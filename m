Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649A2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3317220675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="CD+80r5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfCFAyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 19:54:09 -0500
Received: from onstation.org ([52.200.56.107]:51302 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbfCFAxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 19:53:55 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 0B7969BA;
        Wed,  6 Mar 2019 00:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1551833634;
        bh=Crz4LwIzyGwXc5YA9R7vJxkIPPGLLwFFuwHWnLgByO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CD+80r5Zc4+vNAxuKAzoNWx4K0HZTQSfy49IU1ehqxX/WJ2G9Y6UbPVXewXkWRGjR
         wMX5rH/C8lgHV8OOIp5gN5uSXQesl/0be9XoY6OhTeEFWBAHBw1+KuCqrKccELkrNZ
         VJrSKsQagvbE3Iw0LMYRdkM5ZW2C1PjGitlGXA9Q=
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 6/8] arm64: dts: qcom: pm8998: add gpio-ranges
Date:   Tue,  5 Mar 2019 19:53:14 -0500
Message-Id: <20190306005316.12232-7-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306005316.12232-1-masneyb@onstation.org>
References: <20190306005316.12232-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the gpio-ranges property so that the GPIO pins are initialized
by the GPIO framework and not pinctrl. This fixes a circular dependency
between these two frameworks so GPIO hogging can be used on this board.

This was not tested on this particular hardware, however this same
change was tested on qcom-pm8941 using a LG Nexus 5 (hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 43cb5ea14089..4872f116758d 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -93,6 +93,7 @@
 			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
+			gpio-ranges = <&pm8998_gpio 0 0 26>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-- 
2.20.1

