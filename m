Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EA0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 03:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF92217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 03:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qIHxHcfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfH1DDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 23:03:01 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:37765
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbfH1DDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 23:03:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bc9hK9APccyum72sfb0qn0aPJGbo8nnAQREdRKv6QF+gMn7EdNxec94M5QIwEiStIkFXrMa+tJ0060DXV6+g6w+lGDNBl8v/H9Rv59xWdFgFZPqd5wzadwJygZmTOjHDtHIdNWql7v/n8vZAkfy0ERs50mE85kIJ4UghU++dgsPzzNpixQrRiwSZQJlBKlT4E58Ly/VbxTJ40+Fyoclu76NNfa7Nt/3cNQlFglQow3sAFx0pJZW6yU/0fNU5phYt1Z2cMJ1VyE3tYVBX3k1iD2MGpCvTddCa0DTcWDVKp/Y/J9a7AFrvzR/jvzeF19jGFsW+u7qes6F4rknAXY88Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rx9r6CgURtCFmp8DHjXvh7Bt6cFnUZHBoFRsXTMJoY=;
 b=Ir6kf/I+jKNJvJZzCNim55D5zOKbRwJtTW+70/YVdPti3DoUFJ9FpK8SUMyrJDCcj2D49esgaQvOWyQAJI8QBzQLgc0IVK56zsXG1SIYDjofzz/IvdU+lY4ZFpmzNLkf83LacOLvMj72u9BEahsCi/I44Lh7/MdQgDL9I94GTUHcomoAR7WH9L26lWX1L8St6bblnNJl9yitx93Ao1hwFJXmHVpVSozPL6rNYV97tPah3za5WMHTDhmHHko5ZpR+sjNqMZzMAVCZfWXdBqXSZ8k4ki6AmQgYG5kPuf07DZYgj+0JcJbvt7T7LwLBHLk4/HWeLHtXHDTe5SPYxpW96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rx9r6CgURtCFmp8DHjXvh7Bt6cFnUZHBoFRsXTMJoY=;
 b=qIHxHcfGv1Gm09Kmb6/n8ee0Z3v6R0o4IFkF9qznXLOT4n8UmldwclV1p6viebWsNHQp5Bzg9EuViicladZ+QXywq3nRYRyM/HoDFmeYK4wFNtjqpva9iH+hQOSJTuAksJraKscY47E8yDeYygIDHik8fndaanw+0WAe6MS5ChE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6033.eurprd04.prod.outlook.com (20.179.33.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 28 Aug 2019 03:02:54 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.023; Wed, 28 Aug 2019
 03:02:54 +0000
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
Subject: [PATCH v5 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Topic: [PATCH v5 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Index: AQHVXU0W/OQqpHrw2UaiSQygGBIz9Q==
Date:   Wed, 28 Aug 2019 03:02:54 +0000
Message-ID: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0163.apcprd02.prod.outlook.com
 (2603:1096:201:1f::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d15ec50a-bf93-4ec6-b435-08d72b6438a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB6033;
x-ms-traffictypediagnostic: AM0PR04MB6033:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB60339A6C7E9DD99397A9EB2088A30@AM0PR04MB6033.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(476003)(25786009)(6116002)(66446008)(53936002)(3846002)(66476007)(66946007)(66556008)(64756008)(8936002)(6512007)(14444005)(478600001)(386003)(44832011)(6306002)(305945005)(15650500001)(54906003)(2201001)(86362001)(2616005)(14454004)(486006)(6506007)(256004)(966005)(7736002)(6436002)(2906002)(50226002)(4326008)(81166006)(102836004)(81156014)(8676002)(6486002)(36756003)(5660300002)(26005)(71190400001)(2501003)(99286004)(66066001)(52116002)(316002)(186003)(71200400001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6033;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MOuufvugdaLsoY3W1ukB+WMdtSjLlDAhRv4fupLXYl4+qBwd21C+Xsx/yG8oKpjo0m6mGTrqqSP2D5pZQtRu/hmWqV+T16C8ACN9VEpDV6H7zQELZtFF1OuR+2uKoZpt9tLLA429lCq69V1HwrefQScHlgDCJ+qjSp7UaCPMBzuucP/LlD95h7eQ1b2/XSfmgPlSTZ0Yoxy1jNHJbvj4NqbyrckPtV6+Bkjx25DS+KRztmM7mA5nTG0hw879dHkLAI3oVu+LLud4UQoZ2+Ha3nkGGuid7wkSBx45RvJRJZ5c1rYS89DvefBKagdAtNEO+mF0KVCpVOgbMyozexjlNCiSACAkH/9S0F8/DIx0K/65yDWsCRAAfTn0Z4OJiJ+23J1/RKnyg+8ETA7KUi9x9AkSD9gSLWxP1/MxHZSRn7A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15ec50a-bf93-4ec6-b435-08d72b6438a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 03:02:54.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PccFo1di8NM2BGM+WAIsfvLonKL6dpxc1RSN4xI+NEC34U7K9gWo4q6qi14B8XIJUx3VxO5oSz/sKDslHVrzvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V5:
yaml fix

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

 .../devicetree/bindings/mailbox/arm-smc.yaml       | 125 ++++++++++++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm-smc-mailbox.c                  | 215 +++++++++++++++++=
++++
 4 files changed, 349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
 create mode 100644 drivers/mailbox/arm-smc-mailbox.c

--=20
2.16.4

