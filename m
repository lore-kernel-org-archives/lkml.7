Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABA5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF672089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566493985;
	bh=YIshGsicoGE+zJT+JRFCI1Xd0g+0hNcRCeEzpxTP3jI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FyGss5/3Cbkr9uHacJHvPcXTXF0t7BwTq/TYX3xdoNVoK++293OerMRzH5EDd/E4M
	 zUfDMu3WE8tPfiWMKi07Mj+uSp2pgtrZ2q2EtcCOngUrRKRoq44R7PUVhxtsCJ9LGv
	 tlB5xdp5iBRlk3ftL9qHPxcVPRX0j24WcMb9AopQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391019AbfHVRNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731662AbfHVRNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:13:01 -0400
Received: from localhost.localdomain (unknown [171.61.89.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F432089E;
        Thu, 22 Aug 2019 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493980;
        bh=YIshGsicoGE+zJT+JRFCI1Xd0g+0hNcRCeEzpxTP3jI=;
        h=From:To:Cc:Subject:Date:From;
        b=Ik9Xic0MuMKLq4IdBpDfoWf6KbhIOlgxccZ4r4BNw7OzC5hQKk/kiyXHUIseED3SB
         t1/Rc9Y3EqOHgcPJPO2qfYJWdnebT/6Umm/JLO64Dq10y3SoQb6MeO++M5H47baAUv
         xkKpEcjyUUbpsANZjBNT5xNGVrOvsLMGl7ckpmHU=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: sdm845: Add parent clock for rpmhcc
Date:   Thu, 22 Aug 2019 22:41:35 +0530
Message-Id: <20190822171135.26488-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPM clock controller has parent as xo, so specify that in DT node for
rpmhcc

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9be6acb0650e..8a19ed601470 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3028,6 +3028,8 @@
 			rpmhcc: clock-controller {
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
+				clock-names = "xo-board";
+				clocks = <&xo_board>;
 			};
 
 			rpmhpd: power-controller {
-- 
2.20.1

