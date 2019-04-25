Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85012C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B04205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFJdW43V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfDYPfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:35:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38225 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfDYPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:34:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so872466wmc.3;
        Thu, 25 Apr 2019 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UB2f9M3oRDKr+4FDcqYbUI2702i3wSnwm+pUVNp/ePs=;
        b=GFJdW43V+EKtC4mFiD2b1f/DMUvj86HpfCjwEJK0lpNHLQqXc7bBuwPIe1CkdOY0Fm
         bqaREf9G118usiD4gq2RGPaM/hq6sCaAqzZPWgIMtx5VgrQDho7QnbSwy9QFVnofTP03
         pE5XySAqbiOJ/33H8ln1n0j3BbIJRPe4b06D6Bj+x/sq/XXFq7g0gwS3r3CCDha+Lj92
         J9oYFEP3kx9AkYinb/r22dx1o9ZyNo7ggl2m/nZ1mCNQpCAHij1Sabh/4+FYSQy8qEYQ
         ZYivdpO263o132tZNMxyW5bS9RreTlhnQ0xf+Lg+7R49heNyY6yRfiIU2B+jXKTgIIs5
         jd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UB2f9M3oRDKr+4FDcqYbUI2702i3wSnwm+pUVNp/ePs=;
        b=sfC7FjJCbPQhPdc+nK9baAxYB323y8h9wHOsfYYJLJbrst2hlLUp0fzM9BcIrEDGg5
         O5Z3jH8RDoS+2/otJc1/ZQG5q4UaSI+zcCML6W7j3386/ci9s1FSjgVHAh90zxJvPRky
         bhVSOSWawqMoKXAuPSWONNOYofkyyjRjzfWVQJ/vOxobCaAcSMXk56xYbPSLQVcmeGX9
         rnUiDu2BlyZUKowamqFPJgwyTVpLD02ehHJj2y3hxAOAsYw4a/8fTuPsofmbSaLjP/Zp
         bNOAdBlcEyW0LPGi+Y+e6XZkkJQAenDsXFEbAdXFmHTSvzYeqrt5n1gLv0bc4Dax3pEb
         dVag==
X-Gm-Message-State: APjAAAU7M//XRRc+tfFyOR3Us8wcwqRabDRONZHtpzl/foWzA47M/saz
        VIpXy6gkb5kcsSALRV4FJKk=
X-Google-Smtp-Source: APXvYqx1qLB4hwqYEvz7YdWnjwqDzJvUsr08O9hbhIchftnOFdhNtXhZ9fY3Y9ejnHpl4SfhVzD3xg==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr3956391wmj.43.1556206489276;
        Thu, 25 Apr 2019 08:34:49 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id g3sm4650223wmf.9.2019.04.25.08.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 08:34:48 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] phy: tegra: xusb: Add Tegra210 PLL power supplies
Date:   Thu, 25 Apr 2019 17:34:44 +0200
Message-Id: <20190425153444.6281-3-thierry.reding@gmail.com>
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

The Tegra210 SoC has four inputs that consume power in order to supply
the PLLs that drive the various USB, PCI and SATA pads.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index 05bee32a3a4d..eb754baa8d71 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -2017,6 +2017,13 @@ static const struct tegra_xusb_padctl_ops tegra210_xusb_padctl_ops = {
 	.hsic_set_idle = tegra210_hsic_set_idle,
 };
 
+static const char * const tegra210_xusb_padctl_supply_names[] = {
+	"avdd-pll-utmip",
+	"avdd-pll-uerefe",
+	"dvdd-pex-pll",
+	"hvdd-pex-pll-e",
+};
+
 const struct tegra_xusb_padctl_soc tegra210_xusb_padctl_soc = {
 	.num_pads = ARRAY_SIZE(tegra210_pads),
 	.pads = tegra210_pads,
@@ -2035,6 +2042,8 @@ const struct tegra_xusb_padctl_soc tegra210_xusb_padctl_soc = {
 		},
 	},
 	.ops = &tegra210_xusb_padctl_ops,
+	.supply_names = tegra210_xusb_padctl_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra210_xusb_padctl_supply_names),
 };
 EXPORT_SYMBOL_GPL(tegra210_xusb_padctl_soc);
 
-- 
2.21.0

