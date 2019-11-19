Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4ADC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EA920672
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143639;
	bh=ITiLQa7PhFYebKtxc6Fl3GvTzg0Y6H8CyAE5H5v51fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SZi7vcnwjhetyu0oPGH7mKP2u8MtpncnZdUDZDiDFckshQFrITMA1IFaCK+vWyS1Z
	 FhQLCoKrz7ESkF08RBOxuxUVwdNIWgxy5HlZ3y4PXMJp2sxENVW/924mmHMcYz4f2h
	 fdC1owV3spJCVgh+lk04u4bWtRKVq+m2XHiI1EAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfKSFdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729526AbfKSFdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:33:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CFF221823;
        Tue, 19 Nov 2019 05:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141604;
        bh=ITiLQa7PhFYebKtxc6Fl3GvTzg0Y6H8CyAE5H5v51fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJtCI1ij6uWRskH8nMZ157rYNUL1TqqaEvd4WvZ6IFFN02u4SDmrFeKjuuMHjtZ+M
         K2/HbSlKQ3ZoO3ffWb0VvPjDVuuIoWFkITL357Kq1/SK4m7wRwngw+gQZjUCOwEAoY
         QCivxQA02qV1NjYKzmYDlX3aui3+SSSla3C2D01o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 216/422] ARM: dts: sun9i: Fix I2C bus warnings
Date:   Tue, 19 Nov 2019 06:16:53 +0100
Message-Id: <20191119051412.605588409@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 57a83c5222c1b5e7b3acc72c6e60fce00a38991a ]

dtc has new checks for I2C buses. The sun9i-a80 dts file has a node named
'i2c' which causes a false positive warning. As the node is a RSB bus,
correct the node name to be 'rsb' to fix the warnings.

arch/arm/boot/dts/sun9i-a80-cubieboard4.dtb: Warning (i2c_bus_reg): /soc/i2c@8003400/codec@e89:reg: I2C address must be less than 10-bits, got "0xe89"
arch/arm/boot/dts/sun9i-a80-cubieboard4.dtb: Warning (i2c_bus_reg): /soc/i2c@8003400/pmic@745:reg: I2C address must be less than 10-bits, got "0x745"
arch/arm/boot/dts/sun9i-a80-optimus.dtb: Warning (i2c_bus_reg): /soc/i2c@8003400/codec@e89:reg: I2C address must be less than 10-bits, got "0xe89"
arch/arm/boot/dts/sun9i-a80-optimus.dtb: Warning (i2c_bus_reg): /soc/i2c@8003400/pmic@745:reg: I2C address must be less than 10-bits, got "0x745"

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 25591d6883ef2..d9532fb1ef650 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -1196,7 +1196,7 @@
 			};
 		};
 
-		r_rsb: i2c@8003400 {
+		r_rsb: rsb@8003400 {
 			compatible = "allwinner,sun8i-a23-rsb";
 			reg = <0x08003400 0x400>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.20.1



