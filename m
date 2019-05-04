Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A337C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E5C2075C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vCaTJVpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEDAWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 20:22:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45634 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfEDAWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 20:22:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id a10so6824973otl.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 17:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2GLzP+mIPWDKsZ2J8CpfXaoOt0+K7Q0KkqhqHG4CQc=;
        b=vCaTJVpfuYZulF2lvGYTlcwKbV4bHIuldvUdxOqs+uH+ZWUG8MHCqU5LYRU4Ii5WsS
         PDEi1Bnr5u7uVLSxwEHBcH9FcPgYoz9Zrqra3zoo3B3CV5rf1+xPBXBNtymFu8jTtI2b
         4t2wu2eKaV7ho3Zf63LxX2I8ETXX16rERV2zGWVqTQO/gyE/IpH1gehvfpn1PuaZ9XQ2
         nmeLDeeeVTfbVR8/sYJ645rjgSmbfdxHU+oB6gDOf5ZuLEJW+SGhXPmQQNsK5GI6X0Ln
         ByAdVXtAjKqekszhk+thuc6BqPOtKacnBhw35lG5RNxfap33IOANS8l1kbF1doUDWmMd
         3bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2GLzP+mIPWDKsZ2J8CpfXaoOt0+K7Q0KkqhqHG4CQc=;
        b=jDqEwoMjdsLvETqTZo00XPDG/8BPOEoz2xf2xhZSWafj+4CsqBdyVcIX8ZODrQqk60
         RU2TOAqjxNYbgtqX5yafNWHV2OdLSlLz29R0i9HuMc+qiqpFu8AMscN3WxSwoPjOmQ/n
         kWe0tFA8WYI9WoBrAhL/BjjTAmzGqDQTbyR3693yQbSwiyAvWHol44pW0CJ/wXsieBaP
         Lrok6P9hlCzRMkRyU9HfyTpf47+mz9HiMxOLBQzT00p2w3VrK9pl4NFUckv9OlSzbqY4
         Ujsd0ezo56OvAxtCGz1WJu8SlfwQPiOrZYtlfel6U6kFcqIa37lHkBWVrnfr8T/drOZ9
         qL6Q==
X-Gm-Message-State: APjAAAWZnM0TNERoWT2bEbK3Xaa3v27NEZUJa9hAeMGSv+xh4OZwhmHn
        5OnZsqNycC4JD85fKEyX7GkCz6Mgg+ggNkgyH4Nj74pr
X-Google-Smtp-Source: APXvYqxdVipoa5z31EifFG5ifrC68H+QnObLfr0ceemkguKFFrj+suFsJQfhR6Tx4LZgszvoXiMNhHCc5XuKsKhoJxk=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr6880612oti.229.1556929354326;
 Fri, 03 May 2019 17:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634075.2015392.3371070426600230054.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190501232517.crbmgcuk7u4gvujr@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAPcyv4hxy86gWN3ncTQmHi8DT31k8YzsweMfGHgCh=sORMQQcg@mail.gmail.com>
In-Reply-To: <CAPcyv4hxy86gWN3ncTQmHi8DT31k8YzsweMfGHgCh=sORMQQcg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 May 2019 17:22:23 -0700
Message-ID: <CAPcyv4hAh-Joe3Pt0r5CPSaWpZ4YoNF2jNDcvbMF2fsQm7Hetg@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] mm/sparsemem: Introduce struct mem_section_usage
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 11:07 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, May 1, 2019 at 4:25 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > On 19-04-17 11:39:00, Dan Williams wrote:
> > > Towards enabling memory hotplug to track partial population of a
> > > section, introduce 'struct mem_section_usage'.
> > >
> > > A pointer to a 'struct mem_section_usage' instance replaces the existing
> > > pointer to a 'pageblock_flags' bitmap. Effectively it adds one more
> > > 'unsigned long' beyond the 'pageblock_flags' (usemap) allocation to
> > > house a new 'map_active' bitmap.  The new bitmap enables the memory
> > > hot{plug,remove} implementation to act on incremental sub-divisions of a
> > > section.
> > >
> > > The primary motivation for this functionality is to support platforms
> > > that mix "System RAM" and "Persistent Memory" within a single section,
> > > or multiple PMEM ranges with different mapping lifetimes within a single
> > > section. The section restriction for hotplug has caused an ongoing saga
> > > of hacks and bugs for devm_memremap_pages() users.
> > >
> > > Beyond the fixups to teach existing paths how to retrieve the 'usemap'
> > > from a section, and updates to usemap allocation path, there are no
> > > expected behavior changes.
> > >
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Logan Gunthorpe <logang@deltatee.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  include/linux/mmzone.h |   23 ++++++++++++--
> > >  mm/memory_hotplug.c    |   18 ++++++-----
> > >  mm/page_alloc.c        |    2 +
> > >  mm/sparse.c            |   81 ++++++++++++++++++++++++------------------------
> > >  4 files changed, 71 insertions(+), 53 deletions(-)
> > >
> > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > index 70394cabaf4e..f0bbd85dc19a 100644
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -1160,6 +1160,19 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
> > >  #define SECTION_ALIGN_UP(pfn)        (((pfn) + PAGES_PER_SECTION - 1) & PAGE_SECTION_MASK)
> > >  #define SECTION_ALIGN_DOWN(pfn)      ((pfn) & PAGE_SECTION_MASK)
> > >
> > > +#define SECTION_ACTIVE_SIZE ((1UL << SECTION_SIZE_BITS) / BITS_PER_LONG)
> > > +#define SECTION_ACTIVE_MASK (~(SECTION_ACTIVE_SIZE - 1))
> > > +
> > > +struct mem_section_usage {
> > > +     /*
> > > +      * SECTION_ACTIVE_SIZE portions of the section that are populated in
> > > +      * the memmap
> > > +      */
> > > +     unsigned long map_active;
> >
> > I think this should be proportional to section_size / subsection_size.
> > For example, on intel section size = 128M, and subsection is 2M, so
> > 64bits work nicely. But, on arm64 section size if 1G, so subsection is
> > 16M.
> >
> > On the other hand 16M is already much better than what we have: with 1G
> > section size and 2M pmem alignment we guaranteed to loose 1022M. And
> > with 16M subsection it is only 14M.
>
> I'm ok with it being 16M for now unless it causes a problem in
> practice, i.e. something like the minimum hardware mapping alignment
> for physical memory being less than 16M.

On second thought, arbitrary differences across architectures is a bit
sad. The most common nvdimm namespace alignment granularity is
PMD_SIZE, so perhaps the default sub-section size should try to match
that default.
