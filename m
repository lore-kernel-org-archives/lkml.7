Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3506CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B9C20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="KHXue2QE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfCFAx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 19:53:57 -0500
Received: from onstation.org ([52.200.56.107]:51264 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbfCFAxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 19:53:53 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 3F2A5627;
        Wed,  6 Mar 2019 00:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1551833632;
        bh=k6N5uo+zpxSWFA7dueCGQxbw4rgZCV4KCHnwfcWTlrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHXue2QEz+SpRSpZgl/not3i4er5XCfEM4ktlWKqQr2lO9t6d29TqAdS9SUiAGHBX
         dHPF+E/R1xpUEBoyisO2Y5mvWE+F0CJLH+ELi8cFeyPGDgIgp3K3t54G8LCdNHcyHr
         7RdyJG/1O2xPS/WI7LdPUOCt92zlLj49haqUH6dU=
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 1/8] ARM: dts: qcom: apq8064: add gpio-ranges
Date:   Tue,  5 Mar 2019 19:53:09 -0500
Message-Id: <20190306005316.12232-2-masneyb@onstation.org>
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
 arch/arm/boot/dts/qcom-apq8064.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index bd6907db615b..8ca89c79bd0e 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -714,6 +714,7 @@
 					interrupt-controller;
 					#interrupt-cells = <2>;
 					gpio-controller;
+					gpio-ranges = <&pm8921_gpio 0 0 44>;
 					#gpio-cells = <2>;
 
 				};
-- 
2.20.1

