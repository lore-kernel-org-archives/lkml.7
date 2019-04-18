Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149A8C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFF4217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FW/JetfM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EWotGmsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbfDRAjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:39:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58240 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728268AbfDRAjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:39:22 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3I0RO6d018235;
        Wed, 17 Apr 2019 17:39:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GtgCHvQddxepzDm5CilE+VAum+QHU1xHkXGEwpuPmHo=;
 b=FW/JetfMvy6oE23quhvpPdBzWf3l3k1VoVn6e44DwXcJqI1umxU6gXFq3pdMU4AoVwMB
 eobzNHwIwq78PyZPoYIm5j7VSVZ5WTyVzrDik0vQFZbnYF1RH4MY2adkGrhc4vM/g4Sh
 rTdlTN+SjAsU3LcVA7RVQy4OJnKraUlSQD4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rx0t2u33r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Apr 2019 17:39:04 -0700
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 17 Apr 2019 17:39:01 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 17 Apr 2019 17:39:00 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 17 Apr 2019 17:39:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtgCHvQddxepzDm5CilE+VAum+QHU1xHkXGEwpuPmHo=;
 b=EWotGmswVEmaOZyw8UJ1/cSI7CCmHAczCBjrjdhp6c2ApxoDgrJYxAAh7NZswvFRb4uh/MCiCHYKjPfaiJgTfHqpt1IU0PoywRYPaCBwAETXxVgscmLxibNVMGOXb0ZevGv6dB+jEKpxlhuDyqMWaa7jGbJK3CILXAJIv0uaOXY=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2823.namprd15.prod.outlook.com (20.179.158.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 00:38:58 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1792.021; Thu, 18 Apr 2019
 00:38:58 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Roman Gushchin <guroan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "Christoph Lameter" <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 4/5] mm: rework non-root kmem_cache lifecycle management
Thread-Topic: [PATCH 4/5] mm: rework non-root kmem_cache lifecycle management
Thread-Index: AQHU9WhFLwAo90XwHUSqs2s91sh5hqZBAzaAgAAQK4A=
Date:   Thu, 18 Apr 2019 00:38:57 +0000
Message-ID: <20190418003850.GA13977@tower.DHCP.thefacebook.com>
References: <20190417215434.25897-1-guro@fb.com>
 <20190417215434.25897-5-guro@fb.com>
 <CALvZod5K8SM2EQFH1WM9bbwWBtyXWb_PvzJGvF5dg1Z=bdR7zg@mail.gmail.com>
In-Reply-To: <CALvZod5K8SM2EQFH1WM9bbwWBtyXWb_PvzJGvF5dg1Z=bdR7zg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1001CA0002.namprd10.prod.outlook.com
 (2603:10b6:301:2a::15) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:a1cc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cf1bd20-59b0-4dcd-f990-08d6c3963e2a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2823;
x-ms-traffictypediagnostic: BYAPR15MB2823:
x-microsoft-antispam-prvs: <BYAPR15MB28232CF6FC065CD15790BCD7BE260@BYAPR15MB2823.namprd15.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(39860400002)(136003)(376002)(199004)(189003)(97736004)(486006)(102836004)(446003)(2906002)(6246003)(52116002)(86362001)(7416002)(25786009)(256004)(6436002)(476003)(99286004)(54906003)(186003)(53546011)(386003)(6506007)(4326008)(11346002)(8936002)(5660300002)(6486002)(229853002)(14454004)(1076003)(71190400001)(71200400001)(81156014)(81166006)(33656002)(14444005)(316002)(8676002)(6512007)(9686003)(7736002)(53936002)(478600001)(6116002)(6916009)(68736007)(46003)(305945005)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2823;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yeslp6739fC1arNXKi9CAv4CX2rcgZyjOZH1BPdEiyeUa4dZdt0msUU7uQd1z/qsbfArP82ZU5m3O6R0JgYtUKtDmqbfKVQ1IxoxfSgy2gcDq2VcJyOGUEVH1e+y0z5eNTYj5MCBiQqYoqoLgGPpFiBG9+8Vk61qhKnzw0JWHESzj27JDqtgubLQ66PgJR8dS6uteIEDYDOrCKE0IZhUdZosNnVXNtofjEoDa51f6EGsRb3tkLDrU212xMLq7OpSuA8+RyQ4UQRus+/ihovJkX9pHfOK7UB9vSZpA7yD8Ucn3WFNbFpq1ItkIPObUAUEA9y+ZHDRTB6Vd9eKU1rlc7Z29GhMxR20KD/JN82Vus7cZ/l9fCByW+IRR6CpDVAx1ZQ/O+T4OEeUpZJScsHDYuIzrA9hcpoFJY3IAVjJwCc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29E42D93509769408761DF124E08866C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf1bd20-59b0-4dcd-f990-08d6c3963e2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 00:38:57.8701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2823
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-17_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:41:01PM -0700, Shakeel Butt wrote:
> On Wed, Apr 17, 2019 at 2:55 PM Roman Gushchin <guroan@gmail.com> wrote:
> >
> > This commit makes several important changes in the lifecycle
> > of a non-root kmem_cache, which also affect the lifecycle
> > of a memory cgroup.
> >
> > Currently each charged slab page has a page->mem_cgroup pointer
> > to the memory cgroup and holds a reference to it.
> > Kmem_caches are held by the cgroup. On offlining empty kmem_caches
> > are freed, all other are freed on cgroup release.
>=20
> No, they are not freed (i.e. destroyed) on offlining, only
> deactivated. All memcg kmem_caches are freed/destroyed on memcg's
> css_free.

You're right, my bad. I was thinking about the corresponding sysfs entry
when was writing it. We try to free it from the deactivation path too.

>=20
> >
> > So the current scheme can be illustrated as:
> > page->mem_cgroup->kmem_cache.
> >
> > To implement the slab memory reparenting we need to invert the scheme
> > into: page->kmem_cache->mem_cgroup.
> >
> > Let's make every page to hold a reference to the kmem_cache (we
> > already have a stable pointer), and make kmem_caches to hold a single
> > reference to the memory cgroup.
>=20
> What about memcg_kmem_get_cache()? That function assumes that by
> taking reference on memcg, it's kmem_caches will stay. I think you
> need to get reference on the kmem_cache in memcg_kmem_get_cache()
> within the rcu lock where you get the memcg through css_tryget_online.

Yeah, a very good question.

I believe it's safe because css_tryget_online() guarantees that
the cgroup is online and won't go offline before css_free() in
slab_post_alloc_hook(). I do initialize kmem_cache's refcount to 1
and drop it on offlining, so it protects the online kmem_cache.

Thank you for looking into the patchset!
