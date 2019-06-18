Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A7C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBD920645
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="V/nOFIy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfFRGre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:47:34 -0400
Received: from mail-eopbgr760074.outbound.protection.outlook.com ([40.107.76.74]:50278
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728195AbfFRGrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBj+6gPNppaLfSon7xS8n0B5MCFhpTaR8lqFB4mqKV8=;
 b=V/nOFIy6yWCfsC7FstmTWZQ6j8bu4WmTJOJ6itnrcggA0SKkjrrXEbq0QKSvLunUmAHz8zpXg2fGeGnjwzzmL2iS4s2iBIusi2N28mxWakZ3JfO7BGRXeIwKN5DriuKh5aOydU3Xxn8IMW8M694NnwmpcfKA1iqakq4FBvKE0yI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6312.namprd05.prod.outlook.com (20.178.51.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.11; Tue, 18 Jun 2019 05:33:12 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2008.007; Tue, 18 Jun 2019
 05:33:12 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Borislav Petkov <bp@suse.de>, Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3] resource: Introduce resource cache
Thread-Topic: [PATCH 3/3] resource: Introduce resource cache
Thread-Index: AQHVIaTIgkJbYpRVG0mXAw73pWsOuqag4XgAgAAJ4gA=
Date:   Tue, 18 Jun 2019 05:33:12 +0000
Message-ID: <98464609-8F5A-47B9-A64E-2F67809737AD@vmware.com>
References: <20190613045903.4922-1-namit@vmware.com>
 <20190613045903.4922-4-namit@vmware.com>
 <20190617215750.8e46ae846c09cd5c1f22fdf9@linux-foundation.org>
In-Reply-To: <20190617215750.8e46ae846c09cd5c1f22fdf9@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 640bd28d-cb55-49f8-0dd8-08d6f3ae74bd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6312;
x-ms-traffictypediagnostic: BYAPR05MB6312:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR05MB631223752283964C12CA8573D0EA0@BYAPR05MB6312.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(486006)(14454004)(53546011)(66946007)(6506007)(66446008)(64756008)(66476007)(478600001)(4326008)(5660300002)(33656002)(73956011)(36756003)(229853002)(66556008)(86362001)(76116006)(966005)(25786009)(2616005)(186003)(446003)(71190400001)(476003)(71200400001)(14444005)(256004)(26005)(102836004)(53376002)(2906002)(6246003)(81166006)(6436002)(8676002)(81156014)(99286004)(11346002)(6512007)(76176011)(6306002)(66066001)(53936002)(68736007)(305945005)(316002)(6916009)(54906003)(7736002)(6486002)(8936002)(3846002)(6116002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6312;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SilzUoourfhHYUwbGY/Te8pM7BRAuv2/ZefLrzM5YVCKvJr+/73PW9aDL5VjCDDOHQ8Dnmd+Vh7KxSHgiLV9xPv8UgsCQAO18xciy5rW0xyqofwtcfJS3YbfSpP7HY1/3M13TzVt1o04j27b2mEoaPBGsvFHbHko/DpdPcoFQm66aQkcacAoe4LUmfMI64ASbibZieElEfixyqsi3RYb9fGqQnh6cl+gHNbwp8d+2hbWGyHz5jbbjHbgvEfWqa7qKdvcmx/nfBBTEgTSaYkv17nh2GafXLtOIUSUxsSf2U/+TG52uhks+bSw+FKHg5wnerlX7lzhv9Qwsbfmroq39ruafMY8JYFqb4goJowHIFPAu8mVkJ89ljggrWjYfnjg7y8T4LXDl/KcDlFrMR0iSO4nRRwwuIHkT3AGTPWSCv4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4A32AD2F1BDF74F9714AD2C3E4E6334@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640bd28d-cb55-49f8-0dd8-08d6f3ae74bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 05:33:12.6640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6312
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gMTcsIDIwMTksIGF0IDk6NTcgUE0sIEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCAxMiBKdW4gMjAxOSAyMTo1OTow
MyAtMDcwMCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4gDQo+PiBGb3Ig
ZWZmaWNpZW50IHNlYXJjaCBvZiByZXNvdXJjZXMsIGFzIG5lZWRlZCB0byBkZXRlcm1pbmUgdGhl
IG1lbW9yeQ0KPj4gdHlwZSBmb3IgZGF4IHBhZ2UtZmF1bHRzLCBpbnRyb2R1Y2UgYSBjYWNoZSBv
ZiB0aGUgbW9zdCByZWNlbnRseSB1c2VkDQo+PiB0b3AtbGV2ZWwgcmVzb3VyY2UuIENhY2hpbmcg
dGhlIHRvcC1sZXZlbCBzaG91bGQgYmUgc2FmZSBhcyByYW5nZXMgaW4NCj4+IHRoYXQgbGV2ZWwg
ZG8gbm90IG92ZXJsYXAgKHVubGlrZSB0aG9zZSBvZiBsb3dlciBsZXZlbHMpLg0KPj4gDQo+PiBL
ZWVwIHRoZSBjYWNoZSBwZXItY3B1IHRvIGF2b2lkIHBvc3NpYmxlIGNvbnRlbnRpb24uIFdoZW5l
dmVyIGEgcmVzb3VyY2UNCj4+IGlzIGFkZGVkLCByZW1vdmVkIG9yIGNoYW5nZWQsIGludmFsaWRh
dGUgYWxsIHRoZSByZXNvdXJjZXMuIFRoZQ0KPj4gaW52YWxpZGF0aW9uIHRha2VzIHBsYWNlIHdo
ZW4gdGhlIHJlc291cmNlX2xvY2sgaXMgdGFrZW4gZm9yIHdyaXRlLA0KPj4gcHJldmVudGluZyBw
b3NzaWJsZSByYWNlcy4NCj4+IA0KPj4gVGhpcyBwYXRjaCBwcm92aWRlcyByZWxhdGl2ZWx5IHNt
YWxsIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50cyBvdmVyIHRoZQ0KPj4gcHJldmlvdXMgcGF0Y2gg
KH4wLjUlIG9uIHN5c2JlbmNoKSwgYnV0IGNhbiBiZW5lZml0IHN5c3RlbXMgd2l0aCBtYW55DQo+
PiByZXNvdXJjZXMuDQo+IA0KPj4gLS0tIGEva2VybmVsL3Jlc291cmNlLmMNCj4+ICsrKyBiL2tl
cm5lbC9yZXNvdXJjZS5jDQo+PiBAQCAtNTMsNiArNTMsMTIgQEAgc3RydWN0IHJlc291cmNlX2Nv
bnN0cmFpbnQgew0KPj4gDQo+PiBzdGF0aWMgREVGSU5FX1JXTE9DSyhyZXNvdXJjZV9sb2NrKTsN
Cj4+IA0KPj4gKy8qDQo+PiArICogQ2FjaGUgb2YgdGhlIHRvcC1sZXZlbCByZXNvdXJjZSB0aGF0
IHdhcyBtb3N0IHJlY2VudGx5IHVzZSBieQ0KPj4gKyAqIGZpbmRfbmV4dF9pb21lbV9yZXMoKS4N
Cj4+ICsgKi8NCj4+ICtzdGF0aWMgREVGSU5FX1BFUl9DUFUoc3RydWN0IHJlc291cmNlICosIHJl
c291cmNlX2NhY2hlKTsNCj4gDQo+IEEgcGVyLWNwdSBjYWNoZSB3aGljaCBpcyBhY2Nlc3NlZCB1
bmRlciBhIGtlcm5lbC13aWRlIHJlYWRfbG9jayBsb29rcyBhDQo+IGJpdCBvZGQgLSB0aGUgbGF0
ZW5jeSBnZXR0aW5nIGF0IHRoYXQgcndsb2NrIHdpbGwgc3dhbXAgdGhlIGJlbmVmaXQgb2YNCj4g
aXNvbGF0aW5nIHRoZSBDUFVzIGZyb20gZWFjaCBvdGhlciB3aGVuIGFjY2Vzc2luZyByZXNvdXJj
ZV9jYWNoZS4NCj4gDQo+IE9uIHRoZSBvdGhlciBoYW5kLCBpZiB3ZSBoYXZlIG11bHRpcGxlIENQ
VXMgcnVubmluZw0KPiBmaW5kX25leHRfaW9tZW1fcmVzKCkgY29uY3VycmVudGx5IHRoZW4geWVz
LCBJIHNlZSB0aGUgYmVuZWZpdC4gIEhhcw0KPiB0aGUgYmVuZWZpdCBvZiB1c2luZyBhIHBlci1j
cHUgY2FjaGUgKHJhdGhlciB0aGFuIGEga2VybmVsLXdpZGUgb25lKQ0KPiBiZWVuIHF1YW50aWZp
ZWQ/DQoNCk5vLiBJIGFtIG5vdCBzdXJlIGhvdyBlYXN5IGl0IHdvdWxkIGJlIHRvIG1lYXN1cmUg
aXQuIE9uIHRoZSBvdGhlciBoYW5kZXINCnRoZSBsb2NrIGlzIG5vdCBzdXBwb3NlZCB0byBiZSBj
b250ZW5kZWQgKGF0IG1vc3QgY2FzZXMpLiBBdCB0aGUgdGltZSBJIHNhdw0KbnVtYmVycyB0aGF0
IHNob3dlZCB0aGF0IHN0b3JlcyB0byDigJxleGNsdXNpdmUiIGNhY2hlIGxpbmVzIGNhbiBiZSBh
cw0KZXhwZW5zaXZlIGFzIGF0b21pYyBvcGVyYXRpb25zIFsxXS4gSSBhbSBub3Qgc3VyZSBob3cg
dXAgdG8gZGF0ZSB0aGVzZQ0KbnVtYmVycyBhcmUgdGhvdWdoLiBJbiB0aGUgYmVuY2htYXJrIEkg
cmFuLCBtdWx0aXBsZSBDUFVzIHJhbg0KZmluZF9uZXh0X2lvbWVtX3JlcygpIGNvbmN1cnJlbnRs
eS4NCg0KWzFdIGh0dHA6Ly9zaWdvcHMub3JnL3MvY29uZmVyZW5jZXMvc29zcC8yMDEzL3BhcGVy
cy9wMzMtZGF2aWQucGRmDQoNCj4gDQo+IA0KPj4gQEAgLTI2Miw5ICsyNjgsMjAgQEAgc3RhdGlj
IHZvaWQgX19yZWxlYXNlX2NoaWxkX3Jlc291cmNlcyhzdHJ1Y3QgcmVzb3VyY2UgKnIpDQo+PiAJ
fQ0KPj4gfQ0KPj4gDQo+PiArc3RhdGljIHZvaWQgaW52YWxpZGF0ZV9yZXNvdXJjZV9jYWNoZSh2
b2lkKQ0KPj4gK3sNCj4+ICsJaW50IGNwdTsNCj4+ICsNCj4+ICsJbG9ja2RlcF9hc3NlcnRfaGVs
ZF9leGNsdXNpdmUoJnJlc291cmNlX2xvY2spOw0KPj4gKw0KPj4gKwlmb3JfZWFjaF9wb3NzaWJs
ZV9jcHUoY3B1KQ0KPj4gKwkJcGVyX2NwdShyZXNvdXJjZV9jYWNoZSwgY3B1KSA9IE5VTEw7DQo+
PiArfQ0KPiANCj4gQWxsIHRoZSBjYWxscyB0byBpbnZhbGlkYXRlX3Jlc291cmNlX2NhY2hlKCkg
YXJlIHJhdGhlciBhDQo+IG1haW50YWluYWJpbGl0eSBpc3N1ZSAtIGVhc3kgdG8gbWlzcyBvbmUg
YXMgdGhlIGNvZGUgZXZvbHZlcy4NCj4gDQo+IENhbid0IHdlIGp1c3QgbWFrZSBmaW5kX25leHRf
aW9tZW1fcmVzKCkgc21hcnRlcj8gIEZvciBleGFtcGxlLCBzdGFydA0KPiB0aGUgbG9va3VwIGZy
b20gdGhlIGNhY2hlZCBwb2ludCBhbmQgaWYgdGhhdCBmYWlsZWQsIGRvIGEgZnVsbCBzd2VlcD8N
Cg0KSSBtYXkgYmUgYWJsZSB0byBkbyBzb21ldGhpbmcgbGlrZSB0aGF0IHRvIHJlZHVjZSB0aGUg
bnVtYmVyIG9mIGxvY2F0aW9ucw0KdGhhdCBuZWVkIHRvIGJlIHVwZGF0ZWQsIGJ1dCB5b3UgYWx3
YXlzIG5lZWQgdG8gaW52YWxpZGF0ZSBpZiBhIHJlc291cmNlIGlzDQpyZW1vdmVkLiBUaGlzIG1p
Z2h0IG1ha2UgdGhlIGNvZGUgbW9yZSBwcm9uZSB0byBidWdzLCBzaW5jZSB0aGUgbG9naWMgb2YN
CndoZW4gdG8gaW52YWxpZGF0ZSBiZWNvbWVzIG1vcmUgY29tcGxpY2F0ZWQuDQoNCj4+ICsJaW52
YWxpZGF0ZV9yZXNvdXJjZV9jYWNoZSgpOw0KPj4gKwlpbnZhbGlkYXRlX3Jlc291cmNlX2NhY2hl
KCk7DQo+PiArCWludmFsaWRhdGVfcmVzb3VyY2VfY2FjaGUoKTsNCj4+ICsJaW52YWxpZGF0ZV9y
ZXNvdXJjZV9jYWNoZSgpOw0KPj4gKwlpbnZhbGlkYXRlX3Jlc291cmNlX2NhY2hlKCk7DQo+PiAr
CWludmFsaWRhdGVfcmVzb3VyY2VfY2FjaGUoKTsNCj4+ICsJaW52YWxpZGF0ZV9yZXNvdXJjZV9j
YWNoZSgpOw0KPj4gKwlpbnZhbGlkYXRlX3Jlc291cmNlX2NhY2hlKCk7DQo+PiArCWludmFsaWRh
dGVfcmVzb3VyY2VfY2FjaGUoKTsNCj4+ICsJaW52YWxpZGF0ZV9yZXNvdXJjZV9jYWNoZSgpOw0K
Pj4gKwlpbnZhbGlkYXRlX3Jlc291cmNlX2NhY2hlKCk7DQo+PiArCQkJaW52YWxpZGF0ZV9yZXNv
dXJjZV9jYWNoZSgpOw0KPj4gKwlpbnZhbGlkYXRlX3Jlc291cmNlX2NhY2hlKCk7DQo+PiArCWlu
dmFsaWRhdGVfcmVzb3VyY2VfY2FjaGUoKTsNCj4gDQo+IE93LiAgSSBndWVzcyB0aGUgbWFpbnRh
aW5hYmlsaXR5IHNpdHVhdGlvbiBjYW4gYmUgaW1wcm92ZWQgYnkgcmVuYW1pbmcNCj4gcmVzb3Vy
Y2VfbG9jayB0byBzb21ldGhpbmcgZWxzZSAodG8gYXZvaWQgbWlzaGFwcykgdGhlbiBhZGRpbmcg
d3JhcHBlcg0KPiBmdW5jdGlvbnMuICBCdXQgc3RpbGwuICBJIGNhbid0IHNheSB0aGlzIGlzIGEg
c3VwZXItZXhjaXRpbmcgcGF0Y2ggOigNCg0KSSBjb25zaWRlcmVkIGRvaW5nIHNvLCBidXQgSSB3
YXMgbm90IHN1cmUgaXQgaXMgYmV0dGVyLiBJZiB5b3Ugd2FudCBJ4oCZbGwNCmltcGxlbWVudCBp
dCB1c2luZyB3cmFwcGVyIGZ1bmN0aW9ucyAoYnV0IGJvdGggbG9jayBhbmQgdW5sb2NrIHdvdWxk
IG5lZWQgDQp0byBiZSB3cmFwcGVkIGZvciBjb25zaXN0ZW5jeSkuDQoNClRoZSBiZW5lZml0IG9m
IHRoaXMgcGF0Y2ggb3ZlciB0aGUgcHJldmlvdXMgb25lIGlzIG5vdCBodWdlLCBhbmQgSSBkb27i
gJl0DQprbm93IGhvdyB0byBpbXBsZW1lbnQgaXQgYW55IGJldHRlciAoZXhjbHVkaW5nIHdyYXBw
ZXIgZnVuY3Rpb24sIGlmIHlvdQ0KY29uc2lkZXIgaXQgYmV0dGVyKS4gSWYgeW91IHdhbnQsIHlv
dSBjYW4ganVzdCBkcm9wIHRoaXMgcGF0Y2guDQoNCg0K
