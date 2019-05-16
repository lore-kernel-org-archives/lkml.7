Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13705C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66FA2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fDZp+pxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfEPOQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:16:24 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:64406
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726790AbfEPOQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrbIqiFp1FNdikz0/28kQFOCtURf9dvEzgL5XEPlD1A=;
 b=fDZp+pxZWtXW2v25kq/MkKWyQgHn1tvKE5SMsxweBONHiKBl/q6FsfMK2GNufbUj7QJvTRY3+GdWyRbeF+cJQ0Wf5SHAv2RNiWee5/sblPoHxEkxBwPQcRKgXPqfX35D7ut7z7DaNqqJll+VhoR3bJm0KQMcZaL+SELsk+hw2lM=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3568.eurprd04.prod.outlook.com (52.134.4.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 14:16:20 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::888f:9ea:6f65:508f]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::888f:9ea:6f65:508f%6]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 14:16:20 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Julia.Lawall@lip6.fr" <Julia.Lawall@lip6.fr>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "viorel.suman@gmail.com" <viorel.suman@gmail.com>
Subject: Re: [PATCH] ASoC: AK4458: add regulator for ak4458
Thread-Topic: [PATCH] ASoC: AK4458: add regulator for ak4458
Thread-Index: AQHVC+dix6gnGF9HoUCg65Wy4dJcvqZtzA2A
Date:   Thu, 16 May 2019 14:16:20 +0000
Message-ID: <3bfeb07f8faad6f434da59571150639f4bfb52e5.camel@nxp.com>
References: <1558011640-7864-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1558011640-7864-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a6f4962-9293-4ea6-ec14-08d6da09118c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3568;
x-ms-traffictypediagnostic: VI1PR0402MB3568:
x-microsoft-antispam-prvs: <VI1PR0402MB3568C70CC1DC86CCB4907028F90A0@VI1PR0402MB3568.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(2201001)(86362001)(7736002)(186003)(66476007)(66556008)(64756008)(81156014)(229853002)(81166006)(68736007)(14454004)(73956011)(6486002)(66946007)(6246003)(71200400001)(71190400001)(305945005)(8676002)(2906002)(36756003)(76116006)(66446008)(118296001)(8936002)(54906003)(110136005)(486006)(256004)(3846002)(6116002)(2501003)(6436002)(102836004)(2616005)(316002)(14444005)(44832011)(478600001)(5660300002)(476003)(6512007)(11346002)(66066001)(99286004)(76176011)(6506007)(446003)(25786009)(26005)(4326008)(558084003)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3568;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HWVHiq0uNgB6UBk5pA6czpcvFZUsqC6bZtJlIGS0XV8FhBGv9+UQCHjvRcOJArEgJ9OAPHqB7qxtYO3PX1dAdzUilLH8w53zN9Eb7+Sc2gnKELQtzqY4EyI6fxwnu+mLdyvs0qKZQ43JXtVoCIo402+A0vzCEJn9+EeOIcXUcSXSjfDIooxJ045qlMOdKjeeHxjRlaMbms4iTN4OV7DZLSvdiyr7xqNytGL13+sRNKg1Bi9MRjD3G8PSj5Yzl2PD1RT64BTLDpR12UslHf2Yt82uy97Lw698It42EvL3ZV1m27z4cthQZ+hH6hHO3lJs/t7FSAR/oRAZfJE/mnyfISaskVNvUuDsf+k41G2kZfNf3Ls3DPByl+yU1UV72xPKZf3BGIOpTjTnDG7CHRCq6QHcMFmSpVyH5YGDsSZN6F4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <387C47A069F5BB4EA42CFCF5B3C3D313@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6f4962-9293-4ea6-ec14-08d6da09118c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 14:16:20.2903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3568
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA1LTE2IGF0IDEzOjAwICswMDAwLCBWaW9yZWwgU3VtYW4gd3JvdGU6DQo+
IEZyb206IFNoZW5naml1IFdhbmcgPHNoZW5naml1LndhbmdAbnhwLmNvbT4NCj4gDQo+IEFkZCBy
ZWd1bGF0b3IgZm9yIGFrNDQ1OC4NCj4gDQpIaSBWaW9yZWwsDQoNCldoaWxlIGF0IGl0IHBsZWFz
ZSBkaXNhYmxlL2VuYWJsZSB0aGUgcmVndWxhdG9yIGluIHN1c3BlbmQvcmVzdW1lLg0KDQp0aGFu
a3MsDQpEYW5pZWwuDQo=
