Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B2C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C9420663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lPOlyfkq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ml7VCWui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfDEAVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:21:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33894 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728727AbfDEAVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:21:13 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x350FSeN024842;
        Thu, 4 Apr 2019 17:20:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=D2YI+Nep9tITdS9BTZqFEvfRyBgXHFMypWDGZ0kYxjc=;
 b=lPOlyfkqGwmr6AQANTc8DgX4ckY/wMt1zJ2XZZPIV57bNmCzSq1vGfGXvlaB7F8bXll3
 sxiu2eD/Bq2hPha/bd+ZjlykP7x+FK0f+193BGCiJYCcs91npRQdhHvmkvfGuqgRHtLi
 Q89vba22vGRp0PkbcumMP4fFzxuhNnbTwqg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rnq7015av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Apr 2019 17:20:45 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 4 Apr 2019 17:20:44 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 4 Apr 2019 17:20:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2YI+Nep9tITdS9BTZqFEvfRyBgXHFMypWDGZ0kYxjc=;
 b=Ml7VCWui1fRhSR3+QZXc+bEK8PioGxiIzx72V6RWz3hhigj2evKtd8G0n+V6sPQzUap8/tJ0EPfBDHSSNFSgkvZaesCgvrz3re859wmZAk3Mm2VUJ0AcD86sPg1OX4D0Y0uKljQI3pK6ITvx57vATAuhkaW4PwnzUqHuKYVKOwY=
Received: from MWHPR15MB1375.namprd15.prod.outlook.com (10.173.234.14) by
 MWHPR15MB1263.namprd15.prod.outlook.com (10.175.3.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Fri, 5 Apr 2019 00:20:42 +0000
Received: from MWHPR15MB1375.namprd15.prod.outlook.com
 ([fe80::9070:ab94:bb34:4c66]) by MWHPR15MB1375.namprd15.prod.outlook.com
 ([fe80::9070:ab94:bb34:4c66%2]) with mapi id 15.20.1750.017; Fri, 5 Apr 2019
 00:20:42 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>, Roman Gushchin <guro@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 05/21] bpf: Introduce
 bpf_sysctl_{get,set}_new_value helpers
Thread-Topic: [PATCH v2 bpf-next 05/21] bpf: Introduce
 bpf_sysctl_{get,set}_new_value helpers
Thread-Index: AQHU421afg1rilDHVkKbhQ9mqXVVFaYsISCAgACiyYA=
Date:   Fri, 5 Apr 2019 00:20:41 +0000
Message-ID: <20190405002032.GA89960@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1553560620.git.rdna@fb.com>
 <1b3f7545f3d14e2277a3206eef2c3fea6329245d.1553560620.git.rdna@fb.com>
 <368fcbf5-4144-c95b-d39a-d756546a67d5@iogearbox.net>
In-Reply-To: <368fcbf5-4144-c95b-d39a-d756546a67d5@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0002.namprd22.prod.outlook.com
 (2603:10b6:301:28::15) To MWHPR15MB1375.namprd15.prod.outlook.com
 (2603:10b6:300:bc::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:2b7a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b23f78dc-10e6-48ce-33f6-08d6b95c899a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1263;
x-ms-traffictypediagnostic: MWHPR15MB1263:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MWHPR15MB126302A9C2B2F8137EE7DFE1A8510@MWHPR15MB1263.namprd15.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(446003)(229853002)(106356001)(86362001)(105586002)(71190400001)(6486002)(478600001)(966005)(71200400001)(5660300002)(6436002)(68736007)(8676002)(8936002)(6246003)(81166006)(81156014)(11346002)(53936002)(99286004)(4326008)(54906003)(305945005)(7736002)(102836004)(486006)(316002)(97736004)(386003)(53546011)(9686003)(476003)(6116002)(25786009)(2906002)(6306002)(6512007)(186003)(256004)(14454004)(52116002)(76176011)(14444005)(1076003)(6506007)(46003)(6916009)(33656002)(5024004)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1263;H:MWHPR15MB1375.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FPmVWVhuNl8YcC0y+poNXIdjqAX3AhZba7cYn/qqUjOVpzyY8r7Npy2iMoYwGyETpCI94g/cE3lVpekhnNLuryv2/fWw6yAj8UetJL37QOzrlXGlABDWJ8X+G/LZYDQFtaMJ+xpBo+94vLM4tZ0wdXyZ/vYseNmnCMZUiKcdLIUUbuaTICjWSF4Z8ur0j8YHUX6ef+K02Jc5SRypns4jnF81/GQgUG0wXVtci+/JznJl+t5yh1jj9t1EQEsVzoOH+YvS9Q78dcsCQV0e8cAmF5cfckV8zIoAFNX8ZAUaJqRUL1Qd9zIabPrarTEakCgEyz7Yy0zmuPQZXp/hnJDUDGDCrdC9iHbi0eLab70gSKB9bljeHo5/6FclRY1+RQZMy8tVSONtrPGUvlCEy2fT+FsxvgJLjRifeiLCt/OtJfw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB11B2E5F37A254782F5315B9AAC1D54@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b23f78dc-10e6-48ce-33f6-08d6b95c899a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 00:20:42.0201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1263
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD4gW1RodSwgMjAxOS0wNC0wNCAw
NzozOCAtMDcwMF06DQo+IE9uIDAzLzI2LzIwMTkgMDE6NDMgQU0sIEFuZHJleSBJZ25hdG92IHdy
b3RlOg0KPiA+IEFkZCBoZWxwZXJzIHRvIHdvcmsgd2l0aCBuZXcgdmFsdWUgYmVpbmcgd3JpdHRl
biB0byBzeXNjdGwgYnkgdXNlcg0KPiA+IHNwYWNlLg0KPiA+IA0KPiA+IGJwZl9zeXNjdGxfZ2V0
X25ld192YWx1ZSgpIGNvcGllcyB2YWx1ZSBiZWluZyB3cml0dGVuIHRvIHN5c2N0bCBpbnRvDQo+
ID4gcHJvdmlkZWQgYnVmZmVyLg0KPiA+IA0KPiA+IGJwZl9zeXNjdGxfc2V0X25ld192YWx1ZSgp
IG92ZXJyaWRlcyBuZXcgdmFsdWUgYmVpbmcgd3JpdHRlbiBieSB1c2VyDQo+ID4gc3BhY2Ugd2l0
aCBhIG9uZSBmcm9tIHByb3ZpZGVkIGJ1ZmZlci4gQnVmZmVyIHNob3VsZCBjb250YWluIHN0cmlu
Zw0KPiA+IHJlcHJlc2VudGF0aW9uIG9mIHRoZSB2YWx1ZSwgc2ltaWxhciB0byB3aGF0IGNhbiBi
ZSBzZWVuIGluIC9wcm9jL3N5cy8uDQo+ID4gDQo+ID4gQm90aCBoZWxwZXJzIGNhbiBiZSB1c2Vk
IG9ubHkgb24gc3lzY3RsIHdyaXRlLg0KPiA+IA0KPiA+IEZpbGUgcG9zaXRpb24gbWF0dGVycyBh
bmQgY2FuIGJlIG1hbmFnZWQgYnkgYW4gaW50ZXJmYWNlIHRoYXQgd2lsbCBiZQ0KPiA+IGludHJv
ZHVjZWQgc2VwYXJhdGVseS4gRS5nLiBpZiB1c2VyIHNwYWNlIGNhbGxzIHN5c193cml0ZSB0byBh
IGZpbGUgaW4NCj4gPiAvcHJvYy9zeXMvIGF0IGZpbGUgcG9zaXRpb24gPSBYLCB3aGVyZSBYID4g
MCwgdGhlbiB0aGUgdmFsdWUgc2V0IGJ5DQo+ID4gYnBmX3N5c2N0bF9zZXRfbmV3X3ZhbHVlKCkg
d2lsbCBiZSB3cml0dGVuIHN0YXJ0aW5nIGZyb20gWC4gSWYgcHJvZ3JhbQ0KPiA+IHdhbnRzIHRv
IG92ZXJyaWRlIHdob2xlIHZhbHVlIHdpdGggc3BlY2lmaWVkIGJ1ZmZlciwgZmlsZSBwb3NpdGlv
biBoYXMNCj4gPiB0byBiZSBzZXQgdG8gemVyby4NCj4gPiANCj4gPiBEb2N1bWVudGF0aW9uIGZv
ciB0aGUgbmV3IGhlbHBlcnMgaXMgcHJvdmlkZWQgaW4gYnBmLmggVUFQSS4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBbmRyZXkgSWduYXRvdiA8cmRuYUBmYi5jb20+DQo+ID4gLS0tDQo+ID4g
IGZzL3Byb2MvcHJvY19zeXNjdGwuYyAgICAgIHwgMjIgKysrKysrKystLS0NCj4gPiAgaW5jbHVk
ZS9saW51eC9icGYtY2dyb3VwLmggfCAgOCArKy0tDQo+ID4gIGluY2x1ZGUvbGludXgvZmlsdGVy
LmggICAgIHwgIDMgKysNCj4gPiAgaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oICAgfCAzOCArKysr
KysrKysrKysrKysrKy0NCj4gPiAga2VybmVsL2JwZi9jZ3JvdXAuYyAgICAgICAgfCA4MSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICA1IGZpbGVzIGNoYW5nZWQs
IDE0MiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZnMvcHJvYy9wcm9jX3N5c2N0bC5jIGIvZnMvcHJvYy9wcm9jX3N5c2N0bC5jDQo+ID4gaW5k
ZXggNzJmNGEwOTZjMTQ2Li40ZDFhYjIyNzc0ZjcgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvcHJvYy9w
cm9jX3N5c2N0bC5jDQo+ID4gKysrIGIvZnMvcHJvYy9wcm9jX3N5c2N0bC5jDQo+ID4gQEAgLTU3
MCw4ICs1NzAsOCBAQCBzdGF0aWMgc3NpemVfdCBwcm9jX3N5c19jYWxsX2hhbmRsZXIoc3RydWN0
IGZpbGUgKmZpbHAsIHZvaWQgX191c2VyICpidWYsDQo+ID4gIAlzdHJ1Y3QgaW5vZGUgKmlub2Rl
ID0gZmlsZV9pbm9kZShmaWxwKTsNCj4gPiAgCXN0cnVjdCBjdGxfdGFibGVfaGVhZGVyICpoZWFk
ID0gZ3JhYl9oZWFkZXIoaW5vZGUpOw0KPiA+ICAJc3RydWN0IGN0bF90YWJsZSAqdGFibGUgPSBQ
Uk9DX0koaW5vZGUpLT5zeXNjdGxfZW50cnk7DQo+ID4gKwl2b2lkICpuZXdfYnVmID0gTlVMTDsN
Cj4gPiAgCXNzaXplX3QgZXJyb3I7DQo+ID4gLQlzaXplX3QgcmVzOw0KPiA+ICANCj4gPiAgCWlm
IChJU19FUlIoaGVhZCkpDQo+ID4gIAkJcmV0dXJuIFBUUl9FUlIoaGVhZCk7DQo+ID4gQEAgLTU4
OSwxNSArNTg5LDI3IEBAIHN0YXRpYyBzc2l6ZV90IHByb2Nfc3lzX2NhbGxfaGFuZGxlcihzdHJ1
Y3QgZmlsZSAqZmlscCwgdm9pZCBfX3VzZXIgKmJ1ZiwNCj4gPiAgCWlmICghdGFibGUtPnByb2Nf
aGFuZGxlcikNCj4gPiAgCQlnb3RvIG91dDsNCj4gPiAgDQo+ID4gLQllcnJvciA9IEJQRl9DR1JP
VVBfUlVOX1BST0dfU1lTQ1RMKGhlYWQsIHRhYmxlLCB3cml0ZSk7DQo+ID4gKwllcnJvciA9IEJQ
Rl9DR1JPVVBfUlVOX1BST0dfU1lTQ1RMKGhlYWQsIHRhYmxlLCB3cml0ZSwgYnVmLCAmY291bnQs
DQo+ID4gKwkJCQkJICAgJm5ld19idWYpOw0KPiA+ICAJaWYgKGVycm9yKQ0KPiA+ICAJCWdvdG8g
b3V0Ow0KPiA+ICANCj4gPiAgCS8qIGNhcmVmdWw6IGNhbGxpbmcgY29udmVudGlvbnMgYXJlIG5h
c3R5IGhlcmUgKi8NCj4gPiAtCXJlcyA9IGNvdW50Ow0KPiA+IC0JZXJyb3IgPSB0YWJsZS0+cHJv
Y19oYW5kbGVyKHRhYmxlLCB3cml0ZSwgYnVmLCAmcmVzLCBwcG9zKTsNCj4gPiArCWlmIChuZXdf
YnVmKSB7DQo+ID4gKwkJbW1fc2VnbWVudF90IG9sZF9mczsNCj4gPiArDQo+ID4gKwkJb2xkX2Zz
ID0gZ2V0X2ZzKCk7DQo+ID4gKwkJc2V0X2ZzKEtFUk5FTF9EUyk7DQo+ID4gKwkJZXJyb3IgPSB0
YWJsZS0+cHJvY19oYW5kbGVyKHRhYmxlLCB3cml0ZSwgKHZvaWQgX191c2VyICopbmV3X2J1ZiwN
Cj4gPiArCQkJCQkgICAgJmNvdW50LCBwcG9zKTsNCj4gPiArCQlzZXRfZnMob2xkX2ZzKTsNCj4g
DQo+IEZyb20gcXVpY2sgZ2xhbmNlIG9uIHRoZSBzZXQsIHRoZSBhYm92ZSBzdG9vZCBvdXQuIEFm
YWlrLCB0aGVyZSBpcyBhbiBvbmdvaW5nDQo+IGVmZm9ydCBieSBBbCBhbmQgb3RoZXIgZnMvY29y
ZSBmb2xrcyAoYXMgdmlzaWJsZSBpbiB0aGUgZ2l0IGxvZykgdG8gZ2V0IHJpZCBvZg0KPiBzZXRf
ZnMoKSBjYWxscyBpbiB0aGUgdHJlZSB3aXRoIHRoZSBnb2FsIG9mIGVsaW1pbmF0aW5nIHRoaXMg
aW50ZXJmYWNlIC9lbnRpcmVseS8NCj4gKG1vcmUgY29udGV4dCBvbiAnd2h5JyBoZXJlOiBodHRw
czovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2x3bi5uZXRf
QXJ0aWNsZXNfNzIyMjY3XyZkPUR3SUNhUSZjPTVWRDBSVHRObFRoM3ljZDQxYjNNVXcmcj0zakFv
a3BIeUd1Q3VKODM0ai10dHRRJm09Zm1uNmpkMWN6RHZwNWE2R2VTdzB6TE14VTNWUmNnbTFvaHF3
QVBPS2YzOCZzPUFmYnZKOTFhclV6bTMyOGNLemNIWGVlYjEwNGJvQXg4Tkpqc29JVTZMYmsmZT0p
LiBJcyB0aGVyZSBhIGJldHRlcg0KPiB3YXkgdG8gYWNoaWV2ZSB0aGUgYWJvdmUgdy9vIG5lZWRp
bmcgaXQ/DQoNClRoYXQncyBhIGdvb2QgcXVlc3Rpb24uIEkndmUgc3BlbnQgcXVpdGUgYSBsb3Qg
b2YgdGltZSBsb29raW5nIGZvciBhDQpiZXR0ZXIgd2F5IGFuZCB0aGUgb25seSBvbmUgSSdtIGF3
YXJlIG9mIHNvIGZhciBpcyB0byBjaGFuZ2UNCnByb2NfaGFuZGxlciBzaWduYXR1cmUsIHNvIHRo
YXQgaXQgYWNjZXB0cyBrZXJuZWwgJ2J1ZmZlcicsIGFuZCBjb3B5aW5nDQpiZXR3ZWVuIHVzZXIg
YW5kIGtlcm5lbCBoYXBwZW5zIG91dHNpZGUgb2YgcHJvY19oYW5kbGVyLg0KDQpCdXQgaXQgd291
bGQgcmVxdWlyZSBjaGFuZ2luZyBhbGwgcHJvY19oYW5kbGVyIGltcGxlbWVudGF0aW9ucyBhcyB3
ZWxsDQpzbyB0aGF0IHRoZXkgYWNjZXB0IGtlcm5lbCAnYnVmZmVyJyBhbmQgZG9uJ3QgY29weSBk
YXRhIGZyb20vdG8gdXNlciBieQ0KdGhlbXNlbHZlcyBhbmQgdGhlcmUgYXJlIGp1c3QgdG9vIG1h
bnkgc3lzY3RsIHByb2NfaGFuZGxlcg0KaW1wbGVtZW50YXRpb25zOg0KDQogICUgZ2l0IGdyZXAg
LUUgJ1wucHJvY19oYW5kbGVyXHMrPVxzKycgfCBcDQogIAlzZWQgLUVlICdzL14uKlwucHJvY19o
YW5kbGVyXHMrPVxzKy8vJyB8IHNvcnQgLXUgfCB3YyAtbA0KICAxNzkNCiAgJSBnaXQgZ3JlcCAt
bEUgJ1wucHJvY19oYW5kbGVyXHMrPVxzKycgfCB3YyAtbA0KICAxMDMNCg0KDQosIGkuZS4gaXQn
cyBodWdlIHJlZmFjdG9yaW5nIHRoYXQgY2FuIGJlIHJlYWxseSBoYXJkIHRvIHVwc3RyZWFtLg0K
DQpBbHNvIEkgbG9va2VkIGF0IHRoZSBMV04gYXJ0aWNsZSB5b3UgbWVudGlvbmVkIGFuZCBmb3Vu
ZCB0aGlzIGJyYW5jaA0KdGhhdCBjbGVhbnMgdXAgc2V0X2ZzIHVzZSBjYXNlczoNCmh0dHA6Ly9n
aXQuaW5mcmFkZWFkLm9yZy91c2Vycy9oY2gvdmZzLmdpdC9zaG9ydGxvZy9yZWZzL2hlYWRzL3Nl
dGZzLWVsaW1pbmF0aW9uDQoNCkkgc2VlIGl0IHVzZXMgZWl0aGVyIHNpbWlsYXIgYXBwcm9hY2gs
IGkuZS4gaW50cm9kdWNlIHNlcGFyYXRlIChvciB1c2UNCmF2YWlsYWJsZSkgZnVuY3Rpb24gdGhh
dCBhY2NlcHRzIGtlcm5lbCBidWZmZXIsIHRoZW4gY29weSBkYXRhIGZyb20gdXNlcg0KYW5kIHBh
c3MgaXQgdG8gc3VjaCBhIGZ1bmN0aW9uLiBBbm90aGVyIGFwcHJvYWNoLCBJIHNlZSBpbiB0aGUg
YnJhbmNoLA0KaXMgdG8gdXNlIGlvdmVjIGl0ZXJhdG9ycyAodGhhdCdzIG1lbnRpb25lZCBpbiB0
aGUgTFdOIGFydGljbGUgYXMgd2VsbCksDQpidXQgdGhhdCBhZ2FpbiB3b3VsZCByZXF1aXJlIGNo
YW5naW5nIGFsbCBwcm9jX2hhbmRsZXIgaW1wbGVtZW50YXRpb25zLg0KDQpUaGF0J3MgYmVpbmcg
c2FpZCBJIGRvbid0IGtub3cgYSBiZXR0ZXIgd2F5IHRvIGRvIHRoaXMgdy9vIGh1Z2UNCnJlZmFj
dG9yaW5nLg0KDQoNCj4gPiArCQlrZnJlZShuZXdfYnVmKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4g
KwkJZXJyb3IgPSB0YWJsZS0+cHJvY19oYW5kbGVyKHRhYmxlLCB3cml0ZSwgYnVmLCAmY291bnQs
IHBwb3MpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCWlmICghZXJyb3IpDQo+ID4gLQkJZXJyb3Ig
PSByZXM7DQo+ID4gKwkJZXJyb3IgPSBjb3VudDsNCj4gPiAgb3V0Og0KPiA+ICAJc3lzY3RsX2hl
YWRfZmluaXNoKGhlYWQpOw0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9i
cGYtY2dyb3VwLmggYi9pbmNsdWRlL2xpbnV4L2JwZi1jZ3JvdXAuaA0KPiA+IGluZGV4IGIxYzQ1
ZGEyMGEyNi4uMWU5NzI3MWY5YTEwIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvYnBm
LWNncm91cC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9icGYtY2dyb3VwLmgNCj4gPiBAQCAt
MTEzLDcgKzExMyw4IEBAIGludCBfX2Nncm91cF9icGZfY2hlY2tfZGV2X3Blcm1pc3Npb24oc2hv
cnQgZGV2X3R5cGUsIHUzMiBtYWpvciwgdTMyIG1pbm9yLA0KPiA+ICANCj4gPiAgaW50IF9fY2dy
b3VwX2JwZl9ydW5fZmlsdGVyX3N5c2N0bChzdHJ1Y3QgY3RsX3RhYmxlX2hlYWRlciAqaGVhZCwN
Cj4gPiAgCQkJCSAgIHN0cnVjdCBjdGxfdGFibGUgKnRhYmxlLCBpbnQgd3JpdGUsDQo+ID4gLQkJ
CQkgICBlbnVtIGJwZl9hdHRhY2hfdHlwZSB0eXBlKTsNCj4gPiArCQkJCSAgIHZvaWQgX191c2Vy
ICpidWYsIHNpemVfdCAqcGNvdW50LA0KPiA+ICsJCQkJICAgdm9pZCAqKm5ld19idWYsIGVudW0g
YnBmX2F0dGFjaF90eXBlIHR5cGUpOw0KPiA+ICANCj4gPiAgc3RhdGljIGlubGluZSBlbnVtIGJw
Zl9jZ3JvdXBfc3RvcmFnZV90eXBlIGNncm91cF9zdG9yYWdlX3R5cGUoDQo+ID4gIAlzdHJ1Y3Qg
YnBmX21hcCAqbWFwKQ0KPiA+IEBAIC0yNjEsMTEgKzI2MiwxMiBAQCBpbnQgYnBmX3BlcmNwdV9j
Z3JvdXBfc3RvcmFnZV91cGRhdGUoc3RydWN0IGJwZl9tYXAgKm1hcCwgdm9pZCAqa2V5LA0KPiA+
ICB9KQ0KPiA+ICANCj4gPiAgDQo+ID4gLSNkZWZpbmUgQlBGX0NHUk9VUF9SVU5fUFJPR19TWVND
VEwoaGVhZCwgdGFibGUsIHdyaXRlKQkJCSAgICAgICBcDQo+ID4gKyNkZWZpbmUgQlBGX0NHUk9V
UF9SVU5fUFJPR19TWVNDVEwoaGVhZCwgdGFibGUsIHdyaXRlLCBidWYsIGNvdW50LCBuYnVmKSAg
ICAgICBcDQo+ID4gICh7CQkJCQkJCQkJICAgICAgIFwNCj4gPiAgCWludCBfX3JldCA9IDA7CQkJ
CQkJCSAgICAgICBcDQo+ID4gIAlpZiAoY2dyb3VwX2JwZl9lbmFibGVkKQkJCQkJCSAgICAgICBc
DQo+ID4gIAkJX19yZXQgPSBfX2Nncm91cF9icGZfcnVuX2ZpbHRlcl9zeXNjdGwoaGVhZCwgdGFi
bGUsIHdyaXRlLCAgICAgXA0KPiA+ICsJCQkJCQkgICAgICAgYnVmLCBjb3VudCwgbmJ1ZiwgICAg
ICAgXA0KPiA+ICAJCQkJCQkgICAgICAgQlBGX0NHUk9VUF9TWVNDVEwpOyAgICAgXA0KPiA+ICAJ
X19yZXQ7CQkJCQkJCQkgICAgICAgXA0KPiA+ICB9KQ0KPiA+IEBAIC0zMzgsNyArMzQwLDcgQEAg
c3RhdGljIGlubGluZSBpbnQgYnBmX3BlcmNwdV9jZ3JvdXBfc3RvcmFnZV91cGRhdGUoc3RydWN0
IGJwZl9tYXAgKm1hcCwNCj4gPiAgI2RlZmluZSBCUEZfQ0dST1VQX1JVTl9QUk9HX1VEUDZfU0VO
RE1TR19MT0NLKHNrLCB1YWRkciwgdF9jdHgpICh7IDA7IH0pDQo+ID4gICNkZWZpbmUgQlBGX0NH
Uk9VUF9SVU5fUFJPR19TT0NLX09QUyhzb2NrX29wcykgKHsgMDsgfSkNCj4gPiAgI2RlZmluZSBC
UEZfQ0dST1VQX1JVTl9QUk9HX0RFVklDRV9DR1JPVVAodHlwZSxtYWpvcixtaW5vcixhY2Nlc3Mp
ICh7IDA7IH0pDQo+ID4gLSNkZWZpbmUgQlBGX0NHUk9VUF9SVU5fUFJPR19TWVNDVEwoaGVhZCwg
dGFibGUsIHdyaXRlKSAoeyAwOyB9KQ0KPiA+ICsjZGVmaW5lIEJQRl9DR1JPVVBfUlVOX1BST0df
U1lTQ1RMKGhlYWQsdGFibGUsd3JpdGUsYnVmLGNvdW50LG5idWYpICh7IDA7IH0pDQo+ID4gIA0K
PiA+ICAjZGVmaW5lIGZvcl9lYWNoX2Nncm91cF9zdG9yYWdlX3R5cGUoc3R5cGUpIGZvciAoOyBm
YWxzZTsgKQ0KPiA+ICANCg0KLS0gDQpBbmRyZXkgSWduYXRvdg0K
