Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D26AC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FACD218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="KrFesCvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfDWVzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:55:32 -0400
Received: from mail-eopbgr750113.outbound.protection.outlook.com ([40.107.75.113]:38022
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbfDWVzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHgGNdaLBcLUJ9Ifka6idJUg8dmHKSWnSp/HRFayExo=;
 b=KrFesCvpReRWHXgZlshKhyjk3C6SFsr/pG7KcFfcGbLuobucVu+KPWGujGI4NB5LXAmXTToznWa3qQ2ZC+l4SEBwXO4BfQe2vN7ajVQ/OCWRD5AnOSDmM6wn3OepnsyWTWMYNt070tiVepIGmuqAK+UXLd7k3JXC6HwrxNkTjyY=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1054.namprd22.prod.outlook.com (10.174.169.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Tue, 23 Apr 2019 21:55:29 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 21:55:29 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Joel Stanley <joel@jms.id.au>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] mips: vdso: drop unnecessary cc-ldoption
Thread-Topic: [PATCH] mips: vdso: drop unnecessary cc-ldoption
Thread-Index: AQHU+hbjECdZlMB6i0mRyTkBYrCWf6ZKSlEA
Date:   Tue, 23 Apr 2019 21:55:28 +0000
Message-ID: <MWHPR2201MB12770545C4358E70F24344F6C1230@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190423205521.246828-1-ndesaulniers@google.com>
In-Reply-To: <20190423205521.246828-1-ndesaulniers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0071.namprd08.prod.outlook.com
 (2603:10b6:a03:117::48) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b940d39-514d-48a9-d0ed-08d6c83665d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR2201MB1054;
x-ms-traffictypediagnostic: MWHPR2201MB1054:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR2201MB1054028F4932A0FC0EFB79B7C1230@MWHPR2201MB1054.namprd22.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(39850400004)(136003)(199004)(189003)(14454004)(26005)(8676002)(66556008)(44832011)(66476007)(71200400001)(81156014)(68736007)(25786009)(97736004)(186003)(76176011)(8936002)(478600001)(476003)(6436002)(102836004)(229853002)(81166006)(966005)(71190400001)(4326008)(52116002)(2906002)(7696005)(6306002)(6246003)(256004)(5660300002)(6916009)(9686003)(386003)(73956011)(66946007)(99286004)(64756008)(3846002)(52536014)(6116002)(6506007)(55016002)(316002)(486006)(53936002)(42882007)(446003)(33656002)(11346002)(305945005)(54906003)(7736002)(74316002)(66066001)(66446008)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1054;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sihll9NH6PM3TRm0bBGoEwKXNFbGEQFazmbMqCSYb6gLZCjYgfHkRkpLSWzbfJ8AM7/YOuDbi/sgoyFtLmPEf+5eFiPZfa6H0n81ujEwZ7Wmj30qXQkWPwjv5rwUAcprf7dApHNFgG637cVGgGutrhNb5ozUDFkNcw2BZAHEatzefSER8c4+z2poyzrv1x8SdpwZjpFfbg9t20UXfbImHf4MmErxTzxq3aKlZ66o0wMm0z6g9riiR5yy+NT8lUPL3VqgkM4ZdFNiukmWnVDBrig812jZgh7wqx23vD2nc0+6Zb0VlYMQzs8bYbgjbKR4NF0qz+q9AdLPU0MGwjjOAXGPAcxnYdoweNCCFYvUbB/jNSTsYuI3z+WQpj/7bD2cyzJFx3Ca4XeSUg5DgrAcccIYsTbf93uwLBquV9cj+VY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b940d39-514d-48a9-d0ed-08d6c83665d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 21:55:28.8160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCk5pY2sgRGVzYXVsbmllcnMgd3JvdGU6DQo+IFRvd2FyZHMgdGhlIGdvYWwgb2Yg
cmVtb3ZpbmcgY2MtbGRvcHRpb24sIGl0IHNlZW1zIHRoYXQgLS1oYXNoLXN0eWxlPQ0KPiB3YXMg
YWRkZWQgdG8gYmludXRpbHMgMi4xNy41MC4wLjIgaW4gMjAwNi4gVGhlIG1pbmltYWwgcmVxdWly
ZWQgdmVyc2lvbg0KPiBvZiBiaW51dGlscyBmb3IgdGhlIGtlcm5lbCBhY2NvcmRpbmcgdG8NCj4g
RG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NoYW5nZXMucnN0IGlzIDIuMjAuDQo+IA0KPiAtLWJ1aWxk
LWlkIHdhcyBhZGRlZCBpbiAyLjE4IGFjY29yZGluZyB0byBiaW51dGlscy1nZGIvbGQvTkVXUy4N
Cj4gDQo+IExpbms6IGh0dHBzOi8vZ2NjLmdudS5vcmcvbWwvZ2NjLzIwMDctMDEvbXNnMDExNDEu
aHRtbA0KPiBDYzogY2xhbmctYnVpbHQtbGludXhAZ29vZ2xlZ3JvdXBzLmNvbQ0KPiBTdWdnZXN0
ZWQtYnk6IE1hc2FoaXJvIFlhbWFkYSA8eWFtYWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29t
Pg0KDQpBcHBsaWVkIHRvIG1pcHMtbmV4dC4NCg0KVGhhbmtzLA0KICAgIFBhdWwNCg0KWyBUaGlz
IG1lc3NhZ2Ugd2FzIGF1dG8tZ2VuZXJhdGVkOyBpZiB5b3UgYmVsaWV2ZSBhbnl0aGluZyBpcyBp
bmNvcnJlY3QNCiAgdGhlbiBwbGVhc2UgZW1haWwgcGF1bC5idXJ0b25AbWlwcy5jb20gdG8gcmVw
b3J0IGl0LiBdDQo=
