Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1436C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F60021855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N4LKLHL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfI3IcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:32:20 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:6306
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfI3IcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:32:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkG1sBsZUoKtZR5YjnkpivMOR+JlL/NE+qCNfv4dOT8qHmomhebZcqDVTj8I75wOfaFRbBfQa0jSn5sSc9m9MAKgHZGz+8eRzH903jt/ZrfLdNX/UvunQ4tWdkiXjOQZ7OYcilWHBHxfHtLDp8vt69/OUIZRzLaLENJ+8AX/xMbpvuNqZaqoQt5UewYQ4n557U9OHoUV4YkiSWZuKc8SOkOpOk7xhQWXob9k5s9O3L0CG5diekNPv6iZj/kSz/V48VqpThNY/6NOcitNEDyPUSi7SyAqFfUCZV6J9YsPz9uLfEchc6/uzNC+Zl+vO4h2eSPnS/hd9Izm8beY35TWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVo4zqw3h2bYRHXOY3WXWgJhE0tXx25VO6yyzRj4DjM=;
 b=LtnYIOWu3CWYkHWA8MCUJA5RNHhPUOfx0W+ybSZKvz8q9/ik/zCoxXuQpstjq+6nazsHPubJ0wJNKeqj6oLaOai6dbHxt4utz6ztGAhezH937dN7G9QWenAKV1YPtN2r40F0Des3O8YeHviCdZp4dScLROr+oWd9R/L0LAk6j8P1tt+p1mNqav+EV9i+cJ4Ln8eA8i+MEIl1q45eyhSGZMv16JgC4yD6Ur2zXs+sN6t2STMdjODPttDSqi2KFwGluFrozev4uHyRl1JhJ2kIutqufPwK6FdKVoWfrmkqRQH+9bOee/FVpdfnJy6I3eWH3lQnm05iGQxppPdJEeFhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVo4zqw3h2bYRHXOY3WXWgJhE0tXx25VO6yyzRj4DjM=;
 b=N4LKLHL26TBrnUtlL3v/1hRnaNvPg0jV3fF4i3TPQ+Mkw17wJqoiMY/Nx/ADTzfimFTR/In7T4IGMDePG5d6qS6c2du7QXHaekZwysDAhzg/h3Q6M8RCQx8K6t6hZ0VXrk2oMUKD88UhS9HEwCpwZENLNl2fNzZPHjSsxJSyLL4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3692.eurprd04.prod.outlook.com (52.134.65.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Mon, 30 Sep 2019 08:32:14 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 08:32:14 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Topic: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Index: AQHVc4lT/ErvPybCJUCbZ2x7mLGjsqdD3BbwgAALBgCAAAI3gA==
Date:   Mon, 30 Sep 2019 08:32:14 +0000
Message-ID: <DB3PR0402MB3916B2243D4B452B460EA892F5820@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
 <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
 <DB3PR0402MB391683202692BEAE4D2CD9C1F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190926100558.egils3ds37m3s5wo@pengutronix.de>
 <VI1PR04MB702336F648EA1BF0E4AC584BEE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <DB3PR0402MB391675F9BF6FCA315B124BEBF5810@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <VI1PR04MB702322F2F020A527AD2F8DDEEE820@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <DB3PR0402MB39169BC7E8DB3525A309034EF5820@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190930081434.qrrv3yqczzxihntm@pengutronix.de>
In-Reply-To: <20190930081434.qrrv3yqczzxihntm@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 115066d7-c6d9-49a8-0b42-08d74580b274
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB3PR0402MB3692:|DB3PR0402MB3692:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3692B14962CEBBDC43DBD80EF5820@DB3PR0402MB3692.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(189003)(199004)(6116002)(229853002)(446003)(4326008)(11346002)(5660300002)(52536014)(76176011)(7696005)(2906002)(26005)(33656002)(478600001)(14454004)(53546011)(186003)(6506007)(3846002)(99286004)(25786009)(66066001)(6246003)(44832011)(81156014)(81166006)(476003)(102836004)(55016002)(9686003)(54906003)(8936002)(71190400001)(66476007)(64756008)(486006)(8676002)(66946007)(74316002)(305945005)(76116006)(256004)(6436002)(66446008)(66556008)(7736002)(6916009)(316002)(86362001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3692;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VljTYCERxZbfnLIVQyvkc2mRwMldY/WXFuoLOVhVkT0nu9OUKm1punHun9AZpQ7QPXIJ/nnQlBjS3++pg/PTUD3zXUhNsETvvcYFB3trzPa7Qit23jO1LvSJ/S09oLe0eI6Ec1UdOsUsf+RSNxoqHEEEeqDWhIl+tadMUkRooZAPAc/hFki+Fy9qSeS3OTVjC7HRuqtZStFGnOVGXphLRhynrcQWmymOLJTyQJTSw76B7TGpzCMCPmKHzI7i8cvd8HlxPbrJdvDoJPzdPXHohT7CKP5GmXN8Sa6R4qKiRxc5w4PFIfzXgb73pTwnZ8IdDyS2tDlCEtD1RyHMCsFe+oPBnLl+Y3bycKWAmWmuHpr17oklo8D8YAxY6oQ0XsxDU8LXBh7luISEn1lMgV36Y9w/nZBvxTEW2cgosPxFEwc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115066d7-c6d9-49a8-0b42-08d74580b274
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 08:32:14.7954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7c/rIv8nQZjyZY3tB0NAFFVmo60NdLQpB9lpMNUyQCFvOc+WvrWeWmcm1Sew6p/PPePosXx57lMNPmt0thkNLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmNvDQoNCj4gT24gMTktMDktMzAgMDc6NDIsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+
IEhpLCBMZW9uYXJkDQo+ID4NCj4gPiA+IE9uIDIwMTktMDktMjcgNDoyMCBBTSwgQW5zb24gSHVh
bmcgd3JvdGU6DQo+ID4gPiA+PiBPbiAyMDE5LTA5LTI2IDE6MDYgUE0sIE1hcmNvIEZlbHNjaCB3
cm90ZToNCj4gPiA+ID4+PiBPbiAxOS0wOS0yNiAwODowMywgQW5zb24gSHVhbmcgd3JvdGU6DQo+
ID4gPiA+Pj4+PiBPbiAxOS0wOS0yNSAxODowNywgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiA+
Pj4+Pj4gVGhlIFNDVSBmaXJtd2FyZSBkb2VzIE5PVCBhbHdheXMgaGF2ZSByZXR1cm4gdmFsdWUg
c3RvcmVkIGluDQo+ID4gPiA+Pj4+Pj4gbWVzc2FnZSBoZWFkZXIncyBmdW5jdGlvbiBlbGVtZW50
IGV2ZW4gdGhlIEFQSSBoYXMgcmVzcG9uc2UNCj4gPiA+ID4+Pj4+PiBkYXRhLCB0aG9zZSBzcGVj
aWFsIEFQSXMgYXJlIGRlZmluZWQgYXMgdm9pZCBmdW5jdGlvbiBpbiBTQ1UNCj4gPiA+ID4+Pj4+
PiBmaXJtd2FyZSwgc28gdGhleSBzaG91bGQgYmUgdHJlYXRlZCBhcyByZXR1cm4gc3VjY2VzcyBh
bHdheXMuDQo+ID4gPiA+Pj4+Pj4NCj4gPiA+ID4+Pj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBp
bXhfc2NfcnBjX21zZyB3aGl0ZWxpc3RbXSA9IHsNCj4gPiA+ID4+Pj4+PiArCXsgLnN2YyA9IElN
WF9TQ19SUENfU1ZDX01JU0MsIC5mdW5jID0NCj4gPiA+ID4+Pj4+IElNWF9TQ19NSVNDX0ZVTkNf
VU5JUVVFX0lEIH0sDQo+ID4gPiA+Pj4+Pj4gKwl7IC5zdmMgPSBJTVhfU0NfUlBDX1NWQ19NSVND
LCAuZnVuYyA9DQo+ID4gPiA+Pj4+Pj4gK0lNWF9TQ19NSVNDX0ZVTkNfR0VUX0JVVFRPTl9TVEFU
VVMgfSwgfTsNCj4gPiA+ID4+Pj4+DQo+ID4gPiA+Pj4+PiBJcyB0aGlzIGdvaW5nIHRvIGJlIGV4
dGVuZGVkIGluIHRoZSBuZWFyIGZ1dHVyZT8gSSBzZWUgc29tZQ0KPiA+ID4gPj4+Pj4gdXBjb21p
bmcgcHJvYmxlbXMgaGVyZSBpZiBzb21lb25lIHVzZXMgYSBkaWZmZXJlbnQNCj4gPiA+ID4+Pj4+
IHNjdS1mdzwtPmtlcm5lbCBjb21iaW5hdGlvbiBhcyBueHAgd291bGQgc3VnZ2VzdC4NCj4gPiA+
ID4+Pj4NCj4gPiA+ID4+Pj4gQ291bGQgYmUsIGJ1dCBJIGNoZWNrZWQgdGhlIGN1cnJlbnQgQVBJ
cywgT05MWSB0aGVzZSAyIHdpbGwgYmUNCj4gPiA+ID4+Pj4gdXNlZCBpbiBMaW51eCBrZXJuZWws
IHNvIEkgT05MWSBhZGQgdGhlc2UgMiBBUElzIGZvciBub3cuDQo+ID4gPiA+Pj4NCj4gPiA+ID4+
PiBPa2F5Lg0KPiA+ID4gPj4+DQo+ID4gPiA+Pj4+IEhvd2V2ZXIsIGFmdGVyIHJldGhpbmssIG1h
eWJlIHdlIHNob3VsZCBhZGQgYW5vdGhlciBpbXhfc2NfcnBjDQo+ID4gPiA+Pj4+IEFQSSBmb3Ig
dGhvc2Ugc3BlY2lhbCBBUElzPyBUbyBhdm9pZCBjaGVja2luZyBpdCBmb3IgYWxsIHRoZQ0KPiA+
ID4gPj4+PiBBUElzIGNhbGxlZCB3aGljaA0KPiA+ID4gPj4gbWF5IGltcGFjdCBzb21lIHBlcmZv
cm1hbmNlLg0KPiA+ID4gPj4+PiBTdGlsbCB1bmRlciBkaXNjdXNzaW9uLCBpZiB5b3UgaGF2ZSBi
ZXR0ZXIgaWRlYSwgcGxlYXNlIGFkdmlzZSwgdGhhbmtzIQ0KPiA+ID4gPj4NCj4gPiA+ID4+IE15
IHN1Z2dlc3Rpb24gaXMgdG8gcmVmYWN0b3IgdGhlIGNvZGUgYW5kIGFkZCBhIG5ldyBBUEkgZm9y
IHRoZQ0KPiA+ID4gPj4gdGhpcyAibm8gZXJyb3IgdmFsdWUiIGNvbnZlbnRpb24uIEludGVybmFs
bHkgdGhleSBjYW4gY2FsbCBhDQo+ID4gPiA+PiBjb21tb24gZnVuY3Rpb24gd2l0aCBmbGFncy4N
Cj4gPiA+ID4NCj4gPiA+ID4gSWYgSSB1bmRlcnN0YW5kIHlvdXIgcG9pbnQgY29ycmVjdGx5LCB0
aGF0IG1lYW5zIHRoZSBsb29wIGNoZWNrIG9mDQo+ID4gPiA+IHdoZXRoZXIgdGhlIEFQSSBpcyB3
aXRoICJubyBlcnJvciB2YWx1ZSIgZm9yIGV2ZXJ5IEFQSSBzdGlsbCBOT1QNCj4gPiA+ID4gYmUg
c2tpcHBlZCwgaXQgaXMganVzdCByZWZhY3RvcmluZyB0aGUgY29kZSwgcmlnaHQ/DQo+ID4gPg0K
PiA+ID4gVGhlcmUgd291bGQgYmUgbm8gImxvb3AiIGFueXdoZXJlOiB0aGUgcmVzcG9uc2liaWxp
dHkgd291bGQgZmFsbCBvbg0KPiA+ID4gdGhlIGNhbGwgdG8gY2FsbCB0aGUgcmlnaHQgUlBDIGZ1
bmN0aW9uLiBJbiB0aGUgY3VycmVudCBsYXllcmluZw0KPiA+ID4gc2NoZW1lIChkcml2ZXJzIC0+
IFJQQyAtPg0KPiA+ID4gbWFpbGJveCkgdGhlIFJQQyBsYXllciB0cmVhdHMgYWxsIGNhbGxzIHRo
ZSBzYW1lIGFuZCBpdCdzIHVwIHRoZSB0aGUNCj4gPiA+IGNhbGxlciB0byBwcm92aWRlIGluZm9y
bWF0aW9uIGFib3V0IGNhbGxpbmcgY29udmVudGlvbi4NCj4gPiA+DQo+ID4gPiBBbiBleGFtcGxl
IGltcGxlbWVudGF0aW9uOg0KPiA+ID4gKiBSZW5hbWUgaW14X3NjX3JwY19jYWxsIHRvIF9faW14
X3NjX3JwY19jYWxsX2ZsYWdzDQo+ID4gPiAqIE1ha2UgYSB0aW55IGlteF9zY19ycGNfY2FsbCB3
cmFwcGVyIHdoaWNoIGp1c3QgY29udmVydHMNCj4gPiA+IHJlc3Avbm9yZXNwIHRvIGEgZmxhZw0K
PiA+ID4gKiBNYWtlIGdldCBidXR0b24gc3RhdHVzIGNhbGwgX19pbXhfc2NfcnBjX2NhbGxfZmxh
Z3Mgd2l0aCB0aGUNCj4gPiA+IF9JTVhfU0NfUlBDX05PRVJST1IgZmxhZw0KPiA+ID4NCj4gPiA+
IEhvcGUgdGhpcyBtYWtlcyBteSBzdWdnZXN0aW9uIGNsZWFyZXI/IFB1c2hpbmcgdGhpcyB0byB0
aGUgY2FsbGVyIGlzDQo+ID4gPiBhIGJpdCB1Z2x5IGJ1dCBJIHRoaW5rIGl0J3Mgd29ydGggcHJl
c2VydmluZyB0aGUgZmFjdCB0aGF0IHRoZSBpbXgNCj4gPiA+IHJwYyBjb3JlIHRyZWF0cyBzZXJ2
aWNlcyBpbiBhbiB1bmlmb3JtIHdheS4NCj4gPg0KPiA+IEl0IGlzIGNsZWFyIG5vdywgc28gZXNz
ZW50aWFsbHkgaXQgaXMgc2FtZSBhcyAyIHNlcGFyYXRlIEFQSXMsIHN0aWxsDQo+ID4gbmVlZCB0
byBjaGFuZ2UgdGhlIGJ1dHRvbiBkcml2ZXIgYW5kIHVpZCBkcml2ZXIgdG8gdXNlIHRoZSBzcGVj
aWFsDQo+ID4gZmxhZywgbWVhbndoaWxlLCBuZWVkIHRvIGNoYW5nZSB0aGUgdGhpcmQgcGFyYW1l
bnQgb2YgaW14X3NjX3JwY19jYWxsKCkNCj4gZnJvbSBib29sIHRvIHUzMi4NCj4gPg0KPiA+IElm
IG5vIG9uZSBvcHBvc2VzIHRoaXMgYXBwcm9hY2gsIEkgd2lsbCByZWRvIHRoZSBwYXRjaCB0b2dl
dGhlciB3aXRoDQo+ID4gdGhlIGJ1dHRvbiBkcml2ZXIgYW5kIHVpZCBkcml2ZXIgYWZ0ZXIgaG9s
aWRheS4NCj4gDQo+IEFzIEFuc29ucyBzYWlkIHRoYXQgYXJlIHR3byBhcHByb2FjaGVzIGFuZCBp
biBib3RoIHdheXMgdGhlIGNhbGxlciBuZWVkcyB0bw0KPiBrbm93IGlmIHRoZSBlcnJvciBjb2Rl
IGlzIHZhbGlkLiBFeHRlbmRpbmcgdGhlIGZsYWdzIHNlZW1zIGJldHRlciB0byBtZSBidXQgaXQN
Cj4gbG9va3Mgc3RpbGwgbm90IHRoYXQgZ29vZC4gT25lIHF1ZXN0aW9uLCBkb2VzIHRoZSBzY3Ut
Zncgc2V0IHRoZSBlcnJvci1tc2cgdG8NCj4gc29tZXRoaW5nPyBJZiBub3QgdGhhbiB3aHkgc2hv
dWxkIHdlIHNwZWNpZnkgYSBmbGFnIG9yIGEgb3RoZXIgYXBpPw0KPiBOb3dhZGF5cyB0aGUgY2Fs
bGVyIG5lZWRzIHRvIGtub3cgdGhhdCB0aGUgZXJyb3ItbXNnLWZpZWxkIGlzbid0IHNldCBzbyBp
ZiB0aGUNCj4gY2FsbGVyIHNldHMgdGhlIG1zZy1wYWNrZXQgdG8gemVybyBhbmQgZmlsbHMgdGhl
IHJwYy1pZCB0aGUgZXJyb3ItbXNnLWZpZWxkDQo+IHNob3VsZG4ndCBiZSB0b3VjaGVkIGJ5IHRo
ZSBmaXJtd2FyZS4gU28gaXQgc2hvdWxkIGJlIHplcm8uDQoNClRoZSBmbG93IGFyZSBhcyBiZWxv
dyBmb3IgdGhvc2Ugc3BlY2lhbCBBUElzIHdpdGggcmVzcG9uc2UgZGF0YSBidXQgbm8gcmV0dXJu
IHZhbHVlIGZyb20gU0NVIEZXOg0KDQoxLiBjYWxsZXIgc2VuZHMgbXNnIHdpdGggYSBoZWFkZXIg
ZmllbGQgYW5kIGRhdGEgZmllbGQsIHRoZSBoZWFkZXIgZmllbGQgaGFzIHN2YyBJRCBhbmQgZnVu
Y3Rpb24gSUQ7DQoyLiBTQ1UgRlcgd2lsbCBzZXJ2aWNlIHRoZSBjYWxsZXIgYW5kIHRoZW4gY2xl
YXIgdGhlIFNWQyBJRCBiZWZvcmUgcmV0dXJuLCB0aGUgcmVzcG9uc2UgZGF0YSB3aWxsIGJlDQpQ
dXQgaW4gbXNnIGRhdGEgZmllbGQsIGFuZCBpZiB0aGUgQVBJcyBoYXMgcmV0dXJuIHZhbHVlLCBT
Q1UgRlcgd2lsbCBwdXQgdGhlIHJldHVybiB2YWx1ZSBpbiBmdW5jdGlvbiBJRCBvZiBtc2c7ICAN
Cg0KVGhlIGNhbGxlciBoYXMgbm8gY2hhbmNlIHRvIHNldCB0aGUgbXNnLXBhY2tldCB0byB6ZXJv
IGFuZCBycGMtaWQsIGl0IG5lZWRzIHRvIHBhc3MgY29ycmVjdCBycGMtaWQgdG8gU0NVIEZXIGFu
ZA0KR2V0IHJlc3BvbnNlIGRhdGEgZnJvbSBTQ1UgRlcsIGFuZCBmb3IgdGhvc2Ugc3BlY2lhbCBB
UElzIGhhcyBmdW5jdGlvbiBJRCBOT1Qgb3Zlci13cml0dGVuIGJ5IFNDVSBGVydzIHJldHVybg0K
VmFsdWUsIGJ1dCB0aGUgZnVuY3Rpb24gSUQgaXMgYSB1bnNpZ25lZCBpbnQsIGFuZCB0aGUgU0NV
IEZXIHJldHVybiB2YWx1ZSBpcyBhbHNvIGEgdW5zaWduZWQgaW50LCBzbyB3ZSBoYXZlIG5vDQpp
ZGVhIHRvIHNlcGFyYXRlIHRoZW0gZm9yIG5vLXJldHVybiB2YWx1ZSBBUEkgb3IgZXJyb3ItcmV0
dXJuIEFQSS4NCg0KV2l0aCBuZXcgYXBwcm9hY2gsIEkgY2FuIHVzZSBiZWxvdyAyIGZsYWdzLCB0
aGUgdWdseSBwb2ludCBpcyB1c2VyIG5lZWQgdG8ga25vdyB3aGljaCBBUEkgdG8gY2FsbC4NCg0K
KysrIGIvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvaXBjLmgNCkBAIC0zNSw2ICszNSwxMSBA
QCBzdHJ1Y3QgaW14X3NjX3JwY19tc2cgew0KICAgICAgICB1aW50OF90IGZ1bmM7DQogfTsNCg0K
KyNkZWZpbmUgSU1YX1NDX1JQQ19IQVZFX1JFU1AgICBCSVQoMCkgLyogY2FsbGVyIGhhcyByZXNw
b25zZSBkYXRhICovDQorI2RlZmluZSBJTVhfU0NfUlBDX05PRVJST1IgICAgIEJJVCgxKSAvKiBj
YWxsZXIgaGFzIHJlc3BvbnNlIGRhdGEgYnV0IG5vIHJldHVybiB2YWx1ZSBmcm9tIFNDVSBGVyAq
Lw0KKw0KK2ludCBpbXhfc2N1X2NhbGxfcnBjX2ZsYWdzKHN0cnVjdCBpbXhfc2NfaXBjICppcGMs
IHZvaWQgKm1zZywgdTMyIGZsYWdzKTsNCg0KQW5zb24NCg0K
