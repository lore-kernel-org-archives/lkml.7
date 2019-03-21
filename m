Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3385F21916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kr1Bi0yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbfCURSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:18:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42705 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbfCURSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:18:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so4705445pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5VTcVo1Chs4XGa35tec1xGg2FL/05IcVUKqdSKt+U9Q=;
        b=Kr1Bi0ytzlIExrHApFqy1i2jPUQf5/OokIJmBfy88t6HmBn28AzgN6842rJUZ2wmQx
         LCQ0JbLwZpGjnZIYqJaa2e5V2i/f+jtne9UBW62i8YsOzXXWUy91ZxTlU4Em4XNQ2krG
         Z3n2muBhDqKmlKuIu8zh5BF2z13WJk+9N3Zek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5VTcVo1Chs4XGa35tec1xGg2FL/05IcVUKqdSKt+U9Q=;
        b=CHWrIpibWyLcv1nry1lQ2mjqT4p8jS9xB4tuFuGvdUvPwROKzoUez4MZkz+AJfUtER
         D5SE5AmURJt9PQKG4OuyNes/2JosUDi4Ddljdb6nQBfuLiqLrqfnHt9WAqTtHfoXCt8T
         GED7zaWXrnVxPgUijCXDe1xXNmfcxFqhgEABs77kNoe2F2+XZJiLOiD7gFwUT+ntha7N
         sUFjvNgOe/ET3bB29dkUYNTQ6b2OBQ+Cv8/Tof7+XQeaHwCs+pwPAH+h5Zr7u58flI9j
         T2RapFE8eldDCM++uGHrO3TOa4xmzO6GA732BcmFSLytrnD6NY31NEyFxP2GKSsMViGl
         Tn6Q==
X-Gm-Message-State: APjAAAVQIziLOtXg31n9mzDvWIM79BLvo1r0XJZYzGiI0OAyi1f98YlD
        dqvXRGHek5DPpQrv30ifIKEbzQ==
X-Google-Smtp-Source: APXvYqwVkUQOfEPbsJoytpmNSpCN+m2u6x55lnqBlfVlHlhBkUsE+bGCQubPjDMcBfyYPanRj2vq8A==
X-Received: by 2002:a62:a219:: with SMTP id m25mr4396024pff.197.1553188697650;
        Thu, 21 Mar 2019 10:18:17 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id z6sm20953866pgo.31.2019.03.21.10.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Mar 2019 10:18:17 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 2/8] dt-bindings: phy-qcom-qmp: Add UFS PHY reset
Date:   Thu, 21 Mar 2019 10:17:54 -0700
Message-Id: <20190321171800.104681-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321171800.104681-1-evgreen@chromium.org>
References: <20190321171800.104681-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a required reset to the SDM845 UFS phy to express the PHY reset
bit inside the UFS controller register space. Before this change, this
reset was not expressed in the DT, and the driver utilized two different
callbacks (phy_init and phy_poweron) to implement a two-phase
initialization procedure that involved deasserting this reset between
init and poweron. This abused the two callbacks and diluted their
purpose.

That scheme does not work as regulators cannot be turned off in
phy_poweroff because they were turned on in init, rather than poweron.
The net result is that regulators are left on in suspend that shouldn't
be.

This new scheme gives the UFS reset to the PHY, so that it can fully
initialize itself in a single callback. We can then turn regulators on
during poweron and off during poweroff.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 5d181fc3cc18..4a78ba8b85bc 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -59,7 +59,8 @@ Required properties:
 	   one for each entry in reset-names.
  - reset-names: "phy" for reset of phy block,
 		"common" for phy common block reset,
-		"cfg" for phy's ahb cfg block reset.
+		"cfg" for phy's ahb cfg block reset,
+		"ufsphy" for the PHY reset in the UFS controller.
 
 		For "qcom,ipq8074-qmp-pcie-phy" must contain:
 			"phy", "common".
@@ -74,7 +75,8 @@ Required properties:
 			"phy", "common".
 		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
 			"phy", "common".
-		For "qcom,sdm845-qmp-ufs-phy": no resets are listed.
+		For "qcom,sdm845-qmp-ufs-phy": must contain:
+			"ufsphy".
 
  - vdda-phy-supply: Phandle to a regulator supply to PHY core block.
  - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
-- 
2.20.1

