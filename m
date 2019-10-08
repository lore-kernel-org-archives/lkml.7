Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B01ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 00:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6C2206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 00:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DFu3jjuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfJHA6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 20:58:13 -0400
Received: from mail-eopbgr10075.outbound.protection.outlook.com ([40.107.1.75]:12231
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbfJHA6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 20:58:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8OtWXGbC/yqCoA3emOEmnRy8ES1AYNnnUj2hbsl+5FwsJors7ScnOlH/eCiF5abJAIX+NrpIBuoeUGZFB0THZKsG8nn9ZsLClg3ghj6/AEELr4N3hcLOZ9Zitp4yuZsZjpIxGxgBCqpr0aQXGwNKj8eziMCQobuFO5wQGc4YmAxKP56X5Sq5uy0Ip3+v1o6ShAhwnxqe9lugbsKmzNIkOxllMPCXw6WzlHAm8F4LDxdBO/8gpFn7wWUy+ePAghownRv8GEjIVUrHyJ2c0gfNsqgf08adNlCrDOA02ejEH2OTgVf79hs2yh55BAF8UKAs/Py19dy3R2tP3zn7vf5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNbEQqvbrBfzYgNQ4qBavOLjSA20xkB9J9HYqMsOmqU=;
 b=ByABkp4T4Y2xMyO5uGDbGQLSCHxjWLoh0QPgNh9M8ICxEsVTfCAgJ+b8LpLIRWtmXn5kNWDlvXSFyVxRhNx5wnbOwzw6a3rHeOVgTe2sQBNY/5/WljDPUyAwkYt6hbd//vIXJ89Rlm8Hoc6pT+Ub2ksrfupwPc8t4aNrHBIqT/uDLQxErrEoXBsloYegLXYrImMjaQhR77potJ/8OUQ6NZXPhH932of8C4VwKsnTg8Yhmk1SdszZDMcX/ODTxbP/nB8L4ArepWwLwg+RYJT/NjPdD/Kz20WKOGKkLhAiQvDIcxVClo9kLUGn8+j1MYfzPKAIzc8j4xuCbh4ZztHl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNbEQqvbrBfzYgNQ4qBavOLjSA20xkB9J9HYqMsOmqU=;
 b=DFu3jjuh9jPxGToTn+QC9x9Z8uZMFg2LrT+uYzYWUgeZVXPF4OZMBb7VZXHxWiH9J4g+/qiZMjv0Xjkm5KHemNbKA5taxTanGiqsFSPUtYA9a+hZyQrcqAX0/1n7ym3jaBzF0J28L1uhaqqhlFBjbCNUC/R7TwHuVb1zXT+mak0=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3736.eurprd04.prod.outlook.com (52.133.30.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 00:58:09 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::b0c2:4fbb:fae7:991]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::b0c2:4fbb:fae7:991%5]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 00:58:09 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] arm64: dts: imx8mq: Use correct clock for usdhc's ipg
 clk
Thread-Topic: [PATCH 1/3] arm64: dts: imx8mq: Use correct clock for usdhc's
 ipg clk
Thread-Index: AQHVbqglk8A6UJved0u2I0b9vtH2Y6dPM42AgADV4wA=
Date:   Tue, 8 Oct 2019 00:58:08 +0000
Message-ID: <AM6PR0402MB3911D80F4C96EE9500B360D2F59A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1568869559-28611-1-git-send-email-Anson.Huang@nxp.com>
 <20191007121204.GI7150@dragon>
In-Reply-To: <20191007121204.GI7150@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d178113d-dd50-4679-2cc6-08d74b8a9610
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM6PR0402MB3736:|AM6PR0402MB3736:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB37363052564DB1EC4F6EEBCFF59A0@AM6PR0402MB3736.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(189003)(199004)(486006)(71190400001)(71200400001)(54906003)(316002)(558084003)(44832011)(6116002)(3846002)(476003)(25786009)(99286004)(256004)(186003)(26005)(478600001)(66066001)(11346002)(7696005)(446003)(2906002)(6506007)(76176011)(102836004)(5660300002)(6916009)(4326008)(9686003)(33656002)(55016002)(14454004)(8936002)(81156014)(8676002)(81166006)(229853002)(7736002)(86362001)(66446008)(64756008)(66476007)(305945005)(66556008)(52536014)(76116006)(6246003)(6436002)(74316002)(7416002)(66946007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3736;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZXRWiooFutyh4aFtmVy8+NeSHu7T/7YbuaLbpLOof6z41np4j09w8cu96OL+9MtDq42EIMowi41ReAi7EQ/i7Q+eDhOBGDPw9/ONAQOQDgd3+5yZkgv65z5cP8JgFLV7DmlsEOBMGp01JQ4eE/Q5plNasdn05A/A9l3VcloBy2BHThHTFJQ/AisNdHqXPV9xfT1ceIduoonUMEM0DzdKokFyrXwSkEZCsgTxpdFvele6jtoRn4riIMq/xdOmL9ErkS56hQ35jsIl4gigedT4tV7auZ0UGvticBo0xvan9cuyiwE3b7yahPCeLd3UXhHI/YXo3c3w3hhv6zT7nJ35//wBee1w5mTXgGdc0QYGjj4oAsIczO5UWtoFmkS/WE7s/88ZQsNFf8XNyyo+t7FIZe8OrzZmh2lSmkLuvU2yLf8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d178113d-dd50-4679-2cc6-08d74b8a9610
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 00:58:09.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgWJYMXFmADUt6aD5CvVEC+f9G2wVonv6SzwIh90vei/KTjKVO5HXpVu0E971TmKYWUwq8y9NsKXm2q4pDAPSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gT24gVGh1LCBTZXAgMTksIDIwMTkgYXQgMDE6MDU6NTdQTSArMDgwMCwg
QW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gT24gaS5NWDhNUSwgdXNkaGMncyBpcGcgY2xvY2sgaXMg
ZnJvbSBJTVg4TVFfQ0xLX0lQR19ST09ULCBhc3NpZ24gaXQNCj4gPiBleHBsaWNpdGx5IGluc3Rl
YWQgb2YgdXNpbmcgSU1YOE1RX0NMS19EVU1NWS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFu
c29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiANCj4gRml4ZXMgdGFnPw0KDQpPSywg
YWRkZWQgdGhlbSBpbiBWMi4NCg0KVGhhbmtzLA0KQW5zb24NCg0K
