Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D003CC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05E021848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Y7HZPUIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbfISF3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 01:29:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44555 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388120AbfISF3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 01:29:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so1479419pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 22:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7UOcZwhIF06MhGn+HJKXs6pdfSRqhxVhEIb50OgmNOI=;
        b=Y7HZPUIUZqEK4jo+BJve1KpFrqXMnsuT4bQMzaur4NSxYR5oJZEaU/x99ezt/hgzfm
         M8PBWQosHOZYlBM54/Fa5fMIwPZQ7ECsrS5UPQMAhp40MvbZCPvEYUe+LfiUyItaU+O5
         VrurC+B1oAuvwLo1lyOl7ZjDnYwRIKRGoziX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UOcZwhIF06MhGn+HJKXs6pdfSRqhxVhEIb50OgmNOI=;
        b=QWqLSILh/BLuD5uEsTjm6Wl+uocDuKl30dGQRb6nWg70nKxhwi05IUOId1oipCSFkB
         tChOfQuz7nzvEoFWyk6/ihTcf7QS8d+lIiMtmXZP19BniGSfuH6ZSTlmdnDCW0GpTJ1i
         Fb3BZYXP9O5mavsXC4FoR4OLouiIZwPqs0vr82iQKhodJ9lVKwj7Kk/UMnf0M0C+Qi/F
         m3EeG3pPdTr4wHIEZfNQSGyCFMhDjium05Eh59sU3mFRUi9hJyCHRSdOmJa6nnA4lhIv
         cMUOS+f1UTuZXiB7Z+zJSqq8cEhJ4yG67rXW/i5MFxKjbpKJxQQ9XioGZYQsDlDN5FYq
         1qBw==
X-Gm-Message-State: APjAAAV0m8p8+Azc42bFsT68Inm9+C70C8WfgCt5PHYMzLSl5W8fkj06
        nPnQdnvHKdpoXEl/7ItBI/0QRQ==
X-Google-Smtp-Source: APXvYqwhNboYAOFo2Eq0/XPNnZNqgcNjmWaxGA4Hw7IJ25NN0lvkUgCVt3/UnpQ1hpCwXf1Vlu0p/A==
X-Received: by 2002:a62:fb06:: with SMTP id x6mr724333pfm.186.1568870945159;
        Wed, 18 Sep 2019 22:29:05 -0700 (PDT)
Received: from localhost.localdomain ([49.206.200.127])
        by smtp.gmail.com with ESMTPSA id z20sm5051930pjn.12.2019.09.18.22.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 22:29:04 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Levin Du <djw@t-chip.com.cn>,
        Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Da Xue <da@lessconfused.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 5/6] arm64: dts: rockchip: Rename vcc12v_sys into dc_12v for roc-rk3399-pc
Date:   Thu, 19 Sep 2019 10:58:21 +0530
Message-Id: <20190919052822.10403-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190919052822.10403-1-jagan@amarulasolutions.com>
References: <20190919052822.10403-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is always better practice to follow regulator naming conventions
as per the schematics for future references.

This would indeed helpful to review and check the naming convention
directly on schematics, both for the code reviewers and the developers.

So, rename vcc12v_sys into dc_12v as per rk3399 power tree as per
roc-rk3399-pc schematics.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../boot/dts/rockchip/rk3399-libretech-roc-rk3399-pc.dts  | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-libretech-roc-rk3399-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-libretech-roc-rk3399-pc.dts
index e09bcbdd92f5..51242ea5447d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-libretech-roc-rk3399-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-libretech-roc-rk3399-pc.dts
@@ -57,9 +57,9 @@
 	 * should be placed inside mp8859, but not until mp8859 has
 	 * its own dt-binding.
 	 */
-	vcc12v_sys: mp8859-dcdc1 {
+	dc_12v: mp8859-dcdc1 {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc12v_sys";
+		regulator-name = "dc_12v";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <12000000>;
@@ -85,7 +85,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc12v_sys>;
+		vin-supply = <&dc_12v>;
 	};
 
 	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
@@ -118,7 +118,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc12v_sys>;
+		vin-supply = <&dc_12v>;
 	};
 
 	vdd_log: vdd-log {
-- 
2.18.0.321.gffc6fa0e3

