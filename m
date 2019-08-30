Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0367C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9BF2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfH3HwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:52:10 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:11873 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfH3HwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:52:08 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Razvan.Stefanescu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Razvan.Stefanescu@microchip.com";
  x-sender="Razvan.Stefanescu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Razvan.Stefanescu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Razvan.Stefanescu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Tk0s43DimFZSh11bE//WzVTzqjY4uSzqQ3VLHFaFEAlUVKsvhJdvwwgxYtdtJPe/xte8KPpCx8
 TQufMN84Toy7SsPd90iBNSCvK9AoJcZxV0t1XLEwTNBIW8M0X8IjsM6uddiRjg7U4EEERhCLeK
 0y9P11KnflqClxvLqyA66L0qNEumhLGUlNvEiOWFaoKAVpejrgBMUHz5o4IjcUk3DalTfoCSd3
 ho6BFqM3E/2eOphB/1mcCihNEXRxQgemsqD8TY2+NB9W5OY2Dh6rBrrkiomKcAZX7etW6kSy1Q
 rhE=
X-IronPort-AV: E=Sophos;i="5.64,446,1559545200"; 
   d="scan'208";a="47133020"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2019 00:52:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 30 Aug 2019 00:52:07 -0700
Received: from rob-ult-m50855.microchip.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 30 Aug 2019 00:52:05 -0700
From:   Razvan Stefanescu <razvan.stefanescu@microchip.com>
To:     Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Razvan Stefanescu" <razvan.stefanescu@microchip.com>
Subject: [PATCH v2 0/2] net: dsa: microchip: add KSZ8563 support
Date:   Fri, 30 Aug 2019 10:52:00 +0300
Message-ID: <20190830075202.20740-1-razvan.stefanescu@microchip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds compatibility string for the KSZ8563 switch.

Razvan Stefanescu (2):
  dt-bindings: net: dsa: document additional Microchip KSZ8563 switch
  net: dsa: microchip: add KSZ8563 compatibility string

 Documentation/devicetree/bindings/net/dsa/ksz.txt | 1 +
 drivers/net/dsa/microchip/ksz9477_spi.c           | 1 +
 2 files changed, 2 insertions(+)

--
Changelog:
v2: drop fix patches

2.20.1

