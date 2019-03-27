Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1D9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735FC2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ct8ztFS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbfC0Jzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:55:42 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33819 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfC0Jzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:55:42 -0400
X-IronPort-AV: E=Sophos;i="5.60,276,1549954800"; 
   d="scan'208";a="30232297"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Mar 2019 02:55:40 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 27 Mar 2019 02:55:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b67hpcswFMXys18GCn52i2GBGGC1EpLfK9Ow/LKWA0=;
 b=ct8ztFS1i3a78G4oCDwSLr9TUyyr3m8tiig7YmwL8AzPNSFTST6x6TqDSjzhp1ZDzyB1JrQHVPuczdwJJxcsa1AmnkdKdwsf6sJmaInAQuvHEIeUHAIFihoQd1oLR80m7fHX2obXgoiuOeLtBcOvqGSXN4U15AdbmYBnlPrFqA8=
Received: from BY5PR11MB4119.namprd11.prod.outlook.com (10.255.162.219) by
 BY5PR11MB4054.namprd11.prod.outlook.com (10.255.162.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Wed, 27 Mar 2019 09:55:38 +0000
Received: from BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::4454:7962:5f5a:72e9]) by BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::4454:7962:5f5a:72e9%2]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 09:55:38 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH v1 0/2] net: phy: mscc: Improvements to VSC8514 PHY driver
Thread-Topic: [PATCH v1 0/2] net: phy: mscc: Improvements to VSC8514 PHY
 driver
Thread-Index: AQHU5IM7lmXAiQHE0k6mqCQ8IQzOxQ==
Date:   Wed, 27 Mar 2019 09:55:38 +0000
Message-ID: <20190327095519.6181-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::14) To BY5PR11MB4119.namprd11.prod.outlook.com
 (2603:10b6:a03:18f::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kavyasree.Kotagiri@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [182.72.246.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6077c87-9924-487f-f729-08d6b29a5d38
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BY5PR11MB4054;
x-ms-traffictypediagnostic: BY5PR11MB4054:
x-microsoft-antispam-prvs: <BY5PR11MB4054449F6A89769D36178BAC92580@BY5PR11MB4054.namprd11.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(43544003)(189003)(66066001)(26005)(6116002)(3846002)(97736004)(72206003)(6486002)(476003)(6506007)(486006)(52116002)(386003)(78486014)(2616005)(6436002)(14454004)(55236004)(6512007)(102836004)(256004)(305945005)(106356001)(2501003)(68736007)(186003)(81156014)(316002)(105586002)(54906003)(81166006)(110136005)(71190400001)(5660300002)(50226002)(8676002)(71200400001)(25786009)(99286004)(107886003)(2201001)(1076003)(86362001)(478600001)(36756003)(7736002)(8936002)(2906002)(4326008)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4054;H:BY5PR11MB4119.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mcx2MAidVwYQBiQMtz7S6GJ9ufAcU646XTIsN74PYNcqR8iLYGTXim1Z64qgFH4DPgT45V7siLukohhLFSQOtt+ZZoa5fFpGA5MTpgmgUgedCXjihAAD+ixEuesLYGxx2aNeDtXhO5ARkTQ0q6kDYTRMTMzPK5lNAD7g58JpSdZK9uRHkORccFJzN5p+VRo7ou4N7s25T95q0Tuqb96Tg/VrYfkD4rCzQY8St12Jn4VfsQr4V2DXdjBOSKjCQ6tRNBYS5Vz9MmVxodi3akVsWv8hMivwRWAzWAxxkWoDu3g+W+tRmSLdhCupe3O95yS5EFXiie1Oqvxc19+GPsFCSMx1uFZFLvodZ5wjVTL2mtk4xE1VEmdO9mI0DBnArdJ9dt3DqV/me7f5wF7ZuAHumiKPhlWU6eOnTMpKdrpxBqM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c6077c87-9924-487f-f729-08d6b29a5d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 09:55:38.6952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4054
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    The VSC8514 PHY is a 4-ports PHY that is 10/100/1000BASE-T, 100BASE-FX,
    1000BASE-X, can communicate with the MAC via QSGMII.
    The MAC interface protocol for each port within QSGMII can
    be either 1000BASE-X or SGMII, if the QSGMII MAC that the VSC8514 is
    connecting to supports this functionality.
    VSC8514 also supports SGMII MAC-side autonegotiation on each individual
    port, downshifting, can set the blinking pattern of each of its 4 LEDs,
    SyncE, 1000BASE-T Ring Resiliency as well as HP Auto-MDIX detection.

    This patch series adds support for 10BASE-T, 100BASE-TX, and 1000BASE-T=
,
    QSGMII link with the MAC, downshifting, HP Auto-MDIX detection
    and blinking pattern for its 4 LEDs.

    The GPIO register bank is a set of registers that are common to all PHY=
s
    in the package. So any modification in any register of this bank affect=
s
    all PHYs of the package.

    If the PHYs haven't been reset before booting the Linux kernel and were
    configured to use interrupts for e.g. link status updates, it is
    required to clear the interrupts mask register of all PHYs before being
    able to use interrupts with any PHY. The first PHY of the package that
    will be init will take care of clearing all PHYs interrupts mask
    registers. Thus, we need to keep track of the init sequence in the
    package, if it's already been done or if it's to be done.

    Most of the init sequence of a PHY of the package is common to all PHYs
    in the package, thus we use the SMI broadcast feature which enables us
    to propagate a write in one register of one PHY to all PHYs in the same
    package.

    This patch series adds support for VSC8514 in Microsemi driver(mscc.c)=
=20
    and removes support from Vitesse driver(vitesse.c).

v1=20
- Added 0/2 file.

Kavya Sree (2):
  net: phy: mscc: add support for VSC8514 PHY
  net: phy: vitesse: Remove support for VSC8514

 drivers/net/phy/Kconfig   |   2 +-
 drivers/net/phy/mscc.c    | 381 ++++++++++++++++++++++++++++++++++++++
 drivers/net/phy/vitesse.c |  12 --
 3 files changed, 382 insertions(+), 13 deletions(-)

--=20
2.17.1

