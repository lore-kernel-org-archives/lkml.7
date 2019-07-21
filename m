Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8498C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713A72147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ixg9hGxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfGUUVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 16:21:15 -0400
Received: from mail-eopbgr760051.outbound.protection.outlook.com ([40.107.76.51]:6176
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbfGUUVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 16:21:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7rSsheBD3pDzpdluKEraVVlCIHnwPf1Onud2DIkEe959iAeh352Z6Hm9hRHdq8hkaKGTkQ6UJe2PKt22Eo8gByiT94DA1C5gnY6LU04/Ut9RS9rCJgWBDi8GxegQsWqwMMpaJNEpcWff2qVQFrVl/i3AuBjLyRGSbnrRTHwJotGN3RH6tQG64Hk2eB/3cfWL7NNv6K1/ay90e7hC+RfAEkZTRjfcvU0mPGZIz6Gbn/k4qXuk2/KCLZTGz9bEX2M2pIhYPL5lhH9agTUQQu8EMsi0vF8gfn6MhSOca1CZLUkyZ0M+9L9WTUsUwsTSFwfVozxOhxo9h2nRRDVLF9q1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLhFYndbr0h4NU70W2Ews4SS6wtkmLNphAinE3bpyq4=;
 b=UZzFEeRFl6lHk4xBiRue+yM2RX2piPlTSvGKT2s1oEKxRizqx9/tW+RoyygYlejnpsTgtcjZi7q7RefYlmNFoVahJFmMsHNwvTKawIXcrEq3+b7Krd60hc48UxTy3mNy4eWWJGwul4Z03LCA93EkJgG4L5WxdTmAM8WohXY0hrExcWPyNnKZswd+rSW5SoiI/on9GTPfC/LJiVfLSnpi4qpWmWqKWNditBGflicwNsitjAMQtU52QvoqQ39GVFOQ74TH7OKDbEYvvS5ig22GiubI2sqFegoPgYPIsILrj89M50+LT66MPP0qbkLfCWRYTm40jIOgb5E01cdzvahLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLhFYndbr0h4NU70W2Ews4SS6wtkmLNphAinE3bpyq4=;
 b=ixg9hGxYltbatr/boj720QY8PjUX3LQ2x14iKkL2K8/PjbDOVk+XTu4X4y/uGYD0LbVzbJ9JAAoXVyNWpFbjA0MnHQZgwATnORcPDuzq7DRZW354E1AsN8DRoePVXRXnl6pisWaMr6tElNeU/xwEhz0/504t1/wql0/I5H6XjLM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5589.namprd05.prod.outlook.com (20.177.186.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.8; Sun, 21 Jul 2019 20:21:12 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2115.005; Sun, 21 Jul 2019
 20:21:12 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 5/9] x86/mm/tlb: Privatize cpu_tlbstate
Thread-Topic: [PATCH v3 5/9] x86/mm/tlb: Privatize cpu_tlbstate
Thread-Index: AQHVPc0sdRp3u9Eq6kyTg9bchPzdrKbSRpyAgANBdoA=
Date:   Sun, 21 Jul 2019 20:21:11 +0000
Message-ID: <BC2AFFA3-9972-4370-945D-6CCF43F0448E@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-6-namit@vmware.com>
 <052e9e57-8f72-d005-f0f7-4060bc665ba4@intel.com>
In-Reply-To: <052e9e57-8f72-d005-f0f7-4060bc665ba4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 928b2377-62ea-4a57-491c-08d70e18f961
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5589;
x-ms-traffictypediagnostic: BYAPR05MB5589:
x-microsoft-antispam-prvs: <BYAPR05MB558968DADBAF0F3EDFC37669D0C50@BYAPR05MB5589.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0105DAA385
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(14454004)(53546011)(54906003)(6506007)(2616005)(99286004)(2906002)(11346002)(102836004)(446003)(76176011)(186003)(8676002)(476003)(68736007)(81156014)(26005)(8936002)(33656002)(3846002)(6116002)(81166006)(316002)(71200400001)(36756003)(71190400001)(6512007)(6246003)(53936002)(229853002)(76116006)(66066001)(66446008)(66946007)(66476007)(66556008)(64756008)(5660300002)(478600001)(4326008)(256004)(486006)(6486002)(86362001)(7736002)(25786009)(6436002)(305945005)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5589;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ty/Uy7j7bJ8vBmR/V+3S5m3V1ol1ZcsOjzHAhTlEZZoDtFOmOxT5In9G7HCvSJ2L8aj9pvB/0MEr+U4LCbvJ/SGfBJI0To21jm1io7PxPXRjcLppmVWQDwmZXUOk9a0/8a6esfz8uXEMTwgBz9n8T031OyeoUoKSRHGwk3ZxLQdhEfs9aJSzOJy8LUhWvXmSCFbAV0LEMFBKlBfdr8DHiQkLaEN9OENXZCFdXsbdRszWalXnKCGLZcJuUr+Md7utFS/FKPuf4ego4CDd0TTqeGfsfBYXjdPUZhJM+tTkIWUg7N/38XxJf89VP2JaRZcmJ3MYpo53VvCPxh03ToU4P3TSjB10Y3dZFQvmNW/4gske/FKbMF3dbS1Xpa+oeojJhqZlSkWnWLGZvUzO8puwKnfIDe/pBxD/eZirh4HUh/s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36A2920237A6AC40A9F2D52546A622B8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928b2377-62ea-4a57-491c-08d70e18f961
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2019 20:21:11.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMTksIDIwMTksIGF0IDExOjM4IEFNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5A
aW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDcvMTgvMTkgNTo1OCBQTSwgTmFkYXYgQW1pdCB3
cm90ZToNCj4+ICtzdHJ1Y3QgdGxiX3N0YXRlX3NoYXJlZCB7DQo+PiArCS8qDQo+PiArCSAqIFdl
IGNhbiBiZSBpbiBvbmUgb2Ygc2V2ZXJhbCBzdGF0ZXM6DQo+PiArCSAqDQo+PiArCSAqICAtIEFj
dGl2ZWx5IHVzaW5nIGFuIG1tLiAgT3VyIENQVSdzIGJpdCB3aWxsIGJlIHNldCBpbg0KPj4gKwkg
KiAgICBtbV9jcHVtYXNrKGxvYWRlZF9tbSkgYW5kIGlzX2xhenkgPT0gZmFsc2U7DQo+PiArCSAq
DQo+PiArCSAqICAtIE5vdCB1c2luZyBhIHJlYWwgbW0uICBsb2FkZWRfbW0gPT0gJmluaXRfbW0u
ICBPdXIgQ1BVJ3MgYml0DQo+PiArCSAqICAgIHdpbGwgbm90IGJlIHNldCBpbiBtbV9jcHVtYXNr
KCZpbml0X21tKSBhbmQgaXNfbGF6eSA9PSBmYWxzZS4NCj4+ICsJICoNCj4+ICsJICogIC0gTGF6
aWx5IHVzaW5nIGEgcmVhbCBtbS4gIGxvYWRlZF9tbSAhPSAmaW5pdF9tbSwgb3VyIGJpdA0KPj4g
KwkgKiAgICBpcyBzZXQgaW4gbW1fY3B1bWFzayhsb2FkZWRfbW0pLCBidXQgaXNfbGF6eSA9PSB0
cnVlLg0KPj4gKwkgKiAgICBXZSdyZSBoZXVyaXN0aWNhbGx5IGd1ZXNzaW5nIHRoYXQgdGhlIENS
MyBsb2FkIHdlDQo+PiArCSAqICAgIHNraXBwZWQgbW9yZSB0aGFuIG1ha2VzIHVwIGZvciB0aGUg
b3ZlcmhlYWQgYWRkZWQgYnkNCj4+ICsJICogICAgbGF6eSBtb2RlLg0KPj4gKwkgKi8NCj4+ICsJ
Ym9vbCBpc19sYXp5Ow0KPj4gK307DQo+PiArREVDTEFSRV9QRVJfQ1BVX1NIQVJFRF9BTElHTkVE
KHN0cnVjdCB0bGJfc3RhdGVfc2hhcmVkLCBjcHVfdGxic3RhdGVfc2hhcmVkKTsNCj4gDQo+IENv
dWxkIHdlIGdldCBhIGNvbW1lbnQgYWJvdXQgd2hhdCAic2hhcmVkIiBtZWFucyBhbmQgd2h5IHdl
IG5lZWQgc2hhcmVkDQo+IHN0YXRlPw0KPiANCj4gU2hvdWxkIHdlIGNoYW5nZSAndGxiX3N0YXRl
JyB0byAndGxiX3N0YXRlX3ByaXZhdGXigJk/DQoNCkkgZG9u4oCZdCBmZWVsIHN0cm9uZ2x5IGFi
b3V0IGVpdGhlciBvbmUuIEkgcGVyZmVycmVkIHRoZSBvbmUgdGhhdCBpcyBsaWtlbHkNCnRvIGNh
dXNlIGZld2VyIGNoYW5nZXMgYW5kIHBvdGVudGlhbCBjb25mbGljdHMuIEFueWhvdywgSSB3b3Vs
ZCBhZGQgYSBiZXR0ZXINCmNvbW1lbnQgYXMgeW91IGFza2VkIGZvci4NCg0KU28gaXQgaXMgcmVh
bGx5IHVwIHRvIHlvdS4NCg0K
