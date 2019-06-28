Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE44C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA13208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561764861;
	bh=g9YbkwG7SrNhTyR0UmNnmc/Ncr7WQClKLPhmuGGOwSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RBtUT1bBIc0BvgtQJmiXaJ4N/qs0JEbhfqZDJbjRPZYWtTU7tX8uOy8jJxi+F1HPb
	 F3MN0dNdJNdwQybwY3VzSYdbpmM0bbRYwE38pJpLTfdPbCKiOYeGBojG9zb3Ylr1ab
	 cv2y5klYDxtX8CeDZvxOHlil33FmtlOzjVicCCoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfF1XeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 19:34:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32906 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfF1XeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 19:34:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id m4so3253399pgk.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 16:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KrgrAoIPZ1LQ1VyQOLNmxmRQwkVpu3ldX8C9irBrRvU=;
        b=FuXCRWTAM+9ahhxbr5qRNj6BgsiLoHnFWtS3E/mbYN3VEM9nacepKLwqukT6/a5DpQ
         8rGhoiGM77FVD5YSg8amgM2e4bGYcfvJ08VPz2iRAFW1jvApJZis32GTE2YhY2CrzFnP
         PC+VYJ7ZGK9aw2KYLwsjRaYWsB5cW7yQMB+9w29z9p5XaMDx2Q4u1ua1sLOdrpFU+b37
         EBXaa+OuUBn754W/1n1g2dWtzETfkn4sIt5Y/iN25C7NyOh3z2jCx+cNqAuK9kol6iOY
         oLXTY+eCtjUWMYBkPYAGHguhSSluwdMytMAf09GCumQXseLeqXfzkVpgpU1EzbNO/C30
         qpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KrgrAoIPZ1LQ1VyQOLNmxmRQwkVpu3ldX8C9irBrRvU=;
        b=VgEv4DuiWOFSm5/cB6cvm/l0Z3NCoFE8j0xIqD8VbULt7LRWsq2WnEH55HdUad/p4n
         FpM+KcTYYvnyhGogCRMfADDplk1dmRQrcCmOKo8pjdyra0J3P75J31aNNEfhXNEPJgtg
         5K00G8rYlAJQAE9Q3LhsudQaOtP5PDkU6wl3VaaNE0AWEDAOaxczYKNOwx+dkM4yN5Tx
         6gXWcjBFVXcRrrTvqcSYwW83QLiPceWrWKYZuZVqoHXVe5E3CZX4gcdQoJZd359Cambv
         rlA3lxgNBiti7Cze5BWWNwsJ7wAhcxuoONGoIQWxuIdZ4Tbflgvc8apuQW7bYqAt0SSG
         WIhw==
X-Gm-Message-State: APjAAAWUzzTJWxFscW9khBXxNGfRH4sAAj+aBkbKJgj0NVcNY5NwtDlB
        seGHqkU24WYIjcpdDz7xljyes1K2
X-Google-Smtp-Source: APXvYqxiEqYGkwyQWFFs2+k+3J5PBRG1DwCuUg4xTvxq530PkTHIrVLX01gAIyt/3/ykcFV26DI/mg==
X-Received: by 2002:a63:5b1d:: with SMTP id p29mr11179249pgb.297.1561764858832;
        Fri, 28 Jun 2019 16:34:18 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id e6sm3320634pfn.71.2019.06.28.16.34.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 16:34:17 -0700 (PDT)
Date:   Sat, 29 Jun 2019 08:34:13 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kuo-Hsin Yang <vovoy@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmscan: fix not scanning anonymous pages when
 detecting file refaults
Message-ID: <20190628233413.GA245333@google.com>
References: <20190619080835.GA68312@google.com>
 <20190627184123.GA11181@cmpxchg.org>
 <20190628065138.GA251482@google.com>
 <20190628142252.GA17212@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628142252.GA17212@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:22:52AM -0400, Johannes Weiner wrote:
> Hi Minchan,
> 
> On Fri, Jun 28, 2019 at 03:51:38PM +0900, Minchan Kim wrote:
> > On Thu, Jun 27, 2019 at 02:41:23PM -0400, Johannes Weiner wrote:
> > > On Wed, Jun 19, 2019 at 04:08:35PM +0800, Kuo-Hsin Yang wrote:
> > > > Fixes: 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache workingset transition")
> > > > Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
> > > 
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > 
> > > Your change makes sense - we should indeed not force cache trimming
> > > only while the page cache is experiencing refaults.
> > > 
> > > I can't say I fully understand the changelog, though. The problem of
> > 
> > I guess the point of the patch is "actual_reclaim" paramter made divergency
> > to balance file vs. anon LRU in get_scan_count. Thus, it ends up scanning
> > file LRU active/inactive list at file thrashing state.
> 
> Look at the patch again. The parameter was only added to retain
> existing behavior. We *always* did file-only reclaim while thrashing -
> all the way back to the two commits I mentioned below.

Yeah, I know it that we did force file relcaim if we have enough file LRU.
What I confused from the description was "actual_reclaim" part.
Thanks for the pointing out, Johannes. I confirmed it kept the old
behavior in get_scan_count.

> 
> > So, Fixes: 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache workingset transition")
> > would make sense to me since it introduces the parameter.
> 
> What is the observable behavior problem that this patch introduced?
> 
> > > forcing cache trimming while there is enough page cache is older than
> > > the commit you refer to. It could be argued that this commit is
> > > incomplete - it could have added refault detection not just to
> > > inactive:active file balancing, but also the file:anon balancing; but
> > > it didn't *cause* this problem.
> > > 
> > > Shouldn't this be
> > > 
> > > Fixes: e9868505987a ("mm,vmscan: only evict file pages when we have plenty")
> > > Fixes: 7c5bd705d8f9 ("mm: memcg: only evict file pages when we have plenty")
> > 
> > That would affect, too but it would be trouble to have stable backport
> > since we don't have refault machinery in there.
> 
> Hm? The problematic behavior is that we force-scan file while file is
> thrashing. We can obviously only solve this in kernels that can
> actually detect thrashing.

What I meant is I thought it's -stable material but in there, we don't have
refault machinery in v3.8.
I agree this patch fixes above two commits you mentioned so we should use it.
