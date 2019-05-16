Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C68C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393B520833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kBpl/gAF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Wbn+RyFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfEPRYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:24:15 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:37668 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726472AbfEPRYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:24:14 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 86B09C0096;
        Thu, 16 May 2019 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558027459; bh=oE8LxxHxiqBMxlmgUp5oyVAN2XI6p9oveJiPbKpLUVY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kBpl/gAFNtbM0BFmjviCD8Cx52hKiga4mFr1F/9NLJazRGP0mWd1bNA8QeyjybP5u
         pdg+gl3nl4+NN9fzPlq4h+121qxnxUn5ugowh/MOGjv8i0yToWCtwYAGb+YgJplAph
         vx/mW/0kp5RBj/2gWEoW9uRlkCtCgq/8yuzCxgHYwlFaECxGPg+skJhy8VXc9o88SC
         6mBsBu/HKDel/9E5DZYFg/ptKOvpP4+H7Y5do4s9UD0LGreXEOgG1P2yw4NCHtKoCY
         DXg6FBq8u5Ex43ZnsD8yhrAjS6FcATcfwXz1zL2esEWx0xQhStiP0tPUlZp2porx9M
         fYvZmYKXPHxRA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B3A1EA005D;
        Thu, 16 May 2019 17:24:12 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 16 May 2019 10:24:12 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 16 May 2019 10:24:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE8LxxHxiqBMxlmgUp5oyVAN2XI6p9oveJiPbKpLUVY=;
 b=Wbn+RyFMMSJZPjus0i0lm8OfXoThaXuCByh04aKkeWd2RteX8BshkPeJdTrITgx/Ca7VEksH/GeVV1w3bKcUuLbnfF42DKdn2pqdfDs7+JKfVmK2cIQW4Z1wb6xqqYGSjXJk6oemJsLBMB0qDF7NNSEbUencPRNbxxRlpgl0QJc=
Received: from MWHPR12MB1632.namprd12.prod.outlook.com (10.172.56.21) by
 MWHPR12MB1135.namprd12.prod.outlook.com (10.169.204.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 17:24:09 +0000
Received: from MWHPR12MB1632.namprd12.prod.outlook.com
 ([fe80::c5dc:3b4:6ab8:4dc6]) by MWHPR12MB1632.namprd12.prod.outlook.com
 ([fe80::c5dc:3b4:6ab8:4dc6%2]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 17:24:09 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>
CC:     "paltsev@snyopsys.com" <paltsev@snyopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH 4/9] ARC: mm: do_page_fault refactor #3: tidyup vma access
 permission code
Thread-Topic: [PATCH 4/9] ARC: mm: do_page_fault refactor #3: tidyup vma
 access permission code
Thread-Index: AQHVCrV7sukeR9XiU0qv5Rc2AMUmg6ZuAusA
Date:   Thu, 16 May 2019 17:24:09 +0000
Message-ID: <1558027448.2682.11.camel@synopsys.com>
References: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
         <1557880176-24964-5-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1557880176-24964-5-git-send-email-vgupta@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b439ab49-56bb-43f2-f19b-08d6da234ea0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR12MB1135;
x-ms-traffictypediagnostic: MWHPR12MB1135:
x-microsoft-antispam-prvs: <MWHPR12MB1135A9A438B02806185C0132DE0A0@MWHPR12MB1135.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(396003)(39860400002)(199004)(189003)(305945005)(478600001)(6436002)(5640700003)(54906003)(6512007)(37006003)(2351001)(229853002)(6486002)(102836004)(73956011)(66946007)(76116006)(64756008)(66476007)(6506007)(91956017)(85306007)(14454004)(103116003)(7736002)(66556008)(76176011)(81156014)(81166006)(66066001)(8676002)(2501003)(36756003)(66446008)(99286004)(8936002)(256004)(4326008)(6246003)(6862004)(53936002)(71200400001)(486006)(446003)(476003)(2616005)(68736007)(316002)(14444005)(86362001)(26005)(3846002)(6116002)(2906002)(11346002)(71190400001)(25786009)(6636002)(5660300002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR12MB1135;H:MWHPR12MB1632.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eqsipbborog6r33nDblFpHuVa6KpJtrF8lM7d0nDzhrRjkXFCKHTi8Zu2ZUuV/nrtGq11G7FW9LtKREbQH0swD9ClEoHJwQMP7AaoVJlgBBIeIgA9pKt1FPwCPpY/F8jNieKHor7OfcrQ9oofoPOwa6WhvsRGb3kGAbVYKSkE+jcvEJE5+/WQ50rH6Ml5fpIt6gAAYvpk7CNjGPT+qyQSaJgqzqLsOHX0r5mzzc6068KoqgI/qdV3QveEOoB/3BdzxxuOtM+m7Zg84LP0xfGr2bBg5F6F7K50lKTTUPspHWWIiGRj2kj4PAMAIM7nWFP32mEd2KphOiYH3/EL1cq6bvrIgin4maIuhAUwAFlnvqRdNAusSDoumvOq2sS0EeqlByrGGrxjUNRLSoHIso/seKhPqMYeqUUh858gmmYYgM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAF2304AECF65C45AC3503A9F316C09C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b439ab49-56bb-43f2-f19b-08d6da234ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 17:24:09.6013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1135
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTE0IGF0IDE3OjI5IC0wNzAwLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+
IFRoZSBjb2RpbmcgcGF0dGVybiB0byBOT1QgaW50aWFsaXplIHZhcmlhYmxlcyBhdCBkZWNsYXJh
dGlvbiB0aW1lIGJ1dA0KPiByYXRoZXIgbmVhciBjb2RlIHdoaWNoIG1ha2VzIHVzIGVvZiB0aGVt
IG1ha2VzIGl0IG11Y2ggZWFzaWVyIHRvIGdyb2sNCj4gdGhlIG92ZXJhbGwgbG9naWMsIHNwZWNp
YWxseSB3aGVuIHRoZSBpbml0IGlzIG5vdCBzaW1wbHkgMCBvciAxDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBWaW5lZXQgR3VwdGEgPHZndXB0YUBzeW5vcHN5cy5jb20+DQo+IC0tLQ0KPiAgYXJjaC9h
cmMvbW0vZmF1bHQuYyB8IDM5ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL21tL2ZhdWx0LmMgYi9hcmNoL2FyYy9tbS9mYXVs
dC5jDQo+IGluZGV4IGYxMTc1Njg1ZDkxNC4uYWU4OTBhOGQ1ZWJmIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL2FyYy9tbS9mYXVsdC5jDQo+ICsrKyBiL2FyY2gvYXJjL21tL2ZhdWx0LmMNCj4gQEAgLTY3
LDkgKzY3LDkgQEAgdm9pZCBkb19wYWdlX2ZhdWx0KHVuc2lnbmVkIGxvbmcgYWRkcmVzcywgc3Ry
dWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ICAJc3RydWN0IHRhc2tfc3RydWN0ICp0c2sgPSBjdXJyZW50
Ow0KPiAgCXN0cnVjdCBtbV9zdHJ1Y3QgKm1tID0gdHNrLT5tbTsNCj4gIAlpbnQgc2lfY29kZSA9
IFNFR1ZfTUFQRVJSOw0KPiArCXVuc2lnbmVkIGludCB3cml0ZSA9IDAsIGV4ZWMgPSAwLCBtYXNr
Ow0KDQpQcm9iYWJseSBpdCdzIGJldHRlciB0byB1c2UgJ2Jvb2wnIHR5cGUgZm9yICd3cml0ZScg
YW5kICdleGVjJyBhcyB3ZSByZWFsbHkgdXNlIHRoZW0gYXMgYSBib29sZWFuIHZhcmlhYmxlcy4N
Cg0KDQo+ICAJdm1fZmF1bHRfdCBmYXVsdDsNCj4gLQlpbnQgd3JpdGUgPSByZWdzLT5lY3JfY2F1
c2UgJiBFQ1JfQ19QUk9UVl9TVE9SRTsgIC8qIFNUL0VYICovDQo+IC0JdW5zaWduZWQgaW50IGZs
YWdzID0gRkFVTFRfRkxBR19BTExPV19SRVRSWSB8IEZBVUxUX0ZMQUdfS0lMTEFCTEU7DQo+ICsJ
dW5zaWduZWQgaW50IGZsYWdzOw0KPiAgDQo+ICAJLyoNCj4gIAkgKiBOT1RFISBXZSBNVVNUIE5P
VCB0YWtlIGFueSBsb2NrcyBmb3IgdGhpcyBjYXNlLiBXZSBtYXkNCj4gQEAgLTkxLDggKzkxLDE4
IEBAIHZvaWQgZG9fcGFnZV9mYXVsdCh1bnNpZ25lZCBsb25nIGFkZHJlc3MsIHN0cnVjdCBwdF9y
ZWdzICpyZWdzKQ0KPiAgCWlmIChmYXVsdGhhbmRsZXJfZGlzYWJsZWQoKSB8fCAhbW0pDQo+ICAJ
CWdvdG8gbm9fY29udGV4dDsNCj4gIA0KPiArCWlmIChyZWdzLT5lY3JfY2F1c2UgJiBFQ1JfQ19Q
Uk9UVl9TVE9SRSkJLyogU1QvRVggKi8NCj4gKwkJd3JpdGUgPSAxOw0KPiArCWVsc2UgaWYgKChy
ZWdzLT5lY3JfdmVjID09IEVDUl9WX1BST1RWKSAmJg0KPiArCSAgICAgICAgIChyZWdzLT5lY3Jf
Y2F1c2UgPT0gRUNSX0NfUFJPVFZfSU5TVF9GRVRDSCkpDQo+ICsJCWV4ZWMgPSAxOw0KPiArDQo+
ICsJZmxhZ3MgPSBGQVVMVF9GTEFHX0FMTE9XX1JFVFJZIHwgRkFVTFRfRkxBR19LSUxMQUJMRTsN
Cj4gIAlpZiAodXNlcl9tb2RlKHJlZ3MpKQ0KPiAgCQlmbGFncyB8PSBGQVVMVF9GTEFHX1VTRVI7
DQo+ICsJaWYgKHdyaXRlKQ0KPiArCQlmbGFncyB8PSBGQVVMVF9GTEFHX1dSSVRFOw0KPiArDQo+
ICByZXRyeToNCj4gIAlkb3duX3JlYWQoJm1tLT5tbWFwX3NlbSk7DQo+ICANCj4gQEAgLTEwNSwy
NCArMTE1LDE3IEBAIHZvaWQgZG9fcGFnZV9mYXVsdCh1bnNpZ25lZCBsb25nIGFkZHJlc3MsIHN0
cnVjdCBwdF9yZWdzICpyZWdzKQ0KPiAgCX0NCj4gIA0KPiAgCS8qDQo+IC0JICogT2ssIHdlIGhh
dmUgYSBnb29kIHZtX2FyZWEgZm9yIHRoaXMgbWVtb3J5IGFjY2Vzcywgc28NCj4gLQkgKiB3ZSBj
YW4gaGFuZGxlIGl0Li4NCj4gKwkgKiB2bV9hcmVhIGlzIGdvb2QsIG5vdyBjaGVjayBwZXJtaXNz
aW9ucyBmb3IgdGhpcyBtZW1vcnkgYWNjZXNzDQo+ICAJICovDQo+IC0Jc2lfY29kZSA9IFNFR1Zf
QUNDRVJSOw0KPiAtDQo+IC0JLyogSGFuZGxlIHByb3RlY3Rpb24gdmlvbGF0aW9uLCBleGVjdXRl
IG9uIGhlYXAgb3Igc3RhY2sgKi8NCj4gLQ0KPiAtCWlmICgocmVncy0+ZWNyX3ZlYyA9PSBFQ1Jf
Vl9QUk9UVikgJiYNCj4gLQkgICAgKHJlZ3MtPmVjcl9jYXVzZSA9PSBFQ1JfQ19QUk9UVl9JTlNU
X0ZFVENIKSkNCj4gKwltYXNrID0gVk1fUkVBRDsNCj4gKwlpZiAod3JpdGUpDQo+ICsJCW1hc2sg
PSBWTV9XUklURTsNCj4gKwlpZiAoZXhlYykNCj4gKwkJbWFzayA9IFZNX0VYRUM7DQo+ICsNCj4g
KwlpZiAoISh2bWEtPnZtX2ZsYWdzICYgbWFzaykpIHsNCj4gKwkJc2lfY29kZSA9IFNFR1ZfQUND
RVJSOw0KPiAgCQlnb3RvIGJhZF9hcmVhOw0KPiAtDQo+IC0JaWYgKHdyaXRlKSB7DQo+IC0JCWlm
ICghKHZtYS0+dm1fZmxhZ3MgJiBWTV9XUklURSkpDQo+IC0JCQlnb3RvIGJhZF9hcmVhOw0KPiAt
CQlmbGFncyB8PSBGQVVMVF9GTEFHX1dSSVRFOw0KPiAtCX0gZWxzZSB7DQo+IC0JCWlmICghKHZt
YS0+dm1fZmxhZ3MgJiAoVk1fUkVBRCB8IFZNX0VYRUMpKSkNCj4gLQkJCWdvdG8gYmFkX2FyZWE7
DQo+ICAJfQ0KPiAgDQo+ICAJLyoNCi0tIA0KIEV1Z2VuaXkgUGFsdHNldg==
