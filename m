Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C29CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ABA21479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="VHxcv48V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfJ2MXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:23:31 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:60388
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729058AbfJ2MXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:23:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeO4PDhgTntDZ3n4Ppl37IqATUHprur6RUl9aIg/upqDTi3McKVXt1HJBe2gJRE6TwmScJSdwOOjekw5ZUkV50zcZZlgXDASc0PzrxYQRlvFfa7vkMwRPViEm+/PNxjTtpwvATaXMDxafl6d4LMyGStWZpTcPw8Dhrcrsfvq+t9RPchLbrZP2Q72p/DiQbKSkVi38rqstsy7VVgH8KWQdeZC54zvMxLg+cEQDPWUj+ZVnx6dPDOtY9wXKbMDxmNrfR256/3ORQhZWfZ0UojuHRIpamkO0rv2WbCiWt/jDDZ3Hi8j3vCcJBHL11VVyzNiYjInDWTxjAMA6PhoENg6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3hBDvN4Cwb5kt4giDZXgWjJxZImeCkfHeK4sR6vHA8=;
 b=b9DlxOZtg/8ZmdznE7Ozh7X49Opq8KQVNRcF6ILzWMGezYnaF+/JoIrkgblYl93GXW8gBNemcKZqX49yAb2ixZsRmbIR8DaZ29y9yJRwjPptVA2Flt+vJCuHgfpoIRD2omqJ4JU52hTXkdKG3KJ0Nj9NSzsBGk1t3e+P4jrJibCRANuqmQav5voKNbdFQIJmT2RQ6c6GLWVEpz+X4zn3IZk8o+AzDV0KLpYXh2cGcWcfEhWu5NsLY6djanpfgSGJfz1ejh4XJDFCduZkKlNLyqKCC+xrbAU5tnmoKZ5iIobiv9egrGNpTpugTsKwwWjK8E/yCt+NfCAfHtyCOF3wWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3hBDvN4Cwb5kt4giDZXgWjJxZImeCkfHeK4sR6vHA8=;
 b=VHxcv48V93ot33vbnVHE8aAQcvEiM64Rug9tXLEfWFiKljkPrccMGkloDT5W2fiCLG+8ov5nCQZ1az6hIe6VcVrYfFjozFMAgfbLrLlX0My3Sm61yk3+4VRtg8Y0VmmikNGiCJgu+SymulfGF8vHgG9YNmPhWhTyB7SjToSSEOs=
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com (10.170.212.23) by
 DB6PR0902MB1799.eurprd09.prod.outlook.com (10.171.74.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Tue, 29 Oct 2019 12:22:45 +0000
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::b1b2:ecb1:9c98:6b74]) by DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::b1b2:ecb1:9c98:6b74%6]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 12:22:45 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "oliver.graute@gmail.com" <oliver.graute@gmail.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Jon Nettleton <jon@solid-run.com>,
        Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 0/1] arm64: dts: added basic DTS for qmx8 congatec board
Thread-Topic: [RFC PATCH 0/1] arm64: dts: added basic DTS for qmx8 congatec
 board
Thread-Index: AQHVjlORbb5pQGDQCkq61kl7ksae7g==
Date:   Tue, 29 Oct 2019 12:22:44 +0000
Message-ID: <20191029122026.14208-1-oliver.graute@kococonnector.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0101CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::46) To DB6PR0902MB2072.eurprd09.prod.outlook.com
 (2603:10a6:6:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oliver.graute@kococonnector.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [193.47.161.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3a6dfa9-1181-47dd-b507-08d75c6ab3bf
x-ms-traffictypediagnostic: DB6PR0902MB1799:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0902MB1799159A340C09C5666AA274EB610@DB6PR0902MB1799.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39830400003)(346002)(136003)(396003)(51234002)(199004)(189003)(36756003)(6306002)(86362001)(386003)(966005)(6506007)(6916009)(6116002)(316002)(14444005)(256004)(5640700003)(1076003)(99286004)(486006)(476003)(2906002)(6512007)(2616005)(26005)(2501003)(54906003)(44832011)(4326008)(186003)(66946007)(14454004)(66476007)(7736002)(8936002)(45080400002)(102836004)(305945005)(7416002)(508600001)(50226002)(8676002)(81156014)(1730700003)(2351001)(64756008)(66446008)(6436002)(81166006)(71200400001)(71190400001)(66556008)(25786009)(5660300002)(52116002)(6486002)(3846002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0902MB1799;H:DB6PR0902MB2072.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: kococonnector.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lbuCEWpQEdk+1QKqXC5iD4PwKlLuj+1yeuDv/qmLJGcwiStDME6himg4IsTuwEYyVwR4g1s58d7EhfHFBbKtqWyyJGozJfqiP2nLyA8cKrMHzi4+4LeXt9mIzNsFSBnq0TclPrDNm80GkQiXQnbfWAzIbX6KTigxM0FvTD3Lsh6kxNym3eYjY5SShjiA2GjLwgBlyo2t5z1poix9ua6ttDaz4kw9CWKtx8zTmuPgl3s0kqvVUz+4LrRVLstRt7P5GD9pud2+5xPG/2v256reHWn0G98XYy8y3ou+/c9hwgkVJKeRYIvV1PDtpsjdMZ++1gh7WAxsd+chhfqWcaK6P3eFSRMdVKG1Li8d882KgNunXI+57KBPgUu+rG+RCMOeIawQL4D4y3FuXtgJjhKDI6BZoRJncejUg8/GVY+sgSnOsJ4ME+OttbT1cnMMYceoQrzl9b3umRkmdh+3u/3fFZSGKSq8PnzU3SseVmwXE40vO6E244Ln6ykjPXGR7kdX
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a6dfa9-1181-47dd-b507-08d75c6ab3bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 12:22:45.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUtHf5jFel4Y9avn159QOON7oeXRLm94g1i/LPmUryFrC9NqdE7CjmDkgroHuHXTtar8GG3hjE22rQ5qzcrj6X6rpy/cam67luVHy5/Sq9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0902MB1799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is ontop of Aisheng Dongs clock driver and imx8 changes for the
imx8qm.
https://patchwork.kernel.org/patch/11143321/
https://patchwork.kernel.org/patch/11138099/

I observe random crashes with this devicetree like this:

[  676.355973] fec 5b040000.ethernet eth0: MDIO read timeout
[  676.361455] ------------[ cut here ]------------
[  676.366087] WARNING: CPU: 0 PID: 208 at drivers/net/phy/phy.c:708 phy_er=
ror+0x10/0x58
[  676.373924] Modules linked in:
[  676.376984] CPU: 0 PID: 208 Comm: kworker/u8:2 Not tainted 5.3.0-rc7-nex=
t-20190904-00034-gdc1fd1a2104b #5
[  676.386553] Hardware name: Congatec QMX8 Qseven series (DT)
[  676.392128] Workqueue: events_power_efficient phy_state_machine
[  676.398049] pstate: 60000005 (nZCv daif -PAN -UAO)
[  676.402842] pc : phy_error+0x10/0x58
[  676.406413] lr : phy_state_machine+0xa8/0x168
[  676.410765] sp : ffff80001217bd60
[  676.414083] x29: ffff80001217bd60 x28: 0000000000000000
[  676.419399] x27: ffff0008f6b64338 x26: ffff800011073b98
[  676.424715] x25: 0000000000000000 x24: 00000000ffffff92
[  676.430032] x23: ffff0008f70c1000 x22: ffff0008f70c13e0
[  676.435348] x21: 0000000000000004 x20: ffff0008f70c1438
[  676.440665] x19: ffff0008f70c1000 x18: 0000000000000010
[  676.445973] x17: 0000000000000000 x16: 0000000000000000
[  676.451290] x15: ffffffffffffffff x14: ffff8000117398c8
[  676.456607] x13: ffff80009217b8b7 x12: ffff80001217b8bf
[  676.461923] x11: ffff800011752000 x10: ffff80001217b840
[  676.467240] x9 : 00000000ffffffd0 x8 : ffff800010698408
[  676.472557] x7 : 0000000000000151 x6 : 000000015f8c5440
[  676.477874] x5 : ffff0008f8341db0 x4 : ffff0008f6500000
[  676.483190] x3 : ffff0008f70c1438 x2 : 0000000000000000
[  676.488507] x1 : 0000000000000000 x0 : ffff0008f70c1000
[  676.493827] Call trace:
[  676.496273]  phy_error+0x10/0x58
[  676.499499]  phy_state_machine+0xa8/0x168
[  676.503510]  process_one_work+0x1e0/0x350
[  676.507518]  worker_thread+0x40/0x480
[  676.511179]  kthread+0x120/0x128
[  676.514413]  ret_from_fork+0x10/0x18
[  676.517990] ---[ end trace 919aac09d207cb93 ]---
[  676.522931] fec 5b040000.ethernet eth0: Link is Down

Some hints how to fix this?

Oliver Graute (1):
  arm64: dts: added basic DTS for qmx8 congatec board

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8qm-cgt-qmx8.dts    | 391 ++++++++++++++++++
 2 files changed, 392 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-cgt-qmx8.dts

--=20
2.17.1

