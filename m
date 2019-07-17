Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DECC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ED120880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X44Pl8Ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfGQK0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:26:34 -0400
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:65447
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfGQK0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:26:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQx+W2UPZJByIx+J/oXIOWBjgYsbwbfnQ2PGkEfxZZ8m9RDurVepKSugahDvb2b5Wde+75yUvqoSgvtHS+P1FnB/jQOb2rU90gdPUKgPUe9DhRrKnKmuIhdCYJVXMYr5ChBV/2cmz53AKU2IiAI629111l6DiJA3OTTUSd/VkFsMoJzvPHW9W2yJd++h4fA+5bEdiUEQL1VjnApG54LkORax/jRXn0WKhhwXMU54jO4ajFImmpk6Sz28MQK5PzsNRFl2G4z6xhi86oHe5hZxQAqMODx20eo1a41vx2Kj+S2LSomyeBbQvDW7Zg7ua1SLWY2zPUZpXWc/wSzVfAg7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swgPGqtt1BaNBY8SzzBCVBDSwX2D8vPm7WqfMY5jRJc=;
 b=KJgmBYP4s7x4SAxGRo8hHpIlfMIC67iZF2GGJESvwuKJBs+i+E+Ct+OGQP5eg82+fAVcvdFdu5W5F+t1fBlaGvRe3kFbmgYG1RbsvieVo6Ci9XGyOk64752u3PsXX7IV2E5VOgg77REiiA4r8yJtUjfSmlMjH9IbAZNbeOH/cCrH9Y1/aDyU6WYwuDfZlii111gnkaBi7cEH87rdrCl3VSxO334BaLAqpojZ9dbreNeMz6IxFk2FY9tW5IWQ3NfuEumYRuR8FI65fj/o7KuHQRd/PgZm3Kfl6IDLo3HFcc2pAAQPpiILjKecKLozxbU9PX96wuaeCOW5BFOTmY85kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swgPGqtt1BaNBY8SzzBCVBDSwX2D8vPm7WqfMY5jRJc=;
 b=X44Pl8Mlq3B5VzEmpmdcJw2IYRHi+YpMh3Hdv3Twj5K/rm9lgN31vZvizhetCveoknh8NoQBwC2GD5An5jhYqOFiGJaJnt10iuVe9HFI6ANgydzWL8buLz6wI1pGz/Pr9uHMuj+6fu3tY5q6qfPP/dLV3G9ed2UkHZM0TOKYSR4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6306.eurprd04.prod.outlook.com (20.179.33.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 10:26:31 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431%7]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 10:26:30 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Darshak Patel <Darshak.patel@einfochips.com>,
        Kinjan Patel <Kinjan.patel@einfochips.com>,
        Prajose John <Prajose.john@einfochips.com>
Subject: RE: [PATCH 1/3] dt-bindings: Add Vendor prefix for Einfochips
Thread-Topic: [PATCH 1/3] dt-bindings: Add Vendor prefix for Einfochips
Thread-Index: AQHVPGZqg5LESwYIhES8Xd8HR6s4kqbOmyvA
Date:   Wed, 17 Jul 2019 10:26:30 +0000
Message-ID: <AM0PR04MB4211BC8A04B5FB935E15598980C90@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190717061039.9271-1-manivannan.sadhasivam@linaro.org>
 <20190717061039.9271-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190717061039.9271-2-manivannan.sadhasivam@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ef2cd81-8324-4319-be20-08d70aa13c0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6306;
x-ms-traffictypediagnostic: AM0PR04MB6306:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB6306DB898244413AFEDBCA8D80C90@AM0PR04MB6306.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(199004)(189003)(7416002)(81166006)(81156014)(446003)(74316002)(2501003)(7736002)(25786009)(64756008)(66946007)(66476007)(66556008)(66446008)(86362001)(8936002)(478600001)(558084003)(68736007)(76116006)(54906003)(316002)(8676002)(110136005)(53936002)(76176011)(55016002)(5660300002)(6436002)(3846002)(4326008)(6116002)(66066001)(33656002)(52536014)(7696005)(11346002)(476003)(14454004)(2906002)(71190400001)(44832011)(305945005)(486006)(71200400001)(9686003)(6246003)(229853002)(186003)(102836004)(26005)(6506007)(2201001)(256004)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6306;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VmdGQpJUcpCONLqxkHPDIkYPx6xir8487iQp8FuzIQlfI0MBgU5ufWMsyvUM01rAYQ9eB+lbc8l34Ax5XjSAIuIcur3K85o5ADUf86H4ON1FbdzKswD7rzzWxU8ZnQT5efuYuq8k0AZM4EcybZM4SfFNA7mnp7Ue3pz0rk5BOEpDqoJilryG+mezrCPbxb8clM2d+BVxfRsK2uNLUsZPSI6MeeQOUHqENJRsJocBHqd5KYNWg3V7r+r6d+8Cl7dKvQNwDeAj4pq7LtroNf3cGsjlUGE39s8dIdGJeNrnFk3JgwXHUUbioNBO1HLRO65swFBHLYhcX1qETcb+5J1XXiEY2KUXrJCXAQFGFKnP2rnEjqZvuc5oQAVn7D0Upbx8d6n2ywRbdP8NBKwfjWbMf2uMZ06HBeyuJlzDVTRptrw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef2cd81-8324-4319-be20-08d70aa13c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 10:26:30.9052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6306
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5h
cm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMTcsIDIwMTkgMjoxMSBQTQ0KPiANCj4g
QWRkIGRldmljZXRyZWUgdmVuZG9yIHByZWZpeCBmb3IgRWluZm9jaGlwcy4NCj4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFt
QGxpbmFyby5vcmc+DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0Bu
eHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQo=
