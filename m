Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E679C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A6B21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558413599;
	bh=R6AaZKDQzbxKvCL4n1uO7b2P9kFuXmkU96r5m/kTwto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mbc4kDpbsFONojXd+yfN1atfPSryq6P09DGMNlBw5Btudqk5iQvfIOxV2yIoCUQ86
	 bzTt4+CWVJCwn/21sLPgnTmkMiq0JfRs9Cv33mensr8Fl4kLgD3XiYKX3Jnz7FAf0/
	 AzKFivpBFZJJpq4JqX6dcHRAHMbOgEREB0cxukoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfEUEj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:39:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40690 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfEUEj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:39:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so7890122pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 21:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QQkwhZ+FrBt0iCq5K6YROwDY4dt6/xx+/myXpnuTWx4=;
        b=QO5rQwSX4v25HATvAZksTfI6EjXr31E65ISg3wa7Rgi+45wh+Nc67s/QBio/bGiCxj
         XpXtutx7gPssH+Xd9sCjEzvAXWl+YYTuoMcSfqUB6YdCsqDiXmbCW/gEzauJ473iqGp+
         +kVbmM7thyPsWxY6WFV9RGiW3WLCVx/uv3vQHpy3NPuH/7R1CrZmIljMx9pvsxRuXkbc
         7SoMfs2fQkMEeDeNLJ3eNAzSQy4VDAMh4OrN9FQMY+8f8ARo/KGLQ7dX4UID1aDS3epb
         DbYbiaD39kGowIZ66+bRqNKIIsPg3h3p+/6PQAr9RDHCrsN+XINT4BdkIBXTqVSEWNnl
         OcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QQkwhZ+FrBt0iCq5K6YROwDY4dt6/xx+/myXpnuTWx4=;
        b=YHQpkg3rUWJdYbXOkw/7ElyDBuKAwvwOpyO32AjzoTb91eIsBgM2sUtFfL4ZdG7wxH
         /ZGUWDLhk0GWBBQC8L8FESXSuLTL4/aWqnqBibHpcsrfUFD3ri7sCJVw+KA0HDiaZuON
         jAPCYls8SRNPFMsnlcnUDZ7isVWGx9JW5GL/5wLkmvwO02r/AZs4qMpR8lNx/vAGCqw4
         xpjKYtksHslOHtRaBwYdz3qeWRA9VSyJVDf+L7wb9jCcjKJZzoUWcDbrs3a8cBjAGuYb
         BPTaZrx8ScECo3/MTNhCUHVdzDOdJoWclLxQZatIVE8G6reUQnrIgO2icDenOcQgH2rr
         E4CA==
X-Gm-Message-State: APjAAAXTM/sHzhGHGyvYhMsmP9Hsp0qQVkqgii+lqDh+EYDgcK5/YWH6
        HuAhECJhuiseLQo5wWEzrbU=
X-Google-Smtp-Source: APXvYqyhPph8JUAv8OXabcKgL76/7+E4blBN6RjxyY6+rf84o1rFnhmanK/CfaV5snMHaIbjmb0bnA==
X-Received: by 2002:a63:c64c:: with SMTP id x12mr78971864pgg.379.1558413596600;
        Mon, 20 May 2019 21:39:56 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id w12sm29519966pfj.41.2019.05.20.21.39.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 21:39:55 -0700 (PDT)
Date:   Tue, 21 May 2019 13:39:50 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
Message-ID: <20190521043950.GJ10039@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520164605.GA11665@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520164605.GA11665@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 12:46:05PM -0400, Johannes Weiner wrote:
> On Mon, May 20, 2019 at 12:52:47PM +0900, Minchan Kim wrote:
> > - Approach
> > 
> > The approach we chose was to use a new interface to allow userspace to
> > proactively reclaim entire processes by leveraging platform information.
> > This allowed us to bypass the inaccuracy of the kernel’s LRUs for pages
> > that are known to be cold from userspace and to avoid races with lmkd
> > by reclaiming apps as soon as they entered the cached state. Additionally,
> > it could provide many chances for platform to use much information to
> > optimize memory efficiency.
> > 
> > IMHO we should spell it out that this patchset complements MADV_WONTNEED
> > and MADV_FREE by adding non-destructive ways to gain some free memory
> > space. MADV_COLD is similar to MADV_WONTNEED in a way that it hints the
> > kernel that memory region is not currently needed and should be reclaimed
> > immediately; MADV_COOL is similar to MADV_FREE in a way that it hints the
> > kernel that memory region is not currently needed and should be reclaimed
> > when memory pressure rises.
> 
> I agree with this approach and the semantics. But these names are very
> vague and extremely easy to confuse since they're so similar.
> 
> MADV_COLD could be a good name, but for deactivating pages, not
> reclaiming them - marking memory "cold" on the LRU for later reclaim.
> 
> For the immediate reclaim one, I think there is a better option too:
> In virtual memory speak, putting a page into secondary storage (or
> ensuring it's already there), and then freeing its in-memory copy, is
> called "paging out". And that's what this flag is supposed to do. So
> how about MADV_PAGEOUT?
> 
> With that, we'd have:
> 
> MADV_FREE: Mark data invalid, free memory when needed
> MADV_DONTNEED: Mark data invalid, free memory immediately
> 
> MADV_COLD: Data is not used for a while, free memory when needed
> MADV_PAGEOUT: Data is not used for a while, free memory immediately
> 
> What do you think?

There are several suggestions until now. Thanks, Folks!

For deactivating:

- MADV_COOL
- MADV_RECLAIM_LAZY
- MADV_DEACTIVATE
- MADV_COLD
- MADV_FREE_PRESERVE


For reclaiming:

- MADV_COLD
- MADV_RECLAIM_NOW
- MADV_RECLAIMING
- MADV_PAGEOUT
- MADV_DONTNEED_PRESERVE

It seems everybody doesn't like MADV_COLD so want to go with other.
For consisteny of view with other existing hints of madvise, -preserve
postfix suits well. However, originally, I don't like the naming FREE
vs DONTNEED from the beginning. They were easily confused.
I prefer PAGEOUT to RECLAIM since it's more likely to be nuance to
represent reclaim with memory pressure and is supposed to paged-in
if someone need it later. So, it imply PRESERVE.
If there is not strong against it, I want to go with MADV_COLD and
MADV_PAGEOUT.

Other opinion?

