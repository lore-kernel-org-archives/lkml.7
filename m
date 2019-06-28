Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D54FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FE0208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF1JzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:55:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52390 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfF1JzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:55:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hgnaP-00008U-QV; Fri, 28 Jun 2019 09:54:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: seq: fix incorrect order of dest_client/dest_ports arguments
Date:   Fri, 28 Jun 2019 10:54:29 +0100
Message-Id: <20190628095429.13369-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two occurrances of a call to snd_seq_oss_fill_addr where
the dest_client and dest_port arguments are in the wrong order. Fix
this by swapping them around.

Addresses-Coverity: ("Arguments in wrong order")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/core/seq/oss/seq_oss_ioctl.c | 2 +-
 sound/core/seq/oss/seq_oss_rw.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_ioctl.c b/sound/core/seq/oss/seq_oss_ioctl.c
index 96ad01fb668c..ccf682689ec9 100644
--- a/sound/core/seq/oss/seq_oss_ioctl.c
+++ b/sound/core/seq/oss/seq_oss_ioctl.c
@@ -49,7 +49,7 @@ static int snd_seq_oss_oob_user(struct seq_oss_devinfo *dp, void __user *arg)
 	if (copy_from_user(ev, arg, 8))
 		return -EFAULT;
 	memset(&tmpev, 0, sizeof(tmpev));
-	snd_seq_oss_fill_addr(dp, &tmpev, dp->addr.port, dp->addr.client);
+	snd_seq_oss_fill_addr(dp, &tmpev, dp->addr.client, dp->addr.port);
 	tmpev.time.tick = 0;
 	if (! snd_seq_oss_process_event(dp, (union evrec *)ev, &tmpev)) {
 		snd_seq_oss_dispatch(dp, &tmpev, 0, 0);
diff --git a/sound/core/seq/oss/seq_oss_rw.c b/sound/core/seq/oss/seq_oss_rw.c
index 79ef430e56e1..537d5f423e20 100644
--- a/sound/core/seq/oss/seq_oss_rw.c
+++ b/sound/core/seq/oss/seq_oss_rw.c
@@ -161,7 +161,7 @@ insert_queue(struct seq_oss_devinfo *dp, union evrec *rec, struct file *opt)
 	memset(&event, 0, sizeof(event));
 	/* set dummy -- to be sure */
 	event.type = SNDRV_SEQ_EVENT_NOTEOFF;
-	snd_seq_oss_fill_addr(dp, &event, dp->addr.port, dp->addr.client);
+	snd_seq_oss_fill_addr(dp, &event, dp->addr.client, dp->addr.port);
 
 	if (snd_seq_oss_process_event(dp, rec, &event))
 		return 0; /* invalid event - no need to insert queue */
-- 
2.20.1

