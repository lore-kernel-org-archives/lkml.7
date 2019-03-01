Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C0DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5273F2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="a1Z2HtKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbfCAKGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:06:54 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:45392 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfCAKGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:06:54 -0500
X-IronPort-AV: E=Sophos;i="5.58,427,1544511600"; 
   d="scan'208";a="25445149"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Mar 2019 03:06:41 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Mar 2019 03:06:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4bjXEFmB8w9w+50WnJAhkuv/39jLpjoogVXEY9nTHI=;
 b=a1Z2HtKvxI6bDQTxGtm+rcEzk1VHZLq8s/W8UFWYnaySN7wo/LZoO7M43LdkS4OxoVOtY/pM/7b967NBELzEnpIvMEcqEb7X8qWbYdCFtNp3ymNRI9D2rT8H48kFKxkKUh1dEvt+GvP69uzfhcPcBe7duFE7X5z5ickXIzy+ri8=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1309.namprd11.prod.outlook.com (10.169.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 10:06:37 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%8]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 10:06:37 +0000
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
Thread-Index: AQHUzrjibzNyakqaO0avPILToqBAJKX1vpMAgADQ1oA=
Date:   Fri, 1 Mar 2019 10:06:36 +0000
Message-ID: <ea061402-6caa-62d0-c445-acdcdf3ab08c@microchip.com>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <1551284609-14594-2-git-send-email-claudiu.beznea@microchip.com>
 <20190228213858.GC30188@ravnborg.org>
In-Reply-To: <20190228213858.GC30188@ravnborg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0204.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::34) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190301120625665
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f078361-1680-4bcf-38a5-08d69e2d972d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1309;
x-ms-traffictypediagnostic: MWHPR11MB1309:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxMzA5OzIzOjV5MEMzZDlTaDllUXpJRnpwQW1YZ3VHWHJi?=
 =?utf-8?B?YW1mcFU1UWwzM2FzNExuK0xkMTBZNGhyOUVTK2xFaUFtSHNwUHZBOXNkSkFr?=
 =?utf-8?B?S3NoaGRkNzcyVVNYZk1jNnVtWlBobHR3bnh5dlBEMm5IbFpWTDNGVHRNS1Fm?=
 =?utf-8?B?TXk4NEZFaUc3SVd0Vi8yUXlFc0NxM1lBU2lzcFdKOFFjNHFQeFhyb2NURXdo?=
 =?utf-8?B?NmZwV1M3ZDdscysyU3ZWK2N3d3JOSmpWQ2FWTzlzMC9lV1FiVVFZT2RtdCs4?=
 =?utf-8?B?R1lVRkFERUltYWxJL2V4c2tTZzJaVExPdTN0UnRJSzZzRGsxT2JtZWIxUUhh?=
 =?utf-8?B?QjM2VUtjL3pnM3laSW1kejJNbjdoTG95N2drWFdOSUk0eEJKWHZCdmg2QzFz?=
 =?utf-8?B?aFRpLzc0VUVTdlIyemRpYWxBMXVUR0lrRmFYVXE2cmFGSkRJUklNNUp4c3Bp?=
 =?utf-8?B?WlNncUF0RXB4ZFBrdUVIblBUdGVNU3BLN3NhSERKUHBGZDh5aVpvbWtmbnVz?=
 =?utf-8?B?UWFEVVAwM3hjeWlzYU5qQWo5d1ByMU5sdVRjNW5RWkpKY2VhN3BCdUFWek5y?=
 =?utf-8?B?anZKaUNOU0l2MlBpaDhtY0ZscDVnWUFRclUxU0JVaXQrZUcxYVpHeFhERTJq?=
 =?utf-8?B?V3kxZUVvV0tRLzdMVElObEJaR0hlS3o4djM4dFBLcEgvRkZGL2ZoRUxuZTdw?=
 =?utf-8?B?WVM4TkQzN1A4QzljQkZtR0czdk5RSnpJRmcwZyswYXVtYmlKT1oyeW0yeWNz?=
 =?utf-8?B?ajlSSitJd1RSVmliRTRBQ2g4QUJMWFBnblpjQ01Mek1RVTkzVGZZK3N1eDVu?=
 =?utf-8?B?Rnk2QzZNeTBaUmk2eGJrOWI2SUZ5Nm9VWG5NaURwbG9oc0RmQyt5dktBeXF5?=
 =?utf-8?B?blZneS9Fd2srbkprMUdvZ2dsUWM4MTF1YXlkbEp4UlhDdUlvTFVzYXRRRnJ3?=
 =?utf-8?B?ckl0enMzc2RzM1dPWTlKZVV2eGUrL003bWdwaGtEM3Z3cGRxclRFVEpjMG1q?=
 =?utf-8?B?eXhWMDlBT2dKcmZqVVVyK3BJUEpCTmpkdFZLWGlGb1hWRzRQWmltdEw3S2FG?=
 =?utf-8?B?bUZuY0xaTmc4eGdOak0zSGdVejFuS0NRNG9TUXl2THU3b2VCd0ZTM2NBVFFQ?=
 =?utf-8?B?czR2RDVRanZyRzVKSEtmaGZuaWd3a2kvc3hmQWFKbm5UTzkzNmJLYzVIeUYx?=
 =?utf-8?B?dktwR2ZiQVlkQ2cybUV1bmVmb0VMR3VNSFZ3VnlFR081WkdEUm5BWjJFM25v?=
 =?utf-8?B?OXh1eE9qTzJRVEMxRWFWME8rWTFOeWQ2YkpTdVZMRytRaUt3b200Z1VVL29v?=
 =?utf-8?B?bXo4WEx2cG4vZnR0R0FuelV6RU9Xc2tzWjJ4SkRpL3lQSXR1ZWpwTkRud1RI?=
 =?utf-8?B?MUdaOEZFVlJwaG5ubnBFMUtUcmIzTmVKbnJraUJsR05TcVhCU1lWb3FiR25Z?=
 =?utf-8?B?L0toaU92RFM5VGc0N3pHTmNiZ1JxLzRxaHg1SE5TTzhPUE93dXlUZVlDaGtx?=
 =?utf-8?B?NXVQZWxuUFpLU2JSM1UyNytNRExmbm9PSmtJWkRFWUpuaGlSQW4yM3NtWXdm?=
 =?utf-8?B?TTAxZ29pZWp6b1JOTjlXWVZIa3psQlRhMGFSclI1QWd5YU5XRkhxcDZ2emUx?=
 =?utf-8?B?b2hlbEFNR1VkMTJmUHlsN3dlZDFVdXpBanYvd1pUblJDNUlpazN1M3hoemJh?=
 =?utf-8?B?dG5VcUhXaG1jMGU2Z1JYZS9QUW03cWR0dkJXREZSUXdvR2RyNkRYTlhMTzgz?=
 =?utf-8?B?cHpTL1VqTDdrdWJQN2FtRnRUaFQydlh6NHZiUHNDbmlLd0R0dU1tR1ZUNEJv?=
 =?utf-8?B?N1hBUDBOWjI5eUE3VExEbC83QXFNbk00ZG1PZVRDMWNmVGc9PQ==?=
x-microsoft-antispam-prvs: <MWHPR11MB130955F8CFC5C367BD82B79587760@MWHPR11MB1309.namprd11.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(11346002)(6116002)(2616005)(14454004)(6916009)(229853002)(54906003)(8936002)(305945005)(478600001)(66066001)(316002)(446003)(7736002)(68736007)(6486002)(105586002)(106356001)(81166006)(81156014)(6436002)(8676002)(99286004)(72206003)(76176011)(52116002)(3846002)(476003)(966005)(2906002)(31686004)(36756003)(486006)(53546011)(6506007)(25786009)(386003)(26005)(31696002)(86362001)(6512007)(186003)(71190400001)(71200400001)(6306002)(53936002)(14444005)(256004)(7416002)(102836004)(5660300002)(6246003)(97736004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1309;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PxtCYB8+Q+LD/G7sN+gwJzLfSNWR49EQ7Y3oMIB3PEZD/mp4T2a+GBxOiW7Q7W1Zq9+kJ3HSLERsjMX273VmoG94WiuAqiZDGVA94owogM8tK6MWj9aCab7T55JB6XiW/sVhRUA9V2NqzVCB+/aeqzX13XJ6QZsaC0IkUgI0JJiYMiZGOvZOl6Pk544H96B32ldaxSWdF+HfzM1XTzK3zntAq5ZqRAe1gu53x4E3+Xr3xx3gQl+DwcPaqUPmfBsTucLp2Xj7xtYbwFN8dHYSBv3VDiSuZWf83TDf2NwaM77jzYXDE7ljFoFnf6oJMxeu1v3LQ/4q3ZaaUF+IfwHxHTM3Y4qAq7tXfGPAawluv9JY2rp+2EiwpXOSEoMQs4wh9dK+1V8OZzPM/iAG/64I33pHMRPPDtBiDQEOmukZu7Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8E8A2EB2525CA45B563649AE4ABDDB1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f078361-1680-4bcf-38a5-08d69e2d972d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 10:06:33.0783
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

DQoNCk9uIDI4LjAyLjIwMTkgMjM6MzgsIFNhbSBSYXZuYm9yZyB3cm90ZToNCj4gSGkgQ2xhdWRp
dQ0KPiANCj4gT25lIG1vcmUgcmVwbHkgdG8gdGhpcyBwYXRjaC4uLg0KPiANCj4gT24gV2VkLCBG
ZWIgMjcsIDIwMTkgYXQgMDQ6MjQ6MTZQTSArMDAwMCwgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNy
b2NoaXAuY29tPg0KPj4NCj4+IFNBTTl4NjAgTENEIENvbnRyb2xsZXIgaGFzIG5vIG9wdGlvbiB0
byBzZWxlY3QgY2xvY2sgc291cmNlIGFzIHByZXZpb3VzDQo+PiBjb250cm9sbGVycyBoYXZlLiBU
byBiZSBhYmxlIHRvIHVzZSB0aGUgc2FtZSBkcml2ZXIgZXZlbiBmb3IgdGhpcyBMQ0QNCj4+IGNv
bnRyb2xsZXIgYWRkIGEgY29uZmlnIG9wdGlvbiB0byBrbm93IGlmIGNvbnRyb2xsZXIgc3VwcG9y
dHMgdGhpcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5i
ZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hdG1lbC1o
bGNkYy9hdG1lbF9obGNkY19jcnRjLmMgfCAxMiArKysrKysrLS0tLS0NCj4+ICBkcml2ZXJzL2dw
dS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuaCAgIHwgIDIgKysNCj4+ICAyIGZpbGVz
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMNCj4+IGluZGV4IDgw
NzBhNTU4ZDdiMS4uMTdhN2ExOGY2YTA3IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYw0KPj4gQEAgLTc4LDcgKzc4LDggQEAgc3Rh
dGljIHZvaWQgYXRtZWxfaGxjZGNfY3J0Y19tb2RlX3NldF9ub2ZiKHN0cnVjdCBkcm1fY3J0YyAq
YykNCj4+ICAJdW5zaWduZWQgbG9uZyBtb2RlX3JhdGU7DQo+PiAgCXN0cnVjdCB2aWRlb21vZGUg
dm07DQo+PiAgCXVuc2lnbmVkIGxvbmcgcHJhdGU7DQo+PiAtCXVuc2lnbmVkIGludCBjZmc7DQo+
PiArCXVuc2lnbmVkIGludCBtYXNrID0gQVRNRUxfSExDRENfQ0xLRElWX01BU0sgfCBBVE1FTF9I
TENEQ19DTEtQT0w7DQo+PiArCXVuc2lnbmVkIGludCBjZmcgPSAwOw0KPj4gIAlpbnQgZGl2Ow0K
Pj4gIA0KPj4gIAl2bS52ZnJvbnRfcG9yY2ggPSBhZGotPmNydGNfdnN5bmNfc3RhcnQgLSBhZGot
PmNydGNfdmRpc3BsYXk7DQo+PiBAQCAtMTAxLDcgKzEwMiwxMCBAQCBzdGF0aWMgdm9pZCBhdG1l
bF9obGNkY19jcnRjX21vZGVfc2V0X25vZmIoc3RydWN0IGRybV9jcnRjICpjKQ0KPj4gIAkJICAg
ICAoYWRqLT5jcnRjX2hkaXNwbGF5IC0gMSkgfA0KPj4gIAkJICAgICAoKGFkai0+Y3J0Y192ZGlz
cGxheSAtIDEpIDw8IDE2KSk7DQo+PiAgDQo+PiAtCWNmZyA9IEFUTUVMX0hMQ0RDX0NMS1NFTDsN
Cj4+ICsJaWYgKCFjcnRjLT5kYy0+ZGVzYy0+Zml4ZWRfY2xrc3JjKSB7DQo+PiArCQljZmcgPSBB
VE1FTF9ITENEQ19DTEtTRUw7DQo+PiArCQltYXNrIHw9IEFUTUVMX0hMQ0RDX0NMS1NFTDsNCj4+
ICsJfQ0KPiBNYXliZSB0aGlzIGlzIGp1c3QgdG9vIGxhdGUgdG8gbG9vayBhdCBjb2RlLCBidXQg
SSBkbyBub3QgZ2V0IHRoaXMuDQo+IElmIHRoZSBzYW05eDYwIGRvIG5vdCBzdXBwb3J0IHNlbGVj
dGluZyB0aGUgY2xrIHJhdGUgdGhlbiBJIGFzc3VtZSBpdCBpcyBlaXRoZXINCj4gZml4ZWQgdG8g
dXNlZCBzeXN0ZW0gY2xvY2sgb3IgMiB4IHN5c3RlbSBjbG9jay4NCg0KU0FNOVg2MCdzIExDRCBj
b250cm9sbGVyIGhhcyBubyBzdXBwb3J0IGZvciBzZWxlY3RpbmcgY2xvY2sgc291cmNlIChhbmQg
Zm9yDQp0aGUgbW9tZW50LCB5ZXMsIGFzIEFsZXhhbmRyZSBzcGVjaWZpZWQsIHRoZSBkYXRhc2hl
ZXQgaXMgbm90IHB1YmxpYykuIElmDQp5b3UgbG9vayBhdCBlLmcuIFNBTTlYMzUgZGF0YXNoZWV0
ICwgY2hhcHRlciA0NS43LCBhdCBMQ0QgQ29udHJvbGxlcg0KQ29uZmlndXJhdGlvbiBSZWdpc3Rl
ciAwIFsxXSwgeW91IHdpbGwgc2VlIHRoaXMgQ0xLU0VMIGJpdC4gT24gU0FNOVg2MCB5b3UNCmRv
bid0IGhhdmUgdGhpcyBvcHRpb24sIGJ1dCB5b3UgaGF2ZSBvbmx5IG9uZSBjbG9jayBzb3VyY2Us
IGZpeGVkIG9uZS4gWW91DQpzdGlsbCBoYXZlIHRoZSBvcHRpb24gdG8gZGl2aWRlIHRoaXMgY2xv
Y2sgdG8gZ2V0IExDRCBwaXhlbCBjbG9jayB1c2luZw0KQ0xLRElWIGZpZWxkIG9mIExDRCBDb250
cm9sbGVyIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIgMCwgYW5kIHRoZSBmb3JtdWxhIGlzDQp0aGUg
c2FtZSBhcyBpbiBTQU05WDM1IGNhc2U6IHRoZSBvbmx5IGRpZmZlcmVuY2UgaXMgdGhhdCB0aGUg
Zm9ybXVsYSB1c2VzDQp0aGUgZml4ZWQgY2xvY2sgaW4gY2FzZSBvZiBTQU05WDYwIGFwYXJ0IGZy
b20gU0FNOVgzNSB3aGljaCB1c2VzIHRoZQ0Kc2VsZWN0ZWQgY2xvY2s6DQpTQU05WDYwOiBMQ0RQ
Q0xLID0gc291cmNlIGNsb2NrIC8gKENMS0RJVisyKQ0KU0FNOVgzNTogcGl4ZWxfY2xvY2sgPSBz
ZWxlY3RlZF9jbG9jayAvIChDTEtESVYgKyAyKS4NCg0KWzFdDQpodHRwOi8vd3cxLm1pY3JvY2hp
cC5jb20vZG93bmxvYWRzL2VuL0RldmljZURvYy9BdG1lbC0xMTA1NS0zMi1iaXQtQVJNOTI2RUot
Uy1NaWNyb2NvbnRyb2xsZXItU0FNOVgzNV9EYXRhc2hlZXQucGRmI0czOC4xNDcxMDQ4DQoNCj4g
DQo+IEFuZCB3ZSBoYXZlIGluIHRoZSBkcml2ZXIgY29kZSB0byBhZGp1c3QgdGhlICJkaXYiIHZh
bHVlLg0KPiBUaGUgdmFsdWUgb2YgZGl2IGRlcGVuZHMgb24gdGhlIENMS1NFTCBjb25maWd1cmF0
aW9uLCBzbyB0aGVyZSBtdXN0DQo+IGJlIG9uZSBwYXJ0IG9mIHRoaXMgdGhhdCBpcyBub3QgdmFs
aWQgd2hlbiBmaXhlZF9jbGtzcmMgaXMgdHJ1ZS4NCg0KV2hlbiBmaXhlZF9jbGtzcmMgaXMgdHJ1
ZSB5b3Ugc3RpbGwgaGF2ZSB0byBvcHRpb24gdG8gZGl2aWRlIHRoZSBzb3VyY2UgY2xvY2suDQoN
CkkgaG9wZSBJIHdhcyBjbGVhci4NCg0KPiANCj4+ICANCj4+ICAJcHJhdGUgPSAyICogY2xrX2dl
dF9yYXRlKGNydGMtPmRjLT5obGNkYy0+c3lzX2Nsayk7DQo+PiAgCW1vZGVfcmF0ZSA9IGFkai0+
Y3J0Y19jbG9jayAqIDEwMDA7DQo+PiBAQCAtMTMyLDkgKzEzNiw3IEBAIHN0YXRpYyB2b2lkIGF0
bWVsX2hsY2RjX2NydGNfbW9kZV9zZXRfbm9mYihzdHJ1Y3QgZHJtX2NydGMgKmMpDQo+PiAgDQo+
PiAgCWNmZyB8PSBBVE1FTF9ITENEQ19DTEtESVYoZGl2KTsNCj4gDQo+IEl0IGlzIHRoZSBmb2xs
b3dpbmcgY29kZSAobm90IHZpc2libGUgaW4gdGhpcyBwYXRjaCBJIHRhbGsgYWJvdXQ6DQo+ICAg
ICAgICBpZiAoZGl2IDwgMikgew0KPiAgICAgICAgICAgICAgICAgZGl2ID0gMjsNCj4gICAgICAg
ICB9IGVsc2UgaWYgKEFUTUVMX0hMQ0RDX0NMS0RJVihkaXYpICYgfkFUTUVMX0hMQ0RDX0NMS0RJ
Vl9NQVNLKSB7DQo+ICAgICAgICAgICAgICAgICAvKiBUaGUgZGl2aWRlciBlbmRlZCB1cCB0b28g
YmlnLCB0cnkgYSBsb3dlciBiYXNlIHJhdGUuICovDQo+ICAgICAgICAgICAgICAgICBjZmcgJj0g
fkFUTUVMX0hMQ0RDX0NMS1NFTDsNCj4gICAgICAgICAgICAgICAgIHByYXRlIC89IDI7DQo+ICAg
ICAgICAgICAgICAgICBkaXYgPSBESVZfUk9VTkRfVVAocHJhdGUsIG1vZGVfcmF0ZSk7DQo+ICAg
ICAgICAgICAgICAgICBpZiAoQVRNRUxfSExDRENfQ0xLRElWKGRpdikgJiB+QVRNRUxfSExDRENf
Q0xLRElWX01BU0spDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRpdiA9IEFUTUVMX0hMQ0RD
X0NMS0RJVl9NQVNLOw0KPiAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgICBpbnQg
ZGl2X2xvdyA9IHByYXRlIC8gbW9kZV9yYXRlOw0KPiANCj4gICAgICAgICAgICAgICAgIGlmIChk
aXZfbG93ID49IDIgJiYNCj4gICAgICAgICAgICAgICAgICAgICAoKHByYXRlIC8gZGl2X2xvdyAt
IG1vZGVfcmF0ZSkgPA0KPiAgICAgICAgICAgICAgICAgICAgICAxMCAqIChtb2RlX3JhdGUgLSBw
cmF0ZSAvIGRpdikpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgKiBBdCBsZWFzdCAxMCB0aW1lcyBiZXR0ZXIgd2hlbiB1c2luZyBhIGhp
Z2hlcg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgKiBmcmVxdWVuY3kgdGhhbiByZXF1ZXN0
ZWQsIGluc3RlYWQgb2YgYSBsb3dlci4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICogU28s
IGdvIHdpdGggdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGRpdiA9IGRpdl9sb3c7DQo+ICAgICAgICAgfQ0KPiANCj4gQW0gSSBt
aXNzaW5nIHNvbWV0aGluZyBvYnZpb3VzPw0KPiANCj4+IC0JcmVnbWFwX3VwZGF0ZV9iaXRzKHJl
Z21hcCwgQVRNRUxfSExDRENfQ0ZHKDApLA0KPj4gLQkJCSAgIEFUTUVMX0hMQ0RDX0NMS1NFTCB8
IEFUTUVMX0hMQ0RDX0NMS0RJVl9NQVNLIHwNCj4+IC0JCQkgICBBVE1FTF9ITENEQ19DTEtQT0ws
IGNmZyk7DQo+PiArCXJlZ21hcF91cGRhdGVfYml0cyhyZWdtYXAsIEFUTUVMX0hMQ0RDX0NGRygw
KSwgbWFzaywgY2ZnKTsNCj4+ICANCj4+ICAJY2ZnID0gMDsNCj4+ICANCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuaCBiL2RyaXZlcnMv
Z3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19kYy5oDQo+PiBpbmRleCA3MGJkNTQwZDY0
NGUuLjAxNTVlZmI5YzQ0MyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1o
bGNkYy9hdG1lbF9obGNkY19kYy5oDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxj
ZGMvYXRtZWxfaGxjZGNfZGMuaA0KPj4gQEAgLTMyOCw2ICszMjgsNyBAQCBhdG1lbF9obGNkY19s
YXllcl90b19wbGFuZShzdHJ1Y3QgYXRtZWxfaGxjZGNfbGF5ZXIgKmxheWVyKQ0KPj4gICAqIEBt
YXhfaHB3OiBtYXhpbXVtIGhvcml6b250YWwgYmFjay9mcm9udCBwb3JjaCB3aWR0aA0KPj4gICAq
IEBjb25mbGljdGluZ19vdXRwdXRfZm9ybWF0czogdHJ1ZSBpZiBSR0JYWFggb3V0cHV0IGZvcm1h
dHMgY29uZmxpY3Qgd2l0aA0KPj4gICAqCQkJCWVhY2ggb3RoZXIuDQo+PiArICogQGZpeGVkX2Ns
a3NyYzogdHJ1ZSBpZiBjbG9jayBzb3VyY2UgaXMgZml4ZWQNCj4gQmUgc3BlY2lmaWMgaGVyZS4g
VGVsbCBpZiAiZml4ZWRfY2xrc3JjID09IHRydWUiIGVxdWFscyBzeXN0ZW0gY2xvY2sgb3IgMiB4
IHN5c3RlbSBjbG9jay4NCg0KSW4gY2FzZSBvZiBTQU05WDYwLCBhcyBJIHNwZWNpZmllZCBhYm92
ZSwgdGhlcmUgaXMgbm8gb3B0aW9uIHRvIHNlbGVjdCBiL3cNCk1DSyBhbmQgMnhNQ0sgYXMgaW4g
Y2FzZSBvZiwgZS5nLiBTQU05WDM1LCBidXQgb25seSBvbmUgY2xvY2sgc291cmNlLg0KDQo+IA0K
PiAJU2FtDQo+IA0K
