Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAE0C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87632084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fr41RTJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfK1O6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:58:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41929 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfK1O6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:58:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id m4so28806262ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LUyJI7Xtt6B49WNUawbgsGkfQ59e//4g+j9sie0K+wA=;
        b=fr41RTJEy5Zr1Mf34JJS2aTc0bRxU1MD9uDHZeMlDw2PpU5RYyFvfn9cfdKFgw7gRi
         2EnpXvd2e2Fbq0fLk6r3nWUB2D3yhONTgOXuQ+LTEUIQ9ozzk2aJcS/eQhTFDmKhAnrJ
         enhP0jBLFcIMlhOAvq1jZL/fyPjFWIASW6ad0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LUyJI7Xtt6B49WNUawbgsGkfQ59e//4g+j9sie0K+wA=;
        b=SHo6dkztTr5y/+99gncc+cwltyZxHXKlY8Zd+lL50lhvamJyOJIUq8RC/9AcKQPrms
         amIbep5Ps4ER4tb6GrNto7+4/X3SBtFLXiltScgGZRItk+VJvc5zJZaLMF77nnWJ0evp
         aZboff6P50deElSG5AdlfX17JxepzHmax7n7yi2MThhlq4mFJ7b08G/ur3D7lxkZ2TpE
         gkIVm6Z1knKBlwKJ4aMK8KNOgiGboziGrtUsrMSXznUhRp7Zzb5VXy7Cv61OUkAsBSLo
         6LJx+heng3qLosz7X2yAbL5nDTGoihHArPuE2OqDE3mTlRHFy3bq4ub+EhfxB9sxHCDz
         ZYDQ==
X-Gm-Message-State: APjAAAVDcogy9tERc95dz1RkWiDmNfHcW5ZEJvI7BoNBINvAP9RZ8lQg
        VIbuI/d7/YpcnmK/yvZztz3yyTj/KKkE+vkB
X-Google-Smtp-Source: APXvYqzvOsid7pV5utL0Oet589uRnpcNr0xR7W0TnHfGMl1kiNe7Uit0KU1mpk3Kb2fnMEJkAeqIoA==
X-Received: by 2002:a2e:b5b8:: with SMTP id f24mr33942968ljn.188.1574953082288;
        Thu, 28 Nov 2019 06:58:02 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:58:01 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v6 44/49] net/wan/fsl_ucc_hdlc: avoid use of IS_ERR_VALUE()
Date:   Thu, 28 Nov 2019 15:55:49 +0100
Message-Id: <20191128145554.1297-45-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
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

Reviewed-by: Timur Tabi <timur@kernel.org>
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

