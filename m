Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352C9C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF209214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hsyHzuzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633782AbfIYCJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 22:09:09 -0400
Received: from mail-eopbgr140081.outbound.protection.outlook.com ([40.107.14.81]:39153
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389401AbfIYCJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 22:09:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXaT3d8drmG5EUG2JlDd/HipV7sAYaOAgANzSYW4QxUOl8QdJEell8l2/VbPzjIp8vD/J5zcFJKu/t18RQb3wuV+Z9KOlPZqrUKNQ6ld4h6jjV+4vkYim72IfejGzdqcJ0gJTfXghcWKxzMbOnD4YU1QoUO87HXM4hNqNlUIBd8XJjaK5DUFEBseTNJwAZ6mP00Q+SxwblWbSnGIXZWMT9HEoWc3Gk18rloiW+u7/aCuhAexbRGMWoEn1ZDzbsnovZdFxOsd9VK7do0+c54LQZAKwZVS0End55KI2vLiobPS++FA2YNcF12YtHbbGhYOtewwVTXeSsbWzpEJaWdP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jl2nPB2K53BgB4d/OGg7loTW2jHUGBeb7LcciZEA54=;
 b=O0JIK5hqFBr5wjXUWaUBlpJLlpLCsg7V8xKUGA5XX4Xd4P4YaWRrS7kh46gBVXIrWGV47BpYIWfiZ1uzCopg1jsZABAeZL14W7U2okyE6tCyj69Fgmfl22AfY2Pmz4+Y0RW19G0Q28GWIbGtPxKAznXLCzlYEyhzBdgdqSa/kpMVkUtbLpM/szYtCQeT+K7QQbwXv4qb3rGCfswBQjsjaaqe6gRlmmU7NXH3g7KP/Rid1AYN/AGVMDYlqlAkc3wkgcbY41QxaU2U5bcgquutaov6QE3K2vhkpsQ86izkqO6GHed8HZuzrz6gxdqYyTpu6vCLBwKHs0fkCsmj2eTbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jl2nPB2K53BgB4d/OGg7loTW2jHUGBeb7LcciZEA54=;
 b=hsyHzuzz90jWUi1inBxWuNI/q5PCZu2uvAn91MIcpJlLenNdocgHywbe36Wk88ilUs/jf+146m53NmPqVC+YgpdCGiv1XA6AXVVoRJii3uO46xDsGSvV0ddkV3368/4wpqw5OGUKGd3ieVlSl3NQoOImIEY3E9fHoI58MCCOYjc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4451.eurprd04.prod.outlook.com (52.135.149.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Wed, 25 Sep 2019 02:09:04 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 02:09:04 +0000
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
Subject: [PATCH V9 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Topic: [PATCH V9 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Index: AQHVc0Y0k9JRzjAEaUGpwXgSV3qtEQ==
Date:   Wed, 25 Sep 2019 02:09:04 +0000
Message-ID: <1569377224-5755-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0041.apcprd03.prod.outlook.com
 (2603:1096:203:2f::29) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb77d6f4-8357-4347-1d5f-08d7415d5701
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB4451;
x-ms-traffictypediagnostic: AM0PR04MB4451:|AM0PR04MB4451:
x-ms-exchange-purlcount: 6
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4451C12B10A15F53544C778088870@AM0PR04MB4451.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(189003)(199004)(8676002)(2501003)(66446008)(6116002)(66946007)(6512007)(6306002)(102836004)(6436002)(66476007)(64756008)(26005)(186003)(86362001)(44832011)(386003)(6506007)(54906003)(66556008)(486006)(316002)(8936002)(2616005)(476003)(25786009)(7736002)(256004)(15650500001)(14444005)(305945005)(99286004)(66066001)(14454004)(71200400001)(50226002)(81166006)(81156014)(110136005)(3846002)(478600001)(2906002)(52116002)(966005)(2201001)(36756003)(5660300002)(71190400001)(4326008)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4451;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2n/EmYWMd1Fz4UmkI03/MuYXTF3yqARHgFWgbZCqdTwfquJLOdY6hrCzj6yFOLzpC9Awxo76Q3dIb4+bNk2t10EdAyEtvq0iYhaH28nwkssud8A/T22acIbk7SiRz5BC1iI77lARgY6YqSF2Oezu281VjRBKtI+KRk+nlYnbmXw0Zpk7lmDMYYsOfLW2+4yj5bVOXwNihja92mrM3R5o7jJbdRoQCJwlovp+WLmwwVqH9pBCliU2k+OXLq+uF26//hCLhUcpp23QRdwNb24URDVQ9zsMYXd22SLOtNfKsTlNl8syZ2QacSV7qtrFMN6DPCwdEvdiweuwgr5lOq5pEZT+fz4hqJlyTIoCMWSR3ZNSwBv+DlQkHLDVk2CyYMWWtR3eUsIDQT54O8sFDoKG5mANRU0LWsZHGTaxZhm1R/Cf2ddsNJF8r5yZ524HoBlLPYG/4mcDvetdjLRikBsUpw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb77d6f4-8357-4347-1d5f-08d7415d5701
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 02:09:04.5148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gGeFiY8J1+XP36q5213MFxPBFQzRGc7I6i3Gt+VdqhUaqaovh0Tvl6UpWEpob2tJXtnzycCD2D6Xc2/n3WVJrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V9:
 - Add Florian's R-b tag in patch 1/2
 - Mark arm,func-id as a required property per Andre's comments in patch 1/=
2.
 - Make invoke_smc_mbox_fn as a private entry in a channal per Florian's
   comments in pach 2/2
 - Include linux/types.h in arm-smccc-mbox.h in patch 2/2
 - Drop function_id from arm_smccc_mbox_cmd since func-id is from DT
   in patch 2/2/.

   Andre,
    I have marked arm,func-id as a required property and dropped function-i=
d
    from client, please see whether you are happy with the patchset.
    Hope we could finalize and get patches land in.

   Thanks,
   Peng.

V8:
Add missed arm-smccc-mbox.h

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

 .../devicetree/bindings/mailbox/arm-smc.yaml       |  96 ++++++++++++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm-smc-mailbox.c                  | 167 +++++++++++++++++=
++++
 include/linux/mailbox/arm-smccc-mbox.h             |  20 +++
 5 files changed, 292 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
 create mode 100644 drivers/mailbox/arm-smc-mailbox.c
 create mode 100644 include/linux/mailbox/arm-smccc-mbox.h

--=20
2.16.4

