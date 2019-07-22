Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC6FC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A03221955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="x7YzAiQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfGVSlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:41:47 -0400
Received: from mail-eopbgr780040.outbound.protection.outlook.com ([40.107.78.40]:8064
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728798AbfGVSlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:41:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVAvJr1EnKAX+17UAm9VD+YT3I2oagXApHh1KApg0SP+3zGsw18+zcIw8p1CJ8pz8s2X3Qj30z5roASszHWFywLBInzpqvsv29huTE8zofR7Pv7Ij9LJ1xuOmNQX82NM1G88+/H+NoJOnwqD+JWkzEHLycjAd/OIVNLS0nORg16ePFsTsul/bjLSbGa64Zf5fXacQTNcT9g2ZwL91a0z+JQ0EGfg3lZOPMA7qnMYeF+7ZrF7ZldEpYZReMYrJL3JthFdiYZo5qKOhkOmrjGp8jcR6qlovsxT2RFcTmME2osNUUHZz3NeiYYCz+US3b8wQog1IXLNCk29EGYNFaGliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sj7KjIF73yAlLLOzhuVS7LaEjG+6krH0UYGtYrzrbSo=;
 b=EBBQvLouU8clOeLN5nOhrRzsIm/w9RLhXru5Vf/5OVnmxPiw0Rm67APOoBhr+juG0Vmh+xVi0/Rr3rrg6I2pEn4MHzrIUgHWAiz3cjOR34OXi9reFsqX44a/QMPc4FiqdRSuB0oJ4BJn4e0kn0gxFzNZWqnPsw52E50/EOoiMQdLp6uMMpv9JiHmbl8W/JigQLakOOAcHyPwk0Au+vvI2SM+VDBDzb3pLG2Jv4x+Pg2zhZwMNkperrt+z20HMU+fSIOcJinu9C8kSEEOEufOLX1tPWavaP2Co1BZ5uT54dOlgjCtdBbWGHDue1s/nsOaRWgBFswnCL/25GDbVT7oOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sj7KjIF73yAlLLOzhuVS7LaEjG+6krH0UYGtYrzrbSo=;
 b=x7YzAiQfXZAdBc9//PHiPbAMLf4GTNNClrbDzpHiHp7+U+Ka2b2W11gkri2lIHuJYM8Y7t8o7xaC1Zxt8j6uZ0DwFPVg2mnibMUxQwJ1rlVerGLhfm+NdMY0pBMPQhlNTYLHyTS5mgLdyiyKy4Ae466OJgNwviLc1gCaDKA1VHE=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6598.namprd05.prod.outlook.com (20.178.234.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.7; Mon, 22 Jul 2019 18:41:44 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2115.005; Mon, 22 Jul 2019
 18:41:44 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/9] smp: Run functions concurrently in
 smp_call_function_many()
Thread-Topic: [PATCH v3 1/9] smp: Run functions concurrently in
 smp_call_function_many()
Thread-Index: AQHVPc0owCZu4w44l0OVUg4r6D6Gu6bSQmoAgAS1SACAAAbqgA==
Date:   Mon, 22 Jul 2019 18:41:44 +0000
Message-ID: <CF32049E-D6AA-4AD5-A276-0CEC84B6DB11@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-2-namit@vmware.com>
 <c02833c8-8c68-4331-03c7-d9e5eb2f285c@intel.com>
 <20190722181658.GA6698@worktop.programming.kicks-ass.net>
In-Reply-To: <20190722181658.GA6698@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d89a2349-a111-4aa2-e644-08d70ed43ee3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6598;
x-ms-traffictypediagnostic: BYAPR05MB6598:
x-microsoft-antispam-prvs: <BYAPR05MB6598E65BF541A57096A27B8BD0C40@BYAPR05MB6598.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(189003)(199004)(476003)(446003)(11346002)(2616005)(6436002)(6506007)(53546011)(76176011)(26005)(14454004)(102836004)(486006)(6486002)(81166006)(81156014)(186003)(229853002)(99286004)(53936002)(6116002)(3846002)(8936002)(5660300002)(7736002)(2906002)(66066001)(478600001)(305945005)(6916009)(86362001)(66556008)(316002)(4326008)(54906003)(66946007)(71190400001)(71200400001)(64756008)(66476007)(66446008)(14444005)(33656002)(68736007)(36756003)(25786009)(256004)(8676002)(7416002)(6512007)(76116006)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6598;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iMuS/D1DMMbkLHcn/scwZVcjn1+74N+p1flc1a7NnKn18Hi98B4KmihjWNXPVXJ5/5IKY3cb0UIiWHd39UkdlgusaowoqzhLhnRL2dqAzY3qoHIeGCj4ehWePi7hgqiymLm4hjEFxN+5aRzZUdTO6sI08+pBzuzpdpAfv4yu3RNjiYrcf5DnE4tucsObRfrnBsPhBIeJET7s79b0pNxKeRQgsihKFoXHgZUNC/BL96HGA0eh3K9j+fbzW2CXs67K6e/ebZ+s6sqC7DbRK2NQNdWx81s2QpV23NMTJehgkQTx1j/1PxOTxyzrD//wTL2CQvybpRvyjuRiAM0UxlgyN3Xn8HcQsNxVQCww2eJ9QCqP6lKclVxUnfNyEu36AtZfECI63QklsYrpsIHo+YwBwzRb++TKDpDbT3ilG9RfKhQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74D503CF2320044CA69D4C83499F27D5@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89a2349-a111-4aa2-e644-08d70ed43ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 18:41:44.5684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6598
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMjIsIDIwMTksIGF0IDExOjE2IEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBKdWwgMTksIDIwMTkgYXQgMTE6MjM6
MDZBTSAtMDcwMCwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+PiBPbiA3LzE4LzE5IDU6NTggUE0sIE5h
ZGF2IEFtaXQgd3JvdGU6DQo+Pj4gQEAgLTYyNCwxNiArNjIyLDExIEBAIEVYUE9SVF9TWU1CT0wo
b25fZWFjaF9jcHUpOw0KPj4+IHZvaWQgb25fZWFjaF9jcHVfbWFzayhjb25zdCBzdHJ1Y3QgY3B1
bWFzayAqbWFzaywgc21wX2NhbGxfZnVuY190IGZ1bmMsDQo+Pj4gCQkJdm9pZCAqaW5mbywgYm9v
bCB3YWl0KQ0KPj4+IHsNCj4+PiAtCWludCBjcHUgPSBnZXRfY3B1KCk7DQo+Pj4gKwlwcmVlbXB0
X2Rpc2FibGUoKTsNCj4+PiANCj4+PiAtCXNtcF9jYWxsX2Z1bmN0aW9uX21hbnkobWFzaywgZnVu
YywgaW5mbywgd2FpdCk7DQo+Pj4gLQlpZiAoY3B1bWFza190ZXN0X2NwdShjcHUsIG1hc2spKSB7
DQo+Pj4gLQkJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4+PiAtCQlsb2NhbF9pcnFfc2F2ZShmbGFn
cyk7DQo+Pj4gLQkJZnVuYyhpbmZvKTsNCj4+PiAtCQlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7
DQo+Pj4gLQl9DQo+Pj4gLQlwdXRfY3B1KCk7DQo+Pj4gKwlfX3NtcF9jYWxsX2Z1bmN0aW9uX21h
bnkobWFzaywgZnVuYywgZnVuYywgaW5mbywgd2FpdCk7DQo+Pj4gKw0KPj4+ICsJcHJlZW1wdF9l
bmFibGUoKTsNCj4+PiB9DQo+PiANCj4+IFRoZSBnZXRfY3B1KCkgd2FzIG1pc3NpbmcgaXQgdG9v
LCBidXQgaXQgd291bGQgYmUgbmljZSB0byBhZGQgc29tZQ0KPj4gY29tbWVudHMgYWJvdXQgd2h5
IHByZWVtcHQgbmVlZHMgdG8gYmUgb2ZmLiAgSSB3YXMgYWxzbyB0aGlua2luZyBpdA0KPj4gbWln
aHQgbWFrZSBzZW5zZSB0byBkbzoNCj4+IA0KPj4gCWNmZCA9IGdldF9jcHVfdmFyKGNmZF9kYXRh
KTsNCj4+IAlfX3NtcF9jYWxsX2Z1bmN0aW9uX21hbnkoY2ZkLCAuLi4pOw0KPj4gCXB1dF9jcHVf
dmFyKGNmZF9kYXRhKTsNCj4+IAkNCj4+IGluc3RlYWQgb2YgdGhlIGV4cGxpY2l0IHByZWVtcHRf
ZW5hYmxlL2Rpc2FibGUoKSwgYnV0IEkgZG9uJ3QgZmVlbCB0b28NCj4+IHN0cm9uZ2x5IGFib3V0
IGl0Lg0KPiANCj4gSXQgaXMgYWxzbyByZXF1aXJlZCBmb3IgY3B1IGhvdHBsdWcuDQoNCkJ1dCB0
aGVuIHNtcGNmZF9kZWFkX2NwdSgpIHdpbGwgbm90IHJlc3BlY3QgdGhlIOKAnGNwdeKAnSBhcmd1
bWVudC4gRG8geW91IHN0aWxsDQpwcmVmZXIgaXQgdGhpcyB3YXkgKGluc3RlYWQgb2YgdGhlIGN1
cnJlbnQgcHJlZW1wdF9lbmFibGUoKSAvDQpwcmVlbXB0X2Rpc2FibGUoKSk/
