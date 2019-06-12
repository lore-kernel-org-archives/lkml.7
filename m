Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE7DC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E173720896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ju4LKV+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407678AbfFLDyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 23:54:37 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:54990
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406758AbfFLDyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 23:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5y5vSOxQ1vFiT3txUAqQuK5J5zFuJdPc2T3Vj/dFww=;
 b=Ju4LKV+tHS/Mr1D9l17U+/wezNl4nd5+LC9UfKUrU/taSANF38IeGmQZdwfdjQZvGanTxiis2oLWh2XAGJVZoYXp90iPc5jYw6T3dGzil0q6YaP8/vG/gw6i5UZe5JUz0oViYidNFhRwZaR7A9WFFf0m/U1rvbPJmiysFrS4UXI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5203.eurprd04.prod.outlook.com (20.177.42.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Wed, 12 Jun 2019 03:54:30 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::11e1:3bb9:156b:a3e4]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::11e1:3bb9:156b:a3e4%3]) with mapi id 15.20.1965.017; Wed, 12 Jun 2019
 03:54:30 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] soc: imx8: Use existing of_root directly
Thread-Topic: [PATCH 2/2] soc: imx8: Use existing of_root directly
Thread-Index: AQHVIM/DO5YY7FKnPE+TSFiseBOReKaXYxTA
Date:   Wed, 12 Jun 2019 03:54:30 +0000
Message-ID: <AM0PR04MB42119EED46EECC647451A8C280EC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190612033620.3556-1-Anson.Huang@nxp.com>
 <20190612033620.3556-2-Anson.Huang@nxp.com>
In-Reply-To: <20190612033620.3556-2-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 106031d4-2fdc-4e9b-ce6c-08d6eee9ac5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5203;
x-ms-traffictypediagnostic: AM0PR04MB5203:
x-microsoft-antispam-prvs: <AM0PR04MB5203D10952F9DD7538F7861180EC0@AM0PR04MB5203.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(6246003)(86362001)(2201001)(53936002)(68736007)(3846002)(2906002)(110136005)(478600001)(66946007)(6116002)(33656002)(55016002)(316002)(4326008)(14454004)(9686003)(256004)(229853002)(25786009)(71190400001)(71200400001)(6436002)(8676002)(99286004)(558084003)(7696005)(76116006)(81166006)(81156014)(8936002)(73956011)(6506007)(66446008)(66556008)(52536014)(76176011)(486006)(446003)(11346002)(44832011)(74316002)(102836004)(476003)(26005)(305945005)(66066001)(2501003)(7736002)(66476007)(186003)(5660300002)(64756008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5203;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bf39/5dLa6KxRZOqMNh3UGvu7fG5XoMDxAuUwFFoU2Us1VZc+ub1s6hxxB9yN8/SxYZoUPtrMNVOG68h4kfKnpPr+ILymC7KFPIpPKynZOjXNS6PQp7NegT8uhD6BJevpjfGrEx1bDMd9HdH5M7tQ+ugZwES1EBYwIZmV6/06D2xV2UjSmaxD8a8uhEsv7QwUs0Vjl34HpmFIJuS9TyPVw1z4rSe+plwY7lmN5rMv8P/CsbrUVMPbGoKegU90sNrI59bPbKHrxBBorsgL03ZjxMbBm+He0dZGiWBAgH0SHfDEGVejccdyUYg+U7gWnXIkmR9YXmTiJXrxNxPfhOG+5z0DlkKCJfuvbZ/afJI56ZZbkXT6qd8CgS1KfbrlNpT9slnqhJMoa/8QaT2VTyxJ7ETgc1NCAPnOyGncv6scnQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106031d4-2fdc-4e9b-ce6c-08d6eee9ac5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 03:54:30.4357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbi5IdWFuZ0BueHAuY29tIFttYWlsdG86QW5zb24uSHVhbmdAbnhwLmNvbV0N
Cj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDEyLCAyMDE5IDExOjM2IEFNDQo+IA0KPiBUaGVyZSBp
cyBjb21tb24gb2Zfcm9vdCBmb3IgcmVmZXJlbmNlLCBubyBuZWVkIHRvIGZpbmQgaXQgZnJvbSBE
VCBhZ2FpbiwgdXNlDQo+IG9mX3Jvb3QgZGlyZWN0bHkgdG8gbWFrZSBkcml2ZXIgc2ltcGxlLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoN
ClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdh
cmRzDQpEb25nIEFpc2hlbmcNCg==
