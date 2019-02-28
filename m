Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B6DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D62218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU0Fo8tM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbfB1Jzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:55:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45883 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfB1Jzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:55:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so21173390wrn.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 01:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=5dby7dWRNXrTe8adVYnbWgyEhYb7JWERjbyamo16SDU=;
        b=OU0Fo8tMpufyybRYN8cmgwFC7usggu49V2IatjG9tsoArqEMeYQ8vi7w93FywY2Zkz
         m13WZiqqTiT/1KSccCxjy3L/9/9s7mEMzvURm+AAi/Nv4Tth8NXs/j7jShugxuZT6Unh
         kFwokQ+0j9c7vhaV7JXDsxBRzbuFaXTk8CaIXVZK3jyH3UJAXC+eunbXp3RWQxDahmI7
         Y2nU4JaTuyWiWWwp3Addzw+eGAC5hRXEmRY/McbTX1jTSoFdcT8WuFabCKrTEtEwSQuu
         2BloscWpI1BqW5752pGQg2HYO9epvTwwIOSkuyvYxWQXsQALsDAdKk2JMnPuSaHJVzsu
         D5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=5dby7dWRNXrTe8adVYnbWgyEhYb7JWERjbyamo16SDU=;
        b=ILzNZqFvyJWAShDSEVqWx+tmwluyLmdTCK+FXi1Y5R+Xpe1vWx8pIlCG9iQQX7ed3J
         RY5fFJzlI5hbaniSKKX8+bjWybzb1vX04myYYR66W6fzyBF/QaiXOJk8ueZVGEJ12HIw
         Kd4QTlrEMGKWzTtvro4ChXolPLYzFbGK3aR3k7C121tnyW4CvHaUeHuyqr1FNig9FyCs
         lR+Yzy8iUX4OK1EoAgxYQpAtStV1jmZ88zDCmltDHgmGR/OuNqPZGrxWBMT56U4fmKCi
         zJXSm0UfPogD7To+LE2NVNczN9Pa58fwmBOLZTAGYc2JGf9mGs3tFT2KEadgWuqrjVJe
         houQ==
X-Gm-Message-State: APjAAAU70QuL+wYTwDUNma/ia22ojAonVgkebBGfAEBNKdWj8zO3mE8r
        bQgkcSqjvuVl54se9ac5854XznwE
X-Google-Smtp-Source: APXvYqxQDDKm+Inq1Q9fdUu2jL1KgLQgoPDc+8Bhqy9fcOpCLgE9zZ9h9Awz41pFCPDLkLMlIG8fHw==
X-Received: by 2002:adf:e98c:: with SMTP id h12mr5906530wrm.302.1551347748331;
        Thu, 28 Feb 2019 01:55:48 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id p9sm4420406wmc.14.2019.02.28.01.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 01:55:47 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/15] habanalabs: add comments in uapi/misc/habanalabs.h
Date:   Thu, 28 Feb 2019 11:55:44 +0200
Message-Id: <20190228095545.30842-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comment about minimum and maximum size of command buffer.
Add some text about the expected input of CS IOCTL.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v2:
  - Add changelog in the commit message
 
 include/uapi/misc/habanalabs.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 23d6ad3459cb..7fd6f633534c 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -112,7 +112,9 @@ struct hl_cb_in {
 	__u64 cb_handle;
 	/* HL_CB_OP_* */
 	__u32 op;
-	/* Size of CB. Minimum requested size must be PAGE_SIZE */
+	/* Size of CB. Maximum size is 2MB. The minimum size that will be
+	 * allocated, regardless of this parameter's value, is PAGE_SIZE
+	 */
 	__u32 cb_size;
 	/* Context ID - Currently not in use */
 	__u32 ctx_id;
@@ -364,6 +366,12 @@ union hl_mem_args {
  * internal. The driver will get completion notifications from the device only
  * on JOBS which are enqueued in the external queues.
  *
+ * For jobs on external queues, the user needs to create command buffers
+ * through the CB ioctl and give the CB's handle to the CS ioctl. For jobs on
+ * internal queues, the user needs to prepare a "command buffer" with packets
+ * on either the SRAM or DRAM, and give the device address of that buffer to
+ * the CS ioctl.
+ *
  * This IOCTL is asynchronous in regard to the actual execution of the CS. This
  * means it returns immediately after ALL the JOBS were enqueued on their
  * relevant queues. Therefore, the user mustn't assume the CS has been completed
-- 
2.17.1

