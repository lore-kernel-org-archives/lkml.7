Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81E2C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA3D2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LjVr1Eql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfHEEtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 00:49:43 -0400
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:3489
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfHEEtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 00:49:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4vI4/l7hNM78XnO/B3RK+Qpu3zU4A46QUtHHPWvZ6u9+qSbhBu5JW9CoVfE3UtgpG6gDDXFvLz1RmsM9po2soevGZiojFhnpAeCq9lgmEc0O9B1RBDQ4kzYHAnhArMmwYdCdxmysnjnPYmb1su3XF+MtyNUrEob7Kn8mhiROjNlbAlkRxGduLJ9z3+JOsFxLmBcVdG5Z65j3preECV5S/kgqflm9tspSQzX9ym0+IB8pktzFMYfaJWOMOjPotPKdglgZlMogvK1R9XqDh7bORudwRcJRTsQ/D1GgMdmuVFrhAEqA6CkZ1QLBM+gJZ9KFCrhwaLlETDDspmEiGDVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eV/fF87jFho6PUy7c5p8SKhe/QZ+QC9qCMhoYnTvQQ=;
 b=kHm2Y/hlLJWgS1nAykws01BgYcxxoNBbvROqTraqc0LgXksiJw45ucPeLdOJ7C/VTLPSUZZentP3a+Wo2cjdSjGfr6j4pY7r2fE0431UKK8wAfhvkdG4UJ9sJU/PvRYVnl/fE+n76+r46i3lBwK6Gy4+QbsPp/QswuF4b5/9iL5clVSIJWhyQpzz8CtDyX4sAusJMHBmRcHZG8nzw0u0vmH1euZKaJbAAPMaszB97NHhjMUcrMtQMQuQpXxondwWWuuitBK2dV0lE4+4EUiBSvcJbpvgLsik66BRwFMLRuw3xab1woPsPwWyQmkzynd2wc2C6kr1JWttkf4m+wShSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eV/fF87jFho6PUy7c5p8SKhe/QZ+QC9qCMhoYnTvQQ=;
 b=LjVr1Eql3TJG67XzNoZ4012YEd6gweJTubdc/Ivs4Y8rgqcQ33hhZu1uQNJpXOE+wAw7w7mjOvvHRRodXZ9f0V/VHSVpd55fvfqmrKvMcLh6NMs8Rg/neWJ+qsMWTHWmYdO6WdbP7v/px4RUHLrbj02oeYDDUSfDuo9GH4BLI08=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6244.eurprd04.prod.outlook.com (20.179.35.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 04:49:38 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe%5]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 04:49:38 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: RE: [PATCH v5 3/4] dt-bindings: mailbox: imx-mu: add imx7ulp MU
 support
Thread-Topic: [PATCH v5 3/4] dt-bindings: mailbox: imx-mu: add imx7ulp MU
 support
Thread-Index: AQHVSzvfwQBwxXtY3ku9HZrhhBeRRKbr+r0A
Date:   Mon, 5 Aug 2019 04:49:38 +0000
Message-ID: <AM0PR04MB4211FC4E8C694E1E7DECC76780DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1564973491-18286-1-git-send-email-hongxing.zhu@nxp.com>
 <1564973491-18286-4-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1564973491-18286-4-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e816e275-f6fe-4b2e-9b0c-08d71960528c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6244;
x-ms-traffictypediagnostic: AM0PR04MB6244:
x-microsoft-antispam-prvs: <AM0PR04MB6244E42126CC816E9DDB405380DA0@AM0PR04MB6244.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:257;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(26005)(81156014)(256004)(81166006)(54906003)(9686003)(186003)(66476007)(66556008)(64756008)(8936002)(66946007)(71200400001)(71190400001)(52536014)(110136005)(229853002)(25786009)(305945005)(6246003)(99286004)(74316002)(55016002)(8676002)(7736002)(86362001)(6436002)(5660300002)(478600001)(53936002)(6636002)(14454004)(2501003)(66066001)(66446008)(3846002)(316002)(76176011)(2906002)(558084003)(6116002)(486006)(7696005)(446003)(476003)(68736007)(33656002)(102836004)(76116006)(4326008)(2201001)(6506007)(11346002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6244;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 47DbwFR7zfp1VRCe3dunRNZP0igc3MhZ0GFQ1XLM/0pGzkTHdPQSJ0iixxKwtepap8OxAdjXifb1+omUrrkogctgcp5jAs+oH0TmQ/qxa72YFVCKnC3Ki5DxgTzscGkTR/BPheyj4jtxe22fFWSadfCF8OgHJy0F+hr15gX/QSB4Ggv7mkbcs05XAw8CVnkkuZlD98pJRb63vDHt/aMIWaWkQ2cXFlUAsd6P4s98M1RiEY1f7kpOTmhkamF6DY7EGdlDY3GiedOO5RivpDO1JiKO7pgqgm7hnH3eEuoMux359KHPnDGqS7MgvWIv6L7ZLFSQZzJegwzqwz0wF+vrS8gtqAuy9/CJF+VlJOxS52LN8hdW9U1B7umy3MA46UToA/j3i12JVO7gZ6e533ZuLVfnI2U8Dv50Qxo1QrlDmOw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e816e275-f6fe-4b2e-9b0c-08d71960528c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 04:49:38.6227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgQXVndXN0IDUsIDIwMTkgMTA6NTIgQU0NCj4gDQo+IFRoZXJlIGlzIGEgdmVyc2lvbiAxLjAg
TVUgb24gaW14N3VscCwgdXNlICJmc2wsaW14N3VscC1tdSIgY29tcGF0aWJsZSB0bw0KPiBzdXBw
b3J0IGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBu
eHAuY29tPg0KDQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNv
bT4NCg0KUmVnYXJkcw0KQWlzaGVuZw0K
