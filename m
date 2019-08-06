Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD8EC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C8420B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R0hKzPZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbfHFJKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:10:00 -0400
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:57571
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728845AbfHFJKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:10:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtBWGoHqXmcTIIKJYpXwLfVgjiNp+5xfG7io2p0o7WKfvECe8/6rNNEhekuzef6RcCCg1e+IBpQz71psz0Vbh/cdQDaWJ0RIrLrGQLRU8zqFvMXQvkkde6EvvY40d/EI9aqG+ROf3rxhiFlv/Ksp3WX2Szp+BF0MgggnywMkIRIqZJG+S05vlrWwljDEn6DE+153hPibfvz3kmgwfTqVkZC1l0t6J8zX2c4qawkgrRA9X3NHasKH2LfZF8dEjqnSoWpohBummhncyqVwxcSCedaW2gwJCHKQxka/GpGN+UOeVq8db6ud4RdiNGrzhBbVcWfUtQJmhv/3m49r9gAujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nKftMWjY934pOzqU3H14jfywtR37BlCJHdjFEIKxI4=;
 b=JhXefSe80oDgtLgxudEYp9mk2jm57lsG2m76mXK1hcllslJ5cZNKpgWqdezCcj/hP60VSDGtE9YJ2IrtcOkEpQAmAtOsMMMWmc1DoFwLyD/0NR8TTxUsKmfp1UEq8wGmIat4CbkJBYl70S6Z2diSvNU832yGDxGfQDY86poPzRSzGdJEX1FlUGXzDhQazmogOo5bBvpuQFQA7xcWa69bkU0beaEhbHUYGymQLd8tA9zyYBBw7h0dYgZZrlNh1nw9EOAV1quOIDwBIbKKQ/i+BXMX12udFMx7C3ow1Y/fjQngGMRk01g8laZZ5QNoqJrgOJ6F+M/cByitzlrKXSLSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nKftMWjY934pOzqU3H14jfywtR37BlCJHdjFEIKxI4=;
 b=R0hKzPZGzcKWMX33DMSL5+eK8JAHihjdq2Gjh7aJ2gCfzHHS0ealDN+OS/Vd7H8NfFjplgzDEfbHiSgoe8tS0ncIUBKKZdGBAL0lV/wBKmMbvbVWMOTWGgfMeInV3B+q78p/qbJtzeM3wZnhJDdlcVl7+cTi6qSPRljhRaps554=
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com (52.133.13.160) by
 VI1PR04MB7103.eurprd04.prod.outlook.com (10.186.156.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Tue, 6 Aug 2019 09:09:54 +0000
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::c85e:7409:9270:3c3c]) by VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::c85e:7409:9270:3c3c%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 09:09:53 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fancy Fang <chen.fang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>, Abel Vesa <abel.vesa@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] clk: imx8mm: Unregister clks when of_clk_add_provider
 failed
Thread-Topic: [PATCH 1/2] clk: imx8mm: Unregister clks when
 of_clk_add_provider failed
Thread-Index: AQHVTCQEIiAvfTsLQk6nSaEaD5dOEabt1SEA
Date:   Tue, 6 Aug 2019 09:09:53 +0000
Message-ID: <16eb2412986ec69d8fd99a63daa98d174ea6d499.camel@nxp.com>
References: <20190806064614.20294-1-Anson.Huang@nxp.com>
In-Reply-To: <20190806064614.20294-1-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 876d7c30-5301-4fa2-155e-08d71a4dd84c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB7103;
x-ms-traffictypediagnostic: VI1PR04MB7103:
x-microsoft-antispam-prvs: <VI1PR04MB710349B93265F6D737A3AE24F9D50@VI1PR04MB7103.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(189003)(199004)(66946007)(7416002)(316002)(2201001)(99286004)(50226002)(5660300002)(486006)(25786009)(2906002)(110136005)(229853002)(4326008)(3846002)(26005)(2616005)(6116002)(86362001)(68736007)(558084003)(6246003)(102836004)(76176011)(446003)(256004)(66066001)(6512007)(71200400001)(305945005)(8936002)(53936002)(71190400001)(118296001)(11346002)(81156014)(478600001)(8676002)(6436002)(6486002)(476003)(64756008)(6506007)(186003)(66446008)(44832011)(81166006)(76116006)(2501003)(14454004)(7736002)(66476007)(91956017)(66556008)(36756003)(99106002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7103;H:VI1PR04MB4094.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 97/+BX4A5dzYSMcuQULlH6c2pjW0Ri6EAG9LVrefqy30vMKVCwXqwD/9KVhgTZ1v++iGIZm8EOKC3laEuLNa84sv2qungvUxgh0ecZBOtDUYEccJMFOHhJPy7s2BjmCbNbuFuqApA8wJatQXXApkR6nX1n7Z+224cHatfc85FaYbQgggyMnTKNvoHsx3zIXvRdP2FZrP4LgcsW0P2nSWTutlM6qNtEOTl4HjNQM/FFBzXFOea0jB/oMHUk6EvIYTCU05jfk1j3kabyc1W9eJe15sHyG0H9fievkw7ERkcioi4IFqsjizzkeCwP+0YtlCtQGWZD9lTqcGbLe1VZbj6d9F+zcH79Hbbe0PiUF0mO8lHS//iuLArsxWLhVhpNqccLFyirmrkS+gsChcxF+xW8DkdgexD/yHxQoPCpHiDAM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13DE6831E267424BBCCC77BEA2122F31@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876d7c30-5301-4fa2-155e-08d71a4dd84c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 09:09:53.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daniel.baluta@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTA2IGF0IDE0OjQ2ICswODAwLCBBbnNvbi5IdWFuZ0BueHAuY29tIHdy
b3RlOg0KPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IFdo
ZW4gb2ZfY2xrX2FkZF9wcm92aWRlciBmYWlsZWQsIGFsbCBjbGtzIHNob3VsZCBiZSB1bnJlZ2lz
dGVyZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhw
LmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAu
Y29tPg0KDQpUaGFua3MgQW5zb24gZm9yIHRoZSBwYXRjaCENCg==
