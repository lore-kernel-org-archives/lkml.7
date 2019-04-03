Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E3DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F2720882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI19+VCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfDCG5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:57:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40578 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCG5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:57:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so6747136wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7NS0b1KK/UW0YekPs1jqkL2vEXLjFX8tjgclr6ZuSoA=;
        b=DI19+VCMHC0P9XQBJDrbCkoe1Sj0WS056zcggehBRZyy1BOJN2m//iC4T3NsBUq4zR
         mHTMuVEOhyatOaGSOLVo0qK7aN3BSw5aOd+J6/WX2Mg4TLq/QJKsvIDbkwqIXPxgFtSp
         PgmhF1Ind0VdGX5LUn3KnYpnQ0sgFYWPpzv3HAkwQO3dAW/6pY9kAxm94EE2wgnQXddV
         CCjOX7w73ZMM/e1mMkwgSG/ykwrnK5Ck7+/fR8F9BjvOagAV8MvdnKntObGE5n0w3gae
         7yz1Ao+oCm6RNO5/2J7l/lIusaI5Mf8dLst7zChaAbsC/xnN8NKjBYuuCblp+mHs+53e
         BJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7NS0b1KK/UW0YekPs1jqkL2vEXLjFX8tjgclr6ZuSoA=;
        b=Bm1yacsDk7RWFf95BctazH0peVQ/WyyWCJvbAU1/Hj5JdewM5tJYkZeMyfVqE3Df0c
         gxoL8kZJjKWNOQN1BUY+tTUe1YHPwgckBtai++QgRcShVDea9sseSbFblBQ4qTGcuM84
         WfzhTjsKCnw93USHebCea+0g9qjl5ofT5iZxZ0xxvHdLLdgD5N4boGJpIzsJGOrX3TTf
         xf9uEBikspRxF4e4PXhuvpJjQULOGJN/vnuXRGKHwY+kb2w6rIALJ8aez+zqRe4F/acx
         oLotKO8qgu/zS84dTr3kvlu5mMXRWOhOyBcVAY/8qoOgTk8n8Yrmx34/3R/yanLxEvdH
         SBbQ==
X-Gm-Message-State: APjAAAWN02nVrBX1BL/U5MwAFzZiyk0nU7SVi3skBBxCF81WnyNQ7pHJ
        2E8A2bjjp4y+2WJREHPZpWvmHdY3
X-Google-Smtp-Source: APXvYqzbc60Lte8huPcWUYxu7aladvIBn3PuRP6Gz8U4T7rYLOio8L9+wj1cVjNcOW4Xw88LLzq5pw==
X-Received: by 2002:a7b:c14c:: with SMTP id z12mr781986wmi.138.1554274672987;
        Tue, 02 Apr 2019 23:57:52 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id v190sm39059827wme.18.2019.04.02.23.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 23:57:52 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] uapi/habanalabs: fix some comments in uapi file
Date:   Wed,  3 Apr 2019 09:57:50 +0300
Message-Id: <20190403065750.13574-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a better explanation about the sequence number that is
returned per CS. It also fixes the comment about queue numbering rules.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 include/uapi/misc/habanalabs.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 7704fe08c3ad..613d431da783 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -20,8 +20,8 @@
 /*
  * Queue Numbering
  *
- * The external queues (DMA channels + CPU) MUST be before the internal queues
- * and each group (DMA channels + CPU and internal) must be contiguous inside
+ * The external queues (PCI DMA channels) MUST be before the internal queues
+ * and each group (PCI DMA channels and internal) must be contiguous inside
  * itself but there can be a gap between the two groups (although not
  * recommended)
  */
@@ -477,6 +477,12 @@ struct hl_debug_args {
  * Each JOB will be enqueued on a specific queue, according to the user's input.
  * There can be more then one JOB per queue.
  *
+ * The CS IOCTL will receive three sets of JOBS. One set is for "restore" phase,
+ * a second set is for "execution" phase and a third set is for "store" phase.
+ * The JOBS on the "restore" phase are enqueued only after context-switch
+ * (or if its the first CS for this context). The user can also order the
+ * driver to run the "restore" phase explicitly
+ *
  * There are two types of queues - external and internal. External queues
  * are DMA queues which transfer data from/to the Host. All other queues are
  * internal. The driver will get completion notifications from the device only
@@ -493,19 +499,18 @@ struct hl_debug_args {
  * relevant queues. Therefore, the user mustn't assume the CS has been completed
  * or has even started to execute.
  *
- * Upon successful enqueue, the IOCTL returns an opaque handle which the user
+ * Upon successful enqueue, the IOCTL returns a sequence number which the user
  * can use with the "Wait for CS" IOCTL to check whether the handle's CS
  * external JOBS have been completed. Note that if the CS has internal JOBS
  * which can execute AFTER the external JOBS have finished, the driver might
  * report that the CS has finished executing BEFORE the internal JOBS have
  * actually finish executing.
  *
- * The CS IOCTL will receive three sets of JOBS. One set is for "restore" phase,
- * a second set is for "execution" phase and a third set is for "store" phase.
- * The JOBS on the "restore" phase are enqueued only after context-switch
- * (or if its the first CS for this context). The user can also order the
- * driver to run the "restore" phase explicitly
- *
+ * Even though the sequence number increments per CS, the user can NOT
+ * automatically assume that if CS with sequence number N finished, then CS
+ * with sequence number N-1 also finished. The user can make this assumption if
+ * and only if CS N and CS N-1 are exactly the same (same CBs for the same
+ * queues).
  */
 #define HL_IOCTL_CS			\
 		_IOWR('H', 0x03, union hl_cs_args)
-- 
2.17.1

