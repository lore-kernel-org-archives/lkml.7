Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58C7ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45F42133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U761Vbfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfJII3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:29:31 -0400
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:6305
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfJII3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:29:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqMVeGG6nbnanNDcf/S41/aDvS0RIk/peitlSDMsrM5Q2lnGtID4+SSZqeeywuVuOC73E9Oa1GrLjLZpVgID51MiOxddKMo2vqjK8KfdrcyrLgeIHva3DAKVf2McXjb/2tq6FmDlWzse94PXWyC9vFgyk3YdHAbH3c9Zij9U7bM3nGNzljNm0CkXwXKH9SbZVAwHYqD/u7oXXWomkh/gst9RzArtfk63TnLfRWia6rW0JP7+SMjNjNMjQClRwr5Holk3aiE+rQo5CO+RxpRe9y44/LnokomLLNMIlnewoagUwRKUYxBQ9m1CMGKlzepYXpvcU574puZU2htWvICMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g4RK3VEmkB8nnzf1I1M5vVCHF/qeK2sKQ7vprEPym4=;
 b=VGcrbAFfHk3FKr9w1UxaI5YeIjnBdnEHIjpN+Ptycx3UbpoJi2/Ll6uV4ZXW4miL9yOTWSOOfaVSjImjkd+yLr29dZupPHC0Sd5laci8i/lfd1XXvP+TPO5XHJudrBHoEPd5zNxFIxPyLboO9UXJmECBc7n8tuq68uB5FsTgCn45uf7r1uxW/DtshPU1Ke5XoaOrY71b4IEmP2vo8pr7RMRDcltrSpzgXHESOHAHhI91kCwnPj4wP5smitBHPeco/+D7HWaxkKlw5a+PBjX1inYbArSjWTfmlXezbcRHKat2HmQ8xAPXQfNLmlH0FkwJ3zU4TzoIAV8fvsxqLhredQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g4RK3VEmkB8nnzf1I1M5vVCHF/qeK2sKQ7vprEPym4=;
 b=U761VbfheSjELIbbVwMhKTgbicQzYNK+k3Hd8qlqqcwrCeICpH50pZGDRRoujZuyNDp4RXmWCaJqbGO3MdBjR0X05OCth93EEp5Ia3P/4l68FBJQUdG10XwpLwnCzH5rbzH1xyjY5pfQ+z9mYR86sQ5xbytaQ4RRwGxKGcpyvqw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3770.eurprd04.prod.outlook.com (52.134.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.22; Wed, 9 Oct 2019 08:28:44 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2347.016; Wed, 9 Oct 2019
 08:28:44 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] firmware: imx: Skip return value check for some
 special SCU firmware APIs
Thread-Topic: [PATCH V2] firmware: imx: Skip return value check for some
 special SCU firmware APIs
Thread-Index: AQHVfK0Yhw8grvoW2E2n3r70yUmdBKdO0YaAgAEYy6CAAhJjgIAAAOgg
Date:   Wed, 9 Oct 2019 08:28:44 +0000
Message-ID: <DB3PR0402MB3916CD3B5EC47C023F9D840DF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1570410959-32563-1-git-send-email-Anson.Huang@nxp.com>
 <20191007080135.4e5ljhh6z2rbx5bw@pengutronix.de>
 <AM6PR0402MB39118DABDE62496539D7EE6DF59A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <20191009082455.5hqhotkbozsr7mgo@pengutronix.de>
In-Reply-To: <20191009082455.5hqhotkbozsr7mgo@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff5fea14-3243-438b-f61a-08d74c92b299
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB3PR0402MB3770:|DB3PR0402MB3770:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB37707D6707E6C7EB2A9D8CD0F5950@DB3PR0402MB3770.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(199004)(189003)(64756008)(66066001)(256004)(45080400002)(76116006)(66946007)(6436002)(8936002)(66446008)(476003)(33656002)(7696005)(99286004)(229853002)(44832011)(486006)(86362001)(6246003)(25786009)(66556008)(53546011)(66476007)(76176011)(6916009)(9686003)(74316002)(54906003)(102836004)(4326008)(305945005)(446003)(7736002)(6506007)(2906002)(81156014)(81166006)(316002)(26005)(186003)(52536014)(71200400001)(71190400001)(5660300002)(55016002)(6306002)(3846002)(8676002)(14454004)(11346002)(478600001)(966005)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3770;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kTke/64SdOqG6pZaaEgFZmMztfYvX/m2bYiYSTSoFnpqHTTZ4erJ6F56DsRA6/7wlA4ybMWvA1mOB0a5y5a1Oap8QadI/wLwye6DPVBGnhG8snbSs03ddijFKgfKYYlKeCDA9zKcPx2LIBWK7OFPyPZpz3qnyuOlOBociEF314vqKOCassLAfpYr58G8BWoalErE+GvgLIq+nQuUqbCyGxf9q0Jfm6qMGE20maNTJ+Z8vfMUTfiurOOEPxCoO9GoyknxJ91a2PrVtd0GPMqnWjSspAH5FXfKyF7VaGzKlSE2PGXGLMp7IiXOorjXcmZTauZn77OESRdzNaaQwaKWTBkW0jJWt6q4U4WfhnYKMVegMx3x4jQc/6O8NNvh9ifbEd1JUlW3vWS0YQ5sXbikT8Piz1szea69e3THDZjdObMwXO2YAOcsz+MKXMeJD1oJZ+zAOC8Mq4/Q/4mp0Ib+fQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5fea14-3243-438b-f61a-08d74c92b299
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 08:28:44.0435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96Fi9l4THHUCwH7951r2fT+OiY85f0kxyAu3S3+42PIVf6mXHfxAG3GAz8jgWckkQRE6nwq29axTkho0tUyEUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmNvDQoNCj4gT24gMTktMTAtMDggMDA6NDgsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+
IEhpLCBNYXJjbw0KPiA+DQo+ID4gPiBPbiAxOS0xMC0wNyAwOToxNSwgQW5zb24gSHVhbmcgd3Jv
dGU6DQo+ID4gPiA+IFRoZSBTQ1UgZmlybXdhcmUgZG9lcyBOT1QgYWx3YXlzIGhhdmUgcmV0dXJu
IHZhbHVlIHN0b3JlZCBpbg0KPiA+ID4gPiBtZXNzYWdlIGhlYWRlcidzIGZ1bmN0aW9uIGVsZW1l
bnQgZXZlbiB0aGUgQVBJIGhhcyByZXNwb25zZSBkYXRhLA0KPiA+ID4gPiB0aG9zZSBzcGVjaWFs
IEFQSXMgYXJlIGRlZmluZWQgYXMgdm9pZCBmdW5jdGlvbiBpbiBTQ1UgZmlybXdhcmUsDQo+ID4g
PiA+IHNvIHRoZXkgc2hvdWxkIGJlIHRyZWF0ZWQgYXMgcmV0dXJuIHN1Y2Nlc3MgYWx3YXlzLg0K
PiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdA
bnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IENoYW5nZXMgc2luY2UgVjE6DQo+ID4gPiA+
IAktIFVzZSBkaXJlY3QgQVBJIGNoZWNrIGluc3RlYWQgb2YgY2FsbGluZyBhbm90aGVyIGZ1bmN0
aW9uIHRvIGNoZWNrLg0KPiA+ID4gPiAJLSBUaGlzIHBhdGNoIGlzIGJhc2VkIG9uDQo+ID4gPiA+
IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRg0KPiA+ID4gPiBwYXRjDQo+ID4gPiA+DQo+ID4gPg0KPiBod29yay5rZXJuZWwu
b3JnJTJGcGF0Y2glMkYxMTEyOTU1MyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uDQo+ID4g
PiBodWFuZyUNCj4gPiA+ID4NCj4gPiA+DQo+IDQwbnhwLmNvbSU3QzJkZTBhNmJlNjliNzRjYzI0
OWFkMDhkNzRhZmM5NzMwJTdDNjg2ZWExZDNiYzJiNGM2Zg0KPiA+ID4gYTkyY2Q5OQ0KPiA+ID4g
Pg0KPiA+ID4NCj4gYzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcwNjAzMjEwNDYyNDcwNDAmYW1wO3Nk
YXRhPVJNRkFkTEtHS2I2DQo+ID4gPiBtRWRoeWNyekhYDQo+ID4gPiA+IFIwM0U2UXI1cFd5UmM4
Wms2RXJsQmMlM0QmYW1wO3Jlc2VydmVkPTANCj4gPiA+DQo+ID4gPiBUaGFua3MgZm9yIHRoaXMg
djIuIEl0IHdvdWxkIGJlIGdvb2QgdG8gY2hhbmdlIHRoZSBjYWxsZXJzIHdpdGhpbiB0aGlzDQo+
IHNlcmllcy4NCj4gPg0KPiA+IE5PVCBxdWl0ZSB1bmRlcnN0YW5kIHlvdXIgcG9pbnQsIHRoZSBj
YWxsZXJzIGRvZXMgTk9UIG5lZWQgdG8gYmUNCj4gPiBjaGFuZ2VkLCB0aG9zZQ0KPiA+IDIgc3Bl
Y2lhbCBBUElzIGNhbGxlcnMgYXJlIGFscmVhZHkgZm9sbG93aW5nIHRoZSByaWdodCB3YXkgb2Yg
Y2FsbGluZyB0aGUgQVBJcy4NCj4gDQo+IEFoIG9rYXkuIEkgc2VhcmNoZWQgdGhlIDUuNC1yYzIg
dGFnIGFuZCBmb3VuZCB0aGUgc29jX3VpZF9zaG93KCkgYXMgb25seQ0KPiB1c2VyIGJ1dCB0aGlz
IHVzZXIgc2V0cyB0aGUgaGF2ZV9yZXNwIGZpZWxkIHRvIGZhbHNlLiBJcyB0aGlzIGludGVuZGVk
Pw0KDQpJIGFscmVhZHkgZml4ZWQgaXQgYW5kIHBhdGNoIGFwcGxpZWQgYnkgU2hhd24sIHNlZSBi
ZWxvdzoNCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTEyOTQ5Ny8NCg0K
QW5zb24NCg0K
