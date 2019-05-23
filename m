Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CA9C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FF5217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YizduH/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfEWJxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:53:46 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:6257
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729797AbfEWJxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/gJyh9U9QUhiBGH17yaDRDpDoZi1M9kFk9wSCZZuTs=;
 b=YizduH/4e0ucsOoc4AmBS7YVyq/VewABmlXTOQOaW7lvl5pXe8IbNrgnMQC+rTiTQ6BxiDKK7+X20Joct+ikRSmmVQG27Ftcn1VoVIEDYeZ4BCMQZWYo6SRvkR0yKV/pQgw1B6VRiP9VVywIDT4fWr3u4nkjIZ5CbZmLLHj8bnA=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6509.eurprd04.prod.outlook.com (20.179.233.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 23 May 2019 09:53:42 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30%7]) with mapi id 15.20.1922.016; Thu, 23 May 2019
 09:53:42 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Thread-Topic: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Thread-Index: AdURTPrTY9TUCA67Tpmftem6u8zciw==
Date:   Thu, 23 May 2019 09:53:42 +0000
Message-ID: <VE1PR04MB647934199C3AA60759BED888E3010@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05ec2f23-0094-4fbb-840e-08d6df648a4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6509;
x-ms-traffictypediagnostic: VE1PR04MB6509:
x-microsoft-antispam-prvs: <VE1PR04MB6509F50EB45686EE7F2ABB86E3010@VE1PR04MB6509.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(33656002)(8676002)(81156014)(68736007)(14454004)(256004)(52536014)(6116002)(3846002)(1411001)(6916009)(54906003)(6436002)(316002)(99286004)(53936002)(81166006)(2906002)(7736002)(66476007)(229853002)(6506007)(8936002)(478600001)(66556008)(7696005)(6246003)(66446008)(64756008)(305945005)(55016002)(102836004)(86362001)(186003)(9686003)(4326008)(76116006)(66946007)(5660300002)(25786009)(73956011)(486006)(71200400001)(71190400001)(4744005)(74316002)(26005)(476003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6509;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dFFutxu6B3E6s1FFu5vXEndpXoLGmV5tfMInI7BwDXUIizLJBNKnfMirImG2Q0qUIJ6VSJRyNdGEp/5noyhhgcjjS7OUeWiTvvyLk2ULRmX3eZQ5wmSfRvBTDmVkDn4DJe1PRxYonHeMBiIG4EZM62s1TrcOFgjXHI280PA830fNnx9KUwLhbBC/LYKeKuNiu8pFMyfdQaK71htZZySxMahIg97F5YQ9/Vtz8aA+D7c4KUSzI4LvviVUmjcXxHg7/c71T0F+fK+pEFr5XaDOoBMXUocsBRyBUK5l25dqSRC7+m22K1lw8aoPQOaWzgZim/zYI4VRyq5qF9mPgIaHxn6HECMTV8K7RM4qVy/vmz2881f/Rca7TAwTJI3yjXTOQEvWnL67MfJiq1dwSl/gP1+DwLifL6k2BLpkPi7z5DA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ec2f23-0094-4fbb-840e-08d6df648a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 09:53:42.8529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> > +     /*
> > +      * Add fifo reset here, because the regcache_sync will
> > +      * write one more data to ETDR.
> > +      * Which will cause channel shift.
>=20
> Sounds like a bug to me...should fix it first by marking the data registe=
rs as
> volatile.
>=20

The ETDR is a writable register, it is not volatile. Even we change it to
Volatile, I don't think we can't avoid this issue. for the regcache_sync
Just to write this register, it is correct behavior.

Best regards
Wang shengjiu
