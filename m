Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB28CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E90221721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787181;
	bh=Jbnl14VH0GAAeG6oOTitKjeePEn1JZpTLPVkMGnWg1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1DfIitO8jecdQLmAkMHcuvk3WWklJidprr7uK5xaF8+pXdI3C0tiE9n5qD4gR8BcK
	 3Djk4aqbjARaSg95WEcFk+5sp37S4Qcgrjd916HwpARFOeVuFuRp05Sje8GNzJ/5Nb
	 W9e+29VjJKrKoWZJssdxvBYvHySYV6ZpO+vnzbHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfHNMxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:53:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfHNMw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:52:57 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EF502186A;
        Wed, 14 Aug 2019 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787176;
        bh=Jbnl14VH0GAAeG6oOTitKjeePEn1JZpTLPVkMGnWg1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0cwHoORkLit1M9Mkl921zoohMCxy9EcqQBsDglWEC5azHcnengxetDHACLhgCNjU
         wM3Re6l55BpytznqKZRRikQTKaAYlQ/7pkIslpwEXYRNiNuSe5fytcBaLDdE/Q5rQ/
         LzVBfA/VooxWuaUVPll+X2KmM6yD+du8SqZKMUfg=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/22] arm64: dts: qcom: sm8150: Add reserved-memory regions
Date:   Wed, 14 Aug 2019 18:20:08 +0530
Message-Id: <20190814125012.8700-19-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reserved memory regions in SM8150

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 111 +++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 5258b79676f6..7111e1f092f4 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -153,6 +153,117 @@
 		method = "smc";
 	};
 
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hyp_mem: memory@85700000 {
+			reg = <0x0 0x85700000 0x0 0x600000>;
+			no-map;
+		};
+
+		xbl_mem: memory@85d00000 {
+			reg = <0x0 0x85d00000 0x0 0x140000>;
+			no-map;
+		};
+
+		aop_mem: memory@85f00000 {
+			reg = <0x0 0x85f00000 0x0 0x20000>;
+			no-map;
+		};
+
+		aop_cmd_db: memory@85f20000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x0 0x85f20000 0x0 0x20000>;
+			no-map;
+		};
+
+		smem_mem: memory@86000000 {
+			reg = <0x0 0x86000000 0x0 0x200000>;
+			no-map;
+		};
+
+		tz_mem: memory@86200000 {
+			reg = <0x0 0x86200000 0x0 0x3900000>;
+			no-map;
+		};
+
+		rmtfs_mem: memory@89b00000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0x89b00000 0x0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
+		camera_mem: memory@8b700000 {
+			reg = <0x0 0x8b700000 0x0 0x500000>;
+			no-map;
+		};
+
+		wlan_mem: memory@8bc00000 {
+			reg = <0x0 0x8bc00000 0x0 0x180000>;
+			no-map;
+		};
+
+		npu_mem: memory@8bd80000 {
+			reg = <0x0 0x8bd80000 0x0 0x80000>;
+			no-map;
+		};
+
+		adsp_mem: memory@8be00000 {
+			reg = <0x0 0x8be00000 0x0 0x1a00000>;
+			no-map;
+		};
+
+		mpss_mem: memory@8d800000 {
+			reg = <0x0 0x8d800000 0x0 0x9600000>;
+			no-map;
+		};
+
+		venus_mem: memory@96e00000 {
+			reg = <0x0 0x96e00000 0x0 0x500000>;
+			no-map;
+		};
+
+		slpi_mem: memory@97300000 {
+			reg = <0x0 0x97300000 0x0 0x1400000>;
+			no-map;
+		};
+
+		ipa_fw_mem: memory@98700000 {
+			reg = <0x0 0x98700000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: memory@98710000 {
+			reg = <0x0 0x98710000 0x0 0x5000>;
+			no-map;
+		};
+
+		gpu_mem: memory@98715000 {
+			reg = <0x0 0x98715000 0x0 0x2000>;
+			no-map;
+		};
+
+		spss_mem: memory@98800000 {
+			reg = <0x0 0x98800000 0x0 0x100000>;
+			no-map;
+		};
+
+		cdsp_mem: memory@98900000 {
+			reg = <0x0 0x98900000 0x0 0x1400000>;
+			no-map;
+		};
+
+		qseecom_mem: memory@9e400000 {
+			reg = <0 0x9e400000 0 0x1400000>;
+			no-map;
+		};
+	};
+
 	soc: soc@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.20.1

