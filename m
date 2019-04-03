Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C342FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D928205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qdD/W0cl";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="f47Ea+X7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDCVtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:49:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33230 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbfDCVs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:48:59 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33LNEXd027707;
        Wed, 3 Apr 2019 14:24:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BoepgHmhCBIDcbfbKFyCP0TuDUaVhSaVSHYj9hjOBk4=;
 b=qdD/W0clzPYp5ECevJeMMMcC4eeFdKQzlpcYK+DiTxBRo9Ggxga/vaSIJ7rXzhhlByyz
 X5oAsbBpmpzB/XdFEVmvUXD/hTZCmAj13fTXJ4q6PhTaADNcMkMYovyB1oz9gAmuaDLa
 wk7Myb6eJk2kcjJ9OhHlY6AflzmHYwGlqR4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rn475g3jt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Apr 2019 14:24:01 -0700
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 14:23:30 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 3 Apr 2019 14:23:30 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Apr 2019 14:23:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoepgHmhCBIDcbfbKFyCP0TuDUaVhSaVSHYj9hjOBk4=;
 b=f47Ea+X7JTxn+aSXn05ViBlkWdfPC/2I7wwN7NnDL/6JWEilkkTl9ughLAUx4fNx2/GLc/jpGIOltD9H0SPtvL9qATKZ4soRPCUA2rvCKMo1baceARLOctBs9feoMbp5+vA7RnGmYyAW/ahnTIHcBsz+4tIGyh0GYbqW/nhcC48=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2805.namprd15.prod.outlook.com (20.179.158.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Wed, 3 Apr 2019 21:23:28 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 21:23:28 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Tobin C. Harding" <me@tobin.cc>
CC:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] slob: Respect list_head abstraction layer
Thread-Topic: [PATCH v5 2/7] slob: Respect list_head abstraction layer
Thread-Index: AQHU6ajAyy6khhqQC0Sp/NoP4ahiCKYqRZAAgACoe4CAAAWTAA==
Date:   Wed, 3 Apr 2019 21:23:28 +0000
Message-ID: <20190403212322.GA5116@tower.DHCP.thefacebook.com>
References: <20190402230545.2929-1-tobin@kernel.org>
 <20190402230545.2929-3-tobin@kernel.org>
 <20190403180026.GC6778@tower.DHCP.thefacebook.com>
 <20190403210327.GB23288@eros.localdomain>
In-Reply-To: <20190403210327.GB23288@eros.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0010.namprd19.prod.outlook.com
 (2603:10b6:300:d4::20) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:9220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4d6633c-68fa-4060-d3f4-08d6b87a9d24
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2805;
x-ms-traffictypediagnostic: BYAPR15MB2805:
x-microsoft-antispam-prvs: <BYAPR15MB2805ACE7980B6246FDA7AE23BE570@BYAPR15MB2805.namprd15.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(486006)(305945005)(93886005)(6512007)(316002)(7416002)(476003)(11346002)(68736007)(54906003)(446003)(8936002)(229853002)(86362001)(9686003)(6506007)(6486002)(6246003)(25786009)(4326008)(386003)(6436002)(102836004)(478600001)(76176011)(1076003)(256004)(99286004)(186003)(105586002)(46003)(71190400001)(53936002)(52116002)(106356001)(97736004)(71200400001)(33656002)(14454004)(5660300002)(8676002)(2906002)(81166006)(81156014)(14444005)(6116002)(7736002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2805;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qHBKP/B5q1eni+bS2q1Y5HoohqKElv9bU3+GpoY6S6ZLqjeTXGopZR44eUxoonw5ljMSYcLpVjLzBMNYbOVKzIWe7N63yrtva2D4lcLk7VOBdmDgC38Rt6Wg9S9V2qPd8dM0t2TOMKC7DTVRH85FPPPiD+WqB+6BdjvGYPJ/Lj7C/bYj/oxwo87D/6wluNRXWodDwnA7tPduikLBE2FTfHuGq7PFJPK0E97Ps6wvDEnWHhDi4UCw9+DBx0i5BEJTFLpvbHSD2YdltkfFF5jUPK7iYbl7OK9tfXJ/vibn4I+xGR/8m4G2tpWQ7eYrc2fd+G+jd1KiSHyzk9Jrk+G8fhfVDnv6Eu44N5byS/Ak7yOF4pnE7Pn2xfXRMWkOSBJ4LNqrQXecHJFBPg49kDYdnml7D5CoIuGARwOJUz12ERM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8430EC8008007841B1D6BEAE51EF5F20@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d6633c-68fa-4060-d3f4-08d6b87a9d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 21:23:28.4293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2805
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 08:03:27AM +1100, Tobin C. Harding wrote:
> On Wed, Apr 03, 2019 at 06:00:30PM +0000, Roman Gushchin wrote:
> > On Wed, Apr 03, 2019 at 10:05:40AM +1100, Tobin C. Harding wrote:
> > > Currently we reach inside the list_head.  This is a violation of the
> > > layer of abstraction provided by the list_head.  It makes the code
> > > fragile.  More importantly it makes the code wicked hard to understan=
d.
> > >=20
> > > The code reaches into the list_head structure to counteract the fact
> > > that the list _may_ have been changed during slob_page_alloc().  Inst=
ead
> > > of this we can add a return parameter to slob_page_alloc() to signal
> > > that the list was modified (list_del() called with page->lru to remov=
e
> > > page from the freelist).
> > >=20
> > > This code is concerned with an optimisation that counters the tendenc=
y
> > > for first fit allocation algorithm to fragment memory into many small
> > > chunks at the front of the memory pool.  Since the page is only remov=
ed
> > > from the list when an allocation uses _all_ the remaining memory in t=
he
> > > page then in this special case fragmentation does not occur and we
> > > therefore do not need the optimisation.
> > >=20
> > > Add a return parameter to slob_page_alloc() to signal that the
> > > allocation used up the whole page and that the page was removed from =
the
> > > free list.  After calling slob_page_alloc() check the return value ju=
st
> > > added and only attempt optimisation if the page is still on the list.
> > >=20
> > > Use list_head API instead of reaching into the list_head structure to
> > > check if sp is at the front of the list.
> > >=20
> > > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > > ---
> > >  mm/slob.c | 51 +++++++++++++++++++++++++++++++++++++--------------
> > >  1 file changed, 37 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/mm/slob.c b/mm/slob.c
> > > index 307c2c9feb44..07356e9feaaa 100644
> > > --- a/mm/slob.c
> > > +++ b/mm/slob.c
> > > @@ -213,13 +213,26 @@ static void slob_free_pages(void *b, int order)
> > >  }
> > > =20
> > >  /*
> > > - * Allocate a slob block within a given slob_page sp.
> > > + * slob_page_alloc() - Allocate a slob block within a given slob_pag=
e sp.
> > > + * @sp: Page to look in.
> > > + * @size: Size of the allocation.
> > > + * @align: Allocation alignment.
> > > + * @page_removed_from_list: Return parameter.
> > > + *
> > > + * Tries to find a chunk of memory at least @size bytes big within @=
page.
> > > + *
> > > + * Return: Pointer to memory if allocated, %NULL otherwise.  If the
> > > + *         allocation fills up @page then the page is removed from t=
he
> > > + *         freelist, in this case @page_removed_from_list will be se=
t to
> > > + *         true (set to false otherwise).
> > >   */
> > > -static void *slob_page_alloc(struct page *sp, size_t size, int align=
)
> > > +static void *slob_page_alloc(struct page *sp, size_t size, int align=
,
> > > +			     bool *page_removed_from_list)
> >=20
> > Hi Tobin!
> >=20
> > Isn't it better to make slob_page_alloc() return a bool value?
> > Then it's easier to ignore the returned value, no need to introduce "_u=
nused".
>=20
> We need a pointer to the memory allocated also so AFAICS its either a
> return parameter for the memory pointer or a return parameter to
> indicate the boolean value?  Open to any other ideas I'm missing.
>=20
> In a previous crack at this I used a double pointer to the page struct
> then set that to null to indicate the boolean value.  I think the
> explicit boolean parameter is cleaner.

Yeah, sorry, it's my fault. Please, ignore this comment.
Bool* argument is perfectly fine here.

Thanks!
