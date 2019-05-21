Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A980C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2509621773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cr96dR/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfEULER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:04:17 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:59774
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727251AbfEULEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDM52TrHThP77ijg+n8fbhynIoUF2T9ddT0capVhIos=;
 b=Cr96dR/ff+p7dBekCjQZuph7rAByqCw/RxRWPSiXs4BV7GRGLwJKTvqcpmjWfz9+7gR+0D98dZyJ3Kmjbvdt9li/7NRXwap2xzgjBYPF/Pttd8XQOfuxKjBXGkYEkxuGXLUHqJrAagD7YfNneaQ6FCTtbjkiPc4Kz8eUhHNP9FQ=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB3262.eurprd04.prod.outlook.com (10.170.231.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 21 May 2019 11:04:12 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 11:04:12 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "noring@nocrew.org" <noring@nocrew.org>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: Re: [PATCH v4 1/3] USB: use genalloc for USB HCs with local memory
Thread-Topic: [PATCH v4 1/3] USB: use genalloc for USB HCs with local memory
Thread-Index: AQHVC917qUD5l71fnkeLasY+jBJde6Z1Q2GAgAAuuoA=
Date:   Tue, 21 May 2019 11:04:12 +0000
Message-ID: <e71c7f9d-2299-827d-821f-591e134f4a8f@nxp.com>
References: <20190516114721.27694-1-laurentiu.tudor@nxp.com>
 <20190516114721.27694-2-laurentiu.tudor@nxp.com>
 <20190521081657.GA10639@kroah.com>
In-Reply-To: <20190521081657.GA10639@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7314dd37-1266-49e3-f6d5-08d6dddc0e6a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3262;
x-ms-traffictypediagnostic: VI1PR04MB3262:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB32624C8A9985E5E7B5F23D39EC070@VI1PR04MB3262.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(396003)(346002)(199004)(189003)(476003)(2616005)(486006)(6512007)(6306002)(256004)(14444005)(6916009)(53546011)(6506007)(446003)(11346002)(8676002)(102836004)(81156014)(81166006)(8936002)(229853002)(36756003)(6486002)(31696002)(5660300002)(86362001)(71200400001)(71190400001)(6436002)(305945005)(7736002)(4326008)(66446008)(64756008)(66946007)(66476007)(478600001)(76116006)(316002)(73956011)(6116002)(3846002)(66556008)(91956017)(14454004)(68736007)(6246003)(45080400002)(76176011)(44832011)(31686004)(26005)(25786009)(966005)(53936002)(2906002)(66066001)(186003)(99286004)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3262;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y8lWGr7eyZC1aLIQ2LSm9yh4cFt5rz6UPS7gCmORt0OkvFhVmPefCZlPbRevE++8yfRQNRDSo8T4eFx2u3AMXj6A12vr6Ae3j3zC2C1fOjPZOEyc873w/aDZ7MQPLQ8/rfy9eV3Ouj5XNe6V+SZMxRp/Jgn48eczU2EtNJq/M8M/k00i5u/FTrdjtEHsuHcPUwyzgASNLqswdImhqei2VTrjADy/9Nx3Gm+ID5BdvMHvFqnDM6WndqTsLkvd7E+jhxhk+pfxwy+IcLnK+ESmH9UBT6nkrTMQgyU6l3brAIKDRPefEipELdy0f22q+HLoVAjMdrs/N7Rzx7J3gxM+yVTRRR4+uII7IEniJ8lp4YncJEgxTQmpe2nGyEnZZ3gmeaYyN1tdkkCbz3jUoAYv+mMH0XrtqiSvVxc7BxuEmWI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED71632D14E7E245BB97A0643D2A4976@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7314dd37-1266-49e3-f6d5-08d6dddc0e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 11:04:12.2839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIxLjA1LjIwMTkgMTE6MTYsIEdyZWcgS0ggd3JvdGU6DQo+IE9uIFRodSwgTWF5IDE2
LCAyMDE5IGF0IDAyOjQ3OjE5UE0gKzAzMDAsIGxhdXJlbnRpdS50dWRvckBueHAuY29tIHdyb3Rl
Og0KPj4gRnJvbTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCj4+
DQo+PiBGb3IgSENzIHRoYXQgaGF2ZSBsb2NhbCBtZW1vcnksIHJlcGxhY2UgdGhlIGN1cnJlbnQg
RE1BIEFQSSB1c2FnZQ0KPj4gd2l0aCBhIGdlbmFsbG9jIGdlbmVyaWMgYWxsb2NhdG9yIHRvIG1h
bmFnZSB0aGUgbWFwcGluZ3MgZm9yIHRoZXNlDQo+PiBkZXZpY2VzLg0KPj4gVGhpcyBpcyBpbiBw
cmVwYXJhdGlvbiBmb3IgZHJvcHBpbmcgdGhlIGV4aXN0aW5nICJjb2hlcmVudCIgZG1hDQo+PiBt
ZW0gZGVjbGFyYXRpb24gQVBJcy4gQ3VycmVudCBpbXBsZW1lbnRhdGlvbiB3YXMgcmVseWluZyBv
biBhIHNob3J0DQo+PiBjaXJjdWl0IGluIHRoZSBETUEgQVBJIHRoYXQgaW4gdGhlIGVuZCwgd2Fz
IGFjdGluZyBhcyBhbiBhbGxvY2F0b3INCj4+IGZvciB0aGVzZSB0eXBlIG9mIGRldmljZXMuDQo+
Pg0KPj4gRm9yIGNvbnRleHQsIHNlZSB0aHJlYWQgaGVyZTogaHR0cHM6Ly9ldXIwMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGttbC5vcmclMkZs
a21sJTJGMjAxOSUyRjQlMkYyMiUyRjM1NyZhbXA7ZGF0YT0wMiU3QzAxJTdDbGF1cmVudGl1LnR1
ZG9yJTQwbnhwLmNvbSU3Q2Y1MjQyZmIyOGQxNTRmZjk2NTMyMDhkNmRkYzRiNDFjJTdDNjg2ZWEx
ZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjk0MDIzNDIzNzUyNDQ5OSZh
bXA7c2RhdGE9S0VFVVAxS0glMkJhcmFXY1ZLb2dlWUJ6cmF1aCUyRkZUekdqU3hqayUyQnVOb3pq
QSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExhdXJlbnRpdSBUdWRv
ciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy91c2IvY29y
ZS9idWZmZXIuYyAgIHwgMTUgKysrKysrKysrKystLS0tDQo+PiAgIGRyaXZlcnMvdXNiL2hvc3Qv
b2hjaS1oY2QuYyB8IDIzICsrKysrKysrKysrKysrKysrKy0tLS0tDQo+PiAgIGluY2x1ZGUvbGlu
dXgvdXNiL2hjZC5oICAgICB8ICAzICsrKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDMyIGluc2Vy
dGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2NvcmUvYnVmZmVyLmMgYi9kcml2ZXJzL3VzYi9jb3JlL2J1ZmZlci5jDQo+PiBpbmRleCBmNjQx
MzQyY2RlYzAuLjIyYThmM2Y1Njc5YiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNiL2NvcmUv
YnVmZmVyLmMNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2NvcmUvYnVmZmVyLmMNCj4+IEBAIC0xNiw2
ICsxNiw3IEBADQo+PiAgICNpbmNsdWRlIDxsaW51eC9pby5oPg0KPj4gICAjaW5jbHVkZSA8bGlu
dXgvZG1hLW1hcHBpbmcuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L2RtYXBvb2wuaD4NCj4+ICsj
aW5jbHVkZSA8bGludXgvZ2VuYWxsb2MuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L3VzYi5oPg0K
Pj4gICAjaW5jbHVkZSA8bGludXgvdXNiL2hjZC5oPg0KPj4gICANCj4+IEBAIC0xMjQsMTAgKzEy
NSwxMiBAQCB2b2lkICpoY2RfYnVmZmVyX2FsbG9jKA0KPj4gICAJaWYgKHNpemUgPT0gMCkNCj4+
ICAgCQlyZXR1cm4gTlVMTDsNCj4+ICAgDQo+PiArCWlmIChoY2QtPmRyaXZlci0+ZmxhZ3MgJiBI
Q0RfTE9DQUxfTUVNKQ0KPj4gKwkJcmV0dXJuIGdlbl9wb29sX2RtYV9hbGxvYyhoY2QtPmxvY2Fs
bWVtX3Bvb2wsIHNpemUsIGRtYSk7DQo+IA0KPiBEb2VzIHRoaXMgcGF0Y2ggbm93IGJyZWFrIHRo
aW5ncz8gIGhjZC0+bG9jYWxtZW1fcG9vbCBhdCB0aGlzIHBvaW50IGluDQo+IHRpbWUgaXMgTlVM
TCwgc28gdGhpcyBjYWxsIHdpbGwgZmFpbC4gIFRoZXJlJ3Mgbm8gY2hhbmNlIGZvciBhbnkgaG9z
dA0KPiBjb250cm9sbGVyIGRyaXZlciB0byBhY3R1YWxseSBzZXQgdXAgdGhpcyBwb29sIGluIHRo
aXMgcGF0Y2gsIHNvIGlzDQo+IGJpc2VjdGlvbiBicm9rZW4/DQoNClVuZm9ydHVuYXRlbHksIHll
cy4gSSBjb3VsZCBsdW1wIHRoZSBwYXRjaGVzIHRvZ2V0aGVyIGJ1dCBJIHRoaW5rIA0KQ2hyaXN0
b3BoIHN1Z2dlc3Rpb24gaXMgbXVjaCBiZXR0ZXIuDQoNCj4gSSB0aGluayB5b3UgZml4IHRoaXMg
dXAgaW4gbGF0ZXIgcGF0Y2hlcywgcmlnaHQ/DQoNCkNvcnJlY3QuIFRoZSBsYXN0IDIgcGF0Y2hl
cyB1cGRhdGUgdGhlIGRyaXZlci4NCg0KPiBBbmQgaWYgc28sIHdoeSBkbyB3ZSBldmVuIG5lZWQg
SENEX0xPQ0FMX01FTSBhbnltb3JlPyAgQ2FuJ3Qgd2UganVzdA0KPiB0ZXN0IGZvciB0aGUgcHJl
c2VuY2Ugb2YgaGNkLT5sb2NhbG1lbV9wb29sIGluIG9yZGVyIHRvIGRldGVybWluZSB3aGljaA0K
PiBhbGxvY2F0aW9uIG1ldGhvZCB0byB1c2U/DQoNClN1cmUuIFRoZXJlIGFyZSBhIGZldyBtb3Jl
IHBsYWNlcyB0aGF0IG5lZWQgdXBkYXRlcyBidXQgbm8gYmlnIGRlYWwuDQoNCi0tLQ0KQmVzdCBS
ZWdhcmRzLCBMYXVyZW50aXU=
