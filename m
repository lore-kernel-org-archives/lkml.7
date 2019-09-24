Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413E5C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F403D214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bitdefender.onmicrosoft.com header.i=@bitdefender.onmicrosoft.com header.b="O8+M9x9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504033AbfIXIqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 04:46:52 -0400
Received: from mail-eopbgr50117.outbound.protection.outlook.com ([40.107.5.117]:14465
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439012AbfIXIqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:46:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IulhGnfyr45WHM+/olBE8LpJF3wNBuGL75pzqmH9QxEH6r3Dl3BXvTXgWP9RYK2nOOmEXs3RjbSVVreCPapLv/sgu5bOerWivpG2wz74uTCuR2dd8noRqJwRLLR7sGqixMG9A8p6QKlqMh9da2fyVBn6LavmMZLIVHXOZH+0/KFoC1qA4rdhTJ1BnV7RTevLzSxVKv5Z0VI3HYLC8/Ac2bqC6SP+/gOLGK4IQ52YGiKAF7kBajlC6fh+xrS8/m00/v3nj1HuZaphUGn/mfcDywwNVyhFk4wCjXZWytSvaIZ37uJa1gS8bIjV4BccGgVWpuc/oA8a+8lKTlPi1boBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVEwOl/ZaKhhGBY3tC//p8IZXbd1StjJjCkVY4nmwj0=;
 b=aq1IZ7xrX1PYaOM1P+/BSzss+l/Cmx04T1kWf+VH+URHBjY+CL71GaEgwBghU8a7Iq6NvkhjNRS3m8+uv9L4UPxmh0HiT1FS+AAtWut2fbfKs3YGHf08c4o/nQp9eME8CG8O4we+2zO4s6+Eu5U9drK9xkz4QcKjemg8VqRdEsCfPCk1JLsoi17Ag8VBAokLJZZRWtsnYhFY/FFr5pSTWMor0tb0izo10ae7ErjJ4XZXWmFb7mMuK0bfl83a9LCTEzxpdfBj/k+5imj40wg+UdB9ow5kyH5XcXMCPZimYwEZ/0NN40PkgDvQi354yycIiYy9Ls8lKwQ9BwAx3VUYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVEwOl/ZaKhhGBY3tC//p8IZXbd1StjJjCkVY4nmwj0=;
 b=O8+M9x9/KlQVzjk6LWgUbh0B178NPFPohPl8c/Rwd3d3t3bMcys8bPix1RY39/H5kW2FGPG9VVwib+aLVRf4LqV/ybIkqdQ6ZObfl++HhgvA6gNmqgUFUAjbMx+BaF8x1PBQQXhjsMYvrnzeZIgj4VROygGMrXVqA+4g36Ar7fo=
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com (20.177.121.157) by
 DB7PR02MB3833.eurprd02.prod.outlook.com (52.134.102.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Tue, 24 Sep 2019 08:46:48 +0000
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::a9d4:6e4d:dca:97a7]) by DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::a9d4:6e4d:dca:97a7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 08:46:48 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] slab, memcontrol: undefined reference to
 `memcg_kmem_get_cache'
Thread-Topic: [PATCH] slab, memcontrol: undefined reference to
 `memcg_kmem_get_cache'
Thread-Index: AdVytC6le4HJzZbiQp+aXja1W7jiOg==
Date:   Tue, 24 Sep 2019 08:46:48 +0000
Message-ID: <DB7PR02MB397977A2959BFFA89AA67538BB840@DB7PR02MB3979.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mcirjaliu@bitdefender.com; 
x-originating-ip: [91.199.104.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 413350d2-49f6-4470-2cbc-08d740cbbc7a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR02MB3833;
x-ms-traffictypediagnostic: DB7PR02MB3833:|DB7PR02MB3833:|DB7PR02MB3833:
x-microsoft-antispam-prvs: <DB7PR02MB3833E33FCBF4D67178E157C6BB840@DB7PR02MB3833.eurprd02.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(376002)(346002)(199004)(189003)(8936002)(25786009)(7736002)(102836004)(3846002)(66946007)(86362001)(305945005)(486006)(71200400001)(476003)(71190400001)(110136005)(14454004)(6116002)(26005)(5660300002)(186003)(316002)(76116006)(66556008)(66066001)(55016002)(33656002)(66476007)(64756008)(6436002)(66446008)(81166006)(81156014)(52536014)(8676002)(256004)(2501003)(6506007)(14444005)(478600001)(7696005)(74316002)(4326008)(2906002)(99286004)(9686003)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB3833;H:DB7PR02MB3979.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bitdefender.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rVnfMCgU0t4ZTGC8V5/SskdYTtWzo60ibO+qski71MFjOQ0npWR4bRFpkSl9RM7DecNaM6XWXlBzIraqGGjm30BiTJPIw1nDFbnsEFhctH/PIhdFFDtvxp4akcG8YVI+jvUi1GWEpxxnUVd4lT2za41MSlyoVHTXSoQfxoS93oN+fnoxrr/P7XisvjZSc835fDMKuNxgxtR20JhTW40fAubUddgOrLB+zvbuRT+wt3su19Zq6s97w5uWDDFea6/mNR+ppfnqie06tVeWcIJ8sfFKFtm4mJpdyTIp24DQ44+yHK9G1DcfyBqwdxOLpzVmqknpK4kQ5gJo235PiWAP9R79EqizTsZT3/fkKxk1iTMmn57XyxbIUQny5pcxoS2EPaKdAltMlK/RK4UZfQNmdK3RG4D8zFEu3qPveGSJUJE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413350d2-49f6-4470-2cbc-08d740cbbc7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 08:46:48.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31hxOjYruAPKr3C+OpH1t6eF/pvZ80OiaiktwMp7Fy/Ai4B8cXOj5GHXlRo3zgySX+rzJOkF2YFG8Fy3JlinCrDdSey/hyAcDFZ2dFR4LPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having CONFIG_MEMCG turned off causes these issues:
	mm/slub.o: In function `slab_pre_alloc_hook':
	/home/mircea/build/mm/slab.h:425: undefined reference to `memcg_kmem_get_c=
ache'
	mm/slub.o: In function `slab_post_alloc_hook':
	/home/mircea/build/mm/slab.h:444: undefined reference to `memcg_kmem_put_c=
ache'

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1dcb763..61a1391 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1265,10 +1265,10 @@ static inline bool mem_cgroup_under_socket_pressure=
(struct mem_cgroup *memcg)
 }
 #endif

+#ifdef CONFIG_MEMCG_KMEM
 struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
 void memcg_kmem_put_cache(struct kmem_cache *cachep);

-#ifdef CONFIG_MEMCG_KMEM
 int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge(struct page *page, int order);
 int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
@@ -1329,6 +1329,14 @@ extern int memcg_expand_shrinker_maps(int new_id);
 extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
                                   int nid, int shrinker_id);
 #else
+static inline struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *c=
achep)
+{
+       return cachep;
+}
+
+static inline void memcg_kmem_put_cache(struct kmem_cache *cachep)
+{
+}

 static inline int memcg_kmem_charge(struct page *page, gfp_t gfp, int orde=
r)
 {
