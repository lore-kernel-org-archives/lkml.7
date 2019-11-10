Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BCEC17446
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2112077C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPPNGAmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKJVzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:55:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35506 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfKJVzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:55:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so11334455wmo.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FKrKmpotdr1GXEPFKM1fxXS7Q49nQ4Bb9ulqRuSNZ9Q=;
        b=JPPNGAmTgdGTrbu4DOIEu5Lht4Qs6UQiJMnqyRYM0FgdII38VS1+Xr0pwldQk/WQJa
         b4bDNIvMmB9aKh8yHN1Idp02tyai2L+O+CRd7sezGQlyF09R5qQhhOucBm2WPPDeKqyB
         Z1lWqkD4Gq20g+vkGTZZxkTUJGXHd7SNMzhtFpMzkWaykgizZB4B79vhVvoIQToVpcBB
         hCvW3NZobvZbqFVkZf3j3dlRt9dXCAmoMMUvMNvljP/8IC1u/fEnzZxgD/HvQxLKXPvA
         OPrxGifmAhVZcOCjRWcMhHJp9/s4BKGNzi6MSxOoK2It4+AZPqiPTGtgQwRNH96phN3t
         2q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FKrKmpotdr1GXEPFKM1fxXS7Q49nQ4Bb9ulqRuSNZ9Q=;
        b=qpLRFTYIWhpqw1zQ0qIABPAR4y9yuGgdX4l45BpsM7LUdeX0tCqudAzZq+lstgpOea
         JpmPx8+kHh8b1Z3gLhPkAde5K9D4vYnKkQZt3l0uBaINpLeN6gMISTnDXKxR0qyRMt4h
         Hrshn+eL5DYUyw6CdzJC9x8iE1y6jjjy+dD/l1ibylPKjtjzyVpwBGAaBlKOnl+0qjR5
         lzc3KynfMbIyYOlyVRh56t0gY4QpJxWxuQRuSM03srevVjBlTdiNI5ecqETTkVZNAwr1
         c6193r35JD2AJoWKQvp5V/ELr2a305x8qHbSQd6PSE/Ql52Ioqt0rhjc0fpowtZDh6Rs
         M70A==
X-Gm-Message-State: APjAAAWm63N99dvIjg+VW9rsWMbv8WZs9Gu+CdgHsCMHzK/bzK3pKszZ
        cHQsQhzHlUb4/nRu3YlWaZn0wD2F3jE=
X-Google-Smtp-Source: APXvYqxqaIPz/c0agR6qoIjzEeKIOWYMiQ3ZcayKGjPrcITEp1TB7Ke3TCFMttJDeEvxgDoWDE6vEg==
X-Received: by 2002:a1c:560b:: with SMTP id k11mr19312606wmb.153.1573422941429;
        Sun, 10 Nov 2019 13:55:41 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id d11sm14555824wrn.28.2019.11.10.13.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 13:55:40 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 6/6] habanalabs: export uapi defines to user-space
Date:   Sun, 10 Nov 2019 23:55:33 +0200
Message-Id: <20191110215533.754-6-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191110215533.754-1-oded.gabbay@gmail.com>
References: <20191110215533.754-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two defines that control the maximum size of a command buffer and the
maximum number of JOBS per CS need to be exported to the user as they are
part of the API towards user-space.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h |  4 ----
 include/uapi/misc/habanalabs.h       | 16 ++++++++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 0813041f669a..2a5344cc1a60 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -40,8 +40,6 @@
 
 #define HL_MAX_QUEUES			128
 
-#define HL_MAX_JOBS_PER_CS		512
-
 /* MUST BE POWER OF 2 and larger than 1 */
 #define HL_MAX_PENDING_CS		64
 
@@ -242,8 +240,6 @@ struct hl_dma_fence {
  * Command Buffers
  */
 
-#define HL_MAX_CB_SIZE		0x200000	/* 2MB */
-
 /**
  * struct hl_cb_mgr - describes a Command Buffer Manager.
  * @cb_lock: protects cb_handles.
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index e387d9e560b3..716e70750f23 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -192,13 +192,15 @@ struct hl_info_args {
 /* Opcode to destroy previously created command buffer */
 #define HL_CB_OP_DESTROY	1
 
+#define HL_MAX_CB_SIZE		0x200000	/* 2MB */
+
 struct hl_cb_in {
 	/* Handle of CB or 0 if we want to create one */
 	__u64 cb_handle;
 	/* HL_CB_OP_* */
 	__u32 op;
-	/* Size of CB. Maximum size is 2MB. The minimum size that will be
-	 * allocated, regardless of this parameter's value, is PAGE_SIZE
+	/* Size of CB. Maximum size is HL_MAX_CB_SIZE. The minimum size that
+	 * will be allocated, regardless of this parameter's value, is PAGE_SIZE
 	 */
 	__u32 cb_size;
 	/* Context ID - Currently not in use */
@@ -244,6 +246,8 @@ struct hl_cs_chunk {
 
 #define HL_CS_STATUS_SUCCESS		0
 
+#define HL_MAX_JOBS_PER_CS		512
+
 struct hl_cs_in {
 	/* this holds address of array of hl_cs_chunk for restore phase */
 	__u64 chunks_restore;
@@ -253,9 +257,13 @@ struct hl_cs_in {
 	 * Currently not in use
 	 */
 	__u64 chunks_store;
-	/* Number of chunks in restore phase array */
+	/* Number of chunks in restore phase array. Maximum number is
+	 * HL_MAX_JOBS_PER_CS
+	 */
 	__u32 num_chunks_restore;
-	/* Number of chunks in execution array */
+	/* Number of chunks in execution array. Maximum number is
+	 * HL_MAX_JOBS_PER_CS
+	 */
 	__u32 num_chunks_execute;
 	/* Number of chunks in restore phase array - Currently not in use */
 	__u32 num_chunks_store;
-- 
2.17.1

