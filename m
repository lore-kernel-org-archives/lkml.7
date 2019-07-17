Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD00C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4942182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HBnFqjSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfGQK2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:28:04 -0400
Received: from mail-eopbgr10048.outbound.protection.outlook.com ([40.107.1.48]:63416
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfGQK2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:28:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiEuithwOPv0/AbM0NAUjmobFggGATnc8jG9m3nuis9ER5qxyooorHG6Sf6GpMQlZ8ZWJ/geuHeXIphzUv1y28aPaNxkLaajA/JiOrAqnSJS6QdjqIxLviLNfvKSZ7IQ4vXFuLBEykDEqTB7cg7uHpVQgp8sIjwkREH24ZZSVUj/EN9obPe67kaO40OKDkApuS/HD/iMuEAI2HnlPtzc6mVcMprEJtDkgTxU/oiDeMn678fOLaDSU+DaIsX6breHdqHll3tnVuMKK1HOvgHDKoQlbUxV6KNmlLDqPAUz7rVfSS+deun57H1MKAlOtWRZNpZ9Lz0QUWoO336tvP0jxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9z9OupLGqKNUGucJ9d7gqAUQar0j5zoRIwuYy5/7+I=;
 b=QDKtg3fhjuPFZERcSvrPv2SWAixy7alnjW57UGd+QjCwJxNtKPbpMBkxtdlqq8oqJ+3AHD18pQkiVbaFgdaFEXeJux/hIfMV2rRD7UK1Pzg6w2TkrUSboko24eYjIOltBcTIgehjUGJJHIeq49FdWf4OnRb5pZcfzshM3clHMCi1w3VrFwquPSi2IT0cFeX9Mo9RmyigE1KCU2vlBRQFgXmubTu+nC1t+E0OAPHDyyn4SJN695YH3U+4ztO3Zc6WZBs+Og984tBR04UWNpzbvbfva+VE44yIHB0KulLx8g7MXqpcC0YWbVgtdTH1x5E0BKRlVdYXmyePmubStFigng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9z9OupLGqKNUGucJ9d7gqAUQar0j5zoRIwuYy5/7+I=;
 b=HBnFqjSVBzTnv/SqB1MYMvMzwlD2JFQjKSDaMp/c6pMlW87W/sb9cs+VqOeK6Vnjhs53kU4WRUdlCG9S/3tFdhnUQmNZrR9KnxHO7rzeisN4ngICNPliIcHGMxROuKKvCR7RC3dCuozAiv1D5hDevFUjN2ZIuR+H0JoJpyN8oAM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6306.eurprd04.prod.outlook.com (20.179.33.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 10:28:00 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::7882:51:e491:8431%7]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 10:28:00 +0000
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
Subject: RE: [PATCH 2/3] dt-bindings: arm: Document i.MX8QXP AI_ML board
 binding
Thread-Topic: [PATCH 2/3] dt-bindings: arm: Document i.MX8QXP AI_ML board
 binding
Thread-Index: AQHVPGZvwNKzqiH7KkCyVIF3qYYIH6bOm3TQ
Date:   Wed, 17 Jul 2019 10:28:00 +0000
Message-ID: <AM0PR04MB4211FDB909B4114B7B01232480C90@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190717061039.9271-1-manivannan.sadhasivam@linaro.org>
 <20190717061039.9271-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190717061039.9271-3-manivannan.sadhasivam@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2585ce2-9e95-4897-4caa-08d70aa17188
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6306;
x-ms-traffictypediagnostic: AM0PR04MB6306:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB630685F182C10EF754ACF38380C90@AM0PR04MB6306.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:407;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(199004)(189003)(7416002)(81166006)(81156014)(446003)(74316002)(2501003)(7736002)(25786009)(64756008)(66946007)(66476007)(66556008)(66446008)(86362001)(8936002)(478600001)(558084003)(68736007)(76116006)(54906003)(316002)(8676002)(110136005)(53936002)(76176011)(55016002)(5660300002)(6436002)(3846002)(4326008)(6116002)(66066001)(33656002)(52536014)(7696005)(11346002)(476003)(14454004)(2906002)(71190400001)(44832011)(305945005)(486006)(71200400001)(9686003)(6246003)(229853002)(186003)(102836004)(26005)(6506007)(2201001)(256004)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6306;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /LCOlTy3JMeyHbu61a508Lip0HK16Zmaf1ObArlz2uK4lMS2N1iRQhPXKhiuiUSqxtjLj0KHPbzth9SRd+biGPQqU2ipnt+uW842llvIpGj+LiZUMwJsbH+vtdKACU9a9OA+dMCFqTt4R3OUAnpx2ISqAitVa72Bq4wlbKbrj5sTGl7jOVlsO+SyFhTellDD8kDnFTcMvZrgw+mSGsgCCUhihbe+udnx+jBT8AB7ml5+aaYF7ofKZMfPkDI6bTf1PTvY1Ga9wP+ruEGRFoQBL2waKldcI4xU2Q7P38yO3fON34qCbkPHGPJtMWmAqTojWwAeAtbVEtmK9GYUrMqvZ4F6UOjN57llKWZYO4WgRccefLxszmiabZhaZIdZ3Gd555ePGBWcC+DzqlnKtXl95vHBHK7j0uRkh/cy3KhBWaY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2585ce2-9e95-4897-4caa-08d70aa17188
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 10:28:00.6485
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
RG9jdW1lbnQgZGV2aWNldHJlZSBiaW5kaW5nIG9mIGkuTVg4UVhQIEFJX01MIGJvYXJkIGZyb20g
RWluZm9jaGlwcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8
bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQoNClJldmlld2VkLWJ5OiBEb25nIEFp
c2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQo=
