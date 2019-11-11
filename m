Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A43C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB9E21655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498559;
	bh=NRVQEEOYqmHMZ/IprkdRMMJEbAnjRbByMOHCbnyi9T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hcucxH+sVCpyJ7g7ZaFYJAE92ue8WgZPnD4tJ8SLbn6QgP+edgMsF5WRGq+fEtR4m
	 opmHp5Wx6B/lxWzE03KSxqyMWLPV3+JHDCCFrdDmQOkTVThrn4mgWEvbOaWh4e4O6i
	 Mw6WqoZ9qQwD3dthfqet9qtk02QyzHT51F1R0DEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbfKKSz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:55:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfKKSzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:55:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DB9A21655;
        Mon, 11 Nov 2019 18:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498553;
        bh=NRVQEEOYqmHMZ/IprkdRMMJEbAnjRbByMOHCbnyi9T0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNCX2XU/AzN5eU68CMYVRuY07i4WYhYGrBY0dztFxAPhH3AiT82bqaZw1LGL5sTZ3
         dFCPqGB+aPP37q010ZHXzeQ5dvpm5rs2eVB9ngMLmCmggXEWtoJfx0YIZOJVjT48aa
         HKTdARhIoMqp6tNY/AjQYqCKalZeV6D+BJ9ftFhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 113/193] ARC: [plat-hsdk]: Enable on-board SPI NOR flash IC
Date:   Mon, 11 Nov 2019 19:28:15 +0100
Message-Id: <20191111181509.460497844@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

[ Upstream commit 8ca8fa7f22dcb0a3265490a690b0c3e27de681f9 ]

HSDK board has sst26wf016b SPI NOR flash IC installed, enable it.

Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/boot/dts/hsdk.dts      | 8 ++++++++
 arch/arc/configs/hsdk_defconfig | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index bfc7f5f5d6f26..9bea5daadd23f 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -264,6 +264,14 @@
 			clocks = <&input_clk>;
 			cs-gpios = <&creg_gpio 0 GPIO_ACTIVE_LOW>,
 				   <&creg_gpio 1 GPIO_ACTIVE_LOW>;
+
+			spi-flash@0 {
+				compatible = "sst26wf016b", "jedec,spi-nor";
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				spi-max-frequency = <4000000>;
+			};
 		};
 
 		creg_gpio: gpio@14b0 {
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 403125d9c9a34..fe9de80e41ee3 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -31,6 +31,8 @@ CONFIG_INET=y
 CONFIG_DEVTMPFS=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_MTD=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
-- 
2.20.1



