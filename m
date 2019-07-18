Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C6CC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8003C205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HPBlUKWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389261AbfGRD3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:29:10 -0400
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:18986
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727601AbfGRD3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:29:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzRlR4+SZKWYSLt3cpDa3RAE801nw64Wfrjr/cVsCeqffV3yZ2XZTHXqYF4kCy83vu+/XV5BDcvetg3fe5iLNGp9T+gCL2mg2aJsoyefifGLY8meOpS9nOAitsrgOsRaUAJiP5f/ez/iyxGXpD1M+/rP8mcXQ+3CvDhT749HNFsFCGD0DGDKCI2l6MmJ+WXV6jzKl9jbIorOooxak9TqLEaQwol1E/rTXejpiuWi9KkOFXyhu8McKhWURlAwCDFrG5VMJc0JUNavAyVdxBORDSESfhUKl4ZUdS3D+O5tOfu5tppE2Id3uUWGhFmRFojPCKbH3oIr2gJPQncQLVL8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TbgJrcGw4l5ov7UeLUe0ybC+oqv2tlXgAe/QEPk/v4=;
 b=fRma4TBGVhZ8kg6FMWgx6uTmn1RrXbPGNzVvhxot9kXHwyFgSTiBTUXn1yQ1O0EsAn4AKZMODKkpGHd8ubDjjs7Y2mt5I1j0R8RqLUJdFQ/w2LdAhhfw1qBHVmhWte+y42YNmhWFaGncanS7pD9cKP+W6c22fEilv5m3Lx6+P44vqsP7t0XNf0c5hFBNL3HQeGkhSkE7crrvsY942DrY8CgswPJDKLAQJjeaebnmlqeWr8wFAsOAlcFHkKVXYUzZpHcZCVJXIb1fwscXv20jR4O7GQ9cZpm4d0nfOufS5rRRn8oVdAoYTsX6D6GQ5pAFtCY6vOmFDZOqBU889IC4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TbgJrcGw4l5ov7UeLUe0ybC+oqv2tlXgAe/QEPk/v4=;
 b=HPBlUKWCZzayI66zY54X1ITmI43eu891fjFYVWiNEmfy+B4gxpSQrzF42Hd63qluKDoYV3odB1vFN1dWomX45yn/X2hvoSo/YLWVSVWMshCtbyCNsfAL7IUWXaDPVXfPRqaE/9rbpy75q9shBvj28WksfyjWRyp0ccbfmktyS54=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6291.eurprd04.prod.outlook.com (20.179.33.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 18 Jul 2019 03:29:06 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431%7]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 03:29:06 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH 2/3] firmware: imx: scu-pd: Add mu_b side PD range
Thread-Topic: [PATCH 2/3] firmware: imx: scu-pd: Add mu_b side PD range
Thread-Index: AQHVMdIf/A/Nl6mgYkmorW+PMBHFi6bPyyMA
Date:   Thu, 18 Jul 2019 03:29:06 +0000
Message-ID: <AM0PR04MB42114DD325C5DB2E06011A4A80C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190703190404.21136-1-daniel.baluta@nxp.com>
 <20190703190404.21136-3-daniel.baluta@nxp.com>
In-Reply-To: <20190703190404.21136-3-daniel.baluta@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e10935ee-66f1-4d68-19fb-08d70b301698
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6291;
x-ms-traffictypediagnostic: AM0PR04MB6291:
x-microsoft-antispam-prvs: <AM0PR04MB6291AD87C88E0C62CC9DE13380C80@AM0PR04MB6291.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:268;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(199004)(189003)(66476007)(102836004)(53546011)(6116002)(256004)(478600001)(71200400001)(68736007)(25786009)(33656002)(2906002)(55016002)(8936002)(8676002)(6246003)(99286004)(81156014)(54906003)(7736002)(4326008)(26005)(76176011)(3846002)(14454004)(53936002)(74316002)(11346002)(6506007)(64756008)(86362001)(316002)(66946007)(71190400001)(44832011)(7696005)(446003)(6436002)(66556008)(305945005)(76116006)(186003)(476003)(81166006)(486006)(110136005)(9686003)(52536014)(66066001)(229853002)(5660300002)(2501003)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6291;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ep4IcrbBfoT3mdMvO7IfpQUCXMwN3lphUIihIgKkVWJlBw3Hm6MqOsp7TbV38OpBG/yot2zJii+M4NGAlcJYMZ30w3ukV1DteCBt9wOwmQL01G0uh17me5DPZnbnV7ZS5/ec+oM6ldizsFVj2Li9nGnMtg154iqs5OSD6CJpW0njWbJTLUINwN8uQCyj0UmZdE/s/EDVuNYGuruLyjOH5/xUDZL6CtJf6n4XLNOD6CEWFt56Wl7RIlV2cvfaQJnBGl/ci8lxgwo/gtEQIwNMhS0AMlnOLX4ClXWfNqs8+2FcXyCtWCrkviGn1YWza8cUfEc9wQL+5QGXvMO/a82T5wg+MOy87GOEROuHCqhkg4RkIltmCGQ4VSB481JesG2P+wWz+1J0QKqDTi2mV+3D0wYNUgA3LkOzDNmlDvaxK80=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10935ee-66f1-4d68-19fb-08d70b301698
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 03:29:06.0467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBKdWx5IDQsIDIwMTkgMzowNCBBTQ0KPiBTdWJqZWN0OiBbUEFUQ0ggMi8zXSBmaXJt
d2FyZTogaW14OiBzY3UtcGQ6IEFkZCBtdV9iIHNpZGUgUEQgcmFuZ2UNCj4gDQo+IExTSU8gc3Vi
c3lzdGVtIGNvbnRhaW5zIDE0IE1VIGluc3RhbmNlcy4NCj4gDQo+IDUgTVVzIHRvIGNvbW11bmlj
YXRlIGJldHdlZW4gQVAgPC0+IFNDVQ0KPiAgIC0gc2lkZS1BIFBEIHJhbmdlIG1hbmFnZWQgYnkg
QVANCj4gICAtIHNpZGUtQiBQRCByYW5nZSBtYW5hZ2VkIGJ5IFNDVQ0KPiANCj4gOSBNVXMgdG8g
Y29tbXVuaWNhdGUgYmV0d2VlbiBBUCA8LT4gTTQNCg0KVGhlIGxlZnQgOU1VcyBhcmUgZ2VuZXJh
bCBhbmQgY2FuIGJlIHVzZWQgYnkgYWxsIGNvcmVzLA0KZS5nIEFQL000L0RTUC4NClNvIGJlbG93
IGRlc2NyaXB0aW9uIGlzIG5vdCBjb3JyZWN0Lg0KDQo+ICAgLSBzaWRlLUEgUEQgcmFuZ2UgbWFu
YWdlZCBieSBBUA0KPiAgIC0gc2lkZS1CIFBEIHJhbmdlIG1hbmFnZWQgYnkgQVANCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2Zpcm13YXJlL2lteC9zY3UtcGQuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9p
bXgvc2N1LXBkLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9zY3UtcGQuYw0KPiBpbmRleCA5NTBk
MzAyMzgxODYuLjMwYWRjMzEwNDM0NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9p
bXgvc2N1LXBkLmMNCj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMNCj4gQEAg
LTkzLDYgKzkzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfc2NfcGRfcmFuZ2UNCj4gaW14
OHF4cF9zY3VfcGRfcmFuZ2VzW10gPSB7DQo+ICAJeyAia3BwIiwgSU1YX1NDX1JfS1BQLCAxLCBm
YWxzZSwgMCB9LA0KPiAgCXsgImZzcGkiLCBJTVhfU0NfUl9GU1BJXzAsIDIsIHRydWUsIDAgfSwN
Cj4gIAl7ICJtdV9hIiwgSU1YX1NDX1JfTVVfMEEsIDE0LCB0cnVlLCAwIH0sDQo+ICsJeyAibXVf
YiIsIElNWF9TQ19SX01VXzVCLCA5LCB0cnVlLCAwIH0sDQoNClNob3VsZCBzdGFydCBmcm9tIDU/
DQp7ICJtdV9iIiwgSU1YX1NDX1JfTVVfNUIsIDksIHRydWUsIDUgfSwNCg0KUmVnYXJkcw0KQWlz
aGVuZw0KDQo+IA0KPiAgCS8qIENPTk4gU1MgKi8NCj4gIAl7ICJ1c2IiLCBJTVhfU0NfUl9VU0Jf
MCwgMiwgdHJ1ZSwgMCB9LA0KPiAtLQ0KPiAyLjE3LjENCg0K
