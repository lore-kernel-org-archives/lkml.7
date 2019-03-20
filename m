Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2350C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAAF2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EjiDe/IT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T7uP6b42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfCTJuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:50:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51186 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbfCTJuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:50:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ADA35614B6; Wed, 20 Mar 2019 09:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075410;
        bh=7aydc5AQ+/xKBttzzkD8dHxaZRt09wA65scQVcjJiQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EjiDe/ITzg9QMhB6oAEtDSpT54Lu41BcXa4l3v58CXDSFVAPWg2trok11ix/p8ugL
         8iGp58DPFdPsfgz0raLnoF0Onhbbo0VykZMGND5YSDZb9NvDXSi+2+/q8XTI6bhTw9
         vOxZWpo+M/va4DNLy71GSY247er5mahp3P6N7w/k=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3D3960F3E;
        Wed, 20 Mar 2019 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075408;
        bh=7aydc5AQ+/xKBttzzkD8dHxaZRt09wA65scQVcjJiQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7uP6b425b7x+UFr96hEXxfUbJryY+3nlGdqfKci2zT4kiT8dgZ56vk2N3hsZPSIB
         IAMIMsdgVJDZrBWDURpOZb7za6XIEWl3e0KchtlmObcS7auPE2mxFrKv0h1otO2fSf
         uh0wD094d+KqihKc60dJnio8SMgsljY/4ocDa4VA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3D3960F3E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        swboyd@chromium.org, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, dianders@chromium.org, rafael@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC v2 08/11] arm64: dts: sdm845: Add ufs opps and power-domains
Date:   Wed, 20 Mar 2019 15:19:15 +0530
Message-Id: <20190320094918.20234-9-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320094918.20234-1-rnayak@codeaurora.org>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the additional power domain and the OPP table for ufs on sdm845
so the driver can set the appropriate performance state of the
power domain while setting the clock rate.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 027ffe6e93e8..a3af4a1757b4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1140,6 +1140,21 @@
 			};
 		};
 
+		ufs_opp_table: ufs-opp-table {
+			compatible = "operating-points-v2";
+
+			opp-50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+				required-opps = <&rpmhpd_opp_min_svs>;
+			};
+
+			opp-200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+				required-opps = <&rpmhpd_opp_nom>;
+
+			};
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
@@ -1148,7 +1163,7 @@
 			phys = <&ufs_mem_phy_lanes>;
 			phy-names = "ufsphy";
 			lanes-per-direction = <2>;
-			power-domains = <&gcc UFS_PHY_GDSC>;
+			power-domains = <&gcc UFS_PHY_GDSC>, <&rpmhpd SDM845_CX>;
 
 			iommus = <&apps_smmu 0x100 0xf>;
 
@@ -1170,6 +1185,9 @@
 				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
+
+			operating-points-v2 = <&ufs_opp_table>;
+
 			freq-table-hz =
 				<50000000 200000000>,
 				<0 0>,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

