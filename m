Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E482BC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1212084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="TyqKBNvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfFTQT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:19:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35200 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFTQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:19:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id a127so2599416oii.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuGyF1gaAxnc5NCYYEX6kiZekDv13zqB0UQA2n5aQis=;
        b=TyqKBNvBRHg2N7hM9S8c6U4FOJz5mxm6Kd+KBEMqs2GVrceDbu2B5Yv+Tpqg9S34ys
         MaHgCO6/ySGOZphnnrTbgImRuL2QMVoCGG2VWkmL5W3Uon95vGsNjpaeOGPEgMJOT3L9
         5WEJx442dDZs/YbNnY0UQilkmAx8XpdOKM4CFfFFAge3HyxFPgiIP95x0HYvSNAaMKy6
         1mXvvW5okLy4jiD7hQSkY3gSwkQy7MxiqZoOpVEppM+LOHSdZJYPl7dVTiAul4GD3HrH
         y9JAaW9RA4lNlRmSX3HsfKvWxmHRadsFz/qNFrGo4+gaTh+E4u2Ot15NvBhXkJk5Bz/Z
         edQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuGyF1gaAxnc5NCYYEX6kiZekDv13zqB0UQA2n5aQis=;
        b=PY//0PTB7dcltu+zgXrH3xBI815O+UmEH8Ywyho9kYQ0NAS7Fd2AyJ/4Mc+q5u80f+
         F6jjlmK9UISt2JsLOKQ109XDV/k/1BbEPCqn3pPAcvt0sb5XWIjQKZgvHKpoop0J8SCn
         PAtNQdDyCL5z8J2Y2FtRjg+11wq6TImROrWScUPntE7zCtLNWHuXZV4qpdC5LPZOQser
         WG0AEJyURtwOwCvBbHPV9/cJE9VdUNUILYKPsE0+2rPB9kIa7giDeJTuUPufSiAxnG7D
         4i4ktPQ4xpvHgsxyk1DcLrVuE1Q5qhyS+lgSi9tdaMsFdJ4ewPjfzwR4XxjEE+Rhv7Vf
         TamA==
X-Gm-Message-State: APjAAAXgn91NWjDXzQxM/g58H+YLcrMUYH0Rn/rpKZALtRJqKGwIoFiq
        ffPQ8zJIwJ7xDegNI4EpAhhwxaRYiEHxTV4Ddfd5PA==
X-Google-Smtp-Source: APXvYqycTrfFCdUGQlxbLBM8sq/vvF4AR0qE564N7NnNzy2gB1lQelj0Er/vC+yiQUqqVAU2Tj/69BOUevu0+1dRykA=
X-Received: by 2002:aca:d60c:: with SMTP id n12mr4630027oig.105.1561047595403;
 Thu, 20 Jun 2019 09:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156092353780.979959.9713046515562743194.stgit@dwillia2-desk3.amr.corp.intel.com>
 <70f3559b-2832-67eb-0715-ed9f856f6ed9@redhat.com>
In-Reply-To: <70f3559b-2832-67eb-0715-ed9f856f6ed9@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 Jun 2019 09:19:43 -0700
Message-ID: <CAPcyv4jzELzrf-p6ujUwdXN2FRe0WCNhpTziP2-z4-8uBSSp7A@mail.gmail.com>
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

On Thu, Jun 20, 2019 at 3:31 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 19.06.19 07:52, Dan Williams wrote:
> > Prepare the memory hot-{add,remove} paths for handling sub-section
> > ranges by plumbing the starting page frame and number of pages being
> > handled through arch_{add,remove}_memory() to
> > sparse_{add,remove}_one_section().
> >
> > This is simply plumbing, small cleanups, and some identifier renames. No
> > intended functional changes.
> >
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  include/linux/memory_hotplug.h |    5 +-
> >  mm/memory_hotplug.c            |  114 +++++++++++++++++++++++++---------------
> >  mm/sparse.c                    |   16 ++----
> >  3 files changed, 81 insertions(+), 54 deletions(-)
[..]
> > @@ -528,31 +556,31 @@ static void __remove_section(struct zone *zone, struct mem_section *ms,
> >   * sure that pages are marked reserved and zones are adjust properly by
> >   * calling offline_pages().
> >   */
> > -void __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
> > +void __remove_pages(struct zone *zone, unsigned long pfn,
> >                   unsigned long nr_pages, struct vmem_altmap *altmap)
> >  {
> > -     unsigned long i;
> >       unsigned long map_offset = 0;
> > -     int sections_to_remove;
> > +     int i, start_sec, end_sec;
>
> As mentioned in v9, use "unsigned long" for start_sec and end_sec please.

Honestly I saw you and Andrew going back and forth about "unsigned
long i" that I thought this would be handled by a follow on patchset
when that debate settled.
