Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38987C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 23:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC1D20673
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 23:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtU56f+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfGGXEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 19:04:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37851 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfGGXEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 19:04:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so11915207qkl.4;
        Sun, 07 Jul 2019 16:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKbAChrBtpo77ZPmA5a0Czj2yRcAzg1ZW9k7UI3Yc2w=;
        b=NtU56f+rd5tWesyCLzgWBpigTQS79PuxvcBAC5/sb8znPX/RlVW0TE5TKnXe2w+LMf
         FVP8dsG+mSBPlAFO8IPW1hEKb1DehJYF5eIw/YpuRmCzEIbJ01MXfnC1wNwvdLJHIDEG
         h18Ycxc4KmylyOb8/qFfmMumFYET7pev1QlNGttnDf6BKcNFq64qBHjd1YzLGUKmSH7K
         4fvFtTwp/lQssXMk9KmVcnk4RpGDmsPyFgpyIBijH3Lh2SxOAGjMBC7lV3jyT/ETzjWq
         ITwGVmU50vfNyFVzHvrXMddklnSbrKOio4S/VmiIz3vbqrMxjXaqg3SI8dVIRY50ZhVn
         mAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKbAChrBtpo77ZPmA5a0Czj2yRcAzg1ZW9k7UI3Yc2w=;
        b=WjhAdFfSZFYxYdJmrdjy8CYQDh7YcOOQY1GN/dxRoyA/Sd0Hj27/mwAewkiYzutFSL
         A3qBfFIdAzHlj44vg2l5OE58lnyLCPBcCfvhPT23kKfq0xx4MAQ6iTU/312KgwbvGsKe
         7c0FM5wfovQqGM9BPDZFke14xJcdkX7B/tcXPx0nBjuxpaoJCcrPq4zyaCMJvBX1Aggd
         abr56hXISawFJBmY9WxkwzXK9nat4edAV9Ls+I9ASTIX91NTaGaqG5Cm9y91NoRvudrd
         G0Ra3e0cv0X9dbs1Yraeo7nxzQ0dHitDoLLECMrWQKYE0m8f7QOeKW6690eCUhZRli1c
         dNvg==
X-Gm-Message-State: APjAAAXwHM57x+7KBPt7eLszQD8qymAQRV/tTxna3WeJUt+YbGB5Bmoc
        GQ7FX8u3ACAwRND3EIh3bcA=
X-Google-Smtp-Source: APXvYqzaXUH/XnBN83F7kJpTXDTPW1XmTS5QDioiLYs4JQqTXz+s7eh/QjHha0hhcWn2/mGK0O02eg==
X-Received: by 2002:a37:4e92:: with SMTP id c140mr10805411qkb.48.1562540672046;
        Sun, 07 Jul 2019 16:04:32 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id g22sm2788420qtr.95.2019.07.07.16.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 16:04:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ARM: tegra: Fix FLOW_CTLR_HALT register clobbering by tegra_resume()
Date:   Mon,  8 Jul 2019 02:03:57 +0300
Message-Id: <20190707230358.10672-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707230358.10672-1-digetx@gmail.com>
References: <20190707230358.10672-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an unfortunate typo in the code that results in writing to
FLOW_CTLR_HALT instead of FLOW_CTLR_CSR.

Cc: <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index df44828a34d3..53123ae4ac3b 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -44,16 +44,16 @@ ENTRY(tegra_resume)
 	cmp	r6, #TEGRA20
 	beq	1f				@ Yes
 	/* Clear the flow controller flags for this CPU. */
-	cpu_to_csr_reg r1, r0
+	cpu_to_csr_reg r3, r0
 	mov32	r2, TEGRA_FLOW_CTRL_BASE
-	ldr	r1, [r2, r1]
+	ldr	r1, [r2, r3]
 	/* Clear event & intr flag */
 	orr	r1, r1, \
 		#FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
 	movw	r0, #0x3FFD	@ enable, cluster_switch, immed, bitmaps
 				@ & ext flags for CPU power mgnt
 	bic	r1, r1, r0
-	str	r1, [r2]
+	str	r1, [r2, r3]
 1:
 
 	mov32	r9, 0xc09
-- 
2.22.0

