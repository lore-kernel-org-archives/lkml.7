Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0469BCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13CD21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="Mrs06t/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407157AbfJYHhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:37:39 -0400
Received: from mail-eopbgr30080.outbound.protection.outlook.com ([40.107.3.80]:45567
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406055AbfJYHhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:37:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibhZjkjxl+uYydazJf99TGBLq5OZOlK1OILzUe0hsVYPOiJ/f5DrtB68TU2btm/3tfjN5luEIf8SDx2HBAZlhOKnVYVRDTFqwfbEZEJGcwCZOYWY5Rwktc4ZtujwhHM4f26v4GPYgeT0OmEIrm09GoSxOr6bGImItG9lHsjQPQMmioVw3jBEzJslfr5pF2lWrluiytSqufMd/aDVvfcKKArC9oF942iV3kTndkfpBe8KBV9RdCeLHt0BCnGvOnds8CwaKmRXdRAhhocOv+P+4KYnNyjTYrssnj6saTeVmfsCJUiGOiCodkAPvK4MJ9eA868dVLA4ivVVod8wYxCYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xhRtploACdVvK59DwDIcG/zJcer18FOdsYoDwWoDLY=;
 b=eEgDUTokJR9BP7TvnscCPsZg62mtenOjQNEymMwpxmB3OWTp4hitcBXvInjCO99WSbjpOvptuEA/ppPIfaAb1ne6Fhv+4hBlWwaBdeX44S/YxPKewBQYufBkJdg2lNKWbr/0e5EyiwL2aWfWfX/D9dIEudILyjMgR68+RWLEiEulOhTCb+wZFDEDr+6FVe6YStPHsVkwA86r1D29yGUL66WDPdc9P+UQA8uKYzSXMRnRZ+M/sJ6t/nvRVoZdF4Wb2k7pWYRxXzjYy0rKmSakOpuXVQwS30AgXyiNm9SZ7Oy9eHXl0bzW23ASah8YveiqJqWyYBzzA9ieKHClbI9xVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xhRtploACdVvK59DwDIcG/zJcer18FOdsYoDwWoDLY=;
 b=Mrs06t/ZMsTwz4MLK5LSAH/2K+UosBEN9vrh9wavDnKQn8vmDLGC/sNs1gW2Q+wsHgq8UtcEfWECaF8NLoiAvHBBH+nldWSBhmXsyL9ONIgUCZoCrVHSugFYZUoLuYAjJMq3kYqD4TWCFJnaD/jLur+phppfYgbLhzPATWAZFoE=
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com (10.170.212.23) by
 DB6PR0902MB1671.eurprd09.prod.outlook.com (10.171.75.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Fri, 25 Oct 2019 07:37:35 +0000
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::b1b2:ecb1:9c98:6b74]) by DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::b1b2:ecb1:9c98:6b74%6]) with mapi id 15.20.2367.025; Fri, 25 Oct 2019
 07:37:34 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "oliver.graute@gmail.com" <oliver.graute@gmail.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCHv4 0/1] arm64: dts: add basic DTS for imx8qm-rom7720 board
Thread-Topic: [PATCHv4 0/1] arm64: dts: add basic DTS for imx8qm-rom7720 board
Thread-Index: AQHViwcRYochUUs1+UOTEgmf1hQkhQ==
Date:   Fri, 25 Oct 2019 07:37:34 +0000
Message-ID: <20191025073657.17593-1-oliver.graute@kococonnector.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MRXP264CA0040.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::28) To DB6PR0902MB2072.eurprd09.prod.outlook.com
 (2603:10a6:6:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oliver.graute@kococonnector.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [193.47.161.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a5a102d-18d0-4b80-2e6f-08d7591e3397
x-ms-traffictypediagnostic: DB6PR0902MB1671:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0902MB1671E2D6FB444CEBA027BE20EB650@DB6PR0902MB1671.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39830400003)(346002)(376002)(136003)(366004)(189003)(199004)(50226002)(7416002)(2501003)(102836004)(14454004)(316002)(86362001)(54906003)(71190400001)(6116002)(4326008)(6306002)(6512007)(966005)(6916009)(71200400001)(3846002)(52116002)(2616005)(386003)(476003)(5660300002)(5640700003)(6506007)(2906002)(486006)(25786009)(66066001)(508600001)(7736002)(44832011)(6486002)(36756003)(99286004)(305945005)(186003)(256004)(81166006)(8676002)(81156014)(26005)(1730700003)(66946007)(4744005)(1076003)(66476007)(6436002)(66556008)(64756008)(8936002)(66446008)(2351001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0902MB1671;H:DB6PR0902MB2072.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: kococonnector.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H4u3SNXeBoKe7CVvpTY+ytyjbQESUJvKTnATRxJqt/uwPBydFEx60ziEMWKaT1ewz8wbtOLn3m2QREp/ih68RuW+Pe4VRSLXUxlIai+ZuFOIqCpNw/fYM7RbecbuJw85bMW3WwJJa/3OowweCBNBeNcNF5DpnWZ1eqa8Q+inzbqwqZ23eSC71qGH53xyr7sa12Ej+wBh5Bs9rL/ZXzfdEbLjIGB9Xq4jgpEN+EuWg0acMigQ76K7PAFmr90JbpRIssI9cfKUCOSO1hNbuejQuSird69SCcLrYGanctckWlMqybBn1+ywkm5GFwDuvnoYsN31mPodqK73pKd8UnyYlEA1L5vEG13pLBlEpMMwBAiA7a7sLUMFfoLhv9Z+CVfKMjC7pEmUtQt/xjywxNse2s/zhbFqw+upziP24w/OzhOn5qaoUxnlWrVxUW8xXB+DOjKdyR8CifcTb5g4u9N1bSs2pbmhAbmO6oIckL5/z80=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5a102d-18d0-4b80-2e6f-08d7591e3397
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 07:37:34.6890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00mqP4qlgehA/R4Uq2biov4NXfLOBEqdGU/Fs2fdbVXbYgcnOMIa2WVli7wmWdRz4Zqws61WK+9448N2cEqXqLIJQLvI6jNlzAumbU6E4rI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0902MB1671
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is ontop of Aisheng Dongs clock driver and imx8 changes for the
imx8qm

https://patchwork.kernel.org/patch/11143321/
https://patchwork.kernel.org/patch/11138099/

This patch is based on next-20190904

Oliver Graute (1):
  arm64: dts: add basic DTS for imx8qm-rom7720-a1 board

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8qm-rom7720-a1.dts  | 299 ++++++++++++++++++
 2 files changed, 300 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts

--=20
2.17.1

