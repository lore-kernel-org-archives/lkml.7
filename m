Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2EBC48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B8A2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="L68JUZMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfFTQ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:56:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41932 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfFTQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:56:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id 43so3404647otf.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOYLp6hgueM9IndZ4EN5g0OtG+v2NmbcnIaY4S6F39U=;
        b=L68JUZMsU50kQvIyjv7hYWpW6X5xm6ttiDbx+i1flV2loGovu9oLWT0/Oq0wGyvjeF
         fDEHYCjmDgMEzsqFCqfiwLyn1WQa64ztrAwo98O+v66/orGKTWwb8digBS49x4Pflf0Y
         GwbN3GlvDERuyFfH3JoFUUNtodv7ywBBM2TNpqAPqosJAz3+HCLcKrjjimfxbGpOg1yh
         IhpZaJAeuld4fCSpSEEQG7eW9hIzMlX+fOOfur9Rk2uW98EI4n5HVk+orDvRtVpaeJBG
         tFfo8SvN6kMdSRGx7QadqpWCbafgyp8LgUUrcNOCgoFyaIAfeIsdRck4L783SXqbI9Af
         3HIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOYLp6hgueM9IndZ4EN5g0OtG+v2NmbcnIaY4S6F39U=;
        b=Z4D8CHk1vFml76E1yQ6ofayAF2YjanmcTbr7OGf2FDO+R0RFO81KGVmN9y/y1B5LsB
         rmxE2aLaYOhYXmHaXdEBcfjaUkQkEkjVQRmYKg0yIjUb2N0HQLPpGK/Wta7JqrPVNm7D
         C0ntW2o0L7VstfegFDhQJFevn+NrV/OOQBEi74u1lvEvizZBgpPcTYLhCKwtZGHjURVA
         I8yA1rCRNNgGOVUtGzcKd5AAlCdRN5DXIWj43sn7gYSV4Mp7pwWveWE5P+xMkUfMYFNP
         CEG1ShasDXMcYATQMOLKpKbyftAAOcAJ/eGS40JZ03lNvbAKJT8qtSE19nyJw+UEtSi6
         bUnQ==
X-Gm-Message-State: APjAAAV2Ysc2Dtzcs9sZHNepZqwyQ51x5v7y1oyFGFf61RZQZq90z1YV
        GmTzWrXCg+9QwligQwjlSeRzH/1AKVS6SVRozeI8YA==
X-Google-Smtp-Source: APXvYqz6ECdin+kIXbEiVFPFwyQWlqLQpDqZZas2KQgUhlFbQVpZ8YHHJuT5Ae4Hj9wp2NSwJaLXdBacSsagD2vdyWg=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr200928otn.247.1561049811653;
 Thu, 20 Jun 2019 09:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156092353780.979959.9713046515562743194.stgit@dwillia2-desk3.amr.corp.intel.com>
 <70f3559b-2832-67eb-0715-ed9f856f6ed9@redhat.com> <CAPcyv4jzELzrf-p6ujUwdXN2FRe0WCNhpTziP2-z4-8uBSSp7A@mail.gmail.com>
 <d62e1f2f-70db-da84-5cc3-01fab779aeb7@redhat.com>
In-Reply-To: <d62e1f2f-70db-da84-5cc3-01fab779aeb7@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 Jun 2019 09:56:40 -0700
Message-ID: <CAPcyv4j-XxP_8kWbZpv2z94kDjxTB8RBMYGkKr1WopqsfhqdmA@mail.gmail.com>
Subject: Re: [PATCH v10 08/13] mm/sparsemem: Prepare for sub-section ranges
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 9:37 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 20.06.19 18:19, Dan Williams wrote:
> > On Thu, Jun 20, 2019 at 3:31 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 19.06.19 07:52, Dan Williams wrote:
> >>> Prepare the memory hot-{add,remove} paths for handling sub-section
> >>> ranges by plumbing the starting page frame and number of pages being
> >>> handled through arch_{add,remove}_memory() to
> >>> sparse_{add,remove}_one_section().
> >>>
> >>> This is simply plumbing, small cleanups, and some identifier renames. No
> >>> intended functional changes.
> >>>
> >>> Cc: Michal Hocko <mhocko@suse.com>
> >>> Cc: Vlastimil Babka <vbabka@suse.cz>
> >>> Cc: Logan Gunthorpe <logang@deltatee.com>
> >>> Cc: Oscar Salvador <osalvador@suse.de>
> >>> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> >>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >>> ---
> >>>  include/linux/memory_hotplug.h |    5 +-
> >>>  mm/memory_hotplug.c            |  114 +++++++++++++++++++++++++---------------
> >>>  mm/sparse.c                    |   16 ++----
> >>>  3 files changed, 81 insertions(+), 54 deletions(-)
> > [..]
> >>> @@ -528,31 +556,31 @@ static void __remove_section(struct zone *zone, struct mem_section *ms,
> >>>   * sure that pages are marked reserved and zones are adjust properly by
> >>>   * calling offline_pages().
> >>>   */
> >>> -void __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> >>> +void __remove_pages(struct zone *zone, unsigned long pfn,
> >>>                   unsigned long nr_pages, struct vmem_altmap *altmap)
> >>>  {
> >>> -     unsigned long i;
> >>>       unsigned long map_offset = 0;
> >>> -     int sections_to_remove;
> >>> +     int i, start_sec, end_sec;
> >>
> >> As mentioned in v9, use "unsigned long" for start_sec and end_sec please.
> >
> > Honestly I saw you and Andrew going back and forth about "unsigned
> > long i" that I thought this would be handled by a follow on patchset
> > when that debate settled.
> >
>
> I'll send a fixup then, once this patch set is final - hoping I won't
> forget about it (that's why I asked about using these types in the first
> place).

It's in Andrew's tree now, I'll send an incremental patch.
