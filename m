Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FADECA9ECE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 01:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0B820578
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 01:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GBhMt7P/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfKAB2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 21:28:54 -0400
Received: from mail-eopbgr10072.outbound.protection.outlook.com ([40.107.1.72]:55597
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfKAB2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 21:28:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMLEun5p4j8UHIHAjXk8YTaxYKD7iBjqpjhSf/L+c7766eSC56lNQsj9uFKmbKDVDd+MoRHjhkaBi267GJlsAkIb/z9z4kscPL7GPOoVFJcHNoofeLZJIxVXpkInOcxh+8gx+ZOYofNnH3iQdoCf04PIa9dyYtngo0tLLGhLZWvedCylIG51acNA+pF0bHOxW1jmVJxDc64mfit4W1HZB2GxiqzudiNnnjvH/1LJKY5EzLydrrhH8eRxuNo+bRCBjuyD5YLBvAyUoYUg65AebgVJhiy97ZrjsvE5JYAA/QxpCK+d2ibiUNMh8r4xez1toImgNd71B8HfgoFORFxoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQdnQryhdARFRuiQ0XdPCuzA+eg9z5CcPDK9bySW0Ps=;
 b=I+MA+1wDKZ2vpJ/42+NNajX/Jn3S4mq34TMmknVfzb37Xobjn76mH9ESOf5BfDvvG0w4YkMnLLr9/NR29szxntH+awfxAaCwlD+wFQGPOWhB+tDRFyTdSEcukCLBZkDPOcoS7nOwObY0ybDJzlMBWJeVmjgg4ypM49ur4MBtUHzBpka+5a5JdY4p3h0v8bDj401tf9xLEOgT0SMr/F74Ofiyhh6uIQRI1noQpNejrYDIYdZRf7oh7v6MamXJzRZwewrKf+bs3JaJa/+Eio6zfe148cPm5ico9oqw7PABij3yKthPsHubxa6e2Fm6alotwAaH/otqbhu3cCKmoNx8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQdnQryhdARFRuiQ0XdPCuzA+eg9z5CcPDK9bySW0Ps=;
 b=GBhMt7P/qK7+PH7WK8Kt1oEYl5kJshXOYy+BHDFLI5m9WJVlTC55gTRL8AMXgrSE5gSIlqyfZmDm75HSbnJ/f0Yh+QZaE4Cvn/wUqh9AOETTOA8HTCE4pWRzm9ZdC5w1VBzXyJfXTOaYBObiocAIGI4XHBqfiwUjkGogk2a7H0U=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6148.eurprd04.prod.outlook.com (20.179.33.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 01:28:49 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 01:28:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: RE: [PATCH 2/2] clk: imx: imx7d: remove clk_set_parent
Thread-Topic: [PATCH 2/2] clk: imx: imx7d: remove clk_set_parent
Thread-Index: AQHVj9I92AhYNbamKEyejI7asTmq+qd0p9sAgADfddA=
Date:   Fri, 1 Nov 2019 01:28:49 +0000
Message-ID: <AM0PR04MB44812B6B5607B58EE0A7F9B488620@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1572515888-3385-1-git-send-email-peng.fan@nxp.com>
 <1572515888-3385-3-git-send-email-peng.fan@nxp.com>
 <CAOMZO5DWphRs_ZdDiNPLo0MPo45vBTEojWhYnZyWYF6+t12jxw@mail.gmail.com>
In-Reply-To: <CAOMZO5DWphRs_ZdDiNPLo0MPo45vBTEojWhYnZyWYF6+t12jxw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f04b4fa-8866-4256-bc66-08d75e6ad8ef
x-ms-traffictypediagnostic: AM0PR04MB6148:|AM0PR04MB6148:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6148F05DDDDDB2A5C99C1E0F88620@AM0PR04MB6148.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(3846002)(14454004)(8936002)(81166006)(229853002)(8676002)(476003)(81156014)(7696005)(478600001)(102836004)(86362001)(55016002)(66066001)(6116002)(26005)(6246003)(99286004)(186003)(52536014)(6916009)(66946007)(66476007)(76176011)(5660300002)(76116006)(305945005)(33656002)(316002)(66446008)(66556008)(74316002)(6436002)(4744005)(1411001)(256004)(7736002)(64756008)(53546011)(2906002)(486006)(44832011)(71190400001)(11346002)(446003)(9686003)(6506007)(54906003)(25786009)(4326008)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6148;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: soogxtAlq0PDd0GjVyIa3av7WJtx3s10BrKRPieHiHWwtuvemvWsYZDUA4WS+repZ1J/ThKvDBnzWDPtb1opc5DdeoOfxmNw3ZP0AygqW0yFeRcMQxjKUASs4NJXzbWThcIkdCTL92rbwaK6jCa8ywLPWI4a/mgoaM4ZTBgP9gFK+r15dW6mtq08pn8cy6uBjjH1jomZ6f1DrFoeZEFvvA9UWP8cP8BD8BFAnbCmyF1AUX0OLx4xMRk/nj9V+r+smsMysL0tRZJzTZWpbh9UATd+P2Fi6viKg0i8Tb7b7oWiXjM6VU7G0X4lu87KRpg5kXRPGEDz4QFHmSURFgtbn3TyPSRImJ6DNxt2B/g4KJ4lhq0fepAXmHtJAT2Aobt6RlC5WfsSQ7WgpJhngR2qm8sFT++67cRmflvZ7WJb4w6P4501KTKwVmQVDuWL8GQw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f04b4fa-8866-4256-bc66-08d75e6ad8ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 01:28:49.4199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39w4zdAQFNW2xrY8F8tGNbA0cH9jkjt14+OjOD8igs3qs1AS0tHaUPEeExZ2eN29TIbftzP9ebc8we1tZz0/Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gY2xrOiBpbXg6IGlteDdkOiByZW1vdmUgY2xrX3Nl
dF9wYXJlbnQNCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBPbiBUaHUsIE9jdCAzMSwgMjAxOSBhdCA3
OjAyIEFNIFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206
IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gU2luY2UgdGhlIHNldCBwYXJl
bnQgY291bGQgYmUgZG9uZSBieSBhc3NpZ25lZC1jbG9jay1wYXJlbnRzIGluIGR0cywNCj4gPiBz
byBubyBuZWVkIGNsa19zZXRfcGFyZW50IGluIGRyaXZlci4NCj4gDQo+IEl0IGxvb2tzIGxpa2Ug
dGhpcyB3aWxsIGNhdXNlIGJyZWFrYWdlIGlmIHNvbWVvbmUgaXMgdXNpbmcgYW4gb2xkIGR0Yiwg
cmlnaHQ/DQoNClllcy4NCg0KPiANCj4gV2UgdHJ5IG5vdCB0byBicmVhayBleGlzdGluZyBkdGJz
Lg0KDQpvay4gVGhlbiB0aGVyZSB3aWxsIGJlIGxvdHMgY29kZSBpbiB0cmVlIGZvciBjb21wYXRp
YmlsaXR5Lg0KDQpUaGFua3MsDQpQZW5nLg0K
