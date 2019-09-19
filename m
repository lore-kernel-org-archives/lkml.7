Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14408C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBC321907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="buikSMkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbfISJbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 05:31:46 -0400
Received: from mail-eopbgr00055.outbound.protection.outlook.com ([40.107.0.55]:42499
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388194AbfISJbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:31:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDsqf2+0L+7D4OAfNr0KWaCcXQHdqdaP5sC47qI5QlT/ALFCSflSPyfaW+3vDcDTyySstv3nZAhyrBMRIIyiVB5hndbiR1zrvNcMWrnv/02WkRBLJlvcrZyneaSpRMyBrePPWg2c3XEVoJhDWdYIY/cNcfOTInHs3gEwwFf0vxvQtkgo68/lIQrl4hgFaKMCPPfcX5dCT0wTAloH/DshDOfxbq7Hz91MTyHbjp6o87iQspDyg/ThSdDIFICwUZMwatD5mS63lAeQVxDUK8QKbw2oZOJ6SBmfLcHmE9pW10fcOwJGyRgiFpAu+1woAcQsf+OmkX4PtGW7gzBzyaiSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM7TbDXLs7yBD2cyLcBcAYyc6nPRBP+zcO0yCBXE5S8=;
 b=Fzq9OoZ3Z+zJAKMBzAZzXb8RzTi2NX8uIO46miE8skknaXIn0KkieuijRiXEitGRCWUsSEKEmyYkPcQ08o7vx9vjMO+EIsLBI3KW6N8azuDmH9coUGN1fCbB38s6KB6bH2TQeYJX2cmmIxPG247wEMU3fvBs7biFpR9CCnI3Xrl0C5auyAF/54rtBua7PAcicmwexRO0E+1FjH/BGKLOx5EMU2dcAHXx8MENWDh+zAf8GkXDgtEugSe+z/684nIJAPToVfkJKQxE8X4HtOzw1npXK0yRTH9A8/ucscv/t54hzKTR+XnaTknY2mdxFlei1tR4XdtxPkvD8VXC41LKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM7TbDXLs7yBD2cyLcBcAYyc6nPRBP+zcO0yCBXE5S8=;
 b=buikSMkQEq2FwR6esT+e1KR22E+vsnHBMvvC2IUjmKjRRaKkc7PfGbhATUYXNHPrvrbVbaQTAObEWy/7YbOa9xjMLnmsgGnvvVz0u9I4RQp+p8WHRlWuG6HC6BGUhRifSK50HG16U2reO5fbTb/bBSv3/TdnDj5P38nRSuDQoNM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3884.eurprd04.prod.outlook.com (52.134.71.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Thu, 19 Sep 2019 09:31:41 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 09:31:41 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/3] arm64: dts: imx8mm: Use correct clock for usdhc's ipg
 clk
Thread-Topic: [PATCH 2/3] arm64: dts: imx8mm: Use correct clock for usdhc's
 ipg clk
Thread-Index: AQHVbqgmZ51dfuL/8Eaza5al5dL3W6cyl1gAgAAkZxA=
Date:   Thu, 19 Sep 2019 09:31:41 +0000
Message-ID: <DB3PR0402MB3916B0DE9EBC0B0F6664CE34F5890@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1568869559-28611-1-git-send-email-Anson.Huang@nxp.com>
 <1568869559-28611-2-git-send-email-Anson.Huang@nxp.com>
 <c680d114-1c14-6bf8-226c-2fdd98350158@kontron.de>
In-Reply-To: <c680d114-1c14-6bf8-226c-2fdd98350158@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8192cef0-8262-4255-f886-08d73ce42e02
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3884;
x-ms-traffictypediagnostic: DB3PR0402MB3884:|DB3PR0402MB3884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38841D7A2078EB3B83208DB8F5890@DB3PR0402MB3884.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(6436002)(305945005)(256004)(4326008)(81156014)(8936002)(55016002)(52536014)(66476007)(186003)(476003)(9686003)(4744005)(66946007)(446003)(66066001)(8676002)(64756008)(33656002)(81166006)(229853002)(11346002)(76116006)(74316002)(478600001)(2501003)(7736002)(14454004)(71200400001)(316002)(25786009)(6116002)(7696005)(3846002)(6246003)(5660300002)(76176011)(86362001)(2201001)(99286004)(486006)(71190400001)(2906002)(66556008)(110136005)(44832011)(26005)(102836004)(6506007)(7416002)(66446008)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3884;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p73s8nk4QqqxrBpMMqtuIz0JkBkYiLoPKVEssOphvnx3C4gLz/v9NFtzsgcZoFhikVp2oN65XUd5DK5XsGJgAx3r9y3jVNVJEUG4wt6HSGn/zcerdm9Yoa7hoxF7cXv3rLpdCwzgp8PXAJwDyfheDsmFWL8YTxceDabWy6yxx8o83T+TzSzEug26X0sWUG8u7ehfBivXjO/JobbHM1YsFZpw50geK8akUbZ8ArATSFcNrbxwwqFGeEGZp+3E0IcntS2eDfvz9DFQ16dC6INlVzxP1sBrEbvtSjf+6GCTlLADdKzIXRL5piMNhTBQfMbVwGXU91d7Kf0wKAEwe9GbzVFAac4wWOR4YhGiWoeLMFLeksr4YVOJd4d98y2wS9rkzsOuLsgpXIwBikC30HJZF1DiaHevXLf9ih8Xn5kLNnU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8192cef0-8262-4255-f886-08d73ce42e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 09:31:41.6582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /n9SkPxowOTGdrIdjULl9M37a01n9xHToro9WOMjlBm7wNZyEJ8uvSfCh2F7b8/SHs3DWVIgMmJvjxIWZ7dT6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNjaHJlbXBmDQoNCj4gSGkgQW5zb24sDQo+IA0KPiBJIGhhdmUgYSBxdWVzdGlvbiwgdGhh
dCBpcyBub3QgZGlyZWN0bHkgcmVsYXRlZCB0byB0aGlzIHBhdGNoLg0KPiBJIHNlZSB0aGF0IGZv
ciB0aGUgdXNkaGMxIGFuZCB1c2RoYzMgbm9kZXMsIHRoZXJlIGlzIGFuICdhc3NpZ25lZC1jbG9j
aycNCj4gYW5kICdhc3NpZ25lZC1jbG9jay1yYXRlcycgcHJvcGVydHkgYnV0IG5vdCBmb3IgdXNk
aGMyLiBUaGUgc2FtZSBhcHBsaWVzIHRvDQo+IHRoZSBteDhtcSBhbmQgbXg4bW4gZHRzaSBmaWxl
Lg0KPiANCj4gSXMgdGhlcmUgYW55IHJlYXNvbiBmb3IgdGhpcz8gSWYgbm90IGNhbiB5b3UgZml4
IGl0Pw0KDQpUaGlzIHBhdGNoIHNlcmllcyBpcyBOT1QgcmVsYXRlZCB0byAnYXNzaWduZWQtY2xv
Y2snIG9yICdhc3NpZ25lZC1jbG9jay1yYXRlcycNCnByb3BlcnR5LCBpdCBpcyBqdXN0IGZvciBj
b3JyZWN0aW5nIGNsb2NrIHNvdXJjZSBhY2NvcmRpbmcgdG8gcmVmZXJlbmNlIG1hbnVhbCwNCnRo
ZSAnaXBnJyBjbG9jayBpcyBmcm9tIHN5c3RlbSdzIElQR19ST09UIGNsb2NrIGFjY29yZGluZyB0
byByZWZlcmVuY2UgbWFudWFsIENDTQ0KY2hhcHRlciwgdXNpbmcgRFVNTVkgY2xvY2sgaXMgTk9U
IGEgZ29vZCBvcHRpb24sIHRoZSAnaXBnJyBjbG9jayBpcyBzdXBwb3NlZA0KdG8gYmUgdGhlIGNs
b2NrIGZvciBhY2Nlc3NpbmcgcmVnaXN0ZXIsIGFuZCBpdCBzaG91bGQgTk9UIGJlIERVTU1ZIGlm
IHdlIGtub3cNCndoYXQgZXhhY3RseSB0aGUgY2xvY2sgc291cmNlIGlzIHVzZWQuDQoNClRoYW5r
cywNCkFuc29uDQoNCg0KDQo=
