Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A86C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C88F20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfDAOij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:38:39 -0400
Received: from ns.iliad.fr ([212.27.33.1]:51528 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfDAOij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:38:39 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 5D4C8216C4;
        Mon,  1 Apr 2019 16:38:37 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 46DE32171E;
        Mon,  1 Apr 2019 16:38:37 +0200 (CEST)
Subject: [PATCH v2 1/2] arm64: dts: msm8998: Add UFS phy reset
To:     Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham <kishon@ti.com>
References: <20190326170518.157317-1-evgreen@chromium.org>
 <71cde29a-aa10-0889-9581-8e961670bc45@free.fr>
 <CAE=gft710gv2+k86pwVhucJFxAcN-AUZhGnT9Hm2gLutV+PCpg@mail.gmail.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <57ba143d-eea5-4f8c-10b8-9f45fc9a8001@free.fr>
Date:   Mon, 1 Apr 2019 16:38:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft710gv2+k86pwVhucJFxAcN-AUZhGnT9Hm2gLutV+PCpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Apr  1 16:38:37 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup MSM8998 UFS DT nodes now that Evan's reset series has landed.
https://lore.kernel.org/lkml/20190321171800.104681-1-evgreen@chromium.org/

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 893eeaaaedec..1cffa706c909 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1085,6 +1085,7 @@
 			phy-names = "ufsphy";
 			lanes-per-direction = <2>;
 			power-domains = <&gcc UFS_GDSC>;
+			#reset-cells = <1>;
 
 			clock-names =
 				"core_clk",
@@ -1132,6 +1133,9 @@
 				<&gcc GCC_UFS_CLKREF_CLK>,
 				<&gcc GCC_UFS_PHY_AUX_CLK>;
 
+			reset-names = "ufsphy";
+			resets = <&ufshc 0>;
+
 			ufsphy_lanes: lanes@1da7400 {
 				reg = <0x01da7400 0x128>,
 				      <0x01da7600 0x1fc>,
-- 
2.17.1
