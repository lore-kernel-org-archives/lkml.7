Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0646BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C0D20643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="O0/YsIB8";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VOx+HOyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403824AbfDRSZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:25:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41770 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390542AbfDRSFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:05:50 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3II2k0x023828;
        Thu, 18 Apr 2019 11:05:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rtCtANNIr/1Sg2LyrELfXsaYNGiy8l+IvutL0qSsLpo=;
 b=O0/YsIB8j91b1QurTeZgnLlicpJGnVJXlvJugK/y8TXFPMUjohT1kDv0NGBAgn/hoSvc
 XICPATH/F7VuzdxZqrkPtiOqVF6cbKE3zvhoW5BXodgEX9O3534MiXaNOW8yX5gR5JqW
 AsLG3bGpNXMYDpfGYTJIYZxVUdrlxRG5pMk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rxw16g9wt-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Apr 2019 11:05:38 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 18 Apr 2019 11:05:17 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 18 Apr 2019 11:05:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtCtANNIr/1Sg2LyrELfXsaYNGiy8l+IvutL0qSsLpo=;
 b=VOx+HOyQmIGnolCFHmc3EzyBHJJzE8LJrkbHw4yginIAfGOFYeyL7L8WrSsnTQD/4LvHWpsYkvjFWRkFRgw3qg0vcuItYN126ylK2QUMm2hM89DwEQFQg6wzfLuKw0aeSrp/IQ6jO9BDPtmv+gKvubSRedRTf8ulqWC4lH4NYqw=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2598.namprd15.prod.outlook.com (20.179.155.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 18:05:15 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1792.021; Thu, 18 Apr 2019
 18:05:15 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Roman Gushchin <guroan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 4/5] mm: rework non-root kmem_cache lifecycle management
Thread-Topic: [PATCH 4/5] mm: rework non-root kmem_cache lifecycle management
Thread-Index: AQHU9WhFLwAo90XwHUSqs2s91sh5hqZB7UQAgABKcoA=
Date:   Thu, 18 Apr 2019 18:05:15 +0000
Message-ID: <20190418180510.GB11008@tower.DHCP.thefacebook.com>
References: <20190417215434.25897-1-guro@fb.com>
 <20190417215434.25897-5-guro@fb.com>
 <0100016a30abc330-011d895a-b4af-40a9-8937-990297ed4ffd-000000@email.amazonses.com>
In-Reply-To: <0100016a30abc330-011d895a-b4af-40a9-8937-990297ed4ffd-000000@email.amazonses.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:104:4::29) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:497d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 777f9bff-4800-41cc-5f1d-08d6c4286875
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2598;
x-ms-traffictypediagnostic: BYAPR15MB2598:
x-microsoft-antispam-prvs: <BYAPR15MB259809DD1EA4E08AFBB83759BE260@BYAPR15MB2598.namprd15.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(396003)(376002)(39860400002)(189003)(199004)(81156014)(7416002)(14454004)(316002)(54906003)(46003)(86362001)(186003)(11346002)(476003)(52116002)(446003)(99286004)(76176011)(6506007)(386003)(486006)(6512007)(9686003)(97736004)(53936002)(6246003)(5660300002)(102836004)(25786009)(1076003)(305945005)(6436002)(7736002)(4326008)(68736007)(256004)(6916009)(229853002)(6486002)(14444005)(478600001)(6116002)(81166006)(2906002)(33656002)(8936002)(71190400001)(8676002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2598;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JsG2fqPU9+8weaogw384QR1J7UewN1JOffdKIjR6XGZAqchFobnxSfFdKtcRHrhUzZgxBnaI10KNlrJ2o5NFRfoZwkwVie6Yn0JYmpEtywcaYLwgxur2XsuJShYziZDh7ZPhZ+jvbsJjKerx12o/8m2cOCcYXTygXdzPaU/dr2QjE+Bw7p5SyPgMNfOcQBArcs/pyshbOMFPa+XD3hjBxyDjiexcvtv98vhEq5N7TM094h+IfQyU4z3mA8tA8SoKjMQ11ZPRug4SrejQBTMRKnOH0Gn8kpnzlHafUhrD1qXgWRi90e6eJ4cdyYF129pcJ5fnu23heQ24KyplVLmQB2ixj6Lc7GW6UgQHT9WHvZr5aQw2uAoRuPqfHq2f/QCYvB1N7+UpmwTSuphtUjVq3CNErkPqrT0ndxv2Q3tbAdE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B63A3F64D484F84F9EBD4788F5ACDCFA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 777f9bff-4800-41cc-5f1d-08d6c4286875
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 18:05:15.2184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2598
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 01:38:44PM +0000, Christopher Lameter wrote:
> On Wed, 17 Apr 2019, Roman Gushchin wrote:
>=20
> >  static __always_inline int memcg_charge_slab(struct page *page,
> >  					     gfp_t gfp, int order,
> >  					     struct kmem_cache *s)
> >  {
> > -	if (is_root_cache(s))
> > +	int idx =3D (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> > +		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE;
> > +	struct mem_cgroup *memcg;
> > +	struct lruvec *lruvec;
> > +	int ret;
> > +
> > +	if (is_root_cache(s)) {
> > +		mod_node_page_state(page_pgdat(page), idx, 1 << order);
>=20
> Hmmm... This is functionality that is not memcg specific being moved into
> a memcg function??? Maybe rename the function to indicate that it is not
> memcg specific and add the proper #ifdefs?
>=20
> >  static __always_inline void memcg_uncharge_slab(struct page *page, int=
 order,
> >  						struct kmem_cache *s)
> >  {
> > -	memcg_kmem_uncharge(page, order);
> > +	int idx =3D (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> > +		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE;
> > +	struct mem_cgroup *memcg;
> > +	struct lruvec *lruvec;
> > +
> > +	if (is_root_cache(s)) {
> > +		mod_node_page_state(page_pgdat(page), idx, -(1 << order));
> > +		return;
> > +	}
>=20
> And again.
>=20

Good point! Will do in v2.

Thanks!
