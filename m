Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE01C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72A1206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UjulIg6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfEQDLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 23:11:46 -0400
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:13132
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726447AbfEQDLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 23:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+aTwbcH/7LQy4wjWT4xtFInwSpCaIAUDkIJuoZqjGY=;
 b=UjulIg6SSCYGIuPtbYX2QfCQbCAf1cms7WdnGeZkj3Xkj76o/OQu77EzFg83zP8YRQxkCDy3uulrCQT+ZrLB3ZPcW9XSGTlc8MS4hPmTrgVlAPpr75XbQed56y+gvaLvWIM+DJVwX1w4W28HAeRkTBGG6kbjSZ14r2rn9EKIaXs=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6558.eurprd04.prod.outlook.com (20.179.234.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 03:11:42 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30%7]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 03:11:42 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [alsa-devel] [PATCH] ASoC: cs42xx8: Add regcache mask dirty
Thread-Topic: [alsa-devel] [PATCH] ASoC: cs42xx8: Add regcache mask dirty
Thread-Index: AdUMXjs1CTFSY/xiTRW1khdlbZkYxw==
Date:   Fri, 17 May 2019 03:11:42 +0000
Message-ID: <VE1PR04MB6479CA711EF5D796EEA9DA55E30B0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea341b6d-ef5e-43f9-4cbc-08d6da7562c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6558;
x-ms-traffictypediagnostic: VE1PR04MB6558:
x-microsoft-antispam-prvs: <VE1PR04MB655878C7D6A516DF55AB34F1E30B0@VE1PR04MB6558.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:480;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(366004)(376002)(199004)(189003)(66556008)(66476007)(66946007)(64756008)(52536014)(102836004)(186003)(74316002)(7696005)(7736002)(99286004)(71200400001)(71190400001)(6506007)(6246003)(33656002)(73956011)(14444005)(256004)(53936002)(14454004)(66446008)(26005)(25786009)(110136005)(5660300002)(305945005)(2501003)(9686003)(2201001)(6116002)(86362001)(8676002)(3846002)(6436002)(66066001)(81156014)(558084003)(81166006)(55016002)(8936002)(229853002)(76116006)(316002)(478600001)(4326008)(68736007)(486006)(476003)(2906002)(14143004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6558;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qd+Qh5+QKjWySugq5jcnqyP3sv4iETJOhqB6nbmtt4F6/hyKgtyuZKjOrrklquejVEsc7Za7t5C92on0HVbcbDkTasC6vK2hWXccMHxn9Gt9EmIhi1QjhtKOhlFXmkkXtIj41PBSLW9qyJihp8ZnyeePSgLF5/wGatUAOO8G+KwEGdcL0iEgR6lM//S/4LWa2E1B/d1XKUH2Hgl8bx0hQ7bNXl/BXh0ZA1JqfA+7gKE7de2kih6dwxgNsvoa2nYooDVzJq6jSDPfrXGtBGH326yLTd0p1jfyBN5kPhG6dGbVWnWkzAQr9FwKuf0Bcgs8z+rbQ6TAUTysuE+hHoov5RtqzkHCJpn0UX0tvm5+/ddaLsxOEoQTOVu6nBkBvGbHx1ZVcJUIzFLLJBKrAHB8/VpgdWtXpXZ2ic2dGw2XNw8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea341b6d-ef5e-43f9-4cbc-08d6da7562c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 03:11:42.2267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6558
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Add regcache_mark_dirty before regcache_sync for power of codec may be
> lost at suspend, then all the register need to be reconfigured.
>=20
> Fixes: 0c516b4ff85c ("ASoC: cs42xx8: Add codec driver support for
> CS42448/CS42888")

The Fixes tag is split, will send v2.

Best regards
Wang shengjiu
