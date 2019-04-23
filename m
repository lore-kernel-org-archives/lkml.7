Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ADCC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A067206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="sjUTAoUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfDWP5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:57:35 -0400
Received: from mail-eopbgr100130.outbound.protection.outlook.com ([40.107.10.130]:20864
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbfDWP5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfWaB807/cb9crWYbXB+rmDX3y4xWG6DfIfBsL2KBps=;
 b=sjUTAoUQsZX8KHH+myidi6mo5LLCrrMc+wX4wZxqhK+dPuD+kvgmMaU5YfxppdI5jRoqmKZVppr2OpkTo5EZFmCk7TMNFQPRBRvgOj1FTkwh8UpiS8p5HMHD2iXxygiA/ZXoxTPiyqqQw2Sa1KTim0OaVOosp8ytC6JmT2pfkPU=
Received: from LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM (20.176.139.20) by
 LO2P265MB0654.GBRP265.PROD.OUTLOOK.COM (10.166.105.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 15:57:30 +0000
Received: from LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d5c0:cf6f:4b60:ae19]) by LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d5c0:cf6f:4b60:ae19%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 15:57:30 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Guo Ren <guoren@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup.patel@wdc.com>,
        Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Scott Wood <swood@redhat.com>,
        "tech-privileged@lists.riscv.org" <tech-privileged@lists.riscv.org>
Subject: Re: [PATCH] riscv: Support non-coherency memory model
Thread-Topic: [PATCH] riscv: Support non-coherency memory model
Thread-Index: AQHU+SJqOw/bzOFv7E6YG/Ezkj/376ZIW7QAgACE3wCAAF+NAIAApRkAgAAC+wA=
Date:   Tue, 23 Apr 2019 15:57:30 +0000
Message-ID: <d1988350-7da9-37bb-3d8b-93bedea0b732@garyguo.net>
References: <1555947870-23014-1-git-send-email-guoren@kernel.org>
 <20190422161814.GA30694@lst.de> <20190423001348.GA31639@guoren-Inspiron-7460>
 <20190423055548.GA12365@lst.de> <20190423154642.GA16001@guoren-Inspiron-7460>
In-Reply-To: <20190423154642.GA16001@guoren-Inspiron-7460>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::20) To LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8c::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gary@garyguo.net; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:630:212:238:3697:f6ff:fe55:55b1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06794d87-611c-45f5-7de1-08d6c80463e7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:LO2P265MB0654;
x-ms-traffictypediagnostic: LO2P265MB0654:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <LO2P265MB0654ADFE84DE2C0D3404C115D6230@LO2P265MB0654.GBRP265.PROD.OUTLOOK.COM>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(396003)(39830400003)(346002)(199004)(189003)(99286004)(81156014)(81166006)(6436002)(8936002)(53936002)(14444005)(256004)(6246003)(5660300002)(186003)(52116002)(561944003)(66446008)(76176011)(102836004)(53546011)(6506007)(386003)(66476007)(64756008)(66556008)(73956011)(486006)(66946007)(2616005)(446003)(476003)(4326008)(11346002)(8676002)(25786009)(2906002)(46003)(71190400001)(71200400001)(97736004)(7736002)(6116002)(6306002)(305945005)(6916009)(31686004)(7416002)(86362001)(54906003)(14454004)(229853002)(508600001)(966005)(31696002)(36756003)(316002)(93886005)(68736007)(6486002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:LO2P265MB0654;H:LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: garyguo.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ebR+13b/0le0144jb9kLHJl1hCkE+TgYfNma3W7ar8zrE8JKY5s1b/mnkTq/4wDCWzcebvNS0oUPWwFDYfp5dX8KBDxeB7BaO4RhFBGe0HSlFwmT0254KglmZzLV0PybS3hzyQeL5XXEMz7StTWuSU1dTq/X4PbYlaCH6MM0a8FukK1exDMSCcJ8eloLSdHZjH3odWPycwH0a/l+VwaM2f+YWj9OmPKQZ0fbxEyd37v0qo9Cg3BXDyYt+oI6oiFFKK83FXUgNpDhVgeR6ylZxeVh2s2gD+RaKJ2+dYqzdsmgdveaYJumPlNsf5Btai2xd6EJ9rvAeeBcd/0CAeRa625jd5Xzre4LkT51/x0S56uhX2xsyPBBC7kpdazFU64dA+Os7rIhv9t7SpQw+vBmNFniqFv0rLPtz1riK7Lrlbo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17B373646E5003478C80CDE18E54E795@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 06794d87-611c-45f5-7de1-08d6c80463e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 15:57:30.3575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB0654
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIzLzA0LzIwMTkgMTY6NDYsIEd1byBSZW4gd3JvdGU6DQo+IE9uIFR1ZSwgQXByIDIz
LCAyMDE5IGF0IDA3OjU1OjQ4QU0gKzAyMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4g
T24gVHVlLCBBcHIgMjMsIDIwMTkgYXQgMDg6MTM6NDhBTSArMDgwMCwgR3VvIFJlbiB3cm90ZToN
Cj4+Pj4gV2Ugc2hvdWxkIHByb2JhYmx5IHN0YXJ0IGEgd29ya2luZyBncm91cCBmb3IgdGhpcyBB
U0FQIHVubGVzcyB3ZSBjYW4NCj4+Pj4gZ2V0IGFub3RoZXIgd29ya2luZyBncm91cCB0byBoZWxw
IHRha2luZyBjYXJlIG9mIGl0Lg0KPj4+IEdvb2QgbmV3cywgSSBwcmVmZXIgdG8gdXNlIGluc3Ry
dWN0aW9ucyBkaXJlY3RseSBpbnN0ZWFkIG9mIFNCSV9DQUxMLg0KPj4+DQo+Pj4gT3VyIGluc3Ry
dWN0aW9uIGlzICJkY2FjaGUuYy9pdmEgJTAiIChvbmUgY2FjaGUgbGluZSkgYW5kIHRoZSBwYXJh
bWV0ZXIgaXMNCj4+PiB2aXJ0dWFsIGFkZHJlc3MgaW4gUy1zdGF0ZS4gV2hlbiBnZXQgaW50byBN
LXN0YXRlIGJ5IFNCSV9DQUxMLCB3ZSBjb3VsZA0KPj4+IGxldCBkY2FjaGUuYy9pdmEgdXNlIHBo
eXNpY2FsIGFkZHJlcyBkaXJlY3RseSBhbmQgaXQgbmVlZG4ndCBrbWFwIHBhZ2UNCj4+PiBmb3Ig
UlYzMiB3aXRoIGhpZ2htZW0gKE9mIGNhdXNlIGhpZ2htZW0gaXMgbm90IHJlYWR5IGluIFJWMzIg
bm93KS4NCj4+DQo+PiBTbyB5b3Ugb25seSBoYXZlIG9uZSBpbnN0cnVjdGlvbiB2YXJpYW50PyAg
Tm9ybWFsbHkgd2UnZCBoYXZlIHR3byBvcg0KPj4gdGhyZWUgdG8gaW1wbGVtZW50IHRoZSBub24t
Y29oZXJlbnQgRE1BIChvciBwbWVtKSBzZW1hbnRpY3M6DQo+IGRjYWNoZS5jL2l2YSBtZWFucyB0
aHJlZSBpbnN0cnVjdGlvbnM6DQo+ICAgLSBkY2FjaGUuY3ZhICUwICA6IHdyaXRlYmFjayAgICAg
YnkgdmlydHVhbCBhZGRyZXNzIGNhY2hlbGluZQ0KPiAgIC0gZGNhY2hlLml2YSAlMCAgOiBpbnZh
bGlkICAgICAgIGJ5IHZpcnR1YWwgYWRkcmVzcyBjYWNoZWxpbmUNCj4gICAtIGRjYWNoZS5jaXZh
ICUwIDogd3JpdGViYWNrK2ludiBieSB2aXJ0dWFsIGFkZHJlc3MgY2FjaGVsaW5lDQo+IA0KPiBX
ZSBhbHNvIGhhdmUgbWVtb3J5IGJhcnJpZXIgaW5zdHJ1Y3Rpb25zLCByZWY6DQo+IGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dC90cmVlL2FyY2gvY3NreS9pbmNsdWRlL2FzbS9iYXJyaWVyLmgNCj4gDQo+Pg0KPj4gY2FjaGUg
d3JpdGViYWNrLCBjYWNoZSBpbnZhbGlkYXRlIGFuZCBwb3RlbnRpYWxseSBjYWNoZSB3cml0ZWJh
Y2sgKw0KPj4gaW52YWxpZGF0ZSB0byBvcHRpbWl6ZSB0aGF0IGNhc2UuICBIZXJlIGlzIHRoZSB0
YWJsZSBob3cgTGludXgNCj4+IHVzZXMgdGhlbSBmb3IgRE1BOg0KPj4NCj4+ICAgICAgICAgICAg
fCAgIG1hcCAgICAgICAgICA9PSAgZm9yX2RldmljZSAgICAgfCAgIHVubWFwICAgICA9PSAgZm9y
X2NwdQ0KPj4gICAgICAgICAgICB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICBUT19ERVYgICB8ICAgd3JpdGViYWNr
ICAgICAgICB3cml0ZWJhY2sgICAgICB8ICAgbm9uZSAgICAgICAgICBub25lDQo+PiAgIEZST01f
REVWIHwgICBpbnZhbGlkYXRlICAgICAgIGludmFsaWRhdGUgICAgIHwgICBpbnZhbGlkYXRlKiAg
IGludmFsaWRhdGUqDQo+PiAgIEJJREkgICAgIHwgICB3cml0ZWJhY2sraW52ICAgIHdyaXRlYmFj
aytpbnYgIHwgICBpbnZhbGlkYXRlICAgIGludmFsaWRhdGUNCj4+DQo+PiAgICAgICBbKl0gbmVl
ZGVkIGZvciBDUFUgc3BlY3VsYXRpdmUgcHJlZmV0Y2hlcw0KPj4NCj4+DQo+PiBXZSBhbHJlYWR5
IGhhdmUgYSBkaXNjdXNzaW9uIG9uIGlzYS1kZXYgb24gc29tZXRoaW5nIGxpa2UgdGhlc2UNCj4+
IGluc3RydWN0aW9uczoNCj4+DQo+PiBodHRwczovL2dyb3Vwcy5nb29nbGUuY29tL2EvZ3JvdXBz
LnJpc2N2Lm9yZy9mb3J1bS8jIW1zZy9pc2EtZGV2L3FYYnpxYVFiRFhVLzRUaGNFQWVDQ0FBSg0K
Pj4NCj4+IEl0IGdvdCBhIGxpdHRsZSBzaWRlIHRyYWNrZWQsIGJvdGggZHVlIHRvIHRoZSB1c3Vh
bCBub2lzZSBvbiBpc2EtZGV2DQo+PiBhbmQgZHVlIHRvIHRoZSBwcm9wb3NhbCBpbmNsdWRpbmcg
YSBsb3QgbW9yZSBpbnN0cnVjdGlvbnMgdGhhdCBtaWdodCBiZQ0KPj4gYSBsaXR0bGUgbW9yZSBj
b250ZW50aW91cywgYnV0IGl0IG1pZ2h0IGJlIGEgZ29vZCBzdGFydCB0byBicmluZyB0aGlzDQo+
PiBpbnRvIGEgd29ya2luZyBncm91cC4NCj4gSSB0aGluayB1c2luZyBzYmlfY2FsbCBhcyBhIHRl
bXBvcmFyeSBzb2x1dGlvbiBpcyBhIGdvb2QgY2hvaWNlIGJlZm9yZQ0KPiB0aGUgaW5zdHJ1Y3Rp
b24gaXMgZGV0ZXJtaW5lZC4NCj4gDQo+Pg0KPj4+PiBBbHNvIGlzIHRoaXMgcmVhbGx5IGEgY29o
ZXJlbnQgZmxhZywgb3IgYW4gJ3VuY2FjaGVkJyBmbGFnIGxpa2UgaW4NCj4+Pj4gbWFueSBvdGhl
ciBhcmNoaXRlY3R1cmVzPw0KPj4+IFRoZXJlIGFyZSBhIGxvdCBvZiBmZWF0dXJlcyBhYm91dCBj
b2hlcmVuY3kgYXR0cmlidXRlcywgZWc6IGNhY2hlYWJsZSwNCj4+PiBidWZmZXJhYmxlLCBzdHJv
bmcgb3JkZXIgLi4uLCBhbmQgY29oZXJlbmN5IGlzIGEgbW9yZSBhYnN0cmFjdCBuYW1lIHRvDQo+
Pj4gY29udGFpbiBhbGwgb2YgdGhlc2UuIEluIG91ciBoYXJkd2FyZSwgY29oZXJlbmNlID0gdW5j
YWNoZWQgKw0KPj4+IHVuYnVmZmVyYWJsZSArIChzdG9uZyBvcmRlcikuDQo+Pj4NCj4+PiBCdXQg
SSdtIG5vdCB2ZXJ5IGNhcmUgYWJvdXQgdGhlIG5hbWUgaXMsIHVuY2FjaGVkIGlzIGFsc28gb2su
IE15IGtleQ0KPj4+IHBvaW50IGlzIHRoZSBiaXRzIG9mIHBhZ2UgYXR0cmlidXRlcyBpcyB2ZXJ5
IHByZWNpb3VzIGFuZCB0aGlzIHBhdGNoDQo+Pj4gd2lsbCB1c2UgdGhlIGxhc3QgdW51c2VkIGF0
dHJpYnV0ZSBiaXQgaW4gUFRFLg0KPj4NCj4+IEkgZG9uJ3QgY2FyZSBhYm91dCB0aGUgbmFtZSBh
Y3R1YWxseSwgbW9yZSBhYm91dCBoYXZpbmcgZGVmaW5lZCBzZW1hbnRpY3MuDQo+PiBUb3RhbGx5
IHVuY2FjaGVkIHNob3VsZCBpbmNsdWRlIHVuYnVmZmVyZWQuICBJIGRvbid0IHRoaW5rIHdlIG5l
ZWQgdGhlDQo+PiBzdHJvbmcgb3JkZXJpbmcgZm9yIERNQSBtZW1vcnkgZWl0aGVyLg0KPiBZZXMs
IG1lbW9yeSBkb24ndCBuZWVkIHN0cm9uZyBvcmRlciBhbmQgc3Ryb25nIG9yZGVyIGluIFBNQSBh
bHNvIGltcGxpZXMNCj4gdW5jYWNoZWQsIHVuYnVmZmVyZWQgZm9yIElPIGFkZHJlc3MuIElmIHRo
ZSBlbnRyeSBvZiBQTUEgaXMgc3Ryb25nDQo+IG9yZGVyLCB0aGUgcGFnZSBtYXBwaW5nIG11c3Qg
YmUgdW5jYWNoZWQgKyB1bmJ1ZmZlcmVkICsgc3Ryb25nLW9yZGVyDQo+IHdpdGhvdXQgX1BBR0Vf
Q09IRU5DWSBpbiBQVEUuDQo+IA0KPj4NCj4+PiBBbm90aGVyIHBvaW50IGlzIHdlIGNvdWxkIGdl
dCBtb3JlIGF0dHJpYnV0ZSBiaXRzIGJ5IG1vZGlmeSB0aGUgcmlzY3YNCj4+PiBzcGVjOg0KPj4+
ICAgLSBSZW1vdmUgR2xvYmFsIGJpdCwgSSB0aGluayBpdCdzIGR1cGxpY2F0ZSB3aXRoIHRoZSBV
c2VyIGJpdCBpbiBsaW51eC4NCj4+DQo+PiBJdCBpcyBpbiBMaW51eCwgYnV0IGl0IGlzIGNvbmNl
cHR1YWxseSB2ZXJ5IGRpZmZlcmVudC4NCj4gWWVzLCBidXQgaGFyZHdhcmUgY291bGQgaWdub3Jl
IG9uZSBvZiB0aGVtIGFuZCBpbiByaXNjdiBsaW51eA0KPiBfUEFHRV9HTE9CQUwgaXMgbm8gdXNl
IGF0IGFsbCwgc2VlOg0KPiBncmVwIF9QQUdFX0dMT0JBTCBhcmNoL3Jpc2N2IC1yDQo+IA0KPiBJ
biBmYWN0LCB0aGUgX1BBR0VfS0VSTkVMIGZvciBwdGUgZG9lc24ndCBjb250YWluIF9QQUdFX0dM
T0JBTCBhbmQgaXQNCj4gd29ya3Mgb24gRlU1NDAgYW5kIHFlbXUuIEFzIEkndmUgbWVudGlvbmVk
IHBhZ2UgYXR0cmlidXRlIGJpdHMgaXMgdmVyeQ0KPiBwcmVjaW91cywgZGVmaW5lIGEgdXNlbGVz
cyBiaXQgbWFrZSBwZW9wbGUgY29uZnVzZWQuDQogPg0KDQpUaGUgZmFjdCB0aGF0IGl0IGlzbid0
IHVzZWQgeWV0IGRvZXNuJ3QgaW1wbHkgaXQgaXMgbm90IHVzZWZ1bC4gV2UgZG9uJ3QgDQp1c2Ug
QVNJRHMgYXQgdGhlIG1vbWVudCwgYW5kIHdpdGhvdXQgdXNpbmcgQVNJRHMgdGhlICJnbG9iYWwi
IGJpdCBpcyANCmluZGVlZCBub3QgdXNlZnVsLiBIb3dldmVyIHdpdGggQVNJRHMgdGhlIGJpdCB3
aWxsIGJlIHZpdGFsIGZvciBzYXZpbmcgDQpUTEIgc3BhY2VzLiBXaXRob3V0IHRoZSBnbG9iYWwg
Yml0LCB0aGUga2VybmVsIHBhZ2VzIGJlY29tZSBzeW5vbnltcyB0byANCnRoZW1zZWx2ZXMgKGku
ZS4gdGhleSBoYXZlIGRpZmZlcmVudCB0YWdzIGluIFRMQiBidXQgcmVmZXIgdG8gdGhlIHNhbWUg
DQpwaHlzaWNhbCBwYWdlKS4NCg0KVGhlIGdsb2JhbCBiaXQgYWxzbyBleGlzdHMgaW4gbWFueSBv
dGhlciBJU0FzIGFzIHdlbGwuIEl0J3MgZGVmaW5pdGVseSANCm5vdCBhICJ1c2VsZXNzIiBiaXRz
Lg0KDQpNb3Jlb3ZlciwgdGhpcyBiaXQgaXMgYWxyZWFkeSBpbXBsZW1lbnRlZCBpbiBib3RoIFJv
Y2tldCBhbmQgQXJpYW5lLiBJdCANCmlzIGFsc28gaW4gdGhlIHNwZWMgZm9yIHF1aXRlIGEgd2hp
bGUuIFRoZSBmYWN0IHRoYXQgTGludXggZG9lc24ndCB1c2UgDQppdCBhdCB0aGUgbW9tZW50IGlz
IG5vdCBhIHJlYXNvbiBmb3IgcmVtb3ZpbmcgaXQuDQoNCj4gDQo+Pg0KPj4+ICAgLSBDaGFuZ2Ug
X1BBR0VfUEZOX1NISUZUIGZyb20gMTAgdG8gMTIsIGJlY2F1c2UgdGhlIGh1Z2UgcGZuIGluIFJW
MzIgaXMNCj4+PiAgICAgdmVyeSB1c2VsZXNzIGFuZCBjdXJyZW50IFJWMzIgbGludXggZG9lc24n
dCBldmVuIGltcGxlbWVudCBoaWdobWVtLg0KPj4NCj4+IFRoaXMgd291bGQgc2VlbSBzZW5zaWJs
ZSB0byBtZSwgYnV0IEknbSBub3Qgc3VyZSBldmVyeW9uZSBhZ3JlZXMuICBFdmVuDQo+PiB0aGVu
IHdlIGFyZSB2ZXJ5IGxhdGUgaW4gdGhlIGdhbWUgZm9yIGNoYW5nZXMgbGlrZSB0aGF0Lg0KPiBB
Z3JlZS4NCj4gDQo+IEJlc3QgUmVnYXJkcw0KPiAgIEd1byBSZW4NCj4gDQo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LXJpc2N2IG1haWxp
bmcgbGlzdA0KPiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCj4gDQo=
