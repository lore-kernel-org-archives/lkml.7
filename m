Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AE1C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C20A217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bitdefender.onmicrosoft.com header.i=@bitdefender.onmicrosoft.com header.b="auUyDOPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbfIXOIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:08:38 -0400
Received: from mail-eopbgr20129.outbound.protection.outlook.com ([40.107.2.129]:17793
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729868AbfIXOIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:08:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW74CMfgWynRkEqI1mC69SM5IzUwj8WGqb1AAL6S5zaX1fSPWobtSvBNQ0OwWEXLtyU6QWm99Ty25vV/DAv3ET8HC5vitWz4lzCjAblL60SEmK2B1zcihXl+2MLc3mo3bD/XGY8SMcOlED3TsUTyW8TkRqklBBJD6XG8FUIooz+2jXi/oxWQn878aI5EmlxqV8eDojGf6juB2tWgNzWw2LK7XYknrCeo9h7wIQBI6gJRDBvXP2rtojM2VhdYOvmjYMcF1FmqMCNGTgvRHU9DFaMJGpmwHMtRhj0MMwu7lNzbN993LQ4+76MD3HYjYQASemQ6l8veKHL1llauxftVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T18pz4q0XbMSLNLy2tp69tjYPqDuR+KAbcRCCE0vsyg=;
 b=LTv4PwcKuk6SzhAcyPWqbqtiC4XCcqvHu7fWAw4EdDbMHPNjiX7ZoWiYfza3aM3JdE8+c/X6SCzOTjzQb+CKpibW2FbVietecptZZQ97txGWX8sHjd8EZN52+aXxE2lAWmCbtLYs1ZkG81hdZXfFhIXCTOMUAILe8ofv4D5KO5AHS3EKrGa1OgcznB3cwnDqnnc6/vDv/w8WWGAdiIMfKyZWAlYHkKBdveDXrszW8xOsTndOSb9dwZkDHxQYjXg4jV8tmEM0DeTKPRpvG9JHEXuUcq4KZJxN6NDCA+MPeJ7Pcvh35KsnWkbXSacXPCWjgvdy1zHMcWvvcq4ekYzvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T18pz4q0XbMSLNLy2tp69tjYPqDuR+KAbcRCCE0vsyg=;
 b=auUyDOPBoRbBsNfIpGZ2XK6otZ/lCID5jZhCd465GDaeA3Rjt3cBeMefUZNXZSMNwsku+FbIvIZuey92Pu6tpPR6RXTQbj1nr4ooEKNmp/3qSy08W4tgad3oMaMYRYC+vKtmkqW4qMUKAAZtk7K80ryEvJeJoJdIdMNwzIRAHrY=
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com (20.177.121.157) by
 DB7PR02MB5351.eurprd02.prod.outlook.com (20.177.123.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Tue, 24 Sep 2019 14:08:34 +0000
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::a9d4:6e4d:dca:97a7]) by DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::a9d4:6e4d:dca:97a7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 14:08:33 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] slab, memcontrol: undefined reference to
 `memcg_kmem_get_cache'
Thread-Topic: [PATCH] slab, memcontrol: undefined reference to
 `memcg_kmem_get_cache'
Thread-Index: AdVytC6le4HJzZbiQp+aXja1W7jiOgAG/e8AAAORjVA=
Date:   Tue, 24 Sep 2019 14:08:33 +0000
Message-ID: <DB7PR02MB39799BF26E394AE30D710308BB840@DB7PR02MB3979.eurprd02.prod.outlook.com>
References: <DB7PR02MB397977A2959BFFA89AA67538BB840@DB7PR02MB3979.eurprd02.prod.outlook.com>
 <20190924120400.GN23050@dhcp22.suse.cz>
In-Reply-To: <20190924120400.GN23050@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mcirjaliu@bitdefender.com; 
x-originating-ip: [91.199.104.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cc45cb5-839b-4b18-9ebb-08d740f8af6e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB7PR02MB5351;
x-ms-traffictypediagnostic: DB7PR02MB5351:|DB7PR02MB5351:|DB7PR02MB5351:
x-microsoft-antispam-prvs: <DB7PR02MB5351439D71B21AE0B841F890BB840@DB7PR02MB5351.eurprd02.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(346002)(39860400002)(189003)(199004)(71190400001)(6116002)(9686003)(26005)(7736002)(6506007)(64756008)(11346002)(6246003)(81166006)(486006)(478600001)(14454004)(81156014)(8936002)(99286004)(66066001)(186003)(476003)(446003)(6916009)(54906003)(7696005)(102836004)(71200400001)(76176011)(8676002)(66946007)(229853002)(305945005)(74316002)(25786009)(33656002)(4326008)(86362001)(76116006)(66476007)(3846002)(316002)(55016002)(2906002)(66556008)(52536014)(66446008)(14444005)(5660300002)(256004)(6436002)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB5351;H:DB7PR02MB3979.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bitdefender.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XbMX2vo6bkpQ0Usyl0cBAq6KaLCL07i5LR0X3q9NzDSqEgctxgw5LkbYjWBaLLUuLJziKbfWZY+U06YJxhzYI+fHbjLLdDsHWgJNZp1fQvitXoU4gFpViAvJhaakkV5iOmomFFlvVasQf8Rj15MMVM7hYjg9//CLq7MLKsOUVvuxpo3cdZRm1A5cu9WbiHAZzV3Dltktp3nXGC7Xp0V/3IXCKBVoW8/AY8Ww7TxX51GGAZBiv5z5TQJYN9SM2ZZVOu6vcOQAihsryRC7M4/+VxtQJ1cU2cSztd5/sUvGtvKE5gmfHWy7ZVGO64tQ+MWDxuWLSSYsnbqw6hVooSckhGlGQHc98dzuJX1iRYFlyMcanizdzqwYAPEfr6vsD4vz8nm5UCxXQWP+fxHLP9h1dtZCoyj50I+tlpZT5dGcaHk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc45cb5-839b-4b18-9ebb-08d740f8af6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 14:08:33.4014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TUyxuYKqE5BPrVI+9bn5KVmeBaZrf6B1pk9H6Rc/wOnD7yE7POcnXwP1eMXVp9uig1EfIuFYVFcRNbivjQN0UyzIh2Xs5Cs8ALI4YFKjgoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5351
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue 24-09-19 08:46:48, Mircea CIRJALIU - MELIU wrote:
> > Having CONFIG_MEMCG turned off causes these issues:
> > 	mm/slub.o: In function `slab_pre_alloc_hook':
> > 	/home/mircea/build/mm/slab.h:425: undefined reference to
> `memcg_kmem_get_cache'
> > 	mm/slub.o: In function `slab_post_alloc_hook':
> > 	/home/mircea/build/mm/slab.h:444: undefined reference to
> `memcg_kmem_put_cache'
>=20
> You should be adding your Sign-off-by to every patch you post to the kern=
el
> mailing list (see Documentation/SubmittingPatches).
>=20
> It is also really important to mention which tree does this apply to and =
ideally
> also note which change has broken the code. In this particular case I hav=
e
> tried the current Linus tree (4c07e2ddab5b) and $ grep
> 'CONFIG_SLUB\|CONFIG_MEMCG' .config # CONFIG_MEMCG is not set
> CONFIG_SLUB_DEBUG=3Dy CONFIG_SLUB=3Dy CONFIG_SLUB_CPU_PARTIAL=3Dy
> # CONFIG_SLUB_DEBUG_ON is not set # CONFIG_SLUB_STATS is not set
>=20
> which means CONFIG_MEMCG_KMEM is not enabled as well. And the
> compilation succeeds. What is your config file?

The config file is not the problem (figured it out).
I am lowering the optimization level on certain files for debug purposes.
In my case: CFLAGS_slub.o +=3D -O1 -fno-inline

The code which causes the problem looks like this:
static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
						     gfp_t flags)
{
	...

	if (memcg_kmem_enabled() &&
	    ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
		return memcg_kmem_get_cache(s);

	...
}

Under normal circumstances memcg_kmem_enabled() returns false and the
statement is evaluated as unreachable and removed entirely.
It seems -O1 keeps the call to memcg_kmem_get_cache().

The change that introduced this is here:=20
	commit 452647784b2fccfdeeb976f6f842c6719fb2daac
	Author: Vladimir Davydov <vdavydov@virtuozzo.com>
	Date:   Tue Jul 26 15:24:21 2016 -0700
Although I had the same problem before with other header files.

