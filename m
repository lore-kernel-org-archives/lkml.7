Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0280CFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5F0222D4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fbtFc25Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbfKHNDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:03:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34253 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbfKHNCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so4431808lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SKjk4xtgUQ/kA6JZGPtMJVtONpNy6V4lFIeGBwHjI8g=;
        b=fbtFc25QQKF1HYy9EJWgNQgGlj4NvVM/SZQzlg+mehsa55gfaar01ZvOzQEFiHiJS8
         NIWL01E4b4KculB+YonomNkzR6/ye1LnowBIkbJ9/0ahn29mzO+PzUdzYz/FKdLUGozG
         3Bl1Mlzo2VusjD/D//znojGiimZguwgG2m4r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SKjk4xtgUQ/kA6JZGPtMJVtONpNy6V4lFIeGBwHjI8g=;
        b=qFcpPCSzJwd4Z2QMlOf6Yr6E8T1qWNFPgY7Vha1w1eedMl1afO2uRWIXtCpjUn4Xy4
         IGWz0jsIvc3UkRzeXWyIGo+Pqc06Blyp/QMr/EhmDcSuFCtPI8zQYSsFfU8hAw/C4HcN
         BJiwG8Q7+LjwVL/rR8sRADGxMAy+leSSeVZdNO7KJs8bvuHBgoY3uaj4118aYx7coe0P
         XirWCRI1mvZo1N0NBV2pWPaYaCRpAzirnDEpTF9Cqzzjlw4E2MddpHd4reXa6lhaWdA5
         /pTE58WkF7KA8K9TnOfo3nUsgeySNcOG7nakJU+iO2+Z5+jQO6XBll1wFQHqGloiiKQV
         RlZQ==
X-Gm-Message-State: APjAAAUNWV+xKNp15Xms5Ywm4iUgyj8O+Ju3q8lHRdte2hzrTZIDd8QH
        xgbpaKC1bJ91WLW2gN6/Gs0DKQ==
X-Google-Smtp-Source: APXvYqwH4Au0vtX7CvDcjAgRV7H9RHuuGAfZs53rG3gF/CjSF6Puxm/KMJghDcukVOdVzQRBjC2v/w==
X-Received: by 2002:a19:f107:: with SMTP id p7mr6505066lfh.91.1573218142811;
        Fri, 08 Nov 2019 05:02:22 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:22 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v4 44/47] net/wan/fsl_ucc_hdlc: fix reading of __be16 registers
Date:   Fri,  8 Nov 2019 14:01:20 +0100
Message-Id: <20191108130123.6839-45-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
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

