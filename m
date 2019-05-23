Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E14C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185E020675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aPFoUTnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfEWJf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:35:56 -0400
Received: from mail-eopbgr140057.outbound.protection.outlook.com ([40.107.14.57]:31142
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729836AbfEWJfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY7pJIbkluEbMt/+VyZhiElfd+4JG5HAdglHhR/+OFc=;
 b=aPFoUTnzFeDWiP5PeiHRsyc7KOruvwHif6Km7mSnEklJ0f5Xq422/+BLyvn7VeT1ntdfYHuKSixbjnQc6g6Wn3zI9BBvFlwIw9Qo+mzzJGJ7RgoVF8pUsvAecqqa6fFtYak7+YCb79zjiKXm+f4mt5YAq+R9SjiK2w5oyD8ZPHc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3932.eurprd04.prod.outlook.com (52.134.72.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Thu, 23 May 2019 09:35:48 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1922.017; Thu, 23 May 2019
 09:35:48 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH V6 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVESOBOi968fgyqkGLTWjGKVXT0qZ4bDuAgAAF4qA=
Date:   Thu, 23 May 2019 09:35:48 +0000
Message-ID: <DB3PR0402MB3916311773BADACCC5DC3A7CF5010@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1558586911-29309-1-git-send-email-Anson.Huang@nxp.com>
 <20190523090941.zd4rbvcimgit5lq5@shell.armlinux.org.uk>
In-Reply-To: <20190523090941.zd4rbvcimgit5lq5@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25f8706b-244f-44ad-8b76-08d6df620a0a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3932;
x-ms-traffictypediagnostic: DB3PR0402MB3932:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB3PR0402MB3932E970313D0ADEEC06AEB4F5010@DB3PR0402MB3932.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(13464003)(2906002)(316002)(66476007)(66556008)(64756008)(73956011)(66946007)(76116006)(66446008)(7736002)(26005)(305945005)(6116002)(3846002)(53546011)(6506007)(99286004)(186003)(74316002)(8676002)(76176011)(229853002)(8936002)(81156014)(81166006)(6916009)(7696005)(68736007)(55016002)(6306002)(9686003)(6246003)(44832011)(486006)(7416002)(54906003)(6436002)(446003)(11346002)(476003)(33656002)(5660300002)(478600001)(71200400001)(86362001)(4326008)(71190400001)(45080400002)(52536014)(102836004)(14444005)(53936002)(14454004)(966005)(66066001)(25786009)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3932;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ltoM48UUt8e4gK6xnbITEnqt2GioC12SpaHl9h+PNsCqm1mmZgfWtqK2JG6HrDKU5fHaqshKlqlybqBCdmxY3Xpho4odSVO+tB4lkldLkK69tDL+s6Emd6gJUiFCfRkqeePTshxA3YygjsvNBiDGnfmpUmZLSmf5XAJZc+fdJAFv6qZwtq8D5weIbW/AgKkVtMaPnHLv89FaDaFLM6avrNvHepnlWLIeju4aXbftwthaH9pWR1QLIntRsoQdkr1rcwUCbMEDJSr2S6AglZHtaIW3TOMt6Bs82rKbgCj00b2ImFiO4GSkXiUWCs6nuGJlc9FmROwAZoB+FZRZVnZAOeN9nLd2eE/ibDtCe9EHCh/ReOBiciHCT/Q915eZ3zbShSlqulPhmRPwjBTU7ADPWtXUQx9AvW00jtcv9PAxG0g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f8706b-244f-44ad-8b76-08d6df620a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 09:35:48.6107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJ1c3NlbGwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdXNz
ZWxsIEtpbmcgLSBBUk0gTGludXggYWRtaW4gW21haWx0bzpsaW51eEBhcm1saW51eC5vcmcudWtd
DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMjMsIDIwMTkgNToxMCBQTQ0KPiBUbzogQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsg
d2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5n
dXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207
IG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb207IG9sb2ZAbGl4b20ubmV0Ow0KPiBhZ3Jvc3NAa2Vy
bmVsLm9yZzsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+IGJqb3JuLmFuZGVyc3NvbkBs
aW5hcm8ub3JnOyBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsNCj4g
ZGluZ3V5ZW5Aa2VybmVsLm9yZzsgZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsgQWlzaGVu
ZyBEb25nDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEFiZWwgVmVzYSA8YWJlbC52ZXNhQG54
cC5jb20+Ow0KPiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyB0Z2x4QGxpbnV0cm9uaXguZGU7IHJv
YmhAa2VybmVsLm9yZzsNCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggVjYgMS8yXSBzb2M6IGlteDogQWRkIFNDVSBTb0MgaW5mbyBkcml2ZXIgc3VwcG9ydA0KPiAN
Cj4gT24gVGh1LCBNYXkgMjMsIDIwMTkgYXQgMDQ6NTM6NDZBTSArMDAwMCwgQW5zb24gSHVhbmcg
d3JvdGU6DQo+ID4gQWRkIGkuTVggU0NVIFNvQyBpbmZvIGRyaXZlciB0byBzdXBwb3J0IGkuTVg4
UVhQIFNvQywgaW50cm9kdWNlIGRyaXZlcg0KPiA+IGRlcGVuZGVuY3kgaW50byBLY29uZmlnIGFz
IENPTkZJR19JTVhfU0NVIG11c3QgYmUgc2VsZWN0ZWQgdG8gc3VwcG9ydA0KPiA+IGkuTVggU0NV
IFNvQyBkcml2ZXIsIGFsc28gbmVlZCB0byB1c2UgcGxhdGZvcm0gZHJpdmVyIG1vZGVsIHRvIG1h
a2UNCj4gPiBzdXJlIElNWF9TQ1UgZHJpdmVyIGlzIHByb2JlZCBiZWZvcmUgaS5NWCBTQ1UgU29D
IGRyaXZlci4NCj4gDQo+IFRoaXMgc2VlbXMgYnVnZ3kuLi4NCg0KV2UgaGF2ZSB0byB1c2UgcGxh
dGZvcm0gZHJpdmVyIG1vZGVsLCBidXQgdGhlcmUgaXMgbm8gc3VjaCBzb2MgZGV2aWNlIGluIERU
IGZpbGUsDQpzbyB3ZSBjcmVhdGVkIHRoZSBwbGF0Zm9ybSBkZXZpY2UgaW4gdGhpcyBkcml2ZXIg
ZGlyZWN0bHkuDQoNCj4gDQo+ID4gK3N0YXRpYyBpbnQgaW14X3NjdV9zb2NfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsJc3RydWN0IHNvY19kZXZpY2VfYXR0cmli
dXRlICpzb2NfZGV2X2F0dHI7DQo+ID4gKwlzdHJ1Y3Qgc29jX2RldmljZSAqc29jX2RldjsNCj4g
PiArCXUzMiBpZCwgdmFsOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlyZXQgPSBpbXhf
c2N1X2dldF9oYW5kbGUoJnNvY19pcGNfaGFuZGxlKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJ
cmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlzb2NfZGV2X2F0dHIgPSBkZXZtX2t6YWxsb2MoJnBk
ZXYtPmRldiwgc2l6ZW9mKCpzb2NfZGV2X2F0dHIpLA0KPiA+ICsJCQkJICAgIEdGUF9LRVJORUwp
Ow0KPiA+ICsJaWYgKCFzb2NfZGV2X2F0dHIpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4g
Kw0KPiA+ICsJc29jX2Rldl9hdHRyLT5mYW1pbHkgPSAiRnJlZXNjYWxlIGkuTVgiOw0KPiA+ICsN
Cj4gPiArCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfc3RyaW5nKG9mX3Jvb3QsDQo+ID4gKwkJCQkg
ICAgICAibW9kZWwiLA0KPiA+ICsJCQkJICAgICAgJnNvY19kZXZfYXR0ci0+bWFjaGluZSk7DQo+
ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJaWQgPSBpbXhf
c2N1X3NvY19pZCgpOw0KPiA+ICsNCj4gPiArCS8qIGZvcm1hdCBzb2NfaWQgdmFsdWUgcGFzc2Vk
IGZyb20gU0NVIGZpcm13YXJlICovDQo+ID4gKwl2YWwgPSBpZCAmIDB4MWY7DQo+ID4gKwlzb2Nf
ZGV2X2F0dHItPnNvY19pZCA9IHZhbCA/IGthc3ByaW50ZihHRlBfS0VSTkVMLCAiMHgleCIsIHZh
bCkNCj4gPiArCQkJICAgICAgIDogInVua25vd24iOw0KPiANCj4gc29jX2lkIGNhbiBlaXRoZXIg
YmUgYW4gYWxsb2NhdGVkIHN0cmluZywgb3IgaXQgY2FuIGJlIGEgc3RhdGljIHN0cmluZyBvZg0K
PiAidW5rbm93biIuDQo+IA0KPiA+ICsJaWYgKCFzb2NfZGV2X2F0dHItPnNvY19pZCkNCj4gPiAr
CQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwkvKiBmb3JtYXQgcmV2aXNpb24gdmFsdWUg
cGFzc2VkIGZyb20gU0NVIGZpcm13YXJlICovDQo+ID4gKwl2YWwgPSAoaWQgPj4gNSkgJiAweGY7
DQo+ID4gKwl2YWwgPSAoKCh2YWwgPj4gMikgKyAxKSA8PCA0KSB8ICh2YWwgJiAweDMpOw0KPiA+
ICsJc29jX2Rldl9hdHRyLT5yZXZpc2lvbiA9IHZhbCA/IGthc3ByaW50ZihHRlBfS0VSTkVMLA0K
PiA+ICsJCQkJCQkgIiVkLiVkIiwNCj4gPiArCQkJCQkJICh2YWwgPj4gNCkgJiAweGYsDQo+ID4g
KwkJCQkJCSB2YWwgJiAweGYpIDogInVua25vd24iOw0KPiANCj4gcmV2aXNpb24gaGVyZSBpcyB0
aGUgc2FtZS4NCj4gDQo+ID4gKwlpZiAoIXNvY19kZXZfYXR0ci0+cmV2aXNpb24pIHsNCj4gPiAr
CQlyZXQgPSAtRU5PTUVNOw0KPiA+ICsJCWdvdG8gZnJlZV9zb2NfaWQ7DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICsJc29jX2RldiA9IHNvY19kZXZpY2VfcmVnaXN0ZXIoc29jX2Rldl9hdHRyKTsNCj4g
PiArCWlmIChJU19FUlIoc29jX2RldikpIHsNCj4gPiArCQlyZXQgPSBQVFJfRVJSKHNvY19kZXYp
Ow0KPiA+ICsJCWdvdG8gZnJlZV9yZXZpc2lvbjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1
cm4gMDsNCj4gPiArDQo+ID4gK2ZyZWVfcmV2aXNpb246DQo+ID4gKwlrZnJlZShzb2NfZGV2X2F0
dHItPnJldmlzaW9uKTsNCj4gPiArZnJlZV9zb2NfaWQ6DQo+ID4gKwlrZnJlZShzb2NfZGV2X2F0
dHItPnNvY19pZCk7DQo+IA0KPiBZZXQgaGVyZSB5b3UgYmxpbmRseSBrZnJlZSgpLCB3aGljaCBt
ZWFucyB5b3UgY291bGQgYmUgZG9pbmcgaW4gZWZmZWN0DQo+IGtmcmVlKCJ1bmtub3duIikgLSB3
aGljaCB3aWxsIGxpa2VseSByZXN1bHQgaW4gYSBrZXJuZWwgb29wcy4NCj4gDQo+IEVpdGhlciBh
bHdheXMgbWFrZSByZXZpc2lvbi9zb2NfaWQgYW4gYWxsb2NhdGVkIHN0cmluZywgb3IgdXNlIHNv
bWUgc3RhdGljDQo+IHN0b3JhZ2UgZm9yIHRoZSBzdHJpbmdzICh0aGV5J3JlIG9ubHkgc21hbGws
IHN0YXRpYyBzdG9yYWdlIGlzIGxpa2VseSB0byBiZSBtdWNoDQo+IG1vcmUgZWZmaWNpZW50IGlu
IHRoaXMgY2FzZSwgYW5kIHRoZXJlIGNhbiBvbmx5IGJlIG9uZSBvZiB0aGVzZSBpbiBhbnkgY2Fz
ZS4pDQoNCllvdSBhcmUgcmlnaHQsIGFjdHVhbGx5IHRoZSAidW5rbm93biIgbWVzc2FnZSBpcyBO
T1QgaGVscGZ1bCBhdCBhbGwsIHNvIGluIG5leHQgdmVyc2lvbiwNCkkgd2lsbCBqdXN0IGNoZWNr
IHRoZSByZXR1cm4gdmFsdWUgZnJvbSBTQ1UgZmlybXdhcmUsIGlmIGl0IGZhaWwsIGp1c3Qgc2tp
cCB0aGlzIGRyaXZlciBwcm9iZSwNCklmIGl0IHN1Y2Nlc3MsIGl0IHdpbGwganVzdCBwcmludCBv
dXQgdGhlIHNvY19pZCBhbmQgcmV2aXNpb24gcGFzc2luZyBmcm9tIFNDVSBmaXJtd2FyZSwgc28g
bm8NCm5lZWQgdG8gaGF2ZSAidW5rbm93biIgc3RyaW5nIGhlcmUuDQoNCisrKyBiL2RyaXZlcnMv
c29jL2lteC9zb2MtaW14LXNjdS5jDQpAQCAtMjcsNyArMjcsNyBAQCBzdHJ1Y3QgaW14X3NjX21z
Z19taXNjX2dldF9zb2NfaWQgew0KICAgICAgICB9IGRhdGE7DQogfSBfX3BhY2tlZDsNCg0KLXN0
YXRpYyB1MzIgaW14X3NjdV9zb2NfaWQodm9pZCkNCitzdGF0aWMgaW50IGlteF9zY3Vfc29jX2lk
KHZvaWQpDQogew0KICAgICAgICBzdHJ1Y3QgaW14X3NjX21zZ19taXNjX2dldF9zb2NfaWQgbXNn
Ow0KICAgICAgICBzdHJ1Y3QgaW14X3NjX3JwY19tc2cgKmhkciA9ICZtc2cuaGRyOw0KQEAgLTQ0
LDggKzQ0LDcgQEAgc3RhdGljIHUzMiBpbXhfc2N1X3NvY19pZCh2b2lkKQ0KICAgICAgICByZXQg
PSBpbXhfc2N1X2NhbGxfcnBjKHNvY19pcGNfaGFuZGxlLCAmbXNnLCB0cnVlKTsNCiAgICAgICAg
aWYgKHJldCkgew0KICAgICAgICAgICAgICAgIHByX2VycigiJXM6IGdldCBzb2MgaW5mbyBmYWls
ZWQsIHJldCAlZFxuIiwgX19mdW5jX18sIHJldCk7DQotICAgICAgICAgICAgICAgLyogcmV0dXJu
IDAgbWVhbnMgZ2V0dGluZyByZXZpc2lvbiBmYWlsZWQgKi8NCi0gICAgICAgICAgICAgICByZXR1
cm4gMDsNCisgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KICAgICAgICB9DQoNCiAgICAgICAg
cmV0dXJuIG1zZy5kYXRhLnJlc3AuaWQ7DQpAQCAtNTUsNyArNTQsOCBAQCBzdGF0aWMgaW50IGlt
eF9zY3Vfc29jX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KICAgICAg
ICBzdHJ1Y3Qgc29jX2RldmljZV9hdHRyaWJ1dGUgKnNvY19kZXZfYXR0cjsNCiAgICAgICAgc3Ry
dWN0IHNvY19kZXZpY2UgKnNvY19kZXY7DQotICAgICAgIHUzMiBpZCwgdmFsOw0KKyAgICAgICB1
MzIgdmFsOw0KKyAgICAgICBpbnQgaWQ7DQogICAgICAgIGludCByZXQ7DQoNCiAgICAgICAgcmV0
ID0gaW14X3NjdV9nZXRfaGFuZGxlKCZzb2NfaXBjX2hhbmRsZSk7DQpAQCAtNzYsMjEgKzc2LDIy
IEBAIHN0YXRpYyBpbnQgaW14X3NjdV9zb2NfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCiAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KDQogICAgICAgIGlkID0gaW14X3Nj
dV9zb2NfaWQoKTsNCisgICAgICAgaWYgKGlkIDwgMCkNCisgICAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCg0KICAgICAgICAvKiBmb3JtYXQgc29jX2lkIHZhbHVlIHBhc3NlZCBmcm9tIFND
VSBmaXJtd2FyZSAqLw0KICAgICAgICB2YWwgPSBpZCAmIDB4MWY7DQotICAgICAgIHNvY19kZXZf
YXR0ci0+c29jX2lkID0gdmFsID8ga2FzcHJpbnRmKEdGUF9LRVJORUwsICIweCV4IiwgdmFsKQ0K
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogInVua25vd24iOw0KKyAgICAgICBzb2Nf
ZGV2X2F0dHItPnNvY19pZCA9IGthc3ByaW50ZihHRlBfS0VSTkVMLCAiMHgleCIsIHZhbCk7DQog
ICAgICAgIGlmICghc29jX2Rldl9hdHRyLT5zb2NfaWQpDQogICAgICAgICAgICAgICAgcmV0dXJu
IC1FTk9NRU07DQoNCiAgICAgICAgLyogZm9ybWF0IHJldmlzaW9uIHZhbHVlIHBhc3NlZCBmcm9t
IFNDVSBmaXJtd2FyZSAqLw0KICAgICAgICB2YWwgPSAoaWQgPj4gNSkgJiAweGY7DQogICAgICAg
IHZhbCA9ICgoKHZhbCA+PiAyKSArIDEpIDw8IDQpIHwgKHZhbCAmIDB4Myk7DQotICAgICAgIHNv
Y19kZXZfYXR0ci0+cmV2aXNpb24gPSB2YWwgPyBrYXNwcmludGYoR0ZQX0tFUk5FTCwNCi0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiJWQuJWQiLA0KLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh2YWwgPj4gNCkg
JiAweGYsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dmFsICYgMHhmKSA6ICJ1bmtub3duIjsNCisgICAgICAgc29jX2Rldl9hdHRyLT5yZXZpc2lvbiA9
IGthc3ByaW50ZihHRlBfS0VSTkVMLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICIlZC4lZCIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKHZhbCA+PiA0KSAmIDB4ZiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB2YWwgJiAweGYpOw0KICAgICAgICBpZiAoIXNvY19kZXZfYXR0ci0+cmV2aXNp
b24pIHsNCg0KVGhhbmtzLA0KQW5zb24uDQoNCj4gDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9
DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBpbXhfc2N1X3NvY19k
cml2ZXIgPSB7DQo+ID4gKwkuZHJpdmVyID0gew0KPiA+ICsJCS5uYW1lID0gSU1YX1NDVV9TT0Nf
RFJJVkVSX05BTUUsDQo+ID4gKwl9LA0KPiA+ICsJLnByb2JlID0gaW14X3NjdV9zb2NfcHJvYmUs
DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IF9faW5pdCBpbXhfc2N1X3NvY19pbml0
KHZvaWQpIHsNCj4gPiArCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmlteF9zY3Vfc29jX3BkZXY7
DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+
ID4gKwlucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJmc2wsaW14LXNj
dSIpOw0KPiA+ICsJaWYgKCFucCkNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiArDQo+ID4g
KwlvZl9ub2RlX3B1dChucCk7DQo+ID4gKw0KPiA+ICsJcmV0ID0gcGxhdGZvcm1fZHJpdmVyX3Jl
Z2lzdGVyKCZpbXhfc2N1X3NvY19kcml2ZXIpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1
cm4gcmV0Ow0KPiA+ICsNCj4gPiArCWlteF9zY3Vfc29jX3BkZXYgPQ0KPiA+ICsNCj4gCXBsYXRm
b3JtX2RldmljZV9yZWdpc3Rlcl9zaW1wbGUoSU1YX1NDVV9TT0NfRFJJVkVSX05BTUUsDQo+ID4g
KwkJCQkJCS0xLA0KPiA+ICsJCQkJCQlOVUxMLA0KPiA+ICsJCQkJCQkwKTsNCj4gPiArCWlmIChJ
U19FUlIoaW14X3NjdV9zb2NfcGRldikpDQo+ID4gKwkJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0
ZXIoJmlteF9zY3Vfc29jX2RyaXZlcik7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIFBUUl9FUlJfT1Jf
WkVSTyhpbXhfc2N1X3NvY19wZGV2KTsNCj4gPiArfQ0KPiA+ICtkZXZpY2VfaW5pdGNhbGwoaW14
X3NjdV9zb2NfaW5pdCk7DQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQo+ID4NCj4gPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+IGxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHAlM0ElMkYlMkZsaXN0cw0KPiA+IC5pbmZyYWRlYWQub3JnJTJGbWFpbG1hbiUyRmxp
c3RpbmZvJTJGbGludXgtYXJtLQ0KPiBrZXJuZWwmYW1wO2RhdGE9MDIlN0MwDQo+ID4NCj4gMSU3
Q2Fuc29uLmh1YW5nJTQwbnhwLmNvbSU3QzZlZjI5Njg2NmNlMjQzZDk0NzNjMDhkNmRmNWU2YjVm
JTdDDQo+IDY4NmVhMWQNCj4gPg0KPiAzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAl
N0M2MzY5NDE5OTM5NTkxOTU1NjEmYW1wO3NkYXQNCj4gYT1tWGRvdw0KPiA+DQo+IGZMc2hKJTJC
UWx5TEolMkJieVl3dURVWGgzQ3dPQkFpWiUyQnZWRUQlMkZSaDQlM0QmYW1wO3Jlc2VydmUNCj4g
ZD0wDQo+ID4NCj4gDQo+IC0tDQo+IFJNSydzIFBhdGNoIHN5c3RlbToNCj4gaHR0cHM6Ly9ldXIw
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGd3d3
Lg0KPiBhcm1saW51eC5vcmcudWslMkZkZXZlbG9wZXIlMkZwYXRjaGVzJTJGJmFtcDtkYXRhPTAy
JTdDMDElN0NhbnNvDQo+IG4uaHVhbmclNDBueHAuY29tJTdDNmVmMjk2ODY2Y2UyNDNkOTQ3M2Mw
OGQ2ZGY1ZTZiNWYlN0M2ODZlYTFkMw0KPiBiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdD
MCU3QzYzNjk0MTk5Mzk1OTE5NTU2MSZhbXA7c2RhdGENCj4gPXJzckglMkY5cHFkTFpVSjBFJTJC
V1VhMktmNzFydE9jTkR5ako4MVI4RXg2eVFzJTNEJmFtcDtyZXNlcnZlDQo+IGQ9MA0KPiBGVFRD
IGJyb2FkYmFuZCBmb3IgMC44bWlsZSBsaW5lIGluIHN1YnVyYmlhOiBzeW5jIGF0IDEyLjFNYnBz
IGRvd24NCj4gNjIya2JwcyB1cCBBY2NvcmRpbmcgdG8gc3BlZWR0ZXN0Lm5ldDogMTEuOU1icHMg
ZG93biA1MDBrYnBzIHVwDQo=
