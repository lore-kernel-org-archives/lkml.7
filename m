Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D82C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C070521835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="md/XB/SY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfJHSZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:25:21 -0400
Received: from mail-eopbgr770047.outbound.protection.outlook.com ([40.107.77.47]:59971
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbfJHSZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:25:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dG2OQzczg67vsr+7xkt0hbRfG4cj6wXLE5Nbth27lN6HmP1X5GYwDm+DdW/GIzdrSzYP2QBq5KAGQ5/R04IqP1vfEtcGCOlPJb4lM/jonRjZYhoe7QnnCnrKVR+227eIyUVLTBw21Ltmrkjsp5ALvUP3sd3+gGoT+tENW/FTrH66objkhdAHlIIiwE/Hx47vw7pk5mtmqKGosUGF3KK6bmU/ycjhO9mz6dKC+gYgGwFsh4NGwBoBH+DSn0V5BjmWv/1Yti9v0DZKNMfW2NOtD5BirNh6p4rNaEIw790a9E+MTHjM2kciyeCS1KgJQNnIJ9Fg7QanAohEghivjURtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l18p41UB01iWG7b6Ijr3Ia06T32MFbM4oIANR3CO0oU=;
 b=YGiAOlEi7UPGVWl9P09+VXNhFKR7yy4VRxaHSs7M7X27BZyY4+jaIofA3u/sywE7kQDpeVuUmDDKhxbD+u2nZ42+WUYKYXO/9zDQ80cECZqhdGpny2vdprVqFR4sBMJC0cxbatl9ViJ0sWMip7rBt245ADbgeGrLVPWL8VHqYiRD/grIacPvDBrXfsfzXv03hi9dXHQ8iB0renjE2dTzfIltIkBdOeUCRmUHhvlFgml8IL58ktRsSBwbUJ0B2Jixlm+w2u9AQ301De8IK2XYwbBTqCu37+C5QkYr8YOACsNdfSz8JwbihzJIzuH3CgFVflbv1TF8fRWOaKN97Mshuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l18p41UB01iWG7b6Ijr3Ia06T32MFbM4oIANR3CO0oU=;
 b=md/XB/SYe6YNBye4Ogbb5O9HPxUOzzlIw+KrgljHP4vLQQvyU4JVItmyaxZD2YZO15Mkca1rv0hSRIt1/yyTpsNEWuJQZkaTqFJMeoPwR5NF9UcmgsWoEI3HFUrRJhGyn0GJH5n3nHDcRg5yI3ShFoq8DT93dayZDBspsgBxmGk=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6189.namprd05.prod.outlook.com (20.178.243.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 8 Oct 2019 18:25:17 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::286f:c413:5df1:4eb9]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::286f:c413:5df1:4eb9%4]) with mapi id 15.20.2347.014; Tue, 8 Oct 2019
 18:25:17 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?iso-8859-1?Q?Thomas_Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v4 5/9] mm: Add write-protect and clean utilities for
 address space ranges
Thread-Topic: [PATCH v4 5/9] mm: Add write-protect and clean utilities for
 address space ranges
Thread-Index: AQHVfbjyRxqNLTPHjkqs7ZF6N4QmdQ==
Date:   Tue, 8 Oct 2019 18:25:17 +0000
Message-ID: <MN2PR05MB6141AA220CDE585A6BC57C32A19A0@MN2PR05MB6141.namprd05.prod.outlook.com>
References: <20191008091508.2682-1-thomas_os@shipmail.org>
 <20191008091508.2682-6-thomas_os@shipmail.org>
 <CAHk-=wi-7QgG5_gJEGu73xVXUDW-pUwRFDLrkx+VjbY_HzMp9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 371ef6f7-a9c0-4adf-5712-08d74c1cded5
x-ms-traffictypediagnostic: MN2PR05MB6189:
x-microsoft-antispam-prvs: <MN2PR05MB6189988A2B418B9F962B6F80A19A0@MN2PR05MB6189.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(186003)(76176011)(476003)(33656002)(6506007)(229853002)(102836004)(25786009)(52536014)(26005)(81156014)(81166006)(5660300002)(53546011)(7416002)(6436002)(54906003)(446003)(478600001)(55016002)(7696005)(8936002)(110136005)(6246003)(66476007)(9686003)(64756008)(74316002)(71190400001)(14454004)(2906002)(66946007)(71200400001)(76116006)(66446008)(486006)(8676002)(86362001)(3846002)(6116002)(99286004)(7736002)(4326008)(66066001)(305945005)(91956017)(316002)(256004)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6189;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FX7pbXTwX8fey7g4y51Xn3BFVPMaSB88l3KqBYaSFBpHvm5XW/i2C9MYNLUBC/m3XVIQxTKoGfee16qIn+w+JStlQbqWAEIi4MvXEkqXUJKPspogsHtPOisxH33ass8p3sMagSOrBrPjG0NqNjN1Ne/urF60IqhsF7fxtEZj6f0pLfEGLDmi0s/I76rrbD9ahbrKR+vfEBR1ITdug0IyJf9n11vj4Kplhn8+rJb7EwnT10pm/VUlkNbbcwM1EDdacrLokf52KwO+2lsk9EPEPvT1rmNpNF7I/uwFATKK5pGnzxdGIIh/ShYIeFXNOb6qSVIJfcYxO44cdUof1IgBmIgL6rA+N7kmiNhwyo4y8xQbO7DwpaGXVUGbo49FFk5IE26ttxZ/stwXmpBojREDDbZUgsnxM61egkqkKgzedA0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371ef6f7-a9c0-4adf-5712-08d74c1cded5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 18:25:17.5364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIMY+ZML1CbHgzriZgWz38AFAmhaJCHC5JMF5qYji+qXwtZqnQu0tXy1iYl9vXqcwVlewzxgWnHeX+cVd4EMSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/19 7:07 PM, Linus Torvalds wrote:=0A=
> On Tue, Oct 8, 2019 at 2:15 AM Thomas Hellstr=F6m (VMware)=0A=
> <thomas_os@shipmail.org> wrote:=0A=
>> Add two utilities to 1) write-protect and 2) clean all ptes pointing int=
o=0A=
>> a range of an address space.=0A=
> The code looks much simpler and easier to understand now, I think, but=0A=
> that also makes some thing more obvious..=0A=
>=0A=
>> +static int clean_record_pte(pte_t *pte, unsigned long addr,=0A=
>> +                           unsigned long end, struct mm_walk *walk)=0A=
>> +{=0A=
>> +       struct wp_walk *wpwalk =3D walk->private;=0A=
>> +       struct clean_walk *cwalk =3D to_clean_walk(wpwalk);=0A=
>> +       pte_t ptent =3D *pte;=0A=
>> +=0A=
>> +       if (pte_dirty(ptent)) {=0A=
>> +               pgoff_t pgoff =3D ((addr - walk->vma->vm_start) >> PAGE_=
SHIFT) +=0A=
>> +                       walk->vma->vm_pgoff - cwalk->bitmap_pgoff;=0A=
>> +               pte_t old_pte =3D ptep_modify_prot_start(walk->vma, addr=
, pte);=0A=
>> +=0A=
>> +               ptent =3D pte_mkclean(old_pte);=0A=
>> +               ptep_modify_prot_commit(walk->vma, addr, pte, old_pte, p=
tent);=0A=
>> +=0A=
>> +               wpwalk->total++;=0A=
>> +               wpwalk->tlbflush_start =3D min(wpwalk->tlbflush_start, a=
ddr);=0A=
>> +               wpwalk->tlbflush_end =3D max(wpwalk->tlbflush_end,=0A=
>> +                                          addr + PAGE_SIZE);=0A=
>> +=0A=
>> +               __set_bit(pgoff, cwalk->bitmap);=0A=
> The above looks fundamentally racy.=0A=
>=0A=
> You clean the pte in memory, but it remains dirty and writable in the=0A=
> TLB, and you only flush it much later.=0A=
>=0A=
> So now writes can continue to happen to that page, without it=0A=
> necessarily being marked dirty again in the page tables, because all=0A=
> the CPU TLB caches say "it's already dirty".=0A=
>=0A=
> This may be ok - you've moved the diry bit into that bitmap, and you=0A=
> will flush the TLB before then taking action on the bitmap. So you=0A=
> haven't really _lost_ any dirty bits, but it still may be worth a=0A=
> comment.=0A=
>=0A=
> You do have comments about the _other_ issues (ie the whole "If a=0A=
> caller needs to make sure all dirty ptes are picked up and none=0A=
> additional are added..") but you don't actually have comments about=0A=
> the TLB race basically potentially now causing "missing" dirty stuff.=0A=
>=0A=
> And this may actually be a big problem on some architectures. Not x86,=0A=
> and maybe nothing else, but I have this dim memory of some=0A=
> architectures being unhappy due to virtual caches, and writeback when=0A=
> the page table entry says it's read-only and clean.=0A=
>=0A=
> Our normal "clean pages" is very anal about this, and does=0A=
>=0A=
>                         flush_cache_page(vma, address, pte_pfn(*pte));=0A=
>                         entry =3D ptep_clear_flush(vma, address, pte);=0A=
>                         entry =3D pte_wrprotect(entry);=0A=
>                         entry =3D pte_mkclean(entry);=0A=
>                         set_pte_at(vma->vm_mm, address, pte, entry);=0A=
>=0A=
> when it cleans a page, and I note both the cache flush and the=0A=
> "clear_flush()" (which invalidates the pte and does a synchronous TLB=0A=
> flush) and we have magic semantics for that at least on s390 because=0A=
> there are some low-level architecture details wrt flushing TLB entries=0A=
> and modifying them.=0A=
>=0A=
> End result: I think the code is probably ok in practice because you=0A=
> don't mind the slightly fuzzy dirty bit state, and it's _probably_ ok=0A=
> on all architectures that use drm for the TLB invalidation side. But I=0A=
> think it bears a bit of thinking about.=0A=
=0A=
Yes, there's been some considerable thinking behind this. We do have the=0A=
cache flush in the pre_vma callback, and as you mention the TLB flush=0A=
happens before we use the bitmap: any pte that may be subject to a race=0A=
is recorded in the bitmap, and the guarantee we want to provide with the=0A=
function is=0A=
=0A=
a) All ptes that are dirtied before the function starts executing will=0A=
be recorded in the bitmap.=0A=
b) All ptes dirtied after that will either be recorded in the bitmap,=0A=
remain dirty or both.=0A=
=0A=
I probably should add that in the docs.=0A=
=0A=
And the actual writeback happens asynchronously a lot later *should* be=0A=
OK, as long as caches are synced for the dma operation. Of course if=0A=
this somehow fails on a particular architecture I guess we need to=0A=
rethink and use ptep_clear_flush() at least on that architecture.=0A=
=0A=
Thanks,=0A=
Thomas.=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
>=0A=
>               Linus=0A=
>=0A=
=0A=
