Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A32C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95B82085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="XGWfSCSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbfKHNDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:03:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34249 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbfKHNCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id f5so4431763lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IVdoGLW+H0ZKnJRayTBX6GqWyaD6YHKGaBDMMFO7/WI=;
        b=XGWfSCSUEAVnpUU/P6J3Qpi258NYlF3UJQSunn16SlUdmsp2q+W8Bk2e/nwHBQtUA0
         fTuY1Ravcq9bFl1d3rl/f799vNBuCYFEgPCX2t9OqCPlkEeIvRZyKcQb8orXRDyeqpLG
         r3uSJRO/BS/Xt5o6Y8WDp/Fl9289KO+LrOKYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVdoGLW+H0ZKnJRayTBX6GqWyaD6YHKGaBDMMFO7/WI=;
        b=mz8fjQ1ox9cqNInGo4rdAGIPdkQS94toRhfNh88QgBMSs8locT+E9Iq6VbEoY93HIY
         uIi/yOKCrcpUvFeOvvLFXgCN6SS7K2l63LOkXcwrYA+oIR9LPO/WAij2xroolRO3flof
         73jQROmLOpg671dITd766TvH6BdqExe2tDcPQgKVfKvyM3IgXFiQG9CTdPMb4JOrGvUA
         QD5jzQC5omBfFPLSaltFLfi90laFln14Q/hVcXwZqox/TriRmrT2lXAjPN3zPG0LFVyf
         no18Z/kvQwgcTmx5Gi+fNtuLaGav7Ug0+I+8WyMWKDXBwL68QwgxE0QsPEjAQN755esm
         mW+Q==
X-Gm-Message-State: APjAAAUynwlp7LqZ+2cX9cIDPeL4AAFGXgNR9STRDrr4CMJQboJYc/i1
        FZyCQHYGRxEZQ+Q01LHk+kKnKw==
X-Google-Smtp-Source: APXvYqwfxfaitvaPMgKPzDm4mZzVxujIi4YRrNIWmv3dBUm4XchC7Z1ld8b5BxN/rmHZMQ6u7CZ4hg==
X-Received: by 2002:a19:148:: with SMTP id 69mr6994219lfb.76.1573218141700;
        Fri, 08 Nov 2019 05:02:21 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:21 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v4 43/47] net/wan/fsl_ucc_hdlc: avoid use of IS_ERR_VALUE()
Date:   Fri,  8 Nov 2019 14:01:19 +0100
Message-Id: <20191108130123.6839-44-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building this on a 64-bit platform gcc rightly warns that the
error checking is broken (-ENOMEM stored in an u32 does not compare
greater than (unsigned long)-MAX_ERRNO). Instead, now that
qe_muram_alloc() returns s32, use that type to store the return value
and use standard kernel style "ret < 0".

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 10 +++++-----
 drivers/net/wan/fsl_ucc_hdlc.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index ce6af7d5380f..405b24a5a60d 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -84,8 +84,8 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 	int ret, i;
 	void *bd_buffer;
 	dma_addr_t bd_dma_addr;
-	u32 riptr;
-	u32 tiptr;
+	s32 riptr;
+	s32 tiptr;
 	u32 gumr;
 
 	ut_info = priv->ut_info;
@@ -195,7 +195,7 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 	priv->ucc_pram_offset = qe_muram_alloc(sizeof(struct ucc_hdlc_param),
 				ALIGNMENT_OF_UCC_HDLC_PRAM);
 
-	if (IS_ERR_VALUE(priv->ucc_pram_offset)) {
+	if (priv->ucc_pram_offset < 0) {
 		dev_err(priv->dev, "Can not allocate MURAM for hdlc parameter.\n");
 		ret = -ENOMEM;
 		goto free_tx_bd;
@@ -233,14 +233,14 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 
 	/* Alloc riptr, tiptr */
 	riptr = qe_muram_alloc(32, 32);
-	if (IS_ERR_VALUE(riptr)) {
+	if (riptr < 0) {
 		dev_err(priv->dev, "Cannot allocate MURAM mem for Receive internal temp data pointer\n");
 		ret = -ENOMEM;
 		goto free_tx_skbuff;
 	}
 
 	tiptr = qe_muram_alloc(32, 32);
-	if (IS_ERR_VALUE(tiptr)) {
+	if (tiptr < 0) {
 		dev_err(priv->dev, "Cannot allocate MURAM mem for Transmit internal temp data pointer\n");
 		ret = -ENOMEM;
 		goto free_riptr;
diff --git a/drivers/net/wan/fsl_ucc_hdlc.h b/drivers/net/wan/fsl_ucc_hdlc.h
index 8b3507ae1781..71d5ad0a7b98 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.h
+++ b/drivers/net/wan/fsl_ucc_hdlc.h
@@ -98,7 +98,7 @@ struct ucc_hdlc_private {
 
 	unsigned short tx_ring_size;
 	unsigned short rx_ring_size;
-	u32 ucc_pram_offset;
+	s32 ucc_pram_offset;
 
 	unsigned short encoding;
 	unsigned short parity;
-- 
2.23.0

