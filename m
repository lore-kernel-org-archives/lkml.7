Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860FBC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8612064A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NTRp9Dty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbfFMRCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:02:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36794 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbfFLXNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 19:13:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id r6so12838347oti.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 16:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJqJQn2nizeYjh3TqrCfTJQiayYXOWM2pFyUsX77tns=;
        b=NTRp9DtyMg550SFhl1/vN3KzQCUa/cZhIlGRGRXapP1Gtc2QbaW8irXL4WU8+9iBDK
         0sqH+hg6IQoZeqKcqpjtoJaiGYO0XuGnxK8VODPMM2CBGJ4c0zKSTkUe2RbqwhevfGZY
         4a3jJW4c2O6qGax6qUqiRpoKvDDf6R9xwyhLbTmWihJzccRa4lw0/0NS7FBIbNBPY1VB
         4YOAiHHgHXGUfxu/HsNSrCCkJ4LvHrvXdbjWb2ZrYK7FarQ/aIRax6hIDw+oMDzMHXUW
         xxyTDT91GtyChmgdxv5jH1N6WszZK98JANqkbK22IDoZirBRW0eV5oouc/BEfe7gsx4t
         0Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJqJQn2nizeYjh3TqrCfTJQiayYXOWM2pFyUsX77tns=;
        b=FUDszqf4dQbpGicw3Irh2L7RxtFzCB2JhFRMXCKu1Zjub3b8Eq73Q7h3tjC2xjyeDH
         h93GSeuuKP7rBWdq486ie7FfHITzg5j57r6k1FnYN1dAArR0k4HM9ZxDHR6CK4e5smpW
         DvhC/Jmm4+mVNIbiB3rDepYf1JThsc755FRn94F+LklZHMbD0YaD4K/ZWGfPZKyrGToz
         8C9wa+akNcjXnJ/k2WXHhsHCCwu7JTnhXnL8yklYotAHmWoJO+NVa9HUzxUQRVEmrj7D
         mjr6ta74U2TA8YusXsCcil3+i1l4OfM5DB03+CGi4D8WcfWWPfS7Pr2W1s6gKNLqgXsD
         sCEQ==
X-Gm-Message-State: APjAAAV3yHdBZD2zgYkrleebmhEdDXSFB7gVECfsl+7CLhy/QHg2AiZl
        A7HvAIXwe4cLSPHeRWIuM+vZESSMW7BQYmWR3Vgyy7qa
X-Google-Smtp-Source: APXvYqyZhdvkw3fgmKdB88vloKS+olbdNprGVR9kanKMq9fU4ZHhlg81HIACN3QdEs50nE91yv6PVCsh54b8wyF6z3g=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr37353292otn.247.1560381216339;
 Wed, 12 Jun 2019 16:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <1560366952-10660-1-git-send-email-cai@lca.pw> <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
 <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
 <1560376072.5154.6.camel@lca.pw> <CAPcyv4gOhSOwE1DYWdLRkYSo2EL=KFf7LXUZ1w+M=w0xwFpknQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gOhSOwE1DYWdLRkYSo2EL=KFf7LXUZ1w+M=w0xwFpknQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Jun 2019 16:13:25 -0700
Message-ID: <CAPcyv4jRSPVshig-WYYjAg2kETsNkJPS6KCPVTe=TK4UYnOFtg@mail.gmail.com>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 2:52 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Jun 12, 2019 at 2:47 PM Qian Cai <cai@lca.pw> wrote:
> >
> > On Wed, 2019-06-12 at 12:38 -0700, Dan Williams wrote:
> > > On Wed, Jun 12, 2019 at 12:37 PM Dan Williams <dan.j.williams@intel.com>
> > > wrote:
> > > >
> > > > On Wed, Jun 12, 2019 at 12:16 PM Qian Cai <cai@lca.pw> wrote:
> > > > >
> > > > > The linux-next commit "mm/sparsemem: Add helpers track active portions
> > > > > of a section at boot" [1] causes a crash below when the first kmemleak
> > > > > scan kthread kicks in. This is because kmemleak_scan() calls
> > > > > pfn_to_online_page(() which calls pfn_valid_within() instead of
> > > > > pfn_valid() on x86 due to CONFIG_HOLES_IN_ZONE=n.
> > > > >
> > > > > The commit [1] did add an additional check of pfn_section_valid() in
> > > > > pfn_valid(), but forgot to add it in the above code path.
> > > > >
> > > > > page:ffffea0002748000 is uninitialized and poisoned
> > > > > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > > > > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > > > > page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> > > > > ------------[ cut here ]------------
> > > > > kernel BUG at include/linux/mm.h:1084!
> > > > > invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> > > > > CPU: 5 PID: 332 Comm: kmemleak Not tainted 5.2.0-rc4-next-20190612+ #6
> > > > > Hardware name: Lenovo ThinkSystem SR530 -[7X07RCZ000]-/-[7X07RCZ000]-,
> > > > > BIOS -[TEE113T-1.00]- 07/07/2017
> > > > > RIP: 0010:kmemleak_scan+0x6df/0xad0
> > > > > Call Trace:
> > > > >  kmemleak_scan_thread+0x9f/0xc7
> > > > >  kthread+0x1d2/0x1f0
> > > > >  ret_from_fork+0x35/0x4
> > > > >
> > > > > [1] https://patchwork.kernel.org/patch/10977957/
> > > > >
> > > > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > > > ---
> > > > >  include/linux/memory_hotplug.h | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/include/linux/memory_hotplug.h
> > > > > b/include/linux/memory_hotplug.h
> > > > > index 0b8a5e5ef2da..f02be86077e3 100644
> > > > > --- a/include/linux/memory_hotplug.h
> > > > > +++ b/include/linux/memory_hotplug.h
> > > > > @@ -28,6 +28,7 @@
> > > > >         unsigned long ___nr = pfn_to_section_nr(___pfn);           \
> > > > >                                                                    \
> > > > >         if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
> > > > > +           pfn_section_valid(__nr_to_section(___nr), pfn) &&      \
> > > > >             pfn_valid_within(___pfn))                              \
> > > > >                 ___page = pfn_to_page(___pfn);                     \
> > > > >         ___page;                                                   \
> > > >
> > > > Looks ok to me:
> > > >
> > > > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > > >
> > > > ...but why is pfn_to_online_page() a multi-line macro instead of a
> > > > static inline like all the helper routines it invokes?
> > >
> > > I do need to send out a refreshed version of the sub-section patchset,
> > > so I'll fold this in and give you a Reported-by credit.
> >
> > BTW, not sure if your new version will fix those two problem below due to the
> > same commit.
> >
> > https://patchwork.kernel.org/patch/10977957/
> >
> > 1) offline is busted [1]. It looks like test_pages_in_a_zone() missed the same
> > pfn_section_valid() check.
> >
> > 2) powerpc booting is generating endless warnings [2]. In vmemmap_populated() at
> > arch/powerpc/mm/init_64.c, I tried to change PAGES_PER_SECTION to
> > PAGES_PER_SUBSECTION, but it alone seems not enough.
>
> Yes, I was just sending you another note about this. I don't think
> your proposed fix is sufficient. The original intent of
> pfn_valid_within() was to use it as a cheaper lookup after already
> validating that the first page in a MAX_ORDER_NR_PAGES range satisfied
> pfn_valid(). Quoting commit  14e072984179 "add pfn_valid_within helper
> for sub-MAX_ORDER hole detection":
>
>     Add a pfn_valid_within() helper which should be used when scanning pages
>     within a MAX_ORDER_NR_PAGES block when we have already checked the
> validility
>     of the block normally with pfn_valid().  This can then be
> optimised away when
>     we do not have holes within a MAX_ORDER_NR_PAGES block of pages.
>
> So, with that insight I think the complete fix is this:
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 6dd52d544857..9d15ec793330 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1428,7 +1428,7 @@ void memory_present(int nid, unsigned long
> start, unsigned long end);
>  #ifdef CONFIG_HOLES_IN_ZONE
>  #define pfn_valid_within(pfn) pfn_valid(pfn)
>  #else
> -#define pfn_valid_within(pfn) (1)
> +#define pfn_valid_within(pfn) pfn_section_valid(pfn)

Well, obviously that won't work because pfn_section_valid needs a
'struct mem_section *' arg, but this does serve as a good check of
whether call sites were properly using pfn_valid_within() to constrain
the validity after an existing pfn_valid() check within the same
MAX_ORDER_NR_PAGES span.
