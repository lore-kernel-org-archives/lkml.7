Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC21C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FEC20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kCWf423N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfEOL4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:56:30 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:1606
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730720AbfEOL41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9czvIIreUmdJTxciZdE7mshvJdk9XLtrT/Jn7tGL0uI=;
 b=kCWf423Nwn06vX71OCg+pAwbtFA+jwXwOcY4n7jSdG8Te2f6uc9xQhX7ReG5s4Me3QrZ8/seATWOhV8UBthPZrcLG9RIqLAzCY52+BV8abFVj/gUJenEaCHp690rQZJWXqIxFQDhpUv+0yiUZ/+bBDcmqNvKJShe32rNTrmZ2xs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3723.eurprd04.prod.outlook.com (52.134.72.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 11:56:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 11:56:23 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH V2 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVCvixb1MFrIDHlECOalYM+lyDeaZsEfMAgAACb0A=
Date:   Wed, 15 May 2019 11:56:23 +0000
Message-ID: <DB3PR0402MB3916FA535853AE7C0438FF8AF5090@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1557908823-11349-1-git-send-email-Anson.Huang@nxp.com>
 <CAEnQRZAL4BuHP8MDDBfOXTcub8LVdZ-CyZxdzt-5dseVjMMDQA@mail.gmail.com>
In-Reply-To: <CAEnQRZAL4BuHP8MDDBfOXTcub8LVdZ-CyZxdzt-5dseVjMMDQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f50f54a2-b327-4a5d-b5d5-08d6d92c5a4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3723;
x-ms-traffictypediagnostic: DB3PR0402MB3723:
x-microsoft-antispam-prvs: <DB3PR0402MB3723AF7FC10265086C21C44FF5090@DB3PR0402MB3723.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(366004)(13464003)(189003)(199004)(76176011)(26005)(81166006)(6506007)(81156014)(7736002)(305945005)(8936002)(66446008)(99286004)(68736007)(53546011)(33656002)(8676002)(7696005)(186003)(76116006)(2906002)(52536014)(5660300002)(102836004)(73956011)(66946007)(44832011)(486006)(476003)(446003)(11346002)(71200400001)(71190400001)(256004)(66476007)(229853002)(6116002)(55016002)(6436002)(316002)(3846002)(478600001)(14454004)(66556008)(64756008)(4326008)(54906003)(6916009)(7416002)(9686003)(74316002)(53936002)(6246003)(25786009)(86362001)(66066001)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3723;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6BQvf8T4pqJorPKbRAE+arlMKPG6wo8Jbqs5ETeye9Vmg/aORLSD5VSoMB+fugD3W5OdrqzieoExh4J8LD7S5bxuoqwyY7LCrApoLSuqjoU4NUTqiq06MRzlAdPCpVocPnGElC+4zFTXOfoXPockHbYDFm1TlfhlAvQEpjzbD0o6yBtAo7zL+mqX2o+vrU3Te9Lye3Yg9ORZj5PfttjlrMAszwwTZMA65T44t9ShvDubUTrTlmf7VU0GrUGrmrXZPRKTfgAEwTOpC9lgXWWFcEsFQhWI6PkfGfMXk7iHdecgcWV2tjUXXlv185l4szr9e0JPzrY2KeQF0ls0O2mANucbBtfYzWhHIigpRlwQCxOd3ntXrmjdypLAqUQU6xv3hG+WwnyKgPfL8JawIo0rWvw9ksDEew7CFJmL/Tz6/bw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50f54a2-b327-4a5d-b5d5-08d6d92c5a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 11:56:23.5328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIEJhbHV0YSBb
bWFpbHRvOmRhbmllbC5iYWx1dGFAZ21haWwuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAx
NSwgMjAxOSA3OjQ3IFBNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4N
Cj4gQ2M6IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOw0KPiBz
aGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgYWdyb3NzQGtlcm5lbC5vcmc7IG1heGlt
ZS5yaXBhcmRAYm9vdGxpbi5jb207DQo+IG9sb2ZAbGl4b20ubmV0OyBob3JtcytyZW5lc2FzQHZl
cmdlLm5ldC5hdTsNCj4gamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207IGJqb3JuLmFuZGVyc3Nv
bkBsaW5hcm8ub3JnOyBMZW9uYXJkIENyZXN0ZXoNCj4gPGxlb25hcmQuY3Jlc3RlekBueHAuY29t
PjsgbWFyYy53LmdvbnphbGV6QGZyZWUuZnI7DQo+IGRpbmd1eWVuQGtlcm5lbC5vcmc7IGVucmlj
LmJhbGxldGJvQGNvbGxhYm9yYS5jb207DQo+IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IEFiZWwg
VmVzYSA8YWJlbC52ZXNhQG54cC5jb20+OyByb2JoQGtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
ZGwtbGludXgtDQo+IGlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggVjIgMS8yXSBzb2M6IGlteDogQWRkIFNDVSBTb0MgaW5mbyBkcml2ZXIgc3VwcG9ydA0KPiAN
Cj4gSGkgQW5zb24sDQo+IA0KPiBTaW5jZSB5b3UgYXJlIGdvaW5nIHRvIHNlbmQgYSBuZXcgdmVy
c2lvbiBmb3IgdGhpcyBwbGVhc2UgY29uc2lkZXIgbXkNCj4gY29tbWVudCBpbmxpbmUuDQo+IA0K
PiA8c25pcD4NCj4gDQo+ID4gK3N0YXRpYyB1MzIgaW14OHF4cF9zb2NfcmV2aXNpb24odm9pZCkg
ew0KPiA+ICsgICAgICAgc3RydWN0IGlteF9zY19tc2dfbWlzY19nZXRfc29jX2lkIG1zZzsNCj4g
PiArICAgICAgIHN0cnVjdCBpbXhfc2NfcnBjX21zZyAqaGRyID0gJm1zZy5oZHI7DQo+ID4gKyAg
ICAgICB1MzIgcmV2ID0gMDsNCj4gDQo+IE5vIG5lZWQgdG8gaW5pdGlhbGl6ZSB0aGlzIGhlcmUu
DQo+IA0KPiA+ICsgICAgICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgICAgICBoZHItPnZlciA9
IElNWF9TQ19SUENfVkVSU0lPTjsNCj4gPiArICAgICAgIGhkci0+c3ZjID0gSU1YX1NDX1JQQ19T
VkNfTUlTQzsNCj4gPiArICAgICAgIGhkci0+ZnVuYyA9IElNWF9TQ19NSVNDX0ZVTkNfR0VUX0NP
TlRST0w7DQo+ID4gKyAgICAgICBoZHItPnNpemUgPSAzOw0KPiA+ICsNCj4gPiArICAgICAgIG1z
Zy5kYXRhLnNlbmQuY29udHJvbCA9IElNWF9TQ19DX0lEOw0KPiA+ICsgICAgICAgbXNnLmRhdGEu
c2VuZC5yZXNvdXJjZSA9IElNWF9TQ19SX1NZU1RFTTsNCj4gPiArDQo+ID4gKyAgICAgICByZXQg
PSBpbXhfc2N1X2NhbGxfcnBjKHNvY19pcGNfaGFuZGxlLCAmbXNnLCB0cnVlKTsNCj4gPiArICAg
ICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAgICAgICAgICAgZGV2X2VycigmaW14X3NjdV9zb2Nf
cGRldi0+ZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICJnZXQgc29jIGluZm8gZmFp
bGVkLCByZXQgJWRcbiIsIHJldCk7DQo+ID4gKyAgICAgICAgICAgICAgIC8qIHJldHVybiAwIG1l
YW5zIGdldHRpbmcgcmV2aXNpb24gZmFpbGVkICovDQo+IA0KPiBKdXN0IHJldHVybiAwIGhlcmUu
IE5vIG5lZWQgZm9yIHJldi4NCg0KT0ssIHRoYW5rcy4NCg0KQW5zb24uDQoNCj4gPiArICAgICAg
ICAgICAgICAgcmV0dXJuIHJldjsNCj4gPiArICAgICAgIH0NCj4gPiArDQo=
