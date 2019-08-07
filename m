Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176BDC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D9F21922
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="dA8HzeGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfHGGqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:46:54 -0400
Received: from mail-eopbgr60101.outbound.protection.outlook.com ([40.107.6.101]:28288
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727131AbfHGGqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:46:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dq55ERpr5E7dVIdgkLsmoBCOWnQWhI9TsdUxO2MYnbwvKcjUagK9ojBUy0H8ryh/ig2+Tv8e44+xJzb6+nOps2HSy3JwxFCkfyXiWN9VbIPN3fsKKXIhookthmfkFMDN81cLfbSF7/K+AYuBRK3XGa8uFWcTo6Tc6eHS8BVaO5vbKmGqOu3V2wEKuXFyBSNB7fw7QVJyaSVQ6LFhEM5LXij576QUxD52XZDqBiT2oh/hDv6gIttmtZ3o+WQlY7GfCIi4qlWLCgsmLGFpJNWAfDkoiCCZ5ZIbTAlvDT12Zje8z5Ih5IHcw5EdYM0QKJnhEUt50gXZkg9jHEYKeV4CXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRb0/UVStJRoG0pO64qRA6p7Y60j66rEw6ObqEw4mSc=;
 b=VimQMxRB+R7YAe/k9scKfIyviG4yDZPqe7VLzVKdpIMMTkHwO4vNaNKzLmYcEXrx2TECNxVtVzV7RW5oDi/t3agvfyATy6jAsV1LaL2GxwARAkKxyd47lXDLEoy1IMX/7rnjf0RWE5/b6+JcoskiY4seYX8bRzfKEbMDD0FeXJE3vxvRdOvouUo4Ep/6w+yDLPchVcqhjtiN746d7TeSlsa8y+/qKYYlTIBw8CZWn6sCgWlOcqHMAa7XGnJcHyY341xSWg5EETB8fmNTgUwdr7EYljD/Iwu+IY+1XniXnNpCE/IFbgA4z6meHi9gzwyhHIM2rLACbVTCxQ9gT/HCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRb0/UVStJRoG0pO64qRA6p7Y60j66rEw6ObqEw4mSc=;
 b=dA8HzeGjlCuUUyY7eMWSBaVHOpAVVzNPsxdnxZDjN/gi+//fVUAn6DiqcDF8x7hBkG8kqGH1fKldW8i+zpU9Y/NcacAMDKR+ac2ODNRyDyLjlq8N2orsDvKqPMfY5O5PPjUscGFIMftF6AXycpvT5474rXPtll9N44qkTDHUdUo=
Received: from AM6PR0502MB3958.eurprd05.prod.outlook.com (52.133.29.12) by
 AM6PR0502MB3912.eurprd05.prod.outlook.com (52.133.20.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Wed, 7 Aug 2019 06:46:50 +0000
Received: from AM6PR0502MB3958.eurprd05.prod.outlook.com
 ([fe80::9e0:6674:846e:21a5]) by AM6PR0502MB3958.eurprd05.prod.outlook.com
 ([fe80::9e0:6674:846e:21a5%4]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 06:46:50 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] Regulator: Core: Add clock-enable to
 fixed-regulator
Thread-Topic: [RFC PATCH 1/2] Regulator: Core: Add clock-enable to
 fixed-regulator
Thread-Index: AQHVRvxzybMyJSodXUy6lc50qr83sabjdjUAgAAvYYCAAZjcgIAHL6gAgABcCwCAAVTmgIAAW84AgADO9IA=
Date:   Wed, 7 Aug 2019 06:46:50 +0000
Message-ID: <9b3f6c47803bbd672896b682469109bb7201a04b.camel@toradex.com>
References: <20190730173006.15823-1-dev@pschenker.ch>
         <20190730173006.15823-2-dev@pschenker.ch>
         <20190730181038.GK4264@sirena.org.uk>
         <b5e1cc3fb5838d9ea4160078402bff95903ba0da.camel@toradex.com>
         <20190731212335.GL4369@sirena.org.uk>
         <0b51a86ad6ee7e143506501937863cd8559244ec.camel@toradex.com>
         <20190805163724.GK6432@sirena.org.uk>
         <af076ff7e1df4c07ab659ff83efa0c85d5e5e3d6.camel@toradex.com>
         <20190806182606.GG4527@sirena.org.uk>
In-Reply-To: <20190806182606.GG4527@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13fe58dd-561f-40ea-c83e-08d71b030697
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR0502MB3912;
x-ms-traffictypediagnostic: AM6PR0502MB3912:
x-microsoft-antispam-prvs: <AM6PR0502MB39128FB88C9F8B17C6737B78F4D40@AM6PR0502MB3912.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(39840400004)(366004)(136003)(189003)(199004)(76176011)(25786009)(316002)(8676002)(1730700003)(66946007)(36756003)(4326008)(76116006)(186003)(91956017)(486006)(256004)(6246003)(11346002)(2616005)(102836004)(476003)(99286004)(446003)(6506007)(2351001)(44832011)(2501003)(64756008)(66066001)(66556008)(6916009)(2906002)(54906003)(66446008)(66476007)(86362001)(53936002)(6436002)(5640700003)(8936002)(81156014)(81166006)(6486002)(5660300002)(6512007)(26005)(71200400001)(14454004)(71190400001)(118296001)(305945005)(68736007)(229853002)(6116002)(3846002)(7736002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0502MB3912;H:AM6PR0502MB3958.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 10hggRcDd6AZPdxuAuOVpdemoylJBS5bCFKvfJRU+KCLPbDKLO+mxXL8OLJUPXOAyvCYuiuI2ZHjWle3vH3e4czfwaWTAn+cKvjgwULjUa9jB89e4FdkbXOMEuuP2S1wP5dJFAmF38b8X4hq7a4ogN+5NRZ9sdvROHUrF9ZL463xSFKyHjp5sqTl/SK1QQn+cYU1RaHOBWHqOud03PAdz7iYAxREQ+K3Et6LPjPL9bLW/iPR1PhQl3yNIQPlZ18zXMexecBHeDmuNlJmId+JaH4u5NEanqrlhu9oZHRipTXu7wohH96C/L6VeWH+fK3w5MGcLj1EIkH2fy2I/Uxxt55J3oHyGYK/aHLLAchQDwTaL/UsgbBgGPfWLDkIOpfWwj+1kW4U6kYeeBReZbqm23PplQT3xlS8uO/eT1eqlIU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B994D378F515643BF94F2D01B753199@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fe58dd-561f-40ea-c83e-08d71b030697
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 06:46:50.5147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXA3I3tGEdfHykNSpAyN489ztg2dI8C5fKALTSj+qWHZvFeFj1xzM7Q6RMYVqKtdEujwLDHTu0jAG3Nt13RQ5dmz2UJO69tRQZY+RToCbog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB3912
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTA2IGF0IDE5OjI2ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUdWUsIEF1ZyAwNiwgMjAxOSBhdCAxMjo1NzozMlBNICswMDAwLCBQaGlsaXBwZSBTY2hlbmtl
ciB3cm90ZToNCj4gPiBPbiBNb24sIDIwMTktMDgtMDUgYXQgMTc6MzcgKzAxMDAsIE1hcmsgQnJv
d24gd3JvdGU6DQo+ID4gPiBTbyB0aGUgY2FwYWNpdG9yIG9uIHRoZSBpbnB1dCBvZiB0aGUgcC1G
RVQgaXMga2VlcGluZyB0aGUgc3dpdGNoDQo+ID4gPiBvbj8NCj4gPiA+IFdoZW4gSSBzYXkgaXQn
cyBub3Qgc3dpdGNoaW5nIHdpdGggdGhlIGNsb2NrIEkgbWVhbiBpdCdzIG5vdA0KPiA+ID4gY29u
c3RhbnRseQ0KPiA+ID4gYm91bmNpbmcgb24gYW5kIG9mZiBhdCB3aGF0ZXZlciByYXRlIHRoZSBj
bG9jayBpcyBnb2luZyBhdC4NCj4gPiBBaCwgdGhhdCdzIHdoYXQgeW91IG1lYW4uIFllcywgdGhl
IGNhcGFjaXRvciBnZXRzIHNsb3dseSBjaGFyZ2VkDQo+ID4gd2l0aA0KPiA+IHRoZQ0KPiA+IHJl
c2lzdG9yIGJ1dCBuZWFybHkgaW5zdGFudGx5IGRpc2NoYXJnZWQgd2l0aCB0aGUgbi1GRVQuIFNv
IHRoaXMNCj4gPiBjYXBhY2l0b3INCj4gPiBpcyB1c2VkIGFzIGEgTG93LVBhc3MgZmlsdGVyIHRv
IGdldCB0aGUgcC1GRVQgdG8gYmUgY29uc3RhbnRseQ0KPiA+IHN3aXRjaGVkLg0KPiA+IEl0IGlz
IG5vdCBib3VuY2luZyBvbiBhbmQgb2ZmIHdpdGggdGhlIGNsb2NrIGJ1dCByYXRoZXIgaXQgaXMN
Cj4gPiBzd2l0Y2hlZA0KPiA+IGNvbnN0YW50bHkuDQo+IA0KPiBHb29kLCBJIGd1ZXNzIHRoaXMg
bWlnaHQgYmUgcGFydCBvZiB3aHkgaXQncyBnb3QgdGhpcyBwb29yIHJhbXAgdGltZS4NCg0KWWVz
LCBJIHRoaW5rIHNvIHRvby4NCg0KPiANCj4gPiA+IEkgdGhpbmsgeW91IGFyZSBnb2luZyB0byBl
bmQgdXAgd2l0aCBhIGhhY2sgbm8gbWF0dGVyIHdoYXQuDQo+ID4gVGhhdCdzIGV4YWN0bHkgd2hh
dCBJJ20gdHJ5aW5nIHRvIHByZXZlbnQuIFRvIGludHJvZHVjZSBhIGZpeGVkDQo+ID4gcmVndWxh
dG9yIHRoYXQgY2FuIGhhdmUgYSBjbG9jayBpcyBub3QgYSBoYWNrIGZvciBtZS4NCj4gPiBUaGF0
IHRoZSBoYXJkd2FyZSBzb2x1dGlvbiBpcyBhIGhhY2sgaXMgZGViYXRhYmxlIHllcywgYnV0IHdo
eQ0KPiA+IHNob3VsZCBJDQo+ID4gbm90IHRyeSB0byBzb2x2ZSBpdCBwcm9wZXJseSBpbiBzb2Z0
d2FyZT8NCj4gDQo+IEEgbG90IG9mIHRoaXMgZGlzY3Vzc2lvbiBpcyBhcm91bmQgdGhlIGRlZmlu
aXRpb24gb2YgdGVybXMgbGlrZSAiaGFjayINCj4gYW5kICJwcm9wZXIiLg0KPiANCj4gPiBJbiB0
aGUgZW5kIEkganVzdCB3YW50IHRvIHJlcHJlc2VudCBvdXIgaGFyZHdhcmUgaW4gc29mdHdhcmUu
IFdvdWxkDQo+ID4geW91DQo+ID4gYWdyZWUgdG8gY3JlYXRlIGEgbmV3IGNsb2NrLXJlZ3VsYXRv
ci5jIGRyaXZlcj8NCj4gPiBPciB3b3VsZCBpdCBtYWtlIG1vcmUgc2Vuc2UgdG8gZXh0ZW5kIGZp
eGVkLmMgdG8gc3VwcG9ydCBjbG9ja3MtDQo+ID4gZW5hYmxlDQo+ID4gd2l0aG91dCB0b3VjaGlu
ZyBjb3JlPw0KPiANCj4gQXQgbGVhc3QgYSBzZXBhcmF0ZSBjb21wYXRpYmxlIG1ha2VzIHNlbnNl
LCBJJ2QgaGF2ZSB0byBzZWUgdGhlIGNvZGUNCj4gdG8NCj4gYmUgY2xlYXIgaWYgYSBjb21wbGV0
ZWx5IHNlcGFyYXRlIGRyaXZlciBtYWtlcyBzZW5zZSBidXQgaXQnbGwgbmVlZA0KPiBzZXBhcmF0
ZSBvcHMgYXQgbGVhc3QuICBUaGVyZSdkIGRlZmluaXRlbHkgYmUgYSBsb3Qgb2Ygb3ZlcmxhcCB0
aG91Z2gNCj4gc28NCj4gaXQncyB3b3J0aCBsb29raW5nIGF0Lg0KDQpPa2F5LCB0aGFua3MgZm9y
IGRpc2N1c3Npb24hIEkgd2lsbCB0cnkgdG8gbWFrZSBzb21ldGhpbmcgdGhhdCB3aWxsIGZpdA0K
aW4gbWFpbmxpbmUga2VybmVsIGFuZCBJIHdpbGwgbGVhcm4gbW9yZSBhYm91dCB0aGUgcmVndWxh
dG9yIHN1YnN5c3RlbQ0KaW4gZ2VuZXJhbCBzbyBJIGNhbiBtYWtlIGEgc29sdXRpb24gdGhhdCBm
aXRzLg0KQnV0IEknbGwgbmVlZCBzb21lIHRpbWUgdG8gZG8gdGhhdC4gSSB3aWxsIGZvciBzdXJl
IGxpbmsgdG8gdGhhdA0KZGlzY3Vzc2lvbiB3aGVuIEkgc2VuZCB0aGUgcGF0Y2guDQoNClBoaWxp
cHBlDQo=
