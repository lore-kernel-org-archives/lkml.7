Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7625EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD6020874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="I5c96KDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437184AbfFLIxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:53:01 -0400
Received: from mail-eopbgr40091.outbound.protection.outlook.com ([40.107.4.91]:47108
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436779AbfFLIxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UfHLwB7NiF8BD1q9AQ+4p8GVMtsleNPdqN2S2nL84Y=;
 b=I5c96KDF4+ugZcCKEhvMmySBaZoNcGNZxcqTScU5yGJc6nSaXOPeYeUmA9Jm8191bardL5qc2OhRKcKlrKsEDkYstE/K37a2XV6prB2yjeW/O5TNhcj7q7xM8JBwo9ONTZbUh6R5DZPCl082cagRonDcz7+0FUb8xYlTbztmjx0=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3275.eurprd02.prod.outlook.com (52.134.66.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Wed, 12 Jun 2019 08:52:56 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf%5]) with mapi id 15.20.1987.010; Wed, 12 Jun 2019
 08:52:56 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [RESEND PATCH 1/2] dt-bindings: add register based devices' mux
 controller DT bindings
Thread-Topic: [RESEND PATCH 1/2] dt-bindings: add register based devices' mux
 controller DT bindings
Thread-Index: AQHVIPw6O6T+ZmHGOUCUYNQplQDsYQ==
Date:   Wed, 12 Jun 2019 08:52:56 +0000
Message-ID: <20190612085238.1763-2-peda@axentia.se>
References: <20190612085238.1763-1-peda@axentia.se>
In-Reply-To: <20190612085238.1763-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0102CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::30) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef4510af-c142-45c1-3e86-08d6ef135ce3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3275;
x-ms-traffictypediagnostic: DB3PR0202MB3275:
x-microsoft-antispam-prvs: <DB3PR0202MB3275CE0A1CDAE40564796C41BCEC0@DB3PR0202MB3275.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39830400003)(396003)(346002)(136003)(189003)(199004)(25786009)(508600001)(8936002)(4326008)(66476007)(74482002)(256004)(64756008)(66446008)(66556008)(66946007)(50226002)(73956011)(486006)(2906002)(11346002)(446003)(14454004)(476003)(81166006)(86362001)(110136005)(186003)(71200400001)(2501003)(3846002)(66066001)(8676002)(76176011)(53936002)(6486002)(81156014)(2616005)(26005)(6512007)(6436002)(14444005)(316002)(5660300002)(6116002)(99286004)(7736002)(36756003)(52116002)(68736007)(305945005)(1076003)(6506007)(54906003)(102836004)(71190400001)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3275;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 82rfooLbV717teWqrieaSpCtAqFC13BjpTTiNHerIPt2GDGvQddPXow2OSvQP6dknZHMXOvDQaHJiFbeGDIokYR5cXG4KhMiUo+/HgHmUu05OrrAjuudrJF8aCivZdiX3CUN5EBbUBtLNRi34rXNczure2YevhxL3g+tZ4hSFbEj9pMOhh07F5uFb/SiqPCcQRyP9ROjamBpp6Q3ECegLgesyVun+O5mvFxRF25RFGcCILL1KzlaUnxzZUWtgz+XXUCXM8L7etgoBTf2aZled4v6L25nVNPylrAWtGOjRDU0qpt/K0XDlTBbuVmJZIydEQS8HgjvRxEDbu3u7T1dzLt6mqNlEEirnC4g7snnlRlDwyCkrlJk+VQjhojvJCOh3DlMthcymi/9Qqc+xc2vSPmsMz4G+Ofuxsrzvq2pkZA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4510af-c142-45c1-3e86-08d6ef135ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 08:52:56.3456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peda@axentia.se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGFua2FqIEJhbnNhbCA8cGFua2FqLmJhbnNhbEBueHAuY29tPg0KDQpUaGlzIGFkZHMg
ZGV2aWNlIHRyZWUgYmluZGluZyBkb2N1bWVudGF0aW9uIGZvciBnZW5lcmljIHJlZ2lzdGVyIGJh
c2VkDQptdWx0aXBsZXhlciBjb250cm9sbGVkIGJ5IGEgYml0ZmllbGRzIGluIGEgcGFyZW50IGRl
dmljZSdzIHJlZ2lzdGVyIHJhbmdlLg0KDQpzaW5jZSBNTUlPIG11eCBpcyBhIHNwZWNpYWwgY2Fz
ZSBvZiBnZW5lcmljIHJlZ2lzdGVyIGJhc2VkIG11eCwgdGhlDQpNTUlPIG11eCBiaW5kaW5ncyBo
YXZlIGJlZW4gc3Vic3VtZWQgaW4gdGhlc2UgYmluZGluZ3MuDQoNClNpZ25lZC1vZmYtYnk6IFBh
bmthaiBCYW5zYWwgPHBhbmthai5iYW5zYWxAbnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IFBldGVy
IFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbXV4L21taW8tbXV4LnR4dCB8ICA2MCAtLS0tLS0tLS0tDQogRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL211eC9yZWctbXV4LnR4dCAgfCAxMjkgKysrKysrKysrKysr
KysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAxMjkgaW5zZXJ0aW9ucygrKSwgNjAgZGVsZXRp
b25zKC0pDQogZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tdXgvbW1pby1tdXgudHh0DQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tdXgvcmVnLW11eC50eHQNCg0KZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdXgvbW1pby1tdXgudHh0IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL211eC9tbWlvLW11eC50eHQNCmRlbGV0ZWQgZmlsZSBt
b2RlIDEwMDY0NA0KaW5kZXggYTliZmI0ZDhiNmFjLi4wMDAwMDAwMDAwMDANCi0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdXgvbW1pby1tdXgudHh0DQorKysgL2Rldi9u
dWxsDQpAQCAtMSw2MCArMCwwIEBADQotTU1JTyByZWdpc3RlciBiaXRmaWVsZC1iYXNlZCBtdWx0
aXBsZXhlciBjb250cm9sbGVyIGJpbmRpbmdzDQotDQotRGVmaW5lIHJlZ2lzdGVyIGJpdGZpZWxk
cyB0byBiZSB1c2VkIHRvIGNvbnRyb2wgbXVsdGlwbGV4ZXJzLiBUaGUgcGFyZW50DQotZGV2aWNl
IHRyZWUgbm9kZSBtdXN0IGJlIGEgc3lzY29uIG5vZGUgdG8gcHJvdmlkZSByZWdpc3RlciBhY2Nl
c3MuDQotDQotUmVxdWlyZWQgcHJvcGVydGllczoNCi0tIGNvbXBhdGlibGUgOiAibW1pby1tdXgi
DQotLSAjbXV4LWNvbnRyb2wtY2VsbHMgOiA8MT4NCi0tIG11eC1yZWctbWFza3MgOiBhbiBhcnJh
eSBvZiByZWdpc3RlciBvZmZzZXQgYW5kIHByZS1zaGlmdGVkIGJpdGZpZWxkIG1hc2sNCi0gICAg
ICAgICAgICAgICAgICBwYWlycywgZWFjaCBkZXNjcmliaW5nIGEgc2luZ2xlIG11eCBjb250cm9s
Lg0KLSogU3RhbmRhcmQgbXV4LWNvbnRyb2xsZXIgYmluZGluZ3MgYXMgZGVjcmliZWQgaW4gbXV4
LWNvbnRyb2xsZXIudHh0DQotDQotT3B0aW9uYWwgcHJvcGVydGllczoNCi0tIGlkbGUtc3RhdGVz
IDogaWYgcHJlc2VudCwgdGhlIHN0YXRlIHRoZSBtdXhlcyB3aWxsIGhhdmUgd2hlbiBpZGxlLiBU
aGUNCi0JCXNwZWNpYWwgc3RhdGUgTVVYX0lETEVfQVNfSVMgaXMgdGhlIGRlZmF1bHQuDQotDQot
VGhlIG11bHRpcGxleGVyIHN0YXRlIG9mIGVhY2ggbXVsdGlwbGV4ZXIgaXMgZGVmaW5lZCBhcyB0
aGUgdmFsdWUgb2YgdGhlDQotYml0ZmllbGQgZGVzY3JpYmVkIGJ5IHRoZSBjb3JyZXNwb25kaW5n
IHJlZ2lzdGVyIG9mZnNldCBhbmQgYml0ZmllbGQgbWFzayBwYWlyDQotaW4gdGhlIG11eC1yZWct
bWFza3MgYXJyYXksIGFjY2Vzc2VkIHRocm91Z2ggdGhlIHBhcmVudCBzeXNjb24uDQotDQotRXhh
bXBsZToNCi0NCi0Jc3lzY29uIHsNCi0JCWNvbXBhdGlibGUgPSAic3lzY29uIjsNCi0NCi0JCW11
eDogbXV4LWNvbnRyb2xsZXIgew0KLQkJCWNvbXBhdGlibGUgPSAibW1pby1tdXgiOw0KLQkJCSNt
dXgtY29udHJvbC1jZWxscyA9IDwxPjsNCi0NCi0JCQltdXgtcmVnLW1hc2tzID0gPDB4MyAweDMw
PiwgLyogMDogcmVnIDB4MywgYml0cyA1OjQgKi8NCi0JCQkJCTwweDMgMHg0MD4sIC8qIDE6IHJl
ZyAweDMsIGJpdCA2ICovDQotCQkJaWRsZS1zdGF0ZXMgPSA8TVVYX0lETEVfQVNfSVM+LCA8MD47
DQotCQl9Ow0KLQl9Ow0KLQ0KLQl2aWRlby1tdXggew0KLQkJY29tcGF0aWJsZSA9ICJ2aWRlby1t
dXgiOw0KLQkJbXV4LWNvbnRyb2xzID0gPCZtdXggMD47DQotDQotCQlwb3J0cyB7DQotCQkJLyog
aW5wdXRzIDAuLjMgKi8NCi0JCQlwb3J0QDAgew0KLQkJCQlyZWcgPSA8MD47DQotCQkJfTsNCi0J
CQlwb3J0QDEgew0KLQkJCQlyZWcgPSA8MT47DQotCQkJfTsNCi0JCQlwb3J0QDIgew0KLQkJCQly
ZWcgPSA8Mj47DQotCQkJfTsNCi0JCQlwb3J0QDMgew0KLQkJCQlyZWcgPSA8Mz47DQotCQkJfTsN
Ci0NCi0JCQkvKiBvdXRwdXQgKi8NCi0JCQlwb3J0QDQgew0KLQkJCQlyZWcgPSA8ND47DQotCQkJ
fTsNCi0JCX07DQotCX07DQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL211eC9yZWctbXV4LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tdXgvcmVnLW11eC50eHQNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAw
MDAuLjRhZmQ3YmE3M2Q2MA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL211eC9yZWctbXV4LnR4dA0KQEAgLTAsMCArMSwxMjkgQEANCitHZW5l
cmljIHJlZ2lzdGVyIGJpdGZpZWxkLWJhc2VkIG11bHRpcGxleGVyIGNvbnRyb2xsZXIgYmluZGlu
Z3MNCisNCitEZWZpbmUgcmVnaXN0ZXIgYml0ZmllbGRzIHRvIGJlIHVzZWQgdG8gY29udHJvbCBt
dWx0aXBsZXhlcnMuIFRoZSBwYXJlbnQNCitkZXZpY2UgdHJlZSBub2RlIG11c3QgYmUgYSBkZXZp
Y2Ugbm9kZSB0byBwcm92aWRlIHJlZ2lzdGVyIHIvdyBhY2Nlc3MuDQorDQorUmVxdWlyZWQgcHJv
cGVydGllczoNCistIGNvbXBhdGlibGUgOiBzaG91bGQgYmUgb25lIG9mDQorCSJyZWctbXV4IiA6
IGlmIHBhcmVudCBkZXZpY2Ugb2YgbXV4IGNvbnRyb2xsZXIgaXMgbm90IHN5c2NvbiBkZXZpY2UN
CisJIm1taW8tbXV4IiA6IGlmIHBhcmVudCBkZXZpY2Ugb2YgbXV4IGNvbnRyb2xsZXIgaXMgc3lz
Y29uIGRldmljZQ0KKy0gI211eC1jb250cm9sLWNlbGxzIDogPDE+DQorLSBtdXgtcmVnLW1hc2tz
IDogYW4gYXJyYXkgb2YgcmVnaXN0ZXIgb2Zmc2V0IGFuZCBwcmUtc2hpZnRlZCBiaXRmaWVsZCBt
YXNrDQorICAgICAgICAgICAgICAgICAgcGFpcnMsIGVhY2ggZGVzY3JpYmluZyBhIHNpbmdsZSBt
dXggY29udHJvbC4NCisqIFN0YW5kYXJkIG11eC1jb250cm9sbGVyIGJpbmRpbmdzIGFzIGRlY3Jp
YmVkIGluIG11eC1jb250cm9sbGVyLnR4dA0KKw0KK09wdGlvbmFsIHByb3BlcnRpZXM6DQorLSBp
ZGxlLXN0YXRlcyA6IGlmIHByZXNlbnQsIHRoZSBzdGF0ZSB0aGUgbXV4ZXMgd2lsbCBoYXZlIHdo
ZW4gaWRsZS4gVGhlDQorCQlzcGVjaWFsIHN0YXRlIE1VWF9JRExFX0FTX0lTIGlzIHRoZSBkZWZh
dWx0Lg0KKw0KK1RoZSBtdWx0aXBsZXhlciBzdGF0ZSBvZiBlYWNoIG11bHRpcGxleGVyIGlzIGRl
ZmluZWQgYXMgdGhlIHZhbHVlIG9mIHRoZQ0KK2JpdGZpZWxkIGRlc2NyaWJlZCBieSB0aGUgY29y
cmVzcG9uZGluZyByZWdpc3RlciBvZmZzZXQgYW5kIGJpdGZpZWxkIG1hc2sNCitwYWlyIGluIHRo
ZSBtdXgtcmVnLW1hc2tzIGFycmF5Lg0KKw0KK0V4YW1wbGUgMToNCitUaGUgcGFyZW50IGRldmlj
ZSBvZiBtdXggY29udHJvbGxlciBpcyBub3QgYSBzeXNjb24gZGV2aWNlLg0KKw0KKyZpMmMwIHsN
CisJZnBnYUA2NiB7IC8vIGZwZ2EgY29ubmVjdGVkIHRvIGkyYw0KKwkJY29tcGF0aWJsZSA9ICJm
c2wsbHgyMTYwYXFkcy1mcGdhIiwgImZzbCxmcGdhLXFpeGlzLWkyYyIsDQorCQkJICAgICAic2lt
cGxlLW1mZCI7DQorCQlyZWcgPSA8MHg2Nj47DQorDQorCQltdXg6IG11eC1jb250cm9sbGVyIHsN
CisJCQljb21wYXRpYmxlID0gInJlZy1tdXgiOw0KKwkJCSNtdXgtY29udHJvbC1jZWxscyA9IDwx
PjsNCisJCQltdXgtcmVnLW1hc2tzID0gPDB4NTQgMHhmOD4sIC8qIDA6IHJlZyAweDU0LCBiaXRz
IDc6MyAqLw0KKwkJCQkJPDB4NTQgMHgwNz47IC8qIDE6IHJlZyAweDU0LCBiaXRzIDI6MCAqLw0K
KwkJfTsNCisJfTsNCit9Ow0KKw0KK21kaW8tbXV4LTEgew0KKwljb21wYXRpYmxlID0gIm1kaW8t
bXV4LW11bHRpcGxleGVyIjsNCisJbXV4LWNvbnRyb2xzID0gPCZtdXggMD47DQorCW1kaW8tcGFy
ZW50LWJ1cyA9IDwmZW1kaW8xPjsNCisJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorCSNzaXplLWNl
bGxzID0gPDA+Ow0KKw0KKwltZGlvQDAgew0KKwkJcmVnID0gPDB4MD47DQorCQkjYWRkcmVzcy1j
ZWxscyA9IDwxPjsNCisJCSNzaXplLWNlbGxzID0gPDA+Ow0KKwl9Ow0KKw0KKwltZGlvQDggew0K
KwkJcmVnID0gPDB4OD47DQorCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCisJCSNzaXplLWNlbGxz
ID0gPDA+Ow0KKwl9Ow0KKw0KKwkuLg0KKwkuLg0KK307DQorDQorbWRpby1tdXgtMiB7DQorCWNv
bXBhdGlibGUgPSAibWRpby1tdXgtbXVsdGlwbGV4ZXIiOw0KKwltdXgtY29udHJvbHMgPSA8Jm11
eCAxPjsNCisJbWRpby1wYXJlbnQtYnVzID0gPCZlbWRpbzI+Ow0KKwkjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCisJI3NpemUtY2VsbHMgPSA8MD47DQorDQorCW1kaW9AMCB7DQorCQlyZWcgPSA8MHgw
PjsNCisJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KKwkJI3NpemUtY2VsbHMgPSA8MD47DQorCX07
DQorDQorCW1kaW9AMSB7DQorCQlyZWcgPSA8MHgxPjsNCisJCSNhZGRyZXNzLWNlbGxzID0gPDE+
Ow0KKwkJI3NpemUtY2VsbHMgPSA8MD47DQorCX07DQorDQorCS4uDQorCS4uDQorfTsNCisNCitF
eGFtcGxlIDI6DQorVGhlIHBhcmVudCBkZXZpY2Ugb2YgbXV4IGNvbnRyb2xsZXIgaXMgc3lzY29u
IGRldmljZS4NCisNCitzeXNjb24gew0KKwljb21wYXRpYmxlID0gInN5c2NvbiI7DQorDQorCW11
eDogbXV4LWNvbnRyb2xsZXIgew0KKwkJY29tcGF0aWJsZSA9ICJtbWlvLW11eCI7DQorCQkjbXV4
LWNvbnRyb2wtY2VsbHMgPSA8MT47DQorDQorCQltdXgtcmVnLW1hc2tzID0gPDB4MyAweDMwPiwg
LyogMDogcmVnIDB4MywgYml0cyA1OjQgKi8NCisJCQkJPDB4MyAweDQwPiwgLyogMTogcmVnIDB4
MywgYml0IDYgKi8NCisJCWlkbGUtc3RhdGVzID0gPE1VWF9JRExFX0FTX0lTPiwgPDA+Ow0KKwl9
Ow0KK307DQorDQordmlkZW8tbXV4IHsNCisJY29tcGF0aWJsZSA9ICJ2aWRlby1tdXgiOw0KKwlt
dXgtY29udHJvbHMgPSA8Jm11eCAwPjsNCisJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorCSNzaXpl
LWNlbGxzID0gPDA+Ow0KKw0KKwlwb3J0cyB7DQorCQkvKiBpbnB1dHMgMC4uMyAqLw0KKwkJcG9y
dEAwIHsNCisJCQlyZWcgPSA8MD47DQorCQl9Ow0KKwkJcG9ydEAxIHsNCisJCQlyZWcgPSA8MT47
DQorCQl9Ow0KKwkJcG9ydEAyIHsNCisJCQlyZWcgPSA8Mj47DQorCQl9Ow0KKwkJcG9ydEAzIHsN
CisJCQlyZWcgPSA8Mz47DQorCQl9Ow0KKw0KKwkJLyogb3V0cHV0ICovDQorCQlwb3J0QDQgew0K
KwkJCXJlZyA9IDw0PjsNCisJCX07DQorCX07DQorfTsNCi0tIA0KMi4xMS4wDQoNCg==
