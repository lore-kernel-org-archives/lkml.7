Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06279C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADB92186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HdtpBjlE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ihGOICys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfCTIKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:10:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55650 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfCTIKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:10:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D8E6F60E73; Wed, 20 Mar 2019 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553069407;
        bh=UJuw0x+mxfFgrbXWmVuYHImije1VmtQCQK+4SfW0/O8=;
        h=From:To:Cc:Subject:Date:From;
        b=HdtpBjlELVhvNCluW38WQMIoK0lM4T5ToAlLv1KRDq1sBDq0LXY3Z7GRJdYFZiUB/
         M0kxOtyZjiXWARk7iGwI2A2cr8w/CC8VtoFs6ncJXMxcOhfIkB5jsDZgsK/FzbyH/u
         sPyHdQ7qwouSVooI35SWbqLlzo0zO3sP++XxWdlg=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 597D76087F;
        Wed, 20 Mar 2019 08:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553069405;
        bh=UJuw0x+mxfFgrbXWmVuYHImije1VmtQCQK+4SfW0/O8=;
        h=From:To:Cc:Subject:Date:From;
        b=ihGOICyswTW2wmaaBXKixKEfw5fUkMVyrgJXup+T32cqx9w8bxNTffPu2jirmGeS2
         Mpz8J16bBuC/6ODetocJpf2UeSXPs9uE7yYVK7NZCR26lbVkKreii7cVpJW6CTvFcm
         cdj7w9JbVv3b5n/6qin56vRosHDFi5soXiW18cok=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 597D76087F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] arm64: dts: sdm845: Include rpmpd DT header
Date:   Wed, 20 Mar 2019 13:39:45 +0530
Message-Id: <20190320080945.27203-1-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to fix dependencies with rpmpd DT entries, the header was
dropped and hardcoded values were added for opp-level, during the
previous merge window.
Add the header back in now and remove the hardcodings, effectively
reverting commit '08585d21de9875a6064b350957faa0460a4c69a6: arm64: dts:
sdm845: Fixup dependency on RPMPD includes'

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5308f1671824..e4b69c74fe07 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/clock/qcom,videocc-sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -2098,43 +2099,43 @@
 					compatible = "operating-points-v2";
 
 					rpmhpd_opp_ret: opp1 {
-						opp-level = <16>;
+						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
 					};
 
 					rpmhpd_opp_min_svs: opp2 {
-						opp-level = <48>;
+						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
 					};
 
 					rpmhpd_opp_low_svs: opp3 {
-						opp-level = <64>;
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 					};
 
 					rpmhpd_opp_svs: opp4 {
-						opp-level = <128>;
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
 					};
 
 					rpmhpd_opp_svs_l1: opp5 {
-						opp-level = <192>;
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
 					};
 
 					rpmhpd_opp_nom: opp6 {
-						opp-level = <256>;
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
 					};
 
 					rpmhpd_opp_nom_l1: opp7 {
-						opp-level = <320>;
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
 					};
 
 					rpmhpd_opp_nom_l2: opp8 {
-						opp-level = <336>;
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
 					};
 
 					rpmhpd_opp_turbo: opp9 {
-						opp-level = <384>;
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
 					};
 
 					rpmhpd_opp_turbo_l1: opp10 {
-						opp-level = <416>;
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
 					};
 				};
 			};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

