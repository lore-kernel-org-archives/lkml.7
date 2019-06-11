Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E17C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEBF2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SHLdozXp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="bbEv+FS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392041AbfFKSrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:47:36 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:36090 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392016AbfFKSrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:47:36 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 32B8AC2095;
        Tue, 11 Jun 2019 18:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560278855; bh=+tNfwhOx8Vilb/8rtFq2wOxYeoxb2XNP4GshqxFDdWE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SHLdozXpvJSBpUc6ylBGPREa7Oep3Fv+OiJ3mxXqtMejKfuhGqsV0zNdQbLXCflFR
         iGYwrXVLOi7/751ToYyvHgp8XsSX2mIfqAqPxkNZG+q2Of8s+drqmzdFJwqFQt2+XD
         QYn87Jt09sQNKZQg032eYd4olNxD8a5dZsbu3KlunRKAgyEKFsH6rwcfMPdtp40rQ9
         XUCWmWSqjEHFTxXuClkHU0bYckYbjWquEaTPvqnSzfGvg5sx4kq8dU4INDHrSFNpF4
         RZN0g8SwcG21OBEMYzaZB4zEkTYI3SEBDbE6I2XCALjs+cZtHkHcjVY1lSlbAOCSrR
         1AMQtqUun20xg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0BC47A0093;
        Tue, 11 Jun 2019 18:47:33 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 11 Jun 2019 11:47:33 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 11 Jun 2019 11:47:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tNfwhOx8Vilb/8rtFq2wOxYeoxb2XNP4GshqxFDdWE=;
 b=bbEv+FS8YgkSHAe/cdRrltfF6+wmzS1uGiJaKQos2xXvS31jegRjNU7CKKkjB3ye3AVEgqjdiLpMDZotqOkcKsL0CcNr/TempUcB+DPTF+4ilW518OPuWxrNYEp5/xIgyeqHHA8tMWtpJIdQaPuIESwT/EBOw4REz/CZt/hM9jE=
Received: from SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) by
 SN6PR12MB2623.namprd12.prod.outlook.com (52.135.103.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Tue, 11 Jun 2019 18:47:31 +0000
Received: from SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::cd10:94a4:d1b1:c3b2]) by SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::cd10:94a4:d1b1:c3b2%5]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 18:47:31 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Cupertino Miranda <Cupertino.Miranda@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARC Assembler: bundle_align_mode directive support
Thread-Topic: ARC Assembler: bundle_align_mode directive support
Thread-Index: AQHVHicA2N+x/AVgjkyWYOIr/ofXiqaWz+cA
Date:   Tue, 11 Jun 2019 18:47:30 +0000
Message-ID: <d79085cbc6126c2a4fad173934e1e9b29523abba.camel@synopsys.com>
References: <3962a9ad199cea45b1cfadb80be551aab83b7028.camel@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA2307501A2525686@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A2525686@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1328d5f9-8cd4-4a63-0b08-08d6ee9d4273
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2623;
x-ms-traffictypediagnostic: SN6PR12MB2623:
x-microsoft-antispam-prvs: <SN6PR12MB2623954C301887F604A1571DDEED0@SN6PR12MB2623.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:175;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(346002)(39850400004)(376002)(199004)(189003)(2616005)(118296001)(6436002)(2906002)(54906003)(110136005)(86362001)(446003)(11346002)(316002)(478600001)(14454004)(486006)(66476007)(7736002)(73956011)(64756008)(91956017)(66946007)(66446008)(6512007)(6486002)(53936002)(305945005)(66066001)(76116006)(6636002)(66556008)(5660300002)(53546011)(186003)(8676002)(8936002)(36756003)(81156014)(476003)(68736007)(229853002)(6506007)(99286004)(81166006)(85306007)(102836004)(6246003)(26005)(76176011)(71190400001)(71200400001)(6116002)(4326008)(14444005)(3846002)(25786009)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2623;H:SN6PR12MB2670.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ARsKegXeX01SZWe3SUMZgqhOBuPmM8GlZO1A/4ab5LZnpSkYd4iMd7/9W8KmmwVZkQKtX4RJ73e35Pizd92eOhG+FbLNRWEzWmv/fUwcvnpuQCd8B6+guZkk0fOEJlWaMJId4GiAF0mx4rJeFTDVKV6YOW7426RHcQUsS/9iUP4MmC4pFvqrxAGPXelAw93w/sp/VkLS4hGc8V6skjVwKYOUCugXxtgCX1Pd8K1VMmOEE6KV7+0Eus5GfiRp+ykDuTSSKOtP2BztNqXGhQ/f/ifYprOQzFZ6uiEOjKwwC4+5evDWnJapV0NMLKZGwTTPr+gLVlVH5/tZqwfQK+hurCjOhdeZkeBK0dVv4//CZVnusPWrEwmpDBfI+rJk1gYvJStjuLPC+RyL3wv7M2JedWzUZnm+Iiw+6kytqM8bRmU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <193760EC33CDB64FA62DA5FFC498255A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1328d5f9-8cd4-4a63-0b08-08d6ee9d4273
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 18:47:31.0393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paltsev@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2623
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBNb24sIDIwMTktMDYtMTAgYXQgMTU6NTUgKzAwMDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gT24gNi84LzE5IDExOjIxIEFNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6
DQo+ID4gSGkgQ3VwZXJ0aW5vLA0KPiA+IA0KPiA+IEkgdHJpZWQgdG8gdXNlICIuYnVuZGxlX2Fs
aWduX21vZGUiIGRpcmVjdGl2ZSBpbiBBUkMgYXNzZW1ibHksIGJ1dCBJIGdvdCBmb2xsb3dpbmcg
ZXJyb3I6DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tDQo+ID4gQXNzZW1i
bGVyIG1lc3NhZ2VzOg0KPiA+IEVycm9yOiB1bmtub3duIHBzZXVkby1vcDogYC5idW5kbGVfYWxp
Z25fbW9kZScNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0NCj4gPiANCj4g
PiBJcyBpdCBwb3NzaWJsZSB0byBpbXBsZW1lbnQgaXQgaW4gQVJDIGFzc2VtYmxlcj8NCj4gPiBU
aGVyZSBpcyBzb21lIGNvbnRleHQgYWJvdXQgdGhlIHJlYXNvbiB3ZSB3YW50IHRvIGhhdmUgaXQ6
DQo+ID4gDQo+ID4gSSdtIHRyeWluZyB0byBhZGQgc3VwcG9ydCBvZiBqdW1wIGxhYmVscyBmb3Ig
QVJDIGluIGxpbnV4IGtlcm5lbC4gSnVtcCBsYWJlbHMNCj4gPiBwcm92aWRlIGFuIGludGVyZmFj
ZSB0byBnZW5lcmF0ZSBzdGF0aWMgYnJhbmNoZXMgdXNpbmcgc2VsZi1tb2RpZnlpbmcgY29kZS4N
Cj4gPiBUaGlzIGFsbG93cyB1cyB0byBpbXBsZW1lbnQgY29uZGl0aW9uYWwgYnJhbmNoZXMgd2hl
cmUgY2hhbmdpbmcgYnJhbmNoDQo+ID4gZGlyZWN0aW9uIGlzIGV4cGVuc2l2ZSBidXQgYnJhbmNo
IHNlbGVjdGlvbiBpcyBiYXNpY2FsbHkgJ2ZyZWUnLg0KPiA+IA0KPiA+IFRoZXJlIGlzIG51YW5j
ZSBpbiBjdXJyZW50IGltcGxlbWVudGF0aW9uOg0KPiA+IFdlIG5lZWQgdG8gcGF0Y2ggY29kZSBi
eSByZXdyaXRpbmcgMzItYml0IE5PUCBieSAzMi1iaXQgQlJBTkNIIGluc3RydWN0aW9uIChvciB2
aWNlIHZlcnNhKS4NCj4gPiBJdCBjYW4gYmUgZWFzaWx5IGRvbmUgd2l0aCBmb2xsb3dpbmcgY29k
ZToNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0NCj4gPiB3cml0ZV8zMl9i
aXQobmV3X2luc3RydWN0aW9uKQ0KPiA+IGZsdXNoX2wxX2RjYWNoZV9yYW5nZV90aGlzX2NwdQ0K
PiA+IGludmFsaWRhdGVfbDFfaWNhY2hlX3JhbmdlX2FsbF9jcHUNCj4gPiAtLS0tLS0tLS0tLS0t
LS0tLT44LS0tLS0tLS0tLS0tLS0NCj4gPiANCj4gPiBJJCB1cGRhdGUgd2lsbCBiZSBhdG9taWMg
aW4gbW9zdCBvZiBjYXNlcyBleGNlcHQgdGhlIHBhdGNoZWQgaW5zdHJ1Y3Rpb24gc2hhcmUNCj4g
PiB0d28gTDEgY2FjaGUgbGluZXMgKHNvIGZpcnN0IDE2IGJpdHMgb2YgaW5zdHJ1Y3Rpb24gYXJl
IGluIHRoZSBvbmUgY2FjaGUgbGluZSBhbmQNCj4gPiBsYXN0IDE2IGJpdCBhcmUgaW4gYW5vdGhl
ciBjYWNoZSBsaW5lKS4NCj4gPiBJbiBzdWNoIGNhc2Ugd2UgY2FuIGV4ZWN1dGUgaGFsZi11cGRh
dGVkIGluc3RydWN0aW9uIGlmIHdlIGFyZSBwYXRjaGluZyBsaXZlIGNvZGUgKGFuZCB3ZSBhcmUg
dW5sdWNreSBlbm91Z2ggOikNCj4gDQo+IFdoaWxlIEkgdW5kZXJzdGFuZCB5b3VyIG5lZWQgZm9y
IGFsaWdubWVudCwgSSBkb24ndCBzZWUgaG93IHlvdSBjYW4gcG9zc2libHkNCj4gZXhlY3V0ZSBz
dHJheSBsaW5lcy4NCj4gZGNhY2hlIGZsdXNoIHdpbGwgYmUgcHJvcGFnYXRlZCBieSBoYXJkd2Fy
ZSAoU0NVKSB0byBhbGwgY29yZXMgKGFzIGFwcGxpY2FibGUpIGFuZA0KPiB0aGUgaWNhY2hlIGNh
Y2hlIGZsdXNoIHhjYWxsIGlzIHN5bmNocm9ub3VzIGFuZCB3aWxsIGhhdmUgdG8gZmluaXNoIG9u
IGFsbCBjb3Jlcw0KPiBiZWZvcmUgd2UgcHJvY2VlZCB0byBleGVjdXRlIHRoZSBjb2QgZWl0c2Vs
Zi4NCj4gDQoNCkl0J3MgZWFzeSBhcyBoZWxsIC0gd2UgbWF5IGV4ZWN1dGUgc29tZSBjb2RlIG9u
IG9uZSBDUFUgYW5kIHBhdGNoIGl0IG9uIGFub3RoZXIgQ1BVIGF0IHRoZSBzYW1lIG1vbWVudCA6
KQ0KDQpBbmQgaGVyZSBpcyB0aGUgZXhhbXBsZSBvZiB0aGUgc2l0dWF0aW9uIHdoZW4gd2UgY2Fu
IGdldCB0aGUgaXNzdWU6DQotIExldCdzIGltYWdpbmUgd2UgaGF2ZSBTTVAgc3lzdGVtIHdpdGgg
Q1BVIzAgYW5kIENQVSMxLg0KLSBXZSBoYXZlIGluc3RydWN0aW9uIHdoaWNoIHNoYXJlIHR3byBM
MSBjYWNoZSBsaW5lczoNCn4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSB+DQp+ICAgICAgICAgICAgfGluc3RydWN0aW9u
LVogKDMyLWJpdCBpbnN0cnVjdGlvbiB3ZSBwYXRjaCl8ICAgICAgICAgICAgfg0KfiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tIH4NCn4gICBjYWNoZS1saW5lLVggICAgICAgICAgICAgICAgICAgfCBjYWNoZS1saW5lLVkg
ICAgICAgICAgICAgICAgICAgICB+DQp+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gfg0KDQpDUFUjMCBpcyB0cnlpbmcg
dG8gc3dpdGNoIG91ciBzdGF0aWMgYnJhbmNoLCBzbyBpdCB3aWxsIHBhdGNoIHRoZSBjb2RlIChp
bnN0cnVjdGlvbi1aKQ0KQ1BVIzEgaXMgZXhlY3V0aW5nIHRoaXMgY29kZSB3aXRoIG91ciBzdGF0
aWMgYnJhbmNoLCBzbyBpdCBleGVjdXRlIHRoZSBjb2RlICh3aXRoIGluc3RydWN0aW9uLVopIHRo
YXQgd2lsbCBiZSBwYXRjaGVkLg0KDQoxKSBDUFUjMDogd2UgZ2VuZXJhdGUgbmV3IGluc3RydWN0
aW9uICh0byByZXBsYWNlICdpbnN0cnVjdGlvbi1aJykNCiAgIGFuZCB3cml0ZSBpdCB3aXRoIDMy
LWJpdCBzdG9yZSAoc3QpLiBJdCBpcyB3cml0dGVuIHRvIENQVSMwIEwxIGRhdGEgY2FjaGUuDQoy
KSBDUFUjMDogd2UgY2FsbCBvdXIgZnVuY3Rpb24gZmx1c2hfaWNhY2hlX3JhbmdlLg0KICAgSXQg
Zmlyc3RseSB3aWxsIGZsdXNoIEwxIGRhdGEgY2FjaGUgcmVnaW9uIG9uIENQVSMwLg0KICAgSW4g
b3VyIGV4YW1wbGUgaXQgd2lsbCBmbHVzaCBDUFUjMCBMMSAnY2FjaGUtbGluZS1YJyBhbmQgJ2Nh
Y2hlLWxpbmUtWScgdG8gTDIgY2FjaGUuDQozKSBDUFUjMTogd2UgYXJlIGV4ZWN1dGluZyBjb2Rl
IHdoaWNoIGlzIGluICdjYWNoZS1saW5lLVgnLg0KICAgJ2NhY2hlLWxpbmUtWScgaXMgX19OT1Rf
XyBpbiB0aGUgTDEgaW5zdHJ1Y3Rpb24gY2FjaGUgb2YgQ1BVIzEuDQogICBXZSBuZWVkIHRvIGV4
ZWN1dGUgJ2luc3RydWN0aW9uLVonLCBidXQgb25seSBoYWxmIG9mIHRoZSBpbnN0cnVjdGlvbiBp
cyBpbiBMMSBpbnN0cnVjdGlvbiBjYWNoZS4NCiAgIENQVSMxIGZldGNoICdjYWNoZS1saW5lLVkn
IHRvIEwxIGluc3RydWN0aW9uIGNhY2hlLg0KNCkgIE9vb3BzOiBub3cgd2UgaGF2ZSBjb3JydXB0
ZWQgJ2luc3RydWN0aW9uLVonIGluIEwxIGluc3RydWN0aW9uIGNhY2hlIG9mIENQVSMxOg0KICAg
Rmlyc3QgMTYgYml0IG9mIHRoaXMgaW5zdHJ1Y3Rpb24gKHdoaWNoIGJlbG9uZ3MgdG8gJ2NhY2hl
LWxpbmUtWCcpIGFyZSBvbGQgKG5vdCBwYXRjaGVkKS4NCiAgIExhc3QgMTYgYml0IG9mIHRoaXMg
aW5zdHJ1Y3Rpb24gKHdoaWNoIGJlbG9uZ3MgdG8gJ2NhY2hlLWxpbmUtWScpIGFyZSBuZXcgKHBh
dGNoZWQpLiANCg0KPiA+IEFzIG9mIHRvZGF5IEkgc2ltcGx5IGFsaWduIGJ5IDQgYnl0ZSBpbnN0
cnVjdGlvbiB3aGljaCBjYW4gYmUgcGF0Y2hlZCB3aXRoICIuYmFsaWduIDQiIGRpcmVjdGl2ZToN
Cj4gPiAtLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0NCj4gPiBzdGF0aWMgX19hbHdh
eXNfaW5saW5lIGJvb2wgYXJjaF9zdGF0aWNfYnJhbmNoX2p1bXAoc3RydWN0IHN0YXRpY19rZXkg
KmtleSwNCj4gPiAgICAgYm9vbCBicmFuY2gpDQo+ID4gew0KPiA+IGFzbV92b2xhdGlsZV9nb3Rv
KCIuYmFsaWduIDRcbiINCj4gPiAgIjE6XG4iDQo+ID4gICJiICVsW2xfeWVzXVxuIiAvLyA8LSBp
bnN0cnVjdGlvbiB3aGljaCBjYW4gYmUgcGF0Y2hlZA0KPiA+ICAiLnB1c2hzZWN0aW9uIF9fanVt
cF90YWJsZSwgXCJhd1wiXG4iDQo+ID4gICIud29yZCAxYiwgJWxbbF95ZXNdLCAlYzBcbiINCj4g
PiAgIi5wb3BzZWN0aW9uXG4iDQo+ID4gIDogOiAiaSIgKCYoKGNoYXIgKilrZXkpW2JyYW5jaF0p
IDogOiBsX3llcyk7DQo+ID4gDQo+ID4gcmV0dXJuIGZhbHNlOw0KPiA+IGxfeWVzOg0KPiA+IHJl
dHVybiB0cnVlOw0KPiA+IH0NCj4gPiAtLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0N
Cj4gPiANCj4gPiBJbiB0aGF0IGNhc2UgcGF0Y2hlZCBpbnN0cnVjdGlvbiBpcyBhbGlnbmVkIHdp
dGggb25lIDE2LWJpdCBOT1AgaWYgdGhpcyBpcyByZXF1aXJlZC4NCj4gPiBIb3dldmVyICdhbGln
biBieSA0JyBkaXJlY3RpdmUgaXMgbXVjaCBzdHJpY3RlciB0aGFuIGl0IGFjdHVhbGx5IHJlcXVp
cmVkLg0KPiANCj4gSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kLiBDYW4gdSB3cml0ZSBhIGNvdXBs
ZSBvZiBsaW5lcyBvZiBwc2V1ZG8gYXNzZW1ibHkgdG8gc2hvdw0KPiB3aGF0IHRoZSBpc3N1ZSBp
cy4NCg0KQWxsIGluc3RydWN0aW9ucyBvbiBBUkN2MiBhcmUgYWxpZ25lZCBieSAyIGJ5dGUgKGV2
ZW4gaWYgdGhlIGluc3RydWN0aW9uIGlzIDQtYnl0ZSBsb25nKS4NCg0KVXNpbmcgJy5iYWxpZ24n
IGRpcmVjdGl2ZSB3ZSBhbGlnbiBpbnN0cnVjdGlvbiB3aGljaCBjYW4gYmUNCnBhdGNoZWQgYnkg
NCBieXRlLg0KU28gY29tcGlsZXIgd2lsbCBhZGQgb25lICdub3BfcycgYmVmb3JlIG91ciBpbnN0
cnVjdGlvbiBpZiBpdCBpcyBub3QgNCBieXRlIGFsaWduZWQuDQoNClNvIHRoaXMgY29kZQ0KLS0t
LS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tDQotLS0tLQ0KIC5iYWxpZ24gNA0KIDE6
DQogYiAlbFtsX3llc10gICAjPC0gaW5zdHJ1Y3Rpb24gd2hpY2ggY2FuIGJlIHBhdGNoZWQNCi0t
LS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tDQptYXkgdHVybiBpbnRvIHRo
aXM6DQotLS0tLS0tLS0tLS0tLS0tLQ0KLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tDQpibGEtYmxh
LWJsYQ0KIGIgbF95ZXMgICAgICAgIzwtIGluc3RydWN0aW9uIHdoaWNoIGNhbiBiZSBwYXRjaGVk
DQpibGEtYmxhLWJsYQ0KLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cm9yIHRoYXQ6DQotLS0tDQotLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tDQpi
bGEtYmxhLWJsYQ0KIG5vcF9zICAgICAgICAgIyBwYWRkaW5nDQogYiBsX3llcyAgICAgICAjPC0g
aW5zdHJ1Y3Rpb24gd2hpY2ggY2FuIGJlIHBhdGNoZWQNCmJsYS1ibGEtYmxhDQotLS0tLS0tLS0t
LS0tLS0tDQotLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCkluIG1vc3Qgb2YgdGhlIGNhc2Vz
IHRoaXMgZXh0cmEgJ25vcF9zJyBpcyB1bm5lY2Vzc2FyeSBhcyBpdCBpcyBmaW5lIHRvIGhhdmUg
b3VyIGluc3RydWN0aW9uDQpub3QgNCBieXRlIGFsaWduZWQgaWYgaXQgZG9lc24ndCBjcm9zcyBs
MSBjYWNoZSBsaW5lIGJvdW5kYXJ5Lg0KDQpJdCBpcyd0IHRoZSBodWdlIHByb2JsZW0gLSBidXQg
d2UgYXJlIGFkZGluZyBvbmUgdW5uZWNlc3NhcnkgJ25vcCcgd2hpbGUgd2UgdHJ5IHRvIG9wdGlt
aXplIGhvdCBjb2RlLg0KDQo+IA0KPiA+IEl0J3MgZW5vdWdoDQo+ID4gdGhhdCBvdXIgMzItYml0
IGluc3RydWN0aW9uIGRvbid0IGNyb3NzIGwxIGNhY2hlIGxpbmUgYm91bmRhcnkuDQo+ID4gVGhh
dCB3aWxsIHNhdmUgdXMgZnJvbSBhZGRpbmcgdXNlbGVzcyBOT1AgcGFkZGluZyBpbiBtb3N0IG9m
IHRoZSBjYXNlcy4NCj4gPiBJdCBjYW4gYmUgaW1wbGVtZW50ZWQgd2l0aCAiLmJ1bmRsZV9hbGln
bl9tb2RlIiBkaXJlY3RpdmUgd2hpY2ggaXNuJ3Qgc3VwcG9ydGVkIGJ5IEFSQyBBUyB1bmZvcnR1
bmF0ZWx5Lg0KPiANCj4gVGhpcyBzZWVtcyBsaWtlIGEgcmVhc29uYWJsZSByZXF1ZXN0IChjb250
aW5nZW50IHRvIHRoZSBkaWZmaWN1bHR5IG9mDQo+IGltcGxlbWVudGF0aW9uIGluIGJpbnV0aWxz
KS4gYnV0IEkgY2FuJ3QgY29tcHJlaGVuZCB3aHkgeW91IHdvdWxkIG5lZWQgaXQuDQoNCklmIHdl
IHdpbGwgaGF2ZSAiLmJ1bmRsZV9hbGlnbl9tb2RlIiBkaXJlY3RpdmUgc3VwcG9ydGVkIHdlIGNh
biBhZGQgZXh0cmEgJ25vcF9zJyBvbmx5IGlmIGl0J3MgcmVhbGx5IHJlcXVpcmVkDQooaWYgb3Vy
IGluc3RydWN0aW9uIF9yZWFsbHlfIGNyb3NzIEwxIGNhY2hlIGxpbmUgYm91bmRhcnkpLiBTbyB3
ZSB3b24ndCBhZGQgdXNlbGVzcyBOT1AgdG8gaG90IGNvZGUuDQoNCi0tIA0KIEV1Z2VuaXkgUGFs
dHNldg0K
