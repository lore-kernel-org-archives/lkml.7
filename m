Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34D2C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850A820665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442470;
	bh=gwdxi5AAuoYgp387IoGFEKVh/fyMbDmAvT1oM3iYpVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Hw0/ngwNIPO8Fq3hFShKhj9OJqzsJC5eBTUgaX7gGd45J6mltPl4nQ3BbbpYgzVH
	 L/0gwEM/ZB3jft/fKHRAhm0paQ4NFrdYTS4T3KW5N6iWhg6pzgWsEJI0SbE/+tYFv7
	 C2otaDlAvIl3smGGMWSXABYW3JOW0bMZcSv6aemY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391675AbfFMQO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731191AbfFMImZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:42:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A9E32063F;
        Thu, 13 Jun 2019 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415344;
        bh=gwdxi5AAuoYgp387IoGFEKVh/fyMbDmAvT1oM3iYpVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xuCYaYRIFn5Ls3DKSSdtVPltYNnS3UDuk9dgzzCkuTwzwXN0/0msSYL3DzRTjXnN+
         CU/6rrqJmpA3v5JFPYYXEsknsJnIcEruxCB/yMGiXlSRVRl46S6aBDZrrFCw8UBaHM
         seWpWnJnbUGVM6Q1Ps+SSffaMfZzwqA8cogNG+Bs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/118] ALSA: seq: Protect in-kernel ioctl calls with mutex
Date:   Thu, 13 Jun 2019 10:33:49 +0200
Message-Id: <20190613075649.164602254@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit feb689025fbb6f0aa6297d3ddf97de945ea4ad32 ]

ALSA OSS sequencer calls the ioctl function indirectly via
snd_seq_kernel_client_ctl().  While we already applied the protection
against races between the normal ioctls and writes via the client's
ioctl_mutex, this code path was left untouched.  And this seems to be
the cause of still remaining some rare UAF as spontaneously triggered
by syzkaller.

For the sake of robustness, wrap the ioctl_mutex also for the call via
snd_seq_kernel_client_ctl(), too.

Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_clientmgr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index b55cb96d1fed..40ae8f67efde 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2343,14 +2343,19 @@ int snd_seq_kernel_client_ctl(int clientid, unsigned int cmd, void *arg)
 {
 	const struct ioctl_handler *handler;
 	struct snd_seq_client *client;
+	int err;
 
 	client = clientptr(clientid);
 	if (client == NULL)
 		return -ENXIO;
 
 	for (handler = ioctl_handlers; handler->cmd > 0; ++handler) {
-		if (handler->cmd == cmd)
-			return handler->func(client, arg);
+		if (handler->cmd == cmd) {
+			mutex_lock(&client->ioctl_mutex);
+			err = handler->func(client, arg);
+			mutex_unlock(&client->ioctl_mutex);
+			return err;
+		}
 	}
 
 	pr_debug("ALSA: seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\n",
-- 
2.20.1



