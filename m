Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF52C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6296821783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120535;
	bh=yrvj6QEZn4hh+hdM5DHS2jBMNmNJqEh3Pa38HQ+S6AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s1uiCysbiLhXM5/3TWl/tLfCFO/yHnFcqfPygS7rWqpM+q9THvZNaQZMHaI6MCoKZ
	 AHoyLYGieupG7VVQUw8Puh5m2FOzrGmyST4nI9mZn5hr1wDrVqvlSLh282L8rtYpyJ
	 224BI2vrzUnEVCndiz2mcoaML0+yT6aAuZcCMFAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404276AbfJCQfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404264AbfJCQfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:35:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 410F52070B;
        Thu,  3 Oct 2019 16:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120529;
        bh=yrvj6QEZn4hh+hdM5DHS2jBMNmNJqEh3Pa38HQ+S6AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhbFgalGOSoQJgrzaOG+CgZv7fMV56/Em5k1XI9tIZpK2B0T6+vFNlkMHz5Q9OK3n
         W2jcZLt2Haqm8GIR9fViuZN4N/mXb3/pYOHc+ayQWIu4JCXXm6nX/VaslQBS0Hnfsn
         RRk0Vr0Ya/hDB9XRtW3yz59FPUIy+gdCobpaYg8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Liang Chen <cl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 5.2 257/313] arm64: dts: rockchip: limit clock rate of MMC controllers for RK3328
Date:   Thu,  3 Oct 2019 17:53:55 +0200
Message-Id: <20191003154558.340959381@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Lin <shawn.lin@rock-chips.com>

commit 03e61929c0d227ed3e1c322fc3804216ea298b7e upstream.

150MHz is a fundamental limitation of RK3328 Soc, w/o this limitation,
eMMC, for instance, will run into 200MHz clock rate in HS200 mode, which
makes the RK3328 boards not always boot properly. By adding it in
rk3328.dtsi would also obviate the worry of missing it when adding new
boards.

Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for RK3328 SoCs")
Cc: stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Liang Chen <cl@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -800,6 +800,7 @@
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
+		max-frequency = <150000000>;
 		status = "disabled";
 	};
 
@@ -811,6 +812,7 @@
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
+		max-frequency = <150000000>;
 		status = "disabled";
 	};
 
@@ -822,6 +824,7 @@
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
+		max-frequency = <150000000>;
 		status = "disabled";
 	};
 


