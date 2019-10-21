Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69941CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AB6205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="q+7Gxexo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfJUMYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:24:51 -0400
Received: from mail-eopbgr710040.outbound.protection.outlook.com ([40.107.71.40]:59132
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727256AbfJUMYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:24:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXmebEJZj3jQlMqJ7vfcWLH3NijuHrow4zC+J93ZEV/v1jtWkagcUFtCvM3hy+gab4eV479CpRrSxKYUmymDvBf2iqYlYb1obbkmBlQIMKWclpqbiyfV5cKxqOJf7GRdG8S69RphnPCdkeu1lDKW84mwz1hbTzTnK8QaheRXwVOucFnQ2qh+8cRiDwFAXqQS+wk/WtffIHLNseM7v+cr9IudtelBihBngkdHKIGYDm1R9KAyXaUlndpvYZ6wRMbtSsfmwkxEINpxitQMnEWUqKNhUnT9JzoUi7D/MOoXDd02ZD6HY1VKPIPL3OrdV35Bj4zae/L/VotXCtFj+HdmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gHffyfXT4YHeH3SDQLnb1ZC+E0t1uBYJo0Fz+Nk3V0=;
 b=bee74GfpHN+QtxXGFsIRd3cajfdMDoWv6fwKvjaTNaZoqqNSEVCwMhqpkYCKEorF1jGBLgYeQbG6EOKktc+B3QuDVqcOiBvQyjUMb2JQeQsmG5tCz3rxeIYN84wX032AsgXbVA+JiFfptITxfXTHfJOlL/Tph+n1r6IU0zInZfVL/w9UvfSa/zfkibwq3OXlXZ+aHWcBOtT1uCTvWrhLsYUDHrWD4XSIItduQS7N6WaEAnN1o4tK43OjEPxl7Ckx2KwioN0dcuvzAGtX6kB4R2pgR+wxAqxyUB0bpAgdnwUBY76JG+fBZoBKuqdWCLdEynB8MB12APDveXBYB7IuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gHffyfXT4YHeH3SDQLnb1ZC+E0t1uBYJo0Fz+Nk3V0=;
 b=q+7Gxexo3ubVgfiV2yPr4BeA8vCLK84azBpzU1ErSBNDJApq2iRpAc4C85988dAHs8448x0PraXViEzBq3LtdtCVZb7s4zNDmyybdY4we6G0Pwr1IJq6kMWRy2JChvQ+GJ1c0vr/GE0sU9iHVVqlYLB4pOHUp2K6BfFlXIv1wy4=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB7024.namprd05.prod.outlook.com (52.135.37.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.14; Mon, 21 Oct 2019 12:24:45 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::286f:c413:5df1:4eb9]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::286f:c413:5df1:4eb9%4]) with mapi id 15.20.2367.017; Mon, 21 Oct 2019
 12:24:45 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     =?iso-8859-1?Q?Thomas_Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH v6 0/8] Emulated coherent graphics memory take 2
Thread-Topic: [PATCH v6 0/8] Emulated coherent graphics memory take 2
Thread-Index: AQHVgpJqC8shh+REck6Kwu9Se+Blog==
Date:   Mon, 21 Oct 2019 12:24:45 +0000
Message-ID: <MN2PR05MB61414127631EA073C0757B78A1690@MN2PR05MB6141.namprd05.prod.outlook.com>
References: <20191014132204.7721-1-thomas_os@shipmail.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2264430e-bced-48d0-30b2-08d75621a89f
x-ms-traffictypediagnostic: MN2PR05MB7024:
x-microsoft-antispam-prvs: <MN2PR05MB702491D20A9CF15B51D63D94A1690@MN2PR05MB7024.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(189003)(199004)(8936002)(8676002)(9686003)(256004)(478600001)(14444005)(33656002)(53546011)(6506007)(26005)(102836004)(76176011)(7696005)(25786009)(71190400001)(71200400001)(2201001)(91956017)(81166006)(81156014)(99286004)(110136005)(76116006)(54906003)(66446008)(64756008)(66556008)(66946007)(66476007)(55016002)(316002)(14454004)(186003)(7416002)(305945005)(446003)(6246003)(2501003)(5660300002)(229853002)(476003)(486006)(86362001)(66066001)(6436002)(7736002)(4326008)(2906002)(52536014)(6116002)(74316002)(66574012)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB7024;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bC6c7TR58WDhwoINCOTGC8B67I/A4KgyxFh4D9N2gEWT3c0IX08jkyvv0nrJW+o6v9jkWL/SIIRs2XGL95pTBvhq5ne2jArKOci5ZZ+DoblZYrKcx8ZUqqRMmtLgyo4vRErGbJe6fHVik6zpicvTNuDDCXm9NcFBKqq3ZRAlRokSx8LN89ur+1VTGmKy37zGkF5JGbijuu6IbON4bsPdOaoVi6j0qTzzPrUnb2J93ZzD5LuFWj2nkiaLQEbvguuBX8/uGvRoow7Tbr7EqZFHYWug64IK6LABST9bzNhYGKp/PdJNsctOO1+h0Iv9cjVATLAywQqR2wFewZqwAQJNbR9dckz7C8r7RrFWR4bmqyr8i97iX7I0djrPyEVqyNBBOV3u4fQtrd/116V/hLy4mJDEUEOJ2VJdIEh7ySrDUOonlRnrEA2rk2wMO7GEbHgX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2264430e-bced-48d0-30b2-08d75621a89f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 12:24:45.7559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FD4+7LFUv4lYECDgHgFpuH23YIwGJtHyt7rYjLJVYQsiBe0SvFas57u/439jcI4jWdGvjxMlJoy8iy9Jwo18wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/19 3:22 PM, Thomas Hellstr=F6m (VMware) wrote:=0A=
> From: Thomas Hellstr=F6m <thellstrom@vmware.com>=0A=
>=0A=
> Graphics APIs like OpenGL 4.4 and Vulkan require the graphics driver=0A=
> to provide coherent graphics memory, meaning that the GPU sees any=0A=
> content written to the coherent memory on the next GPU operation that=0A=
> touches that memory, and the CPU sees any content written by the GPU=0A=
> to that memory immediately after any fence object trailing the GPU=0A=
> operation is signaled.=0A=
>=0A=
> Paravirtual drivers that otherwise require explicit synchronization=0A=
> needs to do this by hooking up dirty tracking to pagefault handlers=0A=
> and buffer object validation.=0A=
>=0A=
> Provide mm helpers needed for this and that also allow for huge pmd-=0A=
> and pud entries (patch 1-3), and the associated vmwgfx code (patch 4-7).=
=0A=
>=0A=
> The code has been tested and exercised by a tailored version of mesa=0A=
> where we disable all explicit synchronization and assume graphics memory=
=0A=
> is coherent. The performance loss varies of course; a typical number is=
=0A=
> around 5%.=0A=
>=0A=
> I would like to merge this code through the DRM tree, so an ack to includ=
e=0A=
> the new mm helpers in that merge would be greatly appreciated.=0A=
>=0A=
> Changes since RFC:=0A=
> - Merge conflict changes moved to the correct patch. Fixes intra-patchset=
=0A=
>   compile errors.=0A=
> - Be more aggressive when turning ttm vm code into helpers. This makes su=
re=0A=
>   we can use a const qualifier on the vmwgfx vm_ops.=0A=
> - Reinstate a lost comment an fix an error path that was broken when turn=
ing=0A=
>   the ttm vm code into helpers.=0A=
> - Remove explicit type-casts of struct vm_area_struct::vm_private_data=0A=
> - Clarify the locking inversion that makes us not being able to use the m=
m=0A=
>   pagewalk code.=0A=
>=0A=
> Changes since v1:=0A=
> - Removed the vmwgfx maintainer entry for as_dirty_helpers.c, updated=0A=
>   commit message accordingly=0A=
> - Removed the TTM patches from the series as they are merged separately=
=0A=
>   through DRM.=0A=
> Changes since v2:=0A=
> - Split out the pagewalk code from as_dirty_helpers.c and document lockin=
g.=0A=
> - Add pre_vma and post_vma callbacks to the pagewalk code.=0A=
> - Remove huge pmd and -pud asserts that would trip when we protect vmas w=
ith=0A=
>   struct address_space::i_mmap_rwsem rather than with=0A=
>   struct vm_area_struct::mmap_sem.=0A=
> - Do some naming cleanup in as_dirty_helpers.c=0A=
> Changes since v3:=0A=
> - Extensive renaming of the dirty helpers including the filename.=0A=
> - Update walk_page_mapping() doc.=0A=
> - Update the pagewalk code to not unconditionally split pmds if a pte_ent=
ry()=0A=
>   callback is present. Update the dirty helper pmd_entry accordingly.=0A=
> - Use separate walk ops for the dirty helpers.=0A=
> - Update the pagewalk code to take the pagetable lock in walk_pte_range.=
=0A=
> Changes since v4:=0A=
> - Fix pte pointer confusion in patch 2/8=0A=
> - Skip the pagewalk code conditional split patch for now, and update the=
=0A=
>   mapping_dirty_helper accordingly. That problem will be solved in a clea=
ner=0A=
>   way in a follow-up patchset.=0A=
> Changes since v5:=0A=
> - Fix tlb flushing when we have other pending tlb flushes.=0A=
>   =0A=
> Cc: Andrew Morton <akpm@linux-foundation.org>=0A=
> Cc: Matthew Wilcox <willy@infradead.org>=0A=
> Cc: Will Deacon <will.deacon@arm.com>=0A=
> Cc: Peter Zijlstra <peterz@infradead.org>=0A=
> Cc: Rik van Riel <riel@surriel.com>=0A=
> Cc: Minchan Kim <minchan@kernel.org>=0A=
> Cc: Michal Hocko <mhocko@suse.com>=0A=
> Cc: Huang Ying <ying.huang@intel.com>=0A=
> Cc: J=E9r=F4me Glisse <jglisse@redhat.com>=0A=
> Cc: Kirill A. Shutemov <kirill@shutemov.name>=0A=
>=0A=
Kirill, Linus=0A=
=0A=
I have a formal Ack for two of the four mm patches. Is there a chance I=0A=
can get an ack to merge the mm patches of this series through drm with=0A=
the vmwgfx patches?=0A=
=0A=
Thanks,=0A=
=0A=
Thomas=0A=
=0A=
=0A=
