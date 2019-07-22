Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AF8C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642FB2190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="bANGXbCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfGVSe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:34:26 -0400
Received: from mail-eopbgr680068.outbound.protection.outlook.com ([40.107.68.68]:64738
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727855AbfGVSe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:34:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4z4avDFHMFNPhyDBllFg7KZ9V/GjG2lASbofCrfAZa4NkSGPqNI6CtSHYlF+awIEe7udLQixqoY43LGiwyZ/wq9k5xJT39IlAKpVij2WP+vLqARyBG8U19BYya/Vy5WXRIb2pOB+ZmsQQdxgFv1XDsHU1NW7CZM67CVQcY0LOQsIwxjF5DFg8Mh4+BRFHzRkyBPfbrlLyIVRBa/A36EM1vUvm1BYB0O8hedxRwReHlOp8xBueYepB1l2zlCZ3Cn+FpVOY+JbDDCBnmR4GLDuGbvAUDd8vJXrixqRWbrqqZQJB8/3ASEMBvgYji7pBjPD0NpGtMr+bXIxCBuQzBMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+whafBv6dvP4kqssG21n82+bw58Xj1lDtfyufnenwc=;
 b=gPjghOXec04ZPggwousBCYf7+E5CvFu5yH5TabyUsKE7hRTrMWhvdDU+h52TK1bWT8HKykrx31Bkcxoe/zdM2L3iWfZLUTZo0MUJ/w2ttHW7ebOcshU8VXrr6ZQJoU87oO+SsAD4bZDKQkHJIP9Hjs8Ny5GtWvdJ1hSBSF2TdhoDZPjkl4/guLgDiY5pFWyYuU+L00jJnm/IU98YNc0qbY3yUje9GUu3I+SVyqx4du88p1ebVOs+aAnTpGFNjssRoWSvUbmH2sq7Yzszae7ipEgiodRAWqV5DkncUmoCGgsNYW+/HuYETlGUzHiPvAaNu2Ng0L5j+77fIKyVqCl9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+whafBv6dvP4kqssG21n82+bw58Xj1lDtfyufnenwc=;
 b=bANGXbCvypER1/DNkWS4vB98eXuoS/6q1mnareOi/k0QSrprCuOVye7t8b3UtSfqYQjQCi6TWsplfB8f7BH9TwJG/UsxpFZld+b3s6skoQ3dM5QoAzHOoKiE03PCeM9ztQ4ozIuZ3VvsXjtXOMCDPKCc9fW69OEynS7+WIClsAk=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB3943.namprd05.prod.outlook.com (52.135.195.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.10; Mon, 22 Jul 2019 18:34:23 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2115.005; Mon, 22 Jul 2019
 18:34:23 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Andy Lutomirski <luto@kernel.org>,
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
Thread-Index: AQHVPc0owCZu4w44l0OVUg4r6D6Gu6bW+RmAgAADdQA=
Date:   Mon, 22 Jul 2019 18:34:22 +0000
Message-ID: <C93C241E-E078-4825-8C59-39C84D30F9CB@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-2-namit@vmware.com>
 <20190722182159.GB6698@worktop.programming.kicks-ass.net>
In-Reply-To: <20190722182159.GB6698@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8620cf3f-50bc-4508-3e01-08d70ed337c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB3943;
x-ms-traffictypediagnostic: BYAPR05MB3943:
x-microsoft-antispam-prvs: <BYAPR05MB3943F2973349179A5881AFE1D0C40@BYAPR05MB3943.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(229853002)(6116002)(2616005)(476003)(76176011)(186003)(71190400001)(71200400001)(53546011)(81166006)(36756003)(5660300002)(11346002)(33656002)(7736002)(102836004)(4326008)(81156014)(3846002)(6506007)(6916009)(64756008)(66476007)(76116006)(66556008)(66446008)(66946007)(14454004)(26005)(86362001)(53936002)(68736007)(99286004)(66066001)(446003)(478600001)(6512007)(6246003)(2906002)(6486002)(25786009)(316002)(4744005)(8936002)(256004)(54906003)(14444005)(8676002)(305945005)(486006)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3943;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GMF21qDiLXjS/Pazm2146TUKZF/NNrzkaND/1SxgRpP9qiTixIMvAzbktxvtd3JXDi0LWri0Hn7lgJ/MJjRS+v2tn8kVDyVZ8BwDSUCMlc1j4yWaZFrV5oh275QxxcsEB31HRxgjUvAx/Xyk5ZyIg8/70ZagEpTEIPFMowKT8lYSPvhpsCCBXuSThuTdUtgsmOuQ6X+AnacIPn6A5reymlyELdcrQjQunKQKK9UGe7soOjXsTq1n/SZSKmceBOoylhekBvCkFXX+m41RUr5fDeY/nnkMhAzEz5I9CaCTM/FYHEMJsuiou4zoVazYqZO/RFzHdM317D3OdsiaHhqX9Y2duGoVgQ7f3srXcKDO+7HGID2Vi4qgKqiM2vpqkFaeoLRBWVAhklcnCy5HSRB2d4OkbW46ZzSVznBL9VsZS34=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CA8EDC67F4B37449680634FF20D1F0D@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8620cf3f-50bc-4508-3e01-08d70ed337c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 18:34:23.0066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMjIsIDIwMTksIGF0IDExOjIxIEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKdWwgMTgsIDIwMTkgYXQgMDU6NTg6
MjlQTSAtMDcwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+ICsvKg0KPj4gKyAqIENhbGwgYSBmdW5j
dGlvbiBvbiBhbGwgcHJvY2Vzc29ycy4gIE1heSBiZSB1c2VkIGR1cmluZyBlYXJseSBib290IHdo
aWxlDQo+PiArICogZWFybHlfYm9vdF9pcnFzX2Rpc2FibGVkIGlzIHNldC4NCj4+ICsgKi8NCj4+
ICtzdGF0aWMgaW5saW5lIHZvaWQgb25fZWFjaF9jcHUoc21wX2NhbGxfZnVuY190IGZ1bmMsIHZv
aWQgKmluZm8sIGludCB3YWl0KQ0KPj4gK3sNCj4+ICsJb25fZWFjaF9jcHVfbWFzayhjcHVfb25s
aW5lX21hc2ssIGZ1bmMsIGluZm8sIHdhaXQpOw0KPj4gK30NCj4gDQo+IEknbSB0aGlua2luZyB0
aGF0IG9uZSBpZiBidWdneSwgbm90aGluZyBwcm90ZWN0cyBvbmxpbmUgbWFzayBoZXJlLg0KDQpv
bl9lYWNoX2NwdV9tYXNrKCkgY2FsbHMgX19vbl9lYWNoX2NwdV9tYXNrKCkgd2hpY2ggd291bGQg
ZGlzYWJsZSBwcmVlbXB0aW9uLg0KVGhlIG1hc2sgbWlnaHQgY2hhbmdlLCBidXQgYW55aG93IF9f
c21wX2NhbGxfZnVuY3Rpb25fbWFueSgpIHdvdWxkIOKAnGFuZOKAnSBpdCwNCmFmdGVyIGRpc2Fi
bGluZyBwcmVlbXB0aW9uLCB3aXRoICh0aGUgcG90ZW50aWFsbHkgdXBkYXRlZCkgY3B1X29ubGlu
ZV9tYXNrLg0KDQpXaGF0IGlzIHlvdXIgY29uY2Vybj8=
