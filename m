Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E72C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4DB214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="VsmTKWfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfHELIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:08:04 -0400
Received: from mail-eopbgr40127.outbound.protection.outlook.com ([40.107.4.127]:3382
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728398AbfHELIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:08:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhPE0DsYeNXG/l/5cmu5eY0weM8o4YS1fgW6/QTSGmBuloPUSWS8AjYDLBN0zMeK40TnFZ4B0lZpwCx0tk0759tD5NSAg/E0PmublXkiE4MUlLC4p1zOipavClgDJA/R2Bs3iAsfg08W/HL7OgtgO8Tbhk46PhNcbGasp3PdsBTFayqOKYCXjvdBCxF3SeAxwww/kw+rt9mjUugd8lZvWyTLqrkh9o72HlvfOYTdKemrknHBQM+4XoYiYF7cwWo8FId2qzDgmqIQVdJsdJ64VUy1fnIWSiCiKU8dlllozQ/LjquIe2YqKGBHW8XHox3SmPLefpiay4EBhRQYhTxB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aylgOIf9dCOd/gqHWkf58aRKlOMNrrEZkZsmVQXQxos=;
 b=e35EyV5GlfAufumMLLN/dQvm/25yRrxljtY1lnl3XVEH2TzBmpnd1e+Jj+t1fE/AoilmFrd2jFPZkmQ6S+BEzpJBDZ/dyOucQrws9N/WMAfHldYSgP9yBuEmdhFlD2ruumY7PryL6pIoDgCLDRQPOzPtsXgZg2HnDpWrOAwTCJBD12JrFPacwFiojMWENRVnLdunT3KdyoJGaJ35PQVsEJK+Nffu6tVNxODSjzZGzioEapIQM0rkAqoDlqoRVMlFpDzp6tSh/KYcNiRj9P7nj+e207CuFnUB4DkZJ2icFd94V4N1y1dm3ajZzQczHUKAgCJ+ABMOZRhk/4vf3FEg4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aylgOIf9dCOd/gqHWkf58aRKlOMNrrEZkZsmVQXQxos=;
 b=VsmTKWfHLsfSgsnpaoupl0nWMHNjMYFUborVoucnfzUmCLOhHTpoyUsSZlbKsnKwqzHgjQQN4VwMbCfzrnE2f0VUU+6+ZvQVgsSr5UwnKj/CcjESaX9XLcDfzZpsKhKTY3+KEVJd4hKk5o6LLPQtRLGxhTnCUATCWRiUihMqC9o=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3741.eurprd05.prod.outlook.com (52.134.8.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 11:07:58 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 11:07:58 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] Regulator: Core: Add clock-enable to
 fixed-regulator
Thread-Topic: [RFC PATCH 1/2] Regulator: Core: Add clock-enable to
 fixed-regulator
Thread-Index: AQHVRvxzybMyJSodXUy6lc50qr83sabjdjUAgAAvYYCAAZjcgIAHL6gA
Date:   Mon, 5 Aug 2019 11:07:58 +0000
Message-ID: <0b51a86ad6ee7e143506501937863cd8559244ec.camel@toradex.com>
References: <20190730173006.15823-1-dev@pschenker.ch>
         <20190730173006.15823-2-dev@pschenker.ch>
         <20190730181038.GK4264@sirena.org.uk>
         <b5e1cc3fb5838d9ea4160078402bff95903ba0da.camel@toradex.com>
         <20190731212335.GL4369@sirena.org.uk>
In-Reply-To: <20190731212335.GL4369@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29e259eb-80ae-4670-73aa-08d719952cd1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3741;
x-ms-traffictypediagnostic: VI1PR0502MB3741:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0502MB3741E2F7B198A8B95E61C2DCF4DA0@VI1PR0502MB3741.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39840400004)(346002)(376002)(396003)(51444003)(199004)(189003)(85664002)(25786009)(966005)(66066001)(76116006)(256004)(14444005)(5660300002)(478600001)(66556008)(64756008)(53936002)(66476007)(6306002)(14454004)(6436002)(6512007)(66446008)(91956017)(4326008)(5640700003)(66946007)(6246003)(6916009)(229853002)(2501003)(2351001)(76176011)(99286004)(86362001)(6486002)(8936002)(71200400001)(71190400001)(7736002)(81156014)(81166006)(486006)(1730700003)(2906002)(6116002)(3846002)(305945005)(316002)(68736007)(8676002)(446003)(186003)(476003)(2616005)(102836004)(11346002)(36756003)(118296001)(26005)(6506007)(54906003)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3741;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UOBy+F/R/h5WLH44WkOs7otgwzp1tXTknNXI0B0dkx6twdJOQKNG0OCXZhjDShABaJoZBnmSY5SrMvb7ZjrRHl4fzrNYoTQEBFxrmLUCo4L8wBUAPSX0p7ICtASxAfBgQj3Qncmq8le451pq/UKzeUCsm67QWmLmu1tIq75V83lko/VxGSDsvPZ3rjB6mMQT33G4PbiLAeKeXcmjCejgoDjIzoShueZzWDGU+q5ZjKipAwLT5pQzJ6yOIfNQlG1sXgYZ+2lzQhxDfzLl2ynVR8mI0EOz5CcCbG34WeGmSguy60OEky31rZSenjJ1lAexBT+OuR0J+BwBXN/3ITc3eiwAJVaYNGhmP3+LiM6AqZTKNX+bRANorAyfSLd6TWPIygma9+I3sMCZhKOTtiaVnkoC1Zu51Z7l0ImmQUx6h9k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE72F2F8D452F742A0966BD8753337B8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e259eb-80ae-4670-73aa-08d719952cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 11:07:58.7840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTMxIGF0IDIyOjIzICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUdWUsIEp1bCAzMCwgMjAxOSBhdCAwOTowMDowMVBNICswMDAwLCBQaGlsaXBwZSBTY2hlbmtl
ciB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMTktMDctMzAgYXQgMTk6MTAgKzAxMDAsIE1hcmsgQnJv
d24gd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEp1bCAzMCwgMjAxOSBhdCAwNzozMDowNFBNICswMjAw
LCBQaGlsaXBwZSBTY2hlbmtlciB3cm90ZToNCj4gPiA+ID4gVGhpcyBhZGRzIHRoZSBwb3NzaWJp
bGl0eSB0byBlbmFibGUgYSBmaXhlZC1yZWd1bGF0b3Igd2l0aCBhIGNsb2NrLg0KPiA+ID4gV2h5
PyAgV2hhdCBkb2VzIHRoZSBoYXJkd2FyZSB3aGljaCBtYWtlcyB0aGlzIG1ha2Ugc2Vuc2UgbG9v
ayBsaWtlPw0KPiA+IFRvbW9ycm93IEkgY2FuIHByb3ZpZGUgc29tZSBzY2hlbWF0aWNzIGlmIG5l
ZWRlZC4gQnV0IGl0cyBqdXN0IGEgc2ltcGxlDQo+ID4gc3dpdGNoIHRoYXQgaXMgc3dpdGNoZWQg
YnkgYSBjbG9jayAob24gd2hlbiBjbG9jayBpcyBvbiBhbmQgb2ZmIHdoZW4NCj4gPiBjbG9jayBp
cyBvZmYpLiBUaGlzIGNsb2NrIGlzIHRoZSBSR01JSSA1ME1IeiBjbG9jayBmb3IgdGhlIGV0aGVy
bmV0DQo+ID4gUEhZLg0KPiANCj4gU28gaXQncyBub3Qgc3dpdGNoaW5nIHdpdGggdGhlIGNsb2Nr
LCB0aGUgY2lyY3VpdCBzb21laG93IGtlZXBzIHRoZQ0KPiBzd2l0Y2ggbGF0Y2hlZD8NCg0KTm8s
IGl0IGRvZXNuJ3Qga2VlcCBpdCBsYXRjaGVkLiBUbyBtYWtlIHRoaW5ncyBjbGVhciBoZXJlIGEg
c3RhdHVzIHRhYmxlOg0KDQorLS0tLS0tLS0tLSstLS0tLS0tLS0tLSsNCnwgQ2xvY2sgICAgfCBT
d2l0Y2ggICAgfA0KKy0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rDQp8IGVuYWJsZWQgIHwgKzMuM1Yg
b24gIHwNCistLS0tLS0tLS0tKy0tLS0tLS0tLS0tKw0KfCBkaXNhYmxlZCB8ICszLjNWIG9mZiB8
DQorLS0tLS0tLS0tICstLS0tLS0tLS0tLSsNCg0KSSB0cmllZCB0byBkbyBzY2hlbWF0aWNzIGlu
IEFTQ0lJLCBmb3IgZG9jdW1lbnRhdGlvbiBwdXJwb3NlIG9uIE1MOg0KDQorVjMuMyA+LS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLSstLeKUkCArLS0tLS0tLS0tLS0+ICszLjNWX0VUSA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICB8ICBeIHwgICAgICAgICAgICAg
IHN3aXRjaGVkDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgIC0tLeKUtC0t
ICAgICAgICAgc3VwcGx5IHRvIFBIWQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
ICAgICB8wq/Cr8Kvwq/Crw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICArLSsgICAgICB8
IHAtRkVUDQogICAgICAgICAgICAgICAgICAgICAgICAgICBSIHwgfCAgICAgIHwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCB8ICAgICAgfA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICArLSsgICAgICB8DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgIHwN
CiAgICAgICAgICAgICAgICAgICAgICBuLUZFVCAgICstLS0tLS0tKw0KICAgICAgICAgICAgICAg
ICAgICAgICAgICB8fC0t4pSYICAgICAgIHwNClJNSUlfQ0xLXzUwTUh6ICB8IHwgICAgICAgfHw8
LeKUkCAgICAgICB8DQotLS0tLS0tLS0tLS0tLS0tfCB8LS0tK19fX3x8ICB8ICAgICAtLS0tLQ0K
ICAgICAgICAgICAgICAgIHwgfCAgIHwgICAgICAgfCAgICAgLS0tLS0NCiAgICAgICAgICAgICAg
QyAgICAgICB8ICAgICAgIHwgICBDICAgfA0KICAgICAgICAgICAgICAgICAgICAgKy0rICAgICAg
fCAgICAgICB8DQogICAgICAgICAgICAgICAgICAgUiB8IHwgICAgICB8ICAgICAgIHwNCiAgICAg
ICAgICAgICAgICAgICAgIHwgfCAgICAgIHwgICAgICAgfA0KICAgICAgICAgICAgICAgICAgICAg
Ky0rICAgICAgfCAgICAgICB8DQogICAgICAgICAgICAgICAgICAgICAgfCAgICAgICB8ICAgICAg
IHwNCiAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgIHwgICAgICAgfA0KICAgICAgICAgICAg
ICAgICAgICAgKysrICAgICArKysgICAgICsrKw0KICAgICAgICAgICAgICAgICAgICAgR05EICAg
ICBHTkQgICAgIEdORA0KDQoNCklmIGl0IHNob3VsZG4ndCBiZSBjbGVhciBoZXJlIGEgcGljdHVy
ZToNCmh0dHBzOi8vc2hhcmUudG9yYWRleC5jb20vdjlkN2E5N212cTFrczYyDQoNCj4gDQo+ID4g
V2h5IGlzIGEgcmVndWxhdG9yIGV2ZW4gbmVlZGVkPw0KPiA+IC0gT24gcG93ZXIgdXAgb2YgdGhl
IFBIWSB0aGVyZSBpcyBhIGh1Z2UgdGltZSBJIGhhdmUgdG8gd2FpdCBmb3INCj4gPiB2b2x0YWdl
IHJhaWwgdG8gc2V0dGxlLiBJbiB0aGUgcmFuZ2Ugb2YgMTAwbXMuDQo+ID4gLSBCZWNhdXNlIHRo
ZXJlIGlzIGEgc3dpdGNoIGluIHRoZSBjaXJjdWl0IEkgYWJzdHJhY3QgaXQgd2l0aCBhDQo+ID4g
cmVndWxhdG9yLWZpeGVkIGluIGRldmljZXRyZWUgdG8gbWFrZSB1c2Ugb2YgdGhlIHN0YXJ0dXAt
ZGVsYXkuDQo+ID4gLSBUaGlzIHJlZ3VsYXRvci9zd2l0Y2ggaXMgZW5hYmxlZCB3aXRoIGEgY2xv
Y2suIFNvIHRvIGJlIGFibGUgdG8gdXNlDQo+ID4gdGhlIHN0YXJ0dXAgZGVsYXkgSSBuZWVkIGFu
IGVuYWJsZS1ieS1jbG9jayBvbiByZWd1bGF0b3ItZml4ZWQuDQo+IA0KPiBJdCBkb2VzIGZlZWwg
bGlrZSBpdCBtaWdodCBiZSBzaW1wbGVyIHRvIGp1c3QgaGFuZGxlIHRoaXMgYXMgYSBxdWlyayBp
bg0KPiB0aGUgUEhZIG9yIGV0aGVybmV0IGRyaXZlciwgdGhpcyBmZWVscyBsaWtlIGFuIGF3ZnVs
IGxvdCBvZiB3b3JrIHRvDQo+IGFkZCBhIHNsZWVwIG9uIHdoYXQncyBwcm9iYWJseSBvbmx5IGdv
aW5nIHRvIGV2ZXIgYmUgb25lIHN5c3RlbS4NCg0KSSB0aG91Z2h0IG9mIHRoYXQgdG9vLCBidXQg
dGhlIHByb2JsZW0gd2l0aCB0aGF0IGFwcHJvYWNoIGlzIHRoYXQgSSBjYW4ndCByZWZsZWN0IHRo
ZSBhY3R1YWwgc3dpdGNoaW5nIGJlaGF2aW9yLiBXaGF0IHdvdWxkIGhhcHBlbiBpcyBpZiB5b3Ug
dHVybmV0aGVybmV0IG9mZiB3aXRoICdpcCBsaW5rIHNldCBldGgwIGRvd24nLCB0aGUgY2xvY2sg
d291bGQgc3RvcCBhbmQgdGhlcmVmb3JlDQpubyBtb3JlIHN1cHBseSB2b2x0YWdlIHRvIHRoZSBQ
SFkuIEJ1dCB0aGUgZXRoZXJuZXQgZHJpdmVyd291bGQgaW4gdGhhdCBjYXNlDQpsZXQgdGhlIHJl
Z3VsYXRvciBlbmFibGVkIHByZXZlbnRpbmcsIHN3aXRjaGluZyBvZmYgdGhlIGNsb2NrLg0KDQpB
bnl3YXkgSSBmZWVsIHRoYXQgdG8gc29sdmUgdGhpcyB3aXRoIGEgcXVpcmsgd291bGQgYmUgYSBs
aXR0bGUgaGFja2lzaCwgcGx1cyBJJ2QgYW55d2F5IG5lZWQgdG8gbWVzcyBhcm91bmQgd2l0aCB0
aGUgRXRoZXJuZXQvUEhZIGRyaXZlcnMuIFNvIHdoeSBub3Qgc29sdmUgaXQgcHJvcGVybHkgd2l0
aCBhIHJlZ3VsYXRvciB0aGF0IHN1cHBvcnRzIGNsb2Nrcz8NCg0KPiANCj4gPiBXaHkgZG8gSSB0
aGluayB0aGlzIHNob3VsZCBiZSBpbiBjb3JlPw0KPiA+IC0gTm9ybWFsbHkgdGhpcyB0YXNrIGlz
IGRvbmUgd2l0aCBncGlvIHRoYXQgaXMgYWxyZWFkeSBpbiByZWd1bGF0b3ItDQo+ID4gY29yZS4N
Cj4gPiAtIEJlY2F1c2UgdGhhdCBpcyBhbHJlYWR5IHRoZXJlIEkgYWRkZWQgdGhlIGZ1bmN0aW9u
YWxpdHkgZm9yIGVuYWJsZWQtDQo+ID4gYnktY2xvY2stZnVuY3Rpb25hbGl0eS4NCj4gPiAtIEkg
dGhvdWdodCBvZiBjcmVhdGluZyBhIG5ldyByZWd1bGF0b3ItY2xvY2sgZHJpdmVyIGJ1dCB0aGF0
IHdvdWxkDQo+ID4gaG9sZCBhIGxvdCBvZiBjb2RlIGR1cGxpY2F0aW9uIGZyb20gcmVndWxhdG9y
LWZpeGVkLg0KPiANCj4gSG9wZWZ1bGx5IG5vdCBhICpsb3QqIG9mIGR1cGxpY2F0aW9uLiAgVGhl
IEdQSU9zIGFyZSBoYW5kbGVkIGluIHRoZSBjb3JlDQo+IGJlY2F1c2UgdGhleSdyZSByZWFsbHkg
Y29tbW9uIGFuZCB1c2VkIGJ5IG1hbnkgcmVndWxhdG9yIGRldmljZXMsIHRoZQ0KPiBzYW1lIHdp
bGwgSSBob3BlIG5vdCBiZSB0cnVlIGZvciBjbG9ja3MuDQoNCkkgYWdyZWUgdGhhdCB0aGV5IGFy
ZSBjb21tb25seSBhbmQgd2lkZWx5IHVzZWQuIFRvIGFkZCBzdXBwb3J0IGZvciBjbG9ja3MgaW4N
CnJlZ3VsYXRvci1jb3JlIHdhcyByZWFsbHkgZWFzeSB0byBkbyBhcyBJIGRpZCBpdCB0aGUgc2Ft
ZSB3YXkgYXMgaXQgaXMgZG9uZSB3aXRoDQpncGlvJ3MuIElmIEkgZG9uJ3QgbmVlZCB0byB0b3Vj
aCByZWd1bGF0b3ItY29yZSBJIGRvbid0IHdhbnQgdG8uIEJ1dCBhcyBJIHNhaWQNCml0IHdhcyBy
ZWFsbHkgZWFzeSBmb3IgbWUgdG8gaW50ZWdyYXRlIGl0IGluIHRoZXJlIGluIGEgd2F5IHdpdGhv
dXQgZXZlbg0KdW5kZXJzdGFuZGluZyB0aGUgd2hvbGUgcmVndWxhdG9yIEFQSS4NCg0KSWYgaXQg
bWFrZXMgbW9yZSBzZW5zZSB0byBkbyBpdCBpbiBhIG5ldyBmaWxlIGxpa2UgY2xvY2stcmVndWxh
dG9yLmMgYW5kDQpjcmVhdGluZyBhIG5ldyBjb21wYXRpYmxlIHRoYXQgaXMgd2hhdCBJJ20gdHJ5
aW5nIHRvIGZpbmQgb3V0IGhlcmUuIEknZCBiZSBoYXBweQ0KdG8gd3JpdGUgYWxzbyBhIG5ldyBj
bG9jay1yZWd1bGF0b3IgZHJpdmVyIGZvciB0aGF0IHB1cnBvc2UuDQoNCj4gDQo+ID4gV2h5IGlz
IHRoaXMgYSBnb29kIElkZWEgYXQgYWxsPw0KPiA+IC0gV2VsbCBJJ20gaGVyZSBmb3IgdGhlIHNv
ZnR3YXJlIHBhcnQgYW5kIHNob3VsZCBqdXN0IHN1cHBvcnQgb3VyDQo+ID4gaGFyZHdhcmUuIElm
IHRoYXQgaXMgYSBnb29kIElkZWEgYXQgYWxsIEkgZG9uJ3Qga25vdywgZm9yIHN1cmUgaXQgaXMN
Cj4gPiBub3QgYSBzb2x1dGlvbiB0aGF0IGlzIGZyb20gc29tZSBzY2hvb2wtYm9vay4gQnV0IEkg
dHJpZWQgaXQgYW5kDQo+ID4gbWVhc3VyZWQgaXQgb3V0IGFuZCBpdCBzZWVtcyB0byB3b3JrIHBy
ZXR0eSBmaW5lLg0KPiA+IC0gVGhlIHJlYXNvbiBiZWhpbmQgYWxsIG9mIHRoYXQgaXMgbGltaXRl
ZCBHUElPIGF2YWlsYWJpbGl0eSBmcm9tIHRoZQ0KPiA+IGlNWDZVTEwuDQo+IA0KPiBJIGd1ZXNz
IG15IHF1ZXN0aW9uIGhlcmUgaXMgd2hhdCB0aGUgdHJpcCB0aHJvdWdoIHRoZSByZWd1bGF0b3Ig
QVBJIGJ1eXMNCj4gdXMgLSBpdCdzIGEgYml0IG9mIGEgc2xlZGdlaGFtbWVyIHRvIGNyYWNrIGEg
bnV0IHRoaW5nLg0KDQpJbiBteSBvcGluaW9uIHRoaXMgaXMgbm90IG9ubHkgYWJvdXQgdG8gc29s
dmUgbXkgcHJvYmxlbSB3aXRoIHN0YXJ0dXAtZGVsYXkuIEkNCnRoaW5rIHRoYXQgdGhpcyBpcyBy
ZWFsbHkgYSBiZWhhdmlvciB0aGF0IGNhbiBiZSBnZW5lcmljLiBUaGF0J3MgYWxzbyB3aHkgSSdt
DQphc2tpbmcgaGVyZSBob3cgd2Ugd2FudCB0byBzb2x2ZSB0aGF0IHNvIG5vdCBvbmx5IEkgc29s
dmUgbXkgbGl0dGxlIHByb2JsZW0gd2l0aA0KYSBib2FyZCBxdWlyayBidXQgaW4gYSBicm9hZGVy
IHZpZXcgZm9yIHBvc3NpYmxlIGZ1dHVyZSB1c2FnZSBieSBvdGhlcnMuDQoNCkl0IGlzIHBvc3Np
YmxlIHRoYXQgYSByZWd1bGF0b3IgbmVlZHMgYSBjbG9jay4gVGhhdCBleGFjdGx5IGlzLCB3aGF0
IHdlIGhhdmUgb24NCm91ciBib2FyZCBhbmQgd29ya3MgYmV0dGVyIHRoYW4gZXhwZWN0ZWQgKGF0
IGxlYXN0IGJ5IG15c2VsZiA6LSkpLg0K
