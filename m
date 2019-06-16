Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535E7C31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B3120820
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LQ8Jjksf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfFPPmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 11:42:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43014 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfFPPmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 11:42:36 -0400
Received: by mail-oi1-f193.google.com with SMTP id w79so5316092oif.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUNNGKFAqP73eQ+vhxZTGCl7HcRBhNddyWHG8nJUMUI=;
        b=LQ8JjksfqkPqT+AF46Yc03Ej6i8p1rWl1/IVeA7w3nWMjVEJZM5leo0PwrZJmp9Juw
         98lmube2TqS7nKbeNulDuInyvRZ4nnLdljkF61bbMmvpUcvGspoD8rzE0JccY7/bsJdQ
         mqR3NPbUDWb0qbRRzpRStr/hW3YkYGeItzZC8yMruQdUuXGQe5MRt5ZUypkYKYcTVqu5
         VdsHWP2INuUo5oxMOCbePF3tNSNrvuZzG9YGmd+9UnPr01GAvr3drZrffStG1vXLoWnA
         grB8f6fSEPqp4+LiumsBCQJEyT4len2EriwA8MAdla3jvUIL4926+VnZsJChR4/qW+5E
         2uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUNNGKFAqP73eQ+vhxZTGCl7HcRBhNddyWHG8nJUMUI=;
        b=FOR++K8xvsofQcBBoYw9f5rr1sECfuK9W6S5iEx1iVsHevNzf9EgwB3OIzHzSjtQDo
         BVdD97EsGCgabiTmIW/DuK7JLTcOD5VsMTSfKb4i/fW8F5a/bA0gt2arod3WArsKoD7o
         qzYxkfm2kdhES8smbJyswnrOcZskUblPu3NwrQUoYFQz8CvGOMGHPjBKtuEVVl4ldvUa
         mQwao6nYyG6GYSReYRpvPv3fegIrgV2k33SAD6PT+TPrPVt6FzKIZDR8/ImRbp0BtvnO
         /LHrlb9qyso6yBATjsAEtUNXP3k7cQAG8N/D29wJmp42PCtOnaJnlwe9Va83F2KVRWXp
         JFcw==
X-Gm-Message-State: APjAAAWaZO1a9WY+jY1duJla7tZnupYxAcXgH08gFhvTeizJ2LHnaF7i
        qCGq/JhAukCvx51fKQv2638ZurBIra3W+PbdfWdExns5
X-Google-Smtp-Source: APXvYqz5ThqlZvek/o7JX8YjwJYFis1l8vaDPT5C2EIAlKdd8IIFq/qRIv6mpTv47DqSx/ZSvypWcoDwPeSeqggWVXk=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr8120678oii.0.1560699755129;
 Sun, 16 Jun 2019 08:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <1560366952-10660-1-git-send-email-cai@lca.pw> <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
 <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
 <1560376072.5154.6.camel@lca.pw> <87lfy4ilvj.fsf@linux.ibm.com>
 <1560524365.5154.21.camel@lca.pw> <CAPcyv4jAzMzFjSD22VU9Csw+kgGbf8r=XHbdJYzgL_uH_GVEvw@mail.gmail.com>
 <CAPcyv4hjvBPDYKpp2Gns3-cc2AQ0AVS1nLk-K3fwXeRUvvzQLg@mail.gmail.com>
 <1560541220.5154.23.camel@lca.pw> <CAPcyv4i5iUop_H-Ai4q_hn2-3L6aRuovY44tuV50bp1oZj29TQ@mail.gmail.com>
 <1560544982.5154.24.camel@lca.pw>
In-Reply-To: <1560544982.5154.24.camel@lca.pw>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 16 Jun 2019 08:42:22 -0700
Message-ID: <CAPcyv4hyQsAhw35hc4S7hJ2Mh7qwu6ANuh9Bs174okWZZwujgg@mail.gmail.com>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
To:     Qian Cai <cai@lca.pw>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 1:43 PM Qian Cai <cai@lca.pw> wrote:
>
> On Fri, 2019-06-14 at 12:48 -0700, Dan Williams wrote:
> > On Fri, Jun 14, 2019 at 12:40 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > On Fri, 2019-06-14 at 11:57 -0700, Dan Williams wrote:
> > > > On Fri, Jun 14, 2019 at 11:03 AM Dan Williams <dan.j.williams@intel.com>
> > > > wrote:
> > > > >
> > > > > On Fri, Jun 14, 2019 at 7:59 AM Qian Cai <cai@lca.pw> wrote:
> > > > > >
> > > > > > On Fri, 2019-06-14 at 14:28 +0530, Aneesh Kumar K.V wrote:
> > > > > > > Qian Cai <cai@lca.pw> writes:
> > > > > > >
> > > > > > >
> > > > > > > > 1) offline is busted [1]. It looks like test_pages_in_a_zone()
> > > > > > > > missed
> > > > > > > > the
> > > > > > > > same
> > > > > > > > pfn_section_valid() check.
> > > > > > > >
> > > > > > > > 2) powerpc booting is generating endless warnings [2]. In
> > > > > > > > vmemmap_populated() at
> > > > > > > > arch/powerpc/mm/init_64.c, I tried to change PAGES_PER_SECTION to
> > > > > > > > PAGES_PER_SUBSECTION, but it alone seems not enough.
> > > > > > > >
> > > > > > >
> > > > > > > Can you check with this change on ppc64.  I haven't reviewed this
> > > > > > > series
> > > > > > > yet.
> > > > > > > I did limited testing with change . Before merging this I need to go
> > > > > > > through the full series again. The vmemmap poplulate on ppc64 needs
> > > > > > > to
> > > > > > > handle two translation mode (hash and radix). With respect to vmemap
> > > > > > > hash doesn't setup a translation in the linux page table. Hence we
> > > > > > > need
> > > > > > > to make sure we don't try to setup a mapping for a range which is
> > > > > > > arleady convered by an existing mapping.
> > > > > >
> > > > > > It works fine.
> > > > >
> > > > > Strange... it would only change behavior if valid_section() is true
> > > > > when pfn_valid() is not or vice versa. They "should" be identical
> > > > > because subsection-size == section-size on PowerPC, at least with the
> > > > > current definition of SUBSECTION_SHIFT. I suspect maybe
> > > > > free_area_init_nodes() is too late to call subsection_map_init() for
> > > > > PowerPC.
> > > >
> > > > Can you give the attached incremental patch a try? This will break
> > > > support for doing sub-section hot-add in a section that was only
> > > > partially populated early at init, but that can be repaired later in
> > > > the series. First things first, don't regress.
> > > >
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index 874eb22d22e4..520c83aa0fec 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -7286,12 +7286,10 @@ void __init free_area_init_nodes(unsigned long
> > > > *max_zone_pfn)
> > > >
> > > >         /* Print out the early node map */
> > > >         pr_info("Early memory node ranges\n");
> > > > -       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn,
> > > > &nid) {
> > > > +       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn,
> > > > &nid)
> > > >                 pr_info("  node %3d: [mem %#018Lx-%#018Lx]\n", nid,
> > > >                         (u64)start_pfn << PAGE_SHIFT,
> > > >                         ((u64)end_pfn << PAGE_SHIFT) - 1);
> > > > -               subsection_map_init(start_pfn, end_pfn - start_pfn);
> > > > -       }
> > > >
> > > >         /* Initialise every node */
> > > >         mminit_verify_pageflags_layout();
> > > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > > index 0baa2e55cfdd..bca8e6fa72d2 100644
> > > > --- a/mm/sparse.c
> > > > +++ b/mm/sparse.c
> > > > @@ -533,6 +533,7 @@ static void __init sparse_init_nid(int nid,
> > > > unsigned long pnum_begin,
> > > >                 }
> > > >                 check_usemap_section_nr(nid, usage);
> > > >                 sparse_init_one_section(__nr_to_section(pnum), pnum,
> > > > map, usage);
> > > > +               subsection_map_init(section_nr_to_pfn(pnum),
> > > > PAGES_PER_SECTION);
> > > >                 usage = (void *) usage + mem_section_usage_size();
> > > >         }
> > > >         sparse_buffer_fini();
> > >
> > > It works fine except it starts to trigger slab debugging errors during boot.
> > > Not
> > > sure if it is related yet.
> >
> > If you want you can give this branch a try if you suspect something
> > else in -next is triggering the slab warning.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/log/?h=subsect
> > ion-v9
> >
> > It's the original v9 patchset + dependencies backported to v5.2-rc4.
> >
> > I otherwise don't see how subsections would effect slab caches.
>
> It works fine there.

Much appreciated Qian!

Does this change modulate the x86 failures?
