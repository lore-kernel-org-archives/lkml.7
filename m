Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99D2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF2020700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uwhXRaC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfC1Lze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:55:34 -0400
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:40798
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbfC1Lze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VxAmfcqeFGvYjSK3Ydf7Af2D6gJXPdS0o4RSdxO7HM=;
 b=uwhXRaC9pXtWo37orfWIXES9k6epS6FysFQANASATqKHtmlIr+pK/FFR/6S3LOSdknb+63KYwi/qvDraFzCHDm166206Q5EqTrljy2XU3fCk6j3gU3snAbyY3bYVP2g9dLmuju8lEhRi86pH4JcYG8gCuSk3NuN8dZjbByEVktA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4995.eurprd04.prod.outlook.com (20.176.215.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Thu, 28 Mar 2019 11:55:30 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b%4]) with mapi id 15.20.1750.014; Thu, 28 Mar 2019
 11:55:30 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Anson Huang <anson.huang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Thread-Topic: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI
 wakeup
Thread-Index: AQHU5J/uL6RBBX3AA0GxPKCBIrMc4KYfnrmAgAADs4CAAAJMgIAAG7sAgAAPSwCAAQrngIAAEy9A
Date:   Thu, 28 Mar 2019 11:55:30 +0000
Message-ID: <AM0PR04MB42119717B5EC292411963EE380590@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
 <1553701479.2561.38.camel@pengutronix.de>
 <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
 <1553702767.2561.40.camel@pengutronix.de>
 <85c91392-9cbf-a5fc-b037-3d58f2b0ac9c@arm.com>
 <cb2e5521cc0d29b7c3ac42a6717256ec2e8d35e6.camel@nxp.com>
 <b90bd658-a29d-ea16-abf4-95b388467c8c@arm.com>
In-Reply-To: <b90bd658-a29d-ea16-abf4-95b388467c8c@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f339f098-ac02-431a-42bd-08d6b37446da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4995;
x-ms-traffictypediagnostic: AM0PR04MB4995:
x-microsoft-antispam-prvs: <AM0PR04MB4995F315645783C83C1BE1D280590@AM0PR04MB4995.eurprd04.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(51914003)(44832011)(71200400001)(25786009)(14444005)(256004)(2906002)(52536014)(14454004)(97736004)(478600001)(229853002)(66066001)(33656002)(71190400001)(2501003)(6436002)(106356001)(105586002)(11346002)(476003)(102836004)(76176011)(93886005)(6506007)(53936002)(86362001)(99286004)(6246003)(186003)(7696005)(486006)(446003)(81166006)(8676002)(55016002)(8936002)(74316002)(54906003)(110136005)(316002)(4326008)(6116002)(5660300002)(7736002)(7416002)(305945005)(9686003)(81156014)(26005)(68736007)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4995;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ylx/JFa4Yk7CLMlKq1DYeLkmFC8Rx2uY7KsdyitbvacbXCIQG3TUYoPqgA9YZsuOxrGPGJyo8hAXA7UKAf8B7d1RZJhmo1CUNGezbGLrU6HM10f8Jh6jAMLVD9rJtBFhLj+UdErQ+i2dq/fNr1Ugxx0rdoCvvv0AK+Prcrrt839IsJfK9ULSKvGypUJpyEle+Uj62FQOS3QpDg4jPg+jigFO/+4I9AhQLN3qf8tF1+dXpgxAM4pQbMLrGmwpNOUA77LvcnoQldv6k2Pjx8q/9Iymooqt8GoqKQaIFRx0KdjNSSuEruu0L6MAyN0hSbO4u59tfZVYpL++WkWtKqryev7rp2BkvIDDavujaMkkEgLgeHW9KrV4mP4k5zxi0VKW0ED+X7F+vqRQPyMNmI9qa1PDoP/daZo1Jd93jjxvWyo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f339f098-ac02-431a-42bd-08d6b37446da
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 11:55:30.4630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4995
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wy4uLl0NCg0KPiA+ICogQWxsIFNQSXMgYXJlIGNvbm5lY3RlZCB0byBHUEMgaW4gYSAxOjEgbWFw
cGluZw0KPiA+ICogVGhpcyBzZXJpZXMgZGVhbHMgd2l0aCBTR0lzDQo+ID4gKiBUaGUgdGltZXIg
UFBJcyBhcmUgbm90IHJlcXVpcmVkOyBjb3ZlcmVkIGJ5IGxvY2FsLXRpbWVyLXN0b3ANCj4gPiAq
IExQSXMgYXJlIGN1cnJlbnRseSB1bnVzZWQgKEkgdW5kZXJzdGFuZCBpbXgtcGNpIHVzZXMgU1BJ
IGJ5IGRlZmF1bHQNCj4gPiBmcm9tIEx1Y2FzKQ0KPiA+DQo+ID4gQW55dGhpbmcgbWlzc2luZz8N
Cj4gPg0KPiA+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGlzIHdha2UgcmVxdWVzdCBmZWF0
dXJlIHZpYSBHSUMgaXMgbmV3IGluDQo+ID4gdjMgYW5kIHRoaXMgaXMgbWF5YmUgd2h5IEhXIHRl
YW0gbWlzc2VkIGl0IGR1cmluZyBpbnRlZ3JhdGlvbi4gT2xkZXINCj4gPiBpbXg2LzcgaGFzIEdJ
Q3YyIGFuZCBoYXMgZGVlcCBpZGxlIHN0YXRlcyB3aGljaCBhbHdheXMgcmVseSBvbiBHUEMgdG8N
Cj4gPiB3YWtldXAgc28gdGhlIGFwcHJvYWNoIGNhbiB3b3JrLg0KPiANCj4gQ2VydGFpbmx5IHRo
ZSBhcHByb2FjaCBjYW4gd29yay4gVGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIgd2Ugd2FudCB0byBz
dXBwb3J0DQo+IHRoaXMgaW4gYSBtYWlubGluZSBrZXJuZWwsIHNwcmVhZGluZyByYW5kb20gaG9v
a3MgaW4gdGhlIGdlbmVyaWMgY29kZSBhbmQNCj4gYWRkaW5nIGEgZmlybXdhcmUgaW50ZXJmYWNl
IG9uIHRvcCBvZiB0aGF0Lg0KPiANCj4gQnkgYWxsIGFjY291bnRzLCB0aGlzIEhXIGlzIGJyb2tl
bi4gWW91IGNhbiBpbmRlZWQgaW1wb3NlIGxpbWl0YXRpb25zIChkdW1iDQo+IGRvd24gUENJLCBt
YW5kYXRlIHRoZSB1c2Ugb2YgYSBicm9hZGNhc3QgdGltZXIpLCBvciB5b3UgY2FuIGp1c3QgZmxh
ZyBjcHVpZGxlDQo+IGFzIHVuc3VwcG9ydGVkIG9uIHRoaXMgSFcuIE15IHZvdGUgaXMgb24gdGhl
IGxhdHRlci4NCj4gDQoNCkhpIE1hcmMsIFJhZmFlbCwgTG9yZW56byANCg0KVGhhbmtzIGZvciB0
aGUgc3VnZ2VzdGlvbi4gSSBmdWxseSB1bmRlcnN0YW5kIHRoZSBjb25jZXJuLg0KRG8geW91IHRo
aW5rIHdlIGNhbiBwYXRjaCB0aGUgcGxhdGZvcm0gY29kZSB0byBhZGRyZXNzIHRoZSBpc3N1ZSB0
byBhdm9pZA0KdGhlIGJpZyBjaHVybiBvbiBrZXJuZWwgY29yZSBjb2RlPw0KDQpJZiB5ZXMsIHdl
IGNvdWxkIHRyeSB0byBpbnZlc3RpZ2F0ZSBpZiB0aGVyZSdzIGEgc3VpdGFibGUgcGxhY2UgdG8g
ZG8gdGhhdC4NClRoZSBtYWluIHRoaW5nIHdlIG5lZWQgdG8gZG8gc2VlbXMgbGlrZSB0byBtYW51
YWxseSB3YWtldXAgY3B1IGNvcmUNCmR1cmluZyB0aGUgc2VuZGluZyBJUEkgcGF0aCB3aGVuIGV4
aXQgaWRsZS4gV2UgY291bGQgc2VlIGlmIHRoZXJlJ3MgY2hhbmNlDQp0byBkbyBpdCBvbiB0aGF0
IHBhdGguDQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+IFRoYW5rcywNCj4gDQo+IAlNLg0K
PiAtLQ0KPiBKYXp6IGlzIG5vdCBkZWFkLiBJdCBqdXN0IHNtZWxscyBmdW5ueS4uLg0K
