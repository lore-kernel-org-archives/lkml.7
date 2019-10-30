Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D052ECA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9007D21906
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="LAjdN+AI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfJ3WnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:43:06 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:57933 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfJ3WnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:43:05 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 81FA222178;
        Wed, 30 Oct 2019 23:43:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
        s=mail2016061301; t=1572475383;
        bh=Ev/ubprJwnpqeqFsz+uRMTbLx49cuK2FjmTFTyw6tCI=;
        h=From:To:Cc:Subject:Date:From;
        b=LAjdN+AIMOBWrn3tGxQMOY6WcCtUoTZ6SQZs8BNBYhhFDsLZKtKvWoO1+q945gyG6
         Dym3IRCuau5g/gmD7x6Zp8m8jNXb1jFpSvNMQJAXHFvsT+/01qSIUsdk971uoQd1Ts
         SR0pnfCWRfCh7aQ/j/EbrYaicgBB4qFDslNx+GMQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Michael Walle <michael@walle.cc>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: [RFC PATCH 0/3] net: phy: at803x device tree binding
Date:   Wed, 30 Oct 2019 23:42:48 +0100
Message-Id: <20191030224251.21578-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.101.4 at web
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a device tree binding to configure the clock and the RGMII voltage.

I do have the following questions:
 - Who should be the maintainer of the atheros,at803x.yaml file?
 - Is the "atheros,rgmii-io-1v8" boolean property ok or should it be a
   "atheros,rgmii-io-microvolt = <1800000>"?
 - There is actually a typo throughout the whole at803x file. The actual
   name of the PHY is "Atheros AR803x". What should be the name of the yaml
   file and the dt-bindings header file? atheros,at803x.yaml or
   atheros,ar803x.yaml. Likewise for the header file.

Michael Walle (3):
  net: phy: at803x: fix Kconfig description
  dt-bindings: net: phy: Add support for AT803X
  net: phy: at803x: add device tree binding

 .../bindings/net/atheros,at803x.yaml          |  58 +++++++
 drivers/net/phy/Kconfig                       |   4 +-
 drivers/net/phy/at803x.c                      | 156 +++++++++++++++++-
 include/dt-bindings/net/atheros-at803x.h      |  13 ++
 4 files changed, 227 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/atheros,at803x.yaml
 create mode 100644 include/dt-bindings/net/atheros-at803x.h

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
-- 
2.20.1

