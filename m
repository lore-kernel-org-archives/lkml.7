Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104CFC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EE020657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560807370;
	bh=spFdKtBn734P0rF1qx0cgEPcZGvSaAAFlKMTfzB/c04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eqvu5y7Ow/P0Q/810gukzjuPKbkiEM64rxVngKYPp47MmqE3t1osP2HLXmPy9tqO+
	 gG18QjzZR/3biu/LTAQHQSRTlonFP3xiHnF24poI+u1OmrgYFW/FAOI+vy7rjVk5C3
	 8gOcNwoPLbmFqEN55hSqgAU2g5gSQ/MNGyXdhmWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfFQVgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729462AbfFQVWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:22:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2518208CB;
        Mon, 17 Jun 2019 21:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806525;
        bh=spFdKtBn734P0rF1qx0cgEPcZGvSaAAFlKMTfzB/c04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jq/FYL3+rv4VfHQKi04BTe2gKWUQ7azsMaLUuClocCJyroZZr8Sco2v/R9b4Avmd+
         jmuqoNBNW9r9GLVfxMgAXAhvF1wCt/a+eYvq2IaG/2xJYnlYZzIyBORyve2CORf6+o
         cN0HKZNT1YP2BWkjwzJZ5r5ehSVZvddUDxdfeTPQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+47ded6c0f23016cde310@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 045/115] Revert "ALSA: seq: Protect in-kernel ioctl calls with mutex"
Date:   Mon, 17 Jun 2019 23:09:05 +0200
Message-Id: <20190617210802.581623298@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f0654ba94e33699b295ce4f3dc73094db6209035 ]

This reverts commit feb689025fbb6f0aa6297d3ddf97de945ea4ad32.

The fix attempt was incorrect, leading to the mutex deadlock through
the close of OSS sequencer client.  The proper fix needs more
consideration, so let's revert it now.

Fixes: feb689025fbb ("ALSA: seq: Protect in-kernel ioctl calls with mutex")
Reported-by: syzbot+47ded6c0f23016cde310@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_clientmgr.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 8599f2937ac1..c99e1b77a45b 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2337,19 +2337,14 @@ int snd_seq_kernel_client_ctl(int clientid, unsigned int cmd, void *arg)
 {
 	const struct ioctl_handler *handler;
 	struct snd_seq_client *client;
-	int err;
 
 	client = clientptr(clientid);
 	if (client == NULL)
 		return -ENXIO;
 
 	for (handler = ioctl_handlers; handler->cmd > 0; ++handler) {
-		if (handler->cmd == cmd) {
-			mutex_lock(&client->ioctl_mutex);
-			err = handler->func(client, arg);
-			mutex_unlock(&client->ioctl_mutex);
-			return err;
-		}
+		if (handler->cmd == cmd)
+			return handler->func(client, arg);
 	}
 
 	pr_debug("ALSA: seq unknown ioctl() 0x%x (type='%c', number=0x%02x)\n",
-- 
2.20.1



