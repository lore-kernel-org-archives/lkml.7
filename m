Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1301C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A6F21A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119493;
	bh=wKwjfWM+JCA0f7UO0uWQrgxnwNMKaVWWUO0lVQf5ynI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2v1RVNinOGU7xJIlg7kitlCxK13ghwrithlMsmrcHmi4FkLdoJcxpYlxhuWF+9W+C
	 wwQN5QuZcgs8yIjyU/kARDHkaE324VXxkmUM9I7npn6762f07Qfdv6dM3FyYiWIUN2
	 7/bMEfgsUTS2wWo1Nr7ZldgPBuvvfCa+mzucOoJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389577AbfJCQSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389455AbfJCQSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:18:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 603BC20700;
        Thu,  3 Oct 2019 16:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119482;
        bh=wKwjfWM+JCA0f7UO0uWQrgxnwNMKaVWWUO0lVQf5ynI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neq9XLehacnN/ygJjsjMxzCVLjNlVa0tnw9uVf1NFDGLkfyYLf5DzfT/K1JXw71z0
         tjCvhFpcuk4olWlULfcZXz9Cu9w5xGY++4C3qlSulEQEacUgOw/C49q0dXTJTxdaLa
         dIBs0M/FkIXNNdMR1Ep8828BwduNj4h5vVnX6Q1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan.agner@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 082/211] ARM: dts: imx7-colibri: disable HS400
Date:   Thu,  3 Oct 2019 17:52:28 +0200
Message-Id: <20191003154506.035362103@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

[ Upstream commit a95fbda08ee20cd063ce5826e0df95a2c22ea8c5 ]

Force HS200 by masking bit 63 of the SDHCI capability register.
The i.MX ESDHC driver uses SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400. With
that the stack checks bit 63 to descide whether HS400 is available.
Using sdhci-caps-mask allows to mask bit 63. The stack then selects
HS200 as operating mode.

This prevents rare communication errors with minimal effect on
performance:
	sdhci-esdhc-imx 30b60000.usdhc: warning! HS400 strobe DLL
		status REF not lock!

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7-colibri.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 895fbde4d4333..c1ed83131b495 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -323,6 +323,7 @@
 	vmmc-supply = <&reg_module_3v3>;
 	vqmmc-supply = <&reg_DCDC3>;
 	non-removable;
+	sdhci-caps-mask = <0x80000000 0x0>;
 };
 
 &iomuxc {
-- 
2.20.1



