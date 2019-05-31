Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44470C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AE326B2E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="wuALX1ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfEaO7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:59:41 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39594 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEaO7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:59:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id k24so4340108otn.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gkjgr9yAq+VhnnIt5t0RaPzTkMpIeWNJYrEuBA5bAY4=;
        b=wuALX1dsEVY6xCVhPDDDGuSpN6wnECHReOyE/T6CGO5EOwmGiJJwGPmhE7Ls/LTmZj
         k9a53MPPnTG2Xl3DCJuMUQTLVWZ0MTaq91bcxe2buFfCgv4m4p73z0cN+T9o4RExfzEI
         PVmANmnSmNdsXekO7tYe2xfPJMWkEXOduZ4LfbZq5hFqAN5oQv7TsVMsLaWjzCTTkXIk
         qpjBBB70swa9i43eULEvRpovxAhGjq3moOMow2nluRvxO2o8BhSmAi6m5qRSfbVBG5+p
         TdhvwucQ/LfYApSKBBASABxtO+MCKfSA9XJEFlpOa+/e4ECKHx2souc8xpsDSEV8WsBh
         IVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gkjgr9yAq+VhnnIt5t0RaPzTkMpIeWNJYrEuBA5bAY4=;
        b=nOGBTSmjjGqLto4/uK7NtcwsUAZOQNKLM8hkwOVKhKvEibz4lDcjOXsXdBtOioEUzY
         gTFFRRbwZAi9YId3TdqIFaOPf/GwDcB+O5T69AvbdExl1Tg6aL/byXpx0r7j9L4gsyWW
         IhGhuNWumKucCFIBj+MY99bJeD5KcRxjU6oeG7JNAfLvDTLMN0ssZ45L0K/j5mv8Bwnk
         6tgYM3hfa/pi+dwFx2p4/o6gqg76bAxtPQuQAIdOJrbCJSBc5NRtoiVMNBGjFr6HmT26
         khb2ltOVJsBWeHvJL4GucfBGgMeM6vRqvve+qpsR+MnnoJJbZKpXePns/qYIFH1aBwPn
         56iw==
X-Gm-Message-State: APjAAAUZn2/c8uDFXgwl7ZO96MT6H0NsPp0oKJ0bWx3BMuvpLhFJ6jbO
        F44nXu5xHHl8ofzB+MiG54vgcw3bZt09FoKCNB5bXA==
X-Google-Smtp-Source: APXvYqyEy2uoSeMif4klObB48qoPaiK9up6/IKR3TQTeJ3zBAsdV8u4dmVPKTkeVoooxLhERezABZp9xoq24sg44nUc=
X-Received: by 2002:a9d:2963:: with SMTP id d90mr2134041otb.126.1559314780136;
 Fri, 31 May 2019 07:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <154899811208.3165233.17623209031065121886.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154899811738.3165233.12325692939590944259.stgit@dwillia2-desk3.amr.corp.intel.com>
 <cddd43de-62f6-6a91-83aa-da02ff17254d@suse.cz>
In-Reply-To: <cddd43de-62f6-6a91-83aa-da02ff17254d@suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 31 May 2019 07:59:28 -0700
Message-ID: <CAPcyv4g-g=Gyf0T1rENCEH_2KyLtt74kiLydxO=__tM71_bYww@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] mm: Shuffle initial free memory to improve
 memory-side-cache utilization
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 12:33 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 2/1/19 6:15 AM, Dan Williams wrote:
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1714,6 +1714,29 @@ config SLAB_FREELIST_HARDENED
> >         sacrifies to harden the kernel slab allocator against common
> >         freelist exploit methods.
> >
> > +config SHUFFLE_PAGE_ALLOCATOR
> > +     bool "Page allocator randomization"
> > +     default SLAB_FREELIST_RANDOM && ACPI_NUMA
> > +     help
> > +       Randomization of the page allocator improves the average
> > +       utilization of a direct-mapped memory-side-cache. See section
> > +       5.2.27 Heterogeneous Memory Attribute Table (HMAT) in the ACPI
> > +       6.2a specification for an example of how a platform advertises
> > +       the presence of a memory-side-cache. There are also incidental
> > +       security benefits as it reduces the predictability of page
> > +       allocations to compliment SLAB_FREELIST_RANDOM, but the
> > +       default granularity of shuffling on 4MB (MAX_ORDER) pages is
> > +       selected based on cache utilization benefits.
> > +
> > +       While the randomization improves cache utilization it may
> > +       negatively impact workloads on platforms without a cache. For
> > +       this reason, by default, the randomization is enabled only
> > +       after runtime detection of a direct-mapped memory-side-cache.
> > +       Otherwise, the randomization may be force enabled with the
> > +       'page_alloc.shuffle' kernel command line parameter.
> > +
> > +       Say Y if unsure.
>
> It says "Say Y if unsure", yet if I run make oldconfig, the default is
> N. Does that make sense?

The default is due to the general policy of not forcing users into new
kernel functionality (i.e. the common Linus objection when a new
config symbol is default 'y') . However, if someone is actively
considering whether to enable it I think there's no harm in
recommending 'y' because the facility currently needs to be paired
with the page_alloc.shuffle=1 command line option.
