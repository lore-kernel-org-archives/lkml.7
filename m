Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0A5C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E520205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m895fmqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389979AbfGRDaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:30:20 -0400
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:4327
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389773AbfGRDaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:30:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2rabypVK7X9Rdgvlad6bfzEpAT2b3n0lKES8amWaeTV1ofa9N8QLW6B02HGyCkeGzLA/dV+bWKm//bAgnLaLUjzXk91h+np7xNigcrL4XTrxVAVz9dYh+OOf/kThXDihozfxnDG3IGTpng2J6uQqjxXu31dpfCO0WxVHtuGtR3KOn1dA3/wm5H74pZPKrnYS94ovoddtjvHFL2Q9PMZIbNqupKfE0e8JZkvA0q7SElHufJKUYLh7X4ieGs7AuLEEOFO70Su1rXbAwWyuvXL9pJ7UzI7uhBqhSnICaX+3HyFqlaZNIhGTb1JT1z3FGjW5B1sYUA0suLVnCQVcVkSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCgkhsgF0SnJpGM5mZaKF3Y16kIIuExe5osNM0Ole5Y=;
 b=Cg0YEiBBEnL8/WelOdPEZFSGWjIgGbCHg+8Vz1wELsMSc8Zg9Brnp18uualU52R5Laf32p92+Ptgq/7OoQ4nogKa/rTAKM2FBNOorQhhAS/KHGEKpp3sCf3yOWSy0eDQHh+PDp7f51z9TfVjP++978Lw2SwNq7tZ2gA4sG/EMHLUu0096n72yNvtfHF+ohTCTZvZVlrC6/sVqBUCz7QROxqXxfYaYJpkrvjzj78lE7jDSH9CPMaPhajujPVZbVdG1Sb6+Yv75W47SwbOruaWWVCbTVpM4GnY15B///2QtNCjWbP7wV+EFLPO/kHMyDsB+sKpGkm795q3U3AWNPjDcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCgkhsgF0SnJpGM5mZaKF3Y16kIIuExe5osNM0Ole5Y=;
 b=m895fmqnWmYolX1WLQO+uILTQd+g00BzZQDHPvNXLcLYEvlTHK9yvMncFxmfiSHaTD3WxrPmxlH3uEf0MgfpAwyVdRB/VJ+lTHUzStFrTufLk4UjbjQYox4U3mR5jrGz8hMPY7JXpp/3MqP6zS0ZiQEnUYpF8osT+2hKElZqjLQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5857.eurprd04.prod.outlook.com (20.178.118.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 18 Jul 2019 03:30:16 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431%7]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 03:30:16 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH 3/3] firmware: imx: scu-pd: Add IRQSTR_DSP PD range
Thread-Topic: [PATCH 3/3] firmware: imx: scu-pd: Add IRQSTR_DSP PD range
Thread-Index: AQHVMdIgOTCMFsCxF0qH2yiAwH8izabPzmyw
Date:   Thu, 18 Jul 2019 03:30:16 +0000
Message-ID: <AM0PR04MB421126724996C4E0BC80954980C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190703190404.21136-1-daniel.baluta@nxp.com>
 <20190703190404.21136-4-daniel.baluta@nxp.com>
In-Reply-To: <20190703190404.21136-4-daniel.baluta@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a280a931-b88e-407b-e3c4-08d70b304078
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5857;
x-ms-traffictypediagnostic: AM0PR04MB5857:
x-microsoft-antispam-prvs: <AM0PR04MB5857850609FC0DE97D87E61580C80@AM0PR04MB5857.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(2501003)(66946007)(76116006)(66476007)(478600001)(66446008)(64756008)(305945005)(55016002)(11346002)(14454004)(9686003)(52536014)(25786009)(6506007)(186003)(74316002)(71190400001)(229853002)(558084003)(26005)(71200400001)(102836004)(6246003)(5660300002)(53936002)(4326008)(110136005)(316002)(7736002)(68736007)(256004)(86362001)(99286004)(476003)(7696005)(44832011)(486006)(76176011)(446003)(81156014)(8676002)(81166006)(6116002)(3846002)(8936002)(33656002)(6436002)(2906002)(66066001)(54906003)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5857;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VENMirr+A4PZggc6UILaiXRffFgRgISW1LwSxYLeSN9ujmiGu0kfAfW7Rpk8JTg5WZ7+9qje+N6V+bvwK8FR+8TSdtFkuZWEcCPmxEXfHFLyZGIDk88at2RI0exH5L0zp5UW88glLI0XSB/JqSnDKNaMnltz5XaHsC5/XzMu6A+UTYgxWDkLZ88wFn4+na85hQCBzZMhxmIz9+FDOkN8PtqVhPuGB6KdMoY5JjfohvRT4FBVE5esPaDzTdf5Ji7z2hRfhE5+KtR7fbMLwqn/HjLtcOwV69Oqnh5CWdDi7Kg+LuNDo1m6rYUu0WtFtUeSYUPiqZqfGtp2Dy6E4Shj2N5X2lgrDE1YtY1varVKOSesnF3lIQCPGc3WSQTdWhNvUXo0BlnTQV3IcPjrdqxjim+XO9ktZg4yEjse+jioUw0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a280a931-b88e-407b-e3c4-08d70b304078
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 03:30:16.3215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5857
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBKdWx5IDQsIDIwMTkgMzowNCBBTQ0KPiANCj4gVGhlIERTUCBpbnRlcnJ1cHQgc3Rl
ZXIgZ2F0aGVycyBpbnRlcnJ1cHRzIGZyb20gdGhlIHN5c3RlbSBhbmQgY2FuIGJlIHVzZWQgdG8N
Cj4gc3RlZXIgdGhlbSB0byBEU1AuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQmFsdXRh
IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFp
c2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQo=
