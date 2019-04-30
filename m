Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F279CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12E120673
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uqSmWcAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfD3DB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 23:01:26 -0400
Received: from mail-eopbgr40089.outbound.protection.outlook.com ([40.107.4.89]:12307
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729803AbfD3DBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTCboBtbWmI42c5L9eJhDzDa552+KZ8lt/rfaZt7Xsk=;
 b=uqSmWcADCFYB2qWk7bk6JY9EfgvXy9xFAj7ftPvPvEEBkNArAcQGnsZ9nJYrl4rDErGRGQBw0FCwSvcaCP8NAfO+vPSImMqOt5yIOp67SHbuHSuQZkG5oCiOA61JyD/7FSTBG5UFT91R0Rp6XdE8V2onb/UdkHl9lCFmjrx8SGg=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5892.eurprd04.prod.outlook.com (20.178.203.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 30 Apr 2019 03:01:20 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 03:01:20 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] clk: imx: pllv3: Fix fall through build warning
Thread-Topic: [PATCH] clk: imx: pllv3: Fix fall through build warning
Thread-Index: AQHU/vfDJ+hnJuSvCk6GSL1CreUf2aZUA+yA
Date:   Tue, 30 Apr 2019 03:01:20 +0000
Message-ID: <AM0PR04MB421136B8851E8AB81C7E8DDC803A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1556589033-6080-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1556589033-6080-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfea6222-dc27-4aa2-5d16-08d6cd181f64
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5892;
x-ms-traffictypediagnostic: AM0PR04MB5892:
x-microsoft-antispam-prvs: <AM0PR04MB5892EDD4458D8F7C38142B40803A0@AM0PR04MB5892.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:14;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(102836004)(5660300002)(8936002)(11346002)(256004)(99286004)(446003)(316002)(110136005)(53936002)(76176011)(7696005)(6506007)(53546011)(14444005)(8676002)(68736007)(305945005)(74316002)(86362001)(81156014)(97736004)(81166006)(14454004)(71200400001)(2201001)(71190400001)(7736002)(4744005)(186003)(66066001)(478600001)(55016002)(229853002)(3846002)(9686003)(26005)(64756008)(6436002)(44832011)(486006)(2501003)(2906002)(4326008)(6116002)(76116006)(73956011)(66946007)(476003)(25786009)(52536014)(33656002)(6246003)(66476007)(66556008)(66446008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5892;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GIm4y/s6pso6GUotWMcoKmpnU0K947BM3DZrcSwD/evAlz8dAPkYbjzFjmHKy3sKcjPsxr5HpJ8fgWdrgJI+t3bC6P1G8pX4odqKbw+3Auqbu8lqiWbJT9310gvgASz+EV+IakL9xd2Tsq5O2vUexc8og07+ynbDYVsWBMi5w8Uc7QmZUWZ04eolj2InOXIup3KN4LNtJCwmPGvYUuOJ0JCvxFiS2KdGqggAB1/y3P20/ONa4ICYhoi+Sx+zEium5yZj4l5FI7KMwYuZOECDlsgPh6sdudPOsqIZ6ydPVKh4S2H97znnW+FxruysLZtg+3+sXNaW9jrtbpDg7dfDnSRVksD4m24DBjR5PierjLXLG1oLU4DFIQPwMMsAb/xiuXrGmBxrPZu5duKo2vJ6J3eq43iRKuRjGsgy851rtfU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfea6222-dc27-4aa2-5d16-08d6cd181f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 03:01:20.8163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5892
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAzMCwgMjAxOSA5OjU1
IEFNDQo+IFN1YmplY3Q6IFtQQVRDSF0gY2xrOiBpbXg6IHBsbHYzOiBGaXggZmFsbCB0aHJvdWdo
IGJ1aWxkIHdhcm5pbmcNCj4gDQo+IEZpeCBiZWxvdyBmYWxsIHRocm91Z2ggYnVpbGQgd2Fybmlu
ZzoNCj4gDQo+IGRyaXZlcnMvY2xrL2lteC9jbGstcGxsdjMuYzo0NTM6MjE6IHdhcm5pbmc6DQo+
IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9
XQ0KPiANCj4gICAgcGxsLT5kZW5vbV9vZmZzZXQgPSBQTExfSU1YN19ERU5PTV9PRkZTRVQ7DQo+
ICAgICAgICAgICAgICAgICAgICAgIF4NCj4gZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2My5jOjQ1
NDoyOiBub3RlOiBoZXJlDQo+ICAgY2FzZSBJTVhfUExMVjNfQVY6DQo+ICAgXn5+fg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoNClJldmll
d2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpE
b25nIEFpc2hlbmcNCg==
