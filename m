Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0575C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7427E21D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="XPB4053N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfJCH4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:56:55 -0400
Received: from mail-eopbgr710073.outbound.protection.outlook.com ([40.107.71.73]:28160
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbfJCH4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:56:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoYJ9kmd9s6uWeYaTITaUvOarDQOoQ5COjjBH3nJXBlevtgIWHRZkNiB7hMoXjvsbohoYnIegUFjfvA+QnFhqxTdt6xtbbv0FVHwhpHtCeXPOjLnq9BY8w34dR1gZf2sH4A2J5fyKNclDhWpngHDohHDd7IW6wMlSC79rk5mMT0u02ZQGrZf4M0Or//f1Pu/uOBjWUmsT4VpkgcmxNPO0kULA1Iw+vgSmSFzrSoFkW/QoHXtHdYzooZOM95HiDg5eajBhBQiR2SOcrfxzkxCaTabxGuDDHAOcpIuWRlOhFMrhAbzaUd3Oar+IelVvAgPiE0RpC0Un+bb7dJKj69YyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWaRCeSXXy99RaZ95kXgdBH1RaWS/P6zJ0WvcUZvI2E=;
 b=k8++l8vlGk5zOMbuyXxvbG/XItlu8pGHp1FsMuZuLBqnxlrlA911wYW5dGKNb1XOAJyuOvVoMpABUZ5R6OiQ0sXeWzGvPIaFRIe14fuyoqwq4K8iBDSQk7wAlkezLZIaQErj/ONrZrUmxkdiOg2IKhjTx2azecK50g9M77DkC5fz/RBof9ijDdJbT3+Fm6CIzGpaDJ0Mx1b+h4UwSNRdAgFWwKbg4hWrSz5KUVbMAZIOGrg8egv4Kpe8+OF8zbu1rKYPmLGNz1Snqt94ZD3gWQn3g2N8kw5V8eQLzX/RPQ9AWS4LkV3tn7NoTX+ri7dIhqWXLTs8A2pnGMuwhW02Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWaRCeSXXy99RaZ95kXgdBH1RaWS/P6zJ0WvcUZvI2E=;
 b=XPB4053NnO/JCXNM+C3A0j4TCOBHvqVQjpjP+sTouZYAlODjAsloMSYEdlDenR4iuxsToTyC1QUfwq5OsV9l1rU7n1uGf6g8Om+Nh8tPGOGg/Tho1V9BaKmdbRgfZhc4O+8soapTgl5cOcdD+ikb3GH2TvwEYzXrQZXL+0MsJ4w=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6127.namprd05.prod.outlook.com (20.178.241.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.9; Thu, 3 Oct 2019 07:56:52 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::9861:5501:d72f:d977]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::9861:5501:d72f:d977%2]) with mapi id 15.20.2327.009; Thu, 3 Oct 2019
 07:56:51 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?iso-8859-1?Q?Thomas_Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
CC:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v3 3/7] mm: Add write-protect and clean utilities for
 address space ranges
Thread-Topic: [PATCH v3 3/7] mm: Add write-protect and clean utilities for
 address space ranges
Thread-Index: AQHVeSf+wVOREgWfuEO+p37B0vJRyw==
Date:   Thu, 3 Oct 2019 07:56:51 +0000
Message-ID: <MN2PR05MB61412DB4F703A5EE4F961593A19F0@MN2PR05MB6141.namprd05.prod.outlook.com>
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-4-thomas_os@shipmail.org>
 <CAHk-=wic5vXCxpH-+UTtmH_t-EDBKrKnDhxQk=t_N20aiWnqUg@mail.gmail.com>
 <516814a5-a616-b15e-ac87-26ede681da85@shipmail.org>
 <CAHk-=wgH=T5mcDxTaC6QbBN=iJD3d_amzcb2+GxbcV7XuEYL2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9518e2b-ba4d-42bb-7f9b-08d747d7405f
x-ms-traffictypediagnostic: MN2PR05MB6127:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR05MB6127B0F24935863E05D87C58A19F0@MN2PR05MB6127.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(51444003)(52314003)(4326008)(55016002)(66066001)(446003)(64756008)(66476007)(66946007)(33656002)(66556008)(66446008)(71200400001)(71190400001)(486006)(5660300002)(7696005)(6506007)(102836004)(53546011)(76176011)(52536014)(99286004)(476003)(186003)(76116006)(86362001)(26005)(14454004)(91956017)(2906002)(6116002)(74316002)(3846002)(305945005)(7736002)(7416002)(478600001)(6436002)(966005)(110136005)(6306002)(229853002)(9686003)(8676002)(81156014)(81166006)(25786009)(8936002)(6246003)(256004)(14444005)(54906003)(66574012)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6127;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0vBqiWHNjddzeMo1wrkQUAJnN3anQKDpgwO1rboqTFOIOwgJAtfVZvrXpBBX8hs6+ov9M2gtTTIaZBNrZYyrEbH/IeDd3yKY4eqQ4wZKHaVBISzDLiorMHfO7imMsVAe60BIonG3w8bc4cKjSPqqI7NFq7pPbE69teKqpYGrTNNlYf0j4PiMWy3u/bjnv9VztvYsqr6t6hWOXfJzB0phI2h9UwNF6qUKoOCi9T3VtFnWUqRDATyWYe8ysLxzN2pSoiMlxUxNX7H256Tl++hJt4atJggSXqj9yp1Z71OoAXYMg7S9HikfdxauTpYmdNb3F9hkvi5xdxHvxmV+SArW/PnZcZHwUkeUUogSCdc0N9ZES92eEJ6pVfyHlhnh/b9kK+T7E0uBeB36j8PPYDAzQQavYItqlDdYJeNVB5nrIG7Be3lkSaqOUH3/e/6X7WUcZV1LmYlSGu5kX/0OHfAQ8w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9518e2b-ba4d-42bb-7f9b-08d747d7405f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 07:56:51.7566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGtySjCgxZX3K7SvB0eq9UnMVjycZgtdnjsg5GCnJhSWIEC3lmUHeeVAZDouPYOUCB2ERM5CU0DpMMvRtecHWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/19 10:28 PM, Linus Torvalds wrote:=0A=
> On Wed, Oct 2, 2019 at 12:09 PM Thomas Hellstr=F6m (VMware)=0A=
> <thomas_os@shipmail.org> wrote:=0A=
>> Yes I typically tend towards using a "namespace_object_operation" naming=
=0A=
>> scheme, with "as_dirty" being the namespace here,=0A=
> We discourage that kind of mindless namespacing for core stuff.=0A=
>=0A=
> It makes sense in a driver or a filesystem: when there are 20+=0A=
> different filesystems all implementing the same operation, you can't=0A=
> have descriptive and natural names that are unique. So having a=0A=
> namespace prefix for the filesystem or driver makes sense. But even=0A=
> then it tends ot be just a simple name, not the op it does.=0A=
=0A=
Understood.=0A=
=0A=
>=0A=
>> Looking at Matthew's suggestion but lining up with=0A=
>> "unmap_mapping_range()", perhaps we could use "clean_mapping_range" and=
=0A=
>> "wp_mapping_range"?=0A=
> Yes, I agree with Willy that "dirty" is kind of implicit when the=0A=
> operation is to clean something, so the above sounds sane to me.=0A=
>=0A=
> The wp part I'm not entirely sure about: you're not actually=0A=
> write-protecting the range. You're doing something different. You're=0A=
> only doing it for shared writable mappings.=0A=
=0A=
Both the cleaning operation and the wp operation operate on shared=0A=
writable mappings, and since they are also both restricted to entries=0A=
that may take part in dirty-tracking (they're ignoring pmds and puds),=0A=
so perhaps a "dirty" may make sense anyway, and to point out the similarity=
:=0A=
=0A=
clean_mapping_dirty_range() and wp_mapping_dirty_range()"?=0A=
=0A=
>  And I'd rather see=0A=
> separate 'struct mm_walk_ops' than shared ones that then have a flag=0A=
> in a differfent structure to change behavior.=0A=
>=0A=
> Yes, yes, some of the levels share the same logic, but that just means=0A=
> that you can use the same function pointer for that level in the=0A=
> different "clean" vs "wp" mm_walk_op.=0A=
=0A=
I think that this comment and this last one:=0A=
=0A=
> Also, why do you loop inside the pmd_entry function, instead of just=0A=
> having a pte_entry function?"=0A=
=0A=
are tied together. The pagewalk code is kind of awkward since if you=0A=
provide a pte_entry function,=0A=
then huge pmds are unconditionally split, even if handled in pmd_entry,=0A=
forcing pmd-aware users to handle also ptes in pmd_entry(). I'm not=0A=
entirely sure why, but it looks like it's to avoid a race where huge=0A=
pmds could otherwise be unintentionally split if appearing *after* the=0A=
pmd_entry() call. Other pagewalk users do the same here,  see for=0A=
example clear_refs_pte_range();=0A=
=0A=
https://elixir.bootlin.com/linux/latest/source/fs/proc/task_mmu.c#L1040=0A=
=0A=
Also the pagewalk walk_pte_range() for some reason doesn't take the page=0A=
table lock, which means that a pte may well be cleared under us while we=0A=
have it cached for modification.=0A=
=0A=
For these reasons we can't use the pte_entry, even internally and this=0A=
means we have three choices:=0A=
=0A=
a) Selecting the pte function using a bool. Saves code and avoids extra=0A=
indirect function call.=0A=
b) Duplicating the pmd_entry with a different pte function, also=0A=
duplicating the ops. Avoids extra indirect function call but some extra=0A=
code.=0A=
c) Instead of the bool, use another function pointer in yet another ops=0A=
pointed to by the private structure. Saves some code.=0A=
=0A=
I opted for a) here, but I can of course change that if needed?=0A=
=0A=
>=0A=
> Also, looking closer at this patch, this makes me go "Whaa?":=0A=
>=0A=
> +       pte =3D (mm =3D=3D &init_mm) ?=0A=
> +               pte_offset_kernel(pmd, addr) :=0A=
> +               pte_offset_map_lock(mm, pmd, addr, &ptl);=0A=
>=0A=
> because I don't think that's sensible. When do you have a vma in kernel s=
pace?=0A=
>=0A=
> Also, why do you loop inside the pmd_entry function, instead of just=0A=
> having a pte_entry function?=0A=
=0A=
Yes, that was a blind copy from v1 of the code that used=0A=
"apply_to_page_range()". I'll fix that up.=0A=
=0A=
Thanks,=0A=
=0A=
/Thomas=0A=
=0A=
>=0A=
>            Linus=0A=
>=0A=
=0A=
