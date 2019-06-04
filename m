Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A074DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672A9208CB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690666;
	bh=N+2kvga7VTc3c80VaQtj89ys3WNuX+F4zlPWWA9Cnr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ozuL/WYzsi1y9kT4NebKX+wcanhVcVOBQMKJ847oKTEMmH1B/O+Tr6PGfjnCJ8fIs
	 ZQvnwBIJCW6Fk9uMpfBrQiIvETLS5s8hZdIcDiY9U1ggMCrqXx5FgUhnP78E4sADTa
	 8voSGcBPk6WfwvHGMgmJJyV+Xw9hcrPnyFjyNls8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfFDXYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfFDXYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:24:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3241E208E3;
        Tue,  4 Jun 2019 23:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690660;
        bh=N+2kvga7VTc3c80VaQtj89ys3WNuX+F4zlPWWA9Cnr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=joy3tocyUM6sFwzmGmynm7CCPKToXXx6taZjZp7Q8mrzvivpj/z/iiiF4afUs7eOm
         LeMkwvasNJypiVajaxS2Oa1ZnelpESFT21dKsvAEOddQG84r5bWl946H4imLcvwfuS
         o2ImdO7smwRdmqPgMCIOqGmzlJ8uDWrmZs5EBUos=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>,
        syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 02/24] ALSA: seq: Protect in-kernel ioctl calls with mutex
Date:   Tue,  4 Jun 2019 19:23:53 -0400
Message-Id: <20190604232416.7479-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232416.7479-1-sashal@kernel.org>
References: <20190604232416.7479-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

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
index 3bcd7a2f0394..692631bd4a35 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2348,14 +2348,19 @@ int snd_seq_kernel_client_ctl(int clientid, unsigned int cmd, void *arg)
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

