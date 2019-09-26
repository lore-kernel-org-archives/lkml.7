Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604E6C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9FC21A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="Yg4UFUHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfIZLQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:16:52 -0400
Received: from mail-eopbgr140075.outbound.protection.outlook.com ([40.107.14.75]:55662
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbfIZLQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:16:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFSvtQkvFExxbJtXiM4VpIUkePG0c/H4k19/NvY5wRZASSBhgWbNup3rio211QJ5e9IGoXLG3iqdkx+ZSyd9lOJiq6lBEB3JcZMQxRjhU1SLucThM70y1cIY5p6dOFBE165UHJE7GQyWU6hsnCrua9b0IDmps88ln5Fs8Io3Go7v2jcIkpZx9960bcQj4dqnHYLyNhx+zbO2fyJDbpfiFybs+NJIEhlS6wHMuEgNuureF1kXthdiW1rUB8DNyH2GjCzuZfx9MM83zeHnTJIhY6vIewJY57AgfAEDD/qcgST4t5iFhZjX8x2XCo/uzEOM7TC8rW+/rXeWBGLkgneZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISxund8ZLkCm9KPxkGZUMFADQwJSZft4ADgIcincfr0=;
 b=Nn9uqv17nJmuva+BpA+YXQo3qGYcASpGCMa42jipoWWmThL4MSZmMTyXWR+YVTiavDgkXLUrYbGJZd3Uj2jie4y4krRb1Jwk17S//ZG6RDB6ulFVRi5kn9U02wApXnx2KasJWGXtQbUQnJHwJ1F0L0yyymvoHtKgvim0wxwUnKZNDerZQ/IaYxxpIMtG2NldKsyksU7UUWTJeVQy/yziWYjfjyft6jIgH5PACe/BI4f5iZW6S5xIQt7db3X79iAgP5fnqEesWC8+FBgLMZS6FJHg6uxFaCoyyH+bQgGyqwspTIk1TOcffXcOZGy+5qR9ilhxJGBjOlQRfEssziosJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISxund8ZLkCm9KPxkGZUMFADQwJSZft4ADgIcincfr0=;
 b=Yg4UFUHd6Z7wtnMe1LjCLxRrWu0eLVo/McAIZhRESsIwWCubwL1EUD3PoImf5XvXPVvQc9lsu4f0oFy74kXKMtgFV/RRMSC/etj5in0LBVlXQ9Pb2EHPgB0sldAg5i/p7LdD4H/z/+TKp8EYHQXor1ofr8Cv40imS0vmzbfN+JU=
Received: from AM6PR03MB5958.eurprd03.prod.outlook.com (10.255.122.93) by
 AM6PR03MB4214.eurprd03.prod.outlook.com (20.177.33.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 11:16:46 +0000
Received: from AM6PR03MB5958.eurprd03.prod.outlook.com
 ([fe80::f9b6:8b16:c5a6:6f47]) by AM6PR03MB5958.eurprd03.prod.outlook.com
 ([fe80::f9b6:8b16:c5a6:6f47%7]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 11:16:46 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Rob Herring <robh@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [RFC PATCH] xen/gntdev: Stop abusing DT of_dma_configure API
Thread-Topic: [RFC PATCH] xen/gntdev: Stop abusing DT of_dma_configure API
Thread-Index: AQHVc+s0RRpCCJNN+0uv/ZIcTqnc7ac9t66AgAAHl4CAAAgUAIAACJOA
Date:   Thu, 26 Sep 2019 11:16:46 +0000
Message-ID: <f63f55eb-969e-6364-5781-a227d0c04e4c@epam.com>
References: <20190925215006.12056-1-robh@kernel.org>
 <e898c025-32a7-1d2c-3501-c99556f7cdd4@arm.com>
 <1ae7f42e-bf93-b335-b543-653fae5cf49f@epam.com>
 <28440326-ed76-b014-c1b8-02125c3214b9@arm.com>
In-Reply-To: <28440326-ed76-b014-c1b8-02125c3214b9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5356575a-0902-4d1f-c652-08d742730501
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR03MB4214;
x-ms-traffictypediagnostic: AM6PR03MB4214:
x-microsoft-antispam-prvs: <AM6PR03MB42142DD698FBEDB5568A36BCE7860@AM6PR03MB4214.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(54014002)(189003)(199004)(26005)(64756008)(8936002)(55236004)(6116002)(186003)(66066001)(305945005)(53546011)(478600001)(476003)(446003)(6512007)(66556008)(7736002)(80792005)(71200400001)(2906002)(31696002)(31686004)(316002)(14444005)(71190400001)(81166006)(6506007)(25786009)(86362001)(110136005)(486006)(66446008)(8676002)(91956017)(66476007)(7416002)(54906003)(66946007)(76116006)(11346002)(4326008)(229853002)(6246003)(14454004)(36756003)(5660300002)(6486002)(2616005)(81156014)(6436002)(99286004)(102836004)(76176011)(256004)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4214;H:AM6PR03MB5958.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 10bKE6HSyNlXq9JLg7FxLu0fhRK69MjfmsxgZjCULHNPDCB2CdAse/Obv/p4apNRrCy+gz9tomDIpbqAAy/92tZSJRxa8IPCZVbPe/10TUbOlRGcRKrO3yVmF3ZXDTp+0NTFoQgVnTksXQi5X95LFyRpA2n2PoiTEvL0MIsGnK0jGxcEyWlIcfBB5SgUjKWgyVKwxxaa0MO4ViT3YYC8hVzR+oDgJBIqGrhgPgiT2bqbF37HItfpsrqjShpzF2bNbhGF8JKM65eX5htfwI05jmIymlMSsLmbh5cBhcL9h54pJB4cOpAQur+Sm5/wvjtki7IcZz8FDl2bLLcs1BFgDzdQ4UEz38J0g4Wd1GEpexfFbBe3SLS3uZ07uDBUoBK/FmS6SVtn05uAEc9n3707aEKIvZxA0/PK9OEY1whwBHY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F21642236F6806428AA2061BCDF3F298@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5356575a-0902-4d1f-c652-08d742730501
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 11:16:46.6670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2Y93KnpWgxu4qbGMHTxr2UpXZFruD3OVTN1uAn7NyNNBCDTrXquuZmPj72He/sijugdQ1OEx+5A/R7ZSDVbwMga1YXdiFCCPmWpwnHpxbpNiu10ODip2PCNgudYq5Ni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yNi8xOSAxOjQ2IFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+IE9uIDIwMTktMDktMjYg
MTE6MTcgYW0sIE9sZWtzYW5kciBBbmRydXNoY2hlbmtvIHdyb3RlOg0KPj4NCj4+IE9uIDkvMjYv
MTkgMTI6NDkgUE0sIEp1bGllbiBHcmFsbCB3cm90ZToNCj4+PiBIaSBSb2IsDQo+Pj4NCj4+Pg0K
Pj4+IE9uIDkvMjUvMTkgMTA6NTAgUE0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPj4+PiBBcyB0aGUg
Y29tbWVudCBzYXlzLCB0aGlzIGlzbid0IGEgRFQgYmFzZWQgZGV2aWNlLiBvZl9kbWFfY29uZmln
dXJlKCkNCj4+Pj4gaXMgZ29pbmcgdG8gc3RvcCBhbGxvd2luZyBhIE5VTEwgRFQgbm9kZSwgc28g
dGhpcyBuZWVkcyB0byBiZSBmaXhlZC4NCj4+Pg0KPj4+IEFuZCB0aGlzIGNhbid0IHdvcmsgb24g
YXJjaCBub3Qgc2VsZWN0aW5nIENPTkZJR19PRiBhbmQgY2FuIHNlbGVjdA0KPj4+IENPTkZJR19Y
RU5fR1JBTlRfRE1BX0FMTE9DLg0KPj4+DQo+Pj4gV2UgYXJlIGx1Y2t5IGVub3VnaCBvbiB4ODYg
YmVjYXVzZSwgQUZBSUNULCBhcmNoX3NldHVwX2RtYV9vcHMgaXMganVzdA0KPj4+IGEgbm9wLg0K
Pj4+DQo+PiBObyBsdWNrIGlzIG5lZWRlZCBhcyBbMV0gZG9lcyBub3RoaW5nIGZvciB0aG9zZSBw
bGF0Zm9ybXMgbm90IHVzaW5nDQo+PiBDT05GSUdfT0YNCj4+Pj4NCj4+Pj4gTm90IHN1cmUgZXhh
Y3RseSB3aGF0IHNldHVwIGJlc2lkZXMgYXJjaF9zZXR1cF9kbWFfb3BzIGlzIG5lZWRlZC4uLg0K
Pj4+DQo+Pj4gV2UgcHJvYmFibHkgd2FudCB0byB1cGRhdGUgZG1hX21hc2ssIGNvaGVyZW50X2Rt
YV9tYXNrIGFuZA0KPj4+IGRtYV9wZm5fb2Zmc2V0Lg0KPj4+DQo+Pj4gQWxzbywgd2hpbGUgbG9v
ayBhdCBvZl9jb25maWd1cmVfZG1hLCBJIG5vdGljZWQgdGhhdCB3ZSBjb25zaWRlciB0aGUNCj4+
PiBETUEgd2lsbCBub3QgYmUgY29oZXJlbnQgZm9yIHRoZSBncmFudC10YWJsZS4gT2xla3NhbmRy
LCBkbyB5b3Uga25vdw0KPj4+IHdoeSB0aGV5IGNhbid0IGJlIGNvaGVyZW50Pw0KPj4gVGhlIG1h
aW4gYW5kIHRoZSBvbmx5IHJlYXNvbiB0byB1c2Ugb2ZfY29uZmlndXJlX2RtYSBpcyB0aGF0IGlm
IHdlIGRvbid0DQo+PiB0aGVuIHdlDQo+PiBhcmUgYWJvdXQgdG8gc3RheSB3aXRoIGRtYV9kdW1t
eV9vcHMgWzJdLiBJdCBlZmZlY3RpdmVseSBtZWFucyB0aGF0DQo+PiBvcGVyYXRpb25zIG9uIGRt
YS1idWZzDQo+PiB3aWxsIGVuZCB1cCByZXR1cm5pbmcgZXJyb3JzLCBsaWtlIFszXSwgWzRdLCB0
aHVzIG5vdCBtYWtpbmcgaXQgcG9zc2libGUNCj4+IGZvciBYZW4gUFYgRFJNIGFuZCBETUENCj4+
IHBhcnQgb2YgZ250ZGV2IGRyaXZlciB0byBkbyB3aGF0IHdlIG5lZWQgKGRtYS1idWZzIGluIG91
ciB1c2UtY2FzZXMNCj4+IGFsbG93IHplcm8tY29weWluZw0KPj4gd2hpbGUgdXNpbmcgZ3JhcGhp
Y3MgYnVmZmVycyBhbmQgbWFueSBtb3JlKS4NCj4+DQo+PiBJIGRpZG4ndCBmaW5kIGFueSBiZXR0
ZXIgd2F5IG9mIGFjaGlldmluZyB0aGF0LCBidXQgb2ZfY29uZmlndXJlX2RtYS4uLg0KPj4gSWYg
dGhlcmUgaXMgYW55IGJldHRlciBzb2x1dGlvbiB3aGljaCB3aWxsIG5vdCBicmVhayB0aGUgZXhp
c3RpbmcNCj4+IGZ1bmN0aW9uYWxpdHkgdGhlbg0KPj4gSSB3aWxsIGRlZmluaXRlbHkgY2hhbmdl
IHRoZSBkcml2ZXJzIHNvIHdlIGRvIG5vdCBhYnVzZSBEVCApDQo+PiBCZWZvcmUgdGhhdCwgcGxl
YXNlIGtlZXAgaW4gbWluZCB0aGF0IG1lcmdpbmcgdGhpcyBSRkMgd2lsbCBicmVhayBYZW4gUFYN
Cj4+IERSTSArDQo+PiBETUEgYnVmIHN1cHBvcnQgaW4gZ250ZGV2Li4uDQo+PiBIb3BlIHdlIGNh
biB3b3JrIG91dCBzb21lIGFjY2VwdGFibGUgc29sdXRpb24sIHNvIGV2ZXJ5b25lIGlzIGhhcHB5
DQo+DQo+IEFzIEkgbWVudGlvbmVkIGVsc2V3aGVyZSwgdGhlIHJlY2VudCBkbWEtZGlyZWN0IHJl
d29yayBtZWFucyB0aGF0IA0KPiBkbWFfZHVtbXlfb3BzIGFyZSBub3cgb25seSBleHBsaWNpdGx5
IGluc3RhbGxlZCBmb3IgdGhlIEFDUEkgZXJyb3IgDQo+IGNhc2UsIHNvIC0gbXVjaCBhcyBJIG1h
eSBkaXNsaWtlIGl0IC0geW91IHNob3VsZCBnZXQgcmVndWxhciANCj4gKGRpcmVjdC9TV0lPVExC
KSBvcHMgYnkgZGVmYXVsdCBhZ2Fpbi4NCkFoLCBteSBiYWQsIEkgbWlzc2VkIHRoYXQgY2hhbmdl
LiBTbywgaWYgbm8gZHVtbXkgZG1hIG9wcyBhcmUgdG8gYmUgdXNlZCANCnRoZW4NCkkgYmVsaWV2
ZSB3ZSBjYW4gYXBwbHkgYm90aCBjaGFuZ2VzLCBlLmcuIHJlbW92ZSBvZl9kbWFfY29uZmlndXJl
IGZyb20gDQpib3RoIG9mIHRoZSBkcml2ZXJzLg0KPg0KPiBDb2hlcmVuY3kgaXMgdHJpY2tpZXIg
LSBpZiB0aGUgZ3Vlc3QgaXMgYWxsb2NhdGluZyBidWZmZXJzIGZvciB0aGUgUFYgDQo+IGRldmlj
ZSwgd2hpY2ggbWF5IGJlIHNoYXJlZCBkaXJlY3RseSB3aXRoIGhhcmR3YXJlIGJ5IHRoZSBob3N0
IGRyaXZlciwgDQo+IHRoZW4gdGhlIGNvaGVyZW5jeSBvZiB0aGUgUFYgZGV2aWNlIHNob3VsZCBy
ZWFsbHkgcmVmbGVjdCB0aGF0IG9mIHRoZSANCj4gdW5kZXJseWluZyBoYXJkd2FyZSB0byBhdm9p
ZCBwb3RlbnRpYWwgcHJvYmxlbXMuIFRoZXJlIGFyZSBzb21lIGNhc2VzIA0KPiB3aGVyZSB0aGUg
c3RhZ2UgMiBhdHRyaWJ1dGVzIGFsb25lIHdvdWxkbid0IGJlIGVub3VnaCB0byBjb3JyZWN0IGEg
DQo+IG1pc21hdGNoLg0KPg0KPiBSb2Jpbi4NClRoYW5rIHlvdSwNCk9sZWtzYW5kcg==
