Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81248C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556552068D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QtCF582M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfKRLYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38027 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfKRLYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so18995495wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SKjk4xtgUQ/kA6JZGPtMJVtONpNy6V4lFIeGBwHjI8g=;
        b=QtCF582MFVIFUAE0sBGhcnpWjLaKcMJuHBmrKQSENS+VvCOL11gQdMW8atajXJA2em
         kMb/rDoirxRW0vhZP33J+/jeZLSWRclHGRqPwHLuvpPjdAmwLCRTLHjmhdLBSc+TtOWY
         iLVuDZnvsXId6BXLCalrliqwxuijTqlROC53Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SKjk4xtgUQ/kA6JZGPtMJVtONpNy6V4lFIeGBwHjI8g=;
        b=VHb2DFjOSO1jhvrd08OoPcOoc8NTuqVNauVzuWf26X9rXz32t1PWIUHyDSqLGbQrJg
         RCb88IXfsb738mJ9INFCd130m3yJdrWTP3DHUUwB4hTrN1MEoILdPfJnS4EzW9eXsQQX
         XLA5l69XPnQg5v1i2Y6LkfoM5M7gKqLKTYbJJA1EnzlJoRf7rb6NsQbIOphujAdUnNMs
         HfqgHuapbhvE12reQTIoBIVdcrM5NrLOKBaXOpeNeEzywmO6eQilkvkWrNo7v3nYbGn7
         6s5ejE8qb0UOnoUa7Zfid/eYFs38bBRxWljrIuc5kNZac5MS8T1h59T0YesXZRohbUIS
         ST7Q==
X-Gm-Message-State: APjAAAXdzK/Qsq+x8QreYNl7OwIMIsi7gawoDcbLlDXBsX6IGYdU5OwZ
        DjxceYzbsmApJv/11flh1ze7AQ==
X-Google-Smtp-Source: APXvYqzfWvl1cOreV62JRtAha4euFED3eBmtooUgfkfMzTKXNFT+VQz7x317y2h7bdDCVKAQxJWUvQ==
X-Received: by 2002:a5d:4b86:: with SMTP id b6mr22999180wrt.143.1574076270973;
        Mon, 18 Nov 2019 03:24:30 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:30 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v5 45/48] net/wan/fsl_ucc_hdlc: fix reading of __be16 registers
Date:   Mon, 18 Nov 2019 12:23:21 +0100
Message-Id: <20191118112324.22725-46-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When releasing the allocated muram resource, we rely on reading back
the offsets from the riptr/tiptr registers. But those registers are
__be16 (and we indeed write them using iowrite16be), so we can't just
read them back with a normal C dereference.

This is not currently a real problem, since for now the driver is
PPC32-only. But it will soon be allowed to be used on arm and arm64 as
well.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 405b24a5a60d..8d13586bb774 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -732,8 +732,8 @@ static int uhdlc_open(struct net_device *dev)
 
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 {
-	qe_muram_free(priv->ucc_pram->riptr);
-	qe_muram_free(priv->ucc_pram->tiptr);
+	qe_muram_free(ioread16be(&priv->ucc_pram->riptr));
+	qe_muram_free(ioread16be(&priv->ucc_pram->tiptr));
 
 	if (priv->rx_bd_base) {
 		dma_free_coherent(priv->dev,
-- 
2.23.0

