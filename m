Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1471CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EF12080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pwhS3TWT";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ToqgVzO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfJaBxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:53:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65096 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbfJaBxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:53:16 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9V1qvdm021865;
        Wed, 30 Oct 2019 18:53:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GlGFhrx5mA21PcQpMoNtnkjzovh3JhiYzYPCmFr+P6w=;
 b=pwhS3TWTEmuHFrDWIUh+UmIDnMN3Qnjwt9hN+gbrtll1Uw0Um5jU8Ap5+A0YO6FX+QTz
 mCjFFqVW12Q6zZ4QGCslJcUxmeoPhqIwCBAksRpV3wh4o2Hnyqjk3lG4x+SAnKG6pMFS
 vTq+kEcgBkHW0LU35na8JewFUDwgiKufYNY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vyk8a0tu1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 18:53:04 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 30 Oct 2019 18:52:47 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 30 Oct 2019 18:52:46 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 30 Oct 2019 18:52:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPQXkpts1PhQRsuUOd3UcdBJ0ct+0sAkIrxHP9qE1FkMJjFS0wAFA7e049aewGoz32aBbQOA0GDVmPc3WjmcCKN2slfxKuHjzkOXKEanRZZ9MAbHtM+n+Woz8xOyNGJF1hNctsTSgoYTi3ew7aeiBI180KnPzcCf1p33zJvbWWKlP4hPszbkq9UNAoK6Jz7dBSGmDB9GL9NyiYw3csQNiJW0/9KrAzCok+bs8ato7Tr2fzYGGS3TSx94vA60rDnHiepFohxou9Oyipy2meVUBdVFuLsv2pk3iA+RHZIh4bLivaS1JIY4iHXXVfHxPTePhA8DTPULRx3M8dP9HpHt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlGFhrx5mA21PcQpMoNtnkjzovh3JhiYzYPCmFr+P6w=;
 b=oZfq0xC/8IfTa/Mpjen/Mz6dIeQY4KzbXOrhL+UhG4Ir88eowKWfB8PZZu5Y3qZorMdMFkGFXWwLInOeln0IOvUTZhYU9uX6xMcP4i8JMBTnELAJoJvbmUfQUZd/pfZV39BKd9TrMZm2HjZBjqedDrB+9NRihnTKZON3Iw17I2Orex3G4d9frwfujqjWgMJvvcuGnNyM1hm9z3hgFF4qPm0FmYU0oWBwf1qIAcDEvffnSTCJD6z9FrshVmq27zSNNDu04Ba7ecBWzD0v+KG3Y6h6lGMR6kv/5AgjNrDsDRgdfqgJqNwmCZ7Sivy4MTTSzHYF8H+tn3I/Nw2JaMz41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlGFhrx5mA21PcQpMoNtnkjzovh3JhiYzYPCmFr+P6w=;
 b=ToqgVzO0jUlzJ0p35tSBBnTgnBD2qoPwQpD2bB5O+9IdRp2G1LEb0zYmgekeh6m21jBwUyd6VcSWiQOpqh2YGYEl0PLSQMGXEkxCdYr9ZRikenxp3x0T7MFqmL0LOIzKNrya+v48LrBJ++L/KKIuBrODZgzfOXm4iy4VoVDznIQ=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2946.namprd15.prod.outlook.com (20.178.218.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 31 Oct 2019 01:52:44 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2387.027; Thu, 31 Oct 2019
 01:52:44 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 09/16] mm: memcg/slab: charge individual slab objects
 instead of pages
Thread-Topic: [PATCH 09/16] mm: memcg/slab: charge individual slab objects
 instead of pages
Thread-Index: AQHVhUr89wbCEoSSmkSojIAthXBDTadrzcEAgAhDaAA=
Date:   Thu, 31 Oct 2019 01:52:44 +0000
Message-ID: <20191031015238.GA21323@castle.DHCP.thefacebook.com>
References: <20191018002820.307763-1-guro@fb.com>
 <20191018002820.307763-10-guro@fb.com> <20191025194118.GA393641@cmpxchg.org>
In-Reply-To: <20191025194118.GA393641@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR18CA0045.namprd18.prod.outlook.com
 (2603:10b6:104:2::13) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::b46e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4157e853-5e67-4961-68cc-08d75da505a5
x-ms-traffictypediagnostic: BN8PR15MB2946:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB29465079EBD06D397F81223CBE630@BN8PR15MB2946.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(136003)(39860400002)(376002)(189003)(51914003)(199004)(8676002)(8936002)(1076003)(7736002)(386003)(25786009)(229853002)(6436002)(99286004)(6486002)(9686003)(6512007)(76176011)(6246003)(54906003)(6916009)(33656002)(316002)(30864003)(52116002)(6506007)(81156014)(81166006)(305945005)(6116002)(14454004)(5660300002)(186003)(46003)(256004)(14444005)(478600001)(446003)(71190400001)(102836004)(66446008)(71200400001)(66556008)(86362001)(11346002)(476003)(66946007)(486006)(4326008)(64756008)(66476007)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2946;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rjFd03k8fp07IPEmeCiagbqPElqY//yOJ+RC0Kv7cJrCpYpA7L+wUcLF+ieUtWLOOu03GC9MtalYv0yh9RIc42opAUScjhdk4YVuS0QG1Y6UYDZ6IMnzVPUqHGVL3kV6xHOxAhfsy/lVNcqN7UHiCkVu87i4RlLpATNxXhwoQDLzktNFtq6h07GhJ37W7L5+yinnR6KxsbANCK3GO4mTgOGah7LUZ803b8cOkGUjpsseixcvIy/lkFVJT57L0b955UjhXzbvhWbHpIZ9897lxYFYFFCtAM2MbFHuqdLrWk12kha6a5xwodjEaZJBCB5oD/sQP2QEYhuO32tm50Y+c1xUFAbUYSGVaJjbfg8+VoBNM3t+ryI/LC4ojEWYja5KSkWAGTl0Pw6FwR67MkVa8VbfxqqF1WsX4L0H4DrAuO+IpFQB8/aLKiAdPmBcr3Ky
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD780D545DFB58489E528DC09A60DA46@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4157e853-5e67-4961-68cc-08d75da505a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 01:52:44.6715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8xvwzrOzZe6QIQxrd9v9tvtVGtMDTnLXt3usR4j1l7te53ye4X0lCaiABbY5kvt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2946
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_10:2019-10-30,2019-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910310016
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 03:41:18PM -0400, Johannes Weiner wrote:
> On Thu, Oct 17, 2019 at 05:28:13PM -0700, Roman Gushchin wrote:
> > +static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem=
_cache *s,
> > +						struct mem_cgroup **memcgp,
> > +						size_t size, gfp_t flags)
> > +{
> > +	struct kmem_cache *cachep;
> > +
> > +	cachep =3D memcg_kmem_get_cache(s, memcgp);
> > +	if (is_root_cache(cachep))
> > +		return s;
> > +
> > +	if (__memcg_kmem_charge_subpage(*memcgp, size * s->size, flags)) {
> > +		mem_cgroup_put(*memcgp);
> > +		memcg_kmem_put_cache(cachep);
> > +		cachep =3D NULL;
> > +	}
> > +
> > +	return cachep;
> > +}
> > +
> >  static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> >  					      struct mem_cgroup *memcg,
> >  					      size_t size, void **p)
> >  {
> >  	struct mem_cgroup_ptr *memcg_ptr;
> > +	struct lruvec *lruvec;
> >  	struct page *page;
> >  	unsigned long off;
> >  	size_t i;
> > @@ -439,6 +393,11 @@ static inline void memcg_slab_post_alloc_hook(stru=
ct kmem_cache *s,
> >  			off =3D obj_to_index(s, page, p[i]);
> >  			mem_cgroup_ptr_get(memcg_ptr);
> >  			page->mem_cgroup_vec[off] =3D memcg_ptr;
> > +			lruvec =3D mem_cgroup_lruvec(page_pgdat(page), memcg);
> > +			mod_lruvec_memcg_state(lruvec, cache_vmstat_idx(s),
> > +					       s->size);
> > +		} else {
> > +			__memcg_kmem_uncharge_subpage(memcg, s->size);
> >  		}
> >  	}
> >  	mem_cgroup_ptr_put(memcg_ptr);
>=20
> The memcg_ptr as a collection vessel for object references makes a lot
> of sense. But this code showcases that it should be a first-class
> memory tracking API that the allocator interacts with, rather than
> having to deal with a combination of memcg_ptr and memcg.
>=20
> In the two hunks here, on one hand we charge bytes to the memcg
> object, and then handle all the refcounting through a different
> bucketing object. To support that in the first place, we have to
> overload the memcg API all the way down to try_charge() to support
> bytes and pages. This is difficult to follow throughout all layers.
>=20
> What would be better is for this to be an abstraction layer for a
> subpage object tracker that sits on top of the memcg page tracker -
> not unlike the page allocator and the slab allocators themselves.
>=20
> And then the slab allocator would only interact with the subpage
> object tracker, and the object tracker would deal with the memcg page
> tracker under the hood.

Hello, Johannes!

After some thoughts and coding I don't think it's a right direction to go.
Under direction I mean building the new subpage/obj_cgroup API on top
of the intact existing memcg API.
Let me illustrate my point on the code you provided (please, look below).

>=20
> Something like the below, just a rough sketch to convey the idea:
>=20
> On allocation, we look up an obj_cgroup from the current task, charge
> it with obj_cgroup_charge() and bump its refcount by the number of
> objects we allocated. obj_cgroup_charge() in turn uses the memcg layer
> to charge pages, and then doles them out as bytes using
> objcg->nr_stocked_bytes and the byte per-cpu stock.
>=20
> On freeing, we call obj_cgroup_uncharge() and drop the references. In
> turn, this first refills the byte per-cpu stock and drains the
> overflow to the memcg layer (which in turn refills its own page stock
> and drains to the page_counter).
>=20
> On cgroup deletion, we reassign the obj_cgroup to the parent, and all
> remaining live objects will free their pages to the updated parental
> obj_cgroup->memcg, as per usual.
>=20
> ---
>=20
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index f36203cf75f8..efc3398aaf02 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -200,15 +200,15 @@ struct memcg_cgwb_frn {
>  };
> =20
>  /*
> - * A pointer to a memory cgroup with a built-in reference counter.
> - * For a use as an intermediate object to simplify reparenting of
> - * objects charged to the cgroup. The memcg pointer can be switched
> - * to the parent cgroup without a need to modify all objects
> - * which hold the reference to the cgroup.
> + * Bucket for arbitrarily byte-sized objects charged to a memory
> + * cgroup. The bucket can be reparented in one piece when the cgroup
> + * is destroyed, without having to round up the individual references
> + * of all live memory objects in the wild.
>   */
> -struct mem_cgroup_ptr {
> -	struct percpu_ref refcnt;
> +struct obj_cgroup {
> +	struct percpu_ref count;
>  	struct mem_cgroup *memcg;
> +	unsigned long nr_stocked_bytes;
>  	union {
>  		struct list_head list;
>  		struct rcu_head rcu;
> @@ -230,7 +230,6 @@ struct mem_cgroup {
>  	/* Accounted resources */
>  	struct page_counter memory;
>  	struct page_counter swap;
> -	atomic_t nr_stocked_bytes;
> =20
>  	/* Legacy consumer-oriented counters */
>  	struct page_counter memsw;
> @@ -327,8 +326,8 @@ struct mem_cgroup {
>          /* Index in the kmem_cache->memcg_params.memcg_caches array */
>  	int kmemcg_id;
>  	enum memcg_kmem_state kmem_state;
> -	struct mem_cgroup_ptr __rcu *kmem_memcg_ptr;
> -	struct list_head kmem_memcg_ptr_list;
> +	struct obj_cgroup __rcu *slab_objs;
> +	struct list_head slab_objs_list;
>  #endif
> =20
>  	int last_scanned_node;
> @@ -474,21 +473,6 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup=
_subsys_state *css){
>  	return css ? container_of(css, struct mem_cgroup, css) : NULL;
>  }
> =20
> -static inline bool mem_cgroup_ptr_tryget(struct mem_cgroup_ptr *ptr)
> -{
> -	return percpu_ref_tryget(&ptr->refcnt);
> -}
> -
> -static inline void mem_cgroup_ptr_get(struct mem_cgroup_ptr *ptr)
> -{
> -	percpu_ref_get(&ptr->refcnt);
> -}
> -
> -static inline void mem_cgroup_ptr_put(struct mem_cgroup_ptr *ptr)
> -{
> -	percpu_ref_put(&ptr->refcnt);
> -}
> -
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>  	if (memcg)
> @@ -1444,9 +1428,9 @@ int __memcg_kmem_charge_memcg(struct page *page, gf=
p_t gfp, int order,
>  			      struct mem_cgroup *memcg);
>  void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
>  				 unsigned int nr_pages);
> -int __memcg_kmem_charge_subpage(struct mem_cgroup *memcg, size_t size,
> +int obj_cgroup_charge(struct obj_cgroup *objcg, size_t size,
>  				gfp_t gfp);
> -void __memcg_kmem_uncharge_subpage(struct mem_cgroup *memcg, size_t size=
);
> +void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
> =20
>  extern struct static_key_false memcg_kmem_enabled_key;
>  extern struct workqueue_struct *memcg_kmem_cache_wq;
> @@ -1513,20 +1497,20 @@ static inline int memcg_cache_id(struct mem_cgrou=
p *memcg)
>  	return memcg ? memcg->kmemcg_id : -1;
>  }
> =20
> -static inline struct mem_cgroup_ptr *
> -mem_cgroup_get_kmem_ptr(struct mem_cgroup *memcg)
> +static inline struct obj_cgroup *
> +mem_cgroup_get_slab_objs(struct mem_cgroup *memcg)
>  {
> -	struct mem_cgroup_ptr *memcg_ptr;
> +	struct obj_cgroup *objcg;
> =20
>  	rcu_read_lock();
>  	do {
> -		memcg_ptr =3D rcu_dereference(memcg->kmem_memcg_ptr);
> -		if (memcg_ptr && mem_cgroup_ptr_tryget(memcg_ptr))
> +		objcg =3D rcu_dereference(memcg->slab_objs);
> +		if (objcg && percpu_ref_tryget(&objcg->count))
>  			break;
>  	} while ((memcg =3D parent_mem_cgroup(memcg)));
>  	rcu_read_unlock();
> =20
> -	return memcg_ptr;
> +	return objcg;
>  }
> =20
>  #else
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4d99ee5a9c53..7f663fd53c17 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -200,7 +200,7 @@ struct page {
>  #ifdef CONFIG_MEMCG
>  	union {
>  		struct mem_cgroup *mem_cgroup;
> -		struct mem_cgroup_ptr **mem_cgroup_vec;
> +		struct obj_cgroup **obj_cgroups;
>  	};
>  #endif
> =20
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b0d0c833150c..47110f4f0f4c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -260,52 +260,51 @@ struct cgroup_subsys_state *vmpressure_to_css(struc=
t vmpressure *vmpr)
>  #ifdef CONFIG_MEMCG_KMEM
>  extern spinlock_t css_set_lock;
> =20
> -static void memcg_ptr_release(struct percpu_ref *ref)
> +static void obj_cgroup_release(struct percpu_ref *ref)
>  {
> -	struct mem_cgroup_ptr *ptr =3D container_of(ref, struct mem_cgroup_ptr,
> -						  refcnt);
> +	struct obj_cgroup *objcg;
>  	unsigned long flags;
> =20
> +	objcg =3D container_of(ref, struct obj_cgroup, count);
> +
>  	spin_lock_irqsave(&css_set_lock, flags);
> -	list_del(&ptr->list);
> +	list_del(&objcg->list);
>  	spin_unlock_irqrestore(&css_set_lock, flags);
> =20
> -	mem_cgroup_put(ptr->memcg);
> +	mem_cgroup_put(objcg->memcg);
>  	percpu_ref_exit(ref);
> -	kfree_rcu(ptr, rcu);
> +	kfree_rcu(objcg, rcu);
>  }

Btw, the part below is looking good, thanks for the idea!

> =20
> -static int memcg_init_kmem_memcg_ptr(struct mem_cgroup *memcg)
> +static int obj_cgroup_alloc(struct mem_cgroup *memcg)
>  {
> -	struct mem_cgroup_ptr *kmem_memcg_ptr;
> +	struct obj_cgroup *objcg;
>  	int ret;
> =20
> -	kmem_memcg_ptr =3D kmalloc(sizeof(struct mem_cgroup_ptr), GFP_KERNEL);
> -	if (!kmem_memcg_ptr)
> +	objcg =3D kmalloc(sizeof(struct obj_cgroup), GFP_KERNEL);
> +	if (!objcg)
>  		return -ENOMEM;
> =20
> -	ret =3D percpu_ref_init(&kmem_memcg_ptr->refcnt, memcg_ptr_release,
> +	ret =3D percpu_ref_init(&objcg->count, obj_cgroup_release,
>  			      0, GFP_KERNEL);
>  	if (ret) {
> -		kfree(kmem_memcg_ptr);
> +		kfree(objcg);
>  		return ret;
>  	}
> =20
> -	kmem_memcg_ptr->memcg =3D memcg;
> -	INIT_LIST_HEAD(&kmem_memcg_ptr->list);
> -	rcu_assign_pointer(memcg->kmem_memcg_ptr, kmem_memcg_ptr);
> -	list_add(&kmem_memcg_ptr->list, &memcg->kmem_memcg_ptr_list);
> +	INIT_LIST_HEAD(&objcg->list);
> +	objcg->memcg =3D memcg;
>  	return 0;
>  }
> =20

< cut >

> @@ -3117,15 +3095,24 @@ void __memcg_kmem_uncharge(struct page *page, int=
 order)
>  	css_put_many(&memcg->css, nr_pages);
>  }
> =20
> -int __memcg_kmem_charge_subpage(struct mem_cgroup *memcg, size_t size,
> -				gfp_t gfp)
> +int obj_cgroup_charge(struct obj_cgroup *objcg, size_t size, gfp_t gfp)
>  {
> -	return try_charge(memcg, gfp, size, true);
> +	int ret;
> +
> +	if (consume_obj_stock(objcg, nr_bytes))
> +		return 0;
> +
> +	ret =3D try_charge(objcg->memcg, gfp, 1);
> +	if (ret)
> +		return ret;

So, the first problem is here: try_charge() will bump the memcg reference.
It works for generic pages, where we set the mem_cgroup pointer, so that
the reference corresponds to the actual physical page.
But in this case, the actual page is shared between multiple cgroups.
Memcg will be basically referenced once for each stock cache miss.
I struggle to understand what does it mean and how to balance it
with unreferencing on the free path.

The second problem is also here. If a task belonging to a different memcg
is scheduled on this cpu, most likely we will need to refill both stocks,
even if we need only a small temporarily allocation.

> +
> +	refill_obj_stock(objcg, PAGE_SIZE - size);

And the third problem is here. Percpu allocations (on which accounting I'm
working right now) can be larger than a page.

This is fairly small issue in comparison to the first one. But it illustrat=
es
well the main point: we can't simple get a page from the existing API and
sublease it in parts. The problem is that we need to break the main princip=
le
that a page belongs to a single memcg.

Please, let me know what do you think about it.

Thank you!

Roman
