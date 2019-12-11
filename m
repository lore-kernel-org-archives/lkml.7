Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB21C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63FE2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YntiJRpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfLKC4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 21:56:17 -0500
Received: from mail-eopbgr150042.outbound.protection.outlook.com ([40.107.15.42]:30626
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727773AbfLKC4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:56:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKyptkDMC6kf14OlXhIWbyWl+NlOILrqnCEb9EgvFbLwGarFTZWkD8p4zMtp5NBH8YC6GPbG27+IZdLvMIXKItJBhr20+ZSkcAch8oEcbS/+CLfPKZcAt1AlTT1Ily96/M9OFLx7sU2VC4zobD2tOjj5HGRmLDQG57fRnbPt9dzNllQBcyeVT9HGryN8IY0S0vcka2uSdjjp8aMwMhe0sL97rDk/zWQa7O8kp1bfpuqBa67fBKhAOKdZepBX+3B7gq1HAVUCUY+qWz23/vudt7QpEMCTB3bIq6rn+lwQvMMj/DcmEQE4BVhCPoYANbPrOk0+mtFRCV13UMC2BccNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZi1/tjHPZERF/sLRbseIK60zddEkMWCBQnRaqr2kJM=;
 b=VucAaQTJvzmo1nGzWhfr09pKwKg5PhGSDpdawhAvXfUkYYQcHc3O6Q1Kiyi0Eem7GqUykneoy3WdfH2j5lbZrSfceYK+F3ShhOE0Dvk9VTvbynh5xGRGIK78jRwJp8YqqQv+SaisNRM5swjxp49W2DonHuttwMNXUG6WjUQPsBXdXxbLTBHq2lg+rE+L5YIC+qZhdkvll9MgIQisk12fld1mDbhpXzaeDrHvOcIikdAb4CxGEjRAK0QaBtfwnJEK2CxNQYfR7QkMXv+OK+CYL+vThp6saQMvwirRKln0AaOB8/3xufrDa4HVTslxXEGxcqAq87CGIPQG3i/8cxiMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZi1/tjHPZERF/sLRbseIK60zddEkMWCBQnRaqr2kJM=;
 b=YntiJRpM8aIqsqcdLbJUJQG6JJ9tsZwNQ11tK6DzRvLKClN5VrpwB20g79fW94TMaNA0uNZMZBHXqJbBzjL3mlufdPa4AjRbVkwkOXrEEpg2swQEqs1pPkGxm+8aIfH6ilqR6Fksg9pL4SHdz0mW4+i/Z4JXWEQACmM+IBUCS4E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3884.eurprd04.prod.outlook.com (52.134.71.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Wed, 11 Dec 2019 02:56:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1%6]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 02:56:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: imx: Enable ARM_ERRATA_814220 for i.MX6UL and i.MX7D
Thread-Topic: [PATCH] ARM: imx: Enable ARM_ERRATA_814220 for i.MX6UL and
 i.MX7D
Thread-Index: AQHVqaz9uTC5Ekq7lkSM85gAnNButKe0RmUAgAADO9A=
Date:   Wed, 11 Dec 2019 02:56:10 +0000
Message-ID: <DB3PR0402MB3916FD7E76C669D620D91842F55A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1575358720-27624-1-git-send-email-Anson.Huang@nxp.com>
 <20191211024413.GF15858@dragon>
In-Reply-To: <20191211024413.GF15858@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40cdaad7-0621-401d-d88a-08d77de5ad75
x-ms-traffictypediagnostic: DB3PR0402MB3884:|DB3PR0402MB3884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3884207A11407CDE25599F44F55A0@DB3PR0402MB3884.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(9686003)(478600001)(54906003)(55016002)(26005)(7696005)(8936002)(4326008)(66476007)(316002)(86362001)(8676002)(4744005)(6916009)(33656002)(6506007)(186003)(44832011)(66946007)(76116006)(64756008)(66556008)(2906002)(66446008)(81156014)(81166006)(71200400001)(5660300002)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3884;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yby8cyqCd/RRdnBcZopFYNSTGx6spa9APmiQMgIqdUrCMMOnNU6e7faJLX1MlxfkT2O3L3NSrFByBxULjXjlsG46tYyxlnQjGlZWQde7zKowBfd0OCNeDDk6QsnVtGG9BKQFCU6YwH4/Es1OOpNf7t3+pmNnEpm8DRJXhY2clagiQFv2XbFj1qjauNIDCNgn54ZF+Ms7N8SDMKmphRB2hScn34ysz7TgOd2MIBsEmilc8fFcujCcVAk2iQuesARFS2YgYzsSqj7ukPdGKYbxh/4dPfNNt8Q9/lI8gXBELdUrO2TY0qGxB/ryzvzwm5RdVZEV5FpMwglRbnki4HcvEHiDIBH4hhQTu5iG8k2HCFp9yQqZVtTwGhGy8719GGMyEye6xXkbGBatUcINhksViUOuApUhcw81GbXYuWZR4TlqtyMp4gLvXuuKQcXNDfRT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cdaad7-0621-401d-d88a-08d77de5ad75
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 02:56:10.5729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuDEkjvCA7l88w5ZTmImo/GxwIzFB78azd2L2F6wGbUZT37WuD78wDcv15uf7dQ+dA8OZuGXLxkJwpdMqP8Pig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gQVJNOiBpbXg6IEVuYWJsZSBBUk1fRVJSQVRBXzgx
NDIyMCBmb3IgaS5NWDZVTA0KPiBhbmQgaS5NWDdEDQo+IA0KPiBPbiBUdWUsIERlYyAwMywgMjAx
OSBhdCAwMzozODo0MFBNICswODAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBpLk1YNlVMIGFu
ZCBpLk1YN0QgaGF2ZSBDb3J0ZXgtQTcgaW5zaWRlLCBuZWVkIHRvIGVuYWJsZQ0KPiA+IEFSTV9F
UlJBVEFfODE0MjIwIGZvciBwcm9wZXIgd29ya2Fyb3VuZC4NCj4gDQo+IENhbiB3ZSBicmllZmx5
IGRlc2NyaWJlIHRoZSBBUk1fRVJSQVRBXzgxNDIyMCBpbiB0aGUgY29tbWl0IGxvZz8NCg0KRG9u
ZSBpbiBWMi4NCg0KVGhhbmtzLA0KQW5zb24NCg==
