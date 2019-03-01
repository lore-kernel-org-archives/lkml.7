Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D772085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PHX9uykn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbfCAKHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:07:08 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:45421 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfCAKHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:07:07 -0500
X-IronPort-AV: E=Sophos;i="5.58,427,1544511600"; 
   d="scan'208";a="25445159"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 01 Mar 2019 03:07:06 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Mar 2019 03:07:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10VxLXXQTeXnUfUpgemuxC5j/O+ASjjCErbMaD7TZz0=;
 b=PHX9uyknxpESxa/WwNstSh/vkqARrhYz0GzqEoB3HGk8hW1STFwl2sqgJaG+K156rv+iNLpGPkPijdkm35z1bOqeHOGKGBksb7B2Tz8xr5O2HLNqfVpZbOrfPrDGGBTwJWsmE1h7fvxscBu2AYGoUoDFH6OcaIFIisK6Hid1ZJE=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1309.namprd11.prod.outlook.com (10.169.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 10:07:02 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%8]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 10:07:02 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sam@ravnborg.org>
CC:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <thierry.reding@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/7] drm: atmel-hlcdc: add config option for clock
 selection
Thread-Topic: [PATCH 1/7] drm: atmel-hlcdc: add config option for clock
 selection
Thread-Index: AQHUzrjibzNyakqaO0avPILToqBAJKX1uvIAgADUjgA=
Date:   Fri, 1 Mar 2019 10:07:02 +0000
Message-ID: <21942343-5e76-2fa3-b394-c1cef4abd9e1@microchip.com>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <1551284609-14594-2-git-send-email-claudiu.beznea@microchip.com>
 <20190228212558.GB30188@ravnborg.org>
In-Reply-To: <20190228212558.GB30188@ravnborg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0196.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::26) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190301120644299
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a161952-4ae2-406e-2c5f-08d69e2da68c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1309;
x-ms-traffictypediagnostic: MWHPR11MB1309:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxMzA5OzIzOlByM1daWnJhT21XQ2txRWI0dk5PdWNGcXN6?=
 =?utf-8?B?NTV4Unh1QmZ0SXQzUXI1UHBVNjFFKzhzRGNDaGJmbXlxWVF1V0p2Z1NjbytO?=
 =?utf-8?B?eG9ZWkdJSUk2Z2h4R3J2WEwrZFlqa3NtUXJ6dit6eCtqL1NtSjdhaFU1TW5t?=
 =?utf-8?B?Ny9sRE1EcHVTWE9ORHBtK3BWbk1DT0JZYjFwNlpoVjgzeE0rNFVYZmxpYTAx?=
 =?utf-8?B?VzFVdnBrS1FqS3RwVlhNcGpOaFdYZkNvSGNnY1o0Q1ZsdlBnT0FQR2xWSEVt?=
 =?utf-8?B?enNUYWpUSXhUNjhhdnUzWlhsNFZrK3l4VUw1WnpkcXN5RUFockJwaXovUnhY?=
 =?utf-8?B?NTlNcVV6Z0NpY3ZaOWFneWRRUGkreUdpYUxCa20wVGVMblBoRkdYK2hVUm1M?=
 =?utf-8?B?YnVTTVRybUV1V3lwOVBJNW4yVWFpMXZCdDVhZmZMS0VHV0ZSbk01QlIwU09l?=
 =?utf-8?B?QkdYTlByNmRPZUdPbWNLR3ZJZk5ITk1Pem9WcnJEWWRoeE51RCt1U2JuRDBt?=
 =?utf-8?B?YTM5Z2cwdnpNMmlpN3BwY2FIdEVOZG5hb3FmR056TlFkdUw4TW8ySkVFQlpX?=
 =?utf-8?B?bllwQXoydk1DdXc4aXZaY011YjRubFkvUFdEVnZjY09VQzh5M0pJVmI3ckw2?=
 =?utf-8?B?T0RLRjdwUHlsazFYY2p6ckgvUVNaS1lpTmU2cERYSDlEUEJDU21sTEQ1MjJj?=
 =?utf-8?B?WWZ5WkFKQThHOVc1UC9GbGM5UE0wcldRck44U2t0RHcxOFdkclBTTFMxMmhP?=
 =?utf-8?B?bE5TMG9Pd1BYMlR0YnpkQkMraXhuVXpkaUZ4WkRUckQ0cWhyQmIrTURvMzdx?=
 =?utf-8?B?K1gyR2lpY1BHRzFzdjYxZVUwMVpjd0N4S0lZbElrZWoxbHd6MTh6K3VpZGVj?=
 =?utf-8?B?UkptVmloN0FUck9KV1NGbkorYkpFeXIyZENZc3F6M3FXR1pEenkrMGNDN0xo?=
 =?utf-8?B?aHJPQmxRTnJuWW1Xd3JiZlZIUVhRUG5WRjVORXpEZk5mNFFIck5FZG1CYito?=
 =?utf-8?B?Yyt6aGcwOXpmZWdpM3J5a1lna2NRaWpsRXJkKzZCdk5QYzJ0MnBYdTNHK1Rm?=
 =?utf-8?B?VnFSUTYyVUFpRnk2NEFwSk5tSVBkWDRZc08zQmJZazhkQ0J1L3pYRXRuMEsz?=
 =?utf-8?B?QmcwaEpwdVNVSEJrbnV2Uk1rOXlUa1ZTVmZIM2Vhdll5eGw4elE4ejNzOXVs?=
 =?utf-8?B?aERNQnFnT2kvYVNWYUlLME0yRDluL2F4WkRuRm1qajNzM0VaY3RuVlZFYlRN?=
 =?utf-8?B?Z21ZMEs5c3hSUHZMaUxJbkZTanFsMzVQTzIwc1oxOE12dUE4SjFVTmVFeFYz?=
 =?utf-8?B?bjlxb3Z1Z2c0VUZMOGVodFRITVlzcVBWTjZuMmJCcDFnb0xiZnNNczhBUldu?=
 =?utf-8?B?aWR4WUFydC9lSlpoenkyREdPanBKMnRmUTFOWXIwTy9CM3pncEFqUkZyRHNp?=
 =?utf-8?B?aFBmU2REMk5vb0h1Q2M1UW5WdmR2aXNsQ3JZVTROcWFrMWtRRDB2QnFNTDVr?=
 =?utf-8?B?T0ppYWpsd1pzRW5ETHRENXVuTmcwOC8wRG5UZ0M4SWtzTmRmZGY1SWFpWDlW?=
 =?utf-8?B?VmhKa3kvS3ZWdFhCTlZKZ3hrdXQvUVRGZkNJZnViNEdIWmZFeStUVXZuR2lk?=
 =?utf-8?B?ZmlLVzN6RHNYTmxPdWZoaTNXeWtjQklMbExWNWFwZGQvRlMxQlZjMHBIaDVF?=
 =?utf-8?B?MEhNTVpqZ0Mra1QralVJTUhneW1RKzFSbndhSEdmNStIMjVvVU5tNENVdlhD?=
 =?utf-8?Q?FxleuoEZFonnZZuqyRCM2zroMCrLRNciKeTz4=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB13096FBC40A1251BB3985D5787760@MWHPR11MB1309.namprd11.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(11346002)(6116002)(2616005)(14454004)(6916009)(229853002)(54906003)(8936002)(305945005)(478600001)(66066001)(316002)(446003)(7736002)(68736007)(6486002)(105586002)(106356001)(81166006)(81156014)(6436002)(8676002)(99286004)(72206003)(76176011)(52116002)(3846002)(476003)(2906002)(31686004)(36756003)(486006)(53546011)(6506007)(25786009)(386003)(26005)(31696002)(86362001)(6512007)(186003)(71190400001)(71200400001)(53936002)(256004)(7416002)(102836004)(5660300002)(6246003)(97736004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1309;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S5wfbPlEN9X+xKwtOaRQvQOSXtYO6k7nxU20KIOoWUB3BE5LabrDGNl/uhgrD0wLZ7dfgJIrTQv1jItoA09Y5LoKWP8DkN3it/5URE2Lz04Fjgd+/Yw3FeivU5Kz2XIo+j2SwkN1RzZCBR2s5zT+Bqyxuq9a2JvnBSK169zFqqZ/W7RM4A9e/UuynUQlEV/qhICyhhlwqnE4dQ2nu+t0kWQDX0kgyyFCLk354VXZ7b9g4p4hqxoYGJpslxcSSSWW8q/eUjSKyviwwBLH3fKPT91vXKRLYN3rm9Qb53C4uDCR9EvJE4gJ89/bmbd07UQRYXeZXnCsubNueOsowmEfb/eSX5G+6dGBMitkUnWms5cRusWTvy5+XywSThkmm/C18G6huc8Pv78E2AZZOCQBid7JvY83zc8OZVmCrvCVRPI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9B6F4EEA2C4BE4CA54A991A89A2E622@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a161952-4ae2-406e-2c5f-08d69e2da68c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 10:06:57.9746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1309
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI4LjAyLjIwMTkgMjM6MjUsIFNhbSBSYXZuYm9yZyB3cm90ZToNCj4gSGkgQ2xhdWRp
dQ0KPiANCj4gT24gV2VkLCBGZWIgMjcsIDIwMTkgYXQgMDQ6MjQ6MTZQTSArMDAwMCwgQ2xhdWRp
dS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxj
bGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IFNBTTl4NjAgTENEIENvbnRyb2xs
ZXIgaGFzIG5vIG9wdGlvbiB0byBzZWxlY3QgY2xvY2sgc291cmNlIGFzIHByZXZpb3VzDQo+PiBj
b250cm9sbGVycyBoYXZlLiBUbyBiZSBhYmxlIHRvIHVzZSB0aGUgc2FtZSBkcml2ZXIgZXZlbiBm
b3IgdGhpcyBMQ0QNCj4+IGNvbnRyb2xsZXIgYWRkIGEgY29uZmlnIG9wdGlvbiB0byBrbm93IGlm
IGNvbnRyb2xsZXIgc3VwcG9ydHMgdGhpcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1
IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZl
cnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMgfCAxMiArKysrKysrLS0t
LS0NCj4+ICBkcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuaCAgIHwg
IDIgKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVs
X2hsY2RjX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19j
cnRjLmMNCj4+IGluZGV4IDgwNzBhNTU4ZDdiMS4uMTdhN2ExOGY2YTA3IDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYw0KPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYw0KPj4gQEAg
LTc4LDcgKzc4LDggQEAgc3RhdGljIHZvaWQgYXRtZWxfaGxjZGNfY3J0Y19tb2RlX3NldF9ub2Zi
KHN0cnVjdCBkcm1fY3J0YyAqYykNCj4+ICAJdW5zaWduZWQgbG9uZyBtb2RlX3JhdGU7DQo+PiAg
CXN0cnVjdCB2aWRlb21vZGUgdm07DQo+PiAgCXVuc2lnbmVkIGxvbmcgcHJhdGU7DQo+PiAtCXVu
c2lnbmVkIGludCBjZmc7DQo+PiArCXVuc2lnbmVkIGludCBtYXNrID0gQVRNRUxfSExDRENfQ0xL
RElWX01BU0sgfCBBVE1FTF9ITENEQ19DTEtQT0w7DQo+PiArCXVuc2lnbmVkIGludCBjZmcgPSAw
Ow0KPj4gIAlpbnQgZGl2Ow0KPiBIZXJlIGNmZyBhbmQgbWFzayBoYXMgaW5pdGlhbCB2YWx1ZXMu
DQo+IA0KPj4gIA0KPj4gIAl2bS52ZnJvbnRfcG9yY2ggPSBhZGotPmNydGNfdnN5bmNfc3RhcnQg
LSBhZGotPmNydGNfdmRpc3BsYXk7DQo+PiBAQCAtMTAxLDcgKzEwMiwxMCBAQCBzdGF0aWMgdm9p
ZCBhdG1lbF9obGNkY19jcnRjX21vZGVfc2V0X25vZmIoc3RydWN0IGRybV9jcnRjICpjKQ0KPj4g
IAkJICAgICAoYWRqLT5jcnRjX2hkaXNwbGF5IC0gMSkgfA0KPj4gIAkJICAgICAoKGFkai0+Y3J0
Y192ZGlzcGxheSAtIDEpIDw8IDE2KSk7DQo+PiAgDQo+PiAtCWNmZyA9IEFUTUVMX0hMQ0RDX0NM
S1NFTDsNCj4+ICsJaWYgKCFjcnRjLT5kYy0+ZGVzYy0+Zml4ZWRfY2xrc3JjKSB7DQo+PiArCQlj
ZmcgPSBBVE1FTF9ITENEQ19DTEtTRUw7DQo+PiArCQltYXNrIHw9IEFUTUVMX0hMQ0RDX0NMS1NF
TDsNCj4+ICsJfQ0KPiBBbmQgaGVyZSBtYXNrIGlzIGJpdHdpc2Ugb3Igd2l0aCBBVE1FTF9ITENE
Q19DTEtTRUwgLSBmaW5lLg0KPiBCdXQgY2ZnIGlzIGRpcmVjdGx5IGFzc2lnbmVkLg0KDQpJIGRp
cmVjdGx5IGFzc2lnbmVkIGl0IGhlcmUgYmVjYXVzZSBpdCB3YXMgdGhlIGZpcnN0IHRpbWUgaXQg
d2FzIHVzZWQuDQpJIHdpbGwgdXNlIGEgInwiIG9wZXJhdGlvbiBhcyB5b3Ugc3VnZ2VzdCBpbiBu
ZXh0IHZlcnNpb24uDQoNCj4gSWYgY2ZnIHdhcyBiaXR3aXNlIG9yIHRoZSBBVE1FTF9ITENEQ19D
TEtTRUwgdmFsdWUgdGhlbiB0aGUgY29kZSB3YXMgcHJlcGFyZWQNCj4gdG8gaGF2ZSBleHRyYSBm
bGFncyBhZGRlZCBhYm92ZSB0aGVzZSBsaW5lcy4NCj4gDQo+IE9ubHkgYSBzbWFsbCBjaGFuZ2Ug
YW5kIG5vIGZ1bmN0aW9uYWwgZGlmZmVyZW5jZS4NCj4gDQo+IFdpdGggb3Igd2l0aG91dCB0aGlz
IGNoYW5nZToNCj4gUmV2aWV3ZWQtYnk6IFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9yZz4N
Cj4gDQo+IA0K
