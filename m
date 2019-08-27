Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F434C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4906620828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g7vv0EtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfH0Jv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:51:56 -0400
Received: from mail-eopbgr50082.outbound.protection.outlook.com ([40.107.5.82]:47943
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbfH0Jv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:51:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JO23zEBlOiYVz0b4L3tsYZALfmv602c17dh7D+ZicetiSzvA6kyQZNNATulVwtEyHWEEroWGVcHqaD8+gQMJ7q6g2Q2vCMtytK5il60MYzrDBur1iwdJM5Z9nWx5BgrAIj8l+uoXTuF5j6Wk5URiqNi5e8HwRT92gmh9+0XslC4t/nA19IVG3MVOBPiIOB276cXPaEZN71PjdC3UHwu2lI72JctwO6HgMyeQb9HDBxpwukkuwJQ14q68JCSIfXyrSwhdgijXTnUPAf/El7pJ/K00df9c0GxSq9cnN576CKeBPIGGo68OoM/w9j/6cGSQMFTryRPZRtnrwPHWDvs9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKKjeB1PKkoH0A5kGwbfv/r12YbzlJ3wJClfV8L5j+k=;
 b=Nqnlx6PajNJsRy2PamfJnMDeggWT346fKEV/lZw2+FM8opXP6IQp/5iPMNFxjclH5qM/9GTJ77jJ/BV7GK7x5ZAhXr/2mXEEHN826cjBF3ytHQUo17AvTY7VkmYWO4eXc86WVfHer6BKdufw6s5TM0cd/q5IIqoHfOsg8BBtg0oFkMHyGFnTGlJLC8PWwymHK5VLSuhVQZR3Fhg0RNiYTMuRC+G9Y/quq+eVAyawzf4mLnI7w+1SS3eX111ODxA0stjCOPOa1JK2g1pnKHeYSkPVMq9ayRIi5HvnAZupWbZZiouGh0VVmFpFrZ6dDUM3JadV8KxyzMfsdS8KOz2Vsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKKjeB1PKkoH0A5kGwbfv/r12YbzlJ3wJClfV8L5j+k=;
 b=g7vv0EtZCkn00C3Js2cbkogCR8+H9Ulhaws5f1chx3kg6fQx7UQ2OZjz1fco8TVPhimSuZ9Mruxah0Ea1G9F3k9YJR+sNxM/vss6L+qICbPpG7owuj5ycfobIELaYFDki5dcb+O+tVZcrRJ/0RSUvhI0ilKsrDYHc02GqLJj6/s=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6436.eurprd04.prod.outlook.com (20.179.252.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 09:51:51 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.022; Tue, 27 Aug 2019
 09:51:51 +0000
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
Subject: [PATCH v4 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Topic: [PATCH v4 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Index: AQHVXL0MVe41wfXR30KMsd/PIhM2Qg==
Date:   Tue, 27 Aug 2019 09:51:50 +0000
Message-ID: <1566942646-18015-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:202:16::14) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cfa5fd2-6905-4222-b392-08d72ad42efc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6436;
x-ms-traffictypediagnostic: AM0PR04MB6436:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB64366B2F40BC270513009E0988A00@AM0PR04MB6436.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(189003)(199004)(305945005)(2906002)(2201001)(7736002)(36756003)(6436002)(50226002)(8936002)(81166006)(81156014)(8676002)(66556008)(66446008)(64756008)(66476007)(66946007)(6486002)(15650500001)(14444005)(256004)(2501003)(52116002)(14454004)(186003)(110136005)(71200400001)(71190400001)(26005)(966005)(5660300002)(3846002)(6116002)(99286004)(6512007)(66066001)(44832011)(86362001)(2616005)(486006)(53936002)(476003)(25786009)(386003)(6506007)(316002)(102836004)(478600001)(54906003)(6306002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6436;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5G2GPRtdrz7QXqIkJpFHeYeMBFZFDvevrC+GtEc/YJ12//vv5mgajY/353+z6yRMwrdX3qgcqWCsh9PIdkpMDRP+RMLjVM6T6ssFba/fUKsCdwr739gF/rqTFvPRkoPdrDZRaBKt2BN4+bfxNtJExaacE5FPpeAjkj5rDadTugwBGb2yi/1r/n4iv0FD6VncZFDqcWIMPQoYnYqQ+kUHPHS4yPPyWAKA/YTozKcTG6q50GOidH/g8AFIhom+sEFDy4VpxP+2Jh1jPOkU+KYQFY37EJiV3FfiEhgZQqNvEXJZXMtMLBVFkKdfn33V/cTpnZWLyB8VN8CdqTByOXsr8A6HbTKTmRtpGjS5pvLp5MCYHix/Ect+Sra6WEkVndm89oTkjoBTdB7dchOXDVs9nF8ho1qkJG9lYBgAXR8880o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfa5fd2-6905-4222-b392-08d72ad42efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 09:51:50.9458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2LIjYM+n5ACnHgnbLITaEi+bmEgnkzR9JSbo3FfSCiLn3i8hAEbj1ufCoYwyGD/LyyKZnrNsGahnS4Jp9Ulxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V4:
yaml fix for num-chans in patch 1/2.

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

 .../devicetree/bindings/mailbox/arm-smc.yaml       | 126 ++++++++++++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm-smc-mailbox.c                  | 215 +++++++++++++++++=
++++
 4 files changed, 350 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
 create mode 100644 drivers/mailbox/arm-smc-mailbox.c

--=20
2.16.4

