Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB2BC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B53F217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iIpvfYpK";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="S+FCj6Xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfDSUHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:07:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726804AbfDSUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:07:52 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3JJx5w5032418;
        Fri, 19 Apr 2019 13:07:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0o7TgRhaW9KvbjPuiOAr7raGQS1pQ+IeI9U51JZC12I=;
 b=iIpvfYpK9uoABdqXowvTj/D0wOnhc0EcJ3DyUmWS98LMH9aIhIcIt4/5/kuDuZi9fVp2
 kUibv00Ti57ANvzqVmxIH1MYozD/N9czODlsHNxrElaEo2p1Its8bnZWpdi6XswFtzzz
 LRgfS5KqX/jTs0IWyirzVEUtkKQHzUGxqOk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ryjv3gmy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 19 Apr 2019 13:07:40 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 19 Apr 2019 13:07:39 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 19 Apr 2019 13:07:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o7TgRhaW9KvbjPuiOAr7raGQS1pQ+IeI9U51JZC12I=;
 b=S+FCj6XiJVCX4l7FPV03wBXHGmcW9ckOipUBxwN1/xiCg8eKLesmGJ6CslQMHElSQk0yPdNlKVH1BL8fDF0T7JpQr9Tp0SuOISCy+c2/vU4t6YPI3sz/EyswpCFAKjSsiwltfrpe0FFDl8vnQofc8tGBWBE4mgJtsJ2Yr5NNWXI=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3478.namprd15.prod.outlook.com (20.179.60.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Fri, 19 Apr 2019 20:07:37 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1792.023; Fri, 19 Apr 2019
 20:07:37 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: refill_stock for kmem uncharging too
Thread-Topic: [PATCH] memcg: refill_stock for kmem uncharging too
Thread-Index: AQHU9i+qSI2o0+IJiEGApVgxjn8CnaZD6q2A
Date:   Fri, 19 Apr 2019 20:07:37 +0000
Message-ID: <20190419200733.GB31878@tower.DHCP.thefacebook.com>
References: <20190418214224.61900-1-shakeelb@google.com>
In-Reply-To: <20190418214224.61900-1-shakeelb@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0067.namprd10.prod.outlook.com
 (2603:10b6:300:2c::29) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:180f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ee3a094-d03e-4029-d408-08d6c502aafb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3478;
x-ms-traffictypediagnostic: BYAPR15MB3478:
x-microsoft-antispam-prvs: <BYAPR15MB3478942D3B87EDAE208F65ECBE270@BYAPR15MB3478.namprd15.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(486006)(6486002)(54906003)(316002)(476003)(99286004)(446003)(76176011)(6436002)(52116002)(71200400001)(6506007)(478600001)(71190400001)(97736004)(386003)(86362001)(102836004)(5660300002)(14444005)(33656002)(256004)(186003)(14454004)(1076003)(6916009)(7736002)(8676002)(81166006)(81156014)(305945005)(66946007)(66476007)(8936002)(25786009)(6116002)(73956011)(46003)(66446008)(66556008)(2906002)(68736007)(64756008)(6246003)(4326008)(11346002)(229853002)(9686003)(53936002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3478;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oFguq7AfXgIuTKgfBrkmHBfOpctHZGTcjmJ6pXMp4CZBs1tlqxlA6d7P78h3ZYYTBsIQDlYjOVfJQ4g+Kgirc6lwsNNIcIohrOxLXflXqk6K/oleMI1pKFOKBH5Cui+1UqYjtLqF1Mco7aFo/LXZAiWixb3Yuvdmmq2zV3mVNzYvIS7Zn03cpg0nzmTWs5cRLeTeLV6JAEO9/IxIeLwSBY5fnTauQMXl98U51+BJGVF3vnyHjQswaimQJ0GtoVALSpCe0j9PDJRLIK7wyunp8PiFmYDn8vkSzHiWjR1txs26lr6OYB2WveIr29YNn4Qt39DrtNDl0Qe58w1tY6P5yJ3/3BEEk8fji1LjJDdXEa+s+6D4UZZ41Lv6vg/WkfYItbmSZ8vF41KweBhMPBsy5fU3eYt+gN53Vwp+DCG3I5U=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E89A0B4BEB6BB42B99AC022945CB334@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee3a094-d03e-4029-d408-08d6c502aafb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 20:07:37.1442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3478
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-19_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 02:42:24PM -0700, Shakeel Butt wrote:
> The commit 475d0487a2ad ("mm: memcontrol: use per-cpu stocks for socket
> memory uncharging") added refill_stock() for skmem uncharging path to
> optimize workloads having high network traffic. Do the same for the kmem
> uncharging as well. However bypass the refill for offlined memcgs to not
> cause zombie apocalypse.
>=20
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Hello, Shakeel!

> ---
>  mm/memcontrol.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2535e54e7989..7b8de091f572 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -178,6 +178,7 @@ struct mem_cgroup_event {
> =20
>  static void mem_cgroup_threshold(struct mem_cgroup *memcg);
>  static void mem_cgroup_oom_notify(struct mem_cgroup *memcg);
> +static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_page=
s);
> =20
>  /* Stuffs for move charges at task migration. */
>  /*
> @@ -2097,10 +2098,7 @@ static void drain_stock(struct memcg_stock_pcp *st=
ock)
>  	struct mem_cgroup *old =3D stock->cached;
> =20
>  	if (stock->nr_pages) {
> -		page_counter_uncharge(&old->memory, stock->nr_pages);
> -		if (do_memsw_account())
> -			page_counter_uncharge(&old->memsw, stock->nr_pages);
> -		css_put_many(&old->css, stock->nr_pages);
> +		cancel_charge(old, stock->nr_pages);
>  		stock->nr_pages =3D 0;
>  	}
>  	stock->cached =3D NULL;
> @@ -2133,6 +2131,11 @@ static void refill_stock(struct mem_cgroup *memcg,=
 unsigned int nr_pages)
>  	struct memcg_stock_pcp *stock;
>  	unsigned long flags;
> =20
> +	if (unlikely(!mem_cgroup_online(memcg))) {
> +		cancel_charge(memcg, nr_pages);
> +		return;
> +	}

I'm slightly concerned about this part. Do we really need it?
The number of "zombies" which we can pin is limited by the number of CPUs,
and it will drop fast if there is any load on the machine.

If we skip offline memcgs, it can slow down charging/uncharging of skmem,
which might be a problem, if the socket is in active use by an other cgroup=
.
Honestly, I'd drop this part.

> +
>  	local_irq_save(flags);
> =20
>  	stock =3D this_cpu_ptr(&memcg_stock);
> @@ -2768,17 +2771,13 @@ void __memcg_kmem_uncharge(struct page *page, int=
 order)
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		page_counter_uncharge(&memcg->kmem, nr_pages);
> =20
> -	page_counter_uncharge(&memcg->memory, nr_pages);
> -	if (do_memsw_account())
> -		page_counter_uncharge(&memcg->memsw, nr_pages);
> -
>  	page->mem_cgroup =3D NULL;
> =20
>  	/* slab pages do not have PageKmemcg flag set */
>  	if (PageKmemcg(page))
>  		__ClearPageKmemcg(page);
> =20
> -	css_put_many(&memcg->css, nr_pages);
> +	refill_stock(memcg, nr_pages);
>  }
>  #endif /* CONFIG_MEMCG_KMEM */
> =20
> --=20
> 2.21.0.392.gf8f6787159e-goog
>=20

The rest looks good to me.

Thanks!
