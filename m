Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04517C76188
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D2820818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="IlHYoGDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfGQC3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 22:29:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43158 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfGQC3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 22:29:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id h59so19459503otb.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 19:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xha1gnu4k9Oy72ln0mL+F+SQtEp2dX0Dej1VFn9Byxc=;
        b=IlHYoGDprQ1xOzWMqON3a05nzYhFYMAfYY+PzndVmhk+L5azjE63rLAzWHCaDuwu8R
         Of4UQD6V2fJDBr9UCq/ZdnKPYgszELTUmF3dTGaKdC3LSbIfV2C/1F2jg8QUJMTvVQ2k
         PgTpQkgwGckGmJQvv+25I++JVfaO/COZAuj6W2UV5YeHvst26QRmfYJ79mYf0NjZKieV
         ovsu2HS+gICuc4kfGK5XDCcJI3pCe8z5+0QrXrt93xDSOIcUTlxxoCstyUToYXmtsDro
         662tsiQbhTYvFUo4yuYzMaURJwgFGLUf3W4Hv2qzgg/iIGG1omBV0rG5wK2641XjyzjH
         rWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xha1gnu4k9Oy72ln0mL+F+SQtEp2dX0Dej1VFn9Byxc=;
        b=ML0UNf2STjvyaBQ9W6d4tqxTabki66Mm+lDVlS9vI5FvYZ4xF6RFBRgOfLiqOtuU40
         EEvFvk5fTa11879GVrkBD21t+KbF9H3xiTjlQbGjwIeQPmTQfHjaXAcjvLb7Ol0GXvZh
         KwshEHstAkO7qadn5aLwyucv59Lzid5X2TIgYGMfVRX2NvQ0m7q5fBqnVelK5l5qZfpS
         Me399v1El9CqBqMGfML8fG8ZJ//BdasQJ2R3yF+ZTr9lxmQ9x8N98nZ33vZu0gBVGC+D
         /TCPgsIf8B/j8IT7JW3XuhYv8GxFQ598RqJJEDHl1lAUCvTQxN4xmk9EckT/UTN2gxZH
         fEUw==
X-Gm-Message-State: APjAAAXw4BnWQ9Ub5D5XWN9BGvD+gjpsp9A5QEDIRrfuzEt+N45l4/vW
        mIincQFr3NbmvIebfvGHIM1A42Lod5wo25l6XpfMwA==
X-Google-Smtp-Source: APXvYqxMaFQwJqNDONSbr/N/VaB8L20422JmTVZPiPqGIb8xJFeJh37HfCl+fOz5CxTOl3NTc8LlU1vZPBemm3j1mKI=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr26898798otf.126.1563330546010;
 Tue, 16 Jul 2019 19:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190715081549.32577-1-osalvador@suse.de> <20190715081549.32577-3-osalvador@suse.de>
 <87tvbne0rd.fsf@linux.ibm.com> <1563225851.3143.24.camel@suse.de>
In-Reply-To: <1563225851.3143.24.camel@suse.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Jul 2019 19:28:54 -0700
Message-ID: <CAPcyv4gp18-CRADqrqAbR0SnjKBoPaTyL_oaEyyNPJOeLybayg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm,memory_hotplug: Fix shrink_{zone,node}_span
To:     Oscar Salvador <osalvador@suse.de>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 2:24 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, 2019-07-15 at 21:41 +0530, Aneesh Kumar K.V wrote:
> > Oscar Salvador <osalvador@suse.de> writes:
> >
> > > Since [1], shrink_{zone,node}_span work on PAGES_PER_SUBSECTION
> > > granularity.
> > > The problem is that deactivation of the section occurs later on in
> > > sparse_remove_section, so pfn_valid()->pfn_section_valid() will
> > > always return
> > > true before we deactivate the {sub}section.
> >
> > Can you explain this more? The patch doesn't update section_mem_map
> > update sequence. So what changed? What is the problem in finding
> > pfn_valid() return true there?
>
> I realized that the changelog was quite modest, so a better explanation
>  will follow.
>
> Let us analize what shrink_{zone,node}_span does.
> We have to remember that shrink_zone_span gets called every time a
> section is to be removed.
>
> There can be three possibilites:
>
> 1) section to be removed is the first one of the zone
> 2) section to be removed is the last one of the zone
> 3) section to be removed falls in the middle
>
> For 1) and 2) cases, we will try to find the next section from
> bottom/top, and in the third case we will check whether the section
> contains only holes.
>
> Now, let us take the example where a ZONE contains only 1 section, and
> we remove it.
> The last loop of shrink_zone_span, will check for {start_pfn,end_pfn]
> PAGES_PER_SECTION block the following:
>
> - section is valid
> - pfn relates to the current zone/nid
> - section is not the section to be removed
>
> Since we only got 1 section here, the check "start_pfn == pfn" will make us to continue the loop and then we are done.
>
> Now, what happens after the patch?
>
> We increment pfn on subsection basis, since "start_pfn == pfn", we jump
> to the next sub-section (pfn+512), and call pfn_valid()-
> >pfn_section_valid().
> Since section has not been yet deactivded, pfn_section_valid() will
> return true, and we will repeat this until the end of the loop.
>
> What should happen instead is:
>
> - we deactivate the {sub}-section before calling
> shirnk_{zone,node}_span
> - calls to pfn_valid() will now return false for the sections that have
> been deactivated, and so we will get the pfn from the next activaded
> sub-section, or nothing if the section is empty (section do not contain
> active sub-sections).
>
> The example relates to the last loop in shrink_zone_span, but the same
> applies to find_{smalles,biggest}_section.
>
> Please, note that we could probably do some hack like replacing:
>
> start_pfn == pfn
>
> with
>
> pfn < end_pfn
>
> But the way to fix this is to 1) deactivate {sub}-section and 2) let
> shrink_{node,zone}_span find the next active {sub-section}.
>
> I hope this makes it more clear.

This makes it more clear that the problem is with the "start_pfn ==
pfn" check relative to subsections, but it does not clarify why it
needs to clear pfn_valid() before calling shrink_zone_span().
Sections were not invalidated prior to shrink_zone_span() in the
pre-subsection implementation and it seems all we need is to keep the
same semantic. I.e. skip the range that is currently being removed:

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 37d49579ac15..b69832db442b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -422,8 +422,8 @@ static void shrink_zone_span(struct zone *zone,
unsigned long start_pfn,
                if (page_zone(pfn_to_page(pfn)) != zone)
                        continue;

-                /* If the section is current section, it continues the loop */
-               if (start_pfn == pfn)
+                /* If the sub-section is current span being removed, skip */
+               if (pfn >= start_pfn && pfn < end_pfn)
                        continue;

                /* If we find valid section, we have nothing to do */


I otherwise don't follow why we would need to deactivate prior to
__remove_zone().
