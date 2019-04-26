Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA04C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA33320679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R+NrbqOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfDZJxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:53:21 -0400
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:29774
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbfDZJxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9X0lFLFu5hU4An1MKR8CvmECnj8n58d88ndqF4/cPM=;
 b=R+NrbqOSRYy+VcQeYSt4LsZu2N18ntYUxfHJd9Hob5HZrzjsBKCl3DNOLdISbnbxR/zbgmibgTH3rbl0bfAzy+Z4DFfNIWEERKJHtIRVRSZuYEjsSRvHqQy+rFhZkQd8UcNPvXu827lqgbudomC+QqXHkboHRmNSwUf2NR2YIR0=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3085.eurprd04.prod.outlook.com (10.170.228.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Fri, 26 Apr 2019 09:53:16 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 09:53:16 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v2 06/15] spi: imx: fix ERR009165
Thread-Topic: [EXT] Re: [PATCH v2 06/15] spi: imx: fix ERR009165
Thread-Index: AQHU/AbWhmFw/8q/U0K0862nrKFDRaZOJtSAgAACnACAAAXOAIAAArEA
Date:   Fri, 26 Apr 2019 09:53:16 +0000
Message-ID: <1556272020.951.1.camel@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
         <1556265512-9130-7-git-send-email-yibin.gong@nxp.com>
         <1556269635.2584.23.camel@pengutronix.de>
         <1556270196.9298.16.camel@nxp.com>
         <1556271442.2584.29.camel@pengutronix.de>
In-Reply-To: <1556271442.2584.29.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04b5f809-3d76-4339-4dca-08d6ca2d019a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3085;
x-ms-traffictypediagnostic: VI1PR04MB3085:
x-microsoft-antispam-prvs: <VI1PR04MB3085FA5945747F8FCF462D30893E0@VI1PR04MB3085.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(4326008)(53936002)(36756003)(81166006)(102836004)(8676002)(14454004)(446003)(93886005)(76176011)(50226002)(99286004)(81156014)(53546011)(11346002)(91956017)(5660300002)(7736002)(256004)(8936002)(6506007)(4744005)(305945005)(478600001)(2616005)(25786009)(66066001)(476003)(6116002)(486006)(71200400001)(64756008)(3846002)(97736004)(2906002)(71190400001)(26005)(86362001)(6246003)(68736007)(66556008)(66446008)(229853002)(2201001)(73956011)(6486002)(66946007)(103116003)(110136005)(76116006)(54906003)(6512007)(66476007)(2501003)(316002)(7416002)(6436002)(186003)(99106002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3085;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZAp9swWtr5npGwqbwALD/5XSwRqqj1KQUK2KCcS9V6W8N4w1xoGCGqiRaAp3466yvn4CxVc3bEz87T4DeN0udDMExDk6nzwgV3f46CdlEZSsTQeIzE104zdk68A4Fbn4miUw5ndt0vS1VqRBu6SS2a/4WL63jxJr2RXjl5YdLLeA/hlja9D+eQEELY5TQS4rJD1Meum33jA6J5poJOdItJaHnln1j6Pp316/zwRvweNGSkg0eqtupQJ/8uVvwzNWDSofhtErTvlQcV9ADBJK+Lg25HW+YyovbTNxlmuxeqX8HpbKI3F9fGK0b2kl2jakNrjdSZcDNujx17sXEK6BmZQ11jAtN8SEXnqjcbDWsWAwnrw4fb4Frmn5JCcdyzhRy4LCYDownlhIB2IMjzKERHf76dPmKhIMEkPbqCmTUlg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1E243CA31B122469B45E9233F923901@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b5f809-3d76-4339-4dca-08d6ca2d019a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 09:53:16.7161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0yNiBhdCAxMTozNyArMDIwMCwgTHVjYXMgU3RhY2ggd3JvdGU6DQo+IEFtIEZy
ZWl0YWcsIGRlbiAyNi4wNC4yMDE5LCAwOToyMiArMDAwMCBzY2hyaWViIFJvYmluIEdvbmc6DQo+
ID4gDQo+ID4gT24gMjAxOS0wNC0yNiBhdCAxMTowNyArMDIwMCwgTHVjYXMgU3RhY2ggd3JvdGU6
DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gQW0gRnJlaXRhZywgZGVuIDI2LjA0LjIwMTksIDA4OjA1
ICswMDAwIHNjaHJpZWIgUm9iaW4gR29uZzoNCj4gPiA+ID4gDQo+ID4gPiA+IMKgc3RhdGljIHZv
aWQgbXg1MV9zZXR1cF93bWwoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCkNCj4gPiA+ID4g
wqB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgdTMyIHR4X3dtbCA9IDA7DQo+ID4gPiA+ICsNCj4gPiA+
IFdpdGggYSB3bWwgb2YgMCB5b3UgbWlnaHQgc2V0IHRoZSBtYXhidXJzdCBvZiB0aGUgVFggZG1h
IGNoYW5uZWwNCj4gPiA+IHRvDQo+ID4gPiBmaWZvc2l6ZSB0byBtaW5pbWl6ZSB0aGUgcGVyZm9y
bWFuY2UgaW1wYWN0IG9mIHRoaXMgd29ya2Fyb3VuZC4NCj4gPiA+IA0KPiA+ID4gUmVnYXJkcywN
Cj4gPiA+IEx1Y2FzDQo+ID4gVW5mb3J0dW5hdGVseSwgdGhpcyBpcyBhIE1VU1QgcGFydCBvZiBl
cnJhdGEgd2hpY2ggY2F1c2UNCj4gPiBwZXJmb3JtYW5jZQ0KPiA+IGRyb3AuDQo+IEknbSBub3Qg
dGFsa2luZyBhYm91dCBjaGFuZ2luZyB0aGUgV01MLCBidXQgd2hlbiB0aGUgV01MIG11c3QgYmUg
MA0KPiB5b3UNCj4gY2FuIHNhZmVseSBpbmNyZWFzZSB0aGUgRE1BIGJ1cnN0IHNpemUgd2l0aG91
dCBvdmVyZmxvd2luZyB0aGUgRklGTywNCj4gd2hpY2ggbWlnaHQgcmVjb3ZlciBzb21lIG9mIG9m
IHRoZSBwZXJmb3JtYW5jZSBsb3NzLg0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCkdvb2QgcG9p
bnQsIHdpbGwgYWRkIGl0IGluIFYzLCB0aGFua3Mu
