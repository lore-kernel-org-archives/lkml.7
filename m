Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFB4C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EE82083D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lJZIlXky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfGOKKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:10:10 -0400
Received: from mail-eopbgr140084.outbound.protection.outlook.com ([40.107.14.84]:55363
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729541AbfGOKKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:10:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QizfqdUWTlFVbkPi4YC6cXBScDE6hbAtonTMz6PsFgxGqC9dH9vwIc9Lf6KdsHVVL1Vf64aPTOlusciyGigCFzhaO5JzDbHtV9icg8/JJgvxxD+cF4F1HoflST8ZL7KWTjtdGmMJ5mFF8sZz0RjWglTAsgvmPTM9mWdVV2cR0em/ANvBgim1ZIj3V7fPiItULtCqM+MPahZKuQ6/aXD4XDqN10HlxADqGVo0i0AEuJKf4svG1r51FciZapyXclMPOU5Hfw+78Meti548Jl6eYQ31Ko/DHFCiVGOBZPclhXTgWRxo3c26fzTE6+UNM4Vi3CnfvCa/4m8SXuq0bWNk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7KECzzuyvjcIXRCXV1nmTw+D+j/QlfhVsSEjV6lGJA=;
 b=g8tJy8Iwj4N9dkXwA7i78igBPGqpbjXULcZgKOedPVYqjX0YKWsUFyJ386uH+qmQxUGPADHWAbSaVG6vFJDY9WejvFmnCEEhxQojg9bF6SB57cPriJqDxCXRxe1IahXditNjm0NxJE45KjSS863Hqxqu3ubGEkw3SR/EIkjYvaFJpu8oXzDruUyWlswpihQIkwghiE+mCbJpw3jKHAdMAenKSJFKxLhbpbNN/yExT9Qh23j/xIGaGqAAQUaCFQUsFtGQuA8arwi25a4zSTfFwvA8O39Dc3Nl9/fjo1JrcAX2ZyeTsZZ1hTUMkWs2wLOoQdNYixrmqPkVjVG/0tCgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7KECzzuyvjcIXRCXV1nmTw+D+j/QlfhVsSEjV6lGJA=;
 b=lJZIlXky83CJIOU5eAy5+mbnPt5YC8RxmEa52oZYGWyzrRFHGBGoP9VEsMr+ibBO9SGPJHza08ZwbVWMTZg9SktMxzx4C/VLl89hvCsS4htkHdmtKGVpLXVZS0Kf+SGNlOwWiL0TX+UZ47JFe6K/Cr4NdvZAAUgMwdkQpeBwBwY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4356.eurprd04.prod.outlook.com (52.134.93.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 10:10:06 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47%5]) with mapi id 15.20.2052.020; Mon, 15 Jul 2019
 10:10:06 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Topic: [PATCH v3 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Index: AQHVOvV5QOhgWrlDMUC6J9nMDn5GdA==
Date:   Mon, 15 Jul 2019 10:10:06 +0000
Message-ID: <1563184103-8493-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:203:2e::36) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f00829b-6c70-4bc9-d54e-08d7090c9c48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4356;
x-ms-traffictypediagnostic: AM0PR04MB4356:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR04MB435699A7A6B4B417FCE4E7D888CF0@AM0PR04MB4356.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(68736007)(2501003)(7736002)(305945005)(110136005)(316002)(99286004)(54906003)(50226002)(8936002)(52116002)(386003)(44832011)(8676002)(186003)(102836004)(2616005)(26005)(14454004)(486006)(66446008)(64756008)(66556008)(66476007)(66946007)(81156014)(81166006)(6306002)(25786009)(2906002)(3846002)(6116002)(2201001)(15650500001)(6486002)(478600001)(86362001)(6436002)(14444005)(966005)(256004)(6506007)(5660300002)(71190400001)(476003)(71200400001)(36756003)(6512007)(53936002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4356;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R/lZlKCHXeVY4dvyZsLM+SKMP9+wuxukCU8v19eYfFc0MIFjaUPWxCZl9kbVfvWVPpj7lU39ZxAgLJVei01hQ/dPgkhbEtoAmS6hxwcMoDjQExXPZ3Pr9mMwMD32k6sCsvDdji1kibLpHTCft4QTSuW2G3R7QD5sQCdPsOamHsAnlSMOqeF/xyNU0nLexnOVEHix63jh8u81JIg5sCZoIUYNUh3dfEuXE0dqokIf7c5CxfiunCTDUaUi93LhQI/ldQKR6ChSqcD1c1nfKN4/oQz+6MwpJdsi5AyicxjwlnLLjNBMAbZKBcZ7AkXtj4boLvvXggrcRxWdWynExc7vgleHuJucsAafUj/c5HDx5hEAjIReII4iaNidqmXwlmQz0aSN/ni9JhVzFUxzbaeZRAQ/1n9FeQ/8tJ8yJv14HpY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f00829b-6c70-4bc9-d54e-08d7090c9c48
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 10:10:06.5089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4356
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
Drop interrupt
Introduce transports for mem/reg usage
Add chan-id for mem usage
Convert to yaml format
=20
V2:
This is a modified version from Andre Przywara's patch series
https://lore.kernel.org/patchwork/cover/812997/.
The modification are mostly:
Introduce arm,num-chans
Introduce arm_smccc_mbox_cmd
txdone_poll and txdone_irq are both set to false
arm,func-ids are kept, but as an optional property.
Rewords SCPI to SCMI, because I am trying SCMI over SMC, not SCPI.
Introduce interrupts notification.

[1] is a draft implementation of i.MX8MM SCMI ATF implementation that
use smc as mailbox, power/clk is included, but only part of clk has been
implemented to work with hardware, power domain only supports get name
for now.

The traditional Linux mailbox mechanism uses some kind of dedicated hardwar=
e
IP to signal a condition to some other processing unit, typically a dedicat=
ed
management processor.
This mailbox feature is used for instance by the SCMI protocol to signal a
request for some action to be taken by the management processor.
However some SoCs does not have a dedicated management core to provide
those services. In order to service TEE and to avoid linux shutdown
power and clock that used by TEE, need let firmware to handle power
and clock, the firmware here is ARM Trusted Firmware that could also
run SCMI service.

The existing SCMI implementation uses a rather flexible shared memory
region to communicate commands and their parameters, it still requires a
mailbox to actually trigger the action.

This patch series provides a Linux mailbox compatible service which uses
smc calls to invoke firmware code, for instance taking care of SCMI request=
s.
The actual requests are still communicated using the standard SCMI way of
shared memory regions, but a dedicated mailbox hardware IP can be replaced =
via
this new driver.

This simple driver uses the architected SMC calling convention to trigger
firmware services, also allows for using "HVC" calls to call into hyperviso=
rs
or firmware layers running in the EL2 exception level.

Patch 1 contains the device tree binding documentation, patch 2 introduces
the actual mailbox driver.

Please note that this driver just provides a generic mailbox mechanism,
It could support synchronous TX/RX, or synchronous TX with asynchronous
RX. And while providing SCMI services was the reason for this exercise,
this driver is in no way bound to this use case, but can be used genericall=
y
where the OS wants to signal a mailbox condition to firmware or a
hypervisor.
Also the driver is in no way meant to replace any existing firmware
interface, but actually to complement existing interfaces.

[1] https://github.com/MrVan/arm-trusted-firmware/tree/scmi

Peng Fan (2):
  dt-bindings: mailbox: add binding doc for the ARM SMC/HVC mailbox
  mailbox: introduce ARM SMC based mailbox

 .../devicetree/bindings/mailbox/arm-smc.yaml       | 124 ++++++++++++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm-smc-mailbox.c                  | 215 +++++++++++++++++=
++++
 4 files changed, 348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
 create mode 100644 drivers/mailbox/arm-smc-mailbox.c

--=20
2.16.4

