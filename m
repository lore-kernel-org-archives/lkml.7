Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6B7C04AAC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E95220651
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wxpgMpDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfEEGdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 02:33:06 -0400
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:46565
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfEEGdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 02:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PheNmCk/fCWwFkpW/CuDaV0ceEXwtKl1bu0xt1OBUw0=;
 b=wxpgMpDe3AHkO/6+PyHeuKiPHVP4CtTxBW8ixE8v4xn/QmA1DNNBHvbKl079QbHiOHHe2pOB7UPTBoaIGZCvtQ0pgsLCJGke0A+pZnvEovsD4V+DdZzy4H9AbEirLqA686omSbMulI47FlvIs6roX1aKKgKjk/hg0Y3aayXFWVQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4196.eurprd04.prod.outlook.com (52.134.90.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Sun, 5 May 2019 06:33:01 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 06:33:01 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "pp@emlix.com" <pp@emlix.com>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "colin.didier@devialet.com" <colin.didier@devialet.com>,
        "robh@kernel.org" <robh@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "hofrat@osadl.org" <hofrat@osadl.org>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "stefan@agner.ch" <stefan@agner.ch>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] clk: imx: Use imx_mmdc_mask_handshake() API for
 masking MMDC channel
Thread-Topic: [PATCH 2/2] clk: imx: Use imx_mmdc_mask_handshake() API for
 masking MMDC channel
Thread-Index: AQHVAwprvav6jLJUMkyc/F/3+e7M8aZcEoJQ
Date:   Sun, 5 May 2019 06:33:01 +0000
Message-ID: <AM0PR04MB4211FA2D0264710BF2F9C41C80370@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1557036830-13567-1-git-send-email-Anson.Huang@nxp.com>
 <1557036830-13567-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557036830-13567-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84e5e0b6-cb8c-4b26-32fb-08d6d12385b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4196;
x-ms-traffictypediagnostic: AM0PR04MB4196:
x-microsoft-antispam-prvs: <AM0PR04MB41963107406F0923E04F6D9380370@AM0PR04MB4196.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(66066001)(6246003)(53936002)(14454004)(66556008)(4326008)(7416002)(2501003)(44832011)(26005)(186003)(476003)(2201001)(7736002)(486006)(305945005)(316002)(81166006)(2906002)(76116006)(81156014)(66476007)(66446008)(73956011)(9686003)(8676002)(66946007)(8936002)(64756008)(5660300002)(6436002)(86362001)(55016002)(229853002)(52536014)(68736007)(71200400001)(71190400001)(6506007)(7696005)(76176011)(558084003)(256004)(102836004)(33656002)(99286004)(6116002)(446003)(3846002)(11346002)(110136005)(478600001)(74316002)(25786009)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4196;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dd93fkmz11SoqOTVGDIgYSQPxkPBUQtFHzBXw5fVb9MFcjiISl1cX1rn2c1RBCcRGRJ9G7rCESm/9MjwrU8kc6IWZiofu1GCyCNBKsMB5blTz/fUbb1Pnf+bs4k8uUPyTU1t0mzQ6LL+UAJEmPg5aE/slw1LH+cwjtkFUmPkRCdhYAgdMNVmxoiKVwrN/1db4gZ7ZZcaQ2oZ/PZj3/AsDO8OoLmKFUopVg6U9tEw4u5kokYHBQK2MTPPjjzJerNK2yKR9VzYL1OZrdVPNY0WnjmVXJGs+2OyX5faPIDNJYAhqGvDRw91nacST7FOt1ulfgJlr6SIQWTY7WYBjtbr8LWXNeyX7clNGI5qxZTBqADNqLwr7Xh9PU1SYIPr6t+b61O7C329VdI7ziJa74zX8U+4bUF8ogE5hlnR4d5i58w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e5e0b6-cb8c-4b26-32fb-08d6d12385b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 06:33:01.6540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBTdW5kYXksIE1heSA1LCAyMDE5IDI6MTkgUE0N
Cj4gDQo+IFVzZSBpbXhfbW1kY19tYXNrX2hhbmRzaGFrZSgpIEFQSSBpbnN0ZWFkIG9mIHByb2dy
YW1taW5nIENDTSByZWdpc3Rlcg0KPiBkaXJlY3RseSBpbiBlYWNoIHBsYXRmb3JtIHRvIG1hc2sg
dW51c2VkIE1NREMgY2hhbm5lbCdzIGhhbmRzaGFrZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFu
c29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogRG9uZyBBaXNo
ZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQo=
