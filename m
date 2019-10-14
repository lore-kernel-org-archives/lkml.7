Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059E2C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D78920659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dgpUScAr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U7XpU2g1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfJNJUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:20:23 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19050 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbfJNJUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571044822; x=1602580822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yX9778eXq2N4OM51P4IdRaRkW15I40tzd3qRShew80A=;
  b=dgpUScArnZusDgjh8NegCJcNLtvmNYTm0KHUKb28PVT95U6JYaojZi0+
   JLU0w7EFdbXDbWaHn+Ok8dP7nzq/9lO8keP4sXm2VOkZpdJvQzGpYWO64
   93gvczA7BmXWLy/WoQ0usrfblEfe17vmeiwe7LK2u0PMCjpQVkjaZRXCY
   JS2IfdE2nDjyMg3Swyjo3ga7zr1HFYxbqe2A4h4fjWfGlAZTXVEK02Ymo
   NamKa7eKVC/UlD9lh1blR8OQYXvl0TL+lDMmYchGGiDsy7LPKgqAu9Xiv
   eKpQB0l1uJ04vyK7PPVdNJOLkJnTLIS+K+LQOLBMi1scoEu3sJn1IiwWH
   w==;
IronPort-SDR: VGLi7u7VoiHqnQ4hBAYlzkREHI8kHIbqUIH9F6FvkzK0HpXJuYYnZ+1PVKJRh4EWqFJu49O+Ll
 IUTb2avmpjqyDkgKZcRTSFaNjYArjYlkNbb6WosAVTOP6oTNnVdOz26kB4isHcjqOo7Y2U0VGp
 2DUajqS8Lota/A8NnSJXjdA0JHKKBK3qEWPXpzII/4gFCCzAk/EAi1jVchZIGZ0tngE+wtPICQ
 OoGHwH0LmWz74Bf0d88aQKgKlykiEYClKZrtTvnz7w08eY3cZrGAiE7ezdkBa6i3S6ZNlzQeE7
 iaw=
X-IronPort-AV: E=Sophos;i="5.67,295,1566835200"; 
   d="scan'208";a="122061963"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2019 17:20:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6NT1IoTSOgLyToGqIoBXi0sHvddmNnd4q7fN21GVfttJwfOI/cqdOYaaSfPp9P2IEPlH5hmcQd1gM0vR98BmShwoibm3WBmBasJkscUSArhJM7l+2ORdBJOwhmgfFpKpmnAXbeRr20XQxxeg9GMbIHHgoGVnN6JGezsGKRf8mJze5YwunQT0z47li6kgaXteg6SNJrgyZcSUG/y85MpXvMzI0xK6+wLykqGJQRas3jMn12q3xfvPkdA92aw6b4tughBRt5xiDK7Vm3n/E+SAtNudDaZChK6o2dfmWGv+uEoFVvLwFNx8nmFV8R8C/IDsS97FNHQcVmrXwGMl4YTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX9778eXq2N4OM51P4IdRaRkW15I40tzd3qRShew80A=;
 b=m2OYNzH84PKu/Z9jx1VUhPTH1eeUNkry6olw/WSjyoDYCzd3udt5/tJc2daLuKMKqyXj4YlWM8E3nm0eia0/qfERxQAOqVvpqcZzkaEvlSqq1SVLjKo/1vk0BNtPIR+oPInDJgr54ctAz0eHe1SVbOFKBVzSXA7JxvLTQ8Vg5+CW0HvWZl0iKUagZL5IjWDA69vM94saauCjMdzvFCnYxMmO6H3mGDw0EktMcyBLwPNayu4qkvMoCGrK+sI4vOKOEUt7cEbCeozBnybAjZ8SRbldCIEqWgupnuvwF21Db6A0/aOLf5YVW92IAyD0A3MwkQf/WMiY9vApLtRbjQiCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX9778eXq2N4OM51P4IdRaRkW15I40tzd3qRShew80A=;
 b=U7XpU2g1nFjJac7N1paEwlV4xriSA0hwi3UbN8MrAc1ff075zSILYIt+iIEII5b/w/sRY+yKFBL1ajiyuHB9Q7Hp6DryyygLO3G+S5mtDPmVrasrodY0Fh3bHbHOWlUfgSZWEYWAtCJRJwR5SuoXcEtGHyrSzQNMjcMXN2fiaLY=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6462.namprd04.prod.outlook.com (52.132.170.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Mon, 14 Oct 2019 09:20:20 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a%7]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 09:20:20 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        "rkir@google.com" <rkir@google.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
Thread-Topic: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
Thread-Index: AQHVc2vL/aB/O/VoT0mkZEceqSj8FKdXYO6AgAKYfpA=
Date:   Mon, 14 Oct 2019 09:20:19 +0000
Message-ID: <MN2PR04MB606160F5306A5F3C5D97FB788D900@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20190925063706.56175-3-anup.patel@wdc.com>
 <mhng-edb410db-fdd1-46f6-84c3-ae3b843f7e3a@palmer-si-x1c4>
In-Reply-To: <mhng-edb410db-fdd1-46f6-84c3-ae3b843f7e3a@palmer-si-x1c4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [49.207.50.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae7b64ac-e756-4cc1-f799-08d75087bc18
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR04MB6462:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB64629F56AA8760220C84CA578D900@MN2PR04MB6462.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(13464003)(6916009)(86362001)(4326008)(6436002)(55016002)(33656002)(7696005)(7736002)(8936002)(76176011)(81156014)(81166006)(305945005)(6116002)(99286004)(9686003)(6246003)(229853002)(8676002)(316002)(54906003)(74316002)(3846002)(186003)(66946007)(6506007)(66476007)(66556008)(66446008)(64756008)(14454004)(446003)(11346002)(14444005)(256004)(76116006)(53546011)(102836004)(26005)(55236004)(71200400001)(486006)(476003)(2906002)(5660300002)(25786009)(71190400001)(52536014)(66066001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6462;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JnicT85MkTyPhPcUy2xo/1Kj/TNECaVOLmIYZi7Ecby2iRp9+2676YZDZntJVUWUh5Dh2lrwcVWw6H2s2wlSmAVPZcA/qyVzrqllwESE3n9C2htRab+QHxCq0sew0smNv+IkGrR6RfEgvOt0gO+WqP0GKCgJq24LrWosklXCyf7xF512OqlopNbbS9cz6mzentGOZtPIL5KF7Tm6fYuJxmS9PLVrNJfgPcGpETjcMwv3xqWdp5XJ9wwJ07606nGxj48jvB+38+Sx5UQyZ76OAhBRgUN+b79JgTYNjs6QfjdClykAx8vsg3FFZYoU4Qt7bcS5b4UHkP9DwH50safRMBj2pbTn638Hx0tuRkY23cVEEFGtEwYzuYFprrbG91uUPj5P6usVM3NQGPOVWxiw/c+Nj0S8s+uB9z5v4fHYB6o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7b64ac-e756-4cc1-f799-08d75087bc18
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 09:20:20.0595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBG/BxsyezrJCYqRnBCU766wpgdhPWe8iud44OGQ3g60XuoTbXKF2uyHp4GowXj8LfD+OGbwV4+jX5QsYu6R5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFsbWVyIERhYmJlbHQg
PHBhbG1lckBzaWZpdmUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgT2N0b2JlciAxMiwgMjAxOSAx
MTowOSBQTQ0KPiBUbzogQW51cCBQYXRlbCA8QW51cC5QYXRlbEB3ZGMuY29tPg0KPiBDYzogUGF1
bCBXYWxtc2xleSA8cGF1bC53YWxtc2xleUBzaWZpdmUuY29tPjsgYW91QGVlY3MuYmVya2VsZXku
ZWR1Ow0KPiBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IHJraXJAZ29vZ2xl
LmNvbTsgQXRpc2ggUGF0cmENCj4gPEF0aXNoLlBhdHJhQHdkYy5jb20+OyBBbGlzdGFpciBGcmFu
Y2lzIDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+Ow0KPiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGluZnJhZGVhZC5vcmc+OyBhbnVwQGJyYWluZmF1bHQub3JnOyBsaW51eC0NCj4gcmlzY3ZAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW51cCBQYXRl
bA0KPiA8QW51cC5QYXRlbEB3ZGMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0g
UklTQy1WOiBkZWZjb25maWc6IEVuYWJsZSBHb2xkZmlzaCBSVEMgZHJpdmVyDQo+IA0KPiBPbiBU
dWUsIDI0IFNlcCAyMDE5IDIzOjM4OjA4IFBEVCAoLTA3MDApLCBBbnVwIFBhdGVsIHdyb3RlOg0K
PiA+IFdlIGhhdmUgR29sZGZpc2ggUlRDIGRldmljZSBhdmFpbGFibGUgb24gUUVNVSBSSVNDLVYg
dmlydCBtYWNoaW5lDQo+ID4gaGVuY2UgZW5hYmxlIHJlcXVpcmVkIGRyaXZlciBpbiBSVjMyIGFu
ZCBSVjY0IGRlZmNvbmZpZ3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnVwIFBhdGVsIDxh
bnVwLnBhdGVsQHdkYy5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvcmlzY3YvY29uZmlncy9kZWZj
b25maWcgICAgICB8IDMgKysrDQo+ID4gIGFyY2gvcmlzY3YvY29uZmlncy9ydjMyX2RlZmNvbmZp
ZyB8IDMgKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9jb25maWdzL2RlZmNvbmZpZw0KPiA+IGIvYXJjaC9y
aXNjdi9jb25maWdzL2RlZmNvbmZpZyBpbmRleCAzZWZmZjU1MmEyNjEuLjU3YjRmNjdiMGMwYiAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4gKysrIGIv
YXJjaC9yaXNjdi9jb25maWdzL2RlZmNvbmZpZw0KPiA+IEBAIC03Myw3ICs3MywxMCBAQCBDT05G
SUdfVVNCX1NUT1JBR0U9eSAgQ09ORklHX1VTQl9VQVM9eQ0KPiA+IENPTkZJR19NTUM9eSAgQ09O
RklHX01NQ19TUEk9eQ0KPiA+ICtDT05GSUdfUlRDX0NMQVNTPXkNCj4gPiArQ09ORklHX1JUQ19E
UlZfR09MREZJU0g9eQ0KPiA+ICBDT05GSUdfVklSVElPX01NSU89eQ0KPiA+ICtDT05GSUdfR09M
REZJU0g9eQ0KPiA+ICBDT05GSUdfRVhUNF9GUz15DQo+ID4gIENPTkZJR19FWFQ0X0ZTX1BPU0lY
X0FDTD15DQo+ID4gIENPTkZJR19BVVRPRlM0X0ZTPXkNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9y
aXNjdi9jb25maWdzL3J2MzJfZGVmY29uZmlnDQo+ID4gYi9hcmNoL3Jpc2N2L2NvbmZpZ3MvcnYz
Ml9kZWZjb25maWcNCj4gPiBpbmRleCA3ZGE5M2U0OTQ0NDUuLjUwNzE2YzEzOTVhYSAxMDA2NDQN
Cj4gPiAtLS0gYS9hcmNoL3Jpc2N2L2NvbmZpZ3MvcnYzMl9kZWZjb25maWcNCj4gPiArKysgYi9h
cmNoL3Jpc2N2L2NvbmZpZ3MvcnYzMl9kZWZjb25maWcNCj4gPiBAQCAtNjksNyArNjksMTAgQEAg
Q09ORklHX1VTQl9PSENJX0hDRD15DQo+ID4gQ09ORklHX1VTQl9PSENJX0hDRF9QTEFURk9STT15
ICBDT05GSUdfVVNCX1NUT1JBR0U9eQ0KPiBDT05GSUdfVVNCX1VBUz15DQo+ID4gK0NPTkZJR19S
VENfQ0xBU1M9eQ0KPiA+ICtDT05GSUdfUlRDX0RSVl9HT0xERklTSD15DQo+ID4gIENPTkZJR19W
SVJUSU9fTU1JTz15DQo+ID4gK0NPTkZJR19HT0xERklTSD15DQo+ID4gIENPTkZJR19TSUZJVkVf
UExJQz15DQo+ID4gIENPTkZJR19FWFQ0X0ZTPXkNCj4gPiAgQ09ORklHX0VYVDRfRlNfUE9TSVhf
QUNMPXkNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiANCj4gUmV2aWV3ZWQtYnk6IFBhbG1lciBEYWJi
ZWx0IDxwYWxtZXJAc2lmaXZlLmNvbT4NCj4gDQo+IElJUkMgdGhlcmUgd2FzIHN1cHBvc2VkIHRv
IGJlIGEgZm9sbG93LXVwIHRvIHlvdXIgUUVNVSBwYXRjaCBzZXQgdG8gcmViYXNlDQo+IGl0IG9u
IHRvcCBvZiBhIHJlZmFjdG9yaW5nIG9mIHRoZWlyIFJUQyBjb2RlLCBidXQgSSBkb24ndCBzZWUg
aXQgaW4gbXkgaW5ib3guICBMTUsNCj4gaWYgSSBtaXNzZWQgaXQsIGFzIFFFTVUncyBzb2Z0IGZy
ZWV6ZSBpcyBpbiBhIGZldyB3ZWVrcyBhbmQgSSdkIGxpa2UgdG8gbWFrZQ0KPiBzdXJlIEkgZ2V0
IGV2ZXJ5dGhpbmcgaW4uDQoNCkkgd2FzIGhvcGluZyBmb3IgUUVNVSBSVEMgcmVmYWN0b3Jpbmcg
dG8gYmUgbWVyZ2VkIHNvb24gYnV0IGl0IGhhcyBub3QNCmhhcHBlbmVkIHNvIGZhci4gSSB3aWxs
IHdhaXQgY291cGxlIG9mIG1vcmUgZGF5cyB0aGVuIHNlbmQgdjMgb2YgUUVNVQ0KcGF0Y2hlcy4N
Cg0KPiANCj4gQWRkaXRpb25hbGx5OiB3ZSBzaG91bGQgcmVmYWN0b3Igb3VyIEtjb25maWcgdG8g
aGF2ZSBzb21lIHNvcnQgb2YNCj4gQ09ORklHX1NPQ19WSVJUIHRoYXQgc2VsZWN0cyB0aGlzIHN0
dWZmLCBsaWtlIHdlIGhhdmUgdGhlDQo+IENPTkZJR19TT0NfU0lGSVZFLg0KPiBUaGlzIHdpbGwg
ZXhwbGljaXRseSBkb2N1bWVudCB3aHkgZGV2aWNlcyBhcmUgaW4gdGhlIGRlZmNvbmZpZywgYXZv
aWQNCj4gZHVwbGljYXRpbmcgYSBidW5jaCBvZiBzdHVmZiBiZXR3ZWVuIGRlZmNvbmZpZ3MsIGFu
ZCBwcm92aWRlIGFuIGV4YW1wbGUgb2YNCj4gaG93IHdlIHN1cHBvcnQgbXVsdGlwbGUgU09DcyBp
biBhIHNpbmdsZSBpbWFnZS4NCg0KWWVzLCBpbmRlZWQgd2UgbmVlZCBDT05GSUdfU09DX1ZJUlQg
YnV0IHRoaXMgd2lsbCBiZSBhIHNlcGFyYXRlIHBhdGNoLg0KDQo+IA0KPiBJIGRvbid0IHNlZSB3
aHkgZWl0aGVyIG9mIHRoZXNlIHNob3VsZCBibG9jayBtZXJnaW5nIHRoZSBwYXRjaCwgdGhvdWdo
Lg0KDQpUaGFua3MsDQpBbnVwDQo=
