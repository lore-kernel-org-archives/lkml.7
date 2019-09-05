Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B2CC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28522173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cwZL6L8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbfIEHwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:52:39 -0400
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:35334
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729366AbfIEHwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:52:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfAj7lGITKEsoy9pfh+XuBAyj8pPDO5kF96Qo0c+D7wjbeKvgKUJQa048lNesS3TsiUt6ood4uPifV6ojxbBEShPdn0Upo16j6/gAPgtMQ/fk7Qs4yQHISftm9+09ytFR+ZYdmVuQ5rP4Do7F/jQoIukvE6hx2hU65kYD0DpJB4lLIyUxvoRdo2H1fhcI7UfT+JJLOUxpWC5BYYUxrQ84zW3380QHZ6LS86+UNnuCnD81v+l4FgJ/Ndzm5uOecXqRFmO1YBQMP4Ru3zIqWdB2FlCeRhh4ZSNL8D/PrxNfvGIdBJ8a3oaXcbtAevj3Rmo4D3+AdO/OLvGKslxwolWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQLqvk79EUKMr9LYXVcDfX8PLWyOxSgwN5hGT/140MM=;
 b=exmVlUFcG2RbZe7M6/ORCBxgV/9KuZVTfpYfLV1bjQdiLHPn/C3V4AN6qMfJle8mGMMDBULSobo/h+ZxbMDt33KD72DPFFksODSBlMsh7Ze4uXD8KtA8pCFEr3xtu03IuLX4w5e2X6gcNvsup6p2kO8hsmWNbuiQhosvgC+46VHsVQ//gDgMVe8WAPdOF+0xa7vUapYZE7N21jgzLz0utvNfoEE2HlA8TYjjXoMw+egeO58U44Ao8hoaT8bJPDw44AL1ZBwgKcXkY+SGxi3VpdRkhbaA9uxDNOO5BS8X+N5bH6gFUhJwvqqxMSfdpVaJVi7YqJWu4MP+my506bLNNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQLqvk79EUKMr9LYXVcDfX8PLWyOxSgwN5hGT/140MM=;
 b=cwZL6L8f4PD6zxQ4vNkisy+5qzfz4rxNUP7SgiKwH2HMWOl0DLaGUM8HS6O3vkfg4UBgz4A9YrdjesfZP1o/hvkf9yoc/E0boHFr5Sx64kSdBLJqf2wvtnx++bGfQV24e31Ge+v4ZLWx5gqz9Wj5BOGy16fIybMcCz/7j8HRFFA=
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com (52.133.13.160) by
 VI1PR04MB3165.eurprd04.prod.outlook.com (10.170.229.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 5 Sep 2019 07:52:31 +0000
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::6ced:919:ea4f:5000]) by VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::6ced:919:ea4f:5000%6]) with mapi id 15.20.2241.014; Thu, 5 Sep 2019
 07:52:31 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     dl-linux-imx <linux-imx@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH -next] ASoC: SOF: imx8: Fix COMPILE_TEST error
Thread-Topic: [PATCH -next] ASoC: SOF: imx8: Fix COMPILE_TEST error
Thread-Index: AQHVY7VbB4D3lAJHKUqwCvNT4h8v+Kcctk8A
Date:   Thu, 5 Sep 2019 07:52:29 +0000
Message-ID: <4264c89ddbcff9d67498bc9d89ec4f1826819f46.camel@nxp.com>
References: <20190905064400.24800-1-yuehaibing@huawei.com>
In-Reply-To: <20190905064400.24800-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f65588a-407c-4bb1-12d5-08d731d60166
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3165;
x-ms-traffictypediagnostic: VI1PR04MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB316549629C5742A69A189254F9BB0@VI1PR04MB3165.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(478600001)(229853002)(66066001)(86362001)(3846002)(14454004)(2201001)(2906002)(6116002)(6506007)(4326008)(6246003)(6486002)(118296001)(36756003)(25786009)(446003)(6436002)(11346002)(2616005)(186003)(53936002)(66446008)(64756008)(66556008)(66476007)(44832011)(6512007)(76116006)(91956017)(476003)(66946007)(2501003)(71190400001)(71200400001)(486006)(7416002)(102836004)(5660300002)(256004)(14444005)(26005)(81156014)(8676002)(305945005)(81166006)(316002)(99286004)(110136005)(7736002)(54906003)(76176011)(8936002)(50226002)(99106002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3165;H:VI1PR04MB4094.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H0oCHBkrKTpxB8lE6dJb/VAOqsb2qjfXSggCiA70HXAtuIb+lTg7D9AHau0gxV2t1FsuYArp5m9+ARXgsKWHVQKXZJxWqusaT7E1en/gewCiaFsTClQewHVneeFjVa9yFbbFo6ycqJ2wfFqJfA/Aps9gPPTzxneWq9QZD85bbyUa8s+Nd9X4DPhQzV2U7NpBJZ0BL8+TwRFJPo+Mg0uAkVzfIYVIX/OquNbYAVqdk/Umf64e6gt6+AADowx+7l7D3Ukq6bzgotLIRqxYDCXkJyGXujpgNuiX8baO1nHdBEC3SgObV653oqXSWYrO9zdPpMGHaj64UgCOaLrjMx1wzQr2Ju7TKIghLhSgAspAm299mbpFoE6nB9Z0YXUFpv0sA+psipprmB/EZEfPMR93eF3R5FVsJfvS39Fz7hgp4xg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62718A8F03EE39469AC1D348B4132E3C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f65588a-407c-4bb1-12d5-08d731d60166
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 07:52:29.7612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t35Mye64P8YOO4B/5KYt85v5cg7ngXUkv51z5CA4NT84if2ZOWCZ99ujE/VY/TiFP5kLQtmmaBr0kkQN9Nx37A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTA1IGF0IDE0OjQ0ICswODAwLCBZdWVIYWliaW5nIHdyb3RlOg0KPiBX
aGVuIGRvIGNvbXBpbGUgdGVzdCwgaWYgU05EX1NPQ19TT0ZfT0YgaXMgbm90IHNldCwgd2UgZ2V0
Og0KPiANCj4gc291bmQvc29jL3NvZi9pbXgvaW14OC5vOiBJbiBmdW5jdGlvbiBgaW14OF9kc3Bf
aGFuZGxlX3JlcXVlc3QnOg0KPiBpbXg4LmM6KC50ZXh0KzB4YjApOiB1bmRlZmluZWQgcmVmZXJl
bmNlIHRvIGBzbmRfc29mX2lwY19tc2dzX3J4Jw0KPiBzb3VuZC9zb2Mvc29mL2lteC9pbXg4Lm86
IEluIGZ1bmN0aW9uIGBpbXg4X2lwY19tc2dfZGF0YSc6DQo+IGlteDguYzooLnRleHQrMHhmNCk6
IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHNvZl9tYWlsYm94X3JlYWQnDQo+IHNvdW5kL3NvYy9z
b2YvaW14L2lteDgubzogSW4gZnVuY3Rpb24gYGlteDhfZHNwX2hhbmRsZV9yZXBseSc6DQo+IGlt
eDguYzooLnRleHQrMHgxNjApOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBzb2ZfbWFpbGJveF9y
ZWFkJw0KPiANCj4gTWFrZSBTTkRfU09DX1NPRl9JTVhfVE9QTEVWRUwgYWx3YXlzIGRlcGVuZHMg
b24gU05EX1NPQ19TT0ZfT0YNCj4gDQo+IFJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lA
aHVhd2VpLmNvbT4NCj4gRml4ZXM6IDIwMmFjYzU2NWExZiAoIkFTb0M6IFNPRjogaW14OiBBZGQg
aS5NWDggSFcgc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJp
bmdAaHVhd2VpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1
dGFAbnhwLmNvbT4NCg0KPiAtLS0NCj4gIHNvdW5kL3NvYy9zb2YvaW14L0tjb25maWcgfCAzICsr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zb2YvaW14L0tjb25maWcgYi9zb3VuZC9zb2Mvc29m
L2lteC9LY29uZmlnDQo+IGluZGV4IGZkNzNkODQuLjVhY2FlNzUgMTAwNjQ0DQo+IC0tLSBhL3Nv
dW5kL3NvYy9zb2YvaW14L0tjb25maWcNCj4gKysrIGIvc291bmQvc29jL3NvZi9pbXgvS2NvbmZp
Zw0KPiBAQCAtMiw3ICsyLDggQEANCj4gIA0KPiAgY29uZmlnIFNORF9TT0NfU09GX0lNWF9UT1BM
RVZFTA0KPiAgCWJvb2wgIlNPRiBzdXBwb3J0IGZvciBOWFAgaS5NWCBhdWRpbyBEU1BzIg0KPiAt
CWRlcGVuZHMgb24gQVJNNjQgJiYgU05EX1NPQ19TT0ZfT0YgfHwgQ09NUElMRV9URVNUDQo+ICsJ
ZGVwZW5kcyBvbiBBUk02NHx8IENPTVBJTEVfVEVTVA0KPiArCWRlcGVuZHMgb24gU05EX1NPQ19T
T0ZfT0YNCj4gIAloZWxwDQo+ICAgICAgICAgICAgVGhpcyBhZGRzIHN1cHBvcnQgZm9yIFNvdW5k
IE9wZW4gRmlybXdhcmUgZm9yIE5YUCBpLk1YDQo+IHBsYXRmb3Jtcy4NCj4gICAgICAgICAgICBT
YXkgWSBpZiB5b3UgaGF2ZSBzdWNoIGEgZGV2aWNlLg0K
