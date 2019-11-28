Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9F9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3489F21774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Hf/PPnAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfK1O6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:58:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42331 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfK1O6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:58:06 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so20247565lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A61btIRCfGl2K49FU+YApUFpLzedg3OmEOwCORD6qFU=;
        b=Hf/PPnAbgXenT8bkLjfb4K/u1LbHRKbg0TAYF79JBnqjid3M76xfsO2Iqr0VVwnFyD
         rZNl4JtYAtUQD8Zu1LwxcvmtRvoRs1HGQ6aR9a88XKhA2wHLwBiX2tp7T944IhB1pgwY
         FAIkJLiijQAUm9eh3TF6qwqwuxYQZ78WxFPpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A61btIRCfGl2K49FU+YApUFpLzedg3OmEOwCORD6qFU=;
        b=rQ4tfr9UXwVBrEKdWMwb8he3m77FE/EvhMPPlJ9ik1lN1I9PSnYYwIEhAEK4g42AXu
         BLznrTiyxXF1TBFke0wCtFaDWdb5Q3n6ccNi8fAhcAMy9dnxOm2eUbMtbla5JekfBN9T
         qPJ5G8kk1S5l5r6rFL49PHAjjEwqBgJAumRTXn7k68a9l8TJOVlVORvPlArkMdlOEzow
         x2xHwDCrNp/vohIOBj1wvGqf/3elaQDY11RLSc6o3uSBi2DGvh8B6RvoeD5vlfUoFFTc
         1yToE4LNDaCOmsdQTk9v4dUH5KepRIWDsM4Mw0n0oX4y5J6NbNAyGg0cGHtP0Qo0XOWL
         /3DQ==
X-Gm-Message-State: APjAAAXoh6Y7l0Qb0ZLmJQJGxxlaMS6/q6FvexKA2yxddq+jPHfzyGxT
        ukhk80M3DStuc2pQPHUfxdqwXID6htmqwRh4
X-Google-Smtp-Source: APXvYqxhBAd4opJgrPy7P/4weZdPIJVgERAZIrjiD0AKu9eR6iQ1KzTsifkMtoeeLjTOMUJ9elo8CA==
X-Received: by 2002:a19:cc08:: with SMTP id c8mr32134885lfg.124.1574953084507;
        Thu, 28 Nov 2019 06:58:04 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:58:04 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v6 46/49] net/wan/fsl_ucc_hdlc: reject muram offsets above 64K
Date:   Thu, 28 Nov 2019 15:55:51 +0100
Message-Id: <20191128145554.1297-47-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
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
Reviewed-by: Timur Tabi <timur@kernel.org>
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

