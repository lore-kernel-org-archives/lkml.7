Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91F8C4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE8C21848
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ky5Q9L7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfIRFpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 01:45:25 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:56807
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727779AbfIRFpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 01:45:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDMQJdPAAFovwE860XCtkjjJxj1542O53bvnJ/HSUvlQ+x1iN7wNm+HiZtdGpSaQVg0Q0xuF6ewgu6uxLzR7zJn4qcQ5m6GSMlpeMux0sNbHA4cNQ1mL3YPQVC9ayi4Hw7oK5nuSzghRhKDf6Wgv9Qb+Z/p6itW5sLRP+IUM6aijuYf5V19UI2xeuOR3Hp5SqGHGZG0z35tqAeA3MGZeE4fBQIT+8p5qkIpR89K7icJQmtEYQ93FDry8iGLuWb3w+fOVEOhQ8p2zOHzIzCH3bgTW27a0Em9lWJdl9qsOELFUbFGFEq2mYMSqpJvSCu01GTNYO/UdGlNN5ZBzzHJyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIYGvlAzKVwDHc+fHZrSrqnqClgmPCOC4LsZaUkcx4s=;
 b=S9V4a3DGEbFjFavw9cKlBaz3mkdrkyNC1oyNPYadbedQafOKpZcN4QpwT91aQY+oj/HCAQ5Ttq0jSIGALnIISRUH1P1DSV0beDH9xv8AIeKX6ZjRpv60aVDxLXivl1V1F08II0pq8QzGRf06TE7grZFANtEiYLpd7ykFo6U7V2VMM6/+jFu1AnCDhB46peuLPHxex+A7S6tYYmBCu7qTUlCr7iZ2uC55YpXKIihuWkxwm3aVcfzDkWWxsEfuJ/QJYueWTYEpIJl5OQqx1sIIC4qyw2dYtLW+5Lohub1afAydyT74nMoenmXA4yqHV+iBR87mv0QkAo8wt2yhAgHoUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIYGvlAzKVwDHc+fHZrSrqnqClgmPCOC4LsZaUkcx4s=;
 b=ky5Q9L7acr10Au9+D13iZ4MjKdgBn4fWBrD2fMhAh1UZtho0wzwT8tePQdWO+Zy0LA/gcFKnbUEupekSHcNZaoLhPwj4d6vp0O9vBqpCB1/dCNNXvScRoRho8x6EOS1hm2BGRflxjVjKMXadhhioIyikKnka4QLxNwbEIGqVB5g=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5747.eurprd04.prod.outlook.com (20.178.119.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Wed, 18 Sep 2019 05:45:20 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 05:45:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: RE: [PATCH V3 0/4] clk: imx8m: fix glitch/mux
Thread-Topic: [PATCH V3 0/4] clk: imx8m: fix glitch/mux
Thread-Index: AQHVZsAvxNHrETdja06leIJqZC3kHacvcZcwgACqvYCAAN5xEA==
Date:   Wed, 18 Sep 2019 05:45:20 +0000
Message-ID: <AM0PR04MB4481D54C4508152E458BA9BE888E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1568043491-20680-1-git-send-email-peng.fan@nxp.com>
 <AM0PR04MB4481A31DD68C3C3409E95339888F0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20190917162820.8DC542067B@mail.kernel.org>
In-Reply-To: <20190917162820.8DC542067B@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8573167e-1f44-42ba-f944-08d73bfb6484
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5747;
x-ms-traffictypediagnostic: AM0PR04MB5747:|AM0PR04MB5747:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB574729D21E4F58425ECA13B6888E0@AM0PR04MB5747.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(189003)(199004)(51914003)(66476007)(64756008)(71190400001)(66446008)(66556008)(66946007)(71200400001)(7696005)(6506007)(110136005)(81166006)(305945005)(8936002)(316002)(74316002)(81156014)(76176011)(6436002)(26005)(6246003)(5660300002)(9686003)(52536014)(55016002)(6116002)(3846002)(102836004)(76116006)(256004)(86362001)(2501003)(33656002)(54906003)(8676002)(66066001)(2906002)(44832011)(486006)(4326008)(4744005)(7736002)(11346002)(2201001)(476003)(446003)(25786009)(14454004)(186003)(99286004)(478600001)(229853002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5747;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GPIIbIENDWkfactZmmUKFpXH1vvnz4L30zi8NdPRT4pC6hWdyXUL9hamM6ZHO6NxvAC3khjJ0uCOVddRW4fteFIkry3aL+nPNnEf3qtAx9/0DwGn45dUJGE2elUEg6OpMDRVxDeWmUht6/lXGJTG6vdLgn36THs2FJoNCZUZtfqliqvd50XoOWA7yx7g7EPu8C+O4CakV4zraLuqQMXrL4n0UvAjIi/zy/h4UziKv6/ffzwki0zGB479lsxRxOpa68dBsG0OQzd3aIgSY0qHdwdNsH5gv9OvlWqfYRS1ZEh0vQvw4JvBiMfCprZ6pj7ZphAHcAk0wZt5cMvOPNQGEa/e7d2Ik/B/FDozCd+A4CwEdMJWtTRSAxLA0zWs4m6aZIut0EZrl0vP4lpJ2sGR2qU7w4B7FjnfomSxkca5Epw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8573167e-1f44-42ba-f944-08d73bfb6484
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 05:45:20.3162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ugd6h1Tw4hDML8W2fv4bweoM2Nref7HT0XRYC/b3yNMWrzkpbG4nI7EUuV/U7Ev+1tywvTFBctk3IRyQlDxTvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5747
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFYzIDAvNF0gY2xrOiBpbXg4bTog
Zml4IGdsaXRjaC9tdXgNCj4gDQo+IFF1b3RpbmcgUGVuZyBGYW4gKDIwMTktMDktMTYgMjM6MjA6
MTUpDQo+ID4gSGkgU3RlcGhlbiwgU2hhd24sDQo+ID4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCBW
MyAwLzRdIGNsazogaW14OG06IGZpeCBnbGl0Y2gvbXV4DQo+ID4NCj4gPiBTb3JyeSB0byBwaW5n
IGVhcmx5LiBJcyB0aGVyZSBhIGNoYW5jZSB0byBsYW5kIHRoaXMgcGF0Y2hzZXQgaW4gNS4zIHJl
bGVhc2U/DQo+ID4NCj4gDQo+IE5vLCBpdCB3b24ndCBiZSBpbiA1LjMgYmVjYXVzZSB0aGF0IHZl
cnNpb24gaXMgcmVsZWFzZWQuIFNoYXduIGFscmVhZHkgc2VudCB0aGUNCj4gUFIgZm9yIDUuNCB0
b28gc28gdGhpcyB3aWxsIG1vc3QgbGlrZWx5IGJlIGluIHY1LjUgYXQgdGhlIGVhcmxpZXN0Lg0K
DQpUaGFua3MgZm9yIHRoZSBpbmZvLiBCdXQgdGhpcyBwYXRjaHNldCBpcyBidWdmaXgsIHNvIGhv
cGUgdGhpcyBjb3VsZCBiZSBhY2NlcHRlZCBpbiA1LjQuDQoNClRoYW5rcywNClBlbmcuDQoNCg==
