Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49144C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBD420643
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=thinciit.onmicrosoft.com header.i=@thinciit.onmicrosoft.com header.b="NrkNL3iH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfDYMji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:39:38 -0400
Received: from rout5.hes.trendmicro.com ([54.219.188.4]:52591 "EHLO
        rout5.hes.trendmicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDYMjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:39:37 -0400
Received: from 0.0.0.0_hes.trendmicro.com (unknown [10.64.10.65])
        by rout5.hes.trendmicro.com (Postfix) with SMTP id 643C6EFC06B;
        Thu, 25 Apr 2019 12:39:36 +0000 (UTC)
Received: from IND01-BO1-obe.outbound.protection.outlook.com (unknown [104.47.101.55])
        by relay1.hes.trendmicro.com (TrendMicro Hosted Email Security) with ESMTPS id 5AE84142C0AD;
        Thu, 25 Apr 2019 12:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thinciit.onmicrosoft.com; s=selector1-thinci-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLt1gVCtYnHhzdwOImhRChXyI1IvDmLIelYxUfbX+MM=;
 b=NrkNL3iH0ur9ATJ33Cba3kmUE0IAL+o6y++l0c8XMarGUxm1fnlR5+/ue+HDApLyoDR/r3XuTJNfK8fRzZxnGPjJcvy9LF+pUd4uZ6zk728ws8//Ork3apXbklzfE2ZhOFMjARDmGiCBSDZ3QEdTur8EA1tKqEJzb8Hk2FB2tDs=
Received: from MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM (52.134.158.84) by
 MAXPR01MB3600.INDPRD01.PROD.OUTLOOK.COM (52.134.157.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 25 Apr 2019 12:39:28 +0000
Received: from MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8c8f:543a:ccd6:fe7a]) by MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8c8f:543a:ccd6:fe7a%2]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 12:39:28 +0000
From:   Matt Redfearn <matt.redfearn@thinci.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Philippe Cornu <philippe.cornu@st.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Archit Taneja <architt@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Don't blindly call post_disable
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: Don't blindly call
 post_disable
Thread-Index: AQHU+qkUj1HzsBP9eU2naClnjE4OuqZMy1aAgAAHJ4A=
Date:   Thu, 25 Apr 2019 12:39:27 +0000
Message-ID: <95c36782-7eaf-2224-bb52-cff0a53d98d8@thinci.com>
References: <CGME20190424142210epcas3p403bd5159852ab4e90eca1be67800ecde@epcas3p4.samsung.com>
 <20190424142148.25927-1-matt.redfearn@thinci.com>
 <3da4c0a3-a77b-5128-63f7-9c8d6b012c68@samsung.com>
In-Reply-To: <3da4c0a3-a77b-5128-63f7-9c8d6b012c68@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR02CA0006.eurprd02.prod.outlook.com
 (2603:10a6:6:15::19) To MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:64::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=matthew.redfearn@thinci.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [87.242.198.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 728cfca8-b36c-4569-45de-08d6c97b0e4d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MAXPR01MB3600;
x-ms-traffictypediagnostic: MAXPR01MB3600:
x-microsoft-antispam-prvs: <MAXPR01MB3600F3F991E79FB54BD11FDCF13D0@MAXPR01MB3600.INDPRD01.PROD.OUTLOOK.COM>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(366004)(376002)(136003)(346002)(199004)(189003)(25786009)(305945005)(6116002)(7416002)(6246003)(53936002)(4326008)(7736002)(3846002)(31686004)(6512007)(68736007)(478600001)(229853002)(97736004)(6436002)(14454004)(66066001)(6486002)(102836004)(64756008)(256004)(54906003)(8936002)(53546011)(476003)(26005)(11346002)(5660300002)(446003)(486006)(2616005)(36756003)(316002)(52116002)(76176011)(99286004)(71190400001)(71200400001)(81166006)(66946007)(66556008)(8676002)(73956011)(66446008)(14444005)(2906002)(6506007)(31696002)(81156014)(186003)(110136005)(66476007)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:MAXPR01MB3600;H:MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: thinci.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h47p0+SvWtxv3yko/P/rrJNJiW8UUQp/lAVnlDOiXqn/q6FNq9XJLspTnLi9jyjryjHGBBT7LLIKCL/HDgwZoT29MYNCqJq7uBILIHIqQQCZUIGMzb6Oj7PSiCOkrlNfW5Zqy2Ymc6DKgDYZUdWi0I25N/u4i5C+36pf5LscMbPLdnq1CGjapc4PLL5vlPbBdyipeyWmkqDmsvaPi8QfUO1142WaWenqHmLlZ6STHUDKd0XdhLODtUv1BB5kpr01m3JUXM267SYwB9lS0Yo+eh9/odplu6wN8zlV77xRFGnh2oqHqo0cVGWTUEB1DPXKkaLRUsDD7gGjS2q3zmFpWLAiUyPkVolKB3zh++CK+0G/yP7zNnykLDPrgJqLleCPI+xZasDhZkkiD2+lSmRlAHo60OAwm/qdsbLY82crg7g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDD7503909642D4A9E9E9FE205475BD5@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: thinci.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728cfca8-b36c-4569-45de-08d6c97b0e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:39:27.9981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB3600
X-TMASE-Version: StarCloud-1.3-8.2.1013-24572.007
X-TMASE-Result: 10--10.565900-4.000000
X-TMASE-MatchedRID: u7Yf2n7Ca/0OwH4pD14DsPHkpkyUphL9FuNF4lJG6xtIyDY579vwTCbR
        wYCA7OowGafy0sn9g0ZHVle6mAl0dQXl7w+ur8elVU3yVpaj3QwnAUsgdVnp+xcEzr0UIqADvFf
        PytWHA2khXi7xgp14qwG2ORx9Eyap3CtEsOTZxuKBlNt4VSGvIdJ178I1tpklxSZxKZrfThNFQm
        CP4adJATebgFOGUoOXX07Sn912HMw5HWa1kxc3Mf9Ci025qU0xyeUl7aCTy8i7+NPPxj+R6nHyD
        p4fu+gqJZ5+dQl9ac9+NZ4lfSsps4f1OcQR3MIT0gVVXNgaM0qcIZLVZAQa0I7xHquoAJGGq7rF
        UcuGp/EgBwKKRHe+r1I6nBAvPlKt7p7SoAVOS6LslI6MxjzE4caQMxpU+MJnAcIVrF+S0nM=
X-TM-Deliver-Signature: F9526AD280FD159FD924F4F6FAB49FB4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcnplaiwNCg0KT24gMjUvMDQvMjAxOSAxMzoxMywgQW5kcnplaiBIYWpkYSB3cm90ZToN
Cj4gT24gMjQuMDQuMjAxOSAxNjoyMiwgTWF0dCBSZWRmZWFybiB3cm90ZToNCj4+IFRoZSBEUk0g
ZG9jdW1lbnRhdGlvbiBzdGF0ZXMgdGhhdCBwb3N0X2Rpc2FibGUgaXMgYW4gb3B0aW9uYWwgY2Fs
bGJhY2suDQo+PiBBcyBzdWNoIGFuIGltcGxlbWVudGluZyBkZXZpY2UgbWF5IG5vdCBwb3B1bGF0
ZSBpdC4gVG8gYXZvaWQgcGFuaWNpbmcNCj4+IHRoZSBrZXJuZWwgYnkgY2FsbGluZyBhIE5VTEwg
ZnVuY3Rpb24gcG9pbnRlciwgd2Ugc2hvdWxkIE5VTEwgY2hlY2sgaXQNCj4+IGJlZm9yZSBibGlu
ZHkgY2FsbGluZyBpdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNYXR0IFJlZGZlYXJuIDxtYXR0
LnJlZGZlYXJuQHRoaW5jaS5jb20+DQo+IA0KPj4gLS0tDQo+Pg0KPj4gICBkcml2ZXJzL2dwdS9k
cm0vYnJpZGdlL3N5bm9wc3lzL2R3LW1pcGktZHNpLmMgfCAzICsrLQ0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctbWlwaS1kc2kuYyBiL2RyaXZlcnMv
Z3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctbWlwaS1kc2kuYw0KPj4gaW5kZXggMzhlODgwNzEz
NjMuLjBlZTQ0MDIxNmI4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9z
eW5vcHN5cy9kdy1taXBpLWRzaS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5
bm9wc3lzL2R3LW1pcGktZHNpLmMNCj4+IEBAIC04MDUsNyArODA1LDggQEAgc3RhdGljIHZvaWQg
ZHdfbWlwaV9kc2lfYnJpZGdlX3Bvc3RfZGlzYWJsZShzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdl
KQ0KPj4gICAJICogVGhpcyBuZWVkcyB0byBiZSBmaXhlZCBpbiB0aGUgZHJtX2JyaWRnZSBmcmFt
ZXdvcmsgYW5kIHRoZSBBUEkNCj4+ICAgCSAqIG5lZWRzIHRvIGJlIHVwZGF0ZWQgdG8gbWFuYWdl
IG91ciBvd24gY2FsbCBjaGFpbnMuLi4NCj4+ICAgCSAqLw0KPj4gLQlkc2ktPnBhbmVsX2JyaWRn
ZS0+ZnVuY3MtPnBvc3RfZGlzYWJsZShkc2ktPnBhbmVsX2JyaWRnZSk7DQo+PiArCWlmIChkc2kt
PnBhbmVsX2JyaWRnZS0+ZnVuY3MtPnBvc3RfZGlzYWJsZSkNCj4+ICsJCWRzaS0+cGFuZWxfYnJp
ZGdlLT5mdW5jcy0+cG9zdF9kaXNhYmxlKGRzaS0+cGFuZWxfYnJpZGdlKTsNCj4+ICAgDQo+IA0K
PiBXaHkgbm90IGRybV9icmlkZ2VfcG9zdF9kaXNhYmxlID8NCg0KQWggLSB0aGF0IHNlZW1zIGxp
a2UgYSBuaWNlciBmaXghIERvIHlvdSB0aGluayB0aGUgY29tbWVudCBhYm92ZSANCmRlc2NyaWJp
bmcgd2h5IHRoaXMgZnVuY3Rpb24gcG9pbnRlciBpcyBjYWxsZWQgZGlyZWN0bHkgY2FuIGJlIHJl
bW92ZWQgDQphcyB3ZWxsIGlmIHdlIGdvIHRoaXMgcm91dGU/DQoNCklmIHNvbWVvbmUgY2FsbHMg
ZHJtX2JyaWRnZV9wb3N0X2Rpc2FibGUoKSBvbiB0aGUgU3lucG9zeXMgRFNJIA0KZHJtX2JyaWRn
ZSBpdCB3aWxsIGdvIG9uIHRvIGNhbGwgcG9zdF9kaXNhYmxlIG9uIGFsbCBvdGhlciBicmlkZ2Vz
IGluIA0KdGhlIGNoYWluLCBpbiBhZGRpdGlvbiB0byB1cyBjYWxsaW5nIHRoZW0gaGVyZS4gSXMg
aXQgYW4gaXNzdWUgdG8gY2FsbCANCml0IG11bHRpcGxlIHRpbWVzPw0KDQpUaGFua3MsDQpNYXR0
DQoNCg0KPiANCj4gDQo+IFJlZ2FyZHMNCj4gDQo+IEFuZHJ6ZWoNCj4gDQo+IA0KPj4gICAJaWYg
KGRzaS0+c2xhdmUpIHsNCj4+ICAgCQlkd19taXBpX2RzaV9kaXNhYmxlKGRzaS0+c2xhdmUpOw0K
PiANCj4gDQo=
