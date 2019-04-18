Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B29BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A5D217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="H/5PI2eN";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UyXnE95u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389807AbfDRUlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:41:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56412 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728531AbfDRUlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:41:19 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3IKMDqq015872;
        Thu, 18 Apr 2019 13:40:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=E2qOELGb01UNlm7RwhjLDprQjSNQFPe1jPVLi20fogs=;
 b=H/5PI2eNMB7XRGxUqNHgSa+cyrgMlXGNlckgljqmEF05JxhSbZnhHYpDZaXtIWocqR03
 BSbfIx/aawFeMOq6EtHIXKo5dWPjP3Tc8FNmdlMjY8nMBbdhNTFbmZW945AtddyEkQ8D
 ySBkuC+pSbaCPGo+Pjg8hfAqjwVYid6TwDM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rxw648s3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Apr 2019 13:40:57 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 18 Apr 2019 13:40:56 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 18 Apr 2019 13:40:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2qOELGb01UNlm7RwhjLDprQjSNQFPe1jPVLi20fogs=;
 b=UyXnE95u9hCdDDGE5p02pGKJbKf1ZHeRX0g2EpREm56Iyjq2ZGfiTssejVpsX76I3gQ0P+rGuT5g0LIA8Fkmw6kjgq+YX2VdsOshZxrHNHoRn+BFxgGDS48qaQSkaG2BzcNtG18A0PTNllt3QKpGHY9E7DQK2I151FQbE4kzdGM=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3031.namprd15.prod.outlook.com (20.178.238.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Thu, 18 Apr 2019 20:40:54 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 20:40:54 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Wang YanQing <udknight@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fix compile errors due to unsync linux/in6.h and
 netinet/in.h
Thread-Topic: [PATCH v2] fix compile errors due to unsync linux/in6.h and
 netinet/in.h
Thread-Index: AQHU9hF7teN1QZlsD0Ws3g1Cj2tmF6ZCYeKA
Date:   Thu, 18 Apr 2019 20:40:54 +0000
Message-ID: <f9f8d726-8a45-eee2-ff5e-f62e8b0a8f75@fb.com>
References: <20190418180513.GA4863@udknight>
In-Reply-To: <20190418180513.GA4863@udknight>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR18CA0038.namprd18.prod.outlook.com
 (2603:10b6:320:31::24) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:2ecd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5420537-d39a-4778-422b-08d6c43e2720
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3031;
x-ms-traffictypediagnostic: BYAPR15MB3031:
x-microsoft-antispam-prvs: <BYAPR15MB30312935BEB84033972FCD6ED3260@BYAPR15MB3031.namprd15.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(54534003)(8936002)(31686004)(14454004)(478600001)(6436002)(81166006)(8676002)(81156014)(256004)(14444005)(66556008)(66476007)(36756003)(53936002)(6512007)(316002)(25786009)(110136005)(2501003)(6246003)(2906002)(6116002)(5660300002)(6486002)(229853002)(99286004)(7736002)(305945005)(102836004)(71190400001)(71200400001)(97736004)(53546011)(76176011)(186003)(446003)(31696002)(486006)(11346002)(476003)(2616005)(2201001)(66446008)(68736007)(386003)(6506007)(86362001)(64756008)(52116002)(46003)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3031;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sdo0Vc7DmHk4qsDbAFnW8EV4fwOSbhcgRMKWfSToZg6p1yflAk2qR/hgAQ/unpnT60TLCS6lbh0J8Kd3864pjZffMMaPLbM0wh648XtSl/t6GjY9W7ln/mBshZJeUnnCec0fx3ZVYZhNKxtK6+Ukta9t8/1WtocaMVk6bbskacYML7zBoIkNmjsTosOByTWVOl+Sa7XD03bGjWmWxjb+hTBwPxV1HF4eOkz0qyWsWae6x19+7P1kz7BYf/NtUvvQnDbTZH2YZnrhvc1fkrj2ZO87s0f9SQXK22dwEajiemSjDDbS3rau8jGpR84nPW41nf7Sok2qtMUrKz8+LZT4o58yvRiNP0svFztMdD4Gksg2+vdzyOCHiXK6maFR9IDgapgOct4M6ho7GLRTaws34/SuBga6VKe5EtDKfQlVXeo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A184061249CE22418DB423A037115184@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5420537-d39a-4778-422b-08d6c43e2720
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 20:40:54.5557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3031
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMTgvMTkgMTE6MDUgQU0sIFdhbmcgWWFuUWluZyB3cm90ZToNCj4gSSBtZWV0IGJl
bG93IGNvbXBpbGUgZXJyb3JzOg0KPiAiDQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSB0ZXN0X3Rj
cG5vdGlmeV9rZXJuLmM6MTI6DQo+IC91c3IvaW5jbHVkZS9uZXRpbmV0L2luLmg6MTAxOjU6IGVy
cm9yOiBleHBlY3RlZCBpZGVudGlmaWVyDQo+ICAgICAgSVBQUk9UT19IT1BPUFRTID0gMCwgICAv
KiBJUHY2IEhvcC1ieS1Ib3Agb3B0aW9ucy4gICovDQo+ICAgICAgXg0KPiAvdXNyL2luY2x1ZGUv
bGludXgvaW42Lmg6MTMxOjI2OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdJUFBST1RPX0hP
UE9QVFMnDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIHRlc3RfdGNwbm90aWZ5X2tlcm4uYzoxMjoNCj4gL3Vzci9pbmNsdWRlL25l
dGluZXQvaW4uaDoxMDM6NTogZXJyb3I6IGV4cGVjdGVkIGlkZW50aWZpZXINCj4gICAgICBJUFBS
T1RPX1JPVVRJTkcgPSA0MywgIC8qIElQdjYgcm91dGluZyBoZWFkZXIuICAqLw0KPiAgICAgIF4N
Cj4gL3Vzci9pbmNsdWRlL2xpbnV4L2luNi5oOjEzMjoyNjogbm90ZTogZXhwYW5kZWQgZnJvbSBt
YWNybyAnSVBQUk9UT19ST1VUSU5HJw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBeDQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSB0ZXN0X3RjcG5vdGlmeV9rZXJuLmM6MTI6DQo+
IC91c3IvaW5jbHVkZS9uZXRpbmV0L2luLmg6MTA1OjU6IGVycm9yOiBleHBlY3RlZCBpZGVudGlm
aWVyDQo+ICAgICAgSVBQUk9UT19GUkFHTUVOVCA9IDQ0LCAvKiBJUHY2IGZyYWdtZW50YXRpb24g
aGVhZGVyLiAgKi8NCj4gICAgICBeDQo+IC91c3IvaW5jbHVkZS9saW51eC9pbjYuaDoxMzM6MjY6
IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ0lQUFJPVE9fRlJBR01FTlQnDQo+ICINCj4gVGhl
IHNhbWUgY29tcGlsZSBlcnJvcnMgYXJlIHJlcG9ydGVkIGZvciB0ZXN0X3RjcGJwZl9rZXJuLmMg
dG9vLg0KPiANCj4gTXkgZW52aXJvbm1lbnQ6DQo+IGxzYl9yZWxlYXNlIC1hOg0KPiBObyBMU0Ig
bW9kdWxlcyBhcmUgYXZhaWxhYmxlLg0KPiBEaXN0cmlidXRvciBJRDogVWJ1bnR1DQo+IERlc2Ny
aXB0aW9uOiAgICBVYnVudHUgMTYuMDQuNiBMVFMNCj4gUmVsZWFzZTogICAgICAgIDE2LjA0DQo+
IENvZGVuYW1lOiAgICAgICB4ZW5pYWwNCj4gDQo+IGRwa2cgLWwgfCBncmVwIGxpYmMtZGV2Og0K
PiBpaSAgbGliYy1kZXYtYmluICAgICAgICAgICAgICAyLjIzLTB1YnVudHUxMSAgICAgICAgICAg
YW1kNjQgICAgICAgIEdOVSBDIExpYnJhcnk6IERldmVsb3BtZW50IGJpbmFyaWVzDQo+IGlpICBs
aW51eC1saWJjLWRldjphbWQ2NCAgICAgIDQuNC4wLTE0NS4xNzEgICAgICAgICAgICBhbWQ2NCAg
ICAgICAgTGludXggS2VybmVsIEhlYWRlcnMgZm9yIGRldmVsb3BtZW50Lg0KPiANCj4gVGhlIHJl
YXNvbiBpcyBsaW51eC9pbjYuaCBhbmQgbmV0aW5ldC9pbi5oIGFyZW4ndCBzeW5jaHJvbm91cyBh
Ym91dCBob3cgdG8NCj4gaGFuZGxlIHRoZSBzYW1lIGRlZmluaXRpb25zLCBJUFBST1RPX0hPUE9Q
VFMsIGV0Yy4NCj4gDQo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGNvbXBpbGUgZXJyb3JzIGJ5IG1v
dmluZyA8bmV0aW5ldC9pbi5oPiB0byBiZWZvcmUgdGhlDQo+IDxsaW51eC8qLmg+Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogV2FuZyBZYW5RaW5nIDx1ZGtuaWdodEBnbWFpbC5jb20+DQoNClRlc3Rl
ZCBhbmQgdGhlIGNoYW5nZSBtYWtlcyBzZW5zZS4gQnkgY2hhbmdpbmcgdGhlIGluY2x1ZGUgb3Jk
ZXIsIG5vdyB3ZSANCmhhdmUgbGludXggY2hlY2tzIHRoZSBleGlzdGVuY2Ugb2YgbWFjcm8gX05F
VElORVRfSU5fSCBpbnN0ZWFkIG9mDQpjZXJ0YWluIHZlcnNpb25zIG9mIGdsaWJjIGNoZWNrcyBf
VUFQSV9MSU5VWF9JTjZfSCB3aGljaCBkb2VzIG5vdCBleGlzdA0KZm9yIGFsbCByZWNlbnQga2Vy
bmVscyAoYXQgbGVhc3QgNC40IGFuZCBvbndhcmRzKS4NCg0KQWNrZWQtYnk6IFlvbmdob25nIFNv
bmcgPHloc0BmYi5jb20+DQoNCg0KPiAtLS0NCj4gICBDaGFuZ2VzDQo+ICAgdjEtdjI6DQo+ICAg
MTpSZXdyaXRlIHRoZSBjaGFuZ2Vsb2cuDQo+IA0KPiAgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9wcm9ncy90ZXN0X3RjcGJwZl9rZXJuLmMgICAgfCAyICstDQo+ICAgdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Rlc3RfdGNwbm90aWZ5X2tlcm4uYyB8IDIgKy0NCj4gICAy
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF90Y3BicGZf
a2Vybi5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Rlc3RfdGNwYnBmX2tl
cm4uYw0KPiBpbmRleCA3NGY3M2IzLi5jN2MzMjQwIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF90Y3BicGZfa2Vybi5jDQo+ICsrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy90ZXN0X3RjcGJwZl9rZXJuLmMNCj4gQEAgLTEs
NiArMSw3IEBADQo+ICAgLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gICAj
aW5jbHVkZSA8c3RkZGVmLmg+DQo+ICAgI2luY2x1ZGUgPHN0cmluZy5oPg0KPiArI2luY2x1ZGUg
PG5ldGluZXQvaW4uaD4NCj4gICAjaW5jbHVkZSA8bGludXgvYnBmLmg+DQo+ICAgI2luY2x1ZGUg
PGxpbnV4L2lmX2V0aGVyLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L2lmX3BhY2tldC5oPg0KPiBA
QCAtOSw3ICsxMCw2IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ICAgI2luY2x1
ZGUgPGxpbnV4L3NvY2tldC5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC90Y3AuaD4NCj4gLSNpbmNs
dWRlIDxuZXRpbmV0L2luLmg+DQo+ICAgI2luY2x1ZGUgImJwZl9oZWxwZXJzLmgiDQo+ICAgI2lu
Y2x1ZGUgImJwZl9lbmRpYW4uaCINCj4gICAjaW5jbHVkZSAidGVzdF90Y3BicGYuaCINCj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy90ZXN0X3RjcG5vdGlm
eV9rZXJuLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF90Y3Bub3Rp
Znlfa2Vybi5jDQo+IGluZGV4IGVkYmNhMjAuLmVjNmRiNmUgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy90ZXN0X3RjcG5vdGlmeV9rZXJuLmMNCj4gKysr
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Rlc3RfdGNwbm90aWZ5X2tlcm4u
Yw0KPiBAQCAtMSw2ICsxLDcgQEANCj4gICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMA0KPiAgICNpbmNsdWRlIDxzdGRkZWYuaD4NCj4gICAjaW5jbHVkZSA8c3RyaW5nLmg+DQo+
ICsjaW5jbHVkZSA8bmV0aW5ldC9pbi5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9icGYuaD4NCj4g
ICAjaW5jbHVkZSA8bGludXgvaWZfZXRoZXIuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvaWZfcGFj
a2V0Lmg+DQo+IEBAIC05LDcgKzEwLDYgQEANCj4gICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4N
Cj4gICAjaW5jbHVkZSA8bGludXgvc29ja2V0Lmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3RjcC5o
Pg0KPiAtI2luY2x1ZGUgPG5ldGluZXQvaW4uaD4NCj4gICAjaW5jbHVkZSAiYnBmX2hlbHBlcnMu
aCINCj4gICAjaW5jbHVkZSAiYnBmX2VuZGlhbi5oIg0KPiAgICNpbmNsdWRlICJ0ZXN0X3RjcG5v
dGlmeS5oIg0KPiANCg==
