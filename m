Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD217C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994B921920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CuIbraE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbfIIDk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 23:40:28 -0400
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:12275
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727530AbfIIDkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNo6KC12MNq/iAH3m1LKFGmy5Y+BRWYwghLQVQDuwxCMr64h0/a+V1bm+O2EQOhCDMKHtahClxz/1eO8b2IZLpC23rmEtj+kQoyXVK+LA8OwqQcdNltBXCpUkCAhFAIZML3fOyCxknvymUNCM37VPZZhA8eNFqxssj04fT1iLH1vG/pRTY85RnTaeJXymINEE7NpYwVVHkFubvqJrgZgxgk709TE3NW8jagyEEgYlBvfBcSw7Nj9jkxDKLcLjYrj+ROBh6VBjFNMqpdcHUk4gvxDNP44/G4nfcSs3C1K13TVR4infRQZ7JeEzbRiZeqotHq146Hsh8wO+whyC5Gh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQbl1Heq/eGArwLF///5xF1zd82P3lfPwYfhEG3DN6E=;
 b=axaqblLY0opytOrf1cr+PBU4t+LZbjAMjur650fQHM1oL4f/OPDCDaus8JRksVm0+HOc819l7yEJIB9dJl+j7oPdsdDBSQmiXD9Ni0lY6CIhleA30esECAb8w1IPuCDqw1UmgEiW4w6xwvRQIc/Cp2e/ZwxdO9OQLjisTTLJOV/HdTfUESbki/JSlgs2/VBqjDiQPV+lLLFQkVNyeXDs2EP0vAH6rla35LIIfz+dHgrpRtv+H7eGr3YRmg7dPCrARegG7vKbj42al/PkIMstOCDNib/MwbntM724sPDPDzo0gMaAHtG2MeIXUdtF2p4bHVlULylEMXCGj7G31hVI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQbl1Heq/eGArwLF///5xF1zd82P3lfPwYfhEG3DN6E=;
 b=CuIbraE67GrS4pMtigMJVcGvWCxTyNNCr/O39svTr81IQX9a1WwlQHdLGa9UdrHriy8SzZ/be87xu6jMpmUWbADtTwj4oE3PA02A9c5eHgF12KcDgL7uNoGbm72EbhFlKrD56y7cT/iNIWf8nURw5MUbUI2kZTHdp60SEl6ksuU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6020.eurprd04.prod.outlook.com (20.179.32.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.19; Mon, 9 Sep 2019 03:40:10 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 03:40:10 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: RE: [PATCH V2 1/4] clk: imx: pll14xx: avoid glitch when set rate
Thread-Topic: [PATCH V2 1/4] clk: imx: pll14xx: avoid glitch when set rate
Thread-Index: AQHVW/KK74JBQxFn0kSNJpxYwL3XVace9ziAgAPQ26A=
Date:   Mon, 9 Sep 2019 03:40:10 +0000
Message-ID: <AM0PR04MB4481BCB4A02FC868F5B442E288B70@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1566855676-11510-1-git-send-email-peng.fan@nxp.com>
 <20190906172145.CAD3C20838@mail.kernel.org>
In-Reply-To: <20190906172145.CAD3C20838@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aae4df6-1488-4233-a1fc-08d734d76a69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6020;
x-ms-traffictypediagnostic: AM0PR04MB6020:|AM0PR04MB6020:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB60207D6293B5117E158CFBEA88B70@AM0PR04MB6020.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(199004)(189003)(43544003)(7736002)(76116006)(186003)(26005)(54906003)(316002)(66446008)(52536014)(64756008)(76176011)(7696005)(9686003)(14444005)(446003)(55016002)(4326008)(11346002)(44832011)(3846002)(6116002)(66946007)(102836004)(110136005)(2201001)(25786009)(8676002)(2501003)(478600001)(14454004)(99286004)(66556008)(5660300002)(66476007)(86362001)(4744005)(71190400001)(6246003)(6506007)(2906002)(256004)(476003)(33656002)(486006)(53936002)(8936002)(229853002)(66066001)(81166006)(74316002)(6436002)(71200400001)(81156014)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6020;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uVfZZh3emXR9QSp3y46OlXKjRZa0LGA/Ycbh8+jxgX9Xv7aXAgk2wIZhGDNq4viygFK/pwXTstEERXL2bRZUyImsPVMj5WJKbeeYDvemNHWuq2wAhEnV0upAqL3zMkfxorz4Lr3jNwM0RcGvvjJQ9YAPp2lISS7594lsynAifqzyVMiXKzxvnS9ZosKxka7AsLD7vfvGD87Jq5/Ho5+B+z0l9f/sAwETQy9AiTHdtjEAjiRBZ3yW2ol95PVamJ4HdSBXT3QgRs1/28UPWWF/tplUeCGybqZuAaEbG9ocknA2+/88nhtZclWquC/sa2GYCMiFeug4nQ1fnrmqrtxVNFVmDPwTQO3GD9y03bfuNNNlem3bzg8hq5tWj1ApZbLN/TCiW6RqkJ6ZPh1PgPK7LaJ+Z00mqildwaLRDclworg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aae4df6-1488-4233-a1fc-08d734d76a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 03:40:10.2476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HgME3AwdcBBdUtdh1GCZMYdBKzJCxkpjkGNCjs7PkzS1S5Q7k3GQJ4wjNWcI4JxFAs/dUWZPODKlf0a7UCOwKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDEvNF0gY2xrOiBpbXg6IHBs
bDE0eHg6IGF2b2lkIGdsaXRjaCB3aGVuIHNldCByYXRlDQo+IA0KPiBRdW90aW5nIFBlbmcgRmFu
ICgyMDE5LTA4LTI2IDAyOjQyOjE0KQ0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiA+DQo+ID4gQWNjb3JkaW5nIHRvIFBMTDE0NDNYQSBhbmQgUExMMTQxNlggc3BlYywg
IldoZW4gQllQQVNTIGlzIDAgYW5kIFJFU0VUQg0KPiA+IGlzIGNoYW5nZWQgZnJvbSAwIHRvIDEs
IEZPVVQgc3RhcnRzIHRvIG91dHB1dCB1bnN0YWJsZSBjbG9jayB1bnRpbA0KPiA+IGxvY2sgdGlt
ZSBwYXNzZXMuIFBMTDE0MTZYL1BMTDE0NDNYQSBtYXkgZ2VuZXJhdGUgYSBnbGl0Y2ggYXQgRk9V
VC4iDQo+ID4NCj4gPiBTbyBzZXQgQllQQVNTIHdoZW4gUkVTRVRCIGlzIGNoYW5nZWQgZnJvbSAw
IHRvIDEgdG8gYXZvaWQgZ2xpdGNoLg0KPiA+IEluIHRoZSBlbmQgb2Ygc2V0IHJhdGUsIEJZUEFT
UyB3aWxsIGJlIGNsZWFyZWQuDQo+ID4NCj4gPiBXaGVuIHByZXBhcmUgY2xvY2ssIGFsc28gbmVl
ZCB0byB0YWtlIGNhcmUgdG8gYXZvaWQgZ2xpdGNoLiBTbyB3ZSBhbHNvDQo+ID4gZm9sbG93IFNw
ZWMgdG8gc2V0IEJZUEFTUyBiZWZvcmUgUkVTRVRCIGNoYW5nZWQgZnJvbSAwIHRvIDEuDQo+ID4g
QW5kIGFkZCBhIGNoZWNrIGlmIHRoZSBSRVNFVEIgaXMgYWxyZWFkeSAwLCBkaXJlY3RseSByZXR1
cm4gMDsNCj4gPg0KPiA+IEZpeGVzOiA4NjQ2ZDRkY2M3ZmIgKCJjbGs6IGlteDogQWRkIFBMTHMg
ZHJpdmVyIGZvciBpbXg4bW0gc29jIikNCj4gPiBSZXZpZXdlZC1ieTogTGVvbmFyZCBDcmVzdGV6
IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8
cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gDQo+IFBsZWFzZSBtYWtlIGNvdmVyIGxldHRl
cnMgZm9yIG11bHRpLXBhdGNoIHNlcmllcy4NCg0KSnVzdCBzZW50IG91dCB2MyB0byBpbmNsdWRl
IGNvdmVyLWxldHRlciwgbm8gb3RoZXIgY2hhbmdlcy4NCg0KVGhhbmtzLA0KUGVuZy4NCg0K
