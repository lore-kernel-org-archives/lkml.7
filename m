Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E01C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE5D20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HvKEXY4P";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BYwL66vU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfDVVOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:14:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39008 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729544AbfDVVOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:14:02 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ML5Ov5027209;
        Mon, 22 Apr 2019 14:13:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dfcwkdCFb1ITGBunPP8DPIpmZ1z/oQrqiaAjsmIYB3w=;
 b=HvKEXY4P+mzelgP00ZEEBv5R97uDD/qSRJ8nX43QEa995QUgsJuurDbgy4sBWz8+sYAW
 Y7T6bKbHKRmrzheALaYUzc2oP9R/Pt2nVLNgKA6iRbsqbqc8zsKKHHNkBJUwesSgmndF
 P7N9yIv7uP3IQ/o0reOXNUPOLX+jPCSwdFo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s1k6mrk81-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 14:13:08 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 14:13:08 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Apr 2019 14:13:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfcwkdCFb1ITGBunPP8DPIpmZ1z/oQrqiaAjsmIYB3w=;
 b=BYwL66vUUjRwzpIDgMmyFDHS/fYGIWA7IqhmXgCXtcOnz1QsUsx2XU/Wmplgvyczq2XjOVLkZhGpQQFKF8Q3q6/Z+fALHcfu8ylDNuz77nP3H0aFaHEeLAAAW/PSw4k6JOkAOQ962C42F4l3vjPkUQ7sWu3lKBGnY06TCE1ag9Q=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2773.namprd15.prod.outlook.com (20.179.158.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Mon, 22 Apr 2019 21:13:06 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 21:13:06 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Matt Mullins <mmullins@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Andrew Hall <hall@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>
CC:     Song Liu <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>, Martin Lau <kafai@fb.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH bpf-next v3 5/5] selftests: bpf: test writable buffers in
 raw tps
Thread-Topic: [PATCH bpf-next v3 5/5] selftests: bpf: test writable buffers in
 raw tps
Thread-Index: AQHU9vOZImYJPp9DbEuPi8caOMwjQ6ZIhW2AgAAPZACAAB2dgA==
Date:   Mon, 22 Apr 2019 21:13:06 +0000
Message-ID: <7a82ca1d-dc92-cd03-0dff-3329d8f11774@fb.com>
References: <20190419210409.5021-1-mmullins@fb.com>
 <20190419210409.5021-6-mmullins@fb.com>
 <7f32dd3c-a1e1-2965-3a98-3fa9e54e8501@fb.com>
 <7a40c2851cd6f708a11cd003a05ab79c8644b10d.camel@fb.com>
In-Reply-To: <7a40c2851cd6f708a11cd003a05ab79c8644b10d.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0096.namprd02.prod.outlook.com
 (2603:10b6:301:75::37) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:417e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02da6bfc-8cfb-4f7e-1b29-08d6c7675019
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2773;
x-ms-traffictypediagnostic: BYAPR15MB2773:
x-microsoft-antispam-prvs: <BYAPR15MB277396980D9D103A35804C26D3220@BYAPR15MB2773.namprd15.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(396003)(346002)(136003)(199004)(189003)(6506007)(102836004)(386003)(446003)(53546011)(476003)(53936002)(71200400001)(6116002)(2906002)(6486002)(229853002)(4326008)(25786009)(6246003)(76176011)(5660300002)(31686004)(2616005)(46003)(71190400001)(52116002)(186003)(6436002)(486006)(99286004)(316002)(5024004)(7416002)(14444005)(2501003)(54906003)(73956011)(110136005)(7736002)(305945005)(97736004)(256004)(66476007)(14454004)(68736007)(478600001)(11346002)(66446008)(64756008)(66556008)(66946007)(6512007)(8676002)(81156014)(81166006)(8936002)(93886005)(31696002)(86362001)(36756003)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2773;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0+szDqD78IZs+tkLDirkqwn98DUY2T4VSwjwSW7Q6y23h3XiZNWjTKnvt7tqsWFDNuJL90NXg2lIfnItclhviQtcXkrqzOnEixDYLhaFjvZFTvYh4wL1pYlcjaZqU4lxU839szcdDB0G71LuJEiv+DRqAw5XoGG/Yp+5uaDpoeOhsw11/LZ+CY/Vr8trGaqgeK9aEAcDJnRPyvabn2euxlrxBZ79RdiwLUyUEgEcFt5xwqV/6dsUOqYbMgG5lrZgViw/lsnVHMtMAQFEM3Wz3SUQcQPQsyjMCIrWCKmbT5JWKxoXYpqXSl2l9n4SzziQ4XxZPhrLlvDCYcZpPSL64Vj8xJw/JEBEjLWY1NWhRzIqhZN2WTH+JnGxQE1A/wkZNySTXm5i8pBI8jrDTrwkCRS1x8FTFiKjb8QTx7Et4Ac=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D87CCEF36ACA04590AB037FD189B376@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 02da6bfc-8cfb-4f7e-1b29-08d6c7675019
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 21:13:06.2668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2773
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMjIvMTkgMTI6MjcgUE0sIE1hdHQgTXVsbGlucyB3cm90ZToNCj4gT24gTW9uLCAy
MDE5LTA0LTIyIGF0IDE4OjMyICswMDAwLCBZb25naG9uZyBTb25nIHdyb3RlOg0KPj4NCj4+IE9u
IDQvMTkvMTkgMjowNCBQTSwgTWF0dCBNdWxsaW5zIHdyb3RlOg0KPj4+IFRoaXMgdGVzdHMgdGhh
dDoNCj4+PiAgICAgKiBhIEJQRl9QUk9HX1RZUEVfUkFXX1RSQUNFUE9JTlRfV1JJVEFCTEUgY2Fu
bm90IGJlIGF0dGFjaGVkIGlmIGl0DQo+Pj4gICAgICAgdXNlcyBlaXRoZXI6DQo+Pj4gICAgICAg
KiBhIHZhcmlhYmxlIG9mZnNldCB0byB0aGUgdHJhY2Vwb2ludCBidWZmZXIsIG9yDQo+Pj4gICAg
ICAgKiBhbiBvZmZzZXQgYmV5b25kIHRoZSBzaXplIG9mIHRoZSB0cmFjZXBvaW50IGJ1ZmZlcg0K
Pj4+ICAgICAqIGEgdHJhY2VyIGNhbiBtb2RpZnkgdGhlIGJ1ZmZlciBwcm92aWRlZCB3aGVuIGF0
dGFjaGVkIHRvIGEgd3JpdGFibGUNCj4+PiAgICAgICB0cmFjZXBvaW50IGluIGJwZl9wcm9nX3Rl
c3RfcnVuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXR0IE11bGxpbnMgPG1tdWxsaW5zQGZi
LmNvbT4NCj4+PiAtLS0NCj4+PiAgICBpbmNsdWRlL3RyYWNlL2V2ZW50cy9icGZfdGVzdF9ydW4u
aCAgICAgICAgICAgfCA1MCArKysrKysrKysrKysNCj4+PiAgICBuZXQvYnBmL3Rlc3RfcnVuLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArDQo+Pj4gICAgLi4uL3Jhd190cF93cml0
YWJsZV9yZWplY3RfbmJkX2ludmFsaWQuYyAgICAgIHwgNDAgKysrKysrKysrKw0KPj4+ICAgIC4u
Li9icGYvcHJvZ190ZXN0cy9yYXdfdHBfd3JpdGFibGVfdGVzdF9ydW4uYyB8IDgwICsrKysrKysr
KysrKysrKysrKysNCj4+PiAgICAuLi4vc2VsZnRlc3RzL2JwZi92ZXJpZmllci9yYXdfdHBfd3Jp
dGFibGUuYyAgfCAzNCArKysrKysrKw0KPj4+ICAgIDUgZmlsZXMgY2hhbmdlZCwgMjA4IGluc2Vy
dGlvbnMoKykNCj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS90cmFjZS9ldmVudHMv
YnBmX3Rlc3RfcnVuLmgNCj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvcmF3X3RwX3dyaXRhYmxlX3JlamVjdF9uYmRfaW52YWxp
ZC5jDQo+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi9wcm9nX3Rlc3RzL3Jhd190cF93cml0YWJsZV90ZXN0X3J1bi5jDQo+Pj4gICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi92ZXJpZmllci9yYXdfdHBfd3Jp
dGFibGUuYw0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHJhY2UvZXZlbnRzL2JwZl90
ZXN0X3J1bi5oIGIvaW5jbHVkZS90cmFjZS9ldmVudHMvYnBmX3Rlc3RfcnVuLmgNCj4+PiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uYWJmNDY2ODM5ZWE0DQo+
Pj4gLS0tIC9kZXYvbnVsbA0KPj4+ICsrKyBiL2luY2x1ZGUvdHJhY2UvZXZlbnRzL2JwZl90ZXN0
X3J1bi5oDQo+Pj4gQEAgLTAsMCArMSw1MCBAQA0KPj4+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMCAqLw0KPj4+ICsjdW5kZWYgVFJBQ0VfU1lTVEVNDQo+Pj4gKyNkZWZpbmUg
VFJBQ0VfU1lTVEVNIGJwZl90ZXN0X3J1bg0KPj4+ICsNCj4+PiArI2lmICFkZWZpbmVkKF9UUkFD
RV9OQkRfSCkgfHwgZGVmaW5lZChUUkFDRV9IRUFERVJfTVVMVElfUkVBRCkNCj4+PiArI2RlZmlu
ZSBfVFJBQ0VfQlBGX1RFU1RfUlVOX0gNCj4+PiArDQo+Pj4gKyNpbmNsdWRlIDxsaW51eC90cmFj
ZXBvaW50Lmg+DQo+Pj4gKw0KPj4+ICtERUNMQVJFX0VWRU5UX0NMQVNTKGJwZl90ZXN0X2Zpbmlz
aCwNCj4+PiArDQo+Pj4gKwlUUF9QUk9UTyhpbnQgKmVyciksDQo+Pj4gKw0KPj4+ICsJVFBfQVJH
UyhlcnIpLA0KPj4+ICsNCj4+PiArCVRQX1NUUlVDVF9fZW50cnkoDQo+Pj4gKwkJX19maWVsZChp
bnQsIGVycikNCj4+PiArCSksDQo+Pj4gKw0KPj4+ICsJVFBfZmFzdF9hc3NpZ24oDQo+Pj4gKwkJ
X19lbnRyeS0+ZXJyID0gKmVycjsNCj4+PiArCSksDQo+Pj4gKw0KPj4+ICsJVFBfcHJpbnRrKCJi
cGZfdGVzdF9maW5pc2ggd2l0aCBlcnI9JWQiLCBfX2VudHJ5LT5lcnIpDQo+Pj4gKyk7DQo+Pj4g
Kw0KPj4+ICsjaWZkZWYgREVGSU5FX0VWRU5UX1dSSVRBQkxFDQo+Pj4gKyN1bmRlZiBCUEZfVEVT
VF9SVU5fREVGSU5FX0VWRU5UDQo+Pj4gKyNkZWZpbmUgQlBGX1RFU1RfUlVOX0RFRklORV9FVkVO
VCh0ZW1wbGF0ZSwgY2FsbCwgcHJvdG8sIGFyZ3MsIHNpemUpCVwNCj4+PiArCURFRklORV9FVkVO
VF9XUklUQUJMRSh0ZW1wbGF0ZSwgY2FsbCwgUEFSQU1TKHByb3RvKSwJCVwNCj4+PiArCQkJICAg
ICAgUEFSQU1TKGFyZ3MpLCBzaXplKQ0KPj4+ICsjZWxzZQ0KPj4+ICsjdW5kZWYgQlBGX1RFU1Rf
UlVOX0RFRklORV9FVkVOVA0KPj4+ICsjZGVmaW5lIEJQRl9URVNUX1JVTl9ERUZJTkVfRVZFTlQo
dGVtcGxhdGUsIGNhbGwsIHByb3RvLCBhcmdzLCBzaXplKQlcDQo+Pj4gKwlERUZJTkVfRVZFTlQo
dGVtcGxhdGUsIGNhbGwsIFBBUkFNUyhwcm90byksIFBBUkFNUyhhcmdzKSkNCj4+PiArI2VuZGlm
DQo+Pj4gKw0KPj4+ICtCUEZfVEVTVF9SVU5fREVGSU5FX0VWRU5UKGJwZl90ZXN0X2ZpbmlzaCwg
YnBmX3Rlc3RfZmluaXNoLA0KPj4+ICsNCj4+PiArCVRQX1BST1RPKGludCAqZXJyKSwNCj4+PiAr
DQo+Pj4gKwlUUF9BUkdTKGVyciksDQo+Pj4gKw0KPj4+ICsJc2l6ZW9mKGludCkNCj4+PiArKTsN
Cj4+PiArDQo+Pj4gKyNlbmRpZg0KPj4+ICsNCj4+PiArLyogVGhpcyBwYXJ0IG11c3QgYmUgb3V0
c2lkZSBwcm90ZWN0aW9uICovDQo+Pj4gKyNpbmNsdWRlIDx0cmFjZS9kZWZpbmVfdHJhY2UuaD4N
Cj4+PiBkaWZmIC0tZ2l0IGEvbmV0L2JwZi90ZXN0X3J1bi5jIGIvbmV0L2JwZi90ZXN0X3J1bi5j
DQo+Pj4gaW5kZXggZmFiMTQyYjc5NmVmLi4yNWU3NTcxMDI1OTUgMTAwNjQ0DQo+Pj4gLS0tIGEv
bmV0L2JwZi90ZXN0X3J1bi5jDQo+Pj4gKysrIGIvbmV0L2JwZi90ZXN0X3J1bi5jDQo+Pj4gQEAg
LTEzLDYgKzEzLDkgQEANCj4+PiAgICAjaW5jbHVkZSA8bmV0L3NvY2suaD4NCj4+PiAgICAjaW5j
bHVkZSA8bmV0L3RjcC5oPg0KPj4+ICAgIA0KPj4+ICsjZGVmaW5lIENSRUFURV9UUkFDRV9QT0lO
VFMNCj4+PiArI2luY2x1ZGUgPHRyYWNlL2V2ZW50cy9icGZfdGVzdF9ydW4uaD4NCj4+PiArDQo+
Pj4gICAgc3RhdGljIGludCBicGZfdGVzdF9ydW4oc3RydWN0IGJwZl9wcm9nICpwcm9nLCB2b2lk
ICpjdHgsIHUzMiByZXBlYXQsDQo+Pj4gICAgCQkJdTMyICpyZXR2YWwsIHUzMiAqdGltZSkNCj4+
PiAgICB7DQo+Pj4gQEAgLTEwMCw2ICsxMDMsNyBAQCBzdGF0aWMgaW50IGJwZl90ZXN0X2Zpbmlz
aChjb25zdCB1bmlvbiBicGZfYXR0ciAqa2F0dHIsDQo+Pj4gICAgCWlmIChlcnIgIT0gLUVOT1NQ
QykNCj4+PiAgICAJCWVyciA9IDA7DQo+Pj4gICAgb3V0Og0KPj4+ICsJdHJhY2VfYnBmX3Rlc3Rf
ZmluaXNoKCZlcnIpOw0KPj4+ICAgIAlyZXR1cm4gZXJyOw0KPj4+ICAgIH0NCj4+PiAgICANCj4+
PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvcmF3
X3RwX3dyaXRhYmxlX3JlamVjdF9uYmRfaW52YWxpZC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvYnBmL3Byb2dfdGVzdHMvcmF3X3RwX3dyaXRhYmxlX3JlamVjdF9uYmRfaW52YWxpZC5jDQo+
Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjMyOGQ1YzRi
MDg0Yg0KPj4+IC0tLSAvZGV2L251bGwNCj4+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvcHJvZ190ZXN0cy9yYXdfdHBfd3JpdGFibGVfcmVqZWN0X25iZF9pbnZhbGlkLmMNCj4+
PiBAQCAtMCwwICsxLDQwIEBADQo+Pj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wDQo+Pj4gKw0KPj4+ICsjaW5jbHVkZSA8dGVzdF9wcm9ncy5oPg0KPj4+ICsjaW5jbHVkZSA8
bGludXgvbmJkLmg+DQo+Pj4gKw0KPj4+ICt2b2lkIHRlc3RfcmF3X3RwX3dyaXRhYmxlX3JlamVj
dF9uYmRfaW52YWxpZCh2b2lkKQ0KPj4+ICt7DQo+Pj4gKwlfX3UzMiBkdXJhdGlvbiA9IDA7DQo+
Pj4gKwljaGFyIGVycm9yWzQwOTZdOw0KPj4+ICsJaW50IGJwZl9mZCA9IC0xLCB0cF9mZCA9IC0x
Ow0KPj4+ICsNCj4+PiArCWNvbnN0IHN0cnVjdCBicGZfaW5zbiBwcm9ncmFtW10gPSB7DQo+Pj4g
KwkJLyogcjYgaXMgb3VyIHRwIGJ1ZmZlciAqLw0KPj4+ICsJCUJQRl9MRFhfTUVNKEJQRl9EVywg
QlBGX1JFR182LCBCUEZfUkVHXzEsIDApLA0KPj4+ICsJCUJQRl9MRFhfTUVNKEJQRl9EVywgQlBG
X1JFR18wLCBCUEZfUkVHXzYsIDEyOCksDQo+Pg0KPj4gVGhlIG51bWJlciAiMTI4IiBpcyBhIGxp
dHRsZSBjcnlwdGljLiBNYXliZSB5b3UgY2FuIHVzZSBzb21ldGhpbmcgbGlrZQ0KPj4gc2l6ZW9m
KHN0cnVjdCBuYmRfcmVxdWVzdCk/DQo+IA0KPiBUaGF0IHdhcyBleHBsaWNpdGx5IGNob3NlbiB0
byBiZSAoZmFyKSBsYXJnZXIgdGhhbiBhbiBuYmRfcmVxdWVzdCwgYXMNCj4gdGhpcyBwcm9ncmFt
IHNob3VsZCBiZSByZWplY3RlZCBieSB0aGUgdmVyaWZpZXIuICBJZiB5b3UgcmVhbGx5IHdhbnQs
IEkNCj4gY2FuIGRvIGBzaXplb2Yoc3RydWN0IG5iZF9yZXF1ZXN0KSArIHNvbWUgY29uc3RhbnRg
IGFuZCBhZGQgYSBjb21tZW50Lg0KPiBCdXQgdGhlIHNpemUgb2YgYW4gbmJkIHJlcXVlc3Qgc2hv
dWxkIG5ldmVyIGNoYW5nZSwgYXMgdGhhdCdzIGEgbmV0d29yaw0KPiBwcm90b2NvbC4NCg0KSSB0
aGluayBgc2l6ZW9mKHN0cnVjdCBuYmRfcmVxdWVzdCkgKyBzb21lIGNvbnN0YW50YCBpcyBiZXR0
ZXIgdGhhbiANCm51bWJlciBgMTI4YC4NCg==
