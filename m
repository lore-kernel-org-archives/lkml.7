Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E34C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A498827137
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="vGYtnGN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfFCQWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:22:17 -0400
Received: from mail-eopbgr10097.outbound.protection.outlook.com ([40.107.1.97]:41118
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727162AbfFCQWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVw07+H6t9IJssNcxKJPIUopInbykOhBuKHs0nJkON4=;
 b=vGYtnGN0JO5CReJ0jz+4EZeUbDVGgEhd4F7oNq9wJdSvv0+AtKl9DmOyzBL9HgBIaxBPb5ZaTAFmSn6DuEba+0c2DUXSxie0uFtIll9saWxXg+szAm2LP6SynD0FotNvP1UPtIGKER/0y3rMO0g7GrpmCwBgw3qqNFXICwAVcDk=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3276.eurprd02.prod.outlook.com (52.134.70.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 3 Jun 2019 16:22:11 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf%5]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 16:22:11 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [RFC PATCH 39/57] drivers: mux: Use class_find_device_by_of_node
 helper
Thread-Topic: [RFC PATCH 39/57] drivers: mux: Use class_find_device_by_of_node
 helper
Thread-Index: AQHVGiRK+afNbt1GvU2kh+pKzFah5qaKHLEA
Date:   Mon, 3 Jun 2019 16:22:11 +0000
Message-ID: <bdfa93d6-a45f-cc26-bc95-42ef21c7e8c6@axentia.se>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-40-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1559577023-558-40-git-send-email-suzuki.poulose@arm.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR05CA0276.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::28) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e21b3ad-fdc8-4737-58f4-08d6e83fa185
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3276;
x-ms-traffictypediagnostic: DB3PR0202MB3276:
x-microsoft-antispam-prvs: <DB3PR0202MB327667AF28145279DCCBE1C8BC140@DB3PR0202MB3276.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(346002)(366004)(376002)(396003)(199004)(189003)(8676002)(305945005)(86362001)(65826007)(7736002)(73956011)(6246003)(31686004)(53546011)(6506007)(74482002)(31696002)(71200400001)(66946007)(66446008)(64756008)(66556008)(66476007)(71190400001)(386003)(53936002)(2501003)(65956001)(76176011)(66066001)(81166006)(81156014)(4326008)(8936002)(65806001)(25786009)(6116002)(316002)(229853002)(110136005)(99286004)(6512007)(186003)(58126008)(64126003)(2906002)(3846002)(5660300002)(11346002)(256004)(6486002)(102836004)(26005)(476003)(486006)(36756003)(6436002)(2616005)(446003)(508600001)(54906003)(68736007)(14454004)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3276;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rCwX+k/piL9dG112K29WqlkBj7lmdz0JYiQ3oghBmsLuUfNYMzj+IrW4t3+55BgXz59i5jJYMaos2kuug608GcEGPVYGi4v6jpubLVJLvyp7TIBtPjfZvcZR8K5u29ofImJ1QOMLtJVjxe6EQPiPgrH53Vq96ItVz+lj7VMMJQ8galBgdbggh0JIaDRzV0NBjc56m5ThUW3OMVs1/6h96+nOrM5qGrP25XG/K5XJECnWfe0s4dWr+nuzFcmApIz+cOIgGNHJykQmZSeNXBE4lfn8BpoJ2swB719s39Vdo5jaxUO1aPJYNKD+uGgLF5M7BFjRbrsfdUd7XXW9TN28WIe3azGLkfnpUYftBnUgStjzzwcsqAaazNHGpprAPt0ClecfZa5qO2XIlG7FucHBwrxCvPQheFKHWj2tHgadVhk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9913D8C48743F4DA6D94A3010247592@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e21b3ad-fdc8-4737-58f4-08d6e83fa185
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 16:22:11.2027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peda@axentia.se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3276
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNClRoaXMgYWxsIHNvdW5kcyBsaWtlIG5pY2UgY2hhbmdlcy4gRmlyc3QgYSBjb3VwbGUg
b2Ygbml0cGlja3M6DQoNCkZyb20gdGhlIGNvdmVyIGxldHRlciwgaW5jbHVkZWQgaGVyZSB0byBz
cGFyZSBtb3N0IG9mIHRoZSBvdGhlcnMuLi4NCg0KPiBzdWJzeXN0ZW1zLiBUaGlzIHNlcmllcyBp
cyBhbiBhdHRlbXB0IHRvIGNvbnNvbGlkYXRlIHRoZSBhbmQgY2xlYW51cA0KDQpzL3RoZSBhbmQv
YW5kLw0KDQpPbiAyMDE5LTA2LTAzIDE3OjUwLCBTdXp1a2kgSyBQb3Vsb3NlIHdyb3RlOg0KPiBV
c2UgdGhlIGdlbmVyaWMgaGVscGVyIHRvIGZpbmQgYSBkZXZpY2UgbWF0Y2hpbmcgdGhlIG9mX25v
ZGUuDQo+IA0KPiBDYzogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4NCj4gU2lnbmVkLW9m
Zi1ieTogU3V6dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL211eC9jb3JlLmMgfCA4ICstLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
dXgvY29yZS5jIGIvZHJpdmVycy9tdXgvY29yZS5jDQo+IGluZGV4IGQxMjcxYzEuLjM1OTFlNDAg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXV4L2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL211eC9j
b3JlLmMNCj4gQEAgLTQwNSwxOCArNDA1LDEyIEBAIGludCBtdXhfY29udHJvbF9kZXNlbGVjdChz
dHJ1Y3QgbXV4X2NvbnRyb2wgKm11eCkNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BMKG11eF9j
b250cm9sX2Rlc2VsZWN0KTsNCj4gIA0KPiAtc3RhdGljIGludCBvZl9kZXZfbm9kZV9tYXRjaChz
dHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IHZvaWQgKmRhdGEpDQo+IC17DQo+IC0JcmV0dXJuIGRl
di0+b2Zfbm9kZSA9PSBkYXRhOw0KPiAtfQ0KPiAtDQo+ICAvKiBOb3RlIHRoaXMgZnVuY3Rpb24g
cmV0dXJucyBhIHJlZmVyZW5jZSB0byB0aGUgbXV4X2NoaXAgZGV2LiAqLw0KPiAgc3RhdGljIHN0
cnVjdCBtdXhfY2hpcCAqb2ZfZmluZF9tdXhfY2hpcF9ieV9ub2RlKHN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbnApDQo+ICB7DQo+ICAJc3RydWN0IGRldmljZSAqZGV2Ow0KPiAgDQo+IC0JZGV2ID0gY2xh
c3NfZmluZF9kZXZpY2UoJm11eF9jbGFzcywgTlVMTCwgbnAsIG9mX2Rldl9ub2RlX21hdGNoKTsN
Cj4gLQ0KDQpOaXRwaWNrICMyLiBQbGVhc2UgbGVhdmUgdGhlIGJsYW5rIGxpbmUgd2hlcmUgaXQg
YmVsb25ncy4NCg0KSG93ZXZlciwgaG93IGNhbiBJIHJldmlldyB0aGlzIGlmIEkgZG8gbm90IGdl
dCB0byBzZWUgdGhlIHBhdGNoIHRoYXQNCmFkZHMgdGhlIGNsYXNzX2ZpbmRfZGV2aWNlX2J5X29m
X25vZGUgZnVuY3Rpb24/IFBsZWFzZSBwcm92aWRlIGENCmxpdHRsZSBiaXQgbW9yZSBjb250ZXh0
IQ0KDQpDaGVlcnMsDQpQZXRlcg0KDQo+ICsJZGV2ID0gY2xhc3NfZmluZF9kZXZpY2VfYnlfb2Zf
bm9kZSgmbXV4X2NsYXNzLCBOVUxMLCBucCk7DQo+ICAJcmV0dXJuIGRldiA/IHRvX211eF9jaGlw
KGRldikgOiBOVUxMOw0KPiAgfQ0KPiAgDQo+IA0K
