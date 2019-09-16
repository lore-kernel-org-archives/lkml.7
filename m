Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29534C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E749C206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D9yJ+QRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfIPJok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:44:40 -0400
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:50033
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729400AbfIPJoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:44:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6KJC7gFs90RLxJ4e44etabwhVYyYvNLQyna8iftyRg9iUVf36yQ0fWVI2CRG4vauICi/JCIQ41u4/tgFGMa3s4sO78WHhBxAs+gZXGjxox10zc8oHDvUelWBtdcR/xUvSYcFkagWTB0KxRfIt6aRk+kk+7KtQZn+NsN288uRTN30Q4PnlN6dsgn/wzWVmqgUUDQMa00KiNDS8UgylSEewFKk16GeaOT37XfvoYxKmtKAYrL+qxL7bHCW8SVQHJWlg4x/QWRn8wZw7j8MKbUlnL+dKeiRMu/+BAI081ElMyEeLqHTfwDCkeTRIGvST7u9oBxos9c7mTrdoRTMtb56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIKRP/Ab77pwgvuNgksSyvof9L1tKXs26nOLvpmAc1w=;
 b=hs5qq04547PAqWroiYyFfVwr6/SUoLomKa/GO2g4ff+82tqQriPhfrNUHruc30HlU7rdOChDa2wrzVNJtHTmPjjTQczkwj9/wD+u8uyKnTp0awvo6VAdIeDRneq7ABori06RMR8999c7eGVUs2xd8zsLgXG107CzxLSGOYam71nDOLIUUL3ZhkTahrQynIyiHWwlwlQrdXBu04uun0X9eV/zPdsrne5yZnqOzFWywAE1kisBDRuITf4eNgPD0AMf2Z6jsO1amCMhyXzkAlVQRo1sM7hZn//9yZKrnfxxlBbxo1kJied0buVcKggiuzEaOAaINkePHBrR2TBOWXLdiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIKRP/Ab77pwgvuNgksSyvof9L1tKXs26nOLvpmAc1w=;
 b=D9yJ+QRIPeJ47iHIkzmYtrrB6Qo/P/b38YYznnNav9o2aZbWscv6KC74lxR+IKIyk0ZBHPltr1BXqBi3xxTTZ9Af1ng+CBSDCnQ5BFBrqgI0wuYq99/9Wn+1nXNp+DYSTo3iLFo94DJyMJOztUIwtWfa/aDgj0lhQTw7SC2ra0c=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4674.eurprd04.prod.outlook.com (52.135.149.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.13; Mon, 16 Sep 2019 09:44:34 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 09:44:33 +0000
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
Subject: [PATCH V6 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Topic: [PATCH V6 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Index: AQHVbHNY4zpIebrUQEWKO3DtAUGWhg==
Date:   Mon, 16 Sep 2019 09:44:33 +0000
Message-ID: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d3974ea-c7b1-4df9-4abd-08d73a8a7ac0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB4674;
x-ms-traffictypediagnostic: AM0PR04MB4674:|AM0PR04MB4674:
x-ms-exchange-purlcount: 5
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB46745948AA8A596DC6FDA9FA888C0@AM0PR04MB4674.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(50226002)(81156014)(44832011)(8676002)(8936002)(81166006)(66946007)(14454004)(52116002)(99286004)(15650500001)(6436002)(14444005)(316002)(2616005)(53936002)(486006)(305945005)(7736002)(86362001)(476003)(66066001)(36756003)(2201001)(54906003)(6486002)(2906002)(66556008)(5660300002)(6512007)(110136005)(386003)(6506007)(4326008)(71200400001)(26005)(71190400001)(102836004)(966005)(6116002)(66476007)(3846002)(186003)(64756008)(256004)(66446008)(6306002)(2501003)(478600001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4674;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OewJcPWiBhA4Tsweo4V1b1/WIu2WUAhGr1p66SAEs4hJ30Kox3aIGqvOpm3x7EsrDttHcgtpTcA9hHw/zstpKPUXTNeLPPwFWUlzvHtjiRDp/wQm/RXQN9e/VW44o2TnxptlCUqspyWDzWLq4cH4A4dp64wWbPyunOJVGW7FEtgTKE32bz/2jUsC6lLmBt0yG5DAa7mWJ4/e0H+yrehS3IacSkzXr3mte0DZLHc/4YytLZ1ge7i1aMLQ8aVn2iC310JVAHlfDgZg0oaRRkDgEsPQX/qi4N375zHGnK7H7bAUhRQ3u1f7xFrQZauEKNLthQE2nhmEVnHw1rhRB6s8zuoVlmEo6WGowk4NYldpo0CN8JZgkxIHHTsY0oFNAOJXKmgdvUpakRel8Qk0OshbdmsNWqBC741ayZS/pR/MrUs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3974ea-c7b1-4df9-4abd-08d73a8a7ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 09:44:33.8942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSQNwMBhooiRFuCtyDSin553T1QPeeHcIAX42+olr9UTHjlHvV1C1JEaYYdTzuvW9yxDJa7Qt0uIMHxnPKS1qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V6:
Switch to per-channel a mbox controller
Drop arm,num-chans, transports, method
Add arm,hvc-mbox compatible
Fix smc/hvc args, drop client id and use correct type.

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

 .../devicetree/bindings/mailbox/arm-smc.yaml       |  96 ++++++++++++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm-smc-mailbox.c                  | 167 +++++++++++++++++=
++++
 4 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
 create mode 100644 drivers/mailbox/arm-smc-mailbox.c

--=20
2.16.4

