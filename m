Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCFFC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73AF21773
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="EVaZL4wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407521AbfHISe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:34:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34440 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfHISe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:34:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so45316467plt.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 11:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l3qInV8TXmCdHnd23dBAVW8r6K3CCAoKuu4IFFIBWeI=;
        b=EVaZL4wq7FTuKkCotF7aE5IH5QbekD0MZo2PrS/me34fC2idnhu8PldWFBQCRbXO2o
         H2HMZ5/EX1c5rRu0rrFDoBME2afBICf19PPklf19ngaynpe3mI8Y6cO3RB3q/vsymN3D
         +4bRT/WBZjCY0rC/Zs4foifpghF9wtqtzw6e/EfP2gfGw8d7EyuWEhgLv1S2kT5NXrbV
         EwP8X0MGrNxR6JPzXIG8QGWztfgpBKuURcLDPETmHdbTVLkVX1+H/nDB2TDPuXryfKFp
         kI5+LwnbCeoWW4J6XKGW6biWwoaHzTWbwKl0UJdP8wPftBXYDNNEHWYLiDPYehVamGjK
         W3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l3qInV8TXmCdHnd23dBAVW8r6K3CCAoKuu4IFFIBWeI=;
        b=oHrTkEFtfFvABkpPQskfKc3Crst44QkZ0LCt1Da/U2b4af0rox4w+D8ZXTHltF5Ytw
         TSCcrBQYOjPR/mMjDy9iGtx6FCj148cGcmc27grEJO5EXlI/Tjk/UQc8DZaOzV1LTche
         /iRA0wcJnOioyRZfUbhzYe4/s1anNlQRI01ae9JQ9iV/rTyD52Tp3rLIz6iJUh8jcsD0
         IJHYWiD8S1P2sPIdgQji5YzKNVC5AYV4DF4/1FYPvNjhmtibFLZgAeKpWOltIHpqyH5j
         4EbtyQaz5MgRiwveHRhLDUNgF2cVYk9sfqfu0z/ioQizyRk+iVfOQBYWMD61ARPD/qdS
         o/xg==
X-Gm-Message-State: APjAAAVlCtTzwC0B3aRnDyFTi7KiTqySwQi/viDTJpoWKEgJJoFeZdMU
        VKfld1rQy6uizJdLOFNE75Vopw==
X-Google-Smtp-Source: APXvYqwuOSP4hvD9bUY1S1rpgVgLwZxIHZxrC1NKtKz5i9gg7lsAOSA0upVlx16zBHziVtYSYEcx+A==
X-Received: by 2002:a17:902:441:: with SMTP id 59mr12080641ple.62.1565375667539;
        Fri, 09 Aug 2019 11:34:27 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::ad32])
        by smtp.gmail.com with ESMTPSA id p20sm138343530pgj.47.2019.08.09.11.34.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 11:34:26 -0700 (PDT)
Date:   Fri, 9 Aug 2019 14:34:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] mm: drop mark_page_access from the unmap path
Message-ID: <20190809183424.GA22347@cmpxchg.org>
References: <20190729082052.GA258885@google.com>
 <20190729083515.GD9330@dhcp22.suse.cz>
 <20190730121110.GA184615@google.com>
 <20190730123237.GR9330@dhcp22.suse.cz>
 <20190730123935.GB184615@google.com>
 <20190730125751.GS9330@dhcp22.suse.cz>
 <20190731054447.GB155569@google.com>
 <20190731072101.GX9330@dhcp22.suse.cz>
 <20190806105509.GA94582@google.com>
 <20190809124305.GQ18351@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809124305.GQ18351@dhcp22.suse.cz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 02:43:24PM +0200, Michal Hocko wrote:
> On Tue 06-08-19 19:55:09, Minchan Kim wrote:
> > On Wed, Jul 31, 2019 at 09:21:01AM +0200, Michal Hocko wrote:
> > > On Wed 31-07-19 14:44:47, Minchan Kim wrote:
> [...]
> > > > As Nick mentioned in the description, without mark_page_accessed in
> > > > zapping part, repeated mmap + touch + munmap never acticated the page
> > > > while several read(2) calls easily promote it.
> > > 
> > > And is this really a problem? If we refault the same page then the
> > > refaults detection should catch it no? In other words is the above still
> > > a problem these days?
> > 
> > I admit we have been not fair for them because read(2) syscall pages are
> > easily promoted regardless of zap timing unlike mmap-based pages.
> > 
> > However, if we remove the mark_page_accessed in the zap_pte_range, it
> > would make them more unfair in that read(2)-accessed pages are easily
> > promoted while mmap-based page should go through refault to be promoted.
> 
> I have really hard time to follow why an unmap special handling is
> making the overall state more reasonable.
> 
> Anyway, let me throw the patch for further discussion. Nick, Mel,
> Johannes what do you think?
> 
> From 3821c2e66347a2141358cabdc6224d9990276fec Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Fri, 9 Aug 2019 14:29:59 +0200
> Subject: [PATCH] mm: drop mark_page_access from the unmap path
> 
> Minchan has noticed that mark_page_access can take quite some time
> during unmap:
> : I had a time to benchmark it via adding some trace_printk hooks between
> : pte_offset_map_lock and pte_unmap_unlock in zap_pte_range. The testing
> : device is 2018 premium mobile device.
> :
> : I can get 2ms delay rather easily to release 2M(ie, 512 pages) when the
> : task runs on little core even though it doesn't have any IPI and LRU
> : lock contention. It's already too heavy.
> :
> : If I remove activate_page, 35-40% overhead of zap_pte_range is gone
> : so most of overhead(about 0.7ms) comes from activate_page via
> : mark_page_accessed. Thus, if there are LRU contention, that 0.7ms could
> : accumulate up to several ms.
> 
> bf3f3bc5e734 ("mm: don't mark_page_accessed in fault path") has replaced
> SetPageReferenced by mark_page_accessed arguing that the former is not
> sufficient when mark_page_accessed is removed from the fault path
> because it doesn't promote page to the active list. It is true that a
> page that is mapped by a single process might not get promoted even when
> referenced if the reclaim checks it after the unmap but does that matter
> that much? Can we cosider the page hot if there are no other
> users? Moreover we do have workingset detection in place since then and
> so a next refault would activate the page if it was really hot one.

I do think the pages can be very hot. Think of short-lived executables
and their libraries. Like shell commands. When they run a few times or
periodically, they should be promoted to the active list and not have
to compete with streaming IO on the inactive list - the PG_referenced
doesn't really help them there, see page_check_references().

Maybe the refaults will be fine - but latency expectations around
mapped page cache certainly are a lot higher than unmapped cache.

So I'm a bit reluctant about this patch. If Minchan can be happy with
the lock batching, I'd prefer that.
