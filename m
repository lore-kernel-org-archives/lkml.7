Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAB1C4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 02:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369DF21479
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 02:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qBKgZVrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfIPCzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 22:55:20 -0400
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:32363
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727510AbfIPCzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 22:55:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhHoErXWkS//J/ntoGUqN/4ngUvEheLoOoONA3SQecmeEPmhZalGzjVI7oOG7jLxTx7JzT3GCy6dYCZUie7Tsxmh3TzQmoLF8NYnRVRKoOmONH4aBeA+QEnFonfVBI8gC3m/zp7uaylcQGlOs+Vg5TqzT+DgVYBl+jjJYDTnefFnnNePn6Hjn4mivsfA7B6xuy0q5gaR3AVxTo7/ad74USnJYH/7myilDKpFPSOUxFs4cEjJz6SzZt48AypXeujgi6SMJbU7vowSDoOvscEpiY97SgQ2OQ5zOSGNXJT+p2jo1/X9wyLTRe1KfgGQNkxLxBjcavpC6c2CSzeOubxNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK5B1itasO3wZTjuFJ38gLthB/MLSxDEu66tpqd+xxA=;
 b=PjPyvuysTwm9bvg3bAZNnqzqtiFU6phtFZ5Qxqg65lFRrj0k9bRqO6NJYSu+Brt3SB/5LBrrTo/JqsA3piBoXpGrk43aNV/NKhWQwaPkGEVwddIbxyOnUaBXCHr6cK0nvVMSmz2a1NO3k5aVgrBXv+bpyJHY9xg5Vex3+pPTOJnECBPW66HcyNSeTLPL4zmIPC1bu9PpZQ/sS4VuC4BDUmJD4BfCrd+kjeJyRR8aocWQ3tE2j4L2sJN7xjGMTjLAxbRLDnM1klcxIaV2cMW3yj7A6gVrdnEfvffUvU8fK58/sHnbvZ4X0U3NFJ4tbLemKKoahFcF59X3THTzqaUidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK5B1itasO3wZTjuFJ38gLthB/MLSxDEu66tpqd+xxA=;
 b=qBKgZVrCt/D7kuTnqxu2Y6pOoBvwyfCOXRXdNjjV+ApIct0V0Lng2k4bsYzrj7xcXnz3TfoIvD6eaqIhMKpoD7LqnxeyvePkZ7lwmS5BJQW/wtknVFFTRiAFHsaMyuBmwTCPsvBsaYFbPUU/3l+hZCxUVLs3r1EuRmVNDBl81Dw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3931.eurprd04.prod.outlook.com (52.134.65.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 16 Sep 2019 02:55:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 02:55:15 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] ARM: dts: imx7d: Correct speed grading fuse settings
Thread-Topic: [PATCH 1/2] ARM: dts: imx7d: Correct speed grading fuse settings
Thread-Index: AQHVaRXTS1M3MwR05keYUt7dEQg8Mactob6Q
Date:   Mon, 16 Sep 2019 02:55:15 +0000
Message-ID: <DB3PR0402MB3916411027B6F28179010327F58C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1568256992-31707-1-git-send-email-Anson.Huang@nxp.com>
 <VI1PR04MB7023E48B04999733859F7158EEB00@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023E48B04999733859F7158EEB00@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db86a233-5d75-4323-f27b-08d73a514d4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3931;
x-ms-traffictypediagnostic: DB3PR0402MB3931:|DB3PR0402MB3931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3931DDF35F01D82CF41C49FEF58C0@DB3PR0402MB3931.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:534;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(305945005)(74316002)(7736002)(256004)(86362001)(476003)(2906002)(486006)(44832011)(2501003)(446003)(11346002)(4744005)(5660300002)(6116002)(3846002)(99286004)(71200400001)(71190400001)(316002)(26005)(102836004)(186003)(6506007)(53546011)(7696005)(54906003)(76176011)(52536014)(25786009)(6246003)(66066001)(33656002)(6436002)(55016002)(53936002)(229853002)(9686003)(76116006)(66446008)(66946007)(8676002)(64756008)(66556008)(66476007)(4326008)(81166006)(81156014)(478600001)(8936002)(14454004)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3931;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8TP/EOmI9Cn1ryIo2wtGY3yMK7xWIfrrNyOz8MgO8DXE5UQahFGpKZK8ZndXSRIVUUZBhgULacSsOsm3svubSK6slZjACAYPoe+xOtYW6q67uqsS06yQAD232d+zNdMy4ogx4AqJtkVSFABeTW3K6F4PPeHMVlLxseZrY4eKznHFd7JiaarUE5YObLHei0kDvS6GpSWOVN5YC15s+Zo5xFZFNpcGgKHqN0fksFLNd7r353g6pXY9tochhXKxDF4oGXthY49On97/OhJcSWGKR7uDsVBdgI+CzGLOFUIQujhJCVaU8Bs+1ulVbz1SA4LgNpn2mTMt6Bbx+4eFCDbLdDIOUW5aQc3F5Ogyec+gLQNTqUxfSw75KyVxeF/lU7mN7zeoayqUEIX1t3LCaokwtvWZSrMT2XCbcP8JB8ILXHg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db86a233-5d75-4323-f27b-08d73a514d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 02:55:15.8985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7aBQhsfC3PPvrFxxlpdtpfJyixUrH/l2R9lLzKs/CFn1lZLMFYLyzD891cWJuweEXrPb6sH014QruZG5OX41Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiBPbiAyMDE5LTA5LTEyIDU6NTcgQU0sIEFuc29uIEh1YW5nIHdyb3Rl
Og0KPiA+IFRoZSA4MDBNSHogb3BwIHNwZWVkIGdyYWRpbmcgZnVzZSBtYXNrIHNob3VsZCBiZSAw
eGQgaW5zdGVhZCBvZiAweGYNCj4gPiBhY2NvcmRpbmcgdG8gZnVzZSBtYXAgZGVmaW5pdGlvbjoN
Cj4gPg0KPiA+IFNQRUVEX0dSQURJTkdbMTowXQlNSHoNCj4gPiAJMDAJCTgwMA0KPiA+IAkwMQkJ
NTAwDQo+ID4gCTEwCQkxMDAwDQo+ID4gCTExCQkxMjAwDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBM
ZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KPiANCj4gQXJlIHlvdSBn
b2luZyB0byBhZGQgdGhlIDUwMG1oeiBPUFAgYXMgd2VsbD8NCg0KU28gZmFyIG5vLCBhcyBkYXRh
c2hlZXQgZG9lcyBOT1QgbGlzdCA1MDBNSHogYXMgT1BQLCB0aGlzIHBhdGNoIGlzIGp1c3QgdG8g
bWFrZSBzdXJlDQp0aGUgc3BlZWQgZ3JhZGluZyBtYXNrIHNldHRpbmdzIG1hdGNoZXMgdGhlIGZ1
c2VtYXAgZmlsZSwgTk9UIHN1cmUgaWYgNTAwTUh6IHdpbGwgYmUgc3VwcG9ydGVkDQpvZmZpY2lh
bGx5Lg0KDQpBbnNvbg0K
