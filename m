Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530A9C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2187120820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="H+nhAitY";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eYsb7Vrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388411AbfFJSlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:41:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34110 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387398AbfFJSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:41:53 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5AIYJWd025644;
        Mon, 10 Jun 2019 11:40:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OnyK5CxFTrAi+jwxxHVtmOGnwFAY4QMqSIpcTy3o6TM=;
 b=H+nhAitYReBje2qjMIHaxSJiM8XTm+TyFszpYPzFxOrqX6uM4H2NqIpJfc3jAuafnPcJ
 afjKwTMEOI+tA1oGEpIlna7Wwmsg+p4aGuYLxYY5k9Fkq0EfJpmKubxERNsEHRRwoPMW
 nBXDVxPwdH0PqaBR7na+fazHqDp3oYhZnOY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2t1u4qre4p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Jun 2019 11:40:53 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Jun 2019 11:40:53 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 10 Jun 2019 11:40:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnyK5CxFTrAi+jwxxHVtmOGnwFAY4QMqSIpcTy3o6TM=;
 b=eYsb7VrgOZ766NIvaixQDZMpFXJWUIMBsgK/2sJ/YaoY1utmrp4UPgYn9MxLJq+9s8msktixr7Osdbtv5bY7tuq2ygFcZW18tBwmhlQMELg2gvNx5uS5f87eW1bggGCkMlvsGH+FJpkX+1BwVFL8irFFlIvtXYsQ5+ddCqQCvJ4=
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com (52.132.149.157) by
 MW2PR1501MB2073.namprd15.prod.outlook.com (52.132.150.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Mon, 10 Jun 2019 18:40:51 +0000
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::ede1:f275:2869:8156]) by MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::ede1:f275:2869:8156%7]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 18:40:51 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Adam Borowski <kilobyte@angband.pl>
CC:     =?utf-8?B?UmVuw6kgUmViZQ==?= <rene@exactcode.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, "Chris Mason" <clm@fb.com>,
        Julian Andres Klode <julian.klode@canonical.com>
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Thread-Topic: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Thread-Index: AQHTwX4w5Tc/5RmZHUq3duJllyvimaSH2sIAgABGewCAPObhgIAACrOAgAARzQCAABe+AIAADJaAgBAj6oCBumpMgIADcg8AgAA++gCABGzfAA==
Date:   Mon, 10 Jun 2019 18:40:51 +0000
Message-ID: <B8FF2955-1503-41F6-AD4A-C1B902551194@fb.com>
References: <5B282FAD-EDCF-44C8-A131-A3C6FF3EA84F@fb.com>
 <3F598446-EA1D-47CE-B7A1-4D3002DA3972@exactcode.com>
 <8DE2BD14-0C9C-43AF-B9B7-F760F8434B6B@exactcode.com>
 <20180817165403.GC12066@tassilo.jf.intel.com>
 <20180817175746.d2brxipp7xa4y2uw@angband.pl>
 <20180817192244.GF12066@tassilo.jf.intel.com>
 <20180817200747.bzmsl5nfwewyksvg@angband.pl>
 <8117EBED-C57E-40AA-8E29-F4DFAB97E059@fb.com>
 <0ABE55AB-D29B-4E12-8E12-A9AFD6E39382@exactcode.com>
 <9214536E-2A20-409A-81C7-822AF9269D95@fb.com>
 <20190607230608.GA21020@angband.pl>
In-Reply-To: <20190607230608.GA21020@angband.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::3603]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77e2068b-d33c-44e6-7998-08d6edd329a0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MW2PR1501MB2073;
x-ms-traffictypediagnostic: MW2PR1501MB2073:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MW2PR1501MB2073A3D9D837D55862A40352AB130@MW2PR1501MB2073.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(366004)(136003)(189003)(199004)(53936002)(76176011)(6506007)(82746002)(25786009)(53546011)(86362001)(186003)(8936002)(68736007)(33656002)(71190400001)(83716004)(66556008)(81166006)(71200400001)(66476007)(81156014)(8676002)(66446008)(64756008)(99286004)(66946007)(91956017)(73956011)(102836004)(76116006)(6486002)(305945005)(4326008)(229853002)(54906003)(486006)(6116002)(2906002)(7736002)(256004)(6246003)(478600001)(6512007)(6306002)(14454004)(6436002)(966005)(316002)(11346002)(2616005)(46003)(5660300002)(446003)(6916009)(476003)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR1501MB2073;H:MW2PR1501MB1993.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W1s04QLQFGXRi/9D736f5wgsQnek/Zi4UQ3WROQf3h85fztSVnF2ckRLQo4HS0w6wZ3ri1Jw+VEtoE6chOz7Scujn2w3EQQJLAEGnSrt4B+ON8nnwl6jlcguGA1+OsueHZD+qbNpE7qsvkXkyu4osRfSSCwWwAcUrXF4WqEi2FfPDr8qDqhP4jV67J3PtUuqT01FrY+4VX3/92VLR9a1/QPEGHrF/tXCpWx3IShCaFDEsAMxjMPi1k0AGKUxZf2rNztscjXesGglN9lOEoR3OWlB95yhAAgYxO+38QyDX3xXlBRhIuEG88dTvrt/2lQ+Oj6umW+cCXOevkbRxCILofGKkSueO4lOD5kGhvsdK4IhTIuDpm95HYf7y087gPPLRmDpsXyFezXXj5KeaZzw2iS2VjIE7aGPvO//6FcxlJ0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <586C1DBB62045045BDFE375F62142B84@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e2068b-d33c-44e6-7998-08d6edd329a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 18:40:51.0289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: terrelln@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2073
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906100125
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVuIDcsIDIwMTksIGF0IDQ6MDYgUE0sIEFkYW0gQm9yb3dza2kgPGtpbG9ieXRl
QGFuZ2JhbmQucGw+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBKdW4gMDcsIDIwMTkgYXQgMDc6MjA6
NDZQTSArMDAwMCwgTmljayBUZXJyZWxsIHdyb3RlOg0KPj4gV2UnZCBsb3ZlIHRvIGdldCB0aGlz
IG1haW5saW5lZCBhcyB3ZWxsIQ0KPj4gDQo+PiBXZSdyZSB1c2luZyB0aGVzZSBwYXRjaGVzIGlu
dGVybmFsbHkgYXMgd2VsbC4gV2UncmUgc2VlaW5nIGFuIGltcHJvdmVtZW50IG9uIGFuDQo+PiBJ
bnRlbCBBdG9tIE4zNzEwLCB3aGVyZSBib290IHRpbWUgaXMgcmVkdWNlZCBieSBvbmUgc2Vjb25k
IG92ZXIgdXNpbmcgYW4geHoNCj4+IGNvbXByZXNzZWQga2VybmVsLiBJdCBsb29rcyBsaWtlIFVi
dW50dSBqdXN0IHN3aXRjaGVkIHRvIGEgbHo0IGNvbXByZXNzZWQga2VybmVsLA0KPj4gYnV0IHpz
dGQgaXMgbGlrZWx5IGEgYmV0dGVyIHRyYWRlIG9mZiwgYmVjYXVzZSBpdCBjb21wcmVzc2VzIG11
Y2ggYmV0dGVyIGFuZCBzdGlsbCBoYXMNCj4+IGV4Y2VsbGVudCBkZWNvbXByZXNzaW9uIHNwZWVk
Lg0KPj4gDQo+PiBTaW5jZSBpdHMgYmVlbiBuZWFybHkgYSB5ZWFyIHNpbmNlIEkgc2VudCB0aGVz
ZSBvdXQsIEkgd2lsbCB0YWtlIHNvbWUgdGltZSB0byByZWJhc2UNCj4+IGFuZCByZXRlc3QgdGhl
IHBhdGNoZXMgaW4gY2FzZSBhbnl0aGluZyBjaGFuZ2VkLCBhbmQgdGhlbiB0aGVuIHJlc2VuZCB0
aGUgcGF0Y2hlcw0KPj4gaW4gdGhlIG5leHQgd2Vla3MuDQo+IA0KPiBIaSENCj4gQWZ0ZXIgdGhl
IHBpbmcsIEkgaW50ZW5kZWQgdG8gcmVzZW5kIHRoZSBwYXRjaC1zZXQgKHdpdGggcmVtb3ZhbHMg
aW5jbHVkZWQpDQo+IGFmdGVyIEkgcmV0dXJuIGZyb20gbWluaURlYmNvbmYgSGFtYnVyZywgYnV0
IHlvdSAxLiBhcmUgdGhlIGF1dGhvciBvZiB0aGUNCj4gbm9uLXRyaXZpYWwgcGFydCwgMi4geW91
IGhhdmUgYSBiZXR0ZXIgdGVzdCBtYWNoaW5lcnksIGFuZCAzLiBJIGhhdmUgYQ0KPiBkZWVwbHkg
c2VhdGVkIHByZWZlcmVuY2UgZm9yIGVmZm9ydCB0byBiZSBkb25lIGJ5IHBlb3BsZSB3aG8gYXJl
IG5vdCBtZS4NCg0KSWYgaXRzIG9rYXkgd2l0aCB5b3UgSSB3aWxsIHJlc2VuZCB0aGUgcGF0Y2gg
c2V0IHdpdGggeW91ciByZW1vdmFscyBpbmNsdWRlZCBieSB0aGUgZW5kDQpvZiBuZXh0IHdlZWsg
YXQgdGhlIGxhdGVzdC4gSSdsbCBhaW0gZm9yIHRoaXMgd2Vlay4NCg0KLU5pY2sNCg0KPiBBIHJl
YmFzZWQgYW5kIHdvcmtpbmcgdmVyc2lvbiBpcyBhdCBodHRwczovL2dpdGh1Yi5jb20va2lsb2J5
dGUvbGludXgvdHJlZS9ub2J6Mi12Mw0KPiBidXQgdGhlcmUgYXJlIG5vIHJlYWwgaW1wcm92ZW1l
bnRzIGJleW9uZCByZWJhc2VzLCBhIHR5cG8gZml4LCBhbmQgUGF1bCBCdXJ0b24ncw0KPiBBQ0sg
Zm9yIG1pcHMuDQo+IA0KPiBUaGVyZSdzIGFuIHVuYWRkcmVzc2VkIGNvbW1lbnQgYnkgSW5nbyBN
b2xuYXINCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE4MTExMjA0MjIwMC5HQTk2
MDYxQGdtYWlsLmNvbS8NCj4gZm9yIHlvdXIgcGFydCBvZiB0aGUgY29kZS4NCj4gDQo+IFNvIHdo
YXQgZG8geW91IHN1Z2dlc3Q/DQo+IA0KPiANCj4gTWVvdyENCj4gLS0gDQo+IOKigOKjtOKgvuKg
u+KituKjpuKggCBMYXRpbjogICBtZW93IDQgY2hhcmFjdGVycywgNCBjb2x1bW5zLCAgNCBieXRl
cw0KPiDio77ioIHioqDioJLioIDio7/ioYEgR3JlZWs6ICAgzrzOtc6/z4UgNCBjaGFyYWN0ZXJz
LCA0IGNvbHVtbnMsICA4IGJ5dGVzDQo+IOKiv+KhhOKgmOKgt+KgmuKgiyAgUnVuZXM6ICAg4ZuX
4ZuW4Zuf4Zq5IDQgY2hhcmFjdGVycywgNCBjb2x1bW5zLCAxMiBieXRlcw0KPiDioIjioLPio4Ti
oIDioIDioIDioIAgQ2hpbmVzZTog5Za1ICAgMSBjaGFyYWN0ZXIsICAyIGNvbHVtbnMsICAzIGJ5
dGVzIDwtLSBiZXN0IQ0KDQo=
