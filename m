Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8BAC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 01:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4836520835
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 01:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gzWVkz8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfI0BUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 21:20:23 -0400
Received: from mail-eopbgr140049.outbound.protection.outlook.com ([40.107.14.49]:6371
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfI0BUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 21:20:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql7VdHwyOn3rQse9E8HBpOy7nAH4n4Go2jDSqYuI7qqIMEQFbZL7nbjgjpBiZLwdQiJkt8I+Qe0U41QIXSIxbJ2gkNsaFz4ln9Ze1+X/oYbA++eDpv0xmhNwOszvKB332PFvUyDZ0fL5DMpmsHA3ucHYJAIc5MF2Hv4XHhY3+o7YD5oNaQkZxrr8vIoesSqj9VBzO/mJjZtqyxtrxnMLDjDg20TgmM9MXfNC2P5OTwK8uXLke6i5CAFrzIlCc9oBNbUpqExBK3iRhX8uFjhyJM+JWWPJX/zWJQcNS4NwdEixDHQX+Cy0XFEfYelSn+P2thnUpQdFqXFwwFwiAjA3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXmBSpXUKHDu0Em+Dia+VEzOiwGY0ytRP9L24v+/Z1Q=;
 b=YSKZqKLukNo9+p0L3aLdpYCyibbJjYORZWiGa6hS394lhEQPaMQzF7sGUqZ+9VxEIctVNkgUqnqbJEcYpcFbq0X2GF6jlEqb8sMIOAC5j40VQakOEcNJ0K8QZ7N3Q4mcOYqzZckgaROYxnORrO5G626LP+cUFcPTMawGYzdxzMeOKeFsjkC7XLqX1LM6RxkwefoWXEPXXqxb/LOafnm+wzgdiltFHmK9EDgP812spDofXg3ub50O6bA9gKeUMcfhnHo8f5dctJ+Gso2dbtSeaWou5qeUsk5C+xqB1sHLVEDR7+Vz1ThxR1Jl1tVHcGTIPusSIcj5EoK6r0OLCD8MxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXmBSpXUKHDu0Em+Dia+VEzOiwGY0ytRP9L24v+/Z1Q=;
 b=gzWVkz8A6bR5w4xzjSstCntuCMllNGuJiyucWIrtY4/0JAqN5EjqNNwRv4wOYUb6zOBrcmhEhUmnpXCktCQq0xEaj7t9oCqSpPJYi7q7wCQGWQ/8xdyZJGhQw0ymm8gNKrjewLwvmweF/L6WuT+T6k/KMMRJ6UCKTX8CZoo6ayY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3753.eurprd04.prod.outlook.com (52.134.71.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Fri, 27 Sep 2019 01:20:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2284.028; Fri, 27 Sep 2019
 01:20:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Topic: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Index: AQHVc4lT/ErvPybCJUCbZ2x7mLGjsqc+tdHg
Date:   Fri, 27 Sep 2019 01:20:17 +0000
Message-ID: <DB3PR0402MB391675F9BF6FCA315B124BEBF5810@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
 <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
 <DB3PR0402MB391683202692BEAE4D2CD9C1F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190926100558.egils3ds37m3s5wo@pengutronix.de>
 <VI1PR04MB702336F648EA1BF0E4AC584BEE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB702336F648EA1BF0E4AC584BEE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b45de280-eca6-471d-123d-08d742e8db3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3753;
x-ms-traffictypediagnostic: DB3PR0402MB3753:|DB3PR0402MB3753:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3753BB9ABF4240BB0D6C41C0F5810@DB3PR0402MB3753.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(199004)(189003)(6636002)(229853002)(476003)(26005)(55016002)(6246003)(71200400001)(74316002)(66556008)(64756008)(102836004)(2906002)(66476007)(71190400001)(316002)(186003)(8676002)(25786009)(9686003)(81156014)(66066001)(81166006)(99286004)(7696005)(76176011)(486006)(66446008)(44832011)(54906003)(446003)(7736002)(110136005)(33656002)(4326008)(8936002)(478600001)(52536014)(6436002)(305945005)(256004)(53546011)(5660300002)(6116002)(66946007)(11346002)(3846002)(6506007)(14454004)(76116006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3753;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0ADiU2w0wLaQhm3rv+zbVR4ah1orAPlFkti3R3m193qHDALvcycWmQNrtpIY47quNYZIsYCOeafhwkKhrclTiN5gx/HXjCjwSCO4sI2FQuTrAv97QL791H3awcmRedwXWjee/23foycfdPgK8bQt/FBjLeWX4wpWPYLa1OB7Oo9+qgpJzdVqB7rKCoo5BuhNhS3Qyxx33duIS01quntpSIjPBEYt/kufUeelpqmuAnXet4HvAtsq+rX2DWDOOdrhFQrjbHR7a4LtfeGv8jLqSMYnX39gKjOL5sI8CYflpaoFCtrsnw8D3oJED2XAS6j5JAghubpZODQK1+B/pUIrIQBac24y4CZCpGMdXwaYlOiVBZhRiZzaxrEM5q0jthrUEa0gbL5LexjXajSd9b+q0+ZyOzBcPGSRuMj5eRmHVXY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45de280-eca6-471d-123d-08d742e8db3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 01:20:17.3647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyZV4f45O8OHhD5Hv9wCK1JfIKqq/bNH/PHhM57/VEO34WmBkUOC1Cl5xTCdVXHtArGjTlIO47CkBkG9wqaL4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3753
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiBPbiAyMDE5LTA5LTI2IDE6MDYgUE0sIE1hcmNvIEZlbHNjaCB3cm90
ZToNCj4gPiBPbiAxOS0wOS0yNiAwODowMywgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4+PiBPbiAx
OS0wOS0yNSAxODowNywgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4+Pj4gVGhlIFNDVSBmaXJtd2Fy
ZSBkb2VzIE5PVCBhbHdheXMgaGF2ZSByZXR1cm4gdmFsdWUgc3RvcmVkIGluDQo+ID4+Pj4gbWVz
c2FnZSBoZWFkZXIncyBmdW5jdGlvbiBlbGVtZW50IGV2ZW4gdGhlIEFQSSBoYXMgcmVzcG9uc2Ug
ZGF0YSwNCj4gPj4+PiB0aG9zZSBzcGVjaWFsIEFQSXMgYXJlIGRlZmluZWQgYXMgdm9pZCBmdW5j
dGlvbiBpbiBTQ1UgZmlybXdhcmUsIHNvDQo+ID4+Pj4gdGhleSBzaG91bGQgYmUgdHJlYXRlZCBh
cyByZXR1cm4gc3VjY2VzcyBhbHdheXMuDQo+ID4+Pj4NCj4gPj4+PiArc3RhdGljIGNvbnN0IHN0
cnVjdCBpbXhfc2NfcnBjX21zZyB3aGl0ZWxpc3RbXSA9IHsNCj4gPj4+PiArCXsgLnN2YyA9IElN
WF9TQ19SUENfU1ZDX01JU0MsIC5mdW5jID0NCj4gPj4+IElNWF9TQ19NSVNDX0ZVTkNfVU5JUVVF
X0lEIH0sDQo+ID4+Pj4gKwl7IC5zdmMgPSBJTVhfU0NfUlBDX1NWQ19NSVNDLCAuZnVuYyA9DQo+
ID4+Pj4gK0lNWF9TQ19NSVNDX0ZVTkNfR0VUX0JVVFRPTl9TVEFUVVMgfSwgfTsNCj4gPj4+DQo+
ID4+PiBJcyB0aGlzIGdvaW5nIHRvIGJlIGV4dGVuZGVkIGluIHRoZSBuZWFyIGZ1dHVyZT8gSSBz
ZWUgc29tZSB1cGNvbWluZw0KPiA+Pj4gcHJvYmxlbXMgaGVyZSBpZiBzb21lb25lIHVzZXMgYSBk
aWZmZXJlbnQgc2N1LWZ3PC0+a2VybmVsDQo+ID4+PiBjb21iaW5hdGlvbiBhcyBueHAgd291bGQg
c3VnZ2VzdC4NCj4gPj4NCj4gPj4gQ291bGQgYmUsIGJ1dCBJIGNoZWNrZWQgdGhlIGN1cnJlbnQg
QVBJcywgT05MWSB0aGVzZSAyIHdpbGwgYmUgdXNlZA0KPiA+PiBpbiBMaW51eCBrZXJuZWwsIHNv
IEkgT05MWSBhZGQgdGhlc2UgMiBBUElzIGZvciBub3cuDQo+ID4NCj4gPiBPa2F5Lg0KPiA+DQo+
ID4+IEhvd2V2ZXIsIGFmdGVyIHJldGhpbmssIG1heWJlIHdlIHNob3VsZCBhZGQgYW5vdGhlciBp
bXhfc2NfcnBjIEFQSQ0KPiA+PiBmb3IgdGhvc2Ugc3BlY2lhbCBBUElzPyBUbyBhdm9pZCBjaGVj
a2luZyBpdCBmb3IgYWxsIHRoZSBBUElzIGNhbGxlZCB3aGljaA0KPiBtYXkgaW1wYWN0IHNvbWUg
cGVyZm9ybWFuY2UuDQo+ID4+IFN0aWxsIHVuZGVyIGRpc2N1c3Npb24sIGlmIHlvdSBoYXZlIGJl
dHRlciBpZGVhLCBwbGVhc2UgYWR2aXNlLCB0aGFua3MhDQo+IA0KPiBNeSBzdWdnZXN0aW9uIGlz
IHRvIHJlZmFjdG9yIHRoZSBjb2RlIGFuZCBhZGQgYSBuZXcgQVBJIGZvciB0aGUgdGhpcyAibm8N
Cj4gZXJyb3IgdmFsdWUiIGNvbnZlbnRpb24uIEludGVybmFsbHkgdGhleSBjYW4gY2FsbCBhIGNv
bW1vbiBmdW5jdGlvbiB3aXRoDQo+IGZsYWdzLg0KDQpJZiBJIHVuZGVyc3RhbmQgeW91ciBwb2lu
dCBjb3JyZWN0bHksIHRoYXQgbWVhbnMgdGhlIGxvb3AgY2hlY2sgb2Ygd2hldGhlciB0aGUgQVBJ
DQppcyB3aXRoICJubyBlcnJvciB2YWx1ZSIgZm9yIGV2ZXJ5IEFQSSBzdGlsbCBOT1QgYmUgc2tp
cHBlZCwgaXQgaXMganVzdCByZWZhY3RvcmluZyB0aGUgY29kZSwNCnJpZ2h0Pw0KDQo+IA0KPiA+
IEFkZGluZyBhIHNwZWNpYWwgYXBpIHNob3VsZG4ndCBiZSB0aGUgcmlnaHQgZml4LiBJbWFnaW5l
IGlmIHNvbWVvbmUNCj4gPiAobm90IGEgbnhwLWRldmVsb3Blcikgd2FudHMgdG8gYWRkIGEgbmV3
IGRyaXZlci4gSG93IGNvdWxkIGhlIGJlDQo+ID4gZXhwZWN0ZWQgdG8ga25vdyB3aGljaCBhcGkg
aGUgc2hvdWxkIHVzZS4gVGhlIGJldHRlciBhYmJyb2FjaCB3b3VsZCBiZQ0KPiA+IHRvIGZpeCB0
aGUgc2N1LWZ3IGluc3RlYWQgb2YgYWRkaW5nIHF1aXJrcy4uDQoNClllcywgZml4aW5nIFNDVSBG
VyBpcyB0aGUgYmVzdCBzb2x1dGlvbiwgYnV0IHdlIGhhdmUgdGFsa2VkIHRvIFNDVSBGVyBvd25l
ciwgdGhlIFNDVQ0KRlcgcmVsZWFzZWQgaGFzIGJlZW4gZmluYWxpemVkLCBzbyB0aGUgQVBJIGlt
cGxlbWVudGF0aW9uIGNhbiBOT1QgYmUgY2hhbmdlZCwgYnV0DQp0aGV5IHdpbGwgcGF5IGF0dGVu
dGlvbiB0byB0aGlzIGlzc3VlIGZvciBuZXcgYWRkZWQgQVBJcyBsYXRlci4gVGhhdCBtZWFucyB0
aGUgbnVtYmVyDQpvZiBBUElzIGhhdmluZyB0aGlzIGlzc3VlIGEgdmVyeSBsaW1pdGVkLiANCg0K
PiANCj4gUmlnaHQgbm93IGRldmVsb3BlcnMgd2hvIHdhbnQgdG8gbWFrZSBTQ0ZXIGNhbGxzIGlu
IHVwc3RyZWFtIG5lZWQgdG8NCj4gZGVmaW5lIHRoZSBtZXNzYWdlIHN0cnVjdCBpbiB0aGVpciBk
cml2ZXIgYmFzZWQgb24gcHJvdG9jb2wgZG9jdW1lbnRhdGlvbi4NCj4gVGhpcyBpbmNsdWRlczoN
Cj4gDQo+ICogQmluYXJ5IGxheW91dCBvZiB0aGUgbWVzc2FnZSAoYSBwYWNrZWQgc3RydWN0KQ0K
PiAqIElmIHRoZSBtZXNzYWdlIGhhcyBhIHJlc3BvbnNlIChhbHJlYWR5IGEgYm9vbCBmbGFnKQ0K
PiAqIElmIGFuIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQgKHRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0
IGZvciBpdCkNCj4gDQo+IFNpbmNlIGNhbGxlcnMgYXJlIGFscmVhZHkgZXhwb3NlZCB0byB0aGUg
YmluYXJ5IHByb3RvY29sIGV4cG9zaW5nIHRoZW0gdG8NCj4gbWlub3IgcXVpcmtzIG9mIHRoZSBj
YWxsaW5nIGNvbnZlbnRpb24gYWxzbyBzZWVtcyByZWFzb25hYmxlLiBIYXZpbmcgdGhlDQo+IGxv
dy1sZXZlbCBJUEMgY29kZSBwZWVrIGF0IG1lc3NhZ2UgSURzIHNlZW1zIGxpa2UgYSBoYWNrOyB0
aGlzIGJlbG9uZyBhdCBhDQo+IHNsaWdodGx5IGhpZ2hlciBsZXZlbC4NCg0KQSBsaXR0bGUgY29u
ZnVzZWQsIHNvIHdoYXQgeW91IHN1Z2dlc3RlZCBpcyB0byBhZGQgbWFrZSB0aGUgaW14X3NjdV9j
YWxsX3JwYygpDQpiZWNvbWVzIHRoZSAic2xpZ2h0bHkgaGlnaGVyIGxldmVsIiBBUEksIHRoZW4g
aW4gdGhpcyBBUEksIGNoZWNrIHRoZSBtZXNzYWdlIElEcw0KdG8gZGVjaWRlIHdoZXRoZXIgdG8g
cmV0dXJuIGVycm9yIHZhbHVlLCB0aGVuIGNhbGxzIGEgbmV3IEFQSSB3aGljaCB3aWxsIGhhdmUN
CnRoZSBsb3ctbGV2ZWwgSVBDIGNvZGUsIHRoZSB0aGlzIG5ldyBBUEkgd2lsbCBoYXZlIGEgZmxh
ZyBwYXNzZWQgZnJvbSBpbXhfc2N1X2NhbGxfcnBjKCkNCmZ1bmN0aW9uLCBhbSBJIHJpZ2h0Pw0K
DQpBbnNvbg0K
