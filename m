Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCD0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7599E2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552894455;
	bh=FJ+NNLjFnzugFk7romguA+ia9d7ikXNhr6qG81zrjHU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BUuE6nC/EHnDhdin7AbdDMm/pcblQDOpXXERAh/8jjkDth5nGHEX+vFBpxzWmHwFu
	 hHXQJLuHyIQbHvGOra2yM0mzTsOKpDdaNblXnL9JKK3wwOQPzh4SF6EZf34dZQ2Kg8
	 YnHpc3aMCG51Bv4rf4zm+zlFl28S/AZ8XLtRaM5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfCRHeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:34:14 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:40872 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbfCRHeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:34:13 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id E6EE25FD14; Mon, 18 Mar 2019 15:34:11 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] nvmem: sunxi_sid: native format and A83T/H5 support
Date:   Mon, 18 Mar 2019 15:33:48 +0800
Message-Id: <20190318073354.12151-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This series converts the sunxi_sid driver to read out data in native
endianness for all Allwinner SoCs. It was already the case for the H3,
which used a different read-out method. The endianness for this hardware
was found to be either native or little endian [1], based on the data
layout for the thermal sensor calibration data stored within. Some SoCs
have either 1 or 3 sensors, and calibration data for each sensor is 2
bytes wide, with data for 2 sensors packed into 1 word.

The first three patches do some clean-up and improvements of the code
overall. The fourth patch converts the driver to reading out data in
native endianness. The fifth adds support for the A83T and H5. These
two were already listed in the device tree bindings. The last patch
adds a device node for it on H3 and H5.

Please have a look.

Regards
ChenYu

[1] https://lkml.org/lkml/2019/2/18/134

Chen-Yu Tsai (6):
  nvmem: sunxi_sid: Read out SID for randomness without looping
  nvmem: sunxi_sid: Optimize register read-out method
  nvmem: sunxi_sid: Dynamically allocate nvmem_config structure
  nvmem: sunxi_sid: Read out data in native format
  nvmem: sunxi_sid: Support SID on A83T and H5
  ARM: dts: sunxi: h3/h5: Add device node for SID

 arch/arm/boot/dts/sun8i-h3.dtsi              |  4 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi           |  5 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi |  4 +
 drivers/nvmem/sunxi_sid.c                    | 98 ++++++++------------
 4 files changed, 52 insertions(+), 59 deletions(-)

-- 
2.20.1

