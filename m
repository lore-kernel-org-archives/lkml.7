Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14B5C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBA2206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="SkPbGN7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388604AbfGPW24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:28:56 -0400
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:63653
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728434AbfGPW2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:28:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8zkTipgFnJCwPE4OzPftJXKvhRUixnqpl8QErYTLi3BI0nLqAocKT8NDLLvICrKlyoElQjbJmTJRf3ubhSMLhUmNMqidxv4vtBnrYkNrTRX97O/cSbsPvWFHrXqJ0M1T8WLmkTmntweWPNRiaX9fwoSO3PqTuB/h0MwtlZYS6XLbNX6puLsWtG8KX5Wv7ely8razW3Z/F8pN+x+Bu5GssqUPUcDiFRG/DcycY7TXuyoMzjXfogViF/uE2tJngXB14iv+77R8/pLoEHYA/16YBjMg1cR/51k9aToH+MkfNMh5EjTIs7v2FH+BV8R8Tauoo9Q3n6qIM52ySiLwtf7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euvZBx8+PGP4oQyhfTX7I6SaQx5wEliG8hLk4ImIBI4=;
 b=iO5dOssYqszO/BwQYc6JJMm1WNtsjSxnu9RbFHNxBUPYLKelcVxARkwIxRcj2cv7TF3Up5Fx84tZW+VYKoge8qaoQgjhDzBiWblW7/DPre1Djco/5CEOAztlcRqGipS8X7o8S4gb44pCpTMtvPCuj6zU4ztIfAtYjqsOKSBkikxETmnrQAB37TJyygdJrlZCe6bk/D5/AQGRSqReUwme7/etGH01j7ta2Cb7Nv6sdd1GXduoRnfCjYKqfkORS9H4Vl8TJnxLVz85Stz/IKgI+xrRku39Hs9HG5i+0H2P8pBl9NvnimvUcrI8A/KogVTvcalqEaYilKI6x5zDTfFeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euvZBx8+PGP4oQyhfTX7I6SaQx5wEliG8hLk4ImIBI4=;
 b=SkPbGN7chcvWItx3fbd/F81Wt6wwpcGb3QWn2JgVEQ5g5vDwJjNTwuKzpeviUV5MCKbW4dQr56Oku9WC8r8E9KlOBXog0nIeMJFXLoqP/e1LWRWaPP4in5GHoWWUTLJbk8/+z7yJMWgOkJY6z9lq9aAdOgQ1qQ6tyoY+/XWKy/4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5077.namprd05.prod.outlook.com (20.177.230.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.10; Tue, 16 Jul 2019 22:28:52 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2094.009; Tue, 16 Jul 2019
 22:28:52 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3] resource: find_next_iomem_res() improvements
Thread-Topic: [PATCH 0/3] resource: find_next_iomem_res() improvements
Thread-Index: AQHVIaTGJ7ym4R/nDEy6A26DLGCJOaag/0oAgAC3tYCAAA1/gIAAOaaAgCwCaoCAAAG+gIAAAbUAgAACIYCAAAJEgA==
Date:   Tue, 16 Jul 2019 22:28:51 +0000
Message-ID: <39E58DBC-C13E-429C-A5FC-8FD80ABBBF55@vmware.com>
References: <20190613045903.4922-1-namit@vmware.com>
 <CAPcyv4hpWg5DWRhazS-ftyghiZP-J_M-7Vd5tiUd5UKONOib8g@mail.gmail.com>
 <9387A285-B768-4B58-B91B-61B70D964E6E@vmware.com>
 <CAPcyv4hstt+0teXPtAq2nwFQaNb9TujgetgWPVMOnYH8JwqGeA@mail.gmail.com>
 <19C3DCA0-823E-46CB-A758-D5F82C5FA3C8@vmware.com>
 <20190716150047.3c13945decc052c077e9ee1e@linux-foundation.org>
 <CAPcyv4iqNHBy-_WbH9XBg5hSqxa=qnkc88EW5=g=-5845jNzsg@mail.gmail.com>
 <D463DD43-C09F-4B6E-B1BC-7E1CA5C8A9C4@vmware.com>
 <CAPcyv4gGkgCsf4NtDPj7FNcTMO6o+fUYgfq8AP_pLkqDSbxjzA@mail.gmail.com>
In-Reply-To: <CAPcyv4gGkgCsf4NtDPj7FNcTMO6o+fUYgfq8AP_pLkqDSbxjzA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e66d73ce-ffae-42b8-2fb8-08d70a3cfaf9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5077;
x-ms-traffictypediagnostic: BYAPR05MB5077:
x-microsoft-antispam-prvs: <BYAPR05MB5077924195DF6DB1C370A395D0CE0@BYAPR05MB5077.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(189003)(51914003)(55674003)(51444003)(54534003)(486006)(86362001)(6512007)(102836004)(76176011)(6506007)(66066001)(53546011)(316002)(6486002)(54906003)(8676002)(6436002)(11346002)(446003)(476003)(2616005)(6246003)(7736002)(186003)(478600001)(4326008)(33656002)(25786009)(14454004)(3846002)(229853002)(6916009)(6116002)(7416002)(305945005)(8936002)(2906002)(53936002)(71200400001)(71190400001)(5660300002)(66556008)(99286004)(76116006)(66476007)(66446008)(64756008)(68736007)(66946007)(26005)(36756003)(14444005)(256004)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5077;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cs4AkceCUmVRytJugRqQCJ4G97n3ZvYC8p634vaSE2lJlmdUbOnKrnSmh5o7F+lup6ngHZhPBszbrgqtca3JEoIfRe4gaw0hYGkkOmOy1FjczPFIPYs1FmeE43TNxyfn0M8pGFGOYz+T73hBntaYio3IBy2y4ZZ4x2L82GC/NXhYwUIsKVqLYfPF2qHUvjUMtfz1SNoKDC9yR+s5a4c1W4abJJFxjwdrDu9KsxH7os1rm2gv6P933JhUUgFdVlfLCyZkRskxiqDxm5VvvJEFwzqU4RtdlWZuliJ6wMgzyfAgAwWj7caWvsVUYm9q6syJzzyt/3/Ik7ohwk/bv7xP+FTnoCv3lXWf2t9Ju2PxvAFZ+y3/ECtDY+3980TJBJpuwFkuhkvZHYIl5Nz8SxxDgr+shjrJcpDKMTQHcSDvWvI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC8BE34143F66E469A1199FEDCC6E0DD@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66d73ce-ffae-42b8-2fb8-08d70a3cfaf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 22:28:51.9575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMTYsIDIwMTksIGF0IDM6MjAgUE0sIERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlh
bXNAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSnVsIDE2LCAyMDE5IGF0IDM6MTMg
UE0gTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+Pj4gT24gSnVsIDE2LCAy
MDE5LCBhdCAzOjA3IFBNLCBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4g
d3JvdGU6DQo+Pj4gDQo+Pj4gT24gVHVlLCBKdWwgMTYsIDIwMTkgYXQgMzowMSBQTSBBbmRyZXcg
TW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4+Pj4gT24gVHVlLCAx
OCBKdW4gMjAxOSAyMTo1Njo0MyArMDAwMCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3
cm90ZToNCj4+Pj4gDQo+Pj4+Pj4gLi4uYW5kIGlzIGNvbnN0YW50IGZvciB0aGUgbGlmZSBvZiB0
aGUgZGV2aWNlIGFuZCBhbGwgc3Vic2VxdWVudCBtYXBwaW5ncy4NCj4+Pj4+PiANCj4+Pj4+Pj4g
UGVyaGFwcyB5b3Ugd2FudCB0byBjYWNoZSB0aGUgY2FjaGFiaWxpdHktbW9kZSBpbiB2bWEtPnZt
X3BhZ2VfcHJvdCAod2hpY2ggSQ0KPj4+Pj4+PiBzZWUgYmVpbmcgZG9uZSBpbiBxdWl0ZSBhIGZl
dyBjYXNlcyksIGJ1dCBJIGRvbuKAmXQga25vdyB0aGUgY29kZSB3ZWxsIGVub3VnaA0KPj4+Pj4+
PiB0byBiZSBjZXJ0YWluIHRoYXQgZXZlcnkgdm1hIHNob3VsZCBoYXZlIGEgc2luZ2xlIHByb3Rl
Y3Rpb24gYW5kIHRoYXQgaXQNCj4+Pj4+Pj4gc2hvdWxkIG5vdCBjaGFuZ2UgYWZ0ZXJ3YXJkcy4N
Cj4+Pj4+PiANCj4+Pj4+PiBObywgSSdtIHRoaW5raW5nIHRoaXMgd291bGQgbmF0dXJhbGx5IGZp
dCBhcyBhIHByb3BlcnR5IGhhbmdpbmcgb2ZmIGENCj4+Pj4+PiAnc3RydWN0IGRheF9kZXZpY2Un
LCBhbmQgdGhlbiBjcmVhdGUgYSB2ZXJzaW9uIG9mIHZtZl9pbnNlcnRfbWl4ZWQoKQ0KPj4+Pj4+
IGFuZCB2bWZfaW5zZXJ0X3Bmbl9wbWQoKSB0aGF0IGJ5cGFzcyB0cmFja19wZm5faW5zZXJ0KCkg
dG8gaW5zZXJ0IHRoYXQNCj4+Pj4+PiBzYXZlZCB2YWx1ZS4NCj4+Pj4+IA0KPj4+Pj4gVGhhbmtz
IGZvciB0aGUgZGV0YWlsZWQgZXhwbGFuYXRpb24uIEnigJlsbCBnaXZlIGl0IGEgdHJ5ICh0aGUg
bW9tZW50IEkgZmluZA0KPj4+Pj4gc29tZSBmcmVlIHRpbWUpLiBJIHN0aWxsIHRoaW5rIHRoYXQg
cGF0Y2ggMi8zIGlzIGJlbmVmaWNpYWwsIGJ1dCBiYXNlZCBvbg0KPj4+Pj4geW91ciBmZWVkYmFj
aywgcGF0Y2ggMy8zIHNob3VsZCBiZSBkcm9wcGVkLg0KPj4+PiANCj4+Pj4gSXQgaGFzIGJlZW4g
YSB3aGlsZS4gIFdoYXQgc2hvdWxkIHdlIGRvIHdpdGgNCj4+Pj4gDQo+Pj4+IHJlc291cmNlLWZp
eC1sb2NraW5nLWluLWZpbmRfbmV4dF9pb21lbV9yZXMucGF0Y2gNCj4+PiANCj4+PiBUaGlzIG9u
ZSBsb29rcyBvYnZpb3VzbHkgY29ycmVjdCB0byBtZSwgeW91IGNhbiBhZGQ6DQo+Pj4gDQo+Pj4g
UmV2aWV3ZWQtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPj4+
IA0KPj4+PiByZXNvdXJjZS1hdm9pZC11bm5lY2Vzc2FyeS1sb29rdXBzLWluLWZpbmRfbmV4dF9p
b21lbV9yZXMucGF0Y2gNCj4+PiANCj4+PiBUaGlzIG9uZSBpcyBhIGdvb2QgYnVnIHJlcG9ydCB0
aGF0IHdlIG5lZWQgdG8gZ28gZml4IHBncHJvdCBsb29rdXBzDQo+Pj4gZm9yIGRheCwgYnV0IEkg
ZG9uJ3QgdGhpbmsgd2UgbmVlZCB0byBpbmNyZWFzZSB0aGUgdHJpY2tpbmVzcyBvZiB0aGUNCj4+
PiBjb3JlIHJlc291cmNlIGxvb2t1cCBjb2RlIGluIHRoZSBtZWFudGltZS4NCj4+IA0KPj4gSSB0
aGluayB0aGF0IHRyYXZlcnNpbmcgYmlnIHBhcnRzIG9mIHRoZSB0cmVlIHRoYXQgYXJlIGtub3du
IHRvIGJlDQo+PiBpcnJlbGV2YW50IGlzIHdhc3RlZnVsIG5vIG1hdHRlciB3aGF0LCBhbmQgdGhp
cyBjb2RlIGlzIHVzZWQgaW4gb3RoZXIgY2FzZXMuDQo+PiANCj4+IEkgZG9u4oCZdCB0aGluayB0
aGUgbmV3IGNvZGUgaXMgc28gdHJpY2t5IC0gY2FuIHlvdSBwb2ludCB0byB0aGUgcGFydCBvZiB0
aGUNCj4+IGNvZGUgdGhhdCB5b3UgZmluZCB0cmlja3k/DQo+IA0KPiBHaXZlbiBkYXggY2FuIGJl
IHVwZGF0ZWQgdG8gYXZvaWQgdGhpcyBhYnVzZSBvZiBmaW5kX25leHRfaW9tZW1fcmVzKCksDQo+
IGl0IHdhcyBhIGdlbmVyYWwgb2JzZXJ2YXRpb24gdGhhdCB0aGUgcGF0Y2ggYWRkcyBtb3JlIGxp
bmVzIHRoYW4gaXQNCj4gcmVtb3ZlcyBhbmQgaXMgbm90IHN0cmljdGx5IG5lY2Vzc2FyeS4gSSdt
IGFtYml2YWxlbnQgYXMgdG8gd2hldGhlciBpdA0KPiBpcyB3b3J0aCBwdXNoaW5nIHVwc3RyZWFt
LiBJZiBhbnl0aGluZyB0aGUgY2hhbmdlbG9nIGlzIGdvaW5nIHRvIGJlDQo+IGludmFsaWRhdGVk
IGJ5IGEgY2hhbmdlIHRvIGRheCB0byBhdm9pZCBmaW5kX25leHRfaW9tZW1fcmVzKCkuIENhbiB5
b3UNCj4gdXBkYXRlIHRoZSBjaGFuZ2Vsb2cgdG8gYmUgcmVsZXZhbnQgb3V0c2lkZSBvZiB0aGUg
ZGF4IGNhc2U/DQoNCldlbGwsIDggbGluZXMgYXJlIGNvbW1lbnRzLCA0IGFyZSBlbXB0eSBsaW5l
cywgc28gaXQgYWRkcyAzIGxpbmVzIG9mIGNvZGUNCmFjY29yZGluZyB0byBteSBjYWxjdWxhdGlv
bnMuIDopDQoNCkhhdmluZyBzYWlkIHRoYXQsIGlmIHlvdSB0aGluayBJIG1pZ2h0IGhhdmUgbWFk
ZSBhIG1pc3Rha2UsIG9yIHlvdSBhcmUNCmNvbmNlcm5lZCB3aXRoIHNvbWUgYnVnIEkgbWlnaHQg
aGF2ZSBjYXVzZWQsIHBsZWFzZSBsZXQgbWUga25vdy4gSQ0KdW5kZXJzdGFuZCB0aGF0IHRoaXMg
bG9naWMgbWlnaHQgaGF2ZSBiZWVuIGx5aW5nIGFyb3VuZCBmb3Igc29tZSB0aW1lLg0KDQpJIGNh
biB1cGRhdGUgdGhlIGNvbW1pdCBsb2csIGVtcGhhc2l6aW5nIHRoZSByZWR1bmRhbnQgc2VhcmNo
IG9wZXJhdGlvbnMgYXMNCm1vdGl2YXRpb24gYW5kIHRoZW4gbWVudGlvbmluZyBkYXggYXMgYW4g
aW5zdGFuY2UgdGhhdCBpbmR1Y2VzIG92ZXJoZWFkcyBkdWUNCnRvIHRoaXMgb3ZlcmhlYWQsIGFu
ZCBzYXkgaXQgc2hvdWxkIGJlIGhhbmRsZWQgcmVnYXJkbGVzcyB0byB0aGlzIHBhdGNoLXNldC4N
Ck9uY2UgSSBmaW5kIHRpbWUsIEkgYW0gZ29pbmcgdG8gZGVhbCB3aXRoIERBWCwgdW5sZXNzIHlv
dSBiZWF0IG1lIHRvIGl0Lg0KDQpUaGFua3MsDQpOYWRhdg==
