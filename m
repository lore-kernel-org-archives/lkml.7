Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58996C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16945206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="A1cZu055";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Xm9uxt2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfFEWC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:02:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52794 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbfFEWC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:02:58 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x55LqDn3018295;
        Wed, 5 Jun 2019 15:02:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xu55zHk+E53hUFxZ4FEBqNufQkt2O0JgzDK0pFwhX/E=;
 b=A1cZu055BFHwMsuNAvzP5n07a7llwqJXgdFs4rI030LwmUmpmq9MCJ7b/eRxEzQDUzoF
 0hlh8Spx0UxtsFuCkV/Co9eMZEI7gEu+o8GcZSuzB0Y9MuFKBczXVDoCfvwBxLs20lXH
 YG0N9GMViIxrg+KVmJ7qcThW95iVfLT0wqs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sxgfm9dxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 Jun 2019 15:02:14 -0700
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Jun 2019 15:02:10 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Jun 2019 15:02:09 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Jun 2019 15:02:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu55zHk+E53hUFxZ4FEBqNufQkt2O0JgzDK0pFwhX/E=;
 b=Xm9uxt2fNxGhNJQ2sztlfUSsY6nSPZqR0LGNy9SLF1leP9sc4iI55DPwGlEqN0oxyj9mFkRbfD6D5oX+HFJk87YOEtZV1GSchKzs1TSeJxcXKp4ZdHIqYqyP00rCu0T8bQFJy1CIUbERaSyvVUxSvDKQYGT1cwEKImU+0/ZzrE8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3096.namprd15.prod.outlook.com (20.178.239.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Wed, 5 Jun 2019 22:02:07 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1943.018; Wed, 5 Jun 2019
 22:02:07 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 07/10] mm: synchronize access to kmem_cache dying flag
 using a spinlock
Thread-Topic: [PATCH v6 07/10] mm: synchronize access to kmem_cache dying flag
 using a spinlock
Thread-Index: AQHVG0i1Wx1jT2Odq02KGn1J823cf6aNSJwAgABVb4A=
Date:   Wed, 5 Jun 2019 22:02:06 +0000
Message-ID: <20190605220201.GA16188@tower.DHCP.thefacebook.com>
References: <20190605024454.1393507-1-guro@fb.com>
 <20190605024454.1393507-8-guro@fb.com> <20190605165615.GC12453@cmpxchg.org>
In-Reply-To: <20190605165615.GC12453@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0056.namprd15.prod.outlook.com
 (2603:10b6:101:1f::24) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:4608]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 575850e6-784e-4aa5-f751-08d6ea017321
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB3096;
x-ms-traffictypediagnostic: BYAPR15MB3096:
x-microsoft-antispam-prvs: <BYAPR15MB3096BEC420A29754B7EF196EBE160@BYAPR15MB3096.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(2906002)(305945005)(6512007)(14454004)(5660300002)(9686003)(33656002)(1076003)(478600001)(7736002)(229853002)(6916009)(6116002)(6436002)(6486002)(86362001)(71200400001)(99286004)(8936002)(71190400001)(54906003)(486006)(446003)(6246003)(11346002)(476003)(53936002)(73956011)(76176011)(4326008)(68736007)(256004)(14444005)(102836004)(52116002)(81156014)(8676002)(6506007)(25786009)(316002)(386003)(81166006)(46003)(66446008)(64756008)(66556008)(66476007)(186003)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3096;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5+mkrA4U0xy2JvKjh3uRuEBRsYU+DW4pMrbjVvSwPgxpAU0PUPQvp/CQO1lHf7fNTymr7HHXF9SPc5v8+t+EGvIJGv+gyWKoV4GArzUMHlc+9Dah1OreL0qSSvbA1dFVVDWpTcIyZ96U8oJjJC5A/+rzBSzqp+s2nDHMjpnDpMTrSFr5AsuTdZJDSw3gHQZj+xmrGrMU9D4d2cDhxvB+fTiUUA6B2txxw+23P5WWUX5bSshxCGVWfVVf2NCGwnv0GCF6l8vy7EKwczEEJmhwhuxUIcIm1n7lp9FICAaE8P68Zxu0GrxXOppNrHeAUJgWLAcRnx/R4YT4SwxZ2FsMRFupTgRT4M0o/fkIsLX1/l0grTn/Cz64z2GpWCg3LRDmX2ZD7glaEkeMqT5lfUlJdHldpcUCqK8VtikrZic9EmQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B892CB83EB11F74BA86B21DB9D1B5F14@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 575850e6-784e-4aa5-f751-08d6ea017321
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 22:02:07.0154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3096
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050138
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 12:56:16PM -0400, Johannes Weiner wrote:
> On Tue, Jun 04, 2019 at 07:44:51PM -0700, Roman Gushchin wrote:
> > Currently the memcg_params.dying flag and the corresponding
> > workqueue used for the asynchronous deactivation of kmem_caches
> > is synchronized using the slab_mutex.
> >=20
> > It makes impossible to check this flag from the irq context,
> > which will be required in order to implement asynchronous release
> > of kmem_caches.
> >=20
> > So let's switch over to the irq-save flavor of the spinlock-based
> > synchronization.
> >=20
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  mm/slab_common.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 09b26673b63f..2914a8f0aa85 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -130,6 +130,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, g=
fp_t flags, size_t nr,
> >  #ifdef CONFIG_MEMCG_KMEM
> > =20
> >  LIST_HEAD(slab_root_caches);
> > +static DEFINE_SPINLOCK(memcg_kmem_wq_lock);
> > =20
> >  void slab_init_memcg_params(struct kmem_cache *s)
> >  {
> > @@ -629,6 +630,7 @@ void memcg_create_kmem_cache(struct mem_cgroup *mem=
cg,
> >  	struct memcg_cache_array *arr;
> >  	struct kmem_cache *s =3D NULL;
> >  	char *cache_name;
> > +	bool dying;
> >  	int idx;
> > =20
> >  	get_online_cpus();
> > @@ -640,7 +642,13 @@ void memcg_create_kmem_cache(struct mem_cgroup *me=
mcg,
> >  	 * The memory cgroup could have been offlined while the cache
> >  	 * creation work was pending.
> >  	 */
> > -	if (memcg->kmem_state !=3D KMEM_ONLINE || root_cache->memcg_params.dy=
ing)
> > +	if (memcg->kmem_state !=3D KMEM_ONLINE)
> > +		goto out_unlock;
> > +
> > +	spin_lock_irq(&memcg_kmem_wq_lock);
> > +	dying =3D root_cache->memcg_params.dying;
> > +	spin_unlock_irq(&memcg_kmem_wq_lock);
> > +	if (dying)
> >  		goto out_unlock;
>=20
> What does this lock protect? The dying flag could get set right after
> the unlock.
>

Hi Johannes!

Here is my logic:

1) flush_memcg_workqueue() must guarantee that no new memcg kmem_caches
will be created, and there are no works queued, which will touch
the root kmem_cache, so it can be released
2) so it sets the dying flag, waits for an rcu grace period and flushes
the workqueue (that means for all in-flight works)
3) dying flag in checked in kmemcg_cache_shutdown() and
kmemcg_cache_deactivate(), so that if it set, no new works/rcu tasks
will be queued. corresponding queue_work()/call_rcu() are all under
memcg_kmem_wq_lock lock.
4) memcg_schedule_kmem_cache_create() doesn't check the dying flag
(probably to avoid taking locks on a hot path), but it does
memcg_create_kmem_cache(), which is part of the scheduled work.
And it does it at the very beginning, so even if new kmem_caches
are scheduled to be created, the root kmem_cache won't be touched.

Previously the flag was checked under slab_mutex, but now we set it
under memcg_kmem_wq_lock lock. So I'm not sure we can read it without
taking this lock.

If the flag will be set after unlock, it's fine. It means that the
work has already been scheduled, and flush_workqueue() in
flush_memcg_workqueue() will wait for it. The only problem is if we
don't see the flag after flush_workqueue() is called, but I don't
see how it's possible.

Does it makes sense? I'm sure there are ways to make it more obvious.
Please, let me know if you've any ideas.

Thank you!
