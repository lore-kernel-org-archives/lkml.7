Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBAFC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71EB20679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfFXCKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:10:18 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:25304 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbfFXCKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:10:18 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5NNiO5J025879;
        Sun, 23 Jun 2019 23:44:59 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ta4wgb9hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jun 2019 23:44:59 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 5141954;
        Sun, 23 Jun 2019 23:44:58 +0000 (UTC)
Received: from G4W9334.americas.hpqcorp.net (16.208.32.120) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 23 Jun 2019 23:44:58 +0000
Received: from G4W10205.americas.hpqcorp.net (2002:10cf:520f::10cf:520f) by
 G4W9334.americas.hpqcorp.net (2002:10d0:2078::10d0:2078) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Sun, 23 Jun 2019 23:44:57 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G4W10205.americas.hpqcorp.net (16.207.82.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Sun, 23 Jun 2019 23:44:57 +0000
Received: from CS1PR8401MB0727.NAMPRD84.PROD.OUTLOOK.COM (10.169.15.135) by
 CS1PR8401MB0950.NAMPRD84.PROD.OUTLOOK.COM (10.169.14.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Sun, 23 Jun 2019 23:44:55 +0000
Received: from CS1PR8401MB0727.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f490:9066:df17:59e1]) by CS1PR8401MB0727.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f490:9066:df17:59e1%2]) with mapi id 15.20.2008.014; Sun, 23 Jun 2019
 23:44:55 +0000
From:   "Vaden, Tom (HPE Server OS Architecture)" <tom.vaden@hpe.com>
To:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>
Subject: Re: [RFC] perf/x86/intel: Disable check_msr for real hw
Thread-Topic: [RFC] perf/x86/intel: Disable check_msr for real hw
Thread-Index: AQHVKFmGdWbA6mjcsEqpP4V4vJdZSaap2KCAgAAR2QA=
Date:   Sun, 23 Jun 2019 23:44:55 +0000
Message-ID: <73ec1d24-2dcf-1d48-2907-735fc1a4a7d0@hpe.com>
References: <20190614112853.GC4325@krava>
 <20190621174825.GA31027@tassilo.jf.intel.com> <20190623224031.GB5471@krava>
In-Reply-To: <20190623224031.GB5471@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:207:3d::14) To CS1PR8401MB0727.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750d::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:85:c100:2d8d:dbb0:2ed9:59d1:461]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09f651ff-b2d1-49b5-afe3-08d6f834cb31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CS1PR8401MB0950;
x-ms-traffictypediagnostic: CS1PR8401MB0950:
x-microsoft-antispam-prvs: <CS1PR8401MB0950C2C8EDA839ECC6F47018E8E10@CS1PR8401MB0950.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00770C4423
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(52116002)(7736002)(76176011)(66556008)(186003)(64756008)(66446008)(53546011)(316002)(66476007)(73956011)(305945005)(6436002)(66946007)(14444005)(256004)(110136005)(31686004)(54906003)(8936002)(6506007)(386003)(229853002)(5024004)(6486002)(71190400001)(71200400001)(4326008)(81156014)(53936002)(25786009)(6512007)(8676002)(81166006)(446003)(68736007)(36756003)(31696002)(86362001)(478600001)(11346002)(476003)(2616005)(46003)(14454004)(102836004)(5660300002)(7416002)(486006)(6246003)(6116002)(2906002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CS1PR8401MB0950;H:CS1PR8401MB0727.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IIO4ger6hNA1luWNW3zEqGawoUPNzW2f6+nNJTPa9qHaLWoiL1AW5/WaBEjN+6QUPaLvw3nv18EWDKqHaqNjarPq1EfpUUUsrD7kpSbyCoyPEAt9CLy+B0tPj4uG1J6ldMCS3q9sMeQaB05HstVSOEMtLO4yyr9JAwTer7t+e1WCXH34axR52ljWo+k/RBG2vyHBT6O6Rpwj8QF6rT5SjJqtJpBNrD4daVfPBxBRd8Zsu22730I/q5398UuA4OtWRO9nrpvL7FGUB49PhuaopiuyGQPz3rf0D4WLTC9sC1xjcw9hb0v44Fwfjf9RGzhnDwCiKm2SxzA5vsJh3jlU0/jt9tQr/X/NTHsweHQzq5szx78RR2eDgOpkmixjuROs96qJu1LBSbbgEBIdLR5tVWAQgrCD+yeu+TkWoBIqsfc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <304388C5C470954189ACB4092458D712@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f651ff-b2d1-49b5-afe3-08d6f834cb31
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2019 23:44:55.2924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tom.vaden@hpe.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0950
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-23_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906230205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDYvMjMvMTkgNjo0MCBQTSwgSmlyaSBPbHNhIHdyb3RlOg0KPiBPbiBGcmksIEp1biAy
MSwgMjAxOSBhdCAxMDo0ODoyNUFNIC0wNzAwLCBBbmRpIEtsZWVuIHdyb3RlOg0KPj4gT24gRnJp
LCBKdW4gMTQsIDIwMTkgYXQgMDE6Mjg6NTNQTSArMDIwMCwgSmlyaSBPbHNhIHdyb3RlOg0KPj4+
IGhpLA0KPj4+IHRoZSBIUEUgc2VydmVyIGNhbiBkbyBQT1NUIHRyYWNpbmcgYW5kIGhhdmUgZW5h
YmxlZCBMQlINCj4+PiB0cmFjaW5nIGR1cmluZyB0aGUgYm9vdCwgd2hpY2ggbWFrZXMgY2hlY2tf
bXNyIGZhaWwgZmFsc2x5Lg0KPj4+DQo+Pj4gSXQgbG9va3MgbGlrZSBjaGVja19tc3IgY29kZSB3
YXMgYWRkZWQgb25seSB0byBjaGVjayBvbiBndWVzdHMNCj4+PiBNU1IgYWNjZXNzLCB3b3VsZCBp
dCBiZSB0aGVuIG9rIHRvIGRpc2FibGUgY2hlY2tfbXNyIGZvciByZWFsDQo+Pj4gaGFyZHdhcmU/
IChhcyBpbiBwYXRjaCBiZWxvdykNCj4+Pg0KPj4+IFdlIGNvdWxkIGFsc28gY2hlY2sgaWYgTEJS
IHRyYWNpbmcgaXMgZW5hYmxlZCBhbmQgbWFrZQ0KPj4+IGFwcHJvcHJpYXRlIGNoZWNrcywgYnV0
IHRoaXMgY2hhbmdlIGlzIHNpbXBsZXIgOy0pDQo+Pj4NCj4+PiBpZGVhcz8gdGhhbmtzLA0KPj4+
IGppcmthDQo+Pg0KPj4gU29ycnkgZm9yIHRoZSBsYXRlIGNvbW1lbnQuIEkgc2VlIHRoaXMgcGF0
Y2ggaGFzIGJlZW4gbWVyZ2VkIG5vdy4NCj4+DQo+PiBVbmZvcnR1bmF0ZWx5IEkgZG9uJ3QgdGhp
bmsgaXQncyBhIGdvb2QgaWRlYS4gVGhlIHByb2JsZW0NCj4+IGlzIHRoYXQgdGhlIGh5cGVydmlz
b3IgZmxhZ3MgYXJlIG9ubHkgc2V0IGZvciBhIGZldyBoeXBlcnZpc29ycw0KPj4gdGhhdCBMaW51
eCBrbm93cyBhYm91dC4gQnV0IGluIHByYWN0aWNlIHRoZXJlIGFyZSBtYW55IG1vcmUNCj4+IEh5
cGVydmlzb3JzIGFyb3VuZCB0aGF0IHdpbGwgbm90IGNhdXNlIHRoZXNlIGZsYWdzIHRvIGJlIHNl
dC4NCj4+IEJ1dCB0aGVzZSBhcmUgc3RpbGwgbGlrZWx5IHRvIG1pc3MgTVNScy4NCj4+DQo+PiBU
aGUgb3RoZXIgaHlwZXJ2aXNvcnMgYXJlIHJlbGF0aXZlbHkgb2JzY3VyZSwgYnV0IGV2ZW50dWFs
bHkNCj4+IHNvbWVvbmUgd2lsbCBoaXQgcHJvYmxlbXMuDQo+IA0KPiBhbnkgaWRlYSBpZiB0aGVy
ZSdzIGFueSBvdGhlciBmbGFnL3dheSB3ZSBjb3VsZCB1c2UgdG8gZGV0ZWN0IHRob3NlPw0KPiAN
Cj4gYWRkaW5nIGZldyB2aXJ0dWFsaXphdGlvbiBmb2xrcyB0byB0aGUgbG9vcA0KPiBhbmQgYXR0
YWNoaW5nIHRoZSBvcmlnaW5hbCBwYXRjaA0KPiANCj4gdGhhbmtzLA0KPiBqaXJrYQ0KPiANCldv
dWxkIGl0IGJlIHJlYXNvbmFibGUgdG8gY2hhbmdlIHRoZSBzZW5zZSBvZiB0aGUgb3JpZ2luYWwg
cGF0Y2ggaW4gDQpjb21taXQgNDU1MDkzMSB0byBvbmx5IGVuYWJsZSB0aGUgY2hlY2sgZm9yIHRo
ZSBzZXQgb2YgImNlcnRhaW4gaGFyZHdhcmUgDQplbXVsYXRvcnMiIGFuZCBsZWF2ZSB0aGUgY2hl
Y2sgb3RoZXJ3aXNlIGRpc2FibGVkIGJ5IGRlZmF1bHQ/IEknbSANCmFzc3VtaW5nIHRoYXQgc2V0
IGlzIGtub3duIChhbmQgc21hbGwpPw0KDQo+IA0KPiAtLS0NCj4gVG9tIFZhZGVuIHJlcG9ydGVk
IGZhbHNlIGZhaWx1cmUgb2YgY2hlY2tfbXNyIGZ1bmN0aW9uLCBiZWNhdXNlDQo+IHNvbWUgc2Vy
dmVycyBjYW4gZG8gUE9TVCB0cmFjaW5nIGFuZCBlbmFibGUgTEJSIHRyYWNpbmcgZHVyaW5nDQo+
IHRoZSBib290Lg0KPiANCj4gS2FuIGNvbmZpcm1lZCB0aGF0IGNoZWNrX21zciBwYXRjaCB3YXMg
dG8gZml4IGEgYnVnIHJlcG9ydCBpbg0KPiBndWVzdCwgc28gaXQncyBvayB0byBkaXNhYmxlIGl0
IGZvciByZWFsIEhXLg0KPiANCj4gQ2M6IEthbiBMaWFuZyA8a2FuLmxpYW5nQGludGVsLmNvbT4N
Cj4gUmVwb3J0ZWQtYnk6IFRvbSBWYWRlbiA8dG9tLnZhZGVuQGhwZS5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEppcmkgT2xzYSA8am9sc2FAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICAgYXJjaC94ODYv
ZXZlbnRzL2ludGVsL2NvcmUuYyB8IDggKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZXZlbnRzL2ludGVsL2Nv
cmUuYyBiL2FyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3JlLmMNCj4gaW5kZXggNzEwMDFmMDA1YmZl
Li4xMTk0YWU3ZTE5OTIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3Jl
LmMNCj4gKysrIGIvYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYw0KPiBAQCAtMjAsNiArMjAs
NyBAQA0KPiAgICNpbmNsdWRlIDxhc20vaW50ZWwtZmFtaWx5Lmg+DQo+ICAgI2luY2x1ZGUgPGFz
bS9hcGljLmg+DQo+ICAgI2luY2x1ZGUgPGFzbS9jcHVfZGV2aWNlX2lkLmg+DQo+ICsjaW5jbHVk
ZSA8YXNtL2h5cGVydmlzb3IuaD4NCj4gICANCj4gICAjaW5jbHVkZSAiLi4vcGVyZl9ldmVudC5o
Ig0KPiAgIA0KPiBAQCAtNDA1MCw2ICs0MDUxLDEzIEBAIHN0YXRpYyBib29sIGNoZWNrX21zcih1
bnNpZ25lZCBsb25nIG1zciwgdTY0IG1hc2spDQo+ICAgew0KPiAgIAl1NjQgdmFsX29sZCwgdmFs
X25ldywgdmFsX3RtcDsNCj4gICANCj4gKwkvKg0KPiArCSAqIERpc2FibGUgdGhlIGNoZWNrIGZv
ciByZWFsIEhXLCBzbyB3ZSBkb24ndA0KPiArCSAqIG1lc3MgdXAgd2l0aCBwb3RlbnRpb25hbHkg
ZW5hYmxlZCByZWdzLg0KPiArCSAqLw0KPiArCWlmIChoeXBlcnZpc29yX2lzX3R5cGUoWDg2X0hZ
UEVSX05BVElWRSkpDQo+ICsJCXJldHVybiB0cnVlOw0KPiArDQo+ICAgCS8qDQo+ICAgCSAqIFJl
YWQgdGhlIGN1cnJlbnQgdmFsdWUsIGNoYW5nZSBpdCBhbmQgcmVhZCBpdCBiYWNrIHRvIHNlZSBp
ZiBpdA0KPiAgIAkgKiBtYXRjaGVzLCB0aGlzIGlzIG5lZWRlZCB0byBkZXRlY3QgY2VydGFpbiBo
YXJkd2FyZSBlbXVsYXRvcnMNCj4gDQo=
