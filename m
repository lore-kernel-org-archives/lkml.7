Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB22BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C19621916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UndNXci+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfCURSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:18:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45556 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbfCURSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:18:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so4622997pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Bo6Ts3kPT4RmjlVO3KjUyTjhP8WkrwI/aNrar/qliw=;
        b=UndNXci+1z/Eg7Aq+ZV0SQHvpe+4Jhdi7/ROwPgizumfm4yMF33jHRwWBZmema9QlX
         9sr0tOcPYnJWR42rGspd2OFFHvryg7x2ifOIRvecOH/B53DqA1nTQNfUEhdzSqpStSXB
         gGe9QJR3GOl3I/1ee8z/v72+lCdq/Af1L3oQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Bo6Ts3kPT4RmjlVO3KjUyTjhP8WkrwI/aNrar/qliw=;
        b=Wl1mKJOHkmktilTg0aRMBXh44Ogs/GOZmhDGNaxwVNS3qkkBuFXMXFABI3QuoipiLg
         6Z79kKM06zi9jR+FnH/ZCGdi8aFgA6q5yTXSyWtnF+H08plsdbv92Ku7CnHdcuocwKCW
         RZA9T3xQ4HWopQlJng9XdL12SDp+yh3k8Jlxp1lpQ0dWC7KkqeXh4jvtKKqdcdVOeL07
         nZrmQM/o1P7AMZ/Lou47oCT3MUnX7KTwI7LqEfRX5lxw52bYdW97cG9Jhll/RaloGNqy
         T8i6CXPD1Mj4jpiCgb6arueR2Iqvutp87JJNfeEqitryM3YUmyfKmvUTGvROWJHfhtfC
         xBow==
X-Gm-Message-State: APjAAAXcghis0r/m/AQRiOxZs5Qmsdm58jW9wkOLtv1q5PsrPIm8g3Ov
        RGuCs9sdstw8XWv7X8yVWDL1Zg==
X-Google-Smtp-Source: APXvYqxXR8o25+joEz8dWnEvGQtXoSvqHBfBQrELC7mD18i66AQbkc7ukB5DWxdVHkw2m6ZrP3zj7A==
X-Received: by 2002:a17:902:d894:: with SMTP id b20mr4696828plz.318.1553188699978;
        Thu, 21 Mar 2019 10:18:19 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id z6sm20953866pgo.31.2019.03.21.10.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Mar 2019 10:18:19 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 3/8] dt-bindings: phy: qcom-ufs: Add resets property
Date:   Thu, 21 Mar 2019 10:17:55 -0700
Message-Id: <20190321171800.104681-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321171800.104681-1-evgreen@chromium.org>
References: <20190321171800.104681-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a resets property to the PHY that represents the PHY reset
register in the UFS controller itself. This better describes the
complete specification of the PHY, and allows the PHY to perform
its initialization in a single function, rather than relying on
back-channel sequencing of initialization through the PHY framework.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
- Added resets to example (Stephen).

 Documentation/devicetree/bindings/ufs/ufs-qcom.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
index 21d9a93db2e9..fd59f93e9556 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
+++ b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
@@ -29,6 +29,7 @@ Optional properties:
 - vdda-pll-max-microamp : specifies max. load that can be drawn from pll supply
 - vddp-ref-clk-supply   : phandle to UFS device ref_clk pad power supply
 - vddp-ref-clk-max-microamp : specifies max. load that can be drawn from this supply
+- resets : specifies the PHY reset in the UFS controller
 
 Example:
 
@@ -51,9 +52,11 @@ Example:
 			<&clock_gcc clk_ufs_phy_ldo>,
 			<&clock_gcc clk_gcc_ufs_tx_cfg_clk>,
 			<&clock_gcc clk_gcc_ufs_rx_cfg_clk>;
+		resets = <&ufshc 0>;
 	};
 
-	ufshc@fc598000 {
+	ufshc: ufshc@fc598000 {
+		#reset-cells = <1>;
 		...
 		phys = <&ufsphy1>;
 		phy-names = "ufsphy";
-- 
2.20.1

