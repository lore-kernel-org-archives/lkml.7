Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B888C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084A42075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="EVEKGlYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfC0OJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:09:19 -0400
Received: from mail-eopbgr110108.outbound.protection.outlook.com ([40.107.11.108]:21984
        "EHLO GBR01-CWL-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbfC0OJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kirQD1cMLxzYrd2uSvz4bOtNA/RwlGSqtMTM0BCn2a4=;
 b=EVEKGlYdDFI0mnP03eVLn4Wj72lZXsRM7HSDzLIKV3peg+A//LiQYCgpbIvF/ph/l2GBnMpUR19koQ0bzFz8Rk+6+s9trO2iVRw67f6aFHu2MLLVX+kLiMcGoJjL6Nugb4ilk6ItcmNVJ2SctvSovJDcjDYyP7MwEmsl0aVxgbc=
Received: from LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM (20.176.139.20) by
 LO2P265MB1549.GBRP265.PROD.OUTLOOK.COM (20.176.143.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 14:09:15 +0000
Received: from LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ed34:1290:4306:3157]) by LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ed34:1290:4306:3157%3]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 14:09:15 +0000
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
Thread-Index: AQHU5IQth95RRmVyw0y1O3lxWJG/36YfVxgAgAAEHICAACGYgIAABZuAgAAB4QA=
Date:   Wed, 27 Mar 2019 14:09:15 +0000
Message-ID: <4dca2cfe-069f-f458-b1a7-f87aa6718ef7@garyguo.net>
References: <20190327100201.32220-1-anup.patel@wdc.com>
 <7edf91f1-1df5-5513-d372-d84edd12edf3@garyguo.net>
 <CAAhSdy1+rc9ge02uqNvse5Z6XmDxsRH0G=5GnMsh+6m1LMLFYg@mail.gmail.com>
 <74227a1d-3928-3e92-c7a9-5c3e093b29ab@garyguo.net>
 <CAAhSdy1K6OiZ2nDGcERi7J1z-i6hDC2eWubYDnSqPGCxQKkn5g@mail.gmail.com>
In-Reply-To: <CAAhSdy1K6OiZ2nDGcERi7J1z-i6hDC2eWubYDnSqPGCxQKkn5g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0036.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::24) To LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8c::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gary@garyguo.net; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:630:212:238:3697:f6ff:fe55:55b1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1a26928-2542-4208-4019-08d6b2bdcb63
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:LO2P265MB1549;
x-ms-traffictypediagnostic: LO2P265MB1549:
x-microsoft-antispam-prvs: <LO2P265MB154944EFD1CA7680DAC77B10D6580@LO2P265MB1549.GBRP265.PROD.OUTLOOK.COM>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39830400003)(396003)(346002)(376002)(189003)(199004)(53936002)(6246003)(229853002)(6486002)(316002)(36756003)(6916009)(6436002)(81166006)(6512007)(97736004)(25786009)(8676002)(54906003)(8936002)(7736002)(2906002)(81156014)(99286004)(93886005)(31686004)(305945005)(256004)(31696002)(7416002)(4744005)(5660300002)(486006)(86362001)(102836004)(476003)(4326008)(508600001)(46003)(106356001)(11346002)(186003)(105586002)(2616005)(6506007)(446003)(386003)(71200400001)(14454004)(76176011)(6116002)(52116002)(53546011)(71190400001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:LO2P265MB1549;H:LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: garyguo.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i+5tI2ckZMjMN79J+XLqvBpf1n4phyCWEqThZkNpqyE5RS3beU9f/B3DOD/SUSnEn1+Br64D3RvbpJs1TtjhhPT9pXrqGLnOPHf65vIUYd+7Tk03pQSWbiIdWs90UMPjjsj3atzE49BZBXEVoxJHUe89GAKMK13U+FIIx6TFM8ur72c3dKwQ3AaZ8nfybCVTU3dZYr4uRAPiHetSIPxTFz2O2pMQHzpT9t3bmW7JRC6e+/XKQ45F8NT4jXTOQet43GRjf0Vd7eR+bOsd7QeYt1N9wD88J26gV7w3CU/uuLQ/Z9kFSowDKyah2gGgzHzTCanTqDAR/e/ZZLj+UQpPJ8jQ/hvYYZ0QZHe29+2EwKN8KgqUfe2vnqC60OxVBPdBMlYcYV7aL7LR5M2cxjzznLMyalJU6ZdhC0bjA2Hs1fI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFA84DDD477AD4478D3FA072E01E0B17@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a26928-2542-4208-4019-08d6b2bdcb63
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 14:09:15.2647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB1549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSB0aGluayBteSBjb2RlIGFscmVhZHkgZ2V0IGFsbCB0aGUgY2F2ZWF0cyBjYXNlcyBjb3ZlcmVk
LiBUaGUgb25seSANCnRoaW5nIG15IGNvZGUgaXMgbWlzc2luZyBpcyBoYW5kbGluZyB0aGUgY2Fz
ZSB3aGVuIEFTSUQgaXMgbm90IA0Kc3VwcG9ydGVkLiBNYXliZSBpdCBpcyBiZXR0ZXIgdG8gd29y
ayBiYXNlZCBvbiB0aGF0IGluc3RlYWQ/DQoNCk9uIDI3LzAzLzIwMTkgMTQ6MDIsIEFudXAgUGF0
ZWwgd3JvdGU6DQo+IE9uIFdlZCwgTWFyIDI3LCAyMDE5IGF0IDc6MTIgUE0gR2FyeSBHdW8gPGdh
cnlAZ2FyeWd1by5uZXQ+IHdyb3RlOg0KPj4NCj4+IEkgd291bGQgYWxzbyBsaWtlIHRvIG1lbnRp
b24gdGhhdCB5b3VyIGNvZGUgYXNzdW1lcyA2NC1iaXQgYXRvbWljcw0KPj4gc3VwcG9ydCB3aGlj
aCB3ZSBkb24ndCBoYXZlIG9uIDMyLWJpdCBzeXN0ZW1zLiBVc2luZyAzMi1iaXQgdG8gdHJhY2sN
Cj4+IEFTSUQgZ2VuZXJhdGlvbnMgaXNuJ3Qgc3VmZmljaWVudCBhbmQgd2lsbCBjYXVzZSBvdmVy
Zmxvd3MuIFRoYXQncyB3aHkgSQ0KPj4gaGF2ZSBhc2lkX2dlbmVyYXRpb25fb3ZlcmZsb3cgdG8g
aGFuZGxlIHRoZSBjYXNlICh0aGlzIGlzIHN1cGVyDQo+PiBlcnJvci1wcm9uZSBhcyB3ZWxsKS4N
Cj4gDQo+IFRoYW5rcyBmb3IgY2F0Y2hpbmcuIEkgd2lsbCBmaXggaXNzdWVzIHdpdGggMzJiaXQg
c3lzdGVtcyBhbmQgc2VuZCB2Mg0KPiBzb29uLg0KPiANCj4gUmVnYXJkcywNCj4gQW51cA0KPiAN
Cg==
