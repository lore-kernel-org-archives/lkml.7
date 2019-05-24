Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD51C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0D7217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558663878;
	bh=D13jiBJ+VSs17ODLOwtJTr5e9An3axUmYp32ec5lVQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fzR2UDFs+jl3zMF4s+hvCs0sYjZ2ph8/9Qfkxz8AesHRgNuTrd6+Wwh239YCX/DbE
	 BjdxbwxgdikObCYl1IKDNBjM2Wc8MpilY44QVblPXffeG6MPmwE5RdCBJENlSHMhsL
	 VBvrjqJ0o4gTK3JkWpFnkkzniNwLDLFOlpg22p7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbfEXCLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfEXCLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:11:17 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20460217D7;
        Fri, 24 May 2019 02:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558663876;
        bh=D13jiBJ+VSs17ODLOwtJTr5e9An3axUmYp32ec5lVQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eg8G5GoSTUOvP44MgTC5pa6Mn+vVwAuKHJ9ZipeRqwBvZhWdS+wXG48+MZVGqw9bP
         TgIOiITjOCm+kJfqiOiPcrrwJFA8kfMOO89HJEGLgF2FgNNkbzsughEIGmBlAFgKo4
         RPxF8rNzXnAmtF6ARJueN9B/WU6RVVVYNLdWsaxE=
Date:   Thu, 23 May 2019 19:11:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] signal: reorder struct sighand_struct
Message-Id: <20190523191115.66a4d57dc0ae991415fa131e@linux-foundation.org>
In-Reply-To: <20190504233302.GT29835@dhcp22.suse.cz>
References: <20190503192800.GA18004@avx2>
        <20190504233302.GT29835@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2019 19:33:02 -0400 Michal Hocko <mhocko@kernel.org> wrote:

> CCing Oleg.
> 
> On Fri 03-05-19 22:28:00, Alexey Dobriyan wrote:
> [...]
> > add/remove: 0/0 grow/shrink: 8/68 up/down: 49/-1147 (-1098)
> [...]
> > --- a/include/linux/sched/signal.h
> > +++ b/include/linux/sched/signal.h
> > @@ -15,10 +15,10 @@
> >   */
> >  
> >  struct sighand_struct {
> > -	refcount_t		count;
> > -	struct k_sigaction	action[_NSIG];
> >  	spinlock_t		siglock;
> > +	refcount_t		count;
> >  	wait_queue_head_t	signalfd_wqh;
> > +	struct k_sigaction	action[_NSIG];
> >  };
> 
> Is it possible that this would cause false sharing of the cache line
> that would have performance implications now?

Doesn't seem likely.  Possible .count vs .siglock, but .count only gets
altered by fork/exec-style code, so it's pretty low bandwidth.

