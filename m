Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48D9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05D320828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="ltk39xcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfCRHn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:43:57 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com ([40.107.7.97]:52231
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbfCRHn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5F7yrMiT7SFzjuNt9kY0sa3ySMWGvRGE5hIYi2uyUg=;
 b=ltk39xcwGZ7Ckiqar1H4L5EGsPSy6XlN1XUuWN8Eyi0Y2YiVgwVYwdI8itVna8Hy5ffitUmaW5s3e5lWag6LgVFLhcLn63SejXaVEHkfbeHC+wbvDTGNCI2YzHXvlaUt4D8ZRl9vP9ftuQeQulOlK/qKhHK/x/VP/RcV0nJpVik=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2013.EURPRD10.PROD.OUTLOOK.COM (52.134.28.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 07:43:48 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cd0:b7e8:6608:b826]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cd0:b7e8:6608:b826%4]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 07:43:48 +0000
From:   Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Esben Haabendal <esben@geanix.com>,
        Fabio Estevam <festevam@gmail.com>,
        Per Christensen <pnc@deif.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-fsl-spi: support use of the SPISEL_BOOT signal
 on MPC8309
Thread-Topic: [PATCH] spi: spi-fsl-spi: support use of the SPISEL_BOOT signal
 on MPC8309
Thread-Index: AQHU1AfYCEu+DVoJHESVruGnCokNwaYRFI+A
Date:   Mon, 18 Mar 2019 07:43:47 +0000
Message-ID: <3f0313c8-670c-5d70-80e2-210add8e328c@prevas.se>
References: <20190306103156.19897-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190306103156.19897-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::14) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 252ecbcc-f41b-4c92-41e7-08d6ab757463
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2013;
x-ms-traffictypediagnostic: VI1PR10MB2013:
x-microsoft-antispam-prvs: <VI1PR10MB201389CDB9158E0F30AC29958A470@VI1PR10MB2013.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(6436002)(25786009)(102836004)(2906002)(4326008)(2616005)(229853002)(6506007)(6246003)(446003)(476003)(5660300002)(11346002)(26005)(53936002)(110136005)(8676002)(14454004)(44832011)(31696002)(486006)(54906003)(386003)(106356001)(99286004)(105586002)(8936002)(256004)(66066001)(478600001)(72206003)(81156014)(76176011)(86362001)(316002)(186003)(81166006)(6512007)(6486002)(7736002)(97736004)(3846002)(6116002)(305945005)(74482002)(52116002)(71190400001)(68736007)(71200400001)(31686004)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2013;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MMJ/xkQPrd4MWcsRd/uB3Eo+Og6FY0Tz7BI9EUbgCLsSSBaFR0kjt1Mil1jSSn627O3SyFuliv4T9zm5MNAyawc2exjT6rQQZWqMr7u78FXfIxIpzfKAARy6TI19cfRCeJ+utwyIECqcULnYg3TFEKrJVE7UcwbCt7+abolC8Wzt0JOQVcRgYGjLZ8DyFvY4ACa+ao5UO/h450Lq78P1pf+V7SwMscyPCwUfOMN1zjevCbgg2K3TwQwqPnFjtUdseJg1KiyrQtRVYkKTVmD31Jc0AsYwl2rtV/k+AoXXBHmGEcR1XxErtb7A5WX3ewiG1iQYxyy+y0ZfIxUp7YkZEQNVp1KEjaUrw7XfyyCwPPz8bmcT/xdudBsTpdBbx2IUO5Chng2Xy96XgzfA0SYZaQ/9gNHuRvcykI/VHIyqCOw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4179966A83D55F4B91E29404726DC421@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 252ecbcc-f41b-4c92-41e7-08d6ab757463
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 07:43:47.7843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cGluZw0KDQpPbiAwNi8wMy8yMDE5IDExLjMyLCBSYXNtdXMgVmlsbGVtb2VzIHdyb3RlOg0KPiBU
aGUgTVBDODMwOSBoYXMgYSBkZWRpY2F0ZWQgc2lnbmFsLCBTUElTRUxfQk9PVCwgdXN1YWxseSB1
c2VkIGFzIGNoaXANCj4gc2VsZWN0IGZvciB0aGUgZmxhc2ggZGV2aWNlIGZyb20gd2hpY2ggdGhl
IGJvb3Rsb2FkZXIgaXMgbG9hZGVkLiBJdCBpcw0KPiBub3QgYW4gb3JkaW5hcnkgZ3BpbywgYnV0
IGlzIHNpbXBseSBjb250cm9sbGVkIHZpYSB0aGUgU1BJX0NTIHJlZ2lzdGVyDQo+IGluIHRoZSBz
eXN0ZW0gY29uZmlndXJhdGlvbi4NCj4gDQo+IFRvIGFsbG93IGFjY2Vzc2luZyBzdWNoIGEgc3Bp
IHNsYXZlLCB3ZSBuZWVkIHRvIHRlYWNoDQo+IGZzbF9zcGlfY3NfY29udHJvbCgpIGhvdyB0byBj
b250cm9sIHRoZSBTUElTRUxfQk9PVCBzaWduYWwuIFRvDQo+IGRpc3Rpbmd1aXNoIHRoZSBncGlv
LWNvbnRyb2xsZWQgc2xhdmVzLCBjb250aW51ZSB0byBoYXZlIHRob3NlIHVzZQ0KPiBjaGlwX3Nl
bGVjdCB2YWx1ZXMgb2YgMC4ubmdwaW9zLTEsIGFuZCB1c2UgY2hpcF9zZWxlY3QgPT0gbmdwaW9z
IGZvcg0KPiB0aGUgYm9vdCBmbGFzaC4NCj4gDQo+IEknbSBub3QgdG9vIGhhcHB5IHdpdGggYWxs
IHRoZSBpZmRlZmZlcnksIGJ1dCBpdCBzZWVtcyB0byBiZSBuZWNlc3NhcnkNCj4gZm9yIGd1YXJk
aW5nIHRoZSBzeXNkZXYvZnNsX3NvYy5oIGFuZCB1c2Ugb2YNCj4gZ2V0X2ltbXJiYXNlKCkgKHNw
aS1mc2wtbGliLmMgYWxyZWFkeSBjb250YWlucyBzaW1pbGFyIGlmZGVmZmVyeSkuDQo+IA0KPiBH
b29nbGluZyBzdWdnZXN0cyB0aGF0IHRoZSBNUEM4MzA2IGlzIHNpbWlsYXIsIHdpdGggdGhlIFNQ
SV9DUw0KPiByZWdpc3RlciBhdCB0aGUgc2FtZSBvZmZzZXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBSYXNtdXMgVmlsbGVtb2VzIDxyYXNtdXMudmlsbGVtb2VzQHByZXZhcy5kaz4NCj4gLS0tDQo+
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvZnNsLXNwaS50eHQgICAgICAgfCAgNCArKw0K
PiAgZHJpdmVycy9zcGkvc3BpLWZzbC1saWIuaCAgICAgICAgICAgICAgICAgICAgIHwgIDIgKw0K
PiAgZHJpdmVycy9zcGkvc3BpLWZzbC1zcGkuYyAgICAgICAgICAgICAgICAgICAgIHwgNDAgKysr
KysrKysrKysrKysrKy0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zcGkvZnNsLXNwaS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc3BpL2ZzbC1zcGkudHh0DQo+IGluZGV4IDg4NTQwMDRhMWQzYS4uNDExMzc1ZWFjNTRk
IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2Zz
bC1zcGkudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkv
ZnNsLXNwaS50eHQNCj4gQEAgLTE4LDYgKzE4LDEwIEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+
ICAtIGdwaW9zIDogc3BlY2lmaWVzIHRoZSBncGlvIHBpbnMgdG8gYmUgdXNlZCBmb3IgY2hpcHNl
bGVjdHMuDQo+ICAgIFRoZSBncGlvcyB3aWxsIGJlIHJlZmVycmVkIHRvIGFzIHJlZyA9IDxpbmRl
eD4gaW4gdGhlIFNQSSBjaGlsZCBub2Rlcy4NCj4gICAgSWYgdW5zcGVjaWZpZWQsIGEgc2luZ2xl
IFNQSSBkZXZpY2Ugd2l0aG91dCBhIGNoaXAgc2VsZWN0IGNhbiBiZSB1c2VkLg0KPiArLSBmc2ws
c3Bpc2VsX2Jvb3QgOiBmb3IgdGhlIE1QQzgzMDYgYW5kIE1QQzgzMDksIHNwZWNpZmllcyB0aGF0
IHRoZQ0KPiArICBTUElTRUxfQk9PVCBzaWduYWwgaXMgdXNlZCBhcyBjaGlwIHNlbGVjdCBmb3Ig
YSBzbGF2ZSBkZXZpY2UuIFVzZQ0KPiArICByZWcgPSA8bnVtYmVyIG9mIGdwaW9zPiBpbiB0aGUg
Y29ycmVzcG9uZGluZyBjaGlsZCBub2RlLCBpLmUuIDAgaWYNCj4gKyAgdGhlIGdwaW9zIHByb3Bl
cnR5IGlzIG5vdCBwcmVzZW50Lg0KPiAgDQo+ICBFeGFtcGxlOg0KPiAgCXNwaUA0YzAgew0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLWZzbC1saWIuaCBiL2RyaXZlcnMvc3BpL3NwaS1m
c2wtbGliLmgNCj4gaW5kZXggZjMwM2YzMDZiMzhlLi40ODM3MzRiYzFiMWUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvc3BpL3NwaS1mc2wtbGliLmgNCj4gKysrIGIvZHJpdmVycy9zcGkvc3BpLWZz
bC1saWIuaA0KPiBAQCAtOTUsOCArOTUsMTAgQEAgc3RhdGljIGlubGluZSB1MzIgbXBjOHh4eF9z
cGlfcmVhZF9yZWcoX19iZTMyIF9faW9tZW0gKnJlZykNCj4gIA0KPiAgc3RydWN0IG1wYzh4eHhf
c3BpX3Byb2JlX2luZm8gew0KPiAgCXN0cnVjdCBmc2xfc3BpX3BsYXRmb3JtX2RhdGEgcGRhdGE7
DQo+ICsJaW50IG5ncGlvczsNCj4gIAlpbnQgKmdwaW9zOw0KPiAgCWJvb2wgKmFsb3dfZmxhZ3M7
DQo+ICsJX19iZTMyIF9faW9tZW0gKmltbXJfc3BpX2NzOw0KPiAgfTsNCj4gIA0KPiAgZXh0ZXJu
IHUzMiBtcGM4eHh4X3NwaV90eF9idWZfdTgoc3RydWN0IG1wYzh4eHhfc3BpICptcGM4eHh4X3Nw
aSk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktZnNsLXNwaS5jIGIvZHJpdmVycy9z
cGkvc3BpLWZzbC1zcGkuYw0KPiBpbmRleCA4ZjJlOTc4NTdlOGIuLjNkN2I1MGM2NWYzNiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLWZzbC1zcGkuYw0KPiArKysgYi9kcml2ZXJzL3Nw
aS9zcGktZnNsLXNwaS5jDQo+IEBAIC0zOSw2ICszOSwxNCBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4
L3NwaS9zcGlfYml0YmFuZy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ICANCj4g
KyNpZmRlZiBDT05GSUdfRlNMX1NPQw0KPiArI2luY2x1ZGUgPHN5c2Rldi9mc2xfc29jLmg+DQo+
ICsjZW5kaWYNCj4gKw0KPiArLyogU3BlY2lmaWMgdG8gdGhlIE1QQzgzMDYvTVBDODMwOSAqLw0K
PiArI2RlZmluZSBJTU1SX1NQSV9DU19PRkZTRVQgMHgxNGMNCj4gKyNkZWZpbmUgU1BJX0JPT1Rf
U0VMX0JJVCAgIDB4ODAwMDAwMDANCj4gKw0KPiAgI2luY2x1ZGUgInNwaS1mc2wtbGliLmgiDQo+
ICAjaW5jbHVkZSAic3BpLWZzbC1jcG0uaCINCj4gICNpbmNsdWRlICJzcGktZnNsLXNwaS5oIg0K
PiBAQCAtNzAxLDEwICs3MDksMTcgQEAgc3RhdGljIHZvaWQgZnNsX3NwaV9jc19jb250cm9sKHN0
cnVjdCBzcGlfZGV2aWNlICpzcGksIGJvb2wgb24pDQo+ICAJc3RydWN0IGZzbF9zcGlfcGxhdGZv
cm1fZGF0YSAqcGRhdGEgPSBkZXZfZ2V0X3BsYXRkYXRhKGRldik7DQo+ICAJc3RydWN0IG1wYzh4
eHhfc3BpX3Byb2JlX2luZm8gKnBpbmZvID0gdG9fb2ZfcGluZm8ocGRhdGEpOw0KPiAgCXUxNiBj
cyA9IHNwaS0+Y2hpcF9zZWxlY3Q7DQo+IC0JaW50IGdwaW8gPSBwaW5mby0+Z3Bpb3NbY3NdOw0K
PiAtCWJvb2wgYWxvdyA9IHBpbmZvLT5hbG93X2ZsYWdzW2NzXTsNCj4gIA0KPiAtCWdwaW9fc2V0
X3ZhbHVlKGdwaW8sIG9uIF4gYWxvdyk7DQo+ICsJaWYgKGNzIDwgcGluZm8tPm5ncGlvcykgew0K
PiArCQlpbnQgZ3BpbyA9IHBpbmZvLT5ncGlvc1tjc107DQo+ICsJCWJvb2wgYWxvdyA9IHBpbmZv
LT5hbG93X2ZsYWdzW2NzXTsNCj4gKw0KPiArCQlncGlvX3NldF92YWx1ZShncGlvLCBvbiBeIGFs
b3cpOw0KPiArCX0gZWxzZSB7DQo+ICsJCWlmIChXQVJOX09OX09OQ0UoY3MgPiBwaW5mby0+bmdw
aW9zIHx8ICFwaW5mby0+aW1tcl9zcGlfY3MpKQ0KPiArCQkJcmV0dXJuOw0KPiArCQlpb3dyaXRl
MzJiZShvbiA/IFNQSV9CT09UX1NFTF9CSVQgOiAwLCBwaW5mby0+aW1tcl9zcGlfY3MpOw0KPiAr
CX0NCj4gIH0NCj4gIA0KPiAgc3RhdGljIGludCBvZl9mc2xfc3BpX2dldF9jaGlwc2VsZWN0cyhz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+IEBAIC03MTIsMTIgKzcyNywxNSBAQCBzdGF0aWMgaW50IG9m
X2ZzbF9zcGlfZ2V0X2NoaXBzZWxlY3RzKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0KPiAgCXN0cnVjdCBmc2xfc3BpX3BsYXRm
b3JtX2RhdGEgKnBkYXRhID0gZGV2X2dldF9wbGF0ZGF0YShkZXYpOw0KPiAgCXN0cnVjdCBtcGM4
eHh4X3NwaV9wcm9iZV9pbmZvICpwaW5mbyA9IHRvX29mX3BpbmZvKHBkYXRhKTsNCj4gKwlib29s
IHNwaXNlbF9ib290ID0gSVNfRU5BQkxFRChDT05GSUdfRlNMX1NPQykgJiYNCj4gKwkJb2ZfcHJv
cGVydHlfcmVhZF9ib29sKG5wLCAiZnNsLHNwaXNlbF9ib290Iik7DQo+ICAJaW50IG5ncGlvczsN
Cj4gIAlpbnQgaSA9IDA7DQo+ICAJaW50IHJldDsNCj4gIA0KPiAgCW5ncGlvcyA9IG9mX2dwaW9f
Y291bnQobnApOw0KPiAtCWlmIChuZ3Bpb3MgPD0gMCkgew0KPiArCW5ncGlvcyA9IG1heChuZ3Bp
b3MsIDApOw0KPiArCWlmIChuZ3Bpb3MgPT0gMCAmJiAhc3Bpc2VsX2Jvb3QpIHsNCj4gIAkJLyoN
Cj4gIAkJICogU1BJIHcvbyBjaGlwLXNlbGVjdCBsaW5lLiBPbmUgU1BJIGRldmljZSBpcyBzdGls
bCBwZXJtaXR0ZWQNCj4gIAkJICogdGhvdWdoLg0KPiBAQCAtNzI2LDYgKzc0NCw3IEBAIHN0YXRp
YyBpbnQgb2ZfZnNsX3NwaV9nZXRfY2hpcHNlbGVjdHMoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAg
CQlyZXR1cm4gMDsNCj4gIAl9DQo+ICANCj4gKwlwaW5mby0+bmdwaW9zID0gbmdwaW9zOw0KPiAg
CXBpbmZvLT5ncGlvcyA9IGttYWxsb2NfYXJyYXkobmdwaW9zLCBzaXplb2YoKnBpbmZvLT5ncGlv
cyksDQo+ICAJCQkJICAgICBHRlBfS0VSTkVMKTsNCj4gIAlpZiAoIXBpbmZvLT5ncGlvcykNCj4g
QEAgLTc2OSw3ICs3ODgsMTggQEAgc3RhdGljIGludCBvZl9mc2xfc3BpX2dldF9jaGlwc2VsZWN0
cyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJCX0NCj4gIAl9DQo+ICANCj4gLQlwZGF0YS0+bWF4
X2NoaXBzZWxlY3QgPSBuZ3Bpb3M7DQo+ICsjaWYgSVNfRU5BQkxFRChDT05GSUdfRlNMX1NPQykN
Cj4gKwlpZiAoc3Bpc2VsX2Jvb3QpIHsNCj4gKwkJcGluZm8tPmltbXJfc3BpX2NzID0gaW9yZW1h
cChnZXRfaW1tcmJhc2UoKSArIElNTVJfU1BJX0NTX09GRlNFVCwgNCk7DQo+ICsJCWlmICghcGlu
Zm8tPmltbXJfc3BpX2NzKSB7DQo+ICsJCQlyZXQgPSAtRU5PTUVNOw0KPiArCQkJaSA9IG5ncGlv
cyAtIDE7DQo+ICsJCQlnb3RvIGVycl9sb29wOw0KPiArCQl9DQo+ICsJfQ0KPiArI2VuZGlmDQo+
ICsNCj4gKwlwZGF0YS0+bWF4X2NoaXBzZWxlY3QgPSBuZ3Bpb3MgKyBzcGlzZWxfYm9vdDsNCj4g
IAlwZGF0YS0+Y3NfY29udHJvbCA9IGZzbF9zcGlfY3NfY29udHJvbDsNCj4gIA0KPiAgCXJldHVy
biAwOw0KPiANCg0K
