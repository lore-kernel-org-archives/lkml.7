Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4A1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643E5206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NVXIjhvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfIDHlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:41:39 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:10151
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfIDHlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:41:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7PqqbywLGP6XEDHZZWTUdk/i4gFYx0kV2QF9N/2pcQfuY3qaPmaTqDNWEWR+ZcQeJ5JVb8nNraNKXfbzqSMzQ6/datuVFAY4Lq0eYOGFftNBc7LR4Xf0wA/G9ps5EyL5qsV1fesTzgQKR7m7hi8ebE4S335vInHP+zUki4Z3+Ow80GUN3kyx5Hln4MYugJdflQHXXBh1J1IM99aIeui69YQfmSTyJcmbVlujaJqFYuKS6LFhvnROmAJ8+yFArEsYYp2oIO8BvRR0wBrgOl7LWfS7eW7rXb7HZa+0L7khI8w7IaGbtvnZBn6++wx0xvsFPuVnqisvfnj2EqFCyk5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e57POvpSM9H0PzRSbfFnEAZ8gGdG1uilFOYeNZV9QLo=;
 b=b/j6CExGuLXiGlyvpDqt/lni5BMw8gQ6WaNVXBKcVLV/GTn7HnrRclW+R3cUrwXff6h24Fx7tml7KVTpmLvpQt9ODzx+9zPgolxCbc4s8W58i+nhRj8TfGNo4UUVvQIMJ5vc4QLdk/RWjUaxKFwz7wHzl0fk0jY7cu3Hu3LDBMKPg30baBW3DxKY9AepwTanoEdviDQqfXTztyb1Ys53OLFaep6e72Dnaz8seG5pjR1SAqK1mF7pSSEUe1zZ/x2BMRWjbIDeRwjBWUDFXFp5ixX4gARwRju/8DXp32+Azpzis4IYM+58JO8W0G9HGyr6hsScLdrh9DLm9n8q398Qaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e57POvpSM9H0PzRSbfFnEAZ8gGdG1uilFOYeNZV9QLo=;
 b=NVXIjhvfiYjaIF+hp7zVVuLrYidAYW4fFyWn5BAVxA0H8bT7Y7pxPOybrRQosdk4z+9cPjZ3G60ggDUtvHIeqobvle8IpyKdfdrQW/lVBrqhjW5NbqjCiUWwiG5a5aAEOW9GxxA8uBVqL2wks7RbNF6p0UTNv9tgPF8T5BYf6eo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3833.eurprd04.prod.outlook.com (52.134.67.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Wed, 4 Sep 2019 07:41:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2199.021; Wed, 4 Sep 2019
 07:41:35 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] soc: imx: imx-scu: Getting UID from SCU should have
 response
Thread-Topic: [PATCH] soc: imx: imx-scu: Getting UID from SCU should have
 response
Thread-Index: AQHVYvBaKeS5E5gU7kibbz+lazsBqacbIMgg
Date:   Wed, 4 Sep 2019 07:41:35 +0000
Message-ID: <DB3PR0402MB3916932DFC5401F3573F13FDF5B80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1567624394-25023-1-git-send-email-Anson.Huang@nxp.com>
 <VI1PR04MB7023B9C325C54AA8112F1AE5EEB80@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023B9C325C54AA8112F1AE5EEB80@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af507150-4f5f-490f-453b-08d7310b4fe4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3833;
x-ms-traffictypediagnostic: DB3PR0402MB3833:|DB3PR0402MB3833:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB383327016AD9ADCD1133F1C4F5B80@DB3PR0402MB3833.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(81156014)(8936002)(478600001)(54906003)(71200400001)(71190400001)(81166006)(14454004)(305945005)(316002)(7736002)(74316002)(99286004)(8676002)(66066001)(5660300002)(110136005)(52536014)(14444005)(6436002)(2906002)(53936002)(66446008)(3846002)(33656002)(6636002)(64756008)(66946007)(76116006)(6116002)(229853002)(76176011)(4326008)(476003)(6246003)(256004)(66476007)(66556008)(55016002)(11346002)(102836004)(26005)(186003)(25786009)(9686003)(44832011)(7696005)(6506007)(53546011)(86362001)(446003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3833;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fnp6emNhLfcbHBjHlfgy5m8ad+xW0ABM0mTf9fuuSSEgsrEJ+yVdRweB+wdKb9bY46OyZA/VFNSRbwQx1xfwork/ErtoiJ46kFyTtURF7v9k69cM5UXpzfIxMn6JfonkCBeZZAECWgcOyPbT7mWnssYnuCzYnZRMHoLnRE+VlLPasmWbQEwe80DVRR5+5C9b/VCW9TPVsH7yjSaUvdkYYNOkRacM2H7ovIMfo+mAKqdD4bFmC+WKUUBc22ZiijbkxE04Vtl3VnFIJ9Z47Pk8sJksGz7ydMboYZF4g65Is0iJ9M91mqhHhLTwMv7UaVkWlPbHHXrdPgSGR2ULMGpgHVFkubvrlRERvk49EkaGDah+np5m5LdweY90PIFXslyFJjG9gcGqOLRj3j8XEABKZMiNK1rkqbNmTRyxbECWlQg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af507150-4f5f-490f-453b-08d7310b4fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 07:41:35.0246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NqWd2vnbus3SAzBJMaPe1/dPa0jMWnmZsAhr28JOiCQn74lxCW+rCeivA2oqde7NUyo9/qNtXscTSIvkeN+vQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiBPbiAyMDE5LTA5LTA0IDEwOjE0IEFNLCBBbnNvbiBIdWFuZyB3cm90
ZToNCj4gPiBUaGUgU0NVIGZpcm13YXJlIEFQSSBmb3IgZ2V0dGluZyBVSUQgc2hvdWxkIGhhdmUg
cmVzcG9uc2UsIG90aGVyd2lzZSwNCj4gPiB0aGUgbWVzc2FnZSBzdG9yZWQgaW4gZnVuY3Rpb24g
c3RhY2sgY291bGQgYmUgcmVsZWFzZWQgYW5kIHRoZW4gdGhlDQo+ID4gcmVzcG9uc2UgZGF0YSBy
ZWNlaXZlZCBmcm9tIFNDVSB3aWxsIGJlIHN0b3JlZCBpbnRvIHRoYXQgcmVsZWFzZWQNCj4gPiBz
dGFjayBhbmQgY2F1c2Uga2VybmVsIE5VTEwgcG9pbnRlciBkdW1wLg0KPiANCj4gVGhpcyBmaXgg
bG9va3MgZ29vZCwgYnV0IGxvb2tpbmcgYXQgaW14LXNjdSBjb2RlIGl0IHNlZW1zIHRoYXQgcGFz
c2luZyB0aGUNCj4gaW5jb3JyZWN0ICJoYXZlX3Jlc3AiIGFyZ3VtZW50IHRvIGlteF9zY3VfY2Fs
bF9ycGMgb3IganVzdCByZWNlaXZpbmcgYW4NCj4gdW5leHBlY3RlZCBtZXNzYWdlIGZyb20gU0NG
VyB3aWxsIGFsd2F5cyByZXN1bHQgaW4ga2VybmVsIHN0YWNrIGNvcnJ1cHRpb24hDQo+IA0KPiBU
aGlzIGlzIHdvcnRoIGhhbmRsaW5nIGluc2lkZSBpbXgtc2N1IGl0c2VsZjogdW5sZXNzIGEgcmVz
cG9uc2Ugd2FzIGV4cGxpY2l0bHkNCj4gcmVxdWVzdGVkIGl0IHNob3VsZCBpZ25vcmUgYW5kIHBy
aW50IGEgd2FybmluZyBvbiByeCwgZm9yIGV4YW1wbGUgYnkgc2V0dGluZw0KPiBpbXhfc2NfaXBj
IHRvIE5VTEwgd2hlbiBub3Qgd2FpdGluZyBmb3IgYSByZXNwb25zZS4NCj4gDQo+IEhvbGRpbmcg
b24gdG8gYXJiaXRyYXJ5IHN0YWNrIHBvaW50ZXJzIGlzIGJhZC4NCg0KV2Ugbm90aWNlZCB0aGlz
IGlzc3VlIHJlY2VudGx5IGR1cmluZyB0aGUgZGV2ZWxvcG1lbnQgb2YgT04vT0ZGIGJ1dHRvbiBz
dXBwb3J0LA0KdGhpcyBVSUQgaXMgbHVja3ksIHRoZSBzdGFjayBpcyBOT1QgcmVsZWFzZWQgd2hl
biBTQ1UgcmVzcG9uc2UgZGF0YSBpcyByZWNlaXZlZCwgYnV0DQp0aGlzIGZpeCBzaG91bGQgYmUg
YXBwbGllZC4NCg0KV2UgdGFsa2VkIHRvIENodWNrIGFib3V0IGFkZGluZyByZXR1cm4gdmFsdWUg
Zm9yIHRoZXNlIHNwZWNpYWwgQVBJcywgcmVzcG9uc2UgZGF0YQ0KbmVlZGVkIGJ1dCBubyByZXR1
cm4gdmFsdWUgZnJvbSBTQ1UsIHNvIHZlcnkgbGlrZWx5IHdlIHdpbGwgbmVlZCBhIHBhdGNoIGlu
IGlteF9zY19pcGMNCmRyaXZlciB0byBlbmhhbmNlL2hhbmRsZSB0aGF0LCB3aWxsIGRvIGEgcGF0
Y2ggZm9yIGl0IGxhdGVyLg0KDQpUaGFua3MsDQpBbnNvbg0KDQo=
