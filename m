Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFD0C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4548C20838
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RQR4WCfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgAIJZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:25:42 -0500
Received: from mail-am6eur05on2050.outbound.protection.outlook.com ([40.107.22.50]:6154
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729269AbgAIJZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:25:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKIGx68XXkE661lsBnAs7cn2WtfQRh4FekUYGCf2dkE6SaJdrR4d9WwPci4sit8E1o+g0EBzGYwXEy4BISWGyQ/D90MK4A4VjTR8OKSPLuE/Ga9tHUpL+eyNEggLGAC96ELM37dQqfcdOtZY0+v8SsKJ/+l5LPuW4ek9W2VwuFrd8rWFnvbeYg1PcTjW7qRQU/GSg44ZPX3wvvT75620cIh7f+wa5PmUHuFghxnNKagJ+gE9MlAp1+kpzjBZD8AuWKCGbAhudw9RvRouyON8R1hncS1n75SkRCTx5eTJ/Gt4KN3IEhSZIe2rOCvSfiSxurxfB49sUn9/KrJUyfDbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP1dQy1tK04By4k75sn4vOQgOWyYUHyaTKyfOJ+izhc=;
 b=e54+C2XegXfz9p1gccV+/irW5DzPlIa7/NSWY/bUSgosfcXREXdK+u0983Slc9ZoJZkXizZ2ccUGS1QdGTp0Pfz+yawzB1CPUQljDUDZoPert9VIqqqPmIXHecb7d9FTjbrfPvouwl+R8BUPIbwxXNVo1GGXw1VUZXGbxX2wdgNdZm0FZSNRn/FJ8UDyKTUw2M2NlGe87RA0vxx7Kzrs1fn9Zb4Qp912DyPKseuczrJKGQZELTlsPFQIYnQfmTzsa6dfX0T8H+HbQZKg9C7Bsf/mFRIBDYT9Jj5ikOP6eqVL9PO2Ki8ONsA/7UGH6bB3iXz+ZFi/IvwTEyUT29Jjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP1dQy1tK04By4k75sn4vOQgOWyYUHyaTKyfOJ+izhc=;
 b=RQR4WCfGlHALHkkI7j68cjecZu+bhz4ZIw3g7gIE+qdUmcpaPNom08hztaKKNdbfZj6DDmvJLb04wmCR4WH/qehbi4GpS4IsplvCtiynpRnof4ZvAMN39nFXCYXWM/rGyGVehWtAGh2z1eF6ZnYmdkVLHbOqMqSo/rHOj8U0Aow=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3867.eurprd04.prod.outlook.com (52.134.65.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 09:25:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d968:56ad:4c0c:616f]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d968:56ad:4c0c:616f%7]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 09:25:35 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "andreas@kemnade.info" <andreas@kemnade.info>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/5] ARM: dts: imx6qdl-sabresd: Remove incorrect power
 supply assignment
Thread-Topic: [PATCH 1/5] ARM: dts: imx6qdl-sabresd: Remove incorrect power
 supply assignment
Thread-Index: AQHVvrKzedU6q1PoEkWGPbnH76QqjKfiCd2AgAAE9sCAAAzggIAAA3ow
Date:   Thu, 9 Jan 2020 09:25:35 +0000
Message-ID: <DB3PR0402MB3916EBF00EECB42C1F4E2D40F5390@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1577670071-1322-1-git-send-email-Anson.Huang@nxp.com>
 <20200109080600.GH4456@T480>
 <DB3PR0402MB39168406714A06869C33D037F5390@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200109090950.GJ4456@T480>
In-Reply-To: <20200109090950.GJ4456@T480>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56e6c54b-4067-4f43-aae7-08d794e5e1e9
x-ms-traffictypediagnostic: DB3PR0402MB3867:|DB3PR0402MB3867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3867EE4BA9FA78EF8D0DAB3CF5390@DB3PR0402MB3867.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(186003)(4326008)(33656002)(478600001)(86362001)(6506007)(44832011)(7696005)(7416002)(55016002)(66446008)(64756008)(66556008)(66476007)(9686003)(26005)(52536014)(8936002)(316002)(76116006)(71200400001)(66946007)(2906002)(54906003)(8676002)(5660300002)(81166006)(6916009)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3867;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0of+fkwt9/ROEqELIxMXU1D79rZ4aPxhAmnZMDvio9JGIhLw/6CHB/yqqSQGsCYNzhRyHuqyfX7upObzo/Qyn6oc7W5QkMQQAOdx59JsKkmzZPb7Rl5vE7UONvmXTS33mb6pdXenMjkZWqiP9fHDIZvLRfTwQUCOA/KwwGumIhWWB8o95MW88Hp+Lkzk3iobz6WYdmt9x2SsdfZlvExYIhBl5VTh/JNDiA0B/KXkjXgHrTcG/QEMRGqQ6aS4Z405d5UrfgBveJ3YsOpCV2EcO4ZkHC0N2sSeV/mzrdOmt5XzlfVxgs+9kxyYnarsdR3gaa4v/6+RKoZnV9EVw0JO2PEOWcBjo7xG/+DAXckiXuH3QGwHCZmQ7Av/bU6+gV/MP7r+e5coSQkkl2KFNu0l5ZI8mp5Aao0H4mSYumZbKQQyyhWdPIqm9yz5KZA73n2qupYWhJFpvteyHJbic3SYqI/ZI/lLevVEQztKIPCHsCej23r4PVV8syRL3Zmmzk75
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e6c54b-4067-4f43-aae7-08d794e5e1e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 09:25:35.4123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvTRT++MAe72ctPbGOEUyIQoOpPgkgawkB9rZUeMOmjmrHGpmPPC9/9BtithJ/ouNyz4xzg4CmGzVDo/yIqWbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzVdIEFSTTogZHRzOiBpbXg2cWRs
LXNhYnJlc2Q6IFJlbW92ZSBpbmNvcnJlY3QNCj4gcG93ZXIgc3VwcGx5IGFzc2lnbm1lbnQNCj4g
DQo+IE9uIFRodSwgSmFuIDA5LCAyMDIwIGF0IDA4OjI1OjAzQU0gKzAwMDAsIEFuc29uIEh1YW5n
IHdyb3RlOg0KPiA+IEhpLCBTaGF3bg0KPiA+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
NV0gQVJNOiBkdHM6IGlteDZxZGwtc2FicmVzZDogUmVtb3ZlIGluY29ycmVjdA0KPiA+ID4gcG93
ZXIgc3VwcGx5IGFzc2lnbm1lbnQNCj4gPiA+DQo+ID4gPiBPbiBNb24sIERlYyAzMCwgMjAxOSBh
dCAwOTo0MTowN0FNICswODAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiA+ID4gVGhlIHZkZDNw
MCdzIGlucHV0IHNob3VsZCBiZSBmcm9tIGV4dGVybmFsIFVTQiBWQlVTIGRpcmVjdGx5LCBOT1QN
Cj4gPiA+DQo+ID4gPiBTaG91bGRuJ3QgVVNCIFZCVVMgdXN1YWxseSBiZSA1Vj8gIEl0IGRvZXNu
J3Qgc2VlbSB0byBtYXRjaCAzLjBWDQo+ID4gPiB3aGljaCBpcyBzdWdnZXN0ZWQgYnkgdmRkM3Aw
IG5hbWUuDQo+ID4gPg0KPiA+ID4gPiBQTUlDJ3Mgc3cyLCBzbyByZW1vdmUgdGhlIHBvd2VyIHN1
cHBseSBhc3NpZ25tZW50IGZvciB2ZGQzcDAuDQo+ID4gPiA+DQo+ID4gPiA+IEZpeGVzOiA5MzM4
NTU0NmJhMzYgKCJBUk06IGR0czogaW14NnFkbC1zYWJyZXNkOiBBc3NpZ24NCj4gPiA+ID4gY29y
cmVzcG9uZGluZyBwb3dlciBzdXBwbHkgZm9yIExET3MiKQ0KPiA+ID4NCj4gPiA+IElzIGl0IG9u
bHkgYSBkZXNjcmlwdGlvbiBjb3JyZWN0aW5nIG9yIGlzIGl0IGZpeGluZyBhIHJlYWwgcHJvYmxl
bT8NCj4gPiA+IEknbSB0cnlpbmcgdG8gdW5kZXJzdGFuZCBpdCBpcyBhIDUuNS1yYyBtYXRlcmlh
bCBvciBjYW4gYmUgYXBwbGllZCBmb3IgNS42Lg0KPiA+ID4NCj4gPg0KPiA+IEl0IGlzIGZpeGlu
ZyBhIHJlYWwgcHJvYmxlbSBhYm91dCBVU0IgTERPIHZvbHRhZ2UsIHRoYXQgaXMgd2h5IHdlIG5v
dGljZWQNCj4gdGhpcyBpc3N1ZS4NCj4gDQo+IE9rYXksIHBsZWFzZSBkZXNjcmliZSB0aGUgcHJv
YmxlbSBhIGxpdHRsZSBiaXQgaW4gdGhlIGNvbW1pdCBsb2cuICBBbHNvIHNxdWFzaA0KPiB0aGUg
c2VyaWVzIGludG8gb25lIHBhdGNoLCB3aGljaCBpcyBlYXNpZXIgdG8gYmUgbWVyZ2VkIGludG8g
LXJjIGFzIGEgZml4Lg0KDQpPSywgd2lsbCBzZW5kIGEgbmV3IHBhdGNoIHdpdGggc3F1YXNoaW5n
IHRoZW0gdG9nZXRoZXIsIGJ1dCB3aWxsIE5PVCBoYXZlIHRoZSBmaXggdGFnLA0KaXMgaXQgT0s/
IEFzIHRoZSBmaXggdGFnIGFyZSBkaWZmZXJlbnQgZm9yIGVhY2ggcGF0Y2guDQoNCj4gDQo+IE15
IHF1ZXN0aW9uIGFib3ZlIHRoYXQgVVNCIFZVQlMgaXMgNVYgd2hpY2ggZG9lc24ndCBtYXRjaCAz
LjBWIHN1Z2dlc3RlZA0KPiBieSB2ZGQzcDAgbmFtZSByZW1haW5zIHVuYWRkcmVzc2VkIHRob3Vn
aC4NCg0KVGhlIHZkZDNwMCBpcyBhIExETywgdGhlIGlucHV0IGlzIHRoZSBVU0IgVkJVUyA1Viwg
b3V0cHV0IGNhbiBiZSBwcm9ncmFtbWVkIHRvDQozLjJWLCBJIHRoaW5rIHRoZSBuYW1lIGlzIGZy
b20gdGhlIHRhcmdldCBvdXRwdXQgdm9sdGFnZS4NCg0KQW5zb24NCg==
