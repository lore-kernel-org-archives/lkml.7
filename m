Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C0FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E965A20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FJFrcHi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfDDCLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:11:25 -0400
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:27062
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726412AbfDDCLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97NY9ICsVnGNWpLV5QTZ6XdW02reMwnoGXKV5Lshcmk=;
 b=FJFrcHi8bNwzOP0vWPfIickyj2TNyx15OFm9sWKr4WkmzcLwTfeuUfDTlYYjFtw68atDPBjfB4V3r9It2RIL24FmzFxY6kTj2IO5y4uNE7IQacHtb9MI9sC6jLG8VUbZEo9nrMJ2tlvO1/sT++7KJMB02RT/oqPePYQqGWOtkb8=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4924.eurprd04.prod.outlook.com (20.176.234.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Thu, 4 Apr 2019 02:11:06 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25%3]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 02:11:06 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 0/5] can: flexcan: add CAN FD support on i.MX8QM
Thread-Topic: [PATCH V2 0/5] can: flexcan: add CAN FD support on i.MX8QM
Thread-Index: AQHU3hME3SOkYFf4ZU2Iven+aBmRlKYrWuaw
Date:   Thu, 4 Apr 2019 02:11:06 +0000
Message-ID: <DB7PR04MB46186F1FAE31CE1C2C934F07E6500@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190319051512.14950-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190319051512.14950-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17ead5b2-564d-44e6-0c71-08d6b8a2cc25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4924;
x-ms-traffictypediagnostic: DB7PR04MB4924:
x-microsoft-antispam-prvs: <DB7PR04MB49244CAB8EE78A5AAD6293C9E6500@DB7PR04MB4924.eurprd04.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(189003)(199004)(13464003)(7696005)(99286004)(229853002)(2501003)(71190400001)(14454004)(71200400001)(25786009)(33656002)(4326008)(52536014)(6436002)(106356001)(105586002)(5660300002)(86362001)(478600001)(256004)(53936002)(7736002)(305945005)(66066001)(6246003)(8676002)(74316002)(8936002)(54906003)(81156014)(81166006)(110136005)(6506007)(26005)(446003)(486006)(97736004)(476003)(9686003)(316002)(55016002)(3846002)(2906002)(76176011)(6116002)(4744005)(68736007)(102836004)(53546011)(186003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4924;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BDRWc2yKlOuYFUG4YblU0qFzmwHnqZVjFRAHv4NGTw9wVd4puLb5IhsFPWK7bW4dvT7JtOWji/KjBq2AnHmSydSCJSLr47+L+cPPayRGIJhiuXQ5nLMFihsD4gAPTzruob6GwL2W65LKJmYnC8UDUViOPp1LPla6BK7zjonvH5e7fIYIVvFnL8I3QYg/N0zwh47BoAeuDvtSFt0+4dSvbznDux99E88OYbOxu2cdeuUhsCjEqCaGl8HVq2SbwymxNqpomykTYMQ87xQv/OBoMa+9/r2Ct82f3uyWC7S24LfrVsp0S4KSActQN6RoFVVdPwGtzIXtX0qZGDWLq2nXJNs66m+xf1XQ/lneydWF0gPWlqDll/5/hvUz/zD0PNuBibOp78pGbny//TWVtBGBDcQC5EKpCbRS5wdwU8jXCWg=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ead5b2-564d-44e6-0c71-08d6b8a2cc25
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 02:11:06.7916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4924
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNClBpbmcuLi4NCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9ha2ltIFpoYW5nDQo+IFNlbnQ6IDIwMTnE6jPU
wjE5yNUgMTM6MTcNCj4gVG86IG1rbEBwZW5ndXRyb25peC5kZTsgbGludXgtY2FuQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IHdnQGdyYW5k
ZWdnZXIuY29tOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBKb2FraW0gWmhhbmcNCj4gPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPg0KPiBT
dWJqZWN0OiBbUEFUQ0ggVjIgMC81XSBjYW46IGZsZXhjYW46IGFkZCBDQU4gRkQgc3VwcG9ydCBv
biBpLk1YOFFNDQo+IA0KPiBUaGlzIHBhdGNoIHNldCBpbnRlbmRzIHRvIGFkZCBmZCBtb2RlIHN1
cHBvcnQgb24gaS5NWDhRTSBwbGF0Zm9ybS4NCj4gDQo+IERvbmcgQWlzaGVuZyAoNCk6DQo+ICAg
Y2FuOiByeC1vZmZsb2FkOiBhZGQgQ0FORkQgc3VwcG9ydCBiYXNlZCBvbiBvZmZsb2FkDQo+ICAg
Y2FuOiBmbGV4Y2FuOiBhZGQgQ0FOIEZEIG1vZGUgc3VwcG9ydA0KPiAgIGNhbjogZmxleGNhbjog
YWRkIENBTkZEIEJSUyBzdXBwb3J0IGFuZCBpbXByb3ZlIGJpdHRpbWluZyBzZXR0aW5nDQo+ICAg
Y2FuOiBmbGV4Y2FuOiBhZGQgaW14OHFtIHN1cHBvcnQNCj4gDQo+IEpvYWtpbSBaaGFuZyAoMSk6
DQo+ICAgY2FuOiBmbGV4Y2FuOiBhZGQgSVNPIENBTiBGRCBmZWF0dXJlIHN1cHBvcnQNCj4gDQo+
ICBkcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jICAgICAgfCAyMjIgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tDQo+ICBkcml2ZXJzL25ldC9jYW4vcngtb2ZmbG9hZC5jICAgfCAgMTYg
KystDQo+ICBpbmNsdWRlL2xpbnV4L2Nhbi9yeC1vZmZsb2FkLmggfCAgIDQgKy0NCj4gIDMgZmls
ZXMgY2hhbmdlZCwgMjA2IGluc2VydGlvbnMoKyksIDM2IGRlbGV0aW9ucygtKQ0KPiANCj4gLS0N
Cj4gMi4xNy4xDQoNCg==
