Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD13C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B0B214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="YKdpMlKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfJJT0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 15:26:14 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:51024 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfJJT0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wJEqH4NrrjSb9vl8KVNZW+HaMMj7tZUwG3p49NSaKKg=; b=YKdpMlKc8u3Gja5oVaR6Zuf3uN
        yEFIG2abAmtmQ1KNg3+tm95tqvam2VOFhTpEVnt+ite45WWUAyBjQobGhGeT0oY+FhK3Y+NdaLzxC
        tPCkU+H5Q5Aod1Zc3NYF8xRTLmsnB6iqHk5gCEAC2etdvsySswxAwOW2BLyOy9+/EV88=;
Received: from p200300ccff13bb001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff13:bb00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iIe4Z-0007Jj-Ci; Thu, 10 Oct 2019 21:26:03 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1iIe4Y-0007GV-M4; Thu, 10 Oct 2019 21:26:02 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, marex@denx.de, angus@akkea.ca,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/3] dts: ARM: add Kobo Clara HD eBook reader
Date:   Thu, 10 Oct 2019 21:23:54 +0200
Message-Id: <20191010192357.27884-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a device tree for the Kobo Clara HD eBook reader.
Name on mainboard is: 37NB-E60K00+4A4
Serials start with: E60K02 (a number also seen in
vendor kernel sources)
These boards are also found in the Tolino Shine 3 reader
but equipped with a i.MX6SL processor. Support for that
device is planned to be added in a later patch series.
To prepare for that the device tree is split up into
a board file containing SoC-independent stuff and a
file containing the SoC-dependent stuff.

Work is based on code from the vendor kernel at
https://github.com/kobolabs/Kobo-Reader/blob/master/hw/imx6sll-clara/kernel.tar.bz2
but things need to be heavily reworked due to
incompatible bindings and to prepare for Tolino Shine 3

Changes in v2:
- reordered patches
- various cleanups as suggested by Marco Felsch

Changes in v3:
- correct memory size
- better name for led
- comments about missing i2c devices

Andreas Kemnade (3):
  dt-bindings: arm: fsl: add compatible string for Kobo Clara HD
  ARM: dts: add Netronix E60K02 board common file
  ARM: dts: imx: add devicetree for Kobo Clara HD

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/e60k02.dtsi                 | 337 ++++++++++++++++++
 arch/arm/boot/dts/imx6sll-kobo-clarahd.dts    | 279 +++++++++++++++
 4 files changed, 619 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/e60k02.dtsi
 create mode 100644 arch/arm/boot/dts/imx6sll-kobo-clarahd.dts

-- 
2.20.1

