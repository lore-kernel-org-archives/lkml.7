Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11226C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00EE20820
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H+W+m+QZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503808AbfIXBOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 21:14:08 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:23937
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391681AbfIXBOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 21:14:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITWN+49fiFBMCYlP/Var00VkEwKnsB36P8rqITzzUa6Ee3S9ocf9+F4jZc9OV1x4XToOyfjNk3Sr0Shc1HBQlqLNqgv74FcoNM7ul/fiUnP+M2AAr8FZ/moPB/vw6ZL85SmHOMVUOvZkXrqVktonA0P2pQUoLJjrxN6BrO5D7lTsuwd/UuHoMnvqzEIeEQJKiv/0KSNV0hXK/T1Qfx3KZPonkGCGHD/cRTjMNz1j1z751EUZt429gfAcnmlN4Fp2F2D91lIfaRRtoimZQ9CF3U8T0+dU/KGQof71pdiuxTInLkudf+Er8XJyj50bB1muRrHaxI5h0zUqBAWyPFsq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WxFS7UmptMzToPNfknEYNcbfNJ7tnjtu+DHgKSayhs=;
 b=BiLjx71vkOnPFt3TtIR13iJBW+Hx/jfwAmI9v2GjjShvDQr1OvvNQpBlVN6hvw3BuFCYUkOLq4bvglIR2zhRnEO9xYX7VDqriMP8Kt2gKASiopa1FVae7pqfD6DkfC6J82qgfJ4QY4ct/Og23AzpXKF0L/piMgIqtF2rFKn+Po56oxV7sHNjF96bYTaLuEdcqhbT3CXv3POVdvoDtdx73RolJf6ukOl6uGHOqoBOw5wq7pGzV1EqmpowxrUP9kxIBeukyCAIrTJMZMbL/4FiadrGgxvuLUkRdWg07/+chrNLSbc+q6zCVtGgl50doa58kM9if/+5PlEB47GOoGb7qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WxFS7UmptMzToPNfknEYNcbfNJ7tnjtu+DHgKSayhs=;
 b=H+W+m+QZ5AfmzXwLG7AyFJH/YerjN4c5mLasS9VYfO5EyC9FEUf5HCZfOC4UhozqyQ09AuP6wLEATLnvCf40Xy3VXv4LamovnFJRLEkjolgaqnnr9MYTk9XDPO068PbzmN1WDxBMqF+aVFxmcBwqUNAxfis5ca88UxSXGr2SJMc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5396.eurprd04.prod.outlook.com (20.178.113.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 01:14:03 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 01:14:03 +0000
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
Subject: [PATCH V8 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Topic: [PATCH V8 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Index: AQHVcnVaog47u9gB7k2DLgSr2MVvDA==
Date:   Tue, 24 Sep 2019 01:14:03 +0000
Message-ID: <1569287538-10854-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f1bcfb6-8d04-4f4e-d1ee-08d7408c7d09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5396;
x-ms-traffictypediagnostic: AM0PR04MB5396:|AM0PR04MB5396:
x-ms-exchange-purlcount: 6
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB53969CD26D072B680FE2BDFC88840@AM0PR04MB5396.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(189003)(199004)(66066001)(6436002)(36756003)(478600001)(2201001)(316002)(14454004)(966005)(305945005)(66946007)(26005)(86362001)(71200400001)(66446008)(64756008)(66476007)(71190400001)(6116002)(3846002)(256004)(14444005)(99286004)(6306002)(386003)(66556008)(486006)(6512007)(186003)(6486002)(2501003)(6506007)(2906002)(4326008)(2616005)(102836004)(8676002)(54906003)(110136005)(8936002)(52116002)(81166006)(50226002)(5660300002)(81156014)(44832011)(15650500001)(7736002)(25786009)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5396;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xh2JBC9Y281Y7s7XRdyGRsl6hUkOqOAGbH7CKjbw6dOHzUNr/NouyInImhHtwyJ4t481d5g6R7d5w0gIWxWZ8gDTMAPcpVGqcr6EMYHEw0RF60jK4zUglIhksyRHJ7q3pwyvNDGf1yPKkH4/tFRY7HNGS1NDrNZTzvFX2t3SnuQdn0FTxw0NhDv36aB6/dhKDfPJSe9dgNGpTHzlq7oodxk9e1nmuNwfutcvq4ignVl3m7RIKsALWNAq/PFW9RrcXETPMKJwnbGbKtJo4yaMGN9bbJYhMNMQlrnh0bkA7XZgsjKQEUwuEBI588fe/MGYBS90zbGht3TypEAQCHBUpJz6CXvn/fRMzZj4ALJDfeiXax+XxGmVbK8rbcwqSWKIk5r6DexgsEmRraWklZzdIJv0B9K2m6Jzv316X7y38N4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1bcfb6-8d04-4f4e-d1ee-08d7408c7d09
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 01:14:03.6707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRuuc9kkInW4SMu47IoXg6PqcekHZGf30+BP69ogjzrTYJuTmYn/kCUM1LKNSRFAMWiDhLajck/yBoyDYwQA1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5396
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

 .../devicetree/bindings/mailbox/arm-smc.yaml       |  95 ++++++++++++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm-smc-mailbox.c                  | 168 +++++++++++++++++=
++++
 include/linux/mailbox/arm-smccc-mbox.h             |  22 +++
 5 files changed, 294 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
 create mode 100644 drivers/mailbox/arm-smc-mailbox.c
 create mode 100644 include/linux/mailbox/arm-smccc-mbox.h

--=20
2.16.4

