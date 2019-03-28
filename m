Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1069220811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="oreXGS08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfC1Fdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 01:33:55 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:38321 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1Fdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 01:33:54 -0400
X-IronPort-AV: E=Sophos;i="5.60,278,1549954800"; 
   d="scan'208";a="28750353"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 27 Mar 2019 22:33:41 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 27 Mar 2019 22:33:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPKjd4QLfXT78XVRdVRXDDENgVG1S+laUVKhnsAvSOM=;
 b=oreXGS08eiG7Cjdh5nGQfnq5vMxoMQOWNQibatowZNnqq0sAMgQyMC7xdb8axKy1IGAttTrGIFUbO87Bb6+mBHRRmpHPkGlfTe0B/Z/OqI0AI4aFXEViPaF6PuTfb+YefabUxOQxiVdoxfnFMaoELFbyRHaVKi6+Dhf4DUNPwho=
Received: from BY5PR11MB4119.namprd11.prod.outlook.com (10.255.162.219) by
 BY5PR11MB4022.namprd11.prod.outlook.com (10.255.161.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Thu, 28 Mar 2019 05:33:37 +0000
Received: from BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::4454:7962:5f5a:72e9]) by BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::4454:7962:5f5a:72e9%2]) with mapi id 15.20.1730.019; Thu, 28 Mar 2019
 05:33:36 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH v2 0/2] net: phy: mscc: Improvements to VSC8514 PHY driver
Thread-Topic: [PATCH v2 0/2] net: phy: mscc: Improvements to VSC8514 PHY
 driver
Thread-Index: AQHU5SfKXdzKSU1S7kq9Ntd7v77abw==
Date:   Thu, 28 Mar 2019 05:33:36 +0000
Message-ID: <20190328053251.9711-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To BY5PR11MB4119.namprd11.prod.outlook.com
 (2603:10b6:a03:18f::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kavyasree.Kotagiri@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [182.72.246.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8f5ae23-3538-4c37-6d98-08d6b33eeccc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BY5PR11MB4022;
x-ms-traffictypediagnostic: BY5PR11MB4022:
x-microsoft-antispam-prvs: <BY5PR11MB40229EDB5F869C0846C1191992590@BY5PR11MB4022.namprd11.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(396003)(136003)(189003)(199004)(43544003)(25786009)(316002)(1076003)(6436002)(52116002)(102836004)(6486002)(97736004)(36756003)(186003)(99286004)(3846002)(54906003)(110136005)(476003)(6116002)(2616005)(5660300002)(4326008)(486006)(106356001)(105586002)(72206003)(8936002)(256004)(2501003)(478600001)(53936002)(14444005)(55236004)(71190400001)(71200400001)(78486014)(50226002)(14454004)(26005)(2906002)(386003)(8676002)(81166006)(7736002)(66066001)(2201001)(81156014)(68736007)(6512007)(86362001)(107886003)(6506007)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4022;H:BY5PR11MB4119.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PzRvuEfJJdJv45wR0gz0hTXLWgh2WvsQp1YIranTWOuiQ6Gi4UBHAUpjRN7GV2DQ6f82vGuzroQs+aF9gRIcSwzK3L13Rl58nbTSBKaG7gf+wQFh/BgJiEDQ+WtghmVWkV1bb7LVnhwA/ouOU1w1o6ESss+ARShn2yDkfw9bct+VSrCb069hsq+hZkbJoJ7jiw60SfPZszYEaJKhNLR05hlE7XKVAMfZ+bRAcVpH9XjZDkwxHXoijEpyNTJB5nW7iqmD0NioEEVrEnIEmtZxzHfV3STPwsVuIpHBuzgR9pfjxdqQPScdx1DP7BVOj0aa4GdjMSRYmZUgM37PBFErcgRm1mnRZLRc8kqVi4tjsgbM38APq7udq6oH+KhqUik0MG7Vvccm3PeWN3xV4UZGRthpktO+1WQ+wZSxEyVJ3h0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f5ae23-3538-4c37-6d98-08d6b33eeccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 05:33:36.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4022
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

    This patch series adds support for VSC8514 in Microsemi driver(mscc.c)
    and removes support from Vitesse driver(vitesse.c).

v2=20
- mscc: Sorted varible declarations in reverse christmas tree order.

v1
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

