Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5EA2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lsc6i+02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfC1L16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:27:58 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:6979
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbfC1L15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCRWi6j7zkgOjGFWSFdHS+O3aQ9W4n65rRosgydXP3w=;
 b=Lsc6i+020i7LlFnPTVQriQFztSKrcn0VI1y/tvENcFWN/eLB0EH7+Vp0ie7Zkgd2kjSbYBLj6T8i/S7zBx9iWV+LkIATpzZg0JEhuMxeawH+fvdEbjK20ERdeKzzhEWlSFqojaxdAgg/aF51UkL8rauiwI8uXCV3yZoEjAEAuuI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4707.eurprd04.prod.outlook.com (20.176.214.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Thu, 28 Mar 2019 11:27:53 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b%4]) with mapi id 15.20.1750.014; Thu, 28 Mar 2019
 11:27:53 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Thread-Topic: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI
 wakeup
Thread-Index: AQHU5J/uL6RBBX3AA0GxPKCBIrMc4KYfnrmAgAADs4CAAAJMgIAAG7sAgAACtgCAASScYA==
Date:   Thu, 28 Mar 2019 11:27:53 +0000
Message-ID: <AM0PR04MB4211673DC2071A6181B0948880590@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
         <1553701479.2561.38.camel@pengutronix.de>
         <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
         <1553702767.2561.40.camel@pengutronix.de>
         <85c91392-9cbf-a5fc-b037-3d58f2b0ac9c@arm.com>
 <1553709304.2561.44.camel@pengutronix.de>
In-Reply-To: <1553709304.2561.44.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2104fcf7-d8d5-4ad7-6024-08d6b3706b05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4707;
x-ms-traffictypediagnostic: AM0PR04MB4707:
x-microsoft-antispam-prvs: <AM0PR04MB470732152A839D32835C03EE80590@AM0PR04MB4707.eurprd04.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(51914003)(256004)(14444005)(25786009)(99286004)(44832011)(2501003)(102836004)(186003)(7696005)(486006)(26005)(6506007)(55016002)(476003)(53936002)(68736007)(4326008)(11346002)(76176011)(8936002)(6246003)(81166006)(81156014)(446003)(9686003)(8676002)(93886005)(6436002)(54906003)(6636002)(105586002)(71190400001)(86362001)(5660300002)(74316002)(2906002)(52536014)(14454004)(110136005)(305945005)(7416002)(66066001)(33656002)(478600001)(229853002)(316002)(6116002)(3846002)(106356001)(71200400001)(7736002)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4707;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CUJNFGxDdLV3loHJdg6eai49k3BPSZqjomFriBcmE2/eoCazJxYXZZmSSS3M59YS4W4iSSBox2iNOnfTHjnzHqYOy8tzdw5bjUFFUN6B5RcUthuQgiLQ4pVqEnC8q8HYtrkNlNOeBPyl8fYi4aHYQwAI+TPiC7RPoSk5ydZR5JbR2ModaJQBp1jExelbVSKmiv4YbTFqx9q7xPZc5RQc4C0poFgyLUfHsvSBQwD//zi+nEgCnnLsKLxJnS2zevPZW8VayWscqR2VO9XLgT0TlZ7y0pwRGB9pnDXlbvf5RXLaK0PbnSZQQB3gxpB1lYD5TCneck+/xcBIXHS9XfwFEqEoTIE1UDQdByHduC9/EQYUYJ6R69SVmksYYx2YQSzDGIF7byEAbk7yZvRG/ywFCknmwx0OVBzB/zw0p4oPlvE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2104fcf7-d8d5-4ad7-6024-08d6b3706b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 11:27:53.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wy4uLl0NCj4gPiA+IEFueXRoaW5nIHRoYXQgaXNuJ3QgdmlzaWJsZSB0byB0aGUgR1BDIGFuZCBy
ZXF1aXJlcyB0aGUgR0lDDQo+ID4gPiB3YWtlX3JlcXVlc3Qgc2lnbmFsIHRvIGJlaGF2ZSBhcyBz
cGVjaWZpZWQgaXMgYnJva2VuIGJ5IHRoaXMgZXJyYXR1bS4NCj4gPg0KPiA+IEkgcmVhbGx5IHdv
bmRlciBob3cgYSB0aW1lciBpbnRlcnJ1cHQgKGEgUFBJLCBoZW5jZSBub3Qgcm91dGVkIHRocm91
Z2gNCj4gPiB0aGUgR1BDKSBjYW4gd2FrZSB1cCB0aGUgQ1BVIGluIHRoaXMgY2FzZS4gSXQgcmVh
bGx5IGZlZWxzIGxpa2UNCj4gPiBzb21ldGhpbmcgbGlrZSAicHJvZ3JhbSBDTlRWX0NWQUxfRUww
IHRvIGV4cGlyZSBhdCBzb21lIGxhdGVyIHBvaW50Ow0KPiA+IFdGSSIgY291bGQgcmVzdWx0IGlu
IHRoZSBDUFUgZ29pbmcgdG8gYSBkZWVwIHNsZWVwIHN0YXRlLCBhbmQgbm90DQo+ID4gd2FrZS11
cCBhdCBhbGwuDQo+IA0KPiBJIGd1ZXNzIGl0J3MgYnJva2VuIGluIHRoZSBzYW1lIHdheS4gVGhl
IGRvd25zdHJlYW0gRFQgY2xhaW1zDQo+ICJsb2NhbC10aW1lci1zdG9wIiBmb3IgdGhlIENQVSBz
bGVlcCBzdGF0ZSBhbmQgImFybSxuby10aWNrLWluLXN1c3BlbmQiDQo+IGZvciB0aGUgYXJtdjgt
dGltZXIsIHdoaWNoIEkgZ3Vlc3MgaXMgbm90IHRoZSB0aW1lciBhY3R1YWxseSBzdG9wcGluZyBp
biBzdXNwZW5kLA0KPiBidXQgdGhlIENQVSBiZWluZyB1bmFibGUgdG8gd2FrZSB1cCBkdWUgdG8g
dGhlIHRpbWVyIElSUS4NCj4gDQo+ID4gVGhpcyB3b3VsZCBpbmRpY2F0ZSB0aGF0IG5vdCBvbmx5
IGNwdWlkbGUgaXMgYnJva2VuIHdpdGggdGhpcywgYnV0DQo+ID4gYWJzb2x1dGVseSBldmVyeSBp
bnRlcnJ1cHQgdGhhdCBpcyBub3Qgcm91dGVkIHRocm91Z2ggdGhlIEdQQy4NCj4gDQo+IFRoYXQn
cyBteSB1bmRlcnN0YW5kaW5nIGFzIHdlbGwuIE5vdGUgdGhhdCBJIGhhdmUgbm8gTlhQIGludGVy
bmFsIGluZm9ybWF0aW9uDQo+IGFuZCBjYW4gb25seSBpbmZlciBmcm9tIHRoZSBwdWJsaXNoZWQg
cmVmZXJlbmNlIG1hbnVhbCwgZXJyYXRhIG5vdGljZSBhbmQNCj4gZG93bnN0cmVhbSBrZXJuZWwu
DQo+IA0KDQpXZSB3aWxsIGRvdWJsZSBjaGVjayBpdC4NClRoYW5rcyBmb3IgdGhlIGluZm9ybWF0
aW9uLg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg0KPiBSZWdhcmRzLA0KPiBMdWNhcw0K
