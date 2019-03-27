Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F78C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97792075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="V2ig6UtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfC0NnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:43:11 -0400
Received: from mail-eopbgr100092.outbound.protection.outlook.com ([40.107.10.92]:43226
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728324AbfC0NnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r59OY5aULlJzATGxaBra4CRIOGt01uor7NXJpYTYl8k=;
 b=V2ig6UtRBV4OzzwrdYrn73XQeKwzWYATMhU0bM+6OetvekvgBBnfps8mmruQ6bfkGC1+HrcKjcdDIU5oJmZBbLRP6lpY31yEkKUN86niAVQx/7xAFK8TWSBHNTotixtfA6mmHShUsC21jZgaw99K9r15/Mlgbhml4UcS/fraGSc=
Received: from LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM (20.176.139.20) by
 LO2P265MB1295.GBRP265.PROD.OUTLOOK.COM (20.176.144.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 13:42:28 +0000
Received: from LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ed34:1290:4306:3157]) by LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ed34:1290:4306:3157%3]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 13:42:28 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Anup Patel <anup@brainfault.org>
CC:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Implement ASID allocator
Thread-Topic: [PATCH] RISC-V: Implement ASID allocator
Thread-Index: AQHU5IQth95RRmVyw0y1O3lxWJG/36YfVxgAgAAEHICAACGYgA==
Date:   Wed, 27 Mar 2019 13:42:28 +0000
Message-ID: <74227a1d-3928-3e92-c7a9-5c3e093b29ab@garyguo.net>
References: <20190327100201.32220-1-anup.patel@wdc.com>
 <7edf91f1-1df5-5513-d372-d84edd12edf3@garyguo.net>
 <CAAhSdy1+rc9ge02uqNvse5Z6XmDxsRH0G=5GnMsh+6m1LMLFYg@mail.gmail.com>
In-Reply-To: <CAAhSdy1+rc9ge02uqNvse5Z6XmDxsRH0G=5GnMsh+6m1LMLFYg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::28) To LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8c::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:630:212:238:3697:f6ff:fe55:55b1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bae4e099-0b80-49ec-8e6f-08d6b2ba0db6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:LO2P265MB1295;
x-ms-traffictypediagnostic: LO2P265MB1295:
x-ms-exchange-purlcount: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gary@garyguo.net; 
x-microsoft-antispam-prvs: <LO2P265MB1295F9B15ABA94E4997DCE4CD6580@LO2P265MB1295.GBRP265.PROD.OUTLOOK.COM>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39830400003)(396003)(136003)(199004)(189003)(97736004)(4326008)(316002)(71190400001)(54906003)(2906002)(14454004)(5660300002)(25786009)(7736002)(966005)(86362001)(6916009)(8936002)(508600001)(71200400001)(256004)(7416002)(68736007)(31696002)(31686004)(186003)(446003)(6436002)(52116002)(6512007)(6306002)(486006)(2616005)(105586002)(6506007)(53546011)(229853002)(53936002)(386003)(476003)(99286004)(6116002)(6486002)(46003)(76176011)(305945005)(8676002)(36756003)(11346002)(102836004)(106356001)(6246003)(81156014)(81166006)(340984004);DIR:OUT;SFP:1102;SCL:1;SRVR:LO2P265MB1295;H:LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: garyguo.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gRkqUT0ojW2+YIiyvG6RnQ6c3o/lfOABCyb44F0ii5Iix6SwYRPbr1B+oQ5ArF4pFodmWpKmmTPa8KQf7GLr+qgv8oGJ1lHkRHt9GbgZpmjLfo8pnyOJ5qJZxpVz8h2pXwu9a5qrC9i0z5tYLMR+6hnbpOlJiM1IoOhHOETgDQx0nloj5p7r2uLepMev9f8zj886zuvBvKL9bqyvrKVglZ5uJwDUHvXEWGWNtVo1F0sz9+2DIyFEz25ptoHMwngIiH4yCmCMBL7JxBcWt/wxJRD42wYAF1r43z6r4oo8AcPS0zt42LdpngIToQLC2rFDlHqQ7jbYZOsohqPHMUMQpQZWqZcm0NpdxVESgFBW2935agciuoU/5sNwdSau7/BznUt8CYzmSH3WcKLPv/2ss3XDJFOsFRn55byGPmDNI8A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F56D11CEF9C0CE4A89C240E6728249E1@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bae4e099-0b80-49ec-8e6f-08d6b2ba0db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 13:42:28.4833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB1295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSB3b3VsZCBhbHNvIGxpa2UgdG8gbWVudGlvbiB0aGF0IHlvdXIgY29kZSBhc3N1bWVzIDY0LWJp
dCBhdG9taWNzIA0Kc3VwcG9ydCB3aGljaCB3ZSBkb24ndCBoYXZlIG9uIDMyLWJpdCBzeXN0ZW1z
LiBVc2luZyAzMi1iaXQgdG8gdHJhY2sgDQpBU0lEIGdlbmVyYXRpb25zIGlzbid0IHN1ZmZpY2ll
bnQgYW5kIHdpbGwgY2F1c2Ugb3ZlcmZsb3dzLiBUaGF0J3Mgd2h5IEkgDQpoYXZlIGFzaWRfZ2Vu
ZXJhdGlvbl9vdmVyZmxvdyB0byBoYW5kbGUgdGhlIGNhc2UgKHRoaXMgaXMgc3VwZXIgDQplcnJv
ci1wcm9uZSBhcyB3ZWxsKS4NCg0KQmVzdCwNCkdhcnkNCg0KT24gMjcvMDMvMjAxOSAxMTo0Miwg
QW51cCBQYXRlbCB3cm90ZToNCj4gT24gV2VkLCBNYXIgMjcsIDIwMTkgYXQgNDo1NyBQTSBHYXJ5
IEd1byA8Z2FyeUBnYXJ5Z3VvLm5ldD4gd3JvdGU6DQo+Pg0KPj4gSGkgQW51cCwNCj4+DQo+PiBU
aGlzIHdvbid0IHdvcmsgaW4gYW4gYWN0dWFsIGhhcmR3YXJlIHdpdGggQVNJRCBzdXBwb3J0LiBU
aGVyZSdyZSBtb3JlDQo+IA0KPiBDYW4geW91IGVsYWJvcmF0ZSB3aHk/DQo+IA0KPiBUaGlzIGlt
cGxlbWVudGF0aW9uIGlzIGJhc2VkIG9uIExpbnV4IEFSTTY0IEFTSUQgYWxsb2NhdG9yIHdoaWNo
IGlzDQo+IHRlc3RlZCBmb3IgbGFyZ2UgbnVtYmVyIG9mIENQVXMgb24gcmVhbCBIVy4NCj4gDQo+
PiBpbnRlcmFjdGlvbnMgd2l0aCBUTEIgZmx1c2hlcyB0aGF0IG5lZWQgdG8gYmUgY29uc2lkZXJl
ZC4gWW91IHdvbid0IHNlZQ0KPiANCj4gWWFwLCBhbHJlYWR5IGNvbnNpZGVyZWQuIFBsZWFzZSBw
b2ludCBtZSB0byB1bmhhbmRsZWQgY2FzZS4NCj4gDQo+PiB0aGlzIG9uIGJvdGggUUVNVSBhbmQg
U2lGaXZlIGJvYXJkLCBhcyBRRU1VIGRvZXMgbm90IGhhdmUgQVNJRCwgc28gaXQNCj4+IHByZXRl
bmRzIHRoYXQgQVNJRCBpcyBzdXBwb3J0ZWQgYnkganVzdCBmbHVzaGluZyBpdHMgVExCIGV2ZXJ5
dGltZSB5b3UNCj4gDQo+IE5vcGUsIGl0IGRvZXMgbm90LiBJdCBkZXRlY3RzIHdoZXRoZXIgQVNJ
RCBpcyBzdXBwb3J0ZWQgb3Igbm90LiBJZiBzdXBwb3J0ZWQNCj4gaXQgd2lsbCBhbHNvIGZpZ3Vy
ZS1vdXQgbnVtYmVyIG9mIEFTSUQgYml0cyBzdXBwb3J0ZWQgYnkgSFcuDQo+IA0KPiBTaUZpdmUg
Ym9hcmQgZG9lcyBub3QgaGF2ZSBBU0lEIGJpdHMgc28gdGhpcyBpbXBsZW1lbnRhdGlvbiBzdWNj
ZXNzZnVsbHkNCj4gZGV0ZWN0cyB0aGF0IG51bWJlciBvZiBBU0lEIGJpdHMgYXJlIDAgYW5kIGZh
bGxiYWNrcyB0byBvcmlnaW5hbCB3YXkgb2YNCj4gbG9jYWwgVExCIGZsdXNoZXMuDQo+IA0KPj4g
Y2hhbmdlIHNwdGJyLiBJIHN1c3BlY3QgdGhlIHBlcmZvcm1hbmNlIGdhaW4geW91IHNlZSBpcyBq
dXN0IGR1ZSB0bw0KPj4gc2F2ZWQgVExCIGZsdXNoIGFzIFRMQiBmbHVzaCBpcyBzdXBlciBleHBl
bnNpdmUgaW4gUUVNVSAoYWxsIHRyYW5zbGF0aW9uDQo+PiBibG9jayBqdW1wcyBuZWVkIHRvIGJl
IGNsZWFyZWQpLg0KPiANCj4gWWVzLCBwZXJmb3JtYW5jZSBnYWluIGlzIGR1ZSB0byBzYXZlZCBU
TEIgZmx1c2hlcy4NCj4gDQo+IE9uIEhXIHdoaWNoIHN1cHBvcnRzIEFTSUQgYml0cywgd2Ugd2ls
bCBzZWUgbW9yZSBwZXJmb3JtYW5jZQ0KPiBpbXByb3ZlbWVudHMuDQo+IA0KPj4NCj4+IEkgaGF2
ZSBteSB2ZXJzaW9uIGhlcmUgaHR0cHM6Ly9naXRodWIuY29tL25iZGQwMTIxL2xpbnV4L3RyZWUv
YXNpZC4gSQ0KPj4gaGF2ZW4ndCBkb25lIGNvZGUgY2xlYW51cHMgeWV0LCBidXQgdGhpcyB2ZXJz
aW9uIGhhcyBjb3JyZWN0bmVzcyBvZiBpdHMNCj4+IEFTSUQgY29kZSB0ZXN0ZWQgb24gb3VyIFRM
QiBzaW11bGF0b3IgdG9vbCAod2hpY2ggdW5mb3J0dW5hdGVseSBJIGNhbid0DQo+PiBzaGFyZSBy
aWdodCBub3cgYXMgaXQgaW52b2x2ZXMgd2l0aCB1bnB1Ymxpc2hlZCB3b3JrcykuDQo+IA0KPiBF
eGNlcHQgZmV3IG1pbm9yIGRpZmZlcmVuY2VzLiBZb3UgdmVyc2lvbiBvZiBBU0lEIGFsbG9jYXRv
ciBpcyBzYW1lIGFzDQo+IG1pbmUuIEluIGZhY3QgdGhlcmUgYXJlIGxvdCBvZiBzaW1pbGFyIGNv
ZGUgZnJhbWdlbWVudHMgaW4geW91ciB2ZXJzaW9uDQo+IGNvbXBhcmVkIHRvIExpbnV4IEFSTTY0
IGFzIHdlbGwuIEkgYW0gc3VyZSB0aGlzIHBhdGNoIHdpbGwgd29yayBmb3IgeW91Lg0KPiANCj4+
DQo+PiBJbiBmYWN0IG15IHN1Ym1pdCBteSBwcmV2aW91cyBwYXRjaCBzZXJpZXMgZXhhY3RseSBh
cyB0aGUgYmFzaXMgb2YgdGhpcw0KPj4gcGF0Y2guDQo+IA0KPiBUaGlzIHBhdGNoIGlzIGJhc2Vk
IHlvdXIgcGF0Y2ggc2VyaWVzIHNvIEkgc3VnZ2VzdCB5b3UgdGFrZSB0aGlzIHBhdGNoDQo+IGFu
ZCB0cnkgaXQgb24geW91ciBzaW11bGF0b3IuDQo+IA0KPiBTdWdnZXN0aW9ucyBhbmQgaW1wcm92
ZW1lbnRzIHRvIHRoaXMgcGF0Y2ggYXJlIHdlbGNvbWVkLg0KPiANCj4gSSB3b3VsZCBiZSBoYXBw
eSBpZiB5b3UgY2FuIGFzc2lzdCBtZSB0byB0cnkgb24geW91ciBIVy4NCj4gDQo+IFJlZ2FyZHMs
DQo+IEFudXANCj4gDQo=
