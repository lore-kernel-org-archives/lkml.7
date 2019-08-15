Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7126C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5912083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D49soO4P";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qUVdzeOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbfHOUZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:25:29 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:32575 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbfHOUZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565900792; x=1597436792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IIXBmwrTo9THGRGqlfBdgwxU0Uv09lk7EJuWmb7E+kU=;
  b=D49soO4PZI+H3DKLGaa2JV17b2+1qCu461Rj72ATFT/pWD/IpPtAj3yZ
   TDnyUqYqdykgxk1oG/G8GEGQj5u3QrYXOMR6mYkT6UnMx1ggsXgFWCDUV
   j0gOQYNdM1Tda0gOoeua/eUJoV1GVjldBwhDC4aqAgsDj6/wHdWkGguR3
   uiqW7Lqg0pIHtn/VGsFxh7pjlVvFi9GzgI/Z0F0ZpGBF/ore7aKKaywhs
   VTUgZZbALmpgtDvp7Pauc59ujT6SeX8qHeE6y44cZ3aU4TFiyJeYqVTlL
   gfVRRkVj08/AsRAX7+WvmLEXFQ6kJ8jCN2F2jY+WrXiCEJtgrnhesRQ5i
   A==;
IronPort-SDR: Zp1hzwBmTPAD+i+dAR9uwsIIA3SVIJIem/cH2fx7MZe+WTwuW2s/J02iijEmwtB2u0219kDdRb
 ugUcrf3VQwYmgtva7kJVvadNdXGQtE53LAicJ3wOVmG8+z5OPeGlbbJ1cXD6Vl/UhIX69tbnT4
 +zbe99SXDmqWYwnUPTba+ZC57KIKXrJy/Ksy9dbZ/JsLyex7H3YTETGd1v8hWVtX66PavpHGwG
 zpwrtqMOyG2whFSIo0EHcYQb3eCJwbR41KFZBDTSgeHUpu8Jxkebu40MoqiVQwNh4+wRZ7YDLw
 Shc=
X-IronPort-AV: E=Sophos;i="5.64,389,1559491200"; 
   d="scan'208";a="216299069"
Received: from mail-dm3nam05lp2056.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.56])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2019 04:26:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZv6j6BhyNK/m9YlY50RQtIInBFfNeKDS4bMAcsqhYoZJORZ+9tGQRUgxiu5joUnKcpMU2vtDR6s7+yT6HhWYrlMgxF6goiF8Fw94PoOZnBcdahx87ocZ+o7bHNTHGliKw3Sjq3OXslPTB79+4rEqVu+JvRjlBzyqhSz7mkYItASw0QDBwD36yq07pgLcOMl9L2piBv/EdqybtC8p40YHAVlhV5veCnOYQY4q1k287yE3H60iOSnM0R029UE2Ndz64QFOSPbQe80nSjlpLMpSq40qZ8ISGorWn5/biezkiTnj85o2zsqDdgBN4e05fF0G3d0md00NVkjS3dER5BxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIXBmwrTo9THGRGqlfBdgwxU0Uv09lk7EJuWmb7E+kU=;
 b=P5Z9drufz+m3QSFHr6tkNVZVQB7YbxqyO3nctK+hmsb6w+uEYMarcJTGOQ91yJLEXLihc6syzgo+gRdT3GCKf+x0RE0FxEryyoj9Q5yOF/Iav/Ru1CWg0UEOcwaNuCTmUj1qo4xYdnoiqqT6hpdlEDfEV+mU7a4RWqKblAyJWWh9azXead0KVWltkiyJRTel/LTNJ/+L0jN+XJ0cJMXObTddIEv9wdB9xtRjAy27McAGQq4PvG0lLad6wsJQzvJTEiRATXynlLKLnonM5R6qtd8PdLoYEIMPhLtNav+h0HhzIeIk/yogFsLX2KNxgtqFN3qm2Z8i9rNQ6oUBNjWIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIXBmwrTo9THGRGqlfBdgwxU0Uv09lk7EJuWmb7E+kU=;
 b=qUVdzeOFlUJDKfzNpKSbuttqGLoEJCSGvRnqYC4REYwDujUtMKGupn4WCgz7UqcQjvtJGChntS/lgN81RJom36kwaB5gy+/Wrh/yU/gEvBsWTk/iPPUsxOg366xP9tWAAktpOvqlcum3DcBxLZ4XvokedgW7uBwgE3dc4Jn3smU=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB5624.namprd04.prod.outlook.com (20.179.56.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Thu, 15 Aug 2019 20:25:26 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::702b:2326:3cee:c07a]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::702b:2326:3cee:c07a%2]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 20:25:26 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "david.abdurachmanov@gmail.com" <david.abdurachmanov@gmail.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [PATCH v5 2/2] RISC-V: Setup initial page tables in two stages
Thread-Topic: [PATCH v5 2/2] RISC-V: Setup initial page tables in two stages
Thread-Index: AQHVN3xcQ1Fn35uAxU+uy0ugjEz8uab8xqoAgAADpYCAABTkgA==
Date:   Thu, 15 Aug 2019 20:25:25 +0000
Message-ID: <77df4a6244ccfabd02757db4a5a5ce5aaa4e7ae8.camel@wdc.com>
References: <20190607060049.29257-1-anup.patel@wdc.com>
         <20190607060049.29257-3-anup.patel@wdc.com>
         <alpine.DEB.2.21.9999.1907101703150.3422@viisi.sifive.com>
         <847fb8c879bbd2c3fd41dc1e428b3217253acebb.camel@wdc.com>
         <CAEn-LTpz_iL0Ts5GG9J6oESN76DcjBaNs-Oz-c9CcpbmRiN5Sw@mail.gmail.com>
In-Reply-To: <CAEn-LTpz_iL0Ts5GG9J6oESN76DcjBaNs-Oz-c9CcpbmRiN5Sw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 793d2ec0-26c2-44b3-2cd5-08d721beb4fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5624;
x-ms-traffictypediagnostic: BYAPR04MB5624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5624EED53C7B62F43E359E8090AC0@BYAPR04MB5624.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(199004)(189003)(36756003)(25786009)(76176011)(8936002)(118296001)(86362001)(5640700003)(7736002)(6486002)(4326008)(6436002)(45080400002)(1361003)(2501003)(14454004)(305945005)(316002)(14444005)(54906003)(6512007)(229853002)(256004)(2906002)(99286004)(53936002)(478600001)(8676002)(26005)(81166006)(6116002)(3846002)(6246003)(6916009)(66476007)(486006)(66556008)(64756008)(66946007)(66446008)(6506007)(53546011)(476003)(186003)(2616005)(11346002)(5660300002)(102836004)(446003)(2351001)(71190400001)(71200400001)(66066001)(81156014)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5624;H:BYAPR04MB4901.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9zAroYNfvRHbKBIHn9XIymmsbWkgU0KbdHqTmEMHLjsLS+PYdq+z82CQZT8s8nriUj3EeeLIAJemuF3tlETT4mhhIG7c2+M4mYax6UPS4igJb7LedoQZb8G3SiFKe47AdsrYqORlcBG9OsxL2tElyAewcqqTK5ImiPGfAQU4cKAz1ZM8/dWqGMPgyv+AELKwNFnigQwvfCyTzEuhg2cFgDFAAu0ci/eZMVrxDBcN3ZJ5NybS8+OBApyRSopDmKykDj6xRi/7h+8COULeS4cTVbRzNJd2QZCfJB1uDxmWMwaerU2TL1YONjVpK2o3FsMm1SWAClKq5gyvo8Ag2oGpez5Zc0Lzwm9VnKudJDeC4o4dQf15QgaiNLEs/pwO3ec1HA2AsXsCNrnKpfpgS9b+RYm6nXqJF3QPy3okiPRTYVM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55CC412753E34E4C93C5F33ACF043B53@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793d2ec0-26c2-44b3-2cd5-08d721beb4fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 20:25:25.8732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMvLI0FMf9w52KI4Rb3PTWtgzq7GtrbGj45awoZ887cpa2kkw7C6WR9W7+Sie0etZRmg5i3GCIHlG3HkP1a+Coi4qp7xmHNnx88rqXhugU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5624
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTE1IGF0IDEyOjA3IC0wNzAwLCBEYXZpZCBBYmR1cmFjaG1hbm92IHdy
b3RlOg0KPiBPbiBUaHUsIEF1ZyAxNSwgMjAxOSBhdCAxMTo1NyBBTSBBbGlzdGFpciBGcmFuY2lz
DQo+IDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAxOS0w
Ny0xMCBhdCAxNzowNSAtMDcwMCwgUGF1bCBXYWxtc2xleSB3cm90ZToNCj4gPiA+IE9uIEZyaSwg
NyBKdW4gMjAxOSwgQW51cCBQYXRlbCB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBDdXJyZW50bHks
IHRoZSBzZXR1cF92bSgpIGRvZXMgaW5pdGlhbCBwYWdlIHRhYmxlIHNldHVwIGluIG9uZS0NCj4g
PiA+ID4gc2hvdA0KPiA+ID4gPiB2ZXJ5IGVhcmx5IGJlZm9yZSBlbmFibGluZyBNTVUuIER1ZSB0
byB0aGlzLCB0aGUgc2V0dXBfdm0oKSBoYXMNCj4gPiA+ID4gdG8NCj4gPiA+ID4gbWFwDQo+ID4g
PiA+IGFsbCBwb3NzaWJsZSBrZXJuZWwgdmlydHVhbCBhZGRyZXNzZXMgc2luY2UgaXQgZG9lcyBu
b3Qga25vdw0KPiA+ID4gPiBzaXplDQo+ID4gPiA+IGFuZA0KPiA+ID4gPiBsb2NhdGlvbiBvZiBS
QU0uIFRoaXMgbWVhbnMgd2UgaGF2ZSBrZXJuZWwgbWFwcGluZ3MgZm9yIG5vbi0NCj4gPiA+ID4g
ZXhpc3RlbnQNCj4gPiA+ID4gUkFNIGFuZCBhbnkgYnVnZ3kgZHJpdmVyIChvciBrZXJuZWwpIGNv
ZGUgZG9pbmcgb3V0LW9mLWJvdW5kDQo+ID4gPiA+IGFjY2Vzcw0KPiA+ID4gPiB0byBSQU0gd2ls
bCBub3QgZmF1bHQgYW5kIGNhdXNlIHVuZGVydGVybWluaXN0aWMgYmVoYXZpb3VyLg0KPiA+ID4g
PiANCj4gPiA+ID4gRnVydGhlciwgdGhlIHNldHVwX3ZtKCkgY3JlYXRlcyBQTUQgbWFwcGluZ3Mg
KGkuZS4gMk0gbWFwcGluZ3MpDQo+ID4gPiA+IGZvcg0KPiA+ID4gPiBSVjY0IHN5c3RlbXMuIFRo
aXMgbWVhbnMgZm9yIFBBR0VfT0ZGU0VUPTB4ZmZmZmZmZTAwMDAwMDAwMA0KPiA+ID4gPiAoaS5l
Lg0KPiA+ID4gPiBNQVhQSFlTTUVNXzEyOEdCPXkpLCB0aGUgc2V0dXBfdm0oKSB3aWxsIHJlcXVp
cmUgMTI5IHBhZ2VzDQo+ID4gPiA+IChpLmUuDQo+ID4gPiA+IDUxNiBLQikgb2YgbWVtb3J5IGZv
ciBpbml0aWFsIHBhZ2UgdGFibGVzIHdoaWNoIGlzIG5ldmVyIGZyZWVkLg0KPiA+ID4gPiBUaGUN
Cj4gPiA+ID4gbWVtb3J5IHJlcXVpcmVkIGZvciBpbml0aWFsIHBhZ2UgdGFibGVzIHdpbGwgZnVy
dGhlciBpbmNyZWFzZQ0KPiA+ID4gPiBpZg0KPiA+ID4gPiB3ZSBjaG9zZSBhIGxvd2VyIHZhbHVl
IG9mIFBBR0VfT0ZGU0VUIChlLmcuIDB4ZmZmZmZmMDAwMDAwMDAwMCkNCj4gPiA+ID4gDQo+ID4g
PiA+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyB0d28tc3RhZ2VkIGluaXRpYWwgcGFnZSB0YWJsZSBz
ZXR1cCwgYXMNCj4gPiA+ID4gZm9sbG93czoNCj4gPiA+ID4gMS4gRWFybHkgKGkuZS4gc2V0dXBf
dm0oKSk6IFRoaXMgc3RhZ2UgbWFwcyBrZXJuZWwgaW1hZ2UgYW5kDQo+ID4gPiA+IERUQiBpbg0K
PiA+ID4gPiBhIGVhcmx5IHBhZ2UgdGFibGUgKGkuZS4gZWFybHlfcGdfZGlyKS4gVGhlIGVhcmx5
X3BnX2RpciB3aWxsDQo+ID4gPiA+IGJlDQo+ID4gPiA+IHVzZWQNCj4gPiA+ID4gb25seSBieSBi
b290IEhBUlQgc28gaXQgY2FuIGJlIGZyZWVkIGFzLXBhcnQgb2YgaW5pdCBtZW1vcnkNCj4gPiA+
ID4gZnJlZS0NCj4gPiA+ID4gdXAuDQo+ID4gPiA+IDIuIEZpbmFsIChpLmUuIHNldHVwX3ZtX2Zp
bmFsKCkpOiBUaGlzIHN0YWdlIG1hcHMgYWxsIHBvc3NpYmxlDQo+ID4gPiA+IFJBTQ0KPiA+ID4g
PiBiYW5rcyBpbiB0aGUgZmluYWwgcGFnZSB0YWJsZSAoaS5lLiBzd2FwcGVyX3BnX2RpcikuIFRo
ZSBib290DQo+ID4gPiA+IEhBUlQNCj4gPiA+ID4gd2lsbCBzdGFydCB1c2luZyBzd2FwcGVyX3Bn
X2RpciBhdCB0aGUgZW5kIG9mIHNldHVwX3ZtX2ZpbmFsKCkuDQo+ID4gPiA+IEFsbA0KPiA+ID4g
PiBub24tYm9vdCBIQVJUcyBkaXJlY3RseSB1c2UgdGhlIHN3YXBwZXJfcGdfZGlyIGNyZWF0ZWQg
YnkgYm9vdA0KPiA+ID4gPiBIQVJULg0KPiA+ID4gPiANCj4gPiA+ID4gV2UgaGF2ZSBmb2xsb3dp
bmcgYWR2YW50YWdlcyB3aXRoIHRoaXMgbmV3IGFwcHJvYWNoOg0KPiA+ID4gPiAxLiBLZXJuZWwg
bWFwcGluZ3MgZm9yIG5vbi1leGlzdGVudCBSQU0gZG9uJ3QgZXhpc3RzIGFueW1vcmUuDQo+ID4g
PiA+IDIuIE1lbW9yeSBjb25zdW1lZCBieSBpbml0aWFsIHBhZ2UgdGFibGVzIGlzIG5vdyBpbmRw
ZW5kZW50IG9mDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBjaG9zZW4gUEFHRV9PRkZTRVQuDQo+ID4g
PiA+IDMuIE1lbW9yeSBjb25zdW1lZCBieSBpbml0aWFsIHBhZ2UgdGFibGVzIG9uIFJWNjQgc3lz
dGVtIGlzIDINCj4gPiA+ID4gcGFnZXMNCj4gPiA+ID4gKGkuZS4gOCBLQikgd2hpY2ggaGFzIHNp
Z25pZmljYW50bHkgcmVkdWNlZCBhbmQgdGhlc2UgcGFnZXMNCj4gPiA+ID4gd2lsbCBiZQ0KPiA+
ID4gPiBmcmVlZCBhcy1wYXJ0IG9mIHRoZSBpbml0IG1lbW9yeSBmcmVlLXVwLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gVGhlIHBhdGNoIGFsc28gcHJvdmlkZXMgYSBmb3VuZGF0aW9uIGZvciBpbXBsZW1l
bnRpbmcgc3RyaWN0DQo+ID4gPiA+IGtlcm5lbA0KPiA+ID4gPiBtYXBwaW5ncyB3aGVyZSB3ZSBw
cm90ZWN0IGtlcm5lbCB0ZXh0IGFuZCByb2RhdGEgdXNpbmcgUFRFDQo+ID4gPiA+IHBlcm1pc3Np
b25zLg0KPiA+ID4gPiANCj4gPiA+ID4gU3VnZ2VzdGVkLWJ5OiBNaWtlIFJhcG9wb3J0IDxycHB0
QGxpbnV4LmlibS5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFudXAgUGF0ZWwgPGFudXAu
cGF0ZWxAd2RjLmNvbT4NCj4gPiA+IA0KPiA+ID4gVGhhbmtzLCB1cGRhdGVkIHRvIGFwcGx5IGFu
ZCB0byBmaXggYSBjaGVja3BhdGNoIHdhcm5pbmcsIGFuZA0KPiA+ID4gcXVldWVkLg0KPiA+ID4g
DQo+ID4gPiBUaGlzIG1heSBub3QgbWFrZSBpdCBpbiBmb3IgdjUuMy1yYzE7IGlmIG5vdCwgd2Un
bGwgc3VibWl0IGl0DQo+ID4gPiBsYXRlci4NCj4gPiANCj4gPiBJJ20gc2VlaW5nIHRoaXMgZmFp
bHVyZSBvbiBSVjMyIHdoaWNoIEkgYmlzZWN0ZWQgdG8gdGhpcyBwYXRjaDoNCj4gPiANCj4gPiBb
ICAgIDEuODIwNDYxXSBzeXN0ZW1kWzFdOiBzeXN0ZW1kIDI0Mi0xOS1nZGIyZTM2NysgcnVubmlu
ZyBpbg0KPiA+IHN5c3RlbQ0KPiA+IG1vZGUuICgtUEFNIC1BVURJVCAtU0VMSU5VWCArSU1BIC1B
UFBBUk1PUiArU01BQ0sgK1NZU1ZJTklUICtVVE1QDQo+ID4gLUxJQkNSWVBUU0VUVVAgLUdDUllQ
VCAtR05VVExTICtBQ0wgK1haIC1MWjQgLVNFQ0NPTVAgK0JMS0lEDQo+ID4gLUVMRlVUSUxTDQo+
ID4gK0tNT0QgLUlETjIgLUlETiAtUENSRTIgZGVmYXVsdC1oaWVyYXJjaHk9aHlicmlkKQ0KPiA+
IFsgICAgMS44MjQzMjBdIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0
IHZpcnR1YWwNCj4gPiBhZGRyZXNzIDlmZjAwYzE1DQo+ID4gWyAgICAxLjgyNDk3M10gT29wcyBb
IzFdDQo+ID4gWyAgICAxLjgyNTE2Ml0gTW9kdWxlcyBsaW5rZWQgaW46DQo+ID4gWyAgICAxLjgy
NTUzNl0gQ1BVOiAwIFBJRDogMSBDb21tOiBzeXN0ZW1kIE5vdCB0YWludGVkIDUuMi4wLXJjNyAj
MQ0KPiA+IFsgICAgMS44MjYwMzldIHNlcGM6IGMwNWMzYzc4IHJhIDogYzA0YjVhNzQgc3AgOiBk
ZjA0N2NlMA0KPiA+IFsgICAgMS44MjY1MTRdICBncCA6IGMwN2ExMDM4IHRwIDogZGYwNGMwMDAg
dDAgOiAwMDAwMDBmYw0KPiA+IFsgICAgMS44MjY5MTldICB0MSA6IDAwMDAwMDAyIHQyIDogMDAw
MDAzZWYgczAgOiBkZjA0N2NmMA0KPiA+IFsgICAgMS44MjczMjJdICBzMSA6IGRmNzA5MGY4IGEw
IDogOWZmMDBjMTUgYTEgOiBjMDcyMTY2Yw0KPiA+IFsgICAgMS44Mjc3MjNdICBhMiA6IDAwMDAw
MDAwIGEzIDogMDAwMDAwMDEgYTQgOiAwMDAwMDAwMQ0KPiA+IFsgICAgMS44MjgxMDRdICBhNSA6
IGRmNmY4MTM4IGE2IDogMDAwMDAwMmYgYTcgOiBkZTYyYTAwMA0KPiA+IFsgICAgMS44Mjg1MzRd
ICBzMiA6IGMwNzIxNjZjIHMzIDogMDAwMDAwMDAgczQgOiAwMDAwMDAwMA0KPiA+IFsgICAgMS44
Mjg5MzFdICBzNSA6IGMwN2EyMDAwIHM2IDogMDA0MDBjYzAgczcgOiAwMDAwMDQwMA0KPiA+IFsg
ICAgMS44MjkzMTldICBzOCA6IGRlNDkxMDE4IHM5IDogMDAwMDAwMDAgczEwOiBmZmZmZjAwMA0K
PiA+IFsgICAgMS44Mjk3MDJdICBzMTE6IGRlNDkxMDMwIHQzIDogZGU2MmIwMDAgdDQgOiAwMDAw
MDAwMA0KPiA+IFsgICAgMS44MzAwOTBdICB0NSA6IDAwMDAwMDAwIHQ2IDogMDAwMDAwODANCj4g
PiBbICAgIDEuODMwMzkyXSBzc3RhdHVzOiAwMDAwMDEwMCBzYmFkYWRkcjogOWZmMDBjMTUgc2Nh
dXNlOg0KPiA+IDAwMDAwMDBkDQo+ID4gWyAgICAxLjgzMTYxNl0gLS0tWyBlbmQgdHJhY2UgNDlh
OTI2YTFhNTMwMGMwMCBdLS0tDQo+ID4gWyAgICAxLjgzNTc3Nl0gS2VybmVsIHBhbmljIC0gbm90
IHN5bmNpbmc6IEF0dGVtcHRlZCB0byBraWxsIGluaXQhDQo+ID4gZXhpdGNvZGU9MHgwMDAwMDAw
Yg0KPiA+IFsgICAgMS44MzY1NzVdIC0tLVsgZW5kIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5n
OiBBdHRlbXB0ZWQgdG8NCj4gPiBraWxsDQo+ID4gaW5pdCEgZXhpdGNvZGU9MHgwMDAwMDAwYiBd
LS0tDQo+ID4gDQo+ID4gRG9lcyBhbnlvbmUgZWxzZSBzZWUgdGhpcz8NCj4gPiANCj4gPiBBIHNp
bXBsZSByZXZlcnQgb2YgdGhpcyBwYXRjaCBvbiA1LjMtcmM0IGZpeGVzIHRoZSBpc3N1ZSBmb3Ig
bWUuDQo+IA0KPiBZZXMsIEkgZG8gc2VlIHRob3NlIGluIEZlZG9yYS9SSVNDViBidWlsZCBmYXJt
IGV2ZXJ5IG1vcm5pbmcsIGJ1dA0KPiB3aXRoDQo+IHJpc2N2NjQgYW5kIDUuMi4wLXJjNyBrZXJu
ZWwuDQo+IA0KPiBZb3UgYWxzbyBzZWVtIHRvIHJ1biA1LjIuMC1yYzcga2VybmVsLg0KDQpUaGF0
IGlzIGp1c3QgYSBjb3B5IGVycm9yIGFzIEkgY29waWVkIHRoZSBsb2cgZnJvbSBteSBiaXNlY3Qg
dG8gcGFzdGUNCml0IGludG8gbXkgY29tbWl0LiBJIGNhbiByZXByb2R1Y2UgdGhpcyBvbiA1LjMt
cmM0IGFzIHdlbGwuDQoNCkFsaXN0YWlyDQoNCj4gDQo+IGZlZG9yYS1yaXNjdi00IGxvZ2luOiBb
MTc4ODc2LjQwNjEyMl0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nDQo+IHJlcXVlc3Qg
YXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMTJhMjgNCj4gZmVkb3JhLXJpc2N2LTcgbG9n
aW46IFsxNzk4My4wNzQ4NDddIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZw0KPiByZXF1
ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyAwZmZmZmZkZmY1ZTE0NzAwDQo+IA0KPiBkYXZpZA0K
