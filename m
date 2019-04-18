Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B9AC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C532184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pOYusUng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387825AbfDRBTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 21:19:10 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:8031
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728268AbfDRBTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 21:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2YAdM0eycG+gl1h+3koYXaKVXykEKrNZXlF6Xc/Iyg=;
 b=pOYusUngOtklAcLBabbK3JPvERITSazbkaMCJR7B1MwOTB4BE8+IudmGW/MXE1V9qsDPJoNu8bphyJx6brkMZb6WUizeqQMQCA+u63BK+KscXVSOSyUaNxzq5mYPwoxcHED9gkRQbkWc531kzvTcvop2xO+19keUIHEDQ59Azyk=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB6285.eurprd04.prod.outlook.com (20.179.27.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 01:19:05 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1792.021; Thu, 18 Apr 2019
 01:19:05 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Igor Plyatov <plyatov@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Duan <fugang.duan@nxp.com>, Han Xu <han.xu@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: Issues with i.MX SPI DMA transfers
Thread-Topic: Issues with i.MX SPI DMA transfers
Thread-Index: AQHU5MQedyysM/Gs0UKoyWKgyiIok6YgnCuAgAADPICAACYCkIAAHYGAgAEpjtCABnMWgIAAEhKQgAqpimCADgHlUA==
Date:   Thu, 18 Apr 2019 01:19:05 +0000
Message-ID: <VI1PR04MB4543A5CA46FBB3ACC9F3B3E289260@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
 <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
 <VI1PR04MB454305A56372466A38E9F81989560@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <VI1PR04MB454302BAF353124ED13747DC892D0@VI1PR04MB4543.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB454302BAF353124ED13747DC892D0@VI1PR04MB4543.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36a0ace1-876e-4d2f-5dce-08d6c39bd989
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB6285;
x-ms-traffictypediagnostic: VI1PR04MB6285:
x-microsoft-antispam-prvs: <VI1PR04MB62856720DF34A0C8E5C1582A89260@VI1PR04MB6285.eurprd04.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(366004)(136003)(13464003)(199004)(189003)(81166006)(11346002)(8676002)(55016002)(7696005)(3846002)(6436002)(33656002)(68736007)(53936002)(97736004)(26005)(6116002)(25786009)(9686003)(2906002)(81156014)(4744005)(99286004)(6246003)(229853002)(478600001)(8936002)(486006)(76176011)(66066001)(74316002)(4326008)(7416002)(305945005)(7736002)(14454004)(446003)(110136005)(476003)(14444005)(186003)(54906003)(5660300002)(71200400001)(71190400001)(52536014)(316002)(102836004)(6506007)(86362001)(93886005)(5024004)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6285;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zcwewHvu50mgw5TrywMRHaXTXjVJ88Avi3b+cDByHafHjYgJ8e3+dyJWkp3SieKrjOzxkhi2KVAb1CyPrJF1Z7XdDKBi2vgVeHgTUsr1DdbfEtZ4pOWOu27Dd3qLeq40yjdM392L8xJbMhJIFhJuE1TYqaGa6Ytf9MaJh4L0oN24ve34hu3zc7FEQ9YqD9ey3X9d4MdgxQeAW6rKZRIVo21aFPnOEIL3bY1koI2UrlY41pAwRcS03tXmR4n5mKHOeWj+Q7WqmXEUV0QkddBSCfH741olXsJcIAb9EtcgYAvrmJ9UracbVQEttOCYwUhVUs9oGAq0JcAhutL3vCJxCKwLrBAQ9dJ3c6CzNJu8/vgGd0QUlGGRQ9NhYHrAQquHN+JrbwIYstPN/lSjGTuKZYMYLUJjECbSBG4rdxPyUKE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a0ace1-876e-4d2f-5dce-08d6c39bd989
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 01:19:05.5178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6285
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWdvciwNCglEaWQgeW91IG1lZXQgYW55IGlzc3VlIHdpdGggbXkgbGF0ZXN0IHBhdGNoPw0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYmluIEdvbmcNCj4gU2Vu
dDogQXByaWwgOSwgMjAxOSAxMToyNj4gDQo+IEhpIElnb3IsDQo+IAlQbGVhc2UgaGF2ZSBhIHRy
eSB3aXRoIHRoZSBhdHRhY2hlZCBwYXRjaGVzLCBhbmQgcmV2ZXJ0IDI1YWFhNzVkZjFlNiwNCj4g
YWQwZDkyZDdiYTZhICwgZGQ0YjQ4N2IzMmEzLCBkZjA3MTAxZTFjNGEgYmVmb3JlIGFwcGx5LiBC
ZXNpZGVzIFhDSCwgdHgNCj4gdGhyZXNoIHNob3VsZCBiZSBzZXQgdG8gMCAsIG5vdyBubyBmYWls
dXJlIGNhdWdodCBvbiBlY3NwaTUuDQo+IA0K
