Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE22C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1635C2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfH30NeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbfB1Ir3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:47:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33051 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731482AbfB1Iqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id c13so6112625wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=i2Rpy2qhhIs2pl96aVxYOiZYK6NcvnT2eL5VcxqJFAM=;
        b=SfH30NeDDim8cpiIODY8NTR2TgB01QnZXveLTBMs8acCmstjoX4JmVWluJjRsj7gf2
         npZZ14tG8JpCLz4YhzhC+GYLm+80J8WMxOacewBvtM0WuDGJzZI+05gy99gD9LvFggMn
         E3Sh7hon6lRlmyH8FQLJyU9dLLDYPnTh5MEELXLJQo3QZJHDsJMLI1u2mrxz8E8wAYK8
         QX0D1KklrsRps2X42eW/omr3f1NUHbV9OUncmvSORO/jUiXUOXKJqqTIACEU+q2RqQox
         lXV2EAvDAjMzTSNCTHr0x5B/pL89rVQYtDUPT3Tog9RGVtpfk/tvaob6nFqiEf078YNo
         mUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=i2Rpy2qhhIs2pl96aVxYOiZYK6NcvnT2eL5VcxqJFAM=;
        b=gkECTGz9B8itjdBnwWL/pWS3h/RYyMexEVok1ByJyHt63WX1wONVi+3cjWSSkljFNV
         83L3fESWHL5VVPiQHrZbjBqHGof6QaA8peuvd4sWZWRapt5Q0Ko6pOpZw4fXrAX7XyH9
         tykEBo4MlywHWb4NBzQPtMc/cyUtOmrjIBusV63/JVuFgMrE5G5ixZYsqoqFYPy1Bbvo
         yYppWkOBu1Ps4Tu9XYDTx6dZVfGnRga5adnB52Y4idhvF6ATy10MbReKhoRqmCHhbYWS
         OD6aNgFpgpNiFc4sQna3hzShUkSZAssNDb4PgJKnhu9ACmjJrUoZd8WOFicifWicwt/l
         KAHQ==
X-Gm-Message-State: APjAAAU6zTe8iW8lJFWqsruhvo8ibgwycfJQnzDDYDJKhw0IO9YNEx+f
        pCIpY3HzRk5LUeoexUtzjWU=
X-Google-Smtp-Source: APXvYqwFC53TYDihH2TdwOY8SP8CVe7DSOyRw6y8Fr3rhbsOrtTfWAMf51dhndul+fcp16QbjOV+gw==
X-Received: by 2002:a1c:39d5:: with SMTP id g204mr2164307wma.17.1551343605157;
        Thu, 28 Feb 2019 00:46:45 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:44 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] habanalabs: add comments in uapi/misc/habanalabs.h
Date:   Thu, 28 Feb 2019 10:46:17 +0200
Message-Id: <20190228084624.25288-9-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
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

