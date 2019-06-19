Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66EAC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 03:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90627208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 03:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="BQ7vWgHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfFSDks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 23:40:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42182 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSDkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 23:40:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so8167014otn.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 20:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4V43vNNP9UR/YMy0iUrU7kUuUwSqcmG602S5hpOD5NE=;
        b=BQ7vWgHmVXoWfX5W8xsL12ik15mXugB0SaJil+xQI3I0WxyylMDSZVjeFIBqrMpPVJ
         Tgiut3d49qvcxdiNlr/Wuqhf5OYmZDTD6pJsL4uc8B7AvZ8wwh8aPM4n71HSolE5Oxc3
         FA9Ld6qDcf1gl5dm9y3qsfehBHljHi5HXuDdd7/icxI+t/oHdrlAmeDiUP/Kmr+DiaXd
         ygMke+1L3EJ6jv6Or7J7ka07JnJyzYJ6usnlq/hrYPaTv2PCenHPThlG9fXMEyQo3ktq
         qYnDyLZfzEglV0V7mhDK4JYNDdtBeedbRy3nXiodLZw2O63uvgAs/frjTUrFddu2fdwk
         1G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4V43vNNP9UR/YMy0iUrU7kUuUwSqcmG602S5hpOD5NE=;
        b=dwBQUrE388OR7Xd2VnsBEZpCs+CwEDv/D7I/j2BCS/3YbpyfZ3d8h/uZ5OTuQPVvXX
         szspdalK3RYkncrWc+ikJgyGDdk8OEYo8Y6LGdDl17VKvUucIiEL13nWrp/nFGlodFFO
         fOcGQfjvXkWzC7SgweVJ4XSv21QpMs55fzsYzibVtPwq5lf1KAwam9Fjd2xTeE8H5msE
         HjnKEc8LbesDtpW7PXh8yeeHEJEyPlU9z8x2v8yB9OXtVlQNRMElfw0kcZNq7tyQoroZ
         R1d37x+BDAl2qJXURhlvL1ZClrTZyBeYem4UVaub3guojyydrFCOgxyc5I88XAtG9/Xm
         Q9vg==
X-Gm-Message-State: APjAAAXxAEDgCCyKcrwnpPEANpyrnJ1iWIDGwBRFQ/Xq0Li9bw1xElpE
        sC7UcGkYyNAz/X22kzUGUMLKBpHfJq9IqOKDgHtgNQ==
X-Google-Smtp-Source: APXvYqzSIN9dPRssFnDKf+ysKlqbDab6DghA3P8E1YBeqgXp36cJF4wdWJZxF+5DmxoFz1Yx1IYT0Jk4KmWR0apXjnU=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr59223453otn.71.1560915647227;
 Tue, 18 Jun 2019 20:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977188458.2443951.9573565800736334460.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190618014223.GD18161@richard>
In-Reply-To: <20190618014223.GD18161@richard>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 18 Jun 2019 20:40:36 -0700
Message-ID: <CAPcyv4gXzNgghUq337foa3ywB0R4g1e1atnXX-=KJCjCacv0TA@mail.gmail.com>
Subject: Re: [PATCH v9 03/12] mm/hotplug: Prepare shrink_{zone, pgdat}_span
 for sub-section removal
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:42 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> On Wed, Jun 05, 2019 at 02:58:04PM -0700, Dan Williams wrote:
> >Sub-section hotplug support reduces the unit of operation of hotplug
> >from section-sized-units (PAGES_PER_SECTION) to sub-section-sized units
> >(PAGES_PER_SUBSECTION). Teach shrink_{zone,pgdat}_span() to consider
> >PAGES_PER_SUBSECTION boundaries as the points where pfn_valid(), not
> >valid_section(), can toggle.
> >
> >Cc: Michal Hocko <mhocko@suse.com>
> >Cc: Vlastimil Babka <vbabka@suse.cz>
> >Cc: Logan Gunthorpe <logang@deltatee.com>
> >Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> >Reviewed-by: Oscar Salvador <osalvador@suse.de>
> >Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >---
> > mm/memory_hotplug.c |   29 ++++++++---------------------
> > 1 file changed, 8 insertions(+), 21 deletions(-)
> >
> >diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> >index 7b963c2d3a0d..647859a1d119 100644
> >--- a/mm/memory_hotplug.c
> >+++ b/mm/memory_hotplug.c
> >@@ -318,12 +318,8 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
> >                                    unsigned long start_pfn,
> >                                    unsigned long end_pfn)
> > {
> >-      struct mem_section *ms;
> >-
> >-      for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SECTION) {
> >-              ms = __pfn_to_section(start_pfn);
> >-
> >-              if (unlikely(!valid_section(ms)))
> >+      for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SUBSECTION) {
> >+              if (unlikely(!pfn_valid(start_pfn)))
> >                       continue;
>
> Hmm, we change the granularity of valid section from SECTION to SUBSECTION.
> But we didn't change the granularity of node id and zone information.
>
> For example, we found the node id of a pfn mismatch, we can skip the whole
> section instead of a subsection.
>
> Maybe this is not a big deal.

I don't see a problem.
