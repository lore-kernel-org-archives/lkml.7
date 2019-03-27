Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0512C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82772075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X7N9vDyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404008AbfC0SkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:40:16 -0400
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:14175
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391046AbfC0SkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8rw+wHOGFYHNOfVf8hGO/HG0SCOcp/4cNhIwpCp96o=;
 b=X7N9vDyFvQ/DBfovPuVayLeB/e+/lDuA765G0MA/xb6apzPjqYSqnnpIZmAJvUEOY9RV13jfLL7GBxZzCt8TCIjF32cj/9gQVEo+KCkshuDeV4Irv0peSB3fPUxduvPXdZkKIxt71IVNA/G/E4dTTAHP2l/DUXnUsFpmqo0Hjtw=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB3214.eurprd04.prod.outlook.com (10.170.227.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Wed, 27 Mar 2019 18:40:07 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::35aa:e13a:52ea:e5e6]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::35aa:e13a:52ea:e5e6%4]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 18:40:07 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
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
Subject: Re: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Thread-Topic: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI
 wakeup
Thread-Index: AQHU5J/uL6RBBX3AA0GxPKCBIrMc4KYfnrmAgAADs4CAAAJMgIAAG7sAgAAPSwA=
Date:   Wed, 27 Mar 2019 18:40:07 +0000
Message-ID: <cb2e5521cc0d29b7c3ac42a6717256ec2e8d35e6.camel@nxp.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
         <1553701479.2561.38.camel@pengutronix.de>
         <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
         <1553702767.2561.40.camel@pengutronix.de>
         <85c91392-9cbf-a5fc-b037-3d58f2b0ac9c@arm.com>
In-Reply-To: <85c91392-9cbf-a5fc-b037-3d58f2b0ac9c@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 576f9c5a-28e5-454a-3a02-08d6b2e3a26e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3214;
x-ms-traffictypediagnostic: VI1PR04MB3214:
x-microsoft-antispam-prvs: <VI1PR04MB3214BBB53373E08CBEE79389EE580@VI1PR04MB3214.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(39860400002)(346002)(199004)(189003)(71190400001)(486006)(256004)(14444005)(14454004)(186003)(53546011)(44832011)(6116002)(6486002)(478600001)(229853002)(6436002)(3846002)(4326008)(6512007)(81156014)(81166006)(25786009)(305945005)(8676002)(118296001)(66066001)(6636002)(53936002)(106356001)(97736004)(105586002)(7416002)(446003)(93886005)(54906003)(110136005)(316002)(7736002)(68736007)(6506007)(2501003)(99286004)(5660300002)(86362001)(26005)(76176011)(2616005)(71200400001)(476003)(102836004)(50226002)(11346002)(8936002)(2906002)(36756003)(6246003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3214;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U0ChtDnwpg+ALZq4yCxxWHnmRCK0/i5Deh1yZ/YRQ8hipECobkStNvICGKUOyH9KhOr4Tv/X4FvEf5AVmGnOkvg+KyTyZJ/PLv6dIB5vNHluysoR54+aBpyuLXdgbdbz5JN79WfPBHyUNMSue3/cpBIvLpge19xWxJXDSHFOxrmETIoofb8viJ4TzIILrGWtTDIIDovk7OIdPp9D51oQ4+4TGT0V2nls297dwezwhaA/3uZFSjNwX0w0js3XZ3OLb7KElM3UzlkB2h5dFy0u2o4QXXRtqhhSUtyGTI/TnHzTep9bWrY1d3weBneHmtX6BAzKY14hnCzVUDjq3wIhKcIQcKJSJ1Hw0BxR889hLUQBu1lGy/LLmNrwirwzLFEk4Pe2tYZIDr3rFQyUJBL8pYzqXvdM8/tD2dBLI6KafFs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8783C4B4E8222A499CD541DF8BB5C3CD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576f9c5a-28e5-454a-3a02-08d6b2e3a26e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 18:40:07.0946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAzLTI3IGF0IDE3OjQ1ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIDI3LzAzLzIwMTkgMTY6MDYsIEx1Y2FzIFN0YWNoIHdyb3RlOg0KPiA+IEFtIE1pdHR3b2No
LCBkZW4gMjcuMDMuMjAxOSwgMTU6NTcgKzAwMDAgc2NocmllYiBNYXJjIFp5bmdpZXI6DQo+ID4g
PiBPbiAyNy8wMy8yMDE5IDE1OjQ0LCBMdWNhcyBTdGFjaCB3cm90ZToNCj4gPiA+ID4gQW0gTWl0
dHdvY2gsIGRlbiAyNy4wMy4yMDE5LCAxMzoyMSArMDAwMCBzY2hyaWViIEFiZWwgVmVzYToNCj4g
PiA+ID4gPiBUaGlzIHdvcmsgaXMgYSB3b3JrYXJvdW5kIEknbSBsb29raW5nIGludG8gKG1vcmUg
YXMgYSBiYWNrZ3JvdW5kIHRhc2spDQo+ID4gPiA+ID4gaW4gb3JkZXIgdG8gYWRkIHN1cHBvcnQg
Zm9yIGNwdWlkbGUgb24gaS5NWDhNUSBiYXNlZCBwbGF0Zm9ybXMuDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gVGhlIG1haW4gaWRlYSBoZXJlIGlzIGdldHRpbmcgYXJvdW5kIHRoZSBtaXNzaW5nIEdJ
QyB3YWtlX3JlcXVlc3Qgc2lnbmFsDQo+ID4gPiA+ID4gKGR1ZSB0byBpbnRlZ3JhdGlvbiBkZXNp
Z24gaXNzdWUpIGJ5IHdha2luZyB1cCBhIGVhY2ggaW5kaXZpZHVhbCBjb3JlIHRocm91Z2gNCj4g
PiA+ID4gPiBzb21lIGRlZGljYXRlZCBTVyBwb3dlci11cCBiaXRzIGluc2lkZSB0aGUgcG93ZXIg
Y29udHJvbGxlciAoR1BDKSByaWdodCBiZWZvcmUNCj4gPiA+ID4gPiBldmVyeSBJUEkgaXMgcmVx
dWVzdGVkIGZvciB0aGF0IGVhY2ggaW5kaXZpZHVhbCBjb3JlLg0KPiA+ID4gPiANCj4gPiA+ID4g
SnVzdCBhIGdlbmVyYWwgY29tbWVudCwgd2l0aG91dCBnb2luZyBpbnRvIHRoZSBkZXRhaWxzIG9m
IHRoaXMgc2VyaWVzOg0KPiA+ID4gPiB0aGlzIGlzc3VlIGlzIG5vdCBvbmx5IGFmZmVjdGluZyBJ
UElzLCBidXQgYWxzbyBNU0lzIHRlcm1pbmF0ZWQgYXQgdGhlDQo+ID4gPiA+IEdJQy4gQ3VycmVu
dGx5IE1TSXMgYXJlIHRlcm1pbmF0ZWQgYXQgdGhlIFBDSWUgY29yZSwgYnV0IHRlcm1pbmF0aW5n
DQo+ID4gPiA+IHRoZW0gYXQgdGhlIEdJQyBpcyBjbGVhcmx5IHByZWZlcmFibGUsIGFzIHRoaXMg
YWxsb3dzIGFzc2lnbmluZyBDUFUNCj4gPiA+ID4gYWZmaW5pdHkgdG8gaW5kaXZpZHVhbCBNU0lz
IGFuZCBsb3dlcnMgSVJRIHNlcnZpY2Ugb3ZlcmhlYWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBJJ20g
bm90IHN1cmUgd2hhdCB0aGUgY29uc2VxdWVuY2VzIGFyZSBmb3IgdXBzdHJlYW0gTGludXggc3Vw
cG9ydCB5ZXQsDQo+ID4gPiA+IGJ1dCB3ZSBzaG91bGQga2VlcCBpbiBtaW5kIHRoYXQgaGF2aW5n
IGEgd29ya2Fyb3VuZCBmb3IgSVBJcyBpcyBvbmx5DQo+ID4gPiA+IHNvbHZpbmcgcGFydCBvZiB0
aGUgaXNzdWUuDQo+ID4gPiANCj4gPiA+IElmIHRoaXMgZXJyYXR1bSBpcyBhZmZlY3RpbmcgbW9y
ZSB0aGFuIGp1c3QgSVBJcywgdGhlbiBpbmRlZWQgSSBkb24ndA0KPiA+ID4gc2VlIGhvdyB0aGlz
IHBhdGNoIHNlcmllcyBzb2x2ZXMgYW55dGhpbmcuDQo+ID4gPiANCj4gPiA+IEJ1dCB0aGUgZXJy
YXR1bSBkb2N1bWVudGF0aW9uIHNlZW1zIHRvIGltcGx5IHRoYXQgb25seSBTR0lzIGFyZQ0KPiA+
ID4gYWZmZWN0ZWQsIGFuZCBnb2VzIGFzIGZhciBhcyBzdWdnZXN0aW5nIHRvIHVzZSBhbiBleHRl
cm5hbCBpbnRlcnJ1cHQNCj4gPiA+IHdvdWxkIHNvbHZlIGl0LiBIb3cgY29tZXMgdGhpcyBpcyBu
b3QgdGhlIGNhc2U/IE9yIGlzIGl0IHRoYXQgYW55dGhpbmcNCj4gPiA+IGRpcmVjdGx5IHJvdXRl
ZCB0byBhIHJlZGlzdHJpYnV0b3IgaXMgYWxzbyBhZmZlY3RlZD8gVGhpcyB3b3VsZCBicmVhaw0K
PiA+ID4gTFBJcyAoYW5kIHRodXMgTVNJcykgYW5kIFBQSXMgKHRoZSBDUFUgdGltZXIsIGFtb25n
IG90aGVycykuDQo+ID4gDQo+ID4gQW55dGhpbmcgdGhhdCBpc24ndCB2aXNpYmxlIHRvIHRoZSBH
UEMgYW5kIHJlcXVpcmVzIHRoZSBHSUMNCj4gPiB3YWtlX3JlcXVlc3Qgc2lnbmFsIHRvIGJlaGF2
ZSBhcyBzcGVjaWZpZWQgaXMgYnJva2VuIGJ5IHRoaXMgZXJyYXR1bS4NCj4gDQo+IEkgcmVhbGx5
IHdvbmRlciBob3cgYSB0aW1lciBpbnRlcnJ1cHQgKGEgUFBJLCBoZW5jZSBub3Qgcm91dGVkIHRo
cm91Z2gNCj4gdGhlIEdQQykgY2FuIHdha2UgdXAgdGhlIENQVSBpbiB0aGlzIGNhc2UuIEl0IHJl
YWxseSBmZWVscyBsaWtlDQo+IHNvbWV0aGluZyBsaWtlICJwcm9ncmFtIENOVFZfQ1ZBTF9FTDAg
dG8gZXhwaXJlIGF0IHNvbWUgbGF0ZXIgcG9pbnQ7DQo+IFdGSSIgY291bGQgcmVzdWx0IGluIHRo
ZSBDUFUgZ29pbmcgdG8gYSBkZWVwIHNsZWVwIHN0YXRlLCBhbmQgbm90DQo+IHdha2UtdXAgYXQg
YWxsLg0KDQpUaGlzIGlzIGFscmVhZHkgYSBjb21tb24gaXNzdWUgZm9yIGNwdWlkbGUgaW1wbGVt
ZW50aW9ucyBoYW5kbGVkIGJ5IHRoZQ0KImxvY2FsLXRpbWVyLXN0b3AiIHByb3BlcnR5LiBpbXgg
aGFzIG90aGVyIHRpbWVyIGJsb2NrcyBpbiB0aGUgU09DLA0KdGhleSBnZW5lcmF0ZSBTUElzIHdo
aWNoIGFyZSBjb25uZWN0ZWQgdG8gR1BDLg0KDQo+IFRoaXMgd291bGQgaW5kaWNhdGUgdGhhdCBu
b3Qgb25seSBjcHVpZGxlIGlzIGJyb2tlbiB3aXRoIHRoaXMsIGJ1dA0KPiBhYnNvbHV0ZWx5IGV2
ZXJ5IGludGVycnVwdCB0aGF0IGlzIG5vdCByb3V0ZWQgdGhyb3VnaCB0aGUgR1BDLg0KDQpZZXMs
IGNwdWlkbGUgaXMgYnJva2VuIGZvciBpcnFzIG5vdCByb3V0ZWQgdGhyb3VnaCBHUEMuIEhvd2V2
ZXI6DQoNCiogQWxsIFNQSXMgYXJlIGNvbm5lY3RlZCB0byBHUEMgaW4gYSAxOjEgbWFwcGluZw0K
KiBUaGlzIHNlcmllcyBkZWFscyB3aXRoIFNHSXMNCiogVGhlIHRpbWVyIFBQSXMgYXJlIG5vdCBy
ZXF1aXJlZDsgY292ZXJlZCBieSBsb2NhbC10aW1lci1zdG9wDQoqIExQSXMgYXJlIGN1cnJlbnRs
eSB1bnVzZWQgKEkgdW5kZXJzdGFuZCBpbXgtcGNpIHVzZXMgU1BJIGJ5IGRlZmF1bHQNCmZyb20g
THVjYXMpDQoNCkFueXRoaW5nIG1pc3Npbmc/DQoNCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0
aGlzIHdha2UgcmVxdWVzdCBmZWF0dXJlIHZpYSBHSUMgaXMgbmV3IGluIHYzDQphbmQgdGhpcyBp
cyBtYXliZSB3aHkgSFcgdGVhbSBtaXNzZWQgaXQgZHVyaW5nIGludGVncmF0aW9uLiBPbGRlcg0K
aW14Ni83IGhhcyBHSUN2MiBhbmQgaGFzIGRlZXAgaWRsZSBzdGF0ZXMgd2hpY2ggYWx3YXlzIHJl
bHkgb24gR1BDIHRvDQp3YWtldXAgc28gdGhlIGFwcHJvYWNoIGNhbiB3b3JrLg0KDQotLQ0KUmVn
YXJkcywNCkxlb25hcmQNCg==
