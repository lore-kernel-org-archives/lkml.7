Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5BCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CC520700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nm1fpnsK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MaYxYp/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389286AbfJVWxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 18:53:11 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5393 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731850AbfJVWxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571784790; x=1603320790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FjTK4ZGG6bODJRuV/Ub4IgTxvO6ifw+hrS6fz6rb0Dg=;
  b=nm1fpnsKmptPpkr66vqQc3QhGoYr2xIuCDKjJOH6Y5KXWpL2VDGtoQSm
   7Um7KqdvvAzVy2ETpEh/lItLAQ4i7buf1Z/KaoDcEFK0jItcA3yPFGANM
   Aid5tzkUrIWdiHwLlNIavwezJgtK5NY0Wt2N7fBEmIxfCAI7jxwXKz0Rs
   gHaHXKs2NNScUIuJAg016D3YXTI9t9Gef4WIb9jgVMM/+hPHaij14Me79
   hj9u5S4w1ByQwmw6H7SWwmSUXXHfqbeQaRHqPd/dQn8dDQnSRg/1ocAgH
   WYPnGdJ93/Exzch91P0sLL7DRAKvEqWeoIJiLzBJz3vep3wTvlv1ax8JD
   g==;
IronPort-SDR: JJhqZ+bGKN6/+1twYEODm8HX3j8xxZlxlSytBL6iGaDo6F8fTgkIrZc9zWfieLQKwmIP7z0ea3
 VMNQNkiUbx16PAkSEB/57venQBf9Cn7/p6iiWt1OHa2iJ/NAgyDrTl4//cl+5WmrMmMEApdGmo
 TCUOikxn/ranBwtl6Y4RghEFcdQimzn1xnSmPOqhMCLLZTYPS0lgKEWVtKB5ViXI9UTx/+3vsQ
 FEDb2ifJU7xIymjCGGCwSsoAF48qU4bstZgj4Q9afoeRvup29eHTAV9PwQRmlk0oWy+YCFHQpL
 Wv0=
X-IronPort-AV: E=Sophos;i="5.68,218,1569254400"; 
   d="scan'208";a="125529643"
Received: from mail-sn1nam04lp2059.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.59])
  by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2019 06:53:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bW/v4RnPLSa4y3XI7e8YyELdbKOWBqTGUlVvPpS1pWrONEO0yjsthURLnEcP0HuMgpI78JaRsm6jC68kL6K8inn6cRraINAS82WYy1nlD/7FgfmVg5oUopIr61hCaMWdV9v5/6NJH7XrR/b8ehaMh2py3O3ADColS+9v4Tc8OOel6Qy7EfGDM1AS8RIEVEzg9B9TPzF+qY7v3yT7jiDz+S76MiAT68SyL+J3mWO94HLl+3NszcfPNBYmBPXA8PZCVp5zDnlU2FukDr2kEvn9qnru4SCcoo5x5cEM9ZF6LAHxqFhxPHHINsSLaKrPea+DXrqw40Xqash19Q4I06p0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjTK4ZGG6bODJRuV/Ub4IgTxvO6ifw+hrS6fz6rb0Dg=;
 b=Pdi5AcmS2jYaz7mNG0SvJKoR0qebsT1VjzDw6nlXaQr42v2s+orNbIq+e8bdJHFeTl7A3cNWR/XkajKUADh//fldhXBFqTZjX6ooJuXfaE8QQuiyB8OXH2gweUk2CnC93S4mdoNZBcO88TH38aDkl5rMkte41yHtrQTYHZ8LPb3g3pHx1nHZRqopZE5VASP3ORIqMJjYENuBF14Bp4A/3Pvz9mICippaa7mD1xsa6otPvsdUlbnAM3Q4SUquzaoqcyOitJUma7g/pK2gjXB8H4N4skbY9prO4Zo6bKa6GheuF+VznSX3ka7EHqSqp2/acp2lgPve93oP7+jHtOr+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjTK4ZGG6bODJRuV/Ub4IgTxvO6ifw+hrS6fz6rb0Dg=;
 b=MaYxYp/8dyq3Xxuz6jUAVhcgQ9EttdDLuenVqUv2T4zKTIf0ed5zTaR6WHCP9Sw7Lo+ebhHcII9F2t1naToztgl+8Bk82JGnd/CjX4oUhghBl4pcAbrq2j9FB5FhPzlYrRq6HvTAxGZFn79B0IOOMWK0GkkI4EVWceSXBBqcJXM=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB4935.namprd04.prod.outlook.com (52.135.235.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 22:53:05 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::4933:8361:f5e3:a6c6]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::4933:8361:f5e3:a6c6%4]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 22:53:05 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rkir@google.com" <rkir@google.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
Thread-Topic: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
Thread-Index: AQHVc2vLFlE68F2kkUyeFzcwcqAG+qdXYO6AgAKZbICADTsXgIAAOUoA
Date:   Tue, 22 Oct 2019 22:53:05 +0000
Message-ID: <17db4a6244d09abf867daf2a6c10de6a5cd58c89.camel@wdc.com>
References: <20190925063706.56175-3-anup.patel@wdc.com>
         <mhng-edb410db-fdd1-46f6-84c3-ae3b843f7e3a@palmer-si-x1c4>
         <MN2PR04MB606160F5306A5F3C5D97FB788D900@MN2PR04MB6061.namprd04.prod.outlook.com>
         <alpine.DEB.2.21.9999.1910221213490.28831@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910221213490.28831@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35d6e10a-9ba9-4636-7cfc-08d7574299e5
x-ms-traffictypediagnostic: BYAPR04MB4935:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4935B3FB2BFEAE357AE9C7E990680@BYAPR04MB4935.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(13464003)(199004)(189003)(3846002)(6486002)(14454004)(6116002)(446003)(478600001)(966005)(229853002)(66946007)(66556008)(66476007)(2501003)(6636002)(54906003)(110136005)(6436002)(316002)(66446008)(64756008)(76116006)(25786009)(71190400001)(71200400001)(186003)(486006)(11346002)(2616005)(476003)(2906002)(6506007)(102836004)(305945005)(256004)(99286004)(4326008)(66066001)(6512007)(26005)(14444005)(6246003)(53546011)(76176011)(7736002)(6306002)(81166006)(8676002)(8936002)(81156014)(118296001)(5660300002)(4001150100001)(86362001)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4935;H:BYAPR04MB4901.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hbiy2aiDJipRpSY3rLRo255EwBb9Lw/GwDptCySudoW8l2M8VB2qsPtjsAu6hQL+7qpmTyRktZD10HhsWx1eLkFUPW/ZGZq1XY2xKZIJXkFtUOBdagrUEmECc/PwGAeL+gsRSHqwqzKGvNcZW1OVneOz8o3NunvtwUx+FE8yFbCkkMhHaaGC0ori4X3Wi5wAqu3u7n2tH2v+TFXaX/LDJ16jp6i++omtsD0oKQibcC4jO2i2aOIMYFbqTZt3Iw5nDcHttHd67hCtU08NaPKoihfB8eatnQFv7cTuDhOS7pg9wXMOExKG/wYC9D7RIOxwqSIiYqj+xaXW0zHLxFj4aQmRNDnOA+toeysU7Oec/ZKQTF/6n2BpGIhCDUxXJa/CUqh9y5DkbDzlgmLCSLZB7SoCJefH7ubEFwjtWV03VwzkYzJdBUOBCSsza3Axa7D/nrHuv3JVv4VULwderqPpT5I4QH+G7rjnskLOReDj8Hw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29F97478FE661D4EA94B7D9C01C67C61@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d6e10a-9ba9-4636-7cfc-08d7574299e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 22:53:05.5937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZ2rjrU/V6qIKHKf3r1kqPTUjk+YToMYKOb7269RXa3t/UlnTLV7YLTAD5UI0IeZgxuMW6DjKGHtRi9Ja+gyju+1c23KfHatG7QWowGtTKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTIyIGF0IDEyOjIzIC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBNb24sIDE0IE9jdCAyMDE5LCBBbnVwIFBhdGVsIHdyb3RlOg0KPiANCj4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBQYWxtZXIgRGFiYmVsdCA8cGFsbWVy
QHNpZml2ZS5jb20+DQo+ID4gPiBTZW50OiBTYXR1cmRheSwgT2N0b2JlciAxMiwgMjAxOSAxMTow
OSBQTQ0KPiA+ID4gVG86IEFudXAgUGF0ZWwgPEFudXAuUGF0ZWxAd2RjLmNvbT4NCj4gPiA+IENj
OiBQYXVsIFdhbG1zbGV5IDxwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20+OyANCj4gPiA+IGFvdUBl
ZWNzLmJlcmtlbGV5LmVkdTsNCj4gPiA+IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPjsgcmtpckBnb29nbGUuY29tOyBBdGlzaA0KPiA+ID4gUGF0cmENCj4gPiA+IDxBdGlzaC5Q
YXRyYUB3ZGMuY29tPjsgQWxpc3RhaXIgRnJhbmNpcyA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29t
DQo+ID4gPiA+Ow0KPiA+ID4gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPjsg
YW51cEBicmFpbmZhdWx0Lm9yZzsNCj4gPiA+IGxpbnV4LQ0KPiA+ID4gcmlzY3ZAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW51cA0KPiA+ID4gUGF0
ZWwNCj4gPiA+IDxBbnVwLlBhdGVsQHdkYy5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDIvMl0gUklTQy1WOiBkZWZjb25maWc6IEVuYWJsZSBHb2xkZmlzaA0KPiA+ID4gUlRDIGRy
aXZlcg0KPiA+ID4gDQo+ID4gPiBPbiBUdWUsIDI0IFNlcCAyMDE5IDIzOjM4OjA4IFBEVCAoLTA3
MDApLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiA+ID4gPiBXZSBoYXZlIEdvbGRmaXNoIFJUQyBkZXZp
Y2UgYXZhaWxhYmxlIG9uIFFFTVUgUklTQy1WIHZpcnQNCj4gPiA+ID4gbWFjaGluZQ0KPiA+ID4g
PiBoZW5jZSBlbmFibGUgcmVxdWlyZWQgZHJpdmVyIGluIFJWMzIgYW5kIFJWNjQgZGVmY29uZmln
cy4NCj4gDQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgR29sZGZpc2ggc3VwcG9ydCBp
cyBzdGlsbCB1bmRlciANCj4gZGlzY3Vzc2lvbiBvbiB0aGUgUUVNVSBzaWRlIGFuZCBpc24ndCBt
ZXJnZWQgeWV0IC0gaXMgdGhhdCBhY2N1cmF0ZT8NCj4gDQo+IGh0dHBzOi8vbGlzdHMuZ251Lm9y
Zy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTEwL21zZzA0OTA0Lmh0bWwNCj4gDQo+ID4g
PiBSZXZpZXdlZC1ieTogUGFsbWVyIERhYmJlbHQgPHBhbG1lckBzaWZpdmUuY29tPg0KPiA+ID4g
DQo+ID4gPiBJSVJDIHRoZXJlIHdhcyBzdXBwb3NlZCB0byBiZSBhIGZvbGxvdy11cCB0byB5b3Vy
IFFFTVUgcGF0Y2ggc2V0DQo+ID4gPiB0byByZWJhc2UNCj4gPiA+IGl0IG9uIHRvcCBvZiBhIHJl
ZmFjdG9yaW5nIG9mIHRoZWlyIFJUQyBjb2RlLCBidXQgSSBkb24ndCBzZWUgaXQNCj4gPiA+IGlu
IG15IGluYm94LiAgTE1LDQo+ID4gPiBpZiBJIG1pc3NlZCBpdCwgYXMgUUVNVSdzIHNvZnQgZnJl
ZXplIGlzIGluIGEgZmV3IHdlZWtzIGFuZCBJJ2QNCj4gPiA+IGxpa2UgdG8gbWFrZQ0KPiA+ID4g
c3VyZSBJIGdldCBldmVyeXRoaW5nIGluLg0KPiA+IA0KPiA+IEkgd2FzIGhvcGluZyBmb3IgUUVN
VSBSVEMgcmVmYWN0b3JpbmcgdG8gYmUgbWVyZ2VkIHNvb24gYnV0IGl0IGhhcw0KPiA+IG5vdA0K
PiA+IGhhcHBlbmVkIHNvIGZhci4gSSB3aWxsIHdhaXQgY291cGxlIG9mIG1vcmUgZGF5cyB0aGVu
IHNlbmQgdjMgb2YNCj4gPiBRRU1VDQo+ID4gcGF0Y2hlcy4NCj4gDQo+IFRoZSBwYXRjaCBsb29r
cyBmaW5lIHRvIG1lLCBidXQgbGV0J3Mgd2FpdCB1bnRpbCB0aGUgdW5kZXJseWluZw0KPiBzdXBw
b3J0IA0KPiBhY3R1YWxseSBhcHBlYXJzIG9uIHRoZSBRRU1VICJoYXJkd2FyZSIuICBDb3VsZCB5
b3UgcmVzZW5kIG9uY2UNCj4gdGhhdCdzIA0KPiBoYXBwZW5lZD8NCg0KSSB0aGluayBpdCBtYWtl
c2Ugc2Vuc2UgZm9yIHRoaXMgdG8gZ28gaW50byBMaW51eCBmaXJzdC4NCg0KVGhlIFFFTVUgcGF0
Y2hlcyBhcmUgZ29pbmcgdG8gYmUgYWNjZXB0ZWQsIGp1c3Qgc29tZSBuaXQgcGlja2luZyB0byBk
bw0KZmlyc3QgOikNCg0KQWZ0ZXIgdGhhdCB3ZSBoYXZlIHRvIHdhaXQgZm9yIGEgUFIgYW5kIHRo
ZW4gYSBRRU1VIHJlbGVhc2UgdW50aWwgbW9zdA0KcGVvcGxlIHdpbGwgc2VlIHRoZSBjaGFuZ2Ug
aW4gUUVNVS4gSW4gdGhhdCB0aW1lIExpbnV4IDUuNCB3aWxsIGJlDQpyZWxlYXNlZCwgaWYgdGhp
cyBjYW4gbWFrZSBpdCBpbnRvIDUuNCB0aGVuIGV2ZXJ5b25lIHVzaW5nIDUuNCB3aWxsIGdldA0K
dGhlIG5ldyBSVEMgYXMgc29vbiBhcyB0aGV5IHVwZ3JhZGUgUUVNVSAoUUVNVSBwcm92aWRlcyB0
aGUgZGV2aWNlDQp0cmVlKS4gSWYgdGhpcyBoYXMgdG8gd2FpdCB1bnRpbCBRRU1VIGhhcyBzdXBw
b3J0IHRoZW4gaXQgd29uJ3QgYmUNCnN1cHBvcnRlZCBmb3IgdXNlcnMgdW50aWwgZXZlbiBsYXRl
ci4NCg0KVXNlcnMgYXJlIGdlbmVyYWxseSBzbG93IHRvIHVwZGF0ZSBrZXJuZWxzIChidWlsZHJv
b3QgaXMgc3RpbGwgdXNpbmcNCjUuMSBieSBkZWZhdWx0IGZvciBleGFtcGxlKSBzbyB0aGUgc29v
bmVyIGNoYW5nZXMgbGlrZSB0aGlzIGdvIGluIHRoZQ0KYmV0dGVyLg0KDQpBbGlzdGFpcg0KDQo+
IA0KPiB0aGFua3MsDQo+IA0KPiAtIFBhdWwNCg==
