Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C93C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29AE205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJgkekSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfDYPex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:34:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43630 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfDYPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:34:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id a12so12405wrq.10;
        Thu, 25 Apr 2019 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7pTCVImssNKLhIIh1mDsX/+6gYcG+1Q8Ji1QYfJoQY=;
        b=TJgkekSKieFe3J3hx+IwB3cfYQgjxTLYh1EIzttDLiq0ubDWdDx/gQw7o3ezDB0sCH
         obqL6JQCLc5ykbqy8QLwqbC2p6y3PJW9MvPWSxm0PrSpWiUjkos2UtXlHtPLi1mqjEor
         ejvFQ73eZBwZbGFQEi2zHAJm6PciakBdkRbIQyXsXyHRQ3yHRxg3Zvsd88pTFnf2j0NX
         z7XU8VJotfE3y/t+EZ+tGFI/aJmGWGJr49+j/JTEEvcwN3FsjpOfiA64rCU5nI7ilg6T
         o7dE8JlXvdKCA9qIhWLyfh0Now3VyUFgNbqYoTClhAp7n0+Eig4runb+0YR/2Cieax7A
         vKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7pTCVImssNKLhIIh1mDsX/+6gYcG+1Q8Ji1QYfJoQY=;
        b=Uuh0oOhD3JDGwTkHCyCD7RSXNX0HxCXlBNDaTKJCc7bK2hSGbBfuwS7V5Mau2IuCm+
         X6VPJheRhThn74+qx+/N5LBEyWo48MLxIzUir21kscwduLKyoxDC1IdkS9MXveVRiaSq
         LBZhACGKuwg4VdXyqbXWYGm+rwRNvyvXsEaeoLTKklcpQsEseyctvWEr61K8LnZ5B8nO
         L4yjJZKtxBhU0i3ALovjqngYi25v3DGA3J5Gk4rW20n+g261hxEwd3KNvy5plr/ejqcK
         wcXaQPhi/lT3OavzbtEp5Fn62uJKZsGXRpF2M4LudYe6BNXSYT0PquzMGpjU6EJTi9hu
         sUWQ==
X-Gm-Message-State: APjAAAVApkxaxPtsG1r8pvbUTSfrvGifDuA/lTbxDdidMSCy97OKLMuk
        fZ/SgtwMGdH5hM6zghKJw9I=
X-Google-Smtp-Source: APXvYqzvH5qK+EgQ5hmezW3SImu66M9Ei8lTew/+sjK3f2TlabSrESA8oFqKXvE8XMT60qSadFAEog==
X-Received: by 2002:adf:e811:: with SMTP id o17mr7092123wrm.30.1556206487735;
        Thu, 25 Apr 2019 08:34:47 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id v14sm2914929wra.58.2019.04.25.08.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 08:34:47 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] phy: tegra: xusb: Add Tegra124 PLL power supplies
Date:   Thu, 25 Apr 2019 17:34:43 +0200
Message-Id: <20190425153444.6281-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425153444.6281-1-thierry.reding@gmail.com>
References: <20190425153444.6281-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The Tegra124 SoC has four inputs that consume power in order to supply
the PLLs that drive the various USB, PCI and SATA pads.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra124.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/tegra/xusb-tegra124.c b/drivers/phy/tegra/xusb-tegra124.c
index c45cbedc6634..254592c47b00 100644
--- a/drivers/phy/tegra/xusb-tegra124.c
+++ b/drivers/phy/tegra/xusb-tegra124.c
@@ -1721,6 +1721,13 @@ static const struct tegra_xusb_padctl_ops tegra124_xusb_padctl_ops = {
 	.hsic_set_idle = tegra124_hsic_set_idle,
 };
 
+static const char * const tegra124_xusb_padctl_supply_names[] = {
+	"avdd-pll-utmip",
+	"avdd-pll-erefe",
+	"avdd-pex-pll",
+	"hvdd-pex-pll-e",
+};
+
 const struct tegra_xusb_padctl_soc tegra124_xusb_padctl_soc = {
 	.num_pads = ARRAY_SIZE(tegra124_pads),
 	.pads = tegra124_pads,
@@ -1743,6 +1750,8 @@ const struct tegra_xusb_padctl_soc tegra124_xusb_padctl_soc = {
 		},
 	},
 	.ops = &tegra124_xusb_padctl_ops,
+	.supply_names = tegra124_xusb_padctl_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra124_xusb_padctl_supply_names),
 };
 EXPORT_SYMBOL_GPL(tegra124_xusb_padctl_soc);
 
-- 
2.21.0

