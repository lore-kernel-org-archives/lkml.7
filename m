Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0570BC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F147205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=thinciit.onmicrosoft.com header.i=@thinciit.onmicrosoft.com header.b="cd9OAb9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbfDYMmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:42:55 -0400
Received: from rout2.hes.trendmicro.com ([54.67.38.140]:58535 "EHLO
        rout2.hes.trendmicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDYMmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:42:55 -0400
Received: from 0.0.0.0_hes.trendmicro.com (unknown [10.64.10.198])
        by rout2.hes.trendmicro.com (Postfix) with SMTP id 69E1AEFC046
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:42:53 +0000 (UTC)
Received: from IND01-BO1-obe.outbound.protection.outlook.com (unknown [104.47.101.59])
        by relay1.hes.trendmicro.com (TrendMicro Hosted Email Security) with ESMTPS id BBF9A142C18D;
        Thu, 25 Apr 2019 12:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thinciit.onmicrosoft.com; s=selector1-thinci-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gagKelH2NDZ1elwuuLKnAeAqWDsu2TH0Fg2RZ7b2rs=;
 b=cd9OAb9kMKicwBbOTmikIUW4cDmIP7Mj7INtEfvUNKCzY+HTmxQ2mO/lsYEA8wbzUMf+gP1+iRp6RnvzrdrMZWTGlX8aq1vTGjH+4Knl8TtIzhB2WqXqfjR7rTVWQcI+0XTi60hdZePfiC3+pPJ2Y7gbe9nrlhmmi510N95gDsM=
Received: from MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM (52.134.158.84) by
 MAXPR01MB3600.INDPRD01.PROD.OUTLOOK.COM (52.134.157.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 25 Apr 2019 12:42:48 +0000
Received: from MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8c8f:543a:ccd6:fe7a]) by MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8c8f:543a:ccd6:fe7a%2]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 12:42:48 +0000
From:   Matt Redfearn <matt.redfearn@thinci.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Archit Taneja <architt@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        Philippe Cornu <philippe.cornu@st.com>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Allow VPG to be enabled via
 debugfs
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: Allow VPG to be enabled via
 debugfs
Thread-Index: AQHU+qkfnnF7eMdiaUyqNeOuxcdkXaZMnfIAgAA1eYA=
Date:   Thu, 25 Apr 2019 12:42:48 +0000
Message-ID: <ac0b01b5-de42-727c-cee4-15371df56474@thinci.com>
References: <20190424142205.26088-1-matt.redfearn@thinci.com>
 <20190425093118.GC4557@pendragon.ideasonboard.com>
In-Reply-To: <20190425093118.GC4557@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0212.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::32) To MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:64::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=matthew.redfearn@thinci.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [87.242.198.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0a4ee14-d488-42c9-74f6-08d6c97b858e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MAXPR01MB3600;
x-ms-traffictypediagnostic: MAXPR01MB3600:
x-microsoft-antispam-prvs: <MAXPR01MB36009E091B84155EFFB0F9CAF13D0@MAXPR01MB3600.INDPRD01.PROD.OUTLOOK.COM>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(366004)(376002)(136003)(346002)(51914003)(199004)(189003)(25786009)(305945005)(6116002)(6246003)(53936002)(4326008)(7736002)(3846002)(31686004)(6512007)(68736007)(478600001)(229853002)(97736004)(6436002)(14454004)(66066001)(6916009)(6486002)(102836004)(64756008)(256004)(54906003)(8936002)(53546011)(476003)(26005)(11346002)(5660300002)(446003)(486006)(2616005)(36756003)(316002)(52116002)(76176011)(99286004)(71190400001)(71200400001)(81166006)(66946007)(5024004)(66556008)(8676002)(73956011)(66446008)(14444005)(2906002)(6506007)(31696002)(81156014)(186003)(66476007)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:MAXPR01MB3600;H:MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: thinci.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IDW3i8N98eVyawFvi3t/9YVQyw/x1ZatOdT+BOMCe7eZKkB1mGnFAj4k7bSa7MJuiG5E9ckoFjRFLN165cp3HnugLYSdoa1O6bYHqso6uXROfj8X9EST2wSxGrS748Dj4BjVUtLaj7zgWSI3DEtfsegltLuewjDoIM6aR2LpA7q824OO8Cgm0IPHeit4CgK3TT65A3ESVqdULzYsbTH3XdX5ApAXpZ0AzDfhEpHZjHGR8F1ITJNF+gXyGC8pagiQCEEHkPBOW6OFCYNb02nMuv3rrlIr7u5I7kRB7zYVmvs+JoChh9WslPdDg3pQBKf+jOKPmQXArEcwDO9Vz1iYg0x0enpP+FR+U8+R8PsZCnkms/rHFG8qtSHXVGHFN2Pdr+sUGjCODje4NyaItvk8OERozlj17AAGgb6e6V5Ksp0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <620D5CC4AC0983419AADEA9F43E05D79@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: thinci.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a4ee14-d488-42c9-74f6-08d6c97b858e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:42:48.1992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB3600
X-TMASE-Version: StarCloud-1.3-8.2.1013-24572.007
X-TMASE-Result: 10--14.032400-4.000000
X-TMASE-MatchedRID: UuaOI1zLN1iSfAmmPXvGRuYAh37ZsBDCjLOy13Cgb49RXC4cX65cJPBv
        7Bu/nOgyhUokMiNy+aa42Q68Rp7Dif2RvKEqDomUZj7E6vHnuNYRvEpVd3vS1d9RlPzeVuQQEXF
        HklABLo6TJ56+BLzoyNGV97hvR8uC2lUnG4pY3GyPmEs8Jfdl06++Humppw/G1JVSTP0E9d6XBZ
        /v/hLIO1WbS+5sTc39rJf0BEhPthE9bdnyYD6z84sKNaNh88CQ7f6JAS2hKPiiXe5nNnUYtyksj
        JeAae2uP39/XlQrt+6Vd67STdAe7UMpVZZsZyZGutvHF25zoU8xXH/dlhvLv0jINjnv2/BMW9oS
        zMAtdLLi8zVgXoAlttUfIakorPe9d4IUx+qHRSmDGx/OQ1GV8rHlqZYrZqdI+gtHj7OwNO3DW0x
        VTs41PFH3jrKBCaTOOi3xMT6KZSUIFTlwlvDFYReIakY2mwC0
X-TM-Deliver-Signature: 521BBF91F613AB22E2FB3E6EE4D07533
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmVudCwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KDQoNCk9uIDI1LzA0LzIwMTkg
MTA6MzEsIExhdXJlbnQgUGluY2hhcnQgd3JvdGU6DQo+IE9uIFdlZCwgQXByIDI0LCAyMDE5IGF0
IDAyOjIyOjE4UE0gKzAwMDAsIE1hdHQgUmVkZmVhcm4gd3JvdGU6DQo+PiBUaGUgU3lub3BzeXMg
TUlQSSBEU0kgSVAgY29udGFpbnMgYSB2aWRlbyB0ZXN0IHBhdHRlcm4gZ2VuZXJhdG9yIHdoaWNo
DQo+PiBpcyBoZWxwZnVsIGluIGRlYnVnZ2luZyB2aWRlbyB0aW1pbmcgd2l0aCBjb25uZWN0ZWQg
ZGlzcGxheXMuDQo+PiBBZGQgYSBkZWJ1Z2ZzIGRpcmVjdG9yeSBjb250YWluaW5nIGZpbGVzIHdo
aWNoIGFsbG93IHRoZSBWUEcgdG8gYmUNCj4+IGVuYWJsZWQgYW5kIGRpc2FibGVkLCBhbmQgaXQn
cyBvcmllbnRhdGlvbiB0byBiZSBjaGFuZ2VkLg0KPiANCj4gcy9pdCdzL2l0cy8NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBNYXR0IFJlZGZlYXJuIDxtYXR0LnJlZGZlYXJuQHRoaW5jaS5jb20+DQo+
Pg0KPj4gLS0tDQo+Pg0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LW1p
cGktZHNpLmMgfCA1NSArKysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1
NSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9icmlk
Z2Uvc3lub3BzeXMvZHctbWlwaS1kc2kuYyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3Bz
eXMvZHctbWlwaS1kc2kuYw0KPj4gaW5kZXggMGVlNDQwMjE2YjguLmExZWUyMzA2MzgyIDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9kdy1taXBpLWRzaS5j
DQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LW1pcGktZHNpLmMN
Cj4+IEBAIC0xMCw2ICsxMCw3IEBADQo+PiAgIA0KPj4gICAjaW5jbHVkZSA8bGludXgvY2xrLmg+
DQo+PiAgICNpbmNsdWRlIDxsaW51eC9jb21wb25lbnQuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgv
ZGVidWdmcy5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQo+PiAgICNpbmNsdWRl
IDxsaW51eC9tb2R1bGUuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPj4g
QEAgLTg2LDYgKzg3LDggQEANCj4+ICAgI2RlZmluZSBWSURfTU9ERV9UWVBFX05PTl9CVVJTVF9T
WU5DX0VWRU5UUwkweDENCj4+ICAgI2RlZmluZSBWSURfTU9ERV9UWVBFX0JVUlNUCQkJMHgyDQo+
PiAgICNkZWZpbmUgVklEX01PREVfVFlQRV9NQVNLCQkJMHgzDQo+PiArI2RlZmluZSBWSURfTU9E
RV9WUEdfRU5BQkxFCQlCSVQoMTYpDQo+PiArI2RlZmluZSBWSURfTU9ERV9WUEdfSE9SSVpPTlRB
TAkJQklUKDI0KQ0KPj4gICANCj4+ICAgI2RlZmluZSBEU0lfVklEX1BLVF9TSVpFCQkweDNjDQo+
PiAgICNkZWZpbmUgVklEX1BLVF9TSVpFKHApCQkJKChwKSAmIDB4M2ZmZikNCj4+IEBAIC0yMzQs
NiArMjM3LDE1IEBAIHN0cnVjdCBkd19taXBpX2RzaSB7DQo+PiAgIAl1MzIgZm9ybWF0Ow0KPj4g
ICAJdW5zaWduZWQgbG9uZyBtb2RlX2ZsYWdzOw0KPj4gICANCj4+ICsjaWZkZWYgQ09ORklHX0RF
QlVHX0ZTDQo+PiArCXN0cnVjdCBkZW50cnkgKmRlYnVnZnNfcm9vdDsNCj4+ICsJc3RydWN0IGRl
bnRyeSAqZGVidWdmc192cGc7DQo+PiArCXN0cnVjdCBkZW50cnkgKmRlYnVnZnNfdnBnX2hvcml6
b250YWw7DQo+PiArDQo+PiArCWJvb2wgdnBnOw0KPj4gKwlib29sIHZwZ19ob3Jpem9udGFsOw0K
Pj4gKyNlbmRpZiAvKiBDT05GSUdfREVCVUdfRlMgKi8NCj4+ICsNCj4+ICAgCXN0cnVjdCBkd19t
aXBpX2RzaSAqbWFzdGVyOyAvKiBkdWFsLWRzaSBtYXN0ZXIgcHRyICovDQo+PiAgIAlzdHJ1Y3Qg
ZHdfbWlwaV9kc2kgKnNsYXZlOyAvKiBkdWFsLWRzaSBzbGF2ZSBwdHIgKi8NCj4+ICAgDQo+PiBA
QCAtNTI1LDYgKzUzNywxMSBAQCBzdGF0aWMgdm9pZCBkd19taXBpX2RzaV92aWRlb19tb2RlX2Nv
bmZpZyhzdHJ1Y3QgZHdfbWlwaV9kc2kgKmRzaSkNCj4+ICAgCWVsc2UNCj4+ICAgCQl2YWwgfD0g
VklEX01PREVfVFlQRV9OT05fQlVSU1RfU1lOQ19FVkVOVFM7DQo+PiAgIA0KPj4gKwlpZiAoZHNp
LT52cGcpIHsNCj4gDQo+IFdvbid0IHRoaXMgYnJlYWsgaWYgQ09ORklHX0RERUJVR19GUyBpcyBu
b3QgZGVmaW5lZCA/DQoNCkFoIHllcyAtIHF1aXRlIHJpZ2h0Lg0KDQo+IA0KPj4gKwkJdmFsIHw9
IFZJRF9NT0RFX1ZQR19FTkFCTEU7DQo+PiArCQl2YWwgfD0gZHNpLT52cGdfaG9yaXpvbnRhbCA/
IFZJRF9NT0RFX1ZQR19IT1JJWk9OVEFMIDogMDsNCj4+ICsJfQ0KPj4gKw0KPj4gICAJZHNpX3dy
aXRlKGRzaSwgRFNJX1ZJRF9NT0RFX0NGRywgdmFsKTsNCj4+ICAgfQ0KPj4gICANCj4+IEBAIC05
MzUsNiArOTUyLDQxIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2JyaWRnZV9mdW5jcyBkd19t
aXBpX2RzaV9icmlkZ2VfZnVuY3MgPSB7DQo+PiAgIAkuYXR0YWNoCSAgICAgID0gZHdfbWlwaV9k
c2lfYnJpZGdlX2F0dGFjaCwNCj4+ICAgfTsNCj4+ICAgDQo+PiArI2lmZGVmIENPTkZJR19ERUJV
R19GUw0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIGR3X21pcGlfZHNpX2RlYnVnZnNfaW5pdChzdHJ1
Y3QgZHdfbWlwaV9kc2kgKmRzaSkNCj4+ICt7DQo+PiArCXN0cnVjdCBkZW50cnkgKmQ7DQo+PiAr
DQo+PiArCWQgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoZGV2X25hbWUoZHNpLT5kZXYpLCBOVUxMKTsN
Cj4+ICsJaWYgKElTX0VSUihkKSkgew0KPj4gKwkJZGV2X2Vycihkc2ktPmRldiwgImZhaWxlZCB0
byBjcmVhdGUgZGVidWdmcyByb290XG4iKTsNCj4+ICsJCXJldHVybjsNCj4+ICsJfQ0KPj4gKwlk
c2ktPmRlYnVnZnNfcm9vdCA9IGQ7DQo+PiArDQo+PiArCWQgPSBkZWJ1Z2ZzX2NyZWF0ZV9ib29s
KCJ2cGciLCAwNjYwLCBkc2ktPmRlYnVnZnNfcm9vdCwgJmRzaS0+dnBnKTsNCj4+ICsJZHNpLT5k
ZWJ1Z2ZzX3ZwZyA9IGQ7DQo+IA0KPiBJZiB5b3UgZG9uJ3QgaGFuZGxlIGZhaWx1cmVzIGhlcmUg
eW91IGRvbid0IG5lZWQgdGhlIGludGVybWVkaWF0ZSBkDQo+IHZhcmlhYmxlLCB5b3UgY2FuIGp1
c3QgYXNzaWduIGRzaS0+ZGVidWdmc192cGcgZGlyZWN0bHkuDQoNClRydWUgLSBJIHdpbGwgdXBk
YXRlIGl0Lg0KDQo+IA0KPj4gKw0KPj4gKwlkID0gZGVidWdmc19jcmVhdGVfYm9vbCgidnBnX2hv
cml6b250YWwiLCAwNjYwLCBkc2ktPmRlYnVnZnNfcm9vdCwNCj4+ICsJCQkJJmRzaS0+dnBnX2hv
cml6b250YWwpOw0KPj4gKwlkc2ktPmRlYnVnZnNfdnBnX2hvcml6b250YWwgPSBkOw0KPiANCj4g
U2FtZSBoZXJlLg0KDQoNCkFuZCBoZXJlIC0gdGhhbmtzIQ0KDQpNYXR0DQoNCj4gDQo+PiArfQ0K
Pj4gKw0KPj4gK3N0YXRpYyB2b2lkIGR3X21pcGlfZHNpX2RlYnVnZnNfcmVtb3ZlKHN0cnVjdCBk
d19taXBpX2RzaSAqZHNpKQ0KPj4gK3sNCj4+ICsJZGVidWdmc19yZW1vdmUoZHNpLT5kZWJ1Z2Zz
X3ZwZ19ob3Jpem9udGFsKTsNCj4+ICsJZGVidWdmc19yZW1vdmUoZHNpLT5kZWJ1Z2ZzX3ZwZyk7
DQo+PiArCWRlYnVnZnNfcmVtb3ZlKGRzaS0+ZGVidWdmc19yb290KTsNCj4+ICt9DQo+PiArDQo+
PiArI2Vsc2UNCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBkd19taXBpX2RzaV9kZWJ1Z2ZzX2luaXQo
c3RydWN0IGR3X21pcGlfZHNpICpkc2kpIHsgfQ0KPj4gK3N0YXRpYyB2b2lkIGR3X21pcGlfZHNp
X2RlYnVnZnNfcmVtb3ZlKHN0cnVjdCBkd19taXBpX2RzaSAqZHNpKSB7IH0NCj4+ICsNCj4+ICsj
ZW5kaWYgLyogQ09ORklHX0RFQlVHX0ZTICovDQo+PiArDQo+PiAgIHN0YXRpYyBzdHJ1Y3QgZHdf
bWlwaV9kc2kgKg0KPj4gICBfX2R3X21pcGlfZHNpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYsDQo+PiAgIAkJICAgIGNvbnN0IHN0cnVjdCBkd19taXBpX2RzaV9wbGF0X2RhdGEg
KnBsYXRfZGF0YSkNCj4+IEBAIC0xMDA1LDYgKzEwNTcsNyBAQCBfX2R3X21pcGlfZHNpX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+PiAgIAkJY2xrX2Rpc2FibGVfdW5wcmVw
YXJlKGRzaS0+cGNsayk7DQo+PiAgIAl9DQo+PiAgIA0KPj4gKwlkd19taXBpX2RzaV9kZWJ1Z2Zz
X2luaXQoZHNpKTsNCj4+ICAgCXBtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+PiAgIA0KPj4gICAJ
ZHNpLT5kc2lfaG9zdC5vcHMgPSAmZHdfbWlwaV9kc2lfaG9zdF9vcHM7DQo+PiBAQCAtMTAxMiw2
ICsxMDY1LDcgQEAgX19kd19taXBpX2RzaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2LA0KPj4gICAJcmV0ID0gbWlwaV9kc2lfaG9zdF9yZWdpc3RlcigmZHNpLT5kc2lfaG9zdCk7
DQo+PiAgIAlpZiAocmV0KSB7DQo+PiAgIAkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmVnaXN0
ZXIgTUlQSSBob3N0OiAlZFxuIiwgcmV0KTsNCj4+ICsJCWR3X21pcGlfZHNpX2RlYnVnZnNfcmVt
b3ZlKGRzaSk7DQo+PiAgIAkJcmV0dXJuIEVSUl9QVFIocmV0KTsNCj4+ICAgCX0NCj4+ICAgDQo+
PiBAQCAtMTAyOSw2ICsxMDgzLDcgQEAgc3RhdGljIHZvaWQgX19kd19taXBpX2RzaV9yZW1vdmUo
c3RydWN0IGR3X21pcGlfZHNpICpkc2kpDQo+PiAgIAltaXBpX2RzaV9ob3N0X3VucmVnaXN0ZXIo
JmRzaS0+ZHNpX2hvc3QpOw0KPj4gICANCj4+ICAgCXBtX3J1bnRpbWVfZGlzYWJsZShkc2ktPmRl
dik7DQo+PiArCWR3X21pcGlfZHNpX2RlYnVnZnNfcmVtb3ZlKGRzaSk7DQo+PiAgIH0NCj4+ICAg
DQo+PiAgIHZvaWQgZHdfbWlwaV9kc2lfc2V0X3NsYXZlKHN0cnVjdCBkd19taXBpX2RzaSAqZHNp
LCBzdHJ1Y3QgZHdfbWlwaV9kc2kgKnNsYXZlKQ0KPiANCg==
