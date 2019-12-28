Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B07AC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5211220838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK97gams"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfL1UgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:36:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39492 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfL1UgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id y1so22890406lfb.6;
        Sat, 28 Dec 2019 12:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7LzR/G6ZPns28vPu8jb4OygZwCP8nesUzQg+DZPZhFk=;
        b=gK97gamss8sfvBgfLI/kZlS1319vvyiSxhuAaT6vIVwa9nE600UFBNvyVVqCg+UkIY
         D01ajtD0DW0vMlLmSdBFMh6tGVHXa6N8djfHv38618YtH8hqWPi0wxqCStJs2ZcVfcWO
         yj9WbBBWx6nmWdxidvPoKd6xmpo1GNm1h+m4PV2zJfn6Ljkjc+nyqIGCfsm+YuIJdG6O
         fOVc9z7Z0P697TUlR9BJWT+ijhCH5Mr3gIMGKLUc/+JyJzlO+Z2X+li2cT0y/vKGYYyX
         ar17z90VHxX6RMvzd18I2ItULs6FyAGvDEFir4WtRbki8GxHmA5vDejrMu9VosXigX+X
         JyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7LzR/G6ZPns28vPu8jb4OygZwCP8nesUzQg+DZPZhFk=;
        b=jBAFxYtVG+J8kJuILTVwPlkXc9FlQ37L8bfFjrBTcT0BhTS4UasVrmBH/vYn/o92C7
         9FaqVtJ5wGQ3bS1BHdnEjSmYlEG98qlX4YdNjc47lopghzQsMaGju0sETTRGS0sHHOCm
         6X4SsLq0EnAlR41IjM8GWF5lhX8IGL6AStKm9ZU16klzVqiJZ9tNTH3DoIqyJsxz65Xh
         N3aXXnfmbXKsER002C97ZoBRAL4F4UOmwSzRXfoAfkLXo3Hjwx2MwqY699y05QIf+ZjY
         1kNAbuhycvZFByN/LHOPLzyuTUSSoQsa8fb8cjDyRXeAJKiuw36nttcI18dsaDkcFxPK
         5XjQ==
X-Gm-Message-State: APjAAAVwp3ZD8tIDaCejobvCFYPVau6dd1iG2lOmlGKFlGlB7ign9Wdx
        jmA0EYnUgz7FyoOth6ivUlU=
X-Google-Smtp-Source: APXvYqw3f5tmEq9veVPq0FG+d8WzSCwm0qRErDLCUT+Ks2i3qS/IxkeqFjHhWRoPaTR3fGEPeZ2DMw==
X-Received: by 2002:a19:7502:: with SMTP id y2mr32220474lfe.55.1577565370094;
        Sat, 28 Dec 2019 12:36:10 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:36:09 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/16] usb: phy: tegra: Move utmip_pad_count checking under lock
Date:   Sat, 28 Dec 2019 23:33:54 +0300
Message-Id: <20191228203358.23490-13-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228203358.23490-1-digetx@gmail.com>
References: <20191228203358.23490-1-digetx@gmail.com>
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
index f7e7df812f83..72825d207840 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -351,30 +351,31 @@ static int utmip_pad_power_off(struct tegra_usb_phy *phy)
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

