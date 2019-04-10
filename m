Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3CCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47FF20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="mmEcHVE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfDJKeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:34:23 -0400
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:28390
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbfDJKeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThJ01jct1k9iNxpf6TgizWCfHx7DsY3NoNQvIxw8a40=;
 b=mmEcHVE3ur+cDxDPjtIvrUUVDek1cc+YhyiMHR6Y4IMGjhSTQ9G1PmniSw3ZBVBffENeU5JQXeA9NTxRURPUYiwwrHiPBdFwi6cil7vP0x126cmyCo83+0IR2YespKOjybkXAnzUxPYey28Y/DQMjELYcdWA41mqhYHQETl2sQE=
Received: from AM6PR05MB6133.eurprd05.prod.outlook.com (20.179.3.144) by
 AM6PR05MB4136.eurprd05.prod.outlook.com (52.135.160.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Wed, 10 Apr 2019 10:34:18 +0000
Received: from AM6PR05MB6133.eurprd05.prod.outlook.com
 ([fe80::b43b:8a06:4870:82cc]) by AM6PR05MB6133.eurprd05.prod.outlook.com
 ([fe80::b43b:8a06:4870:82cc%2]) with mapi id 15.20.1771.011; Wed, 10 Apr 2019
 10:34:17 +0000
From:   Petr Machata <petrm@mellanox.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
CC:     Huang Rui <huangruippp@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>, Jiri Pirko <jiri@mellanox.com>,
        "ecree@solarflare.com" <ecree@solarflare.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
        "amritha.nambiar@intel.com" <amritha.nambiar@intel.com>,
        Li Rongqing <lirongqing@baidu.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>,
        "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>,
        "bridge@lists.linux-foundation.org" 
        <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH] net:bridge:always disable auto-tuning when the user
 specified MTU
Thread-Topic: [PATCH] net:bridge:always disable auto-tuning when the user
 specified MTU
Thread-Index: AQHU70Wdg8ZylmIMz02uBxr+ZWpYCKY0rpyAgACEtgA=
Date:   Wed, 10 Apr 2019 10:34:17 +0000
Message-ID: <87y34ijgil.fsf@mellanox.com>
References: <20190410023208.25435-1-huangruiPPP@gmail.com>
 <20190409193911.2d68a64d@shemminger-XPS-13-9360>
In-Reply-To: <20190409193911.2d68a64d@shemminger-XPS-13-9360>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::17) To AM6PR05MB6133.eurprd05.prod.outlook.com
 (2603:10a6:20b:af::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=petrm@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [78.45.160.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4add7463-6901-41da-1eb9-08d6bda0158e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB4136;
x-ms-traffictypediagnostic: AM6PR05MB4136:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-microsoft-antispam-prvs: <AM6PR05MB4136650422167DA53EA7A9EDDB2E0@AM6PR05MB4136.eurprd05.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(366004)(189003)(199004)(2616005)(36756003)(476003)(256004)(5660300002)(11346002)(8676002)(6116002)(14444005)(478600001)(102836004)(316002)(106356001)(99286004)(486006)(446003)(4326008)(105586002)(229853002)(26005)(86362001)(76176011)(6506007)(305945005)(386003)(6246003)(71190400001)(52116002)(2906002)(6486002)(71200400001)(7416002)(6916009)(7736002)(68736007)(8936002)(54906003)(14454004)(25786009)(97736004)(3846002)(66066001)(81156014)(186003)(6436002)(81166006)(53936002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4136;H:AM6PR05MB6133.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ky9AvaQfnZNoTtgtBOPUNbqi3XyzsYzpdaT1dcuiQbZozwPPJjO/HhQHjkPv4/XMK8NWepH9r5hpxgWShBIB+qEl+8w/bXErVQB8Cqj0Yw/SazRWwwxcAUYQtqfpzVO92zew/EWs7O+IR7RIqCfLJFA9IM8LxCcEaQnSqwYU5WBm6ebpDfGyitiYh7B1UT10XnCl4PaRrxb28l0Km3qcGw26nsLO9bg4bJAGYT/Ne+tWBwlbXtHnEUzKzqBG4GgbO0nJpiOCP+FQ4rOr/LLDB2wVu9n5LTbAqeR23+ih8/gqWiP6cCditSmrwhONN428b6ClpDOJdC7WD/X2Ta93DJBeNKMgrpd3fnpILe39QNMZwRaZwKyoornwykuGeTx5AxnoiqT/FmufDfUMNR29SaJTrIRSljY2oKslVgHbk2g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4add7463-6901-41da-1eb9-08d6bda0158e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 10:34:17.7869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+IHdyaXRlczoN
Cg0KPiBPbiBXZWQsIDEwIEFwciAyMDE5IDAyOjMyOjA4ICswMDAwDQo+IEh1YW5nIFJ1aSA8aHVh
bmdydWlwcHBAZ21haWwuY29tPiB3cm90ZToNCj4NCj4+IEZvciBleGFtcGxlLg0KPj4gTXkgcHVy
cG9zZSBpcyB0byBjcmVhdGUgYSBicmlkZ2UgYnIwIGFuZCBqb2luIGV0aDAgaW50byBicjAuDQo+
PiBpZiB3ZSB1c2UgdGhpcyBmb2xsb3dpbmcgd2F5LCB0aGUgYXV0by10dW5pbmcgZmxhZyB3aWxs
IG5vdCBiZSBkaXNhYmxlZC4NCj4+DQo+PiBJZiBldGgwJ3MgbXR1IGlzIDEyMDANCj4+IHN0ZXAg
MS5icmN0bCBhZGRiciBicjANCj4+IHN0ZXAgMi5icmN0bCBhZGRpZiBicjAgZXRoMA0KPj4gc3Rl
cCAzLmlmY29uZmlnIGJyMCBtdHUgMTIwMA0KPj4gc3RlcCA0LmlmY29uZmlnIGV0aDAgbXR1IDE1
MDANCj4+DQo+PiBSZXN1bHQ6DQo+PiBicjAncyBNVFU6IDE1MDAsIGV0aDAncyBNVFU6IDE1MDAN
Cj4+DQo+PiBFeHBlY3RlZDoNCj4+IGJyMCdzIE1UVTogMTIwMCwgZXRoMCdzIE1UVTogMTUwMA0K
Pj4NCj4+IEkgaGF2ZSBzcGVjaWZpZWQgYnIwJ3MgTVRVLCAgYnV0IGF1dG8tbWluIHBvbGljeSB3
b3Jrcy4gU28gdGhlIE1UVSBpcw0KPj4gbm90IHRoZSByZXN1bHQgd2hhdCB3ZSBleHBlY3RlZC4N
Cj4+IEFzIGV4cGVjdGVkLCBpZiBpIGhhdmUgc3BlY2lmaWVkIGJyaWRnZSdzIE1UVSwgaXQgd2ls
bCBzZXQgdGhlIGZsYWc6DQo+PiBCUk9QVF9NVFVfU0VUX0JZX1VTRVIgaW4gbmV0X2JyaWRnZV9v
cHRzIGRpc2FibGVkIGFuZCBhdXRvLW1pbi9tYXgNCj4+IHBvbGljeSB3aWxsIG5vdCB3b3JrLkJ1
dCBpbiB0aGlzIGNhc2UsIGJlY2F1c2UgdGhlIGRldl9zZXRfbXR1IHJldHVybg0KPj4gZWFybHks
IHRoZSBCUk9QVF9NVFVfU0VUX0JZX1VTRVIgZmxhZyB3aWxsIG5vdCBiZSBkaXNhYmxlZCBhbmQN
Cj4+IGF1dG8tbWluL21heCBwb2xpY3kgd2lsbCBzdGlsbCB3b3JrLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IEh1YW5nIFJ1aSA8aHVhbmdydWlQUFBAZ21haWwuY29tPg0KPg0KPiBBIGJyaWRnZSBs
aWtlIHRoaXMgZ29pbmcgdG8gZHJvcCBmcmFtZXMuDQo+IEEgZnJhbWUgcmVjZWl2ZWQgd2l0aCBN
VFUgb2YgMTIwMCB3aWxsIGdldCBkcm9wcGVkLg0KDQpUaGF0J3MgdHJ1ZSBldmVuIGlmIGFib3Zl
IHlvdSBzZXQgYnIwJ3MgTVRVIHRvIDEyMDEsIGJ1dCB0aGVuIHRoZQ0KYXV0by10dW5pbmcgaXMg
ZGlzYWJsZWQgYXMgZXhwZWN0ZWQuIFRoZSBwcm9ibGVtIGlzIHRoYXQgc2V0dGluZyBNVFUgdG8N
CjEyMDAgaXMgcGVyY2VpdmVkIGFzIGEgbm9uLWNoYW5nZSwgd2hlcmVhcyBpdCBzaG91bGQgaW5z
dGVhZCBiZQ0KcGVyY2VpdmVkIGFzIGEgc2lnbmFsIHRoYXQgdGhlIHVzZXIgdGFrZXMgb3ZlciB0
aGUgTVRVIG1hbmFnZW1lbnQuDQoNCj4gVGhlIHByb3BlciB3YXkgdG8gZG8gdGhpcyBpcyB0byBj
aGFuZ2UgTVRVIG9mIGJvdGggaW50ZXJmYWNlcyB0byBtYXRjaC4NCg==
