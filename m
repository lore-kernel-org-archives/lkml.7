Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EA2CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508B42084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K79/iDQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbfJWGrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:47:24 -0400
Received: from mail-eopbgr20075.outbound.protection.outlook.com ([40.107.2.75]:37346
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbfJWGrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:47:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HN9K3MnQ63qqaP4HpChs76bNFqQMO6gi4uIWSQS0q5XLeMMWldztXiMiUXpKQZNvTcofR2pcrpUgc9Y5wikXJ3w4ZkiMhbp8a+gV7HO5besjd/IS1hXXVYm4ITDrTaUuAS4k9MMwCkn14MbMxWX/GgTX6t4gProCCpGQpWPUj/h4RT2PthahOK5gyt6Bj4KZk3ChNKSDUIXHp10NVs8pQF4/kKjG2/DTzWwCGdRby4sgHhNYfLDpWIjAFVhHpaA9vevjVOienpGtVR6Jsdl4Z4jZ1YdRarkX1NL2XqRes9GuL/0W83LgqIoTwBhIOtG3v9WUGUvdxUFVE9PiYIEiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3D3w+S36N9OlDu0Hq2S2Xj/LiUgg2sXTDH6hem3Cn0=;
 b=EWMKq3D8ne3mbolVjisb6M1hq+S2cY+5i06OScj0FAkmdilCdOfNqXlEy0ivcDavAUaUov6avnqEAZ+1H/9LHiOlvsT9+hoIVUkwVw82W5QY3KGEPy1WPvkkpgsvFtqZ7SA2/h+4pgM1PsKIe8lKRmqVSmL4tv7BdorUfSApvJj8tQ4nP212xug4M+zNJ//aDPQDb+LaPVFDmF57vmslQCbFTHRQwt3rE/AObF9H3cO5cI/EqDqpo0f5MAeu5U6hn8ltkZJ9+2+XmMyAmMHisLthK9kwdCw/yZKFFfVNx65BsczcCf/APAaKDE6Aunm/1cXNWA6749Hl1vibjU9xVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3D3w+S36N9OlDu0Hq2S2Xj/LiUgg2sXTDH6hem3Cn0=;
 b=K79/iDQs/edDeVkLYG/8xTEmDhTVPKaQmHezqgwPADFtnS+qJyojtqQuUF43k7IPCKTQv71yZmr/8c6HKpAphgv6yiJQEAGlrT0uCRlk2kyAI4TgRyYC40DbC0hD3jIJUfi2iYBngI51FA501ubQXm+2ZmM2vI/9QiSS7hcetuk=
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com (52.133.13.160) by
 VI1PR04MB5903.eurprd04.prod.outlook.com (20.178.205.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.21; Wed, 23 Oct 2019 06:47:19 +0000
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::b835:b58c:26b2:ca8f]) by VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::b835:b58c:26b2:ca8f%7]) with mapi id 15.20.2347.030; Wed, 23 Oct 2019
 06:47:19 +0000
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
Subject: Re: [PATCH 2/2] arm64: dts: imx8mn: Remove duplicated machine
 compatible
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mn: Remove duplicated machine
 compatible
Thread-Index: AQHViWxkvmnb0NFVUUmALMBBLKBKQqdnyJSA
Date:   Wed, 23 Oct 2019 06:47:19 +0000
Message-ID: <350019d21e2e4f2d6e815b1d08a270eb69811441.camel@nxp.com>
References: <1571812481-28308-1-git-send-email-Anson.Huang@nxp.com>
         <1571812481-28308-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1571812481-28308-2-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: deef5a8b-3ea9-4c29-b7a9-08d75784d9bf
x-ms-traffictypediagnostic: VI1PR04MB5903:|VI1PR04MB5903:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5903A1040B2090D5C6FD0CC1F96B0@VI1PR04MB5903.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(186003)(316002)(8676002)(110136005)(81166006)(50226002)(2501003)(305945005)(76176011)(102836004)(81156014)(26005)(99286004)(118296001)(8936002)(7736002)(6506007)(5660300002)(71200400001)(71190400001)(6512007)(2201001)(36756003)(86362001)(6436002)(6246003)(4326008)(256004)(14444005)(91956017)(229853002)(6486002)(6116002)(4001150100001)(3846002)(4744005)(2906002)(25786009)(66066001)(14454004)(478600001)(44832011)(66946007)(2616005)(64756008)(66476007)(446003)(66446008)(76116006)(476003)(486006)(7416002)(66556008)(11346002)(99106002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5903;H:VI1PR04MB4094.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q01YBo0ZoqCPaqjfjjObqcD4OIVMO68EqzuztUm186HZn+InJyGVkO1FjMQKRmlqAqwAn5LpwkuckYylCD73PGlLxfgNXkEgpA9FaWfR1ovbQu7cGak6x9WPfp8f7wB6L+Dq7J14CZZgQaIIRgrn5VEuAauS0euIh5BXQnR4SxLyGUrLxcVtshNXHK0gz8wBMADgVX0OoAMYJ0t0e+AtJY7X5uMYZ853PImZHgqS8gWlacpdDOy50lI1lceEGXNJEvy+sAaiQVkveBuqRkpp9WH87Xt8SUxqBZDU3STc88SjV0syHWe1cvOD3jEHxJUtRorFqQJ/eHFX5WipHNhvVfopZT11406OvvJo+YFWUEsg0OoaqpzmnEQ9akptpk8NuxqIXj93BwuRsrGJlNpTmqmk2ImLwPYg2K5g7tnNRMQJUqZXghM81fBh2u5azBgY
Content-Type: text/plain; charset="utf-8"
Content-ID: <C600F8888CCD2747AED605AFA5A3A1D2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deef5a8b-3ea9-4c29-b7a9-08d75784d9bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 06:47:19.5714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Flv2SD9tjirToarQyADJqR1Oc/mFy+JjxgYowt+ZRU3Lb+2hRjj1UJS28kDg0UhsLeroiTl63tLXgJpYsdoYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTIzIGF0IDE0OjM0ICswODAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4g
TWFjaGluZSBjb21wYXRpYmxlIHN0cmluZyBub3JtYWxseSBpcyBsb2NhdGVkIGluIGJvYXJkIERU
LCByZW1vdmUNCj4gdGhlIGR1cGxpY2F0ZWQgb25lIGZyb20gU29DIGR0c2kuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCg0KPiAtLS0NCj4gIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi5kdHNpIHwgMSAtDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbi5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1uLmR0c2kNCj4gaW5kZXggNDZjMjE4ZS4uNzM0MTU0OSAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gQEAgLTExLDcgKzExLDYg
QEANCj4gICNpbmNsdWRlICJpbXg4bW4tcGluZnVuYy5oIg0KPiAgDQo+ICAvIHsNCj4gLQljb21w
YXRpYmxlID0gImZzbCxpbXg4bW4iOw0KPiAgCWludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+
ICAJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ICAJI3NpemUtY2VsbHMgPSA8Mj47DQo=
