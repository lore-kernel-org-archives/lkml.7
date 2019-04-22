Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EED9C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 23:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5093720685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 23:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DHOo+wCX";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fVsOesHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfDVXC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 19:02:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53420 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730446AbfDVXC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 19:02:27 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MMvkB3007850;
        Mon, 22 Apr 2019 16:01:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=bPCUOL5VvxuUuRsar4xTkWsMUs60COBHSl0iVKXZC+E=;
 b=DHOo+wCX+4rxMBx2TAOdOEPDDcta2t2TB0kObRDvwCJC1UcQMt7pz/G9QSU8BSjVH79o
 DDuruxnX/NYm3K0xWKXkJcbm4glqkjPQd3sfPJYRGRJefM/HU6SVbQPui0BeQj/Yl0rt
 kM3XtUcM9Z+J7+3or/y6t4yO6edVC2tqPBQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s19sxk0nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 16:01:36 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 16:01:35 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Apr 2019 16:01:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPCUOL5VvxuUuRsar4xTkWsMUs60COBHSl0iVKXZC+E=;
 b=fVsOesHfYAAKzeVBoIrCZF/ydQ1iqb8BZmjbjJ+FhQtn5qLKcjg6gEvNcqaNUdF10IYXmmJaNWYTv7nsmSzKibR38S0K4YP/BHWOfiMcI5li1qIuVB95UrYt+0oSqquiOXbP6jovxTM+b+o29TyM3I3Eww8SwyV3FY0Y6eZyywM=
Received: from MWHPR15MB1262.namprd15.prod.outlook.com (10.175.3.12) by
 MWHPR15MB1552.namprd15.prod.outlook.com (10.173.235.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 23:01:33 +0000
Received: from MWHPR15MB1262.namprd15.prod.outlook.com
 ([fe80::99cf:e855:88ea:3f7c]) by MWHPR15MB1262.namprd15.prod.outlook.com
 ([fe80::99cf:e855:88ea:3f7c%12]) with mapi id 15.20.1813.017; Mon, 22 Apr
 2019 23:01:32 +0000
From:   Matt Mullins <mmullins@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Andrew Hall <hall@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Lau <kafai@fb.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: add writable context for raw
 tracepoints
Thread-Topic: [PATCH bpf-next v3 1/5] bpf: add writable context for raw
 tracepoints
Thread-Index: AQHU9vOB79lL7UaxSkud4C7lvhwQXqZIf/cAgAATu4CAAB/ZAIAAHTAA
Date:   Mon, 22 Apr 2019 23:01:32 +0000
Message-ID: <2d77d03b79263872397e6d7ee9eeaa0995f8be04.camel@fb.com>
References: <20190419210409.5021-1-mmullins@fb.com>
         <20190419210409.5021-2-mmullins@fb.com>
         <6fbd1336-d2a0-3ea8-6127-ffb12ddde365@fb.com>
         <de2eb4c12121c96b5b9912196aedb081027b3ac4.camel@fb.com>
         <ca1d46d5-ea87-2859-c5a7-ce7220d396db@fb.com>
In-Reply-To: <ca1d46d5-ea87-2859-c5a7-ce7220d396db@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-originating-ip: [2620:10d:c090:200::3:ede9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bacb2466-6e9b-4beb-e6f2-08d6c776769f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1552;
x-ms-traffictypediagnostic: MWHPR15MB1552:
x-microsoft-antispam-prvs: <MWHPR15MB15521E0652FC6F27639CD699B0220@MWHPR15MB1552.namprd15.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(39860400002)(396003)(346002)(189003)(199004)(6116002)(102836004)(4326008)(6512007)(110136005)(14454004)(6246003)(2906002)(478600001)(68736007)(76176011)(66446008)(64756008)(73956011)(6506007)(76116006)(36756003)(25786009)(66946007)(53936002)(5024004)(14444005)(53546011)(256004)(66556008)(66476007)(71190400001)(71200400001)(186003)(99286004)(316002)(46003)(6436002)(81166006)(81156014)(8676002)(2201001)(486006)(11346002)(93886005)(50226002)(229853002)(7736002)(8936002)(54906003)(97736004)(2501003)(118296001)(476003)(2616005)(5660300002)(305945005)(446003)(86362001)(6486002)(99106002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1552;H:MWHPR15MB1262.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mpCqFRJ31HMKlWwtEWKlGJ+sTCa3JL1gasaLgBx1VrNCKLKXUipyYmd3NhaeWI775+ZU6BYlgmTiRcDFJY01XfDZCYEfiXSVnDpvWzZnzx2OvW19vBsftv0Dk8/3ZnIHJVPxkjyTYN8Sid3RFA73ubiWj9+7QIWFla8V85SF9Dvi6WjEtADZ5TyJ4Vp3axiy3zErQW6m0CvPFKivtW8D3ZXNQGOaVIFX9s/Q1ydH5yMeA88BRihKt/UgrZ+qwWWfWDEyOGwbZlkbDnzT5MENvlEdvX/thgeookBYstO9dCXSVEKTQQTDXElgm+15EOFAhSkw2X3fkMZYPbT6SogvkEBjQKJQrtvy8iV9HxoDBpJ8TPWfH7SUM/cu6feFHBFJkeFCwraIQp0mg54kJHHPJDqvXNPOoboRr+aL0u3vDRA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD9523984B9E95459DC93AACBFF6C0E1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bacb2466-6e9b-4beb-e6f2-08d6c776769f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 23:01:32.8051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1552
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA0LTIyIGF0IDIxOjE3ICswMDAwLCBZb25naG9uZyBTb25nIHdyb3RlOg0K
PiANCj4gT24gNC8yMi8xOSAxMjoyMyBQTSwgTWF0dCBNdWxsaW5zIHdyb3RlOg0KPiA+IE9uIE1v
biwgMjAxOS0wNC0yMiBhdCAxODoxMiArMDAwMCwgWW9uZ2hvbmcgU29uZyB3cm90ZToNCj4gPiA+
IA0KPiA+ID4gT24gNC8xOS8xOSAyOjA0IFBNLCBNYXR0IE11bGxpbnMgd3JvdGU6DQo+ID4gPiA+
IFRoaXMgaXMgYW4gb3B0LWluIGludGVyZmFjZSB0aGF0IGFsbG93cyBhIHRyYWNlcG9pbnQgdG8g
cHJvdmlkZSBhIHNhZmUNCj4gPiA+ID4gYnVmZmVyIHRoYXQgY2FuIGJlIHdyaXR0ZW4gZnJvbSBh
IEJQRl9QUk9HX1RZUEVfUkFXX1RSQUNFUE9JTlQgcHJvZ3JhbS4NCj4gPiA+ID4gVGhlIHNpemUg
b2YgdGhlIGJ1ZmZlciBtdXN0IGJlIGEgY29tcGlsZS10aW1lIGNvbnN0YW50LCBhbmQgaXMgY2hl
Y2tlZA0KPiA+ID4gPiBiZWZvcmUgYWxsb3dpbmcgYSBCUEYgcHJvZ3JhbSB0byBhdHRhY2ggdG8g
YSB0cmFjZXBvaW50IHRoYXQgdXNlcyB0aGlzDQo+ID4gPiA+IGZlYXR1cmUuDQo+ID4gPiA+IA0K
PiA+ID4gPiBUaGUgcG9pbnRlciB0byB0aGlzIGJ1ZmZlciB3aWxsIGJlIHRoZSBmaXJzdCBhcmd1
bWVudCBvZiB0cmFjZXBvaW50cw0KPiA+ID4gPiB0aGF0IG9wdCBpbjsgdGhlIGJ1ZmZlciBpcyBy
ZWFkYWJsZSBieSBib3RoIEJQRl9QUk9HX1RZUEVfUkFXX1RSQUNFUE9JTlQNCj4gPiA+ID4gYW5k
IEJQRl9QUk9HX1RZUEVfUkFXX1RSQUNFUE9JTlRfV1JJVEFCTEUgcHJvZ3JhbXMgdGhhdCBhdHRh
Y2ggdG8gc3VjaCBhDQo+ID4gPiA+IHRyYWNlcG9pbnQsIGJ1dCB0aGUgYnVmZmVyIHRvIHdoaWNo
IGl0IHBvaW50cyBtYXkgb25seSBiZSB3cml0dGVuIGJ5IHRoZQ0KPiA+ID4gPiBsYXR0ZXIuDQo+
ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0IE11bGxpbnMgPG1tdWxsaW5zQGZi
LmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAgIGluY2x1ZGUvbGludXgvYnBmLmggICAgICAg
ICAgICAgfCAgMiArKw0KPiA+ID4gPiAgICBpbmNsdWRlL2xpbnV4L2JwZl90eXBlcy5oICAgICAg
IHwgIDEgKw0KPiA+ID4gPiAgICBpbmNsdWRlL2xpbnV4L3RyYWNlcG9pbnQtZGVmcy5oIHwgIDEg
Kw0KPiA+ID4gPiAgICBpbmNsdWRlL3RyYWNlL2JwZl9wcm9iZS5oICAgICAgIHwgMjcgKysrKysr
KysrKysrKysrKysrKysrKysrKy0tDQo+ID4gPiA+ICAgIGluY2x1ZGUvdWFwaS9saW51eC9icGYu
aCAgICAgICAgfCAgMSArDQo+ID4gPiA+ICAgIGtlcm5lbC9icGYvc3lzY2FsbC5jICAgICAgICAg
ICAgfCAgOCArKysrKystLQ0KPiA+ID4gPiAgICBrZXJuZWwvYnBmL3ZlcmlmaWVyLmMgICAgICAg
ICAgIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgICBrZXJu
ZWwvdHJhY2UvYnBmX3RyYWNlLmMgICAgICAgIHwgMjEgKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gPiA+ICAgIDggZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2JwZi5oIGIv
aW5jbHVkZS9saW51eC9icGYuaA0KPiA+ID4gPiBpbmRleCBhMjEzMmUwOWRjMWMuLmQzYzcxZmQ2
NzQ3NiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9icGYuaA0KPiA+ID4gPiAr
KysgYi9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+ID4gPiA+IEBAIC0yNjMsNiArMjYzLDcgQEAgZW51
bSBicGZfcmVnX3R5cGUgew0KPiA+ID4gPiAgICAJUFRSX1RPX1NPQ0tfQ09NTU9OX09SX05VTEws
IC8qIHJlZyBwb2ludHMgdG8gc29ja19jb21tb24gb3IgTlVMTCAqLw0KPiA+ID4gPiAgICAJUFRS
X1RPX1RDUF9TT0NLLAkgLyogcmVnIHBvaW50cyB0byBzdHJ1Y3QgdGNwX3NvY2sgKi8NCj4gPiA+
ID4gICAgCVBUUl9UT19UQ1BfU09DS19PUl9OVUxMLCAvKiByZWcgcG9pbnRzIHRvIHN0cnVjdCB0
Y3Bfc29jayBvciBOVUxMICovDQo+ID4gPiA+ICsJUFRSX1RPX1RQX0JVRkZFUiwJIC8qIHJlZyBw
b2ludHMgdG8gYSB3cml0YWJsZSByYXcgdHAncyBidWZmZXIgKi8NCj4gPiA+ID4gICAgfTsNCj4g
PiA+ID4gICAgDQo+ID4gPiANCj4gPiA+IFsuLi5dDQo+ID4gPiA+ICAgIC8qIHRydW5jYXRlIHJl
Z2lzdGVyIHRvIHNtYWxsZXIgc2l6ZSAoaW4gYnl0ZXMpDQo+ID4gPiA+ICAgICAqIG11c3QgYmUg
Y2FsbGVkIHdpdGggc2l6ZSA8IEJQRl9SRUdfU0laRQ0KPiA+ID4gPiAgICAgKi8NCj4gPiA+ID4g
QEAgLTIxMDAsNiArMjEyNywxMCBAQCBzdGF0aWMgaW50IGNoZWNrX21lbV9hY2Nlc3Moc3RydWN0
IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgaW50IGluc25faWR4LCB1MzIgcmVnbg0KPiA+ID4gPiAg
ICAJCWVyciA9IGNoZWNrX3NvY2tfYWNjZXNzKGVudiwgaW5zbl9pZHgsIHJlZ25vLCBvZmYsIHNp
emUsIHQpOw0KPiA+ID4gPiAgICAJCWlmICghZXJyICYmIHZhbHVlX3JlZ25vID49IDApDQo+ID4g
PiA+ICAgIAkJCW1hcmtfcmVnX3Vua25vd24oZW52LCByZWdzLCB2YWx1ZV9yZWdubyk7DQo+ID4g
PiA+ICsJfSBlbHNlIGlmIChyZWctPnR5cGUgPT0gUFRSX1RPX1RQX0JVRkZFUikgew0KPiA+ID4g
PiArCQllcnIgPSBjaGVja190cF9idWZmZXJfYWNjZXNzKGVudiwgcmVnLCByZWdubywgb2ZmLCBz
aXplKTsNCj4gPiA+ID4gKwkJaWYgKCFlcnIgJiYgdCA9PSBCUEZfUkVBRCAmJiB2YWx1ZV9yZWdu
byA+PSAwKQ0KPiA+ID4gPiArCQkJbWFya19yZWdfdW5rbm93bihlbnYsIHJlZ3MsIHZhbHVlX3Jl
Z25vKTsNCj4gPiA+ID4gICAgCX0gZWxzZSB7DQo+ID4gPiA+ICAgIAkJdmVyYm9zZShlbnYsICJS
JWQgaW52YWxpZCBtZW0gYWNjZXNzICclcydcbiIsIHJlZ25vLA0KPiA+ID4gPiAgICAJCQlyZWdf
dHlwZV9zdHJbcmVnLT50eXBlXSk7DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2Uv
YnBmX3RyYWNlLmMgYi9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMNCj4gPiA+ID4gaW5kZXggZDY0
YzAwYWZjZWI1Li5hMmRkNzlkYzY4NzEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2tlcm5lbC90cmFj
ZS9icGZfdHJhY2UuYw0KPiA+ID4gPiArKysgYi9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMNCj4g
PiA+ID4gQEAgLTkwOSw2ICs5MDksMjQgQEAgY29uc3Qgc3RydWN0IGJwZl92ZXJpZmllcl9vcHMg
cmF3X3RyYWNlcG9pbnRfdmVyaWZpZXJfb3BzID0gew0KPiA+ID4gPiAgICBjb25zdCBzdHJ1Y3Qg
YnBmX3Byb2dfb3BzIHJhd190cmFjZXBvaW50X3Byb2dfb3BzID0gew0KPiA+ID4gPiAgICB9Ow0K
PiA+ID4gPiAgICANCj4gPiA+ID4gK3N0YXRpYyBib29sIHJhd190cF93cml0YWJsZV9wcm9nX2lz
X3ZhbGlkX2FjY2VzcyhpbnQgb2ZmLCBpbnQgc2l6ZSwNCj4gPiA+ID4gKwkJCQkJCSBlbnVtIGJw
Zl9hY2Nlc3NfdHlwZSB0eXBlLA0KPiA+ID4gPiArCQkJCQkJIGNvbnN0IHN0cnVjdCBicGZfcHJv
ZyAqcHJvZywNCj4gPiA+ID4gKwkJCQkJCSBzdHJ1Y3QgYnBmX2luc25fYWNjZXNzX2F1eCAqaW5m
bykNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKwlpZiAob2ZmID09IDAgJiYgc2l6ZSA9PSBzaXplb2Yo
dTY0KSkNCj4gPiA+ID4gKwkJaW5mby0+cmVnX3R5cGUgPSBQVFJfVE9fVFBfQlVGRkVSOw0KPiA+
ID4gDQo+ID4gPiBvbiAzMmJpdCBzeXN0ZW0sIHRoZSBmaXJzdCBhcmd1bWVudCBwb2ludGVyIHNp
emUgY291bGQgYmUgc2l6ZW9mKHUzMik/DQo+ID4gDQo+ID4gQXMgZmFyIGFzIEkgY2FuIHRlbGws
IHBvaW50ZXJzIGFyZSBhbHdheXMgNjQgYml0cyB3aWRlIGZyb20gdGhlDQo+ID4gcGVyc3BlY3Rp
dmUgb2YgdGhlIGVCUEYgaW5zdHJ1Y3Rpb24gc2V0LiAgSSB0aGluayB0aGUgcHJvcGVyIGZpeHVw
IGlzDQo+ID4gaW4gaW5jbHVkZS90cmFjZS9ldmVudHMvbmJkLmggLi4uIEkgc2hvdWxkIHVzZSBh
IHU2NCBpbnN0ZWFkIG9mIGENCj4gPiBwb2ludGVyIHR5cGUuDQo+IA0KPiB1NjQgaXMgb2theS4g
WW91IG1heSB3YW50IHRvIGRvdWJsZSBjaGVjayB0cmFjZXBvaW50IGRlZmluaXRpb24gdG8gDQo+
IGVuc3VyZSB0aGUgYXNzaWduIHRvIHRoZSBmaXJzdCBhcmd1bWVudCBjb252ZXJ0aW5nIHRvIHU2
NCBhcyB3ZWxsIHRvIA0KPiBhdm9pZCBwb3RlbnRpYWwgZ2FyYmFnZS4gSXQgd291bGQgYmUgZ29v
ZCBpZiB0aGlzIGlzIGVuZm9yY2VkIGR1cmluZw0KPiBjb21waWxhdGlvbiB0aW1lLg0KDQpOb3cg
dGhhdCBJJ3ZlIGxvb2tlZCBpbnRvIHRoaXMgZnVydGhlciwgdGhpcyBpcyBhbHJlYWR5IGhhbmRs
ZWQgaW4NCmluY2x1ZGUvdHJhY2UvYnBmX3Byb2JlLmg6DQoNCiN1bmRlZiBERUNMQVJFX0VWRU5U
X0NMQVNTDQojZGVmaW5lIERFQ0xBUkVfRVZFTlRfQ0xBU1MoY2FsbCwgcHJvdG8sIGFyZ3MsIHRz
dHJ1Y3QsIGFzc2lnbiwgcHJpbnQpCVwNCnN0YXRpYyBub3RyYWNlIHZvaWQJCQkJCQkJXA0KX19i
cGZfdHJhY2VfIyNjYWxsKHZvaWQgKl9fZGF0YSwgcHJvdG8pCQkJCQlcDQp7CQkJCQkJCQkJXA0K
CXN0cnVjdCBicGZfcHJvZyAqcHJvZyA9IF9fZGF0YTsJCQkJCVwNCglDT05DQVRFTkFURShicGZf
dHJhY2VfcnVuLCBDT1VOVF9BUkdTKGFyZ3MpKShwcm9nLCBDQVNUX1RPX1U2NChhcmdzKSk7CVwN
Cn0NCg0KVGhlIDMyLWJpdCB2YWx1ZSBvZiB0aGUgc3RydWN0IG5iZF9yZXF1ZXN0IHBvaW50ZXIg
d2lsbCBiZSB6ZXJvLQ0KZXh0ZW5kZWQgdG8gNjQtYml0cyBiZWZvcmUgdGhlIEJQRiBwcm9ncmFt
IHNlZXMgaXQsIHNvIHRoZXJlIHdvbid0IGJlDQphbnkgZ2FyYmFnZSBpbiB0aGUgdXBwZXIgaGFs
ZiBvZiB0aGUgcmVnaXN0ZXIuICBJJ20gZ29pbmcgdG8gbGVhdmUgdGhlDQp0cmFjZV8qIGZ1bmN0
aW9ucyB0YWtpbmcgdGhlIHBvaW50ZXIgYXMtaXMsIHNvIHRoYXQgSSBjYW4ga2VlcCB0aGUNCmNv
bXBpbGUtdGltZSBjaGVja3MgdGhhdCB3cml0YWJsZV9zaXplID09IHNpemVvZigqZmlyc3RfYXJn
dW1lbnQpLg0KDQo+ID4gPiBTaG91bGQgdGhlIGZpcnN0IGFyZ3VtZW50IGZvciByYXdfdHBfd3Jp
dGFibGVfcHJvZyBiZSBhbHdheXMNCj4gPiA+IFBUUl9UT19UUF9CVUZGRVI/DQo+ID4gDQo+ID4g
VGhhdCBpcyB0aGUgcHVycG9zZSBvZiB0aGlzIHBhdGNoIHNlcmllcywgeWVzLiAgTXkgaW5pdGlh
bCBhdHRlbXB0IGF0DQo+ID4gdGhpcyB0cmllZCB0byBhZGQgaXQgdG8gdGhlIGVuZCBvZiB0aGUg
Y29udGV4dCBzdHJ1Y3R1cmUgaW5zdGVhZCwgYW5kDQo+ID4gdGhhdCBlbmRlZCB1cCBiZWluZyBx
dWl0ZSBjb21wbGV4IHRvIHRyYWNrLg0KPiANCj4gU28gYHNpemUgPT0gc2l6ZW9mKHU2NClgIGNh
biBiZSByZW1vdmVkLCBvZmYgPT0gMCBqdXN0IGltcGxpZXMNCj4gcmVnX3R5cGUgUFRSX1RPX1RQ
X0JVRkZFUj8NCg0KSSBjYW4ndCBnZXQgcmlkIG9mIHRoZSBzaXplIGNoZWNrLCBiZWNhdXNlIEkg
Y2FuIGVtaXQgYW4gb3Bjb2RlIGxpa2UNCg0KICAwOiAoNzEpIHI2ID0gKih1OCAqKShyMSArMCkN
Cg0KYW5kIEkgZG9uJ3Qgd2FudCB0byBhY2NpZGVudGFsbHkgbWFyayBhIHZhbHVlIGFzIFBUUl9U
T19UUF9CVUZGRVINCnVubGVzcyBpdCBpcyBhIHdob2xlLCB2YWxpZCBwb2ludGVyLg0KDQo+ID4g
PiA+ICsJcmV0dXJuIHJhd190cF9wcm9nX2lzX3ZhbGlkX2FjY2VzcyhvZmYsIHNpemUsIHR5cGUs
IHByb2csIGluZm8pOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICtjb25zdCBzdHJ1
Y3QgYnBmX3ZlcmlmaWVyX29wcyByYXdfdHJhY2Vwb2ludF93cml0YWJsZV92ZXJpZmllcl9vcHMg
PSB7DQo+ID4gPiA+ICsJLmdldF9mdW5jX3Byb3RvICA9IHJhd190cF9wcm9nX2Z1bmNfcHJvdG8s
DQo+ID4gPiA+ICsJLmlzX3ZhbGlkX2FjY2VzcyA9IHJhd190cF93cml0YWJsZV9wcm9nX2lzX3Zh
bGlkX2FjY2VzcywNCj4gPiA+ID4gK307DQo+ID4gPiA+ICsNCj4gPiA+ID4gK2NvbnN0IHN0cnVj
dCBicGZfcHJvZ19vcHMgcmF3X3RyYWNlcG9pbnRfd3JpdGFibGVfcHJvZ19vcHMgPSB7DQo+ID4g
PiA+ICt9Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICAgIHN0YXRpYyBib29sIHBlX3Byb2dfaXNfdmFs
aWRfYWNjZXNzKGludCBvZmYsIGludCBzaXplLCBlbnVtIGJwZl9hY2Nlc3NfdHlwZSB0eXBlLA0K
PiA+ID4gPiAgICAJCQkJICAgIGNvbnN0IHN0cnVjdCBicGZfcHJvZyAqcHJvZywNCj4gPiA+ID4g
ICAgCQkJCSAgICBzdHJ1Y3QgYnBmX2luc25fYWNjZXNzX2F1eCAqaW5mbykNCj4gPiA+ID4gQEAg
LTExOTgsNiArMTIxNiw5IEBAIHN0YXRpYyBpbnQgX19icGZfcHJvYmVfcmVnaXN0ZXIoc3RydWN0
IGJwZl9yYXdfZXZlbnRfbWFwICpidHAsIHN0cnVjdCBicGZfcHJvZyAqDQo+ID4gPiA+ICAgIAlp
ZiAocHJvZy0+YXV4LT5tYXhfY3R4X29mZnNldCA+IGJ0cC0+bnVtX2FyZ3MgKiBzaXplb2YodTY0
KSkNCj4gPiA+ID4gICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+ID4gICAgDQo+ID4gPiA+ICsJ
aWYgKHByb2ctPmF1eC0+bWF4X3RwX2FjY2VzcyA+IGJ0cC0+d3JpdGFibGVfc2l6ZSkNCj4gPiA+
ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+ICsNCj4gPiA+ID4gICAgCXJldHVybiB0cmFj
ZXBvaW50X3Byb2JlX3JlZ2lzdGVyKHRwLCAodm9pZCAqKWJ0cC0+YnBmX2Z1bmMsIHByb2cpOw0K
PiA+ID4gPiAgICB9DQo+ID4gPiA+ICAgIA0KPiA+ID4gPiANCg==
