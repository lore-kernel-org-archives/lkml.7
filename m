Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C764ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815F120684
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WZvHL3xd";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GUP9xQPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfJYUBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:01:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23718 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbfJYUBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:01:23 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9PK17kn023931;
        Fri, 25 Oct 2019 13:01:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UMeCfdI6/3IfcNVC8OV8i0P+BzjEn8sj+O5UpBKWKvU=;
 b=WZvHL3xdDFPqM32i6+17WzJvVNpBVRv1/nVJrmu3uVGrdFXSIkzm7we8Y7cAxcebh5Mv
 kS/RESDXFZOjjyvArsVKjXT6+2ACxCMkRJEw1KKdRpqpRW15pC8htTcO5OU88P4iQKCT
 334EI2kqh/CnNsAXR4Ek55BIza6Mk5G71Xc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vuuc5kngs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 13:01:09 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 25 Oct 2019 13:00:34 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 25 Oct 2019 13:00:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W62Llkeymq+GfWvpwDPmISUlI50aL6859mgWapEs7I0PhtY8j9XeSOUt0ylPoBlwghb42QmjKj9rQ6U6zJqQE6jTl9YlpihPgbne1f5x5B3VObpmstBLdjmWvb0jdEg053DviOdhB39GOC9ffNMyb8cf2sdvs/byuVEdwCQhZZeJINdotuBXbsaWa2/y8nj37RrDgkOMd7BtRDI5T4pf95E6WdEJp9bzgUXP0wC5vp2w3EAVT/9i2gAFE5NvVbZ+haAHch3gjXlcPICqHCvgZBX82pEup5zpiY7QzIGfaAiaAC9CvjLDmARRmN+hlvXCBAcOoe+pQBoUEHdBoDXh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMeCfdI6/3IfcNVC8OV8i0P+BzjEn8sj+O5UpBKWKvU=;
 b=YD8Sk1o+05pytIS2y1/MSb4n2rzLs3cWJOT/kVic1FxEvI+QCEBoxxZKCXAxln+QPYOx/5H9HFU+ZitjXtnbGhSZ9bK3bbJMqZykbxzZj5jnjBNFXehducMz/Ktf3ieXdq/uK3ES/CZvFjuA+mC/vrYC4B/xPciG0f4NAlIsD5iBUl+hdURpTBp2rNut4WHgtbjcsy1aV/PFcZdkEAAY2Tm+qszP/HRmuppABM7EzDNgUjkgasnRImoM9jIXxHJy4aYNQxsSUhW9GhBVYf5FxEPqLRnKLWOMpT+J+rKuq2npZ34EfIoGJZ/XHpbp/RCN2l4OO12AgeedWEVbM8JjLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMeCfdI6/3IfcNVC8OV8i0P+BzjEn8sj+O5UpBKWKvU=;
 b=GUP9xQPuzEueGZm8gMLWrXskKLbPGGZm7yhnVtSMV9O3G0Dp0DGdpm984aQUHhgxpbbHRr5xCM2ruo8dkZl4ffNmO6okOPhrbX/yhyF1f9q+4PrfUHP6ZvFAx442mPjE8CSyalDhQpFgcWne6kuc+R4VjJgMH+6wtuo0uKMAAzg=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2578.namprd15.prod.outlook.com (20.179.139.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 25 Oct 2019 20:00:32 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 20:00:32 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "Waiman Long" <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 09/16] mm: memcg/slab: charge individual slab objects
 instead of pages
Thread-Topic: [PATCH 09/16] mm: memcg/slab: charge individual slab objects
 instead of pages
Thread-Index: AQHVhUr89wbCEoSSmkSojIAthXBDTadrzcEAgAAFUQA=
Date:   Fri, 25 Oct 2019 20:00:32 +0000
Message-ID: <20191025200020.GA8325@castle.DHCP.thefacebook.com>
References: <20191018002820.307763-1-guro@fb.com>
 <20191018002820.307763-10-guro@fb.com> <20191025194118.GA393641@cmpxchg.org>
In-Reply-To: <20191025194118.GA393641@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:300:16::27) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::bdfd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f342b92d-bb98-4dfa-f87f-08d75985fde5
x-ms-traffictypediagnostic: BN8PR15MB2578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB25789ED87994F862F5A61AC5BE650@BN8PR15MB2578.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(256004)(52116002)(186003)(9686003)(476003)(6116002)(4326008)(6512007)(6916009)(76176011)(446003)(86362001)(6486002)(8676002)(14454004)(11346002)(6436002)(229853002)(7736002)(305945005)(6246003)(486006)(81166006)(8936002)(46003)(102836004)(81156014)(316002)(25786009)(54906003)(66556008)(66446008)(66476007)(66946007)(64756008)(71190400001)(6506007)(1076003)(5660300002)(71200400001)(561944003)(386003)(478600001)(99286004)(33656002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2578;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bETJpbE3mvAJ/CPPJWnp3QNaD/a/7DqvQSlCaCI5vVvUMpIRUF8dUWtVYYa1hJpdiRtT7eTOv/uBfeyBpZ6lVaKhZUvga5poXSj3YdMRpMXTNr3GnC49DmulV5BxyDydbZZG1Wjg11JrALZ0qV3H1/RugNQMRMpEzGTbDzMS0BGvxcraD/Dt2GyyZz7/86PXw0cEvg4ijnAMpWX4QEvAGXqlSvGst/3RyRPecpMzME561daSTAXpuA7L9FPaPVqhjpPLuF0NkxH8MHmaEGVe1TBTtHPKeXBndFUxDqr9z+41SA/Z4DqBezyeHvAboMKmH6axundd8oyVFXjY6f56zm51BIavic/Vm2SECfcARN+WU2mGf+0StiZk3o3W22wUJI2ZZC1MGfEiCBiodgp9R0uCRIrYZBtZhiuQa4ARGRp1+LiRsJHwCi8jbxAUbADI
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54289716AAA5304A98D8988A365F07C7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f342b92d-bb98-4dfa-f87f-08d75985fde5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 20:00:32.4482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VaoAQjvEz6SC6rbfYmLzsA00foy3TvdSZ8WIoKg+EO75AJrWjL8W5Ns3XbES5ea
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2578
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-25_10:2019-10-25,2019-10-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910250182
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

Yes, the idea makes total sense to me. I'm not sure I like the new naming
(I have to spend some time with it first), but the idea of moving
stocks and leftovers to the memcg_ptr/obj_cgroup level is really good.

I'll include something based on your proposal into the next version
of the patchset.

Thank you!
