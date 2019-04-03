Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CC6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5772084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B1DIgmrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfDCIdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:33:35 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:13891
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbfDCIde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uG9QonISTyc0r/liuhIf3Xgj4x828Fpk5G3pmOhUdc=;
 b=B1DIgmrbRq7cufVJqabC6FlJLcw2Qf0gucM9UL2K2nrXItqEHhDqhhAoYzQjw/moUahc7T7xqKlmR9fmgYD8oSGsjWxiJnlhzJ4hJjCySvWdqtuOPteGYDlsQq0ACUVzcruttBnm1kypj5DAFflATg5EHP+GwDvSHYYOlF9ITIA=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5597.eurprd04.prod.outlook.com (20.178.125.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Wed, 3 Apr 2019 08:33:29 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::2980:9bad:dad5:b9a0]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::2980:9bad:dad5:b9a0%2]) with mapi id 15.20.1750.021; Wed, 3 Apr 2019
 08:33:29 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Andy Tang <andy.tang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: RE: [PATCH v1 4/4] clk: qoriq: Add clockgen support for lx2160a
Thread-Topic: [PATCH v1 4/4] clk: qoriq: Add clockgen support for lx2160a
Thread-Index: AQHUzbuXu37W8f+1a0WjYnXw55qsUKXymYaAgDe6Q9A=
Importance: high
X-Priority: 1
Date:   Wed, 3 Apr 2019 08:33:29 +0000
Message-ID: <VI1PR04MB48009D9A1F92BF55DCFD0DEFF3570@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
         <1551132245-6089-5-git-send-email-vabhav.sharma@nxp.com>
 <9aef7eea60ccf4a4aaa65e46e17b615aa73b5caf.camel@buserror.net>
In-Reply-To: <9aef7eea60ccf4a4aaa65e46e17b615aa73b5caf.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a61caec5-2616-4d32-791c-08d6b80f0cc8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5597;
x-ms-traffictypediagnostic: VI1PR04MB5597:
x-microsoft-antispam-prvs: <VI1PR04MB559751DD64B4BFF097A3204CF3570@VI1PR04MB5597.eurprd04.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(13464003)(446003)(5660300002)(99286004)(71190400001)(476003)(33656002)(9686003)(6246003)(186003)(229853002)(110136005)(97736004)(25786009)(8676002)(2906002)(81166006)(6436002)(4326008)(8936002)(53936002)(11346002)(81156014)(54906003)(6116002)(44832011)(316002)(53546011)(68736007)(105586002)(7736002)(3846002)(102836004)(26005)(86362001)(66066001)(106356001)(256004)(2501003)(478600001)(74316002)(6506007)(76176011)(71200400001)(14454004)(55016002)(52536014)(81686011)(2201001)(305945005)(7696005)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5597;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FGdjN/bXSj3e7cEyNt3GTyFikLqRIrJ5hxPDQIMy9jvaxBtdQ1fANPbVemJODo8Rd2zTnZd8Mk2+ne7c+Hq+t4Ng02y+0ngErbkuyF0hWKH+c/un6yV8acaCM9pfdzhEtqc0X3xcjcSOTPYuSY02U/SK5XGhkYZLitYpU9mhZCrIVg/rkUW1kiDsVj9UXCOzFSD9lVDx2bIaqDKAqqa934X+Mr0ZdBLA875pyOpfK2suXBdeLb0RBEp8OJWc6lwsgrz/K1gwKHdhKnDhSFRb3Gc53mY4nSkekg6JL553uljlBloyiZeDCiA/Jh6Ek+hyYNDTlnXH7TepX/FW3q0L3iozDYsOwLlm4I1QC+QRJd5V13fq3ZaeM/hoxM2kG9iGifP51aroPjKRR2fNkPSWbxbuu3iN8+0yOcBqG+dZI8Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61caec5-2616-4d32-791c-08d6b80f0cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 08:33:29.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5597
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWFpbnRhaW5lcnMsDQpQbGVhc2UgbWVyZ2UgYmVsb3cgcGF0Y2guDQoNClJlZ2FyZHMs
DQpWYWJoYXYNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBkZXZpY2V0
cmVlLW93bmVyQHZnZXIua2VybmVsLm9yZyA8ZGV2aWNldHJlZS1vd25lckB2Z2VyLmtlcm5lbC5v
cmc+DQo+IE9uIEJlaGFsZiBPZiBTY290dCBXb29kDQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVh
cnkgMjcsIDIwMTkgMzowMCBBTQ0KPiBUbzogVmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBu
eHAuY29tPjsgc3VkZWVwLmhvbGxhQGFybS5jb207DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7
IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsNCj4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBtdHVycXVldHRlQGJheWxpYnJl
LmNvbTsNCj4gc2JveWRAa2VybmVsLm9yZzsgcmp3QHJqd3lzb2NraS5uZXQ7IHZpcmVzaC5rdW1h
ckBsaW5hcm8ub3JnOyBsaW51eC0NCj4gY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWwtDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZzsgY2F0
YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207DQo+IGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnOyBhcm5kQGFybmRiLmRlOw0KPiBrc3Rld2FydEBsaW51eGZvdW5kYXRp
b24ub3JnOyB5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbTsgTGVvIExpDQo+IDxsZW95YW5n
LmxpQG54cC5jb20+OyBzaGF3bmd1b0BrZXJuZWwub3JnDQo+IENjOiBsaW51eEBhcm1saW51eC5v
cmcudWs7IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOw0KPiB1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
OyBZb2dlc2ggTmFyYXlhbiBHYXVyDQo+IDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT47IEFu
ZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgNC80
XSBjbGs6IHFvcmlxOiBBZGQgY2xvY2tnZW4gc3VwcG9ydCBmb3IgbHgyMTYwYQ0KPiANCj4gT24g
VHVlLCAyMDE5LTAyLTI2IGF0IDEwOjExICswMDAwLCBWYWJoYXYgU2hhcm1hIHdyb3RlOg0KPiA+
IEZyb206IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCj4gPg0KPiA+
IEFkZCBjbG9ja2dlbiBzdXBwb3J0IGZvciBseDIxNjBhLg0KPiA+IEFkZGVkIGVudHJ5IGZvciBj
b21wYXQgJ2ZzbCxseDIxNjBhLWNsb2NrZ2VuJy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRh
bmcgWXVhbnRpYW4gPGFuZHkudGFuZ0BueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvZ2Vz
aCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBW
YWJoYXYgU2hhcm1hIDx2YWJoYXYuc2hhcm1hQG54cC5jb20+DQo+ID4gQWNrZWQtYnk6IFN0ZXBo
ZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4gPiBBY2tlZC1ieTogVmlyZXNoIEt1bWFyIDx2
aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jbGsvY2xrLXFv
cmlxLmMgICAgICAgICB8IDEyICsrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL2NwdWZyZXEvcW9y
aXEtY3B1ZnJlcS5jIHwgIDEgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KykNCj4gDQo+IEFja2VkLWJ5OiBTY290dCBXb29kIDxvc3NAYnVzZXJyb3IubmV0Pg0KPiANCj4g
LVNjb3R0DQo+IA0KDQo=
