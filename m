Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C2FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5F220661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Un3dOhav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfCFRuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:50:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35518 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfCFRui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:50:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id e17so8999478pgd.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=B7EJEtkYgfb94gn0V+wYAWAlkMGaZEXhZikhWNFzx8E=;
        b=Un3dOhavekRu9eIUVknb/DioYxmCK72p6iqV9gkBtLnr9Nt5B2iAJeNWOwUEyKuGEP
         kduL59acYwR+phaDMh3SnngPLH7L/XRJQBWTZPdymDhyXJQYfqNcWNGWnulZKDimDXeK
         cKRW9Ac+lcnzZ7+a1bpKSe9OlYti7bbaw4NWc1ryC8Pdrzp3qNj/gGSZf0fk9Isk8Vlk
         G6PHrSKIN5WLGWxO2p/hpPaCdd79emast888HMebputcrIEpJLFdyBMzZYXR9rVUg0oh
         O5cwpe2dmIpMcDSuA2vT2N52sTb0EbSK4eAn2oQ5IbQ4FvOYM96Xc0QqXr8O1NGetjiT
         7fPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B7EJEtkYgfb94gn0V+wYAWAlkMGaZEXhZikhWNFzx8E=;
        b=d9NCDIvRmZ80HzpNZtwcfKiVLmH5fVk9a/ZRRbiMRBQNsU4f4H4tBwYt3G4RTZa6Zz
         umTZU1PuQ+56USbraDbWTAA/MFZPhTjkW64v8MT8NSoqrDvKF0459BhlXktGMh6QulWl
         KXtEQkUCltwjDUfI6AvaYteBKRVZt8e9F1Yr1b8pJiVl55CZTHxmo757TvfBJmYI2MOu
         nlFmjmTTLllM+REqiScCyp4XwL+b99GXy+hDwUjqa9KL7tjDmOB0BeO6qzfp/IahPTR3
         E7MIsZKBvuLzysymt6z7eEawVgXWkCn0LfPNj5xIruCuRz03KOC/9TzKhW6R+8hcV/k6
         FLrw==
X-Gm-Message-State: APjAAAU63Wnkd54Jgyp9Tlotm4K/8ivGO97b0ADa9B8wHIb4RCfkdDzQ
        TB+wcGw9ZDiVF2theBLSeCYoww==
X-Google-Smtp-Source: APXvYqyMc6oMgJGxVZK+GzQ8iHff2LFWUwsN0S8ksMIBQx3ntYQfk9VFfwHfWhY433btAmxFsPNldQ==
X-Received: by 2002:a62:bd17:: with SMTP id a23mr8253919pff.233.1551894633800;
        Wed, 06 Mar 2019 09:50:33 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q62sm7264437pfi.183.2019.03.06.09.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 09:50:32 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: qcs404: Update memory map to v3
Date:   Wed,  6 Mar 2019 09:51:20 -0800
Message-Id: <20190306175120.22544-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the reserved-memory map to version 3, to adjust to changes in the
remoteprocs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 30 ++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index d6a91c31986a..298a6053c3e0 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -179,8 +179,13 @@
 		#size-cells = <2>;
 		ranges;
 
-		memory@85600000 {
-			reg = <0 0x85600000 0 0x90000>;
+		tz_apps_mem: memory@85900000 {
+			reg = <0 0x85900000 0 0x500000>;
+			no-map;
+		};
+
+		xbl_mem: memory@85e00000 {
+			reg = <0 0x85e00000 0 0x100000>;
 			no-map;
 		};
 
@@ -189,28 +194,33 @@
 			no-map;
 		};
 
-		memory@86100000 {
+		tz_mem: memory@86100000 {
 			reg = <0 0x86100000 0 0x300000>;
 			no-map;
 		};
 
 		wlan_fw_mem: memory@86400000 {
-			reg = <0 0x86400000 0 0x1c00000>;
+			reg = <0 0x86400000 0 0x1100000>;
+			no-map;
+		};
+
+		adsp_fw_mem: memory@87500000 {
+			reg = <0 0x87500000 0 0x1a00000>;
 			no-map;
 		};
 
-		adsp_fw_mem: memory@88000000 {
-			reg = <0 0x88000000 0 0x1a00000>;
+		cdsp_fw_mem: memory@88f00000 {
+			reg = <0 0x88f00000 0 0x600000>;
 			no-map;
 		};
 
-		cdsp_fw_mem: memory@89a00000 {
-			reg = <0 0x89a00000 0 0x600000>;
+		wlan_msa_mem: memory@89500000 {
+			reg = <0 0x89500000 0 0x100000>;
 			no-map;
 		};
 
-		wlan_msa_mem: memory@8a000000 {
-			reg = <0 0x8a000000 0 0x100000>;
+		uefi_mem: memory@9f800000 {
+			reg = <0 0x9f800000 0 0x800000>;
 			no-map;
 		};
 	};
-- 
2.18.0

