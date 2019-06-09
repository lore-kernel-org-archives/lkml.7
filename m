Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008A5C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD1B208E4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB2GcxV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfFIMcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:32:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44834 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfFIMcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:32:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so2554210pll.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jhlTAOCr2cATKgTKP2X5yBcXY2hwT21U0WFbUJTCmU=;
        b=JB2GcxV2vzSPbmqY9uWfp1aXTEqEDjDbpY/zCQGKkn5GUbENacN2fg2ikTk6ew0XEu
         U0DVXGThfew6/PsOa+FD6Sm5EoNVwXpVeyAAsudfmv7VWEXEbLfgyowcB0CVf3cIQkh3
         HCCxFhpQOti0jcW2d5p9A7j6vSMI1XBFUE22CAH5ACC0yN5qvCpr3JNJCzXB4i/qxLdM
         69Gb1loS8eZBUHkPCOKr+91FVUEPepZSZL8vjsQCZ7trX1AbOtZ0R6ggEBdYyJ0gzZA1
         GV7IDHddhjBMf1vOiA1DTOcEXDtEOyzZey88p5eNR6aTy3bCmppHttzDnH+F+3BAucuG
         J1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jhlTAOCr2cATKgTKP2X5yBcXY2hwT21U0WFbUJTCmU=;
        b=K/V7YWFcPMdtdkC9SZav4Y2JMFHTZa/xpPi0LO5pZjyfARNv8IDKQ3gJ8auKvE4NGK
         MYwrlmHf0aBJEMAlk4w+xGVi2beg5kFIBQJwo1Rz64x9AnRLHqajE55IZXQX69T/OOgs
         EbWtVu90F3RUNSXj23kO9Jo0Adk7ohY8go0T4YgReyUbDOrRuqqxNBoRc3oeELdVnBNK
         CAIFWDHJTsxg8CL2F+ig9QUJTlwJooU30fs8g61tJul6Mw/I0M+iv112pyMQk15pPiom
         lr+ZcCKBxjOrAzC7SxAXWe9NrkdPHYBIDbJY+Z/3/+Bh1QbgR55yexV+36FbJhE28MWP
         0jrg==
X-Gm-Message-State: APjAAAVWMqs53hQA5RqcK+McKwR5aSGx1MVOGMB6MTGmlCZBZfOqY0kU
        wtERL1PPnaxf3lVAS929zwNNZmt+
X-Google-Smtp-Source: APXvYqyu77n/9voMKcRA/yiVtVRz2Qmc8st3Lb71fFc8p63vmbIw2ZKk48CF8jSsFfcw9fxtpFqz5g==
X-Received: by 2002:a17:902:760a:: with SMTP id k10mr45126799pll.83.1560083527707;
        Sun, 09 Jun 2019 05:32:07 -0700 (PDT)
Received: from localhost.localdomain ([117.192.26.87])
        by smtp.googlemail.com with ESMTPSA id c142sm10209982pfb.171.2019.06.09.05.32.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 05:32:07 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH v5 3/6] staging: rtl8712: Fixed CamelCase cmdThread rename to cmd_thread
Date:   Sun,  9 Jun 2019 18:01:42 +0530
Message-Id: <cf8b19d6dc86962021d9f7f397729cb6ac6c64f4.1560081972.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1560081971.git.linux.dkm@gmail.com>
References: <cover.1560081971.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CamelCase cmdThread to cmd_thread in struct _adapter in
drv_types.h and in os_intfs.c

This was reported by checkpatch.pl

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h | 2 +-
 drivers/staging/rtl8712/os_intfs.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 9fbd19f03ca9..0c722e9c2410 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -151,7 +151,7 @@ struct _adapter {
 	u32	IsrContent;
 	u8	eeprom_address_size;
 	u8	hw_init_completed;
-	struct task_struct *cmdThread;
+	struct task_struct *cmd_thread;
 	pid_t evtThread;
 	struct task_struct *xmitThread;
 	pid_t recvThread;
diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index c962696c9822..1653b36c4bfd 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -221,9 +221,9 @@ struct net_device *r8712_init_netdev(void)
 
 static u32 start_drv_threads(struct _adapter *padapter)
 {
-	padapter->cmdThread = kthread_run(r8712_cmd_thread, padapter, "%s",
+	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s",
 					  padapter->pnetdev->name);
-	if (IS_ERR(padapter->cmdThread))
+	if (IS_ERR(padapter->cmd_thread))
 		return _FAIL;
 	return _SUCCESS;
 }
@@ -235,7 +235,7 @@ void r8712_stop_drv_threads(struct _adapter *padapter)
 
 	/*Below is to terminate r8712_cmd_thread & event_thread...*/
 	complete(&padapter->cmdpriv.cmd_queue_comp);
-	if (padapter->cmdThread)
+	if (padapter->cmd_thread)
 		wait_for_completion_interruptible(completion);
 	padapter->cmdpriv.cmd_seq = 1;
 }
-- 
2.19.1

