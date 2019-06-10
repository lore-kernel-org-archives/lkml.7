Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E607EC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD421206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bCfuqfpE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="t7Vzpesc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389667AbfFJUiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:38:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42684 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389331AbfFJUiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:38:55 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5AKX4Kd030263;
        Mon, 10 Jun 2019 13:38:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JGOGjmZ/lmwIm39aMbaLlAHbtegJQhM09hnYQ7rrnqE=;
 b=bCfuqfpErmOdyuoVD1zbMMCf8P/9f5/yn5eBDFMj3sHY2JhZuXb1J3pzdFYWe3lDgp3j
 CHjYkBXLQFjhEoWPaLGv3RTbw7N7QvFozrpB6jCn5Dx5ZRRuXptgl7hrWI7IedEdacj/
 6qdx5g2rXUEQGv+dEy0MjccT4hSeUs4oW4Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t1wqbr56e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Jun 2019 13:38:16 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Jun 2019 13:38:16 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Jun 2019 13:38:15 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 10 Jun 2019 13:38:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGOGjmZ/lmwIm39aMbaLlAHbtegJQhM09hnYQ7rrnqE=;
 b=t7VzpescRt0VHHWYheO+bBbEsAZz2pslQ0kjcurnY/YR7AQ2kQndGksihp04xrrxPhHzsKWAbtJEEbhjdzptsMoXVrk59JIQBRdPcqQWeyV7gwNZRnsTY/VTttGi91qQabkJzRXKsq6RfmB7hl1ybtNx4vgTmOHTA31dTJX7EHk=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2770.namprd15.prod.outlook.com (20.179.139.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Mon, 10 Jun 2019 20:38:13 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::251b:ff54:1c67:4e5f]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::251b:ff54:1c67:4e5f%7]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 20:38:13 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 01/10] mm: add missing smp read barrier on getting
 memcg kmem_cache pointer
Thread-Topic: [PATCH v6 01/10] mm: add missing smp read barrier on getting
 memcg kmem_cache pointer
Thread-Index: AQHVG0i1Qy6vvrJhnUaeUsu3v8l0raaTQjIAgAIe1ACAAAE7AA==
Date:   Mon, 10 Jun 2019 20:38:13 +0000
Message-ID: <20190610203805.GA19363@tower.DHCP.thefacebook.com>
References: <20190605024454.1393507-1-guro@fb.com>
 <20190605024454.1393507-2-guro@fb.com>
 <20190609121052.kge3w3hv3t5u5bb3@esperanza>
 <20190610203344.GA7789@cmpxchg.org>
In-Reply-To: <20190610203344.GA7789@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0090.namprd02.prod.outlook.com
 (2603:10b6:301:75::31) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:2dcb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40f27527-8065-440d-03d6-08d6ede38ee0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB2770;
x-ms-traffictypediagnostic: BN8PR15MB2770:
x-microsoft-antispam-prvs: <BN8PR15MB277043023CB40148AE1CC58EBE130@BN8PR15MB2770.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(6436002)(446003)(53936002)(7736002)(66476007)(229853002)(11346002)(6486002)(8676002)(81156014)(81166006)(66446008)(64756008)(66556008)(6916009)(386003)(66946007)(54906003)(9686003)(76176011)(73956011)(6116002)(316002)(6512007)(2906002)(186003)(25786009)(486006)(102836004)(46003)(99286004)(6246003)(6506007)(52116002)(4326008)(305945005)(33656002)(86362001)(1076003)(68736007)(14454004)(476003)(71190400001)(8936002)(71200400001)(5660300002)(14444005)(256004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2770;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6ydWGPaypb7b6dNXsCuiiJ0fUydLlm+v64FbKZyyMIqxmUWC7lv5B4Jxh88wGF8Zy/2a08pB7She5zlnaB6Z68vevnk9YrHXetgGvvDIl0CboHPI1LVIUrKME3TgEI548HZnhD7s0tOHd+kXqh8qlkeP+50iGk8vi3f/eN1GYKz7Fqc+kvOrJng6Fm/9lwLMqwjLPYiafrCDv7QZlPZe9Gv1f8S+wEju4OHPFOReC8KxBy+GTrtmplDR4lY63QIpAtHDGAt526Mk7I3Kjl1XF3Y6DuBumzQEsQn/a5ksOmPNdjnnYEclYphlCTGHC7TzqpR6F33MLGKdfFlu38np+7DksYlRGtsm7Z1riv8qyyVDzeInsUDNwui0O/957YY5gYBxLLoJmqawxlsnYVBRAtPeN2bnNYo1M7Y8xK2O2xA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <841AD1E3E71FE04DAB5DE33BB85DF397@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f27527-8065-440d-03d6-08d6ede38ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 20:38:13.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2770
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906100139
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 04:33:44PM -0400, Johannes Weiner wrote:
> On Sun, Jun 09, 2019 at 03:10:52PM +0300, Vladimir Davydov wrote:
> > On Tue, Jun 04, 2019 at 07:44:45PM -0700, Roman Gushchin wrote:
> > > Johannes noticed that reading the memcg kmem_cache pointer in
> > > cache_from_memcg_idx() is performed using READ_ONCE() macro,
> > > which doesn't implement a SMP barrier, which is required
> > > by the logic.
> > >=20
> > > Add a proper smp_rmb() to be paired with smp_wmb() in
> > > memcg_create_kmem_cache().
> > >=20
> > > The same applies to memcg_create_kmem_cache() itself,
> > > which reads the same value without barriers and READ_ONCE().
> > >=20
> > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > ---
> > >  mm/slab.h        | 1 +
> > >  mm/slab_common.c | 3 ++-
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/mm/slab.h b/mm/slab.h
> > > index 739099af6cbb..1176b61bb8fc 100644
> > > --- a/mm/slab.h
> > > +++ b/mm/slab.h
> > > @@ -260,6 +260,7 @@ cache_from_memcg_idx(struct kmem_cache *s, int id=
x)
> > >  	 * memcg_caches issues a write barrier to match this (see
> > >  	 * memcg_create_kmem_cache()).
> > >  	 */
> > > +	smp_rmb();
> > >  	cachep =3D READ_ONCE(arr->entries[idx]);
> >=20
> > Hmm, we used to have lockless_dereference() here, but it was replaced
> > with READ_ONCE some time ago. The commit message claims that READ_ONCE
> > has an implicit read barrier in it.
>=20
> Thanks for catching this Vladimir. I wasn't aware of this change to
> the memory model. Indeed, we don't need to change anything here.

Cool, I'm dropping this patch.

Thanks!
