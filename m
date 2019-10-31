Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACFDCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9C72087E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LjB9Tz9m";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YF/y2nVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfJaPHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:07:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20344 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728032AbfJaPHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:07:25 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9VF79nT011047;
        Thu, 31 Oct 2019 08:07:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3BAJIjxJFijBFNgcfAZHL88yBZBvsT6bTgsKDjAUgJk=;
 b=LjB9Tz9mbVy2AOj8xMeZHLE8cj9o8tsTAJrVJwq/Y5XKP5GwbGd4JwtVeGcg1g8qjeEN
 HqgRoVc+UphAG+3g9G6H3lBa5U7v6p3UVMc/d9qUaNjk4vwWFwZ77q6q13puuwf1Vq3Q
 tJyK6tQdlz2iCrnz9/jXl8Or6SZ+6vZnBCk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2w01b2080e-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 31 Oct 2019 08:07:14 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 31 Oct 2019 08:07:06 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 31 Oct 2019 08:07:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QD8cxH3ptR/qFjkiiO0xHsnfNbG8/5J2SSUSgR35iqCTlFQIU7jEd2y/ZoY/VT9062Z/v+Ye49UdVrj5tVUkjviJDxOeEnTRCiYc1wFClYHVJDtZ1KajryrATxEPOtxQKbb2diWn6aYYitGxvqB6TxKxQnuEu+bKYbILyvbmeorbaLJ7w3msh8tWhVklCM3cNx/5bIRIJncNvKEAgdgyi2/BKkVZpo6aH9YyRHgqrCvFo5Duc8eWreZG+XQP4oEgiARDKz4BJbG0xjyf2SH+G7AlfY5f3sXB/PfMxzb/6d+HgTLJa7XWmuyNv6LLlmStCFRXMZkZLa+JVjn4sEpLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BAJIjxJFijBFNgcfAZHL88yBZBvsT6bTgsKDjAUgJk=;
 b=AlzwxN0CzAsdr58nJ0dXYHGD1hZazHt0HZNuCCWt2BVrwVDgJvszkAJJ+d4WzndhcT2sQ8FGE01pyS/BuWbvW/BWemTD+RcsU05V9K/M4t45kuP/iQ763F6EHS3RoHLvYE3MY0dKtxw0xEOu5uvaxpPZ32A6YJH5IjBJjlniVkbIAXflOvE8EMv7yv2FvhnblqBXpFxxI1wKrnl+4G/NGWSTn7i8kgp077edDJGqdq2lDwHjiJKj7NEQY6gVsQmXelasDLblzx+jSdW7gEbdrdrxaBNbhancw/pWtBOAHr2hY3tRC+J9T88lcfHR4cvyy19EKXVSN1vr+ofbGHW4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BAJIjxJFijBFNgcfAZHL88yBZBvsT6bTgsKDjAUgJk=;
 b=YF/y2nVONtzjkCx8/ct9PxZpHa7i/P3AzXJOvdrQKLEsv0ItH6eQT/ZdvqETiYpvmL2cQsuCq4C2XzusGNo++17DzW+bmf90kPQ2NoA013NxRnGrfD5SHEbgUZlJY6OjXy7TEOKjAS0ZhTBI/aIoy7tzCEaoXgD4nsMQnfCiU/0=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2627.namprd15.prod.outlook.com (20.179.137.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Thu, 31 Oct 2019 15:07:02 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2387.027; Thu, 31 Oct 2019
 15:07:02 +0000
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
Thread-Index: AQHVhUr89wbCEoSSmkSojIAthXBDTadrzcEAgAhDaACAANbqgIAABwOA
Date:   Thu, 31 Oct 2019 15:07:02 +0000
Message-ID: <20191031150657.GA31765@tower.DHCP.thefacebook.com>
References: <20191018002820.307763-1-guro@fb.com>
 <20191018002820.307763-10-guro@fb.com> <20191025194118.GA393641@cmpxchg.org>
 <20191031015238.GA21323@castle.DHCP.thefacebook.com>
 <20191031144151.GB1168@cmpxchg.org>
In-Reply-To: <20191031144151.GB1168@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0038.namprd22.prod.outlook.com
 (2603:10b6:300:69::24) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:3748]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70d1a8bd-6c31-4f76-45f6-08d75e13fbcf
x-ms-traffictypediagnostic: BN8PR15MB2627:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB262741F515E27A2B812D4344BE630@BN8PR15MB2627.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39860400002)(189003)(199004)(54906003)(7736002)(8936002)(6486002)(8676002)(486006)(25786009)(46003)(6436002)(476003)(5660300002)(2906002)(446003)(81156014)(81166006)(9686003)(11346002)(6512007)(305945005)(1076003)(6916009)(6116002)(186003)(33656002)(386003)(66446008)(99286004)(6506007)(64756008)(86362001)(102836004)(14454004)(4326008)(66946007)(316002)(52116002)(76176011)(478600001)(229853002)(66556008)(6246003)(14444005)(71200400001)(256004)(71190400001)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2627;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsUUQ3J8FN+o+qLV7nLWcymO6uSkat4vVm6clT8al88FlIvEXeEzcjOGjzDSLqEpkZK3mFGkFCkWHIDNiO0t1lxGwuzzsKbQxFNaZJLC+h1vdud4G85F2IC9ax6RFMkujIaTat99ApS2zN2w8Wu6uqmkd4Bpyz+9IT1D4snb8v2p3/feXmYMzGtwjMhKr9iRX/1v+GC7c08zYqnI3ohyYS7mL2ValkKY1mT/T9zpkOkJlBil+qgnl1xgKz7+fTCQ+j+tbkjikkIwRqcAhllOXQWe/oZFCiFAQ//y3QRRgEtYk+XlEe4Fs6z2dTiMEFqIk53lDToIxD9JXA7Nz/ag4/kIAqpioDI84JYV7LtrpfIw7jVxdcOSK5tj0cinGA1drKIvvrfe07Zvr+O6w98EBVbUu1hRgxjv709fBBFDrkVSrxmytPScBV2tudBkf9xj
Content-Type: text/plain; charset="us-ascii"
Content-ID: <599C994690A61041AD935BB8453A9F22@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d1a8bd-6c31-4f76-45f6-08d75e13fbcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 15:07:02.1197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKqY43CPRRpnob01h8AI2HObGd+OjfpX7b89fQJRHiGST00VZ5WVQA4WvcSLpsLg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2627
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-31_06:2019-10-30,2019-10-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910310155
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 10:41:51AM -0400, Johannes Weiner wrote:
> On Thu, Oct 31, 2019 at 01:52:44AM +0000, Roman Gushchin wrote:
> > On Fri, Oct 25, 2019 at 03:41:18PM -0400, Johannes Weiner wrote:
> > > @@ -3117,15 +3095,24 @@ void __memcg_kmem_uncharge(struct page *page,=
 int order)
> > >  	css_put_many(&memcg->css, nr_pages);
> > >  }
> > > =20
> > > -int __memcg_kmem_charge_subpage(struct mem_cgroup *memcg, size_t siz=
e,
> > > -				gfp_t gfp)
> > > +int obj_cgroup_charge(struct obj_cgroup *objcg, size_t size, gfp_t g=
fp)
> > >  {
> > > -	return try_charge(memcg, gfp, size, true);
> > > +	int ret;
> > > +
> > > +	if (consume_obj_stock(objcg, nr_bytes))
> > > +		return 0;
> > > +
> > > +	ret =3D try_charge(objcg->memcg, gfp, 1);
> > > +	if (ret)
> > > +		return ret;
>=20
> > The second problem is also here. If a task belonging to a different mem=
cg
> > is scheduled on this cpu, most likely we will need to refill both stock=
s,
> > even if we need only a small temporarily allocation.
>=20
> Yes, that's a good thing. The reason we have the per-cpu caches in the
> first place is because most likely the same cgroup will perform
> several allocations. Both the slab allocator and the page allocator
> have per-cpu caches for the same reason. I don't really understand
> what the argument is.

I mean it seems strange (and most likely will show up in perf numbers)
to move a page from one stock to another. Is there a reason why do you want
to ask try_charge() and stock only a single page?

Can we do the following instead?

1) add a boolean argument to try_charge() to bypass the consume_stock() cal=
l
at the beginning and just go slow path immediately
2) use try_charge() with this argument set to true to fill the objc/subpage
stock with MEMCG_CHARGE_BATCH pages

In this case we'll reuse try_charge() and will have all corresponding benef=
its,
but will avoid the double stocking, which seems as a strange idea to me.

>=20
> > > +
> > > +	refill_obj_stock(objcg, PAGE_SIZE - size);
> >=20
> > And the third problem is here. Percpu allocations (on which accounting =
I'm
> > working right now) can be larger than a page.
>=20
> How about this?
>=20
> 	nr_pages =3D round_up(size, PAGE_SIZE);
> 	try_charge(objcg->memcg, nr_pages);
> 	refill_obj_stock(objcg, size % PAGE_SIZE);

Ok, this will work.

>=20
> > This is fairly small issue in comparison to the first one. But it illus=
trates
> > well the main point: we can't simple get a page from the existing API a=
nd
> > sublease it in parts. The problem is that we need to break the main pri=
nciple
> > that a page belongs to a single memcg.
>=20
> We can change the underlying assumptions of the existing API if they
> are no longer correct. We don't have to invent a parallel stack.

Ok, this makes sense. And thank you for the patch, I'll take it into the se=
t.

Thanks!
