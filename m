Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B05C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A07820748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LDBp0mtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfKRLYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46435 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfKRLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so18980546wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QjvBFt/Ahp0rywmkIDhfkZ7dAuBAKpWua4zqIA54R0=;
        b=LDBp0mtVCFiTs61O5YXJ16LuAAFhH8wtaXvLbhwE4NXoRfaqYEp6FKGVT2vaF949Ky
         RkF8f68GGwII+OoL/pSznEKhBF6DiPtuZO54muk8b2IyFJErJznWjlXSECWho7drDhE7
         vQt3/hSjdU81hFkXQ6y+8FT4sHHg6s+d213/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QjvBFt/Ahp0rywmkIDhfkZ7dAuBAKpWua4zqIA54R0=;
        b=krqIM/Hk97+Zjbr9xJ2LuwqNswRwI92+apfZeaG+nOqJXYbpfftx9hbfjdRXYw/P2f
         HeFlAP3JT+3KzkNDZBsB2ObvQC3QH8yrbmM5F7A42wxHDsDx5J/mFStptXBeZjI19Nvz
         1+fm2P1Gn3ibX14oKJ14Pxtru2rSg3hUUX1HUvWXwAG407y5F3PzKEnsjIBhhM8W75Fg
         V0uabBv5VetN51m5EWNZ0Fkn6EFhUFWPaVRiaWxFA9sRj8W8ASdiLYS2efLDrut54tKI
         sIPMU1V5aQXJdeOMseoG4McbE1KmECbuwQ9vyJa376hV/7F8acbdta7P93wBgS7pupWQ
         clnQ==
X-Gm-Message-State: APjAAAXvDlE/Ll54AyCprm9mQzrwbJ7gEbJ9p+HS28LQG3XmvRcfLbj0
        g7mV9yJI2yB8+B8G1/aQ/y1quA==
X-Google-Smtp-Source: APXvYqxZTtkYTYCWP+uZMSlkmiNhl2EyyuM0sCeafVOHfcCFMl5DEdLbaJ//DePb88UnZySftdivKQ==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr14810311wrn.103.1574076272138;
        Mon, 18 Nov 2019 03:24:32 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:31 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v5 46/48] net/wan/fsl_ucc_hdlc: reject muram offsets above 64K
Date:   Mon, 18 Nov 2019 12:23:22 +0100
Message-Id: <20191118112324.22725-47-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qiang Zhao points out that these offsets get written to 16-bit
registers, and there are some QE platforms with more than 64K
muram. So it is possible that qe_muram_alloc() gives us an allocation
that can't actually be used by the hardware, so detect and reject
that.

Reported-by: Qiang Zhao <qiang.zhao@nxp.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 8d13586bb774..f029eaa7cfc0 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -245,6 +245,11 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 		ret = -ENOMEM;
 		goto free_riptr;
 	}
+	if (riptr != (u16)riptr || tiptr != (u16)tiptr) {
+		dev_err(priv->dev, "MURAM allocation out of addressable range\n");
+		ret = -ENOMEM;
+		goto free_tiptr;
+	}
 
 	/* Set RIPTR, TIPTR */
 	iowrite16be(riptr, &priv->ucc_pram->riptr);
-- 
2.23.0

