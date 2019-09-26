Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F6AC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3F021A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mBz/EbKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfIZIDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:03:10 -0400
Received: from mail-eopbgr20076.outbound.protection.outlook.com ([40.107.2.76]:5191
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727941AbfIZIDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:03:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcluinXr5u9LX5+Ep/9bs9cdmdoHe56653zEstnmSC7Q3EBf0//PIsvXQPV8dFtlLZpKSpjSxUzuJSEEsvj8DWfXM1hx+8TaZTvE+/i4aLC40dzrGMNglSe9idZuaBjL14Jbmuz+bx6HUIyPM9+dkGFpop/x5QyqCDqU40driYF+fRLzEuT7TCHZdOg7G/Jtt9rfIDSLjkTjFY2BYIxg6F1F0j4jhXjLE2ttPncVWQ9h4SaxX4nP/J9eJlgAyoxDzXqhlRASE0+tY4CEVrqOTB84lgmTz92k9IVTIrS2cJEzdLrl9+X+eZ4i+KNOkNXwl/Wqew6gRYdQa1yNhDRADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUigfO2G3aNApvlxY6j6Lppk+xtWZGsqgemnc1PXHn8=;
 b=Lxj0inqOVVCnskhrVefzm3Ep394XbJc6Mr7BZANYdsPHzO0iBf/AjxWZ+Ds8tmqVxAuM4cykkIPA5ZowLJZrb+1gKGTnHLmkWRHVBmkQ4Ggriy6Wos1jCv5plMdw6FDLi/r+8163qiLg+VfSA/04P65HPq0pkqKxrN+SqJZDOlFMQuJ6nsohVDCZhFMokQ3nfpnddUql4MknPfmUstulKsuHfPCXZGHGultxidpGgWg4zNYPLsq7vHp+Y3AlkWRzUWScAyuMtVojenoSnk5swzyhS0qWRUvf3vMxpomxmHUlK4SviKUvWyixCSf4ZuJisPQWTO3Jd1w7elqZOOJNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUigfO2G3aNApvlxY6j6Lppk+xtWZGsqgemnc1PXHn8=;
 b=mBz/EbKrZqeFAMnydEyKkh2Cw55NhLo5GtXOaOVINPOzNORgOoraAsYVd/lrE/FKf9SMwSeqrclao1geS562gvPuvNCftPL2bZJP+OEPgUCRlMfd0U6EqGtBODBah5u52Yi7wxXrtNSYkvyflzkI6UE3mr2xpjb5M3hoIHcKl64=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3900.eurprd04.prod.outlook.com (52.134.71.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Thu, 26 Sep 2019 08:03:01 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2284.028; Thu, 26 Sep 2019
 08:03:01 +0000
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
Subject: RE: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Topic: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Index: AQHVc4lT/ErvPybCJUCbZ2x7mLGjsqc9mYAAgAAANtA=
Date:   Thu, 26 Sep 2019 08:03:01 +0000
Message-ID: <DB3PR0402MB391683202692BEAE4D2CD9C1F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
 <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
In-Reply-To: <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61aef425-6e4c-4215-0bba-08d74257f3b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3900;
x-ms-traffictypediagnostic: DB3PR0402MB3900:|DB3PR0402MB3900:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB390041FEE4C5C2B6F12C0536F5860@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(76176011)(8676002)(4326008)(305945005)(66556008)(76116006)(64756008)(486006)(2906002)(71190400001)(6246003)(476003)(9686003)(74316002)(45080400002)(6436002)(55016002)(44832011)(52536014)(66946007)(6306002)(66446008)(66476007)(229853002)(7736002)(71200400001)(66066001)(256004)(33656002)(478600001)(6116002)(3846002)(81156014)(5660300002)(11346002)(102836004)(86362001)(8936002)(186003)(966005)(54906003)(446003)(6506007)(99286004)(14454004)(7696005)(6916009)(53546011)(26005)(316002)(81166006)(25786009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3900;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GyEdOr56flwaxBF0XfzC/fw4XoeC1HDEtZ/2pwcRtmqTvANYRuFnq+lqBJvLlQFugtrc4f8sfEqHvWy7CWQG5vYbSIBBc46amiFJ0WjLaJdf7ZZNRBIP5M/bka9Sm0o7escSe1c/bSA9nZ8LwluM1fGeehRMAOx9VbvgyUifsaTRYQgYywCbiLsM/xEQBlTRgmxAq0Gfw7oxEK7Ho/UIDVpEZ4EChlZARoEVWuQ/6ocHV74biOyhEkEmyYIrDL8A81cwWyNAUaDGnczdkir3reZPljVCnO2JQS07kV0yXR8piUfTmRRUbbPM0XHOfGidhrn8G0jSOfxyXpJ5oLRsXb1kpR5LDIFFcE8Gqf7+Hwq4/0oYLUouV9I/gB10Mt/VtA/MtcqqILCvWKVJlXsXNXDPYbWaFJqqhQuAPsdQLro=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61aef425-6e4c-4215-0bba-08d74257f3b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 08:03:01.2993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Nh03er2WrEVRcbQfYNxfidMLhbopbXyURiJZJ+LasWKJkh9NMxn+c9X31+EhLae+jXcl8QnTsu/2YcTGGRoKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmNvDQoNCj4gT24gMTktMDktMjUgMTg6MDcsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+
IFRoZSBTQ1UgZmlybXdhcmUgZG9lcyBOT1QgYWx3YXlzIGhhdmUgcmV0dXJuIHZhbHVlIHN0b3Jl
ZCBpbiBtZXNzYWdlDQo+ID4gaGVhZGVyJ3MgZnVuY3Rpb24gZWxlbWVudCBldmVuIHRoZSBBUEkg
aGFzIHJlc3BvbnNlIGRhdGEsIHRob3NlDQo+ID4gc3BlY2lhbCBBUElzIGFyZSBkZWZpbmVkIGFz
IHZvaWQgZnVuY3Rpb24gaW4gU0NVIGZpcm13YXJlLCBzbyB0aGV5DQo+ID4gc2hvdWxkIGJlIHRy
ZWF0ZWQgYXMgcmV0dXJuIHN1Y2Nlc3MgYWx3YXlzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
QW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gCS0gVGhpcyBw
YXRjaCBpcyBiYXNlZCBvbiB0aGUgcGF0Y2ggb2YNCj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwYXRjDQo+ID4NCj4g
aHdvcmsua2VybmVsLm9yZyUyRnBhdGNoJTJGMTExMjk1NTMlMkYmYW1wO2RhdGE9MDIlN0MwMSU3
Q2Fuc29uLg0KPiBodWFuZyUNCj4gPg0KPiA0MG54cC5jb20lN0MxZjQxMDhjYzI1ZWI0NjE4ZjQz
YzA4ZDc0MjU3NmZhMyU3QzY4NmVhMWQzYmMyYjRjNmZhDQo+IDkyY2Q5OQ0KPiA+DQo+IGM1YzMw
MTYzNSU3QzAlN0MwJTdDNjM3MDUwODE1NjA4OTYzNzA3JmFtcDtzZGF0YT1CWkJnNGNPUjJyUCUy
DQo+IEJSQk5uMTVpDQo+ID4gUXEzJTJGWEJZd2h1Q0xrZ1l6RlJiZkVnVlUlM0QmYW1wO3Jlc2Vy
dmVkPTANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS5jIHwgMzQN
Cj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAzMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UuYw0KPiA+IGIvZHJpdmVycy9maXJtd2Fy
ZS9pbXgvaW14LXNjdS5jIGluZGV4IDg2OWJlN2EuLmNlZDViMTIgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS5jDQo+ID4gKysrIGIvZHJpdmVycy9maXJtd2Fy
ZS9pbXgvaW14LXNjdS5jDQo+ID4gQEAgLTc4LDYgKzc4LDExIEBAIHN0YXRpYyBpbnQgaW14X3Nj
X2xpbnV4X2Vycm1hcFtJTVhfU0NfRVJSX0xBU1RdID0NCj4gew0KPiA+ICAJLUVJTywJIC8qIElN
WF9TQ19FUlJfRkFJTCAqLw0KPiA+ICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
aW14X3NjX3JwY19tc2cgd2hpdGVsaXN0W10gPSB7DQo+ID4gKwl7IC5zdmMgPSBJTVhfU0NfUlBD
X1NWQ19NSVNDLCAuZnVuYyA9DQo+IElNWF9TQ19NSVNDX0ZVTkNfVU5JUVVFX0lEIH0sDQo+ID4g
Kwl7IC5zdmMgPSBJTVhfU0NfUlBDX1NWQ19NSVNDLCAuZnVuYyA9DQo+ID4gK0lNWF9TQ19NSVND
X0ZVTkNfR0VUX0JVVFRPTl9TVEFUVVMgfSwgfTsNCj4gDQo+IElzIHRoaXMgZ29pbmcgdG8gYmUg
ZXh0ZW5kZWQgaW4gdGhlIG5lYXIgZnV0dXJlPyBJIHNlZSBzb21lIHVwY29taW5nDQo+IHByb2Js
ZW1zIGhlcmUgaWYgc29tZW9uZSB1c2VzIGEgZGlmZmVyZW50IHNjdS1mdzwtPmtlcm5lbCBjb21i
aW5hdGlvbiBhcw0KPiBueHAgd291bGQgc3VnZ2VzdC4NCg0KQ291bGQgYmUsIGJ1dCBJIGNoZWNr
ZWQgdGhlIGN1cnJlbnQgQVBJcywgT05MWSB0aGVzZSAyIHdpbGwgYmUgdXNlZCBpbiBMaW51eCBr
ZXJuZWwsIHNvDQpJIE9OTFkgYWRkIHRoZXNlIDIgQVBJcyBmb3Igbm93Lg0KDQpIb3dldmVyLCBh
ZnRlciByZXRoaW5rLCBtYXliZSB3ZSBzaG91bGQgYWRkIGFub3RoZXIgaW14X3NjX3JwYyBBUEkg
Zm9yIHRob3NlIHNwZWNpYWwNCkFQSXM/IFRvIGF2b2lkIGNoZWNraW5nIGl0IGZvciBhbGwgdGhl
IEFQSXMgY2FsbGVkIHdoaWNoIG1heSBpbXBhY3Qgc29tZSBwZXJmb3JtYW5jZS4NClN0aWxsIHVu
ZGVyIGRpc2N1c3Npb24sIGlmIHlvdSBoYXZlIGJldHRlciBpZGVhLCBwbGVhc2UgYWR2aXNlLCB0
aGFua3MhDQoNCkFuc29uDQo=
