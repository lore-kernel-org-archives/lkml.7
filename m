Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51018C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF3421721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="y65D0zMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfJHOol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:44:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34149 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfJHOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:44:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id p10so15891798edq.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=roNGOd3FOBsYLcw6p6AfNsDfUlpEWk12K8lCSg6iAUY=;
        b=y65D0zMlciZ3pKMueE9P/nkUSG2s2/S9BTNNDHGb/WgvM/3pFToz8zmyClu6SIbzkk
         sEQmikJFrj2iHOL7IGwkeUWjamJVgSWk3cYBP1PNNjrr/agjKJX4rXyqIGi4zoLzeNan
         nAJ9XfaeBIpVqlv0WKrMV6KsA18TiyBIMjqJUJMWsk7M5IU3RUEfolfStiafA2TSRBlA
         ZWReAlrO9npe3o+Hhfam0Qb3FZraz2sWMiSj1WALXsJTnYobtVR63+n2+CEHj8NO/Mcp
         l6uBVJ8+IVjhHooVDzJ4PJK+wdJRTJQtw5y0OD42C09JBaH6Yitq5n/PBFV8zIUBjIkD
         FQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=roNGOd3FOBsYLcw6p6AfNsDfUlpEWk12K8lCSg6iAUY=;
        b=ZDoFLxSZATbi1v2o4kBxksc3+NYYPg7sBJtuSeeDD2USBvJHNLSMko3NUXOuGs4LHm
         RogEywCmQuJeX2cMTzAWvZu7V831uYZWp6y8tQiNLMnej95CHUf5dxlloggyWe2l9pWM
         w5DZ47O+j8+F0T7+I3v06DfG/b03A1+LyS3l0UVDS0b8InJsm+btvcRD6+3EaBRo90+E
         LZEJZ3da/ylDYEqu2ZY69nrQm1lEGhfJBFagN90VPF+di6q7rPZ4KSdebkTbusfqDxTM
         Oyh8C19wsK4NlOR9NpAvrm1bEMg4/JaQqZDjPD95N8pN4xrZRJTQn3qUXOKIBJm/FpgO
         Q2Rg==
X-Gm-Message-State: APjAAAWwJJ9j0PUqhvl8LXAfgzQC4jbC/s0SFweUiV6RXxokEhouoKqR
        V/6rNyvsrod4O0LL5ZAu7oRAAQ==
X-Google-Smtp-Source: APXvYqw+1C1Pvr11q8AONS2td9iwm6bodbUuuJy7w3SrM1wrQki8aRt57kKphgwrMCqqnWG+ZJDomQ==
X-Received: by 2002:aa7:cdd6:: with SMTP id h22mr34660703edw.132.1570545878559;
        Tue, 08 Oct 2019 07:44:38 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z20sm3957544edb.3.2019.10.08.07.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 07:44:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9DE6E10170F; Tue,  8 Oct 2019 17:44:37 +0300 (+03)
Date:   Tue, 8 Oct 2019 17:44:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, hughd@google.com, shakeelb@google.com,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: move deferred split queue to memcg's nodeinfo
Message-ID: <20191008144437.fr374cxtpnrnnjsv@box>
References: <1569968203-64647-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191002084304.GI15624@dhcp22.suse.cz>
 <30421920-4fdb-767a-6ef2-60187932c414@suse.cz>
 <20191007143030.GN2381@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007143030.GN2381@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:30:30PM +0200, Michal Hocko wrote:
> On Mon 07-10-19 16:19:59, Vlastimil Babka wrote:
> > On 10/2/19 10:43 AM, Michal Hocko wrote:
> > > On Wed 02-10-19 06:16:43, Yang Shi wrote:
> > >> The commit 87eaceb3faa59b9b4d940ec9554ce251325d83fe ("mm: thp: make
> > >> deferred split shrinker memcg aware") makes deferred split queue per
> > >> memcg to resolve memcg pre-mature OOM problem.  But, all nodes end up
> > >> sharing the same queue instead of one queue per-node before the commit.
> > >> It is not a big deal for memcg limit reclaim, but it may cause global
> > >> kswapd shrink THPs from a different node.
> > >>
> > >> And, 0-day testing reported -19.6% regression of stress-ng's madvise
> > >> test [1].  I didn't see that much regression on my test box (24 threads,
> > >> 48GB memory, 2 nodes), with the same test (stress-ng --timeout 1
> > >> --metrics-brief --sequential 72  --class vm --exclude spawn,exec), I saw
> > >> average -3% (run the same test 10 times then calculate the average since
> > >> the test itself may have most 15% variation according to my test)
> > >> regression sometimes (not every time, sometimes I didn't see regression
> > >> at all).
> > >>
> > >> This might be caused by deferred split queue lock contention.  With some
> > >> configuration (i.e. just one root memcg) the lock contention my be worse
> > >> than before (given 2 nodes, two locks are reduced to one lock).
> > >>
> > >> So, moving deferred split queue to memcg's nodeinfo to make it NUMA
> > >> aware again.
> > >>
> > >> With this change stress-ng's madvise test shows average 4% improvement
> > >> sometimes and I didn't see degradation anymore.
> > > 
> > > My concern about this getting more and more complex
> > > (http://lkml.kernel.org/r/20191002084014.GH15624@dhcp22.suse.cz) holds
> > > here even more. Can we step back and reconsider the whole thing please?
> > 
> > What about freeing immediately after split via workqueue and also have a
> > synchronous version called before going oom? Maybe there would be also
> > other things that would benefit from this scheme instead of traditional
> > reclaim and shrinkers?
> 
> That is exactly what we have discussed some time ago.

Yes, I've posted the patch:

http://lkml.kernel.org/r/20190827125911.boya23eowxhqmopa@box

But I still not sure that the approach is right. I expect it to trigger
performance regressions. For system with pleanty of free memory, we will
just pay split cost for nothing in many cases.

-- 
 Kirill A. Shutemov
