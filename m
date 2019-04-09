Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BA4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B255A20830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qMUtuJd1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MIXxZ9xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfDIXFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:05:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38612 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726640AbfDIXFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 19:05:06 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x39MxIQ6006233;
        Tue, 9 Apr 2019 16:04:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=QFf1j9DBOZSOq+h2Nyak4F0P+jlNDehA7OolBER2AKQ=;
 b=qMUtuJd1Np+l23OYc9UnE01YrVEXKoH8zTdpjzTze+p8fVHbvUUK1f9ZtxYxB/v/AcpG
 v2KlgVdUMgJyxmt4c4e541Aqp8w+WSwp/zWWeeJYvMzw++02dy7/wv5XsNFJ9GZdw1pv
 FdZwvCiEmdss53EhnqN3EGVaDwodJqQMdrw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2rs1620vnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 16:04:39 -0700
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 16:04:38 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Apr 2019 16:04:37 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Apr 2019 16:04:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFf1j9DBOZSOq+h2Nyak4F0P+jlNDehA7OolBER2AKQ=;
 b=MIXxZ9xziGUb6Cd8CsVyeYkgjMZA/sndzJQ4D2e7zDN0RNI169i6vXWLtvvMs9X5YClc+wCBauvU9J/BPe+RY2Lq2DsoHRxYXnIBEuDxbj+XUeFKfzP1mgsvjeFbVXZjZnUpi3pE0NDoq7XPD8ww24ecu3DrkZfWxmshHPJLoPs=
Received: from CY4PR15MB1366.namprd15.prod.outlook.com (10.172.157.148) by
 CY4PR15MB1416.namprd15.prod.outlook.com (10.172.160.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 23:04:35 +0000
Received: from CY4PR15MB1366.namprd15.prod.outlook.com
 ([fe80::cdcb:6db:7ea8:1477]) by CY4PR15MB1366.namprd15.prod.outlook.com
 ([fe80::cdcb:6db:7ea8:1477%4]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 23:04:35 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Jann Horn <jannh@google.com>
CC:     Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Roman Gushchin <guro@fb.com>, Kernel Team <Kernel-team@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 00/21] bpf: Sysctl hook
Thread-Topic: [PATCH v3 bpf-next 00/21] bpf: Sysctl hook
Thread-Index: AQHU6+bolDbIkvoyBUOpRFUnl6HwHKY0UXsAgAAn54A=
Date:   Tue, 9 Apr 2019 23:04:35 +0000
Message-ID: <20190409230432.GA59615@rdna-mbp>
References: <cover.1554485409.git.rdna@fb.com>
 <CAG48ez2D=fUX6_MDf5WD39av65FSQ1OF7v7gG5pqZLqgU9RAUw@mail.gmail.com>
In-Reply-To: <CAG48ez2D=fUX6_MDf5WD39av65FSQ1OF7v7gG5pqZLqgU9RAUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To CY4PR15MB1366.namprd15.prod.outlook.com
 (2603:10b6:903:f7::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:6328]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 778bc652-e830-4e52-55fb-08d6bd3fbbaf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR15MB1416;
x-ms-traffictypediagnostic: CY4PR15MB1416:
x-microsoft-antispam-prvs: <CY4PR15MB141673AA4A5214982640B0CAA82D0@CY4PR15MB1416.namprd15.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(346002)(366004)(39860400002)(136003)(376002)(199004)(189003)(1076003)(316002)(6512007)(106356001)(256004)(5660300002)(386003)(11346002)(14444005)(5024004)(97736004)(71200400001)(81166006)(8936002)(81156014)(8676002)(14454004)(52116002)(478600001)(86362001)(71190400001)(68736007)(7736002)(486006)(53936002)(476003)(9686003)(229853002)(25786009)(6436002)(99286004)(6246003)(7416002)(33656002)(305945005)(33716001)(6116002)(6916009)(186003)(446003)(53546011)(105586002)(4326008)(102836004)(76176011)(54906003)(6486002)(6506007)(46003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1416;H:CY4PR15MB1366.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S5AI4JOjN1Y0fI7BmCm4uZb3+zh3ENJRe7MPVfEXyKiM37RIZT/ugKABI7VaaY8VW7i9muapLioNfJWifolFUnHqOBC+jXRfASPE/V6HcNPFQ81fc8NNoq31sUMTWuykv1QWzUS5oPh+zyniMwYicRMl2/y6kJxLvd1Kaema1GQnQXlPAS+c7g1S+8GqQA5VEgrzwQt63TdeqzS6+DsAag6dLTw+92PKHBJySSO6CsrVyLH4krXTAoZseu24MGjZHDo9tuGhy++Apo/3XINUpovK4De1JDSYXZCkPfo2gWealUylhDQvU/8IQ1zT/l6+0/2cNIDQI+ceJ1ptErdcNwzMU9KtgOryY60gdiF9sBs/uWy1Gl8BZ+5BbMeqf6EX6K6RqaY04mlYf3CU17nmRDFAfw6AtBnIHS6pWBP2qnA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1C0B86DEC54CE4EA1440C4ACE1F0F74@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 778bc652-e830-4e52-55fb-08d6bd3fbbaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 23:04:35.2886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1416
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmFubiBIb3JuIDxqYW5uaEBnb29nbGUuY29tPiBbVHVlLCAyMDE5LTA0LTA5IDEzOjQyIC0wNzAw
XToNCj4gT24gVHVlLCBBcHIgOSwgMjAxOSBhdCAxMDoyNiBQTSBBbmRyZXkgSWduYXRvdiA8cmRu
YUBmYi5jb20+IHdyb3RlOg0KPiA+IFRoZSBwYXRjaCBzZXQgaW50cm9kdWNlcyBuZXcgQlBGIGhv
b2sgZm9yIHN5c2N0bC4NCj4gPg0KPiA+IEl0IGFkZHMgbmV3IHByb2dyYW0gdHlwZSBCUEZfUFJP
R19UWVBFX0NHUk9VUF9TWVNDVEwgYW5kIGF0dGFjaCB0eXBlDQo+ID4gQlBGX0NHUk9VUF9TWVND
VEwuDQo+ID4NCj4gPiBCUEZfQ0dST1VQX1NZU0NUTCBob29rIGlzIHBsYWNlZCBiZWZvcmUgY2Fs
bGluZyB0byBzeXNjdGwncyBwcm9jX2hhbmRsZXIgc28NCj4gPiB0aGF0IGFjY2Vzc2VzIChyZWFk
L3dyaXRlKSB0byBzeXNjdGwgY2FuIGJlIGNvbnRyb2xsZWQgZm9yIHNwZWNpZmljIGNncm91cA0K
PiA+IGFuZCBlaXRoZXIgYWxsb3dlZCBvciBkZW5pZWQsIG9yIHRyYWNlZC4NCj4gDQo+IERvbid0
IGxvb2sgYXQgdGhlIGNyZWRlbnRpYWxzIG9mICJjdXJyZW50IiBpbiBhIHJlYWQgb3Igd3JpdGUg
aGFuZGxlci4NCj4gQ29uc2lkZXIgd2hhdCBoYXBwZW5zIGlmLCBmb3IgZXhhbXBsZSwgc29tZW9u
ZSBpbnNpZGUgYSBjZ3JvdXAgb3BlbnMgYQ0KPiBzeXNjdGwgZmlsZSBhbmQgcGFzc2VzIHRoZSBm
aWxlIGRlc2NyaXB0b3IgdG8gYW5vdGhlciBwcm9jZXNzIG91dHNpZGUNCj4gdGhlIGNncm91cCBv
dmVyIGEgdW5peCBkb21haW4gc29ja2V0LCBhbmQgdGhhdCBvdGhlciBwcm9jZXNzIHRoZW4NCj4g
d3JpdGVzIHRvIGl0LiBFaXRoZXIgZG8geW91ciBhY2Nlc3MgY2hlY2sgb24gb3Blbiwgb3IgdXNl
IHRoZQ0KPiBjcmVkZW50aWFscyB0aGF0IHdlcmUgc2F2ZWQgZHVyaW5nIG9wZW4oKSBpbiB0aGUg
cmVhZC93cml0ZSBoYW5kbGVyLg0KDQpUaGlzIHdheSB0aGlzIHNvbWVvbmUgaW5zaWRlIGNncm91
cCBzaG91bGQgYWxyZWFkeSBoYXZlIGNvbnRyb2wgb3Zlcg0Kc29tZXRoaW5nIHJ1bm5pbmcgYXMg
cm9vdCBbMV0gb3V0c2lkZSBvZiB0aGlzIGNncm91cCwgaS5lLiB0aGUgZ2FtZSBpcw0KYWxyZWFk
eSBsb3N0LCBldmVuIHdpdGhvdXQgdGhpcyBob29rLg0KDQpbMV0gU2luY2UgcHJvY19zeXNfcmVh
ZCgpIC8gcHJvY19zeXNfd3JpdGUoKSBjaGVjayBzeXNjdGxfcGVybSgpIGJlZm9yZQ0KICAgIGV4
ZWN1dGlvbiByZWFjaGVzIHRoZSBob29rLg0KDQpUaGlzIHBhdGNoIHNldCBkb2Vzbid0IGxvb2sg
YXQgY3JlZGVudGlhbHMgYXQgYWxsIGFuZCByZWxpZXMgb24gd2hhdA0KY2hlY2tzIHdlcmUgYWxy
ZWFkeSBkb25lIGF0IHN5c19vcGVuIHRpbWUgb3IgaW4gcHJvY19zeXNfY2FsbF9oYW5kbGVyKCkN
CmJlZm9yZSBleGVjdXRpb24gcmVhY2hlcyB0aGUgaG9vay4NCg0KPiA+IFRoZSBob29rIGhhcyBh
Y2Nlc3MgdG8gc3lzY3RsIG5hbWUsIGN1cnJlbnQgc3lzY3RsIHZhbHVlIGFuZCAob24gd3JpdGUN
Cj4gPiBvbmx5KSB0byBuZXcgc3lzY3RsIHZhbHVlIHZpYSBjb3JyZXNwb25kaW5nIGhlbHBlcnMu
IE5ldyBzeXNjdGwgdmFsdWUgY2FuDQo+ID4gYmUgb3ZlcnJpZGRlbiBieSBwcm9ncmFtLiBCb3Ro
IG5hbWUgYW5kIHZhbHVlcyAoY3VycmVudC9uZXcpIGFyZQ0KPiA+IHJlcHJlc2VudGVkIGFzIHN0
cmluZ3Mgc2FtZSB3YXkgdGhleSdyZSB2aXNpYmxlIGluIC9wcm9jL3N5cy8uIEl0IGlzIHVwIHRv
DQo+ID4gcHJvZ3JhbSB0byBwYXJzZSB0aGVzZSBzdHJpbmdzLg0KPiANCj4gQnV0IGV2ZW4gaWYg
YSBmaWx0ZXIgaXMgaW5zdGFsbGVkIHRoYXQgcHJldmVudHMgYWxsIGFjY2VzcyB0byBhDQo+IHN5
c2N0bCwgeW91IGNhbiBzdGlsbCByZWFkIGl0IGJ5IGluc3RhbGxpbmcgeW91ciBvd24gZmlsdGVy
IHRoYXQsIHdoZW4NCj4gYSByZWFkIGlzIGF0dGVtcHRlZCB0aGUgbmV4dCB0aW1lLCBkdW1wcyB0
aGUgdmFsdWUgaW50byBhIG1hcCBvcg0KPiBzb21ldGhpbmcgbGlrZSB0aGF0LCByaWdodD8NCg0K
Tm8uIFRoaXMgY2FuIGJlIGNvbnRyb2xsZWQgYnkgY2dyb3VwIGhpZXJhcmNoeSBhbmQgYXBwcm9w
cmlhdGUgYXR0YWNoDQpmbGFncywgc2FtZSB3YXkgYXMgd2l0aCBhbnkgb3RoZXIgY2dyb3VwLWJw
ZiBob29rLg0KDQpFLmcuIGltYWdpbmUgdGhlcmUgaXMgYSBjZ3JvdXAgaGllcmFyY2h5Og0KICBy
b290L3NsaWNlL2NvbnRhaW5lci8NCg0KYW5kIGNvbnRhaW5lciBhcHBsaWNhdGlvbiBydW5zIGlu
IHJvb3Qvc2xpY2UvY29udGFpbmVyLyBpbiBhIGNncm91cA0KbmFtZXNwYWNlIChDTE9ORV9ORVdD
R1JPVVApIHRoYXQgbWFrZXMgdmlzaWJsZSBvbmx5ICJjb250YWluZXIvIiBwYXJ0IG9mDQp0aGUg
aGllcmFyY2h5LCBpLmUuIGZyb20gaW5zaWRlIGNvbnRhaW5lciBhcHBsaWNhdGlvbiBjYW4ndCBl
dmVuIHNlZQ0KInJvb3Qvc2xpY2UvIi4NCg0KQWRtaW5pc3RyYXRvciBjYW4gdGhlbiBhdHRhY2gg
c3lzY3RsIGhvb2sgdG8gInJvb3Qvc2xpY2UvIiB3aXRoIGF0dGFjaA0KZmxhZyBOT05FIChicGZf
YXR0ci5hdHRhY2hfZmxhZ3MgPSAwKSB3aGF0IG1lYW5zIG5vYm9keSBkb3duIHRoZQ0KaGllcmFy
Y2h5IGNhbiBvdmVycmlkZSB0aGUgcHJvZ3JhbSBhdHRhY2hlZCBieSBhZG1pbmlzdHJhdG9yLg0K
DQo+ID4gVG8gaGVscCB3aXRoIHBhcnNpbmcgdGhlIG1vc3QgY29tbW9uIGtpbmQgb2Ygc3lzY3Rs
IHZhbHVlLCB2ZWN0b3Igb2YNCj4gPiBpbnRlZ2VycywgdHdvIG5ldyBoZWxwZXJzIGFyZSBwcm92
aWRlZDogYnBmX3N0cnRvbCBhbmQgYnBmX3N0cnRvdWwgd2l0aA0KPiA+IHNlbWFudGljIHNpbWls
YXIgdG8gdXNlciBzcGFjZSBzdHJ0b2woMykgYW5kIHN0cnRvdWwoMykuDQo+ID4NCj4gPiBUaGUg
aG9vayBhbHNvIHByb3ZpZGVzIGJwZl9zeXNjdGwgY29udGV4dCB3aXRoIHR3byBmaWVsZHM6DQo+
ID4gKiBAd3JpdGUgaW5kaWNhdGVzIHdoZXRoZXIgc3lzY3RsIGlzIGJlaW5nIHJlYWQgKD0gMCkg
b3Igd3JpdHRlbiAoPSAxKTsNCj4gPiAqIEBmaWxlX3BvcyBpcyBzeXNjdGwgZmlsZSBwb3NpdGlv
biB0byByZWFkIGZyb20gb3Igd3JpdGUgdG8sIGNhbiBiZQ0KPiA+ICAgb3ZlcnJpZGRlbi4NCj4g
Pg0KPiA+IFRoZSBob29rIGFsbG93cyB0byBtYWtlIGJldHRlciBpc29sYXRpb24gZm9yIGNvbnRh
aW5lcml6ZWQgYXBwbGljYXRpb25zDQo+ID4gdGhhdCBhcmUgcnVuIGFzIHJvb3Qgc28gdGhhdCBv
bmUgY29udGFpbmVyIGNhbid0IGNoYW5nZSBhIHN5c2N0bCBhbmQgYWZmZWN0DQo+ID4gYWxsIG90
aGVyIGNvbnRhaW5lcnMgb24gYSBob3N0LCBtYWtlIGNoYW5nZXMgdG8gYWxsb3dlZCBzeXNjdGwg
aW4gYSBzYWZlcg0KPiA+IHdheSBhbmQgc2ltcGxpZnkgc3lzY3RsIHRyYWNpbmcgZm9yIGNncm91
cHMuDQo+IA0KPiBXaHkgY2FuJ3QgeW91IHVzZSBhIHVzZXIgbmFtZXNwYWNlIGFuZCBpc29sYXRl
IHRoaW5ncyBwcm9wZXJseSB0aGF0DQo+IHdheT8gVGhhdCB3b3VsZCBiZSBtdWNoIGNsZWFuZXIs
IHdvdWxkbid0IGl0Pw0KDQpJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIGhvdyB1c2VyIG5hbWVz
cGFjZSBoZWxwcyBoZXJlLiBGcm9tIG15DQp1bmRlcnN0YW5kaW5nIGl0IGNhbiBvbmx5IGNvbXBs
ZXRlbHkgZGVueSBhY2Nlc3MgdG8gc3lzY3RsIGFuZCBjYW4ndCBkbw0KZmluZS1ncmFpbmVkIGNv
bnRyb2wgZm9yIHNwZWNpZmljIHN5c2N0bCBrbm9icy4gSXQgYWxzbyBjYW4ndCBtYWtlDQphbGxv
dy9kZW55IGRlY2lzaW9uIGJhc2VkIG9uIHN5c2N0bCB2YWx1ZSBiZWluZyB3cml0dGVuLg0KDQpC
YXNpY2FsbHkgdXNlciBuYW1lc3BhY2UgaXMgYWxsIG9yIG5vdGhpbmcuIFRoaXMgc3lzY3RsIGhv
b2sgcHJvdmlkZXMgYQ0Kd2F5IHRvIGltcGxlbWVudCBmaW5lLWdyYWluZWQgYWNjZXNzIGNvbnRy
b2wgZm9yIHN5c2N0bCBrbm9icyBiYXNlZCBvbg0Kc3lzY3RsIG5hbWUgb3IgdmFsdWUgYmVpbmcg
d3JpdHRlbiBvciB3aGF0ZXZlciBlbHNlIHBvbGljeSBhZG1pbmlzdHJhdG9yDQpjYW4gY29tZSB1
cCB3aXRoLg0KDQotLSANCkFuZHJleSBJZ25hdG92DQo=
