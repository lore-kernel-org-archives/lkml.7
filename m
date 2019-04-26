Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392DAC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097952084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DKfH3dt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfDZJW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:22:58 -0400
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:2428
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfDZJW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wosop9x7jdko7Nj7Ym8CzXYQTWX3mLF2psofi+kn098=;
 b=DKfH3dt69JNimngpqvyLZAGsZcN266mNG7MFIPBgK0kiNTBVigWExG4cK1heUbQL8Ciwfj+KkPAcj0rPB6f6SguiTUCutQvw+4Xc+DWTHXd+3xzKa2Med8QnFowm6skF0xIbQ9pCBekBzDgl51Q2wETGUla6rw9plvyOewVYjSE=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4382.eurprd04.prod.outlook.com (20.177.55.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 09:22:52 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 09:22:52 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v2 06/15] spi: imx: fix ERR009165
Thread-Topic: [EXT] Re: [PATCH v2 06/15] spi: imx: fix ERR009165
Thread-Index: AQHU/AbWhmFw/8q/U0K0862nrKFDRaZOJtSAgAACnAA=
Date:   Fri, 26 Apr 2019 09:22:52 +0000
Message-ID: <1556270196.9298.16.camel@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
         <1556265512-9130-7-git-send-email-yibin.gong@nxp.com>
         <1556269635.2584.23.camel@pengutronix.de>
In-Reply-To: <1556269635.2584.23.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ed310d5-5c24-4c08-f16b-08d6ca28c271
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4382;
x-ms-traffictypediagnostic: VI1PR04MB4382:
x-microsoft-antispam-prvs: <VI1PR04MB438293F0BF0D3D85BD40DE99893E0@VI1PR04MB4382.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(99286004)(6246003)(76116006)(14454004)(103116003)(7736002)(76176011)(478600001)(97736004)(305945005)(53936002)(6512007)(91956017)(229853002)(68736007)(66556008)(66446008)(66476007)(64756008)(73956011)(66946007)(54906003)(81156014)(66066001)(8936002)(25786009)(8676002)(7416002)(110136005)(316002)(6436002)(3846002)(6116002)(50226002)(5660300002)(186003)(486006)(476003)(446003)(2616005)(11346002)(6506007)(256004)(71200400001)(53546011)(4744005)(2201001)(71190400001)(2501003)(102836004)(86362001)(36756003)(26005)(81166006)(4326008)(6486002)(2906002)(99106002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4382;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KjUsXsuONhYH6/4vhS87NYAhb2lV/YHuQlYC2tItfpine6qMFRuCorEQDF38+FItCRj+NdHcp0efSXx01fsbqsJUz+mf4+gJJPb6aRtGmN1Lqw2q88Xn0zi3JX9Izzt6SjCjWkKfcIxYARynymOOmVhUYwynAkfjyoAMP9a+MO4945AClvfrHEZ+stTFVf/mbwLaegayR54smaGzpYd/sOUY476U+1kKzsEMKuSt+wD+xxC+OWpizBW/3vYkJHkEWSITUhjJp8Ppt0iN+odj5NnMFCFN5FSdHjHS8m1VgNUP2W/IN1U+5NW0wi+7H+Q0MY0pYIthRbc9flJcxtQVwWTDD7hBBzlyumTRoV4FQV7coh3irgLWIC9QhuZXzymIfFUC8nvFI3ugfw6iEjYW+CfaOsT/+c/ul9qtefMNgs8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1CDFF5781E36B4989E32D766AA48CC6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed310d5-5c24-4c08-f16b-08d6ca28c271
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 09:22:52.7992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4382
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0yNiBhdCAxMTowNyArMDIwMCwgTHVjYXMgU3RhY2ggd3JvdGU6DQo+IA0KPiBB
bSBGcmVpdGFnLCBkZW4gMjYuMDQuMjAxOSwgMDg6MDUgKzAwMDAgc2NocmllYiBSb2JpbiBHb25n
Og0KPiA+IMKgc3RhdGljIHZvaWQgbXg1MV9zZXR1cF93bWwoc3RydWN0IHNwaV9pbXhfZGF0YSAq
c3BpX2lteCkNCj4gPiDCoHsNCj4gPiArwqDCoMKgwqDCoHUzMiB0eF93bWwgPSAwOw0KPiA+ICsN
Cj4gV2l0aCBhIHdtbCBvZiAwIHlvdSBtaWdodCBzZXQgdGhlIG1heGJ1cnN0IG9mIHRoZSBUWCBk
bWEgY2hhbm5lbCB0bw0KPiBmaWZvc2l6ZSB0byBtaW5pbWl6ZSB0aGUgcGVyZm9ybWFuY2UgaW1w
YWN0IG9mIHRoaXMgd29ya2Fyb3VuZC4NCj4gDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQpVbmZvcnR1
bmF0ZWx5LCB0aGlzIGlzIGEgTVVTVCBwYXJ0IG9mIGVycmF0YSB3aGljaCBjYXVzZSBwZXJmb3Jt
YW5jZQ0KZHJvcC4=
