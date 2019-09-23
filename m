Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A0BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F116D20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dSJI456g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404560AbfIWGhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 02:37:05 -0400
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:13198
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404364AbfIWGhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 02:37:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHNkGn2ekmbP+iFYTsNK0v33WAbQdSesZPNce8dRFWxBhGOv+CDrehkhlGvYgtT1dBNB6MnSuPY2Raf7Q5cAON42SBGd2orDLT01rcZNSoQ6uxsilH7V+lFJaDkT3X1Y3JvHGqc6d/KjHzjrj1VZJH5nKw89GYQoMrrdQu4MNvg9ReQnnrBtMOYqGnVqzy6yW/KYK6/LQYrEF3tD/o9xb4Sn+7yri7s+Fb42xNWh76sZN1a7nFeCCc+sOYBrk17YTNCKoNUoanKcZWIUKJQpZkeOxTl/ciCY9tXJx8WRiC+n+UW9x/sAtgzbzzzg9mi1PG0Vm2JTqvDgtYuRyZaoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOaTc0/DsJh4xGX+RY5yR8/qWYowFcRAW59PEuZT3LA=;
 b=jWt3lNef1dl9JMxeCwBQx7VKUGpSVIdCv6MdxpJnx+tTAYwH1cQ//FpWA5NRDeD4YAd6fBkWyQzwZ1FjNy4VJsNW3wY11da6JehMxyiVouRBLsG18mdUiSo4/rbGtE2zzSu3TpAmikSUYXX8ggYrBXpYfM457inY6MvFGFEQt2flN67CTk2q3QIHRiiPW9IagN5nSNQMPNEmkT0NgdJ2/LtFidCdk3UzKqwhX93p+VQF6xWNKjBlfEqeujXADdE3YUZSBR7ys0apQoWugHJN69oEShCwUOFZfLIWY0pRh7Mub9AkEd28sOkY9emhbV5tDRcZfpDjt43WILHZVAQf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOaTc0/DsJh4xGX+RY5yR8/qWYowFcRAW59PEuZT3LA=;
 b=dSJI456g1Dy+Bxl7Hxu7R4RghYOSwSqyowja/wfr6x6/6c2yehXC+kneGEtyYS5ABCjZUV6zKzGu6Bpw+EahxsWWjYxrioAyfn/QIBkQcQ7q2/zvWeAAC+y0/DzBu3ltBXap4bFJFnKlqAxlLnaPDPJq4kdTgYj56mGDI+/1iCk=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4449.eurprd04.prod.outlook.com (52.135.148.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Mon, 23 Sep 2019 06:37:00 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 06:37:00 +0000
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
Subject: [PATCH V7 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Topic: [PATCH V7 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Index: AQHVcdlNWqhZHpusdUul3c2IEB+mNQ==
Date:   Mon, 23 Sep 2019 06:36:59 +0000
Message-ID: <1569220514-27903-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:203:2e::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffb81f14-61bf-4beb-7842-08d73ff06fe2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4449;
x-ms-traffictypediagnostic: AM0PR04MB4449:|AM0PR04MB4449:
x-ms-exchange-purlcount: 6
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB444965DD0A9B9D3C06A2BD9D88850@AM0PR04MB4449.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(189003)(199004)(2501003)(2201001)(14444005)(305945005)(7736002)(54906003)(66066001)(64756008)(110136005)(66556008)(66476007)(316002)(66446008)(6306002)(71200400001)(6116002)(4326008)(71190400001)(86362001)(256004)(66946007)(6512007)(50226002)(8936002)(99286004)(52116002)(25786009)(6436002)(26005)(3846002)(36756003)(8676002)(2906002)(81166006)(81156014)(186003)(15650500001)(102836004)(44832011)(486006)(966005)(5660300002)(478600001)(6486002)(6506007)(386003)(476003)(2616005)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4449;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r9RtY6yc9tGKMpc0kZJj1iwXG7CzNE/tLzyGmUVZ3mhsCaL1AjjaWQylx9NcCSWflm9qSl5AcWMoIGXpayZAoiqfLsH08jcRIV1BM5fuYkvvI6jFyqnYIuvNWMITUUwlxIUXSfaw5NYHCbWXqg3abU8OEBEzUYd2iUk9zxPTc525AFoEHlMYDQSAOl2ccws82DDU4fd/E5q5sSg/lGUysla9y4qsqFgrCPpZQ8g1d5eYa6WJmFE6ugH4AhTptST5+g6+NHurWbu9RpHfckw8Eij4CtlW/HRQh9YCgLjK/LisyLwpwlNg14EFONl/vYv4Bkq18DM4RmkAMwirap/77Fn7/aEJ+R/xBXPx+ZCSZicBuPJ/lpXkyWbovQ8dkJohAiGefG0/5jmKa0zykoQR53isi4Z8wRYfz6Su6TWnhh8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb81f14-61bf-4beb-7842-08d73ff06fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 06:37:00.1396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6ZIbsqXwm1+0FLQJpU2kADU3IO2BoW7iKHL/FKDKL0dYV1kcdL6JNjAecbPdEaE89xv5GwyrvhD8WoKLcFWtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V7:
Typo fix
#mbox-cells changed to 0
Add a new header file arm-smccc-mbox.h
Use ARM_SMCCC_IS_64

Andre,
  The function_id is still kept in arm_smccc_mbox_cmd, because arm,func-id
property is optional, so clients could pass function_id to mbox driver.

V6:
Switch to per-channel a mbox controller
Drop arm,num-chans, transports, method
Add arm,hvc-mbox compatible
Fix smc/hvc args, drop client id and use correct type.
https://patchwork.kernel.org/cover/11146641/

V5:
yaml fix
https://patchwork.kernel.org/cover/11117741/

V4:
yaml fix for num-chans in patch 1/2.
https://patchwork.kernel.org/cover/11116521/

V3:
Drop interrupt
Introduce transports for mem/reg usage
Add chan-id for mem usage
Convert to yaml format
https://patchwork.kernel.org/cover/11043541/
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

 .../devicetree/bindings/mailbox/arm-smc.yaml       |  95 ++++++++++++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm-smc-mailbox.c                  | 168 +++++++++++++++++=
++++
 4 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
 create mode 100644 drivers/mailbox/arm-smc-mailbox.c

--=20
2.16.4

