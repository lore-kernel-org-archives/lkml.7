Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57959C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 02:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3D3218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 02:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gvjb6lxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392772AbfIJCsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 22:48:05 -0400
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]:28847
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728749AbfIJCsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 22:48:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXqQpO26SoHspM4ugLIzXrWTZnCCCCLAxN7rYwLMbRKQ1SgxbMuf2ikDivsRR05T915qhkihHNpXagUqSumrvM/I5rvzkiDEjnJUzsDAEXSFaH2ynQ82nsqckITXpYX5SDHAtBs1XzOfmaZ/A+JzYI/eczyC3zJjyZ8dve0enr4aP7AUioWHyHk8qSXhMbPIXM2pM1W9OU/MjJ4zZF0d8Pib9MiblaLAuAR3cASRyS1mF2QXQP4rFi9kvA8Zz3gyE/nUHazS1OkDfJWsJDJ6x9ppaFVJ5zs672aAtTupXDgaVOCySSE/qoVXXonvsBFL16pYP5Gd0YJ0KebqMZvMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93C4EF6p9yjCol0Pwl/5OV6PN6Rv53cVVcsuP2uFuMs=;
 b=lBr3kDcULnr9slFee0ebW6jjN2OWE3GsD7z5Y9425AH+x1cSjgpHXPQeRYsaUhHscVKLv3RL01SjUu0H9gvFir/L+Kp96PoN3a43+3II4A4sDZyD461REUpV2SWz9Z78g/tF74ao6y6vr2Uc5M29I0lerTMdCF9XVCrppTk7E8zcun/P2BtXTxBPxon95cCd30QhKkJaWJ/R6UVMsUW+P2wfb/AxEnBTecvDTqNbNqmBpgTXODgs/udj39aGy0pMSHz7MkgEx2TZnvo8ZKNHYjwLXoXjfAchAWlIipw93EyBbSKwFt0ssbzdCxpanaTbR6pWqNX2+PwIUt55Q/zU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93C4EF6p9yjCol0Pwl/5OV6PN6Rv53cVVcsuP2uFuMs=;
 b=Gvjb6lxgxN9gOoU/MnX/MzTPRdUB0AW1mZiYe7SsMHXackXoi+J7ANVXWk+AabpA3yzKZIvozUxOI1P71W1j6f+tXGRu1Y6LgxwZM/4ChTwtAIkOFPtSb/7rQ70HWd6lKqWwkpW17YuoyeYG+hTizxzowNxgsjT53DHvIU7I+mA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3931.eurprd04.prod.outlook.com (52.134.65.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Tue, 10 Sep 2019 02:47:59 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 02:47:59 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
        Peng Fan <peng.fan@nxp.com>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: lpcg: write twice when writing lpcg regs
Thread-Topic: [PATCH] clk: imx: lpcg: write twice when writing lpcg regs
Thread-Index: AQHVXK/qRNohGClvt0yC94cqOwkPUKce9XOAgARa7gCAAPmTYA==
Date:   Tue, 10 Sep 2019 02:47:59 +0000
Message-ID: <DB3PR0402MB3916906683B58843B459ABE1F5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1566936978-28519-1-git-send-email-peng.fan@nxp.com>
 <20190906172044.B99FB20838@mail.kernel.org>
 <CAA+hA=To9B0H1z6Hh1eSZN9_rcextT_Oe-CTMmz9fC9CDNUBTQ@mail.gmail.com>
In-Reply-To: <CAA+hA=To9B0H1z6Hh1eSZN9_rcextT_Oe-CTMmz9fC9CDNUBTQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40c0b3e7-865a-4a8b-2aee-08d735994ae8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3931;
x-ms-traffictypediagnostic: DB3PR0402MB3931:|DB3PR0402MB3931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB39319FF4AACD2A5837BC05A0F5B60@DB3PR0402MB3931.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(199004)(189003)(64756008)(7696005)(11346002)(446003)(71190400001)(71200400001)(110136005)(74316002)(7736002)(478600001)(305945005)(52536014)(14454004)(3846002)(5660300002)(33656002)(6116002)(66066001)(9686003)(66946007)(76116006)(66446008)(6636002)(54906003)(256004)(316002)(6246003)(102836004)(6506007)(53546011)(8676002)(6436002)(86362001)(76176011)(26005)(8936002)(486006)(99286004)(44832011)(66476007)(4326008)(55016002)(186003)(81156014)(81166006)(2906002)(66556008)(229853002)(476003)(53936002)(7416002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3931;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QcwUnDESFfBUDm4toHS5RvQyN8BgiaZyYFpK+bSdQq7m2E5uiTa8R0twqcnuOlnsfXmboiOvyH4cOUo49ds4HtmKtLPeAwiK8ebdeLMHaq5VId9jYKuED8Jdt+Dx0+/gj2MFtVbEfKHc/MEOegLAYdvlXOyXK7f/9o9OK2h2A7zIZ7zNtgbEraUNGNsYeTA8IvR1trgboH9K9FKh9XWWEzDpRJ3yH02CdpF5uTJEv+OiYayF2AEtur4Olchbprl6hraM2p+BxManG+jMlr/ejgSFpkRHsVyGZo0nh8pgGayrHyJDxPb1eUzYrHv2CWHeEEJW4TSsG18v7Z2Slhvv+VLbUlR9Yl8ujbsRw5Euu5POZR/imBVc5pok6rZzCe7HSXeC4L2SGoe855hHCw1E5whOXJQEyPnBBZ/udO+XpEQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c0b3e7-865a-4a8b-2aee-08d735994ae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 02:47:59.8092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41aLjU+y76hCUEVKAXE6UlLWtLqGtWcHdu6frcEWAm2sFMhYfjUil/yq3CCXNZrGcZRyJLa0T3Dz4/ty6aAZIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU2F0LCBTZXAgNywgMjAxOSBhdCA5OjQ3IFBNIFN0ZXBoZW4gQm95ZCA8c2JveWRA
a2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBRdW90aW5nIFBlbmcgRmFuICgyMDE5LTA4LTI3
IDAxOjE3OjUwKQ0KPiA+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4g
Pg0KPiA+ID4gVGhlcmUgaXMgaGFyZHdhcmUgaXNzdWUgdGhhdDoNCj4gPiA+IFRoZSBvdXRwdXQg
Y2xvY2sgdGhlIExQQ0cgY2VsbCB3aWxsIG5vdCB0dXJuIGJhY2sgb24gYXMgZXhwZWN0ZWQsDQo+
ID4gPiBldmVuIHRob3VnaCBhIHJlYWQgb2YgdGhlIElQRyByZWdpc3RlcnMgaW4gdGhlIExQQ0cg
aW5kaWNhdGVzIHRoYXQNCj4gPiA+IHRoZSBjbG9jayBzaG91bGQgYmUgZW5hYmxlZC4NCj4gPiA+
DQo+ID4gPiBUaGUgc29mdHdhcmUgd29ya2Fyb3VuZCBpcyB0byB3cml0ZSB0d2ljZSB0byBlbmFi
bGUgdGhlIExQQ0cgY2xvY2sNCj4gPiA+IG91dHB1dC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IERvZXMgdGhpcyBuZWVk
IGEgRml4ZXMgdGFnPw0KPiANCj4gTm90IHN1cmUgYXMgaXQncyBub3QgY29kZSBsb2dpYyBpc3N1
ZSBidXQgYSBoYXJkd2FyZSBidWcuDQo+IEFuZCA0LjE5IExUUyBzdGlsbCBoYXZlIG5vdCB0aGlz
IGRyaXZlciBzdXBwb3J0Lg0KDQpMb29rcyBsaWtlIHRoZXJlIGlzIGFuIGVycmF0YSBmb3IgdGhp
cyBpc3N1ZSwgYW5kIFJhbmphbmkganVzdCBzZW50IGEgcGF0Y2ggZm9yIHJldmlldyBpbnRlcm5h
bGx5LA0KDQpCYWNrLXRvLWJhY2sgTFBDRyB3cml0ZXMgY2FuIGJlIGlnbm9yZWQgYnkgdGhlIExQ
Q0cgcmVnaXN0ZXIgZHVlIHRvIGEgDQpIVyBidWcuIFRoZSB3cml0ZXMgbmVlZCB0byBiZSBzZXBh
cmF0ZWQgYnkgYXRsZWFzdCA0IGN5Y2xlcyBvZiB0aGUgZ2F0ZWQgY2xvY2suDQpUaGUgd29ya2Fy
b3VuZCBpcyBpbXBsZW1lbnRlZCBhcyBmb2xsb3dzOg0KMS4gRm9yIGNsb2NrcyBydW5uaW5nIGdy
ZWF0ZXIgdGhhbiA1ME1IeiBubyBkZWxheSBpcyByZXF1aXJlZCBhcyB0aGUgDQpkZWxheSBpbiBh
Y2Nlc3NpbmcgdGhlIExQQ0cgcmVnaXN0ZXIgaXMgc3VmZmljaWVudC4NCjIuIEZvciBjbG9ja3Mg
cnVubmluZyBncmVhdGVyIHRoYW4gMjNNSHosIGEgcmVhZCBmb2xsb3dlZCBieSB0aGUgd3JpdGUg
DQp3aWxsIHByb3ZpZGUgdGhlIHN1ZmZpY2llbnQgZGVsYXkuDQozLiBGb3IgY2xvY2tzIHJ1bm5p
bmcgYmVsb3cgMjNNSHosIExQQ0cgaXMgbm90IHVzZWQuDQoNCk5lZWQgZG91YmxlIGNoZWNrPw0K
DQpBbnNvbi4NCg==
