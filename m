Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4475C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC64E2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="ZAb/N6bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfIWIj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:39:27 -0400
Received: from mail-eopbgr150098.outbound.protection.outlook.com ([40.107.15.98]:43966
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731212AbfIWIj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:39:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+xexyVs44ZXUa1VJZIQvBIB5h3+e1RsHlB3co8xzOp+O0rNFL0b6ArQLdF/uty29rir6BXg3Q7w+V51lGeNXOQ4wWD73HOf+hcxBPAVLrrwn/KfpvHVX41YEfoUwuIraZvkRYBdHu+iVBU2HhLuAsf7u/u4pSQetV9D/dsnyKrTanLOepcj/NVHT0wCcB5Wym21krT7K+/J/IwoF5S031ocqRTQhAuRb9WVtLVSiEnudaZ6FlaDkUjyxQfPD94jWbbm+rqqRyIKmp8rK7Wxm4pSP6Aq5zCurGIufGFZdUCvJI9VHFKsdRC3pXV4MwGJEINELls+t//f3/az1/N8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tX2BHCJ7Z8huuzN2et7FN9+63dSKbnj/S5ESEP8/bM=;
 b=VGvlKE1wEEm+q9g6U8KelhqWRwyb8UqgGbELbyu/Ggqg/+8dtIgwsf97UgQtPeeFhKttVzUsWK7n5iloMnwcwuuiEaF8QH6h6o64MilxqrsXMSbfVctzXaOWWNZNM7xNOd8NUUkpS/LI7V2O9d2GR04vLVODEq6eiGN4tTNov7216UY58mZP9D5aYNgFXwoXgKyOF5OWMMkW1K708GAG7r+xXybeP+RMjk8FqsNkbFrDi0OtfmBHvsq4jPx0d8huJ42s1STNH8YXWIRBgSw1PbrLNv89JLUXQ7ZsQ3D0FG7Un04nobHzGJYS0uLGbxgRCKBl7c/Ycaf78rMu6MmAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tX2BHCJ7Z8huuzN2et7FN9+63dSKbnj/S5ESEP8/bM=;
 b=ZAb/N6bq4Vow/DFm75jMogmv0N0ODrGp38RlAGykX2xo1yR7jLdScpBtl1tqRsCshgl55DhLtdGqYej4Ms6DNC6BJB2Mmyt7kE1ypIIaZlhxwT5amKhAy1xnWsuyzL/owXqhXy63gX3Pj3NdOA6LjrmoBfyRTRtEtsDEHEGKBIY=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3727.eurprd05.prod.outlook.com (52.134.8.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Mon, 23 Sep 2019 08:39:22 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::1179:c881:a516:644d]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::1179:c881:a516:644d%3]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 08:39:22 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "axel.lin@ingics.com" <axel.lin@ingics.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: fixed: Prevent NULL pointer dereference when
 !CONFIG_OF
Thread-Topic: [PATCH] regulator: fixed: Prevent NULL pointer dereference when
 !CONFIG_OF
Thread-Index: AQHVcO2drnXNq5g1uk6+hZO7h4qitKc48u+A
Date:   Mon, 23 Sep 2019 08:39:22 +0000
Message-ID: <b13f732bd17b21a5e39a8a13b678b66b2bd2fb4b.camel@toradex.com>
References: <20190922022928.28355-1-axel.lin@ingics.com>
In-Reply-To: <20190922022928.28355-1-axel.lin@ingics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fce5dd8c-3029-4f3f-3098-08d740018898
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3727;
x-ms-traffictypediagnostic: VI1PR0502MB3727:
x-microsoft-antispam-prvs: <VI1PR0502MB3727FBF8C8DFC2B6D0662CABF4850@VI1PR0502MB3727.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39840400004)(376002)(346002)(396003)(199004)(189003)(2616005)(446003)(25786009)(6116002)(11346002)(2906002)(6246003)(476003)(186003)(36756003)(99286004)(8676002)(26005)(102836004)(44832011)(478600001)(5660300002)(81166006)(81156014)(3846002)(76176011)(8936002)(6506007)(14454004)(305945005)(7736002)(91956017)(76116006)(86362001)(4326008)(6486002)(229853002)(486006)(71200400001)(66476007)(118296001)(66446008)(64756008)(66556008)(66946007)(71190400001)(6436002)(66066001)(2501003)(316002)(110136005)(54906003)(6512007)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3727;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hd66brUOc/J4jOYAAIwssXDe5orkwsdT0tq7NXySNdKMPt27D530fEdB/58fTWXqwYZEdz9mAEEalCfm3cmXaWgnKv8M4BYKnE4H/jBZD1R0SFW7F57lQup+r56Pa1S/rtLKMmoD1jNJ5RJ6LbIA6E2BysD0YK6iNlVrnmcfVIEXe5JH0DjgDN0+y+m9iKjInVhAEWMAqT9EdH3R+pO65i+Ban5C8uJoi4KdDv8GyCZf17RFYQJtiyY9tkmvo3vNESVYl7lMVtUm1YxyDfCUGLcSpm68ESsP1+S74894UDwMPWLE0ffZLw/65JbLR9kv265Op7jHw39k4xayLeIkDExYt2MsIuyWoIqkQQiARTu79ZTvR+eu4eVdBDaidEsqqiJ1rd5NHVxx54pfctwh5yvXnH08rwZdRkTfIH+p004=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <65111E886149304DA08A8D00C8C57E02@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce5dd8c-3029-4f3f-3098-08d740018898
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 08:39:22.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNyu+XmqNHDiSD+hvI8ZsH+ngSJaPZ95Kg2ruCtId+2j3ZIBkjUzG+2D07i5v5Mew9O6UoxijAeMXr7C00liiBZEDSr+9voOfRB10I/V7nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3727
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE5LTA5LTIyIGF0IDEwOjI5ICswODAwLCBBeGVsIExpbiB3cm90ZToNCj4gVXNl
IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSB3aGljaCBoYXMgTlVMTCB0ZXN0IGZvciBtYXRjaCBi
ZWZvcmUNCj4gZGVyZWZlcmVuY2UgbWF0Y2gtPmRhdGEuIEFkZCBOVUxMIHRlc3QgZm9yIGRydnR5
cGUgc28gaXQgc3RpbGwgd29ya3MNCj4gZm9yIGZpeGVkX3ZvbHRhZ2Vfb3BzIHdoZW4gIUNPTkZJ
R19PRi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxpbkBpbmdpY3MuY29t
Pg0KDQpSZXZpZXdlZC1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRv
cmFkZXguY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9yZWd1bGF0b3IvZml4ZWQuYyB8IDUgKyst
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZWd1bGF0b3IvZml4ZWQuYyBiL2RyaXZlcnMvcmVn
dWxhdG9yL2ZpeGVkLmMNCj4gaW5kZXggZDkwYTZmZDhjYmM3Li5mODE1MzMwNzAwNTggMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvcmVndWxhdG9yL2ZpeGVkLmMNCj4gKysrIGIvZHJpdmVycy9yZWd1
bGF0b3IvZml4ZWQuYw0KPiBAQCAtMTQ0LDggKzE0NCw3IEBAIHN0YXRpYyBpbnQgcmVnX2ZpeGVk
X3ZvbHRhZ2VfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiAgCXN0cnVjdCBmaXhlZF92b2x0YWdlX2Nv
bmZpZyAqY29uZmlnOw0KPiAgCXN0cnVjdCBmaXhlZF92b2x0YWdlX2RhdGEgKmRydmRhdGE7DQo+
IC0JY29uc3Qgc3RydWN0IGZpeGVkX2Rldl90eXBlICpkcnZ0eXBlID0NCj4gLQkJb2ZfbWF0Y2hf
ZGV2aWNlKGRldi0+ZHJpdmVyLT5vZl9tYXRjaF90YWJsZSwgZGV2KS0+ZGF0YTsNCj4gKwljb25z
dCBzdHJ1Y3QgZml4ZWRfZGV2X3R5cGUgKmRydnR5cGUgPQ0KPiBvZl9kZXZpY2VfZ2V0X21hdGNo
X2RhdGEoZGV2KTsNCj4gIAlzdHJ1Y3QgcmVndWxhdG9yX2NvbmZpZyBjZmcgPSB7IH07DQo+ICAJ
ZW51bSBncGlvZF9mbGFncyBnZmxhZ3M7DQo+ICAJaW50IHJldDsNCj4gQEAgLTE3Nyw3ICsxNzYs
NyBAQCBzdGF0aWMgaW50IHJlZ19maXhlZF92b2x0YWdlX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICAJZHJ2ZGF0YS0+ZGVzYy50eXBlID0gUkVHVUxBVE9SX1ZPTFRB
R0U7DQo+ICAJZHJ2ZGF0YS0+ZGVzYy5vd25lciA9IFRISVNfTU9EVUxFOw0KPiAgDQo+IC0JaWYg
KGRydnR5cGUtPmhhc19lbmFibGVfY2xvY2spIHsNCj4gKwlpZiAoZHJ2dHlwZSAmJiBkcnZ0eXBl
LT5oYXNfZW5hYmxlX2Nsb2NrKSB7DQo+ICAJCWRydmRhdGEtPmRlc2Mub3BzID0gJmZpeGVkX3Zv
bHRhZ2VfY2xrZW5hYmxlZF9vcHM7DQo+ICANCj4gIAkJZHJ2ZGF0YS0+ZW5hYmxlX2Nsb2NrID0g
ZGV2bV9jbGtfZ2V0KGRldiwgTlVMTCk7DQo=
