Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8924FC33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5380D2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EJZX9s7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgAIJ3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:29:24 -0500
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:48763
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729269AbgAIJ3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:29:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZDv87qtQtpFi6G+7PgwyaKrHeganXg+SMZ4OT+lFh1IRCFOicB4y8vjW4n4BKyLlcro7JIxPNDoDK/9IlbeQZcGzE6JW/Z58tL6SkJRm2mkC8ub+bp3335QLJpMH5ACEPW/dCmFdkeGxL8j3hQmIzsiMy5gwUPWfLyxOSJfzhkwj3mWVi+mP/yZXinPk3uXUnBL//CEx3dmK3VwGT+jp0yoER4t3L+szQtl0GjgA5FnGjXplZKKi4NhtJ5Ln1NUv1/2nUmnvvLT0f3rTn/ISxh3vny0YSx+v9x3fn4B2GwPn5pmHn84AXmr6qaIr5df7GxuFfRc4zTcxnlpc5T6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nB/HfAO3wEXRfHhM/7aUCtcVjiQqSrdig+6cNj0JAM=;
 b=jScsGqFlE8l1UYc29uAL/TdCgb935wSFwjcDk8q5nt5Td9uV8xVhb+POkY+qdxRhn5a5qXHoa+srukM7OdeAdlwdXUEkj8eVIzILn34xYzBion7SKmot9vRqbNj5cnM11/lW5XKdFULE5RgZh27WhHnZsBHH8V66/AUdDOhTLJG16t7NpQ9TECUMl84tnPDPQcowtxknCw/gb426p5LX/j/jdOyLOs4kdL9ci8viX/fAl55kHDzBgjnF29vJpi+n3WtEWlMcZjUKkj6QfG75CrEZ0gQdvPdbnhoS5ChoN+tL3KX4UBw5ZpjLNMwqhwx2Bs3P7wIgMEHNuDpY8enrWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nB/HfAO3wEXRfHhM/7aUCtcVjiQqSrdig+6cNj0JAM=;
 b=EJZX9s7dR9z9yXC7vdCq1naVdLKcM1yBm0D6QyClvZ/kvYO5L/SKhLRSvMbcAD8CbHKxalqZNZzYPvWQH5M22tP0ljfXHQ2QPHBJq/s4CVgUeQYpdbcrl3+h6kfggfb7XxenWaIsxHfhsQYwJsn+2P/asifIo8WGgmnPr+gIEOM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3867.eurprd04.prod.outlook.com (52.134.65.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 09:28:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d968:56ad:4c0c:616f]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d968:56ad:4c0c:616f%7]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 09:28:35 +0000
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
Thread-Index: AQHVvrKzedU6q1PoEkWGPbnH76QqjKfiCd2AgAAE9sCAAAzggIAAA3owgAABkZA=
Date:   Thu, 9 Jan 2020 09:28:35 +0000
Message-ID: <DB3PR0402MB39167704253BE1FD4E106766F5390@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1577670071-1322-1-git-send-email-Anson.Huang@nxp.com>
 <20200109080600.GH4456@T480>
 <DB3PR0402MB39168406714A06869C33D037F5390@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200109090950.GJ4456@T480>
 <DB3PR0402MB3916EBF00EECB42C1F4E2D40F5390@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916EBF00EECB42C1F4E2D40F5390@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 110f144a-0949-445d-f04a-08d794e64d1d
x-ms-traffictypediagnostic: DB3PR0402MB3867:|DB3PR0402MB3867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38673F8BA285B19A77CF4D55F5390@DB3PR0402MB3867.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(54906003)(71200400001)(66946007)(8936002)(316002)(76116006)(2906002)(5660300002)(81166006)(6916009)(81156014)(8676002)(478600001)(2940100002)(33656002)(186003)(4326008)(66446008)(64756008)(66556008)(66476007)(44832011)(7696005)(7416002)(55016002)(26005)(52536014)(9686003)(86362001)(6506007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3867;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 801B/THufiIxCoMGKOG/O9zuVQytLQv9yvFRgW3cMxngHqpTgPh2dzq+y93BZF51fgVWlPca/aElOD35Q8dzQefKPPqDLRNpn9EipkJgp9Xn1Si0yvY+ObXnKHiRbLH2ZJ49NYtwjRLHhoQZ52WxHDBVGKpm+GalKyDe7ii83InnefE9ImXuUwFva2KQ/0dD3OAnbxtvE3npx5vDbYhPzJDLJwSO8Ytfy8Fi7otGt5+fL/UTichctjDYNEbnw7uvdiiJ+V0EnLncsN0qOGYgyzuoFUSLlnyDziTHibXXQTblwg3FPqFLB2+qV9GrsUTViqSpToU7vrvzUmVTQTCSSTYMx1v4iL/Bg6xxHy5AdAib4tcSc0f4X4jzMfu41Nk7UlEHflA/Mv9dD3kF9eO95oMPjvi+5uFj43uUKXObl5xmEo/bPSlOLkL5v/Ggj6N/ZHuK0YskEYenwmdtry5eVINf14cAZJSr0g8KLRhXSlSAJGNFlCRxBkV8MuGQ4YdL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110f144a-0949-445d-f04a-08d794e64d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 09:28:35.1862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJgbv0cfBirV/dFH4lB8tvTttF8P+jxYbGF5dCuVquS02gXZf19e5r9Nt3DWzw4umhIFJtLUO9HQpwudye8VKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCAxLzVdIEFSTTogZHRzOiBpbXg2cWRsLXNhYnJlc2Q6
IFJlbW92ZSBpbmNvcnJlY3QNCj4gcG93ZXIgc3VwcGx5IGFzc2lnbm1lbnQNCj4gDQo+IEhpLCBT
aGF3bg0KPiANCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNV0gQVJNOiBkdHM6IGlteDZxZGwt
c2FicmVzZDogUmVtb3ZlIGluY29ycmVjdA0KPiA+IHBvd2VyIHN1cHBseSBhc3NpZ25tZW50DQo+
ID4NCj4gPiBPbiBUaHUsIEphbiAwOSwgMjAyMCBhdCAwODoyNTowM0FNICswMDAwLCBBbnNvbiBI
dWFuZyB3cm90ZToNCj4gPiA+IEhpLCBTaGF3bg0KPiA+ID4NCj4gPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCAxLzVdIEFSTTogZHRzOiBpbXg2cWRsLXNhYnJlc2Q6IFJlbW92ZQ0KPiA+ID4gPiBp
bmNvcnJlY3QgcG93ZXIgc3VwcGx5IGFzc2lnbm1lbnQNCj4gPiA+ID4NCj4gPiA+ID4gT24gTW9u
LCBEZWMgMzAsIDIwMTkgYXQgMDk6NDE6MDdBTSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+
ID4gPiA+ID4gVGhlIHZkZDNwMCdzIGlucHV0IHNob3VsZCBiZSBmcm9tIGV4dGVybmFsIFVTQiBW
QlVTIGRpcmVjdGx5LA0KPiA+ID4gPiA+IE5PVA0KPiA+ID4gPg0KPiA+ID4gPiBTaG91bGRuJ3Qg
VVNCIFZCVVMgdXN1YWxseSBiZSA1Vj8gIEl0IGRvZXNuJ3Qgc2VlbSB0byBtYXRjaCAzLjBWDQo+
ID4gPiA+IHdoaWNoIGlzIHN1Z2dlc3RlZCBieSB2ZGQzcDAgbmFtZS4NCj4gPiA+ID4NCj4gPiA+
ID4gPiBQTUlDJ3Mgc3cyLCBzbyByZW1vdmUgdGhlIHBvd2VyIHN1cHBseSBhc3NpZ25tZW50IGZv
ciB2ZGQzcDAuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBGaXhlczogOTMzODU1NDZiYTM2ICgiQVJN
OiBkdHM6IGlteDZxZGwtc2FicmVzZDogQXNzaWduDQo+ID4gPiA+ID4gY29ycmVzcG9uZGluZyBw
b3dlciBzdXBwbHkgZm9yIExET3MiKQ0KPiA+ID4gPg0KPiA+ID4gPiBJcyBpdCBvbmx5IGEgZGVz
Y3JpcHRpb24gY29ycmVjdGluZyBvciBpcyBpdCBmaXhpbmcgYSByZWFsIHByb2JsZW0/DQo+ID4g
PiA+IEknbSB0cnlpbmcgdG8gdW5kZXJzdGFuZCBpdCBpcyBhIDUuNS1yYyBtYXRlcmlhbCBvciBj
YW4gYmUgYXBwbGllZCBmb3IgNS42Lg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEl0IGlzIGZpeGlu
ZyBhIHJlYWwgcHJvYmxlbSBhYm91dCBVU0IgTERPIHZvbHRhZ2UsIHRoYXQgaXMgd2h5IHdlDQo+
ID4gPiBub3RpY2VkDQo+ID4gdGhpcyBpc3N1ZS4NCj4gPg0KPiA+IE9rYXksIHBsZWFzZSBkZXNj
cmliZSB0aGUgcHJvYmxlbSBhIGxpdHRsZSBiaXQgaW4gdGhlIGNvbW1pdCBsb2cuDQo+ID4gQWxz
byBzcXVhc2ggdGhlIHNlcmllcyBpbnRvIG9uZSBwYXRjaCwgd2hpY2ggaXMgZWFzaWVyIHRvIGJl
IG1lcmdlZCBpbnRvIC1yYw0KPiBhcyBhIGZpeC4NCj4gDQo+IE9LLCB3aWxsIHNlbmQgYSBuZXcg
cGF0Y2ggd2l0aCBzcXVhc2hpbmcgdGhlbSB0b2dldGhlciwgYnV0IHdpbGwgTk9UIGhhdmUNCj4g
dGhlIGZpeCB0YWcsIGlzIGl0IE9LPyBBcyB0aGUgZml4IHRhZyBhcmUgZGlmZmVyZW50IGZvciBl
YWNoIHBhdGNoLg0KDQpOZXZlciBtaW5kLCBJIHRoaW5rIEkgY2FuIHB1dCBhbGwgNSBGaXhlcyB0
YWcgdG9nZXRoZXIgaW4gbmV3IHBhdGNoLg0KDQpUaGFua3MsDQpBbnNvbg0K
