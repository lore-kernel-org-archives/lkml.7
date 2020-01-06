Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C758AC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958F3215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdA2yUgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgAFBf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:35:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34470 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbgAFBe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id z22so44495869ljg.1;
        Sun, 05 Jan 2020 17:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBOdi+OKZRFZU4WYLXtV3AOw8+qJl80/HyzpZqYt9wQ=;
        b=LdA2yUgBw+XwewIEmZXjTplQjbHVYwYexhqb2+aPPXi5Lf2HVtsyj5NKf2Xf3JVseD
         vz9BH+JaKGETzIMbzIYgR18TLL5GL/fiBpN/tcgItror7ZQlCKcVlO9KC99silNsQxJT
         tFKdbDPt3xybjAPxOw9fHKB8mLR1f0hLws5NmDlfk4DJ/IBdD/MK1oTwchZhfKkZh4jM
         mzb442V0yuxDuUsZdrzXyjJb7tAkUNC2nr/6GVWasmQPaAhKuBhaoqhkl4mcXZvUnJ8N
         TEZhBOOnqnKTQdBZfaYycu5j4+yu1Vhb0Mw1dUtF2B3rk4Qagr0hdCKPkxoltClhnygw
         dmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBOdi+OKZRFZU4WYLXtV3AOw8+qJl80/HyzpZqYt9wQ=;
        b=HND7NJCHoraQQSGP1gjHBHH3JNCmUyEtS25ePiKvWGLAOSMiEVALFfe2oi/uqWKD5A
         VPFHn1lBUenT1l10DRayFYnrPQzDi8dgdF9bbVHikmFd8NmP6YlzJF9Xl7krY+X3beMP
         qS49+u/hUFhY9rYSAC1HeK1SgOb5nSbi069BGps8yFr9LBhWoDHFuOq0n/iDTgkTzqxL
         GiV0nGhaT4vp9QyMcrFNO84urrT+V1VeWVleJHXPBEMLXANWMnNigNJiScvsTaK4B5H2
         03xQ0+9E9h3pLGrEiHVIvwXilIV4zWGyIGQaUWu+1vB9eEo73c50oBV2e55UXfA77nf4
         DiTw==
X-Gm-Message-State: APjAAAVZYNTk1URQbKJC0NcsGlsaBfC0lK+6Lmylnob8XSpANxMjUAon
        skuALVVSOmwPe6ZZXLg0+A8=
X-Google-Smtp-Source: APXvYqyyhjwg8kpHsnaICuv2fadBZMPDwe4NGNHvRBQiC9YWl4W0NLGRp9laeLFLTQDylXd4CayFuA==
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr58773421ljj.148.1578274494089;
        Sun, 05 Jan 2020 17:34:54 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:53 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/20] usb: phy: tegra: Move utmip_pad_count checking under lock
Date:   Mon,  6 Jan 2020 04:34:11 +0300
Message-Id: <20200106013416.9604-16-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unlikely that two drivers could manage PHY's state simultaneously in
practice, nevertheless the utmip_pad_count checking should be under lock,
for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 90b42e963a1e..1b9667b0aa11 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -348,30 +348,31 @@ static int utmip_pad_power_off(struct tegra_usb_phy *phy)
 	void __iomem *base = phy->pad_regs;
 	unsigned long flags;
 	u32 val;
-	int err;
+	int ret;
+
+	ret = clk_prepare_enable(phy->pad_clk);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&utmip_pad_lock, flags);
 
 	if (!utmip_pad_count) {
 		dev_err(phy->u_phy.dev, "UTMIP pad already powered off\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto ulock;
 	}
 
-	err = clk_prepare_enable(phy->pad_clk);
-	if (err)
-		return err;
-
-	spin_lock_irqsave(&utmip_pad_lock, flags);
-
 	if (--utmip_pad_count == 0) {
 		val = readl_relaxed(base + UTMIP_BIAS_CFG0);
 		val |= UTMIP_OTGPD | UTMIP_BIASPD;
 		writel_relaxed(val, base + UTMIP_BIAS_CFG0);
 	}
-
+ulock:
 	spin_unlock_irqrestore(&utmip_pad_lock, flags);
 
 	clk_disable_unprepare(phy->pad_clk);
 
-	return 0;
+	return ret;
 }
 
 static int utmi_wait_register(void __iomem *reg, u32 mask, u32 result)
-- 
2.24.0

