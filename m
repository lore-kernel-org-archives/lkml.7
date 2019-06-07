Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1C9C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A593208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KVYYv0D0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="L2c5TtKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfFGTWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:22:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52114 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730008AbfFGTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:22:09 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x57J9UUm020611;
        Fri, 7 Jun 2019 12:21:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rTaHkelg5wszskIiWMkn6zGlnpLIr1bVCraXEWLwovw=;
 b=KVYYv0D01HjdU6qxnn7g/fGMAWMzt+Ke1WBh5NGShY5fcYAdgsckNUO0PHxPtMkkjk9F
 nGKxqYMZ4j5yAuWYIYWltVzCOZSZno7AVEhoRLpbmMY55URwXa46TXOuZk8CBtDS+p7c
 yju1KarUwCe28Bck7OQt2hrwkMKE55FOqfk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sytr28sj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 07 Jun 2019 12:21:08 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 7 Jun 2019 12:21:07 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 7 Jun 2019 12:21:06 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 7 Jun 2019 12:21:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTaHkelg5wszskIiWMkn6zGlnpLIr1bVCraXEWLwovw=;
 b=L2c5TtKOkNqGkc90o8JsJXXIYO8g82H0cPHLzaA+WUUZeBCBwmLy56tk24WPaPXdXyZLhHRK42TPzYBt4JlN531skWM00Pb93Nk8OcVPU23QmJTgqnJW7Hh6UawnBUaUdUP/8cviDLip9q4mQ/JTG0qr5v4dfBT5yTOnPcATf/k=
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com (52.132.149.157) by
 MW2PR1501MB2073.namprd15.prod.outlook.com (52.132.150.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Fri, 7 Jun 2019 19:20:47 +0000
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::ede1:f275:2869:8156]) by MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::ede1:f275:2869:8156%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 19:20:46 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     =?utf-8?B?UmVuw6kgUmViZQ==?= <rene@exactcode.com>
CC:     Adam Borowski <kilobyte@angband.pl>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Kernel Team" <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Julian Andres Klode <julian.klode@canonical.com>
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Thread-Topic: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Thread-Index: AQHTwX4w5Tc/5RmZHUq3duJllyvimaSH2sIAgABGewCAPObhgIAACrOAgAARzQCAABe+AIAADJaAgBAj6oCBumpMgIADcg8A
Date:   Fri, 7 Jun 2019 19:20:46 +0000
Message-ID: <9214536E-2A20-409A-81C7-822AF9269D95@fb.com>
References: <20180322012943.4145794-1-terrelln@fb.com>
 <5B282FAD-EDCF-44C8-A131-A3C6FF3EA84F@fb.com>
 <3F598446-EA1D-47CE-B7A1-4D3002DA3972@exactcode.com>
 <8DE2BD14-0C9C-43AF-B9B7-F760F8434B6B@exactcode.com>
 <20180817165403.GC12066@tassilo.jf.intel.com>
 <20180817175746.d2brxipp7xa4y2uw@angband.pl>
 <20180817192244.GF12066@tassilo.jf.intel.com>
 <20180817200747.bzmsl5nfwewyksvg@angband.pl>
 <8117EBED-C57E-40AA-8E29-F4DFAB97E059@fb.com>
 <0ABE55AB-D29B-4E12-8E12-A9AFD6E39382@exactcode.com>
In-Reply-To: <0ABE55AB-D29B-4E12-8E12-A9AFD6E39382@exactcode.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::5a24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b13183d6-e023-4fc9-8f1e-08d6eb7d3e67
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MW2PR1501MB2073;
x-ms-traffictypediagnostic: MW2PR1501MB2073:
x-microsoft-antispam-prvs: <MW2PR1501MB2073DE66DE9094F8633C3A9BAB100@MW2PR1501MB2073.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(136003)(39860400002)(346002)(199004)(189003)(66946007)(476003)(2616005)(76176011)(6512007)(478600001)(73956011)(66476007)(186003)(66446008)(64756008)(66556008)(486006)(7736002)(25786009)(33656002)(99286004)(305945005)(46003)(6436002)(446003)(76116006)(11346002)(68736007)(229853002)(6486002)(36756003)(6916009)(6116002)(82746002)(102836004)(86362001)(81156014)(81166006)(8676002)(6246003)(14454004)(2906002)(256004)(5660300002)(4744005)(316002)(54906003)(4326008)(6506007)(53546011)(8936002)(71190400001)(71200400001)(53936002)(83716004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR1501MB2073;H:MW2PR1501MB1993.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oft62SC+sBm8C6Surv9ldrm0/DKVMRdeOTZp/ZJ3kG5QAcwl3O6+bZ+n+PA/p9ccWHxlp3TfzlNzf/PSB3L1vos3/prLC440IRGEh9tX+GkZdX8d69uQqDsf4CUbXIJ9JWjhLyIvcpG9kvs46cJd3Y7Xq5KF003PqLldYMGLfoktRPvVGg/BTTYDBY7kwQHZllRDpZzg6RJ2HU6m/eStsczTa07gXi1McUJDcWteC6+EkBiCEq6K2qhKvuHmK/EgdFC+BtQ82TjvMwbm36oLs2xN6sH7pkoyrdo/XwRrQjStiI8Y/A9wpEM62HBTf9KimqxYx0j91pIlA+3xkSAh0eXlojZxlYUO/OYGgkzhXh2aLqCipQcvcFyTg/qZXidQDaTc0wdUfkTI8EqMOaoUcQBxMX2QI4dGS6zgFGJln0U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E02D19D696EA5049B4AB81D17E84CE6E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b13183d6-e023-4fc9-8f1e-08d6eb7d3e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 19:20:46.8468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: terrelln@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2073
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=810 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906070128
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gNSwgMjAxOSwgYXQgNzo0MyBBTSwgUmVuw6kgUmViZSA8cmVuZUBleGFjdGNvZGUu
Y29tPiB3cm90ZToNCj4gDQo+IEhleSB0aGVyZSwNCj4gDQo+IGp1c3Qgd2FudGVkIHRvIGNoZWNr
IGFib3V0IHRoZSBzdGF0dXMgb2YgenN0ZC1jb21wcmVzc2VkIGtlcm5lbC4NCj4gSXQgd29ya3Mg
Z3JlYXQgZm9yIHVzLCBhbmQgdGhlIGluaXRyZCBwYXJ0IEkgdGVzdGVkIG9uIFBQQywgUFBDNjQs
IFNQQVJDNjQsDQo+IEhQUEEsIE1JUFM2NCBhbmQgcHJvYmFibHkgb3RoZXIgcmFuZG9tIHRoaW5n
cyB0aGF0IEkgbWF5IGZvcmdvdCBhYm91dCBpbiB0aGUNCj4gbWVhbnRpbWUuDQo+IA0KPiBXb3Vs
ZCBiZSBncmVhdCBpZiBzb21ldGhpbmcgbGlrZSB0aGlzIGNvdWxkIGJlIG1haW5saW5lZC4NCg0K
V2UnZCBsb3ZlIHRvIGdldCB0aGlzIG1haW5saW5lZCBhcyB3ZWxsIQ0KDQpXZSdyZSB1c2luZyB0
aGVzZSBwYXRjaGVzIGludGVybmFsbHkgYXMgd2VsbC4gV2UncmUgc2VlaW5nIGFuIGltcHJvdmVt
ZW50IG9uIGFuDQpJbnRlbCBBdG9tIE4zNzEwLCB3aGVyZSBib290IHRpbWUgaXMgcmVkdWNlZCBi
eSBvbmUgc2Vjb25kIG92ZXIgdXNpbmcgYW4geHoNCmNvbXByZXNzZWQga2VybmVsLiBJdCBsb29r
cyBsaWtlIFVidW50dSBqdXN0IHN3aXRjaGVkIHRvIGEgbHo0IGNvbXByZXNzZWQga2VybmVsLA0K
YnV0IHpzdGQgaXMgbGlrZWx5IGEgYmV0dGVyIHRyYWRlIG9mZiwgYmVjYXVzZSBpdCBjb21wcmVz
c2VzIG11Y2ggYmV0dGVyIGFuZCBzdGlsbCBoYXMNCmV4Y2VsbGVudCBkZWNvbXByZXNzaW9uIHNw
ZWVkLg0KDQpTaW5jZSBpdHMgYmVlbiBuZWFybHkgYSB5ZWFyIHNpbmNlIEkgc2VudCB0aGVzZSBv
dXQsIEkgd2lsbCB0YWtlIHNvbWUgdGltZSB0byByZWJhc2UNCmFuZCByZXRlc3QgdGhlIHBhdGNo
ZXMgaW4gY2FzZSBhbnl0aGluZyBjaGFuZ2VkLCBhbmQgdGhlbiB0aGVuIHJlc2VuZCB0aGUgcGF0
Y2hlcw0KaW4gdGhlIG5leHQgd2Vla3MuDQoNCk5pY2sNCg0KPiBbLi4uXQ==
