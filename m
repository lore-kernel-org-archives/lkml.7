Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0D7C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7A821771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="PondpcWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfK1O6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:58:45 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37489 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfK1O6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:58:06 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so20265003lfp.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=byxQuHw6IVmwv5QbVm5twa+er8x0Qu7qmmS64lJfOnw=;
        b=PondpcWeSDGdnmJ3H3VheUMZ5EamRr1/9yXbPe7FnTxs0EB3gX3rAmq3N+xxQXg1zC
         8n9IySGiwvx4CXJ87vaurWMM04a78FAMf2Sv1PDfAzRwEzyV7rH4OyqjmmxRqM28QIEv
         FB3fNi1x+H8+Cb63fYmgSdnsF52YRLDjjuMIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=byxQuHw6IVmwv5QbVm5twa+er8x0Qu7qmmS64lJfOnw=;
        b=pmCGRm13OsEou2g8TuTjuKG94n6UNYcTYVuDuZ0OpWDXSEGzBs6q5HhAY2baxZeqY4
         Rq2QrE1b3j/KQ+AvKDUW6bI3tvLM4slNCkA8gMKf2WRBBqqXAwdcgTLOMnqkdlPOvEl5
         fWPPDtl/J0w3IqYDB6a2ojXvYHV+Iv3blv0R1p3wNz7wFSnzDHbkYRd45uM90zF12mYp
         RI4+o4v26Gaff69BDN1j5Ic2DB8zCgjcn7i5ax5QtCtHnJjgjQxRmPV64jdthmkLgANT
         QistkK+NduTA/up1fUfM7/8bpGyRZzfXRzCcmo0is8nY8Ewf15/kWTH7Z7CLmSG9jfeY
         jM+w==
X-Gm-Message-State: APjAAAUfu5ZWnsDSRZu6UCb4Bo2lCC4pSWrKryiityV70YJXbae6/jb9
        8b5eY1tVcBUoCU86O6Q8EgVqmQ==
X-Google-Smtp-Source: APXvYqyFtd33g1Hp4cvK1H6BPWnHJDxlirit0nsDRKrmBSAkYuEyCJVhYftiyBHH6/qxlZfMH1fiXA==
X-Received: by 2002:a19:e011:: with SMTP id x17mr8564756lfg.59.1574953083383;
        Thu, 28 Nov 2019 06:58:03 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:58:03 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v6 45/49] net/wan/fsl_ucc_hdlc: fix reading of __be16 registers
Date:   Thu, 28 Nov 2019 15:55:50 +0100
Message-Id: <20191128145554.1297-46-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
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

Reviewed-by: Timur Tabi <timur@kernel.org>
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

