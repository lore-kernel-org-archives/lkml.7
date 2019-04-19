Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A8DC282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2057421855
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="u3c+KcLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfDSXNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:13:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40722 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDSXNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:13:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id t8so5386372otp.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 16:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRzO3kj6mXZFzP66LK/VZmTpLamHoofRF3P1lpxxpGo=;
        b=u3c+KcLKfuS31rxHOPJxOD+jAkIBsldGNjGasuIi0wgt7f5oKRgsaMeKAnGB2KIsNq
         7uuPfbutEc4z2PWsgoMoylAi/wRziuHnuEV8vVz7OVUoDfM1/cmnzQAOeiHy+As93QkW
         WbRM2kxeKyzLorg6m+qy6nGCBVr0cILsoEt/NP3FQc8oO+pY1RNDg8cX/brf9JMk29WC
         R0eTIcNlR8TqzKAtpd6T/YSGl2w5NsJshHc3TRXpg9xBH8XXDrKhlKIJkNHW5BpFxChv
         go8IMdTQSHIuk76qcPTCXnL5vgM9XcrqQn8exBUc+oHOieBfLjpXBOpbNxnB31HgMo1p
         RtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRzO3kj6mXZFzP66LK/VZmTpLamHoofRF3P1lpxxpGo=;
        b=gfyjJHz17bROW+/rt+FJTq4wEvtNep5BZN6YarlbxMy/tX6c22qBOU2h4ny+uW5FCh
         sJbw8Ncjl19dw4CN5Z6u+0+gzF5hKajZlUWWAovzExXbdNOeSgOxm8O/C0r25Y5a7tiA
         4gU9ZU4Pxi6W5mJh/yDYkl+JLXMPECejWX7lcXtPFnuetddDi9MzQ06bUZIWLJyl7hGG
         EvbfvMZslmUGL7jZFkRf32gdJDQaYfVCO84c4ELucI5snTn8s5jOcaM9l4cG3LdBu8K5
         7fY7ge3VVlASnYInBxU9xd5S72wRDGwYTc7UJo8u9xeaQYkcjNuKFAMsuIWAwnuV4Sg7
         agUA==
X-Gm-Message-State: APjAAAVZQ6W72/D1hHD08OEQW2vK7B2TKs7yxbn89dXUUZIYl6o32625
        GbcEA79yc1fJ0oUilxVFh5ooXsVDt1B2Ma97FwPLCg==
X-Google-Smtp-Source: APXvYqxea/pSlbqQQY6zsjv6dAASN05Ch5VZf2vs5gMd48EOK+tb9ggPNRINmdcSMieFjfEJaGDwcTy/eWYwCeif7ig=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr3635314otl.229.1555715631703;
 Fri, 19 Apr 2019 16:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552635609.2015392.6246305135559796835.stgit@dwillia2-desk3.amr.corp.intel.com>
 <001f15a6-26bb-cbab-587f-d897b2dc9094@nvidia.com>
In-Reply-To: <001f15a6-26bb-cbab-587f-d897b2dc9094@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 19 Apr 2019 16:13:40 -0700
Message-ID: <CAPcyv4iCg8v2+-qG-p9bruM+CZs3dG-P=q+f5KdKEy3jn4S5OQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/12] mm/hotplug: Prepare shrink_{zone, pgdat}_span
 for sub-section removal
To:     Ralph Campbell <rcampbell@nvidia.com>
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

On Fri, Apr 19, 2019 at 4:09 PM Ralph Campbell <rcampbell@nvidia.com> wrote:
[..]
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 8b7415736d21..d5874f9d4043 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -327,10 +327,10 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
> >   {
> >       struct mem_section *ms;
> >
> > -     for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SECTION) {
> > +     for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SUB_SECTION) {
> >               ms = __pfn_to_section(start_pfn);
> >
> > -             if (unlikely(!valid_section(ms)))
> > +             if (unlikely(!pfn_valid(start_pfn)))
> >                       continue;
>
> Note that "struct mem_section *ms;" is now set but not used.
> You can remove the definition and initialization of "ms".

Good eye, yes, will clean up.
