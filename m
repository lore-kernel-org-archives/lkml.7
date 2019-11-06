Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E200DC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D8521848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="yk4hH6Ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbfKFO4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:56:13 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44144 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfKFO4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:56:13 -0500
Received: by mail-qv1-f66.google.com with SMTP id h3so1518687qvu.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 06:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8RsPIheisQdOMfEo46P3sUMu3xJT8aXR6jbJFy2hr7U=;
        b=yk4hH6YmOorresqTYVCQeYLIXle69BH70RVWbNYx+RxLmrO3Fjua58sz40sCaMMzZV
         xAd+qpzrJ1U/nrB+TlPJuDQLmCvaYEFKGg+bbzE9cTluly6sfCktYOutl007HhWBpqfw
         B4KReNKcVGzXUYTEqhLszaGzn7sYd0/pLU4UxX4mSwvO/msr4lzdaZNtlbNUR81ODH8l
         FM90wC3NvO0Bm83XTvyBG6F2WjaJ8SLW2q2Q0e3MZmYlCd7wL1KMYjbVybbpU0nkhKQW
         CACas7XFt5oAaas2BsyeSQ7IWJZgirdPFJ5VGe8DSNtNPuktMP6FbH82/EnTv/K+xEMR
         7XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8RsPIheisQdOMfEo46P3sUMu3xJT8aXR6jbJFy2hr7U=;
        b=pxJC+kSorIce4HznjrSvynBmSd2hWmJA/eNN9U2sGBz5z8BjSdvjdh+VVaWkgF9WV1
         E6PYgEFUo601mH6a1+Gh8QBDyaECwq2T1afqbYrZNkIna7QkyMJAW2XRiso+X5I6swev
         XSvUbmtjZOV81jX6pdfpjYwPc6T7UF36DkIuJHXN5e6Atj1/OnRHYjyty8i3EHTMwurs
         GqIbNO+XJG5Y+56Ef8XmNqoQLJUJ2HLRMB+PNWT7AW2oJM0yBHAI13Y8W99nDZSHGT/f
         gMHpjvrKbIDgSg3zTLPfoVY5mZ0gty6N3oQNotARkIsFj+G5x10KybCDeiqqMtHKAlkD
         cigA==
X-Gm-Message-State: APjAAAUD5thT8p9xwutkwqpJE9wxinuvn1dM0itbpr2s+Vr+CB2lG79O
        QSISRuEjqgoOitNSXJQJL2oIfhkbhMWhhw==
X-Google-Smtp-Source: APXvYqzHhF5xoFfD/8M7C6GqNVPzBI6kynDZEYUS15GAoCKyyJW/qfQuz5IY4hkDR/SBHfHwsntlYQ==
X-Received: by 2002:ad4:56ab:: with SMTP id bd11mr2558761qvb.237.1573052171900;
        Wed, 06 Nov 2019 06:56:11 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::66e4])
        by smtp.gmail.com with ESMTPSA id z193sm12925333qkb.12.2019.11.06.06.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 06:56:11 -0800 (PST)
Date:   Wed, 6 Nov 2019 09:56:09 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     snazy@snazy.de
Cc:     Jan Kara <jack@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191106145608.ucvuwsuyijvkxz22@macbook-pro-91.dhcp.thefacebook.com>
References: <20191025132700.GJ17610@dhcp22.suse.cz>
 <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
 <20191025135749.GK17610@dhcp22.suse.cz>
 <20191025140029.GL17610@dhcp22.suse.cz>
 <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
 <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
 <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
 <20191105182211.GA33242@cmpxchg.org>
 <20191106120315.GF16085@quack2.suse.cz>
 <4edf4dea97f6c1e3c7d4fed0e12c3dc6dff7575f.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4edf4dea97f6c1e3c7d4fed0e12c3dc6dff7575f.camel@gmx.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 02:45:43PM +0100, Robert Stupp wrote:
> On Wed, 2019-11-06 at 13:03 +0100, Jan Kara wrote:
> > On Tue 05-11-19 13:22:11, Johannes Weiner wrote:
> > > What I don't quite understand yet is why the fault path doesn't
> > > make
> > > progress eventually. We must drop the mmap_sem without changing the
> > > state in any way. How can we keep looping on the same page?
> >
> > That may be a slight suboptimality with Josef's patches. If the page
> > is marked as PageReadahead, we always drop mmap_sem if we can and
> > start
> > readahead without checking whether that makes sense or not in
> > do_async_mmap_readahead(). OTOH page_cache_async_readahead() then
> > clears
> > PageReadahead so the only way how I can see we could loop like this
> > is when
> > file->ra->ra_pages is 0. Not sure if that's what's happening through.
> > We'd
> > need to find which of the paths in filemap_fault() calls
> > maybe_unlock_mmap_for_io() to tell more.
> 
> Yes, ra_pages==0
> Attached the dmesg + smaps outputs
> 
> 

Ah ok I see what's happening, __get_user_pages() returns 0 if we get an EBUSY
from faultin_page, and then __mm_populate does nend = nstart + ret * PAGE_SIZE,
which just leaves us where we are.

We need to handle the non-blocking and the locking separately in __mm_populate
so we know what's going on.  Jan's fix for the readahead thing is definitely
valid as well, but this will keep us from looping forever in other retry cases.

diff --git a/mm/gup.c b/mm/gup.c
index 8f236a335ae9..ac625805d569 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1237,6 +1237,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 	unsigned long end, nstart, nend;
 	struct vm_area_struct *vma = NULL;
 	int locked = 0;
+	int nonblocking = 1;
 	long ret = 0;
 
 	end = start + len;
@@ -1268,7 +1269,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		 * double checks the vma flags, so that it won't mlock pages
 		 * if the vma was already munlocked.
 		 */
-		ret = populate_vma_page_range(vma, nstart, nend, &locked);
+		ret = populate_vma_page_range(vma, nstart, nend, &nonblocking);
 		if (ret < 0) {
 			if (ignore_errors) {
 				ret = 0;
@@ -1276,6 +1277,14 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 			}
 			break;
 		}
+
+		/*
+		 * We dropped the mmap_sem, so we need to re-lock, and the next
+		 * loop around we won't drop because nonblocking is now 0.
+		 */
+		if (!nonblocking)
+			locked = 0;
+
 		nend = nstart + ret * PAGE_SIZE;
 		ret = 0;
 	}
