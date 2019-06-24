Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FE8C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BEA205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="t642LGgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfFXMeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:34:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46991 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFXMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:34:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id d4so21500100edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lR/K9dPqLYYsbzYW2e/lfBpEoeC6Cvpl0omMuZVAwYE=;
        b=t642LGgn6kd1Tw+bg6xnoK7KAmyybbu2hSgkAwPeYxKZC8G9mQXRdrkOhnvrU3K1pW
         yRMyp9OiwNJAD1gC3ckyahmckgj2KaGdZRnPto9Zh2VnDpYKvjguSSFHgnIPB6gS0AkD
         P7EdRWOXPrVsp+pRxKB/7Qrt9gI9GRvDZE/KvWzK4ec2gWXmgxsITzCEMRV9WjPZPECh
         KHS4ySpz2XP7UuQo5DH6nWJvcOBpb9bdWKcNa827kBXUNhU1q3nKRfx4eqPCUjWYaCsD
         MqIMQcbVvqcI54K2OQpgYigJqqzK6bEKkCrRVUoEmRW5/Qlt+CqW+cyzE0Ot1Wrx/cSU
         4f/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lR/K9dPqLYYsbzYW2e/lfBpEoeC6Cvpl0omMuZVAwYE=;
        b=a2BUkWRkTnEdSnToh5OaL/5eYTOeB0q3sPIoxp/s1VvkQ9xf3ALyh7/foX0f8+dDyY
         0IEwwnW58De8aj4/NZiuegOSz+6vzJsah+GF8To3cVR6ns2fyrE+UzqF2vnVQ0ZtRdnM
         UsNFExQEF/zdzAX0r2UbycfiBWWt/kZF4vzEeKGhgb+CDUv//TloGb95STg7iTjW1nOU
         1U9MpOywYiYLLPxw94AlauZpLTbzjmbB76NA3XOkJiJ6jOec+Wc+Tp0wf+ghCGg9dh0a
         uAjwRv8EZcKmaBqNZBo6pSu+Lu2kXlXW/xEReg+7VlpbbnHu9EC33eaLk56L4RHgArgV
         15yg==
X-Gm-Message-State: APjAAAU+DqSVjjah9aVjb5V4ZO16SEUpKaBjr82PNQo8LFuJK7jvMHzY
        GWvT505JHi+bsQVE/XCgMOjH1PKN6K0=
X-Google-Smtp-Source: APXvYqyYG0KW9bFgfCg3/28Cw1GvUVIn0oWrcBJwaum/DCvk7ez7L29DjOpy8Uas3/JkBWDdA7egFA==
X-Received: by 2002:a17:906:a39a:: with SMTP id k26mr104302117ejz.82.1561379673442;
        Mon, 24 Jun 2019 05:34:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y21sm1861137ejm.60.2019.06.24.05.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 05:34:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1417D10439E; Mon, 24 Jun 2019 15:34:38 +0300 (+03)
Date:   Mon, 24 Jun 2019 15:34:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v4 5/5] uprobe: collapse THP pmd after removing all
 uprobes
Message-ID: <20190624123438.dubsp52tauwkr342@box>
References: <20190613175747.1964753-1-songliubraving@fb.com>
 <20190613175747.1964753-6-songliubraving@fb.com>
 <20190621124823.ziyyx3aagnkobs2n@box>
 <B72B62C9-78EE-4440-86CA-590D3977BDB1@fb.com>
 <20190621133613.xnzpdlicqvjklrze@box>
 <4B58B3B3-10CB-4593-8BEC-1CEF41F856A1@fb.com>
 <707D52CA-E782-4C9A-AC66-75938C8E3358@fb.com>
 <DB6689FE-8528-4883-8CD9-CFE5F3BEC321@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6689FE-8528-4883-8CD9-CFE5F3BEC321@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 06:04:14PM +0000, Song Liu wrote:
> 
> 
> > On Jun 21, 2019, at 9:30 AM, Song Liu <songliubraving@fb.com> wrote:
> > 
> > 
> > 
> >> On Jun 21, 2019, at 6:45 AM, Song Liu <songliubraving@fb.com> wrote:
> >> 
> >> 
> >> 
> >>> On Jun 21, 2019, at 6:36 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >>> 
> >>> On Fri, Jun 21, 2019 at 01:17:05PM +0000, Song Liu wrote:
> >>>> 
> >>>> 
> >>>>> On Jun 21, 2019, at 5:48 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >>>>> 
> >>>>> On Thu, Jun 13, 2019 at 10:57:47AM -0700, Song Liu wrote:
> >>>>>> After all uprobes are removed from the huge page (with PTE pgtable), it
> >>>>>> is possible to collapse the pmd and benefit from THP again. This patch
> >>>>>> does the collapse.
> >>>>>> 
> >>>>>> An issue on earlier version was discovered by kbuild test robot.
> >>>>>> 
> >>>>>> Reported-by: kbuild test robot <lkp@intel.com>
> >>>>>> Signed-off-by: Song Liu <songliubraving@fb.com>
> >>>>>> ---
> >>>>>> include/linux/huge_mm.h |  7 +++++
> >>>>>> kernel/events/uprobes.c |  5 ++-
> >>>>>> mm/huge_memory.c        | 69 +++++++++++++++++++++++++++++++++++++++++
> >>>>> 
> >>>>> I still sync it's duplication of khugepaged functinallity. We need to fix
> >>>>> khugepaged to handle SCAN_PAGE_COMPOUND and probably refactor the code to
> >>>>> be able to call for collapse of particular range if we have all locks
> >>>>> taken (as we do in uprobe case).
> >>>>> 
> >>>> 
> >>>> I see the point now. I misunderstood it for a while. 
> >>>> 
> >>>> If we add this to khugepaged, it will have some conflicts with my other 
> >>>> patchset. How about we move the functionality to khugepaged after these
> >>>> two sets get in? 
> >>> 
> >>> Is the last patch of the patchset essential? I think this part can be done
> >>> a bit later in a proper way, no?
> >> 
> >> Technically, we need this patch to regroup pmd mapped page, and thus get 
> >> the performance benefit after the uprobe is detached. 
> >> 
> >> On the other hand, if we get the first 4 patches of the this set and the 
> >> other set in soonish. I will work on improving this patch right after that..
> > 
> > Actually, it might be pretty easy. We can just call try_collapse_huge_pmd() 
> > in khugepaged.c (in khugepaged_scan_shmem() or khugepaged_scan_file() after 
> > my other set). 
> > 
> > Let me fold that in and send v5. 
> 
> On a second thought, if we would have khugepaged to do collapse, we need a
> dedicated bit to tell khugepaged which pmd to collapse. Otherwise, it may 
> accidentally collapse pmd that are split by other split_huge_pmd. 

Why is it a problem? Do you know a situation where such collapse possible
and will break split_huge_pmd() user's expectation. If there's such user
it is broken: normal locking should prevent such situation.

-- 
 Kirill A. Shutemov
