Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1F6CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FA62084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="saF7jt8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbfJWGs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:48:29 -0400
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:19910
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbfJWGs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:48:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjgKGwFUDC0vxykAnrqLRQJBCV2c5BOUtfPpCxeTAPPhw+9rMGjZGFKFcf65IdxJamfl9yw5qZFVynUcqfj4owsrLqUa85AQneSVTSxcbaELPnZKd2JqDzMJbMISIOywVPnJLEJ41+7oxglzpoKoVDnu87iPleOqqVqnzjIDOR6jX4te6d+EC6j59ts3PhEhkE9/JupC36/MlAulvO0I3v4lw6ocdcXwDqfd8rpJ5lxefJkvyV3fQ1HkuPPWvT04pxSLPUeNcL3FCF40SDWa8Zt20YCFl976q+Kb6x2VWn/fURqTxkqshetZ3s1JHySUSTth3NXMd+53NX2fGWNK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hidAdPdzkEpK/e/fJQSeFOby+oop34J6oEDhBtSY+qM=;
 b=cOtGS8ecB2qHjb/maer31BrfZ9GcnSxalIL4/4Lh21t6OHxM5h+XtMlYnjfmXvBvEMVPee+LuapmHUrQMrQejZS2cy6pYVvm/yrMlGnc+BRz0eGy/Q6CCHoFNRIA4l3KjVOKyBXJlLvk4tf19tGG82V9Ot685GYDCT2GkIdpdDHE69vjeDP/zXETyGd4b4AhtfBmEV6c4cxe25XAqNrBblyTtyRSDhlKs4rbgmlqglRpuus6BBo54eXUyge8y/4OZi9StBtWkypZe8HVJSQEMp+MXQHII9sLy7KsdP8XhJbyc2x9hWnueqrG8cXE9aKqdwJo+nbpQjvTmYXRoLLwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hidAdPdzkEpK/e/fJQSeFOby+oop34J6oEDhBtSY+qM=;
 b=saF7jt8b7Rcj6V5XK2jzc5Et9K9OChzUxHAunHVyWcC8SXAGFSlVeuUC7FsRiPWnk1aXn/Yqz0gURw5r6HZU9oM4oFnFsXY2/RgcHSWrJ/TOQgv26JNad6cj908Ssb+PFPP+O8mM2pv1QGOXoyM/AD3jrajmeeV9EaP1SLQVPJg=
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com (52.133.13.160) by
 VI1PR04MB5710.eurprd04.prod.outlook.com (20.178.125.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.28; Wed, 23 Oct 2019 06:48:24 +0000
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::b835:b58c:26b2:ca8f]) by VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::b835:b58c:26b2:ca8f%7]) with mapi id 15.20.2347.030; Wed, 23 Oct 2019
 06:48:24 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm: Remove duplicated machine
 compatible
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mm: Remove duplicated machine
 compatible
Thread-Index: AQHViWxjRVElS5Fll02b6XXQulFHGKdnyOGA
Date:   Wed, 23 Oct 2019 06:48:24 +0000
Message-ID: <1b7a2290851c051236eb66263a10ca96cc54b3a1.camel@nxp.com>
References: <1571812481-28308-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1571812481-28308-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fabd60c7-f2c5-479a-5ae0-08d757850051
x-ms-traffictypediagnostic: VI1PR04MB5710:|VI1PR04MB5710:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5710A8314EC291A7F38B4E10F96B0@VI1PR04MB5710.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(199004)(189003)(11346002)(2201001)(2906002)(36756003)(446003)(316002)(486006)(86362001)(110136005)(3846002)(6116002)(5660300002)(229853002)(25786009)(2616005)(476003)(7416002)(44832011)(2501003)(4744005)(6246003)(6506007)(71200400001)(71190400001)(305945005)(91956017)(4001150100001)(118296001)(99286004)(7736002)(76176011)(4326008)(14454004)(76116006)(66446008)(66556008)(64756008)(6436002)(66946007)(66476007)(186003)(6486002)(256004)(14444005)(50226002)(102836004)(81156014)(478600001)(66066001)(8676002)(6512007)(26005)(81166006)(8936002)(99106002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5710;H:VI1PR04MB4094.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /b762f7flnO1RjHqlryzgjThk33hnQz8yR1fLNZFlWADufEFqFE/emuh0YyuDV+LhL0wIYBGGfDyJAFUv6jA/8Y3xod3GlJ+Sv5AFevB3vTve7QMP4IhEPNd+zP4lGM0j1oSUTa69kZlblDSpds1bPP3comC0kNkpFHRG0MeHXL1Agy2qc9B5m/Nq3CyVUPqjaZo9gw9aeJY1dsts+RvJmNabM5fH9U4E/T1EDFKAuCftol/84Vs0/gu6HRmrLKp813pK/YphIL0OVL//wRrceDEtgXbUqRPouH8OdXWFFyJeXiKSW/Vh1uTJMD8feNDcky3tPnrbBwZMMO2QS1IoAldZ1dmHEpFzcQp9sn7e39ULzNGzgj992W4ucxm+r4YjhY8OUYamRoktzamMXWd/XyKM9rE7XQGYccuvYwqqqKnsG1OjNtobsmU8L7F+xXx
Content-Type: text/plain; charset="utf-8"
Content-ID: <006D86FE64EB55448FAD648DE0068501@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabd60c7-f2c5-479a-5ae0-08d757850051
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 06:48:24.2513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tU7Vy1h8fKMu6Z+pAh9VER/906YcYVyV86GXfcD6bWYyskikk3I4j0JZGeVCQOCgi4h5R/g2sv6GXSZ8WpDY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5710
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTIzIGF0IDE0OjM0ICswODAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4g
TWFjaGluZSBjb21wYXRpYmxlIHN0cmluZyBub3JtYWxseSBpcyBsb2NhdGVkIGluIGJvYXJkIERU
LCByZW1vdmUNCj4gdGhlIGR1cGxpY2F0ZWQgb25lIGZyb20gU29DIGR0c2kuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCg0KPiAtLS0NCj4gIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpIHwgMSAtDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1tLmR0c2kNCj4gaW5kZXggOTI1ODE1MC4uNWZmOWI2YiAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gQEAgLTEyLDcgKzEyLDYg
QEANCj4gICNpbmNsdWRlICJpbXg4bW0tcGluZnVuYy5oIg0KPiAgDQo+ICAvIHsNCj4gLQljb21w
YXRpYmxlID0gImZzbCxpbXg4bW0iOw0KPiAgCWludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+
ICAJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ICAJI3NpemUtY2VsbHMgPSA8Mj47DQo=
