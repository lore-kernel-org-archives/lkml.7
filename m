Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549EBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0BF214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="siQhamaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfJJTMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 15:12:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41454 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJTMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:12:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id p10so6627667qkg.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cMt4BJeZJ/Cdi4k5RmrGMFgzosfQx/tqi/Gp7tlgiE0=;
        b=siQhamaPzLNwjCK9yYUlnIdmeE1f+M/NCQQMpVcDu2E4UsAjo8vctIVi1t+aXjWwyU
         AgtY1Hjc1bc3GrUjaqAnkG4d8gCt8Kfgqm0soMTLkV750+DW1PkXlNlmyofHY0zP8S+R
         xyQim62zeYOcyyuUE22hkAwFaNrLYbReAVGn/Swy/0CQDCmoGzSiauZgr7/54pge/Z6z
         8vlPJ6zTu3R2QmawJ9ofcr8yH9VMQ/Owzd0jBoEe8skF2ZsMeUtNoqWqHZtz+IzBovqf
         /xDShgOgB9iUxffCKFuRS+e4RyYv3vPk2VW2lzqDDOigT33RIpN00GoyOT+C5OOWmK+F
         z8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cMt4BJeZJ/Cdi4k5RmrGMFgzosfQx/tqi/Gp7tlgiE0=;
        b=lkIZRYXvvjB5iYGEsCdo+H9t2P0pwvU5nnfkquz9FynXoQHyYLs26thylHZVwNc4gD
         SlBJ3L/p3Ez5l4/ymZ9sahgVpRlfUHy4jJTDZlaKkN0UWVo1awz7ktahFh7MGQNlLfjH
         /WAGaU9/cOuu4bR/EQtstrR6GTQZ1AtnFdmVxE2HqAv9UpX+Iay3HjMZB/t4Ne/L8/qW
         szt6dYSDqVjsyrlqwFQmHWs9Qwcjn1N5yIibvJ/DY6/Gyu3WoX2zKpcdiZFZeXs3O1vR
         FYD2RnZ0qtmKefhyW/bp2FVk0CktHWhVcYghWTFYep2cM79yqmLb3AWKRyX00nnyE25j
         M1TQ==
X-Gm-Message-State: APjAAAUcnr4MRTnNY+KM7HHXovHX4d/8c9SCoJhcSnMfeVuutebF5tCa
        b9d/X+kV9G7UdjsdL+9ge8QRFw==
X-Google-Smtp-Source: APXvYqxqE2/ZPBRIeCe92f8SgM3Qc+KtHwbcwC+/dO/OK33ze9iRMmZDxHMzX8lh2Whzr/ddXr0CSQ==
X-Received: by 2002:a05:620a:359:: with SMTP id t25mr11456613qkm.171.1570734722899;
        Thu, 10 Oct 2019 12:12:02 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d45sm3185134qtc.70.2019.10.10.12.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 12:12:02 -0700 (PDT)
Message-ID: <1570734720.5937.32.camel@lca.pw>
Subject: Re: [PATCH] mm/page_owner: fix a crash after memory offline
From:   Qian Cai <cai@lca.pw>
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "mhocko@suse.com" <mhocko@suse.com>
Date:   Thu, 10 Oct 2019 15:12:00 -0400
In-Reply-To: <2e36a929-0fc7-d32a-d838-de746ff071fc@redhat.com>
References: <1570732366-16426-1-git-send-email-cai@lca.pw>
         <2e36a929-0fc7-d32a-d838-de746ff071fc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-10 at 20:55 +0200, David Hildenbrand wrote:
> On 10.10.19 20:32, Qian Cai wrote:
> > The linux-next series "mm/memory_hotplug: Shrink zones before removing
> > memory" [1] seems make a crash easier to reproduce while reading
> > /proc/pagetypeinfo after offlining a memory section. Fix it by using
> > pfn_to_online_page() in the PFN walker.
> 
> Can you please rephrase the subject+description to describe the actual 
> problem and drop the reference to the series?

I'd figure it is better for you to post this as you are on the top of this whole
mess. What do you think?

> 
> E.g., similar to my recent patches:
> 
> "mm/page_owner: Don't access uninitialized memmaps when reading 
> /proc/pagetypeinfo
> 
> Uninitialized memmaps contain garbage and in the worst case trigger 
> kernel BUGs, especially with CONFIG_PAGE_POISONING. They should not get
> touched.
> 
> For example, when not onlining a memory block that is spanned by a zone 
> and reading /proc/pagetypeinfo, we can trigger a kernel BUG: ...
> "
> 
> However, you also have to justify why it is okay to no longer consider 
> ZONE_DEVICE (I think walk_zones_in_node() will skip ZONE_DEVICE due to 
> assert_populated == true and ZONE_DEVICE will never be populated, 
> Therefore, we will never end in this code path with ZONE_DEVICE).
> 
> 
> > 
> > [1] https://lore.kernel.org/linux-mm/20191006085646.5768-1-david@redhat.com/
> > 
> > page:ffffea0021200000 is uninitialized and poisoned
> > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> > There is not page extension available.
> > ------------[ cut here ]------------
> > kernel BUG at include/linux/mm.h:1107!
> > RIP: 0010:pagetypeinfo_showmixedcount_print+0x4fb/0x680
> > Call Trace:
> >   walk_zones_in_node+0x3a/0xc0
> >   pagetypeinfo_show+0x260/0x2c0
> >   seq_read+0x27e/0x710
> >   proc_reg_read+0x12e/0x190
> >   __vfs_read+0x50/0xa0
> >   vfs_read+0xcb/0x1e0
> >   ksys_read+0xc6/0x160
> >   __x64_sys_read+0x43/0x50
> >   do_syscall_64+0xcc/0xaec
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >   mm/page_owner.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/page_owner.c b/mm/page_owner.c
> > index dee931184788..03a6b19b3cdd 100644
> > --- a/mm/page_owner.c
> > +++ b/mm/page_owner.c
> > @@ -296,11 +296,10 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
> >   		pageblock_mt = get_pageblock_migratetype(page);
> >   
> 
> What about the pfn_valid() in the outermost loop? You can skip over the 
> whole pageblock if the first page is not online.
> 
> >   		for (; pfn < block_end_pfn; pfn++) {
> > -			if (!pfn_valid_within(pfn))
> > +			page = pfn_to_online_page(pfn);
> > +			if (!page)
> >   				continue;
> >   
> > -			page = pfn_to_page(pfn);
> > -
> >   			if (page_zone(page) != zone)
> >   				continue;
> >   
> > 
> 
> 
