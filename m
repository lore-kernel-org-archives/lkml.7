Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DA4C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEB92067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="esTMORPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgAIIZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:25:07 -0500
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:9440
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728347AbgAIIZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:25:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McjYQlRDKv1qB9yb9n4Ykg11XkgLZVxu37lBAIxNIwSVv040EgKh5jUzdGF0wjBEUb+9IEcvhZ5G4w2NsST1KUPKe+NUeQzZGLE84oIYqXMWzoeCM2zkLKS4v+Lx1guMCoP6rIYNRwVViQtqoX2pLcXAAxJNDkTv+yyPj91C/vvqD0hKZuDjy+SdxYppfCcf7ZTw291sjVLhe9AdS6Rq5OlK1P4p+mV8hAbCJkI27hQI0rZXo83XTu4SLxwtvH/c83Iilwx3xv0ywBQRwsUIOjk6lb9/jhzRY2bb+jwaoHfVbXF9io4b3awsYMIL/Ut/fDyoXVx64/5NPBvpHqQpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxZcaIEVu1vc+vQ6DJdLtThVQkvGXLSmK659Deghx6k=;
 b=aUoDdHMN8aeNtUz8BQgP4j2B9dqdEo9UYc4DDGBed1SiHgnIJlKggbVOqdOtHf5CBrvCl8unXWV4LCVxEF857Fi/yMG+ZBQPmUVXd1B2E3zilAJfKV8Hv5Oha8vvC6Sbv5vijH1+5qgawus+7giYk+uGdszosZrFsZDL0xc3PDHGF2t1tT9wErKks0ZjLgZfD7wbnkZY4tE2GDy0gydz5jyaatG9CkO3rm6pASiwsDj0RFmJeFl2EOlkgUHc+KdKVT0SkVe0zG1+9qqCjrezWThBRhHMjJNB0VDP/41G/z3zm2BXkPOoEhkmDDYK0RwDmdrfln//0K7N2MmSIyOmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxZcaIEVu1vc+vQ6DJdLtThVQkvGXLSmK659Deghx6k=;
 b=esTMORPm4Osxom9gV7sO39cyATBBFsRk+L5Z9ehE4+xxA8CRAIxU/CMBZYXV2nPvWbyEGKIzppoI5W4XW+0QGMdftJm/0Urbb1B4/Ga+/nUtKc5m1uGEVN8uq3nlqVo/2XnBqsbt5zL7YwySeqRq0zGlCyIJeoIpAqxp+0CviuA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 08:25:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d968:56ad:4c0c:616f]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d968:56ad:4c0c:616f%7]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 08:25:03 +0000
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
Thread-Index: AQHVvrKzedU6q1PoEkWGPbnH76QqjKfiCd2AgAAE9sA=
Date:   Thu, 9 Jan 2020 08:25:03 +0000
Message-ID: <DB3PR0402MB39168406714A06869C33D037F5390@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1577670071-1322-1-git-send-email-Anson.Huang@nxp.com>
 <20200109080600.GH4456@T480>
In-Reply-To: <20200109080600.GH4456@T480>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8074fc5f-98db-41f4-24b1-08d794dd6d0d
x-ms-traffictypediagnostic: DB3PR0402MB3929:|DB3PR0402MB3929:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB39297396D9F4B5E859DA684EF5390@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(71200400001)(5660300002)(7416002)(33656002)(478600001)(4744005)(66946007)(76116006)(86362001)(66476007)(66446008)(54906003)(44832011)(316002)(66556008)(4326008)(81166006)(81156014)(64756008)(26005)(186003)(8676002)(7696005)(2906002)(6916009)(52536014)(6506007)(55016002)(9686003)(8936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ct4VT7xi54cAKcaFBYGgJ6GMdhFkB9fRA1r+5w37wUJ+UlYTnFZvbD5UewQd21+d7EzKq2x4d/OJxUXFXMk7ED5I2M7MmO0godrkvoBtPFHpYOTzk8RR/ooeu9hBMTLqzhRtEczYk20hXaEzWY5GU+N/KYP2r0xr5mAOlhMiBXHWaCpPbga0K6lIWhBnY1HcEmYBGjTDHea5Yb0/a9YJAsveH2uCiPcMqkoKobNGYPAg388t8lxCHkePBAsIJjbSgUHprb4z8f7KSId0l2ho6ld9lxROiToPQdaRPsgp+uJRf6qxa5Dj5VCr9kN83660/9IslVKl6c0UjoUJzxc4gep9vCk2aieTJFcA3YMvzZeBPkumwKCYUtBp8IgaZBICEevbHRjp9Rd9CaSDyHiPIQ+wLzREC+mAwen/W80yqO9eadsIxbZV3/UtbOQh3rIxLofpAJWhUsHNl6FuP2y7YjtfFoPWM1xoEePjra6gO8MV4YM9cCkfGKH9Lj3aXPEE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8074fc5f-98db-41f4-24b1-08d794dd6d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 08:25:03.3466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NLfMV3XHpwuV6F4cLNiVVrgJOG1HxrUI07u12NsA9QmxVwSLEmbVta0aVUFcx1PZIygKh5SHd18tonHMM9wdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzVdIEFSTTogZHRzOiBpbXg2cWRs
LXNhYnJlc2Q6IFJlbW92ZSBpbmNvcnJlY3QNCj4gcG93ZXIgc3VwcGx5IGFzc2lnbm1lbnQNCj4g
DQo+IE9uIE1vbiwgRGVjIDMwLCAyMDE5IGF0IDA5OjQxOjA3QU0gKzA4MDAsIEFuc29uIEh1YW5n
IHdyb3RlOg0KPiA+IFRoZSB2ZGQzcDAncyBpbnB1dCBzaG91bGQgYmUgZnJvbSBleHRlcm5hbCBV
U0IgVkJVUyBkaXJlY3RseSwgTk9UDQo+IA0KPiBTaG91bGRuJ3QgVVNCIFZCVVMgdXN1YWxseSBi
ZSA1Vj8gIEl0IGRvZXNuJ3Qgc2VlbSB0byBtYXRjaCAzLjBWIHdoaWNoIGlzDQo+IHN1Z2dlc3Rl
ZCBieSB2ZGQzcDAgbmFtZS4NCj4gDQo+ID4gUE1JQydzIHN3Miwgc28gcmVtb3ZlIHRoZSBwb3dl
ciBzdXBwbHkgYXNzaWdubWVudCBmb3IgdmRkM3AwLg0KPiA+DQo+ID4gRml4ZXM6IDkzMzg1NTQ2
YmEzNiAoIkFSTTogZHRzOiBpbXg2cWRsLXNhYnJlc2Q6IEFzc2lnbiBjb3JyZXNwb25kaW5nDQo+
ID4gcG93ZXIgc3VwcGx5IGZvciBMRE9zIikNCj4gDQo+IElzIGl0IG9ubHkgYSBkZXNjcmlwdGlv
biBjb3JyZWN0aW5nIG9yIGlzIGl0IGZpeGluZyBhIHJlYWwgcHJvYmxlbT8gIEknbSB0cnlpbmcg
dG8NCj4gdW5kZXJzdGFuZCBpdCBpcyBhIDUuNS1yYyBtYXRlcmlhbCBvciBjYW4gYmUgYXBwbGll
ZCBmb3IgNS42Lg0KPiANCg0KSXQgaXMgZml4aW5nIGEgcmVhbCBwcm9ibGVtIGFib3V0IFVTQiBM
RE8gdm9sdGFnZSwgdGhhdCBpcyB3aHkgd2Ugbm90aWNlZCB0aGlzIGlzc3VlLg0KDQpUaGFua3Ms
DQpBbnNvbi4NCg==
