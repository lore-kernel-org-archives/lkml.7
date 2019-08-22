Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F94C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8254521743
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbfHVTIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:08:04 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:24585 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731946AbfHVTID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:08:03 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Horatiu.Vultur@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Horatiu.Vultur@microchip.com";
  x-sender="Horatiu.Vultur@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Horatiu.Vultur@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Horatiu.Vultur@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 3j/s0R80uTH2/iiwh3/Aq50sL9TGuK21EoqkCrGTKS/2wpZS/H/2ik5hBFQkEdNc+EtUWKH71i
 NWoJQBpa8udfutd8IWtcJOand3f4nWYNMHaptQ9u32IPCEk8qpBO6GNPDdotaKTJ3+hySTT0I/
 Vwhv3U4ao/mslKdtB3id8jFSudKHBHlF/pqphCSoo0YTq2a60mB9C7Ota15PbxwMD86Z2t45Qv
 vt9G/FvKYm3hLpTAn7Be9fXqrq9MRNYm4thJFepCCsOUSacCuwmzfw1r8GB2Os1zXdL8wly1iE
 P6w=
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; 
   d="scan'208";a="46283497"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2019 12:08:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 22 Aug 2019 12:08:00 -0700
Received: from soft-dev3.microsemi.net (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 22 Aug 2019 12:07:58 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <roopa@cumulusnetworks.com>, <nikolay@cumulusnetworks.com>,
        <davem@davemloft.net>, <UNGLinuxDriver@microchip.com>,
        <alexandre.belloni@bootlin.com>, <allan.nielsen@microchip.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bridge@lists.linux-foundation.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 0/3] Add NETIF_F_HW_BRIDGE feature
Date:   Thu, 22 Aug 2019 21:07:27 +0200
Message-ID: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of the SW bridge is setting the interfaces in
promisc mode when they are added to bridge if learning of the frames is
enabled.
In case of Ocelot which has HW capabilities to switch frames, it is not
needed to set the ports in promisc mode because the HW already capable of
doing that. Therefore add NETIF_F_HW_BRIDGE feature to indicate that the
HW has bridge capabilities. Therefore the SW bridge doesn't need to set
the ports in promisc mode to do the switching.
This optimization takes places only if all the interfaces that are part
of the bridge have this flag and have the same network driver.

If the bridge interfaces is added in promisc mode then also the ports part
of the bridge are set in promisc mode.

Horatiu Vultur (3):
  net: Add HW_BRIDGE offload feature
  net: mscc: Use NETIF_F_HW_BRIDGE
  net: mscc: Implement promisc mode.

 drivers/net/ethernet/mscc/ocelot.c | 26 ++++++++++++++++++++++++--
 include/linux/netdev_features.h    |  3 +++
 net/bridge/br_if.c                 | 29 ++++++++++++++++++++++++++++-
 net/core/ethtool.c                 |  1 +
 4 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.7.4

