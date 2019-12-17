Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5919EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BA021582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvku33vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfLQUsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:48:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32501 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727452AbfLQUsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576615724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1F9uJvS0v0ubviEmqIDODCQVEQuBsyDqVhFfI7iipD8=;
        b=fvku33vum4JnOt+5DY85fU+IVCEQM/whv+7nR2LpqkRw0160/BcxXTFSj2DnzvqewDuQha
        mGeGMluHFHGvVZ8xcntMrM7jKTsT2ciQ3Z36KcpW6rN3gxz2PpRbRc2PjONjGaK3PvKI9P
        j8hzcI76EZE2QCB/tqDGedzQsoxPB3E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-pZR7nh6XNnStCH5a9YqIMw-1; Tue, 17 Dec 2019 15:48:42 -0500
X-MC-Unique: pZR7nh6XNnStCH5a9YqIMw-1
Received: by mail-qk1-f200.google.com with SMTP id g28so7706108qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1F9uJvS0v0ubviEmqIDODCQVEQuBsyDqVhFfI7iipD8=;
        b=FrZtnpS2cJ2PWWfLHhc1uBa62fVUCnBB5Y32cF99WRrMh9sifVz65tsYuCN9mFnGIj
         /wujD+4GodM0j0tY+EWFgprlZM/gGBqx3xnOQDmukVO56O8qkcQ3zLTNh7sY6smHiXQm
         gwdSBPo4qIuWRYJ3TOkUtatIs7eV6KxUtYfgt2zhIuA0sqOQdakKTSv9Q0E39pIkneU9
         ChZOeO0yxbVSMv2eJjVVsN/vfjDEiW4+O4VttAfx/p7u5vnjQr1H+HNZVK/o9By3iWh1
         vErUSlm7fi2Xz8y3gkxxBXdDrsevodwIRa183gDvLu/qIekXgEXCPIgGI+E9p4KNHRrQ
         Tt1w==
X-Gm-Message-State: APjAAAV1id3UyVhf3y2PxZyBq8VneDLZVgPnQqWWY/IBNmYx2O5CkhvO
        TvaoEnLOzOvtr6kI7E2seRLuKMQvPJK6G9ZjPnQZKpq1FtIrwW7uOXuXnAfJp1Y6kvUvR4J0Qxz
        CQdCC1hfDlkEsG+2ZENXMt0qn
X-Received: by 2002:a37:bf83:: with SMTP id p125mr7349983qkf.165.1576615721933;
        Tue, 17 Dec 2019 12:48:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjNdUxpaAN0PG8ezaYAOX5jOFFTw8omtnZ/QPvdGqby2pFOod5W/PrTj2bhYCh1JrYBpxBOQ==
X-Received: by 2002:a37:bf83:: with SMTP id p125mr7349956qkf.165.1576615721637;
        Tue, 17 Dec 2019 12:48:41 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id o17sm8247126qtq.93.2019.12.17.12.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 12:48:40 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:48:39 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] smp: Allow smp_call_function_single_async() to insert
 locked csd
Message-ID: <20191217204839.GH7258@xz-x1>
References: <20191204204823.1503-1-peterx@redhat.com>
 <20191211154058.GO2827@hirez.programming.kicks-ass.net>
 <20191211162925.GD48697@xz-x1>
 <20191216203705.GV2844@hirez.programming.kicks-ass.net>
 <20191216205833.GB161272@xz-x1>
 <20191217095156.GZ2844@hirez.programming.kicks-ass.net>
 <20191217153128.GB7258@xz-x1>
 <20191217202352.GH2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217202352.GH2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 09:23:52PM +0100, Peter Zijlstra wrote:
> > > I suspect to be nice for virt. Both CPUID and MSR accesses can trap. but
> > > now I'm confused, because it is mostly WRMSR that traps.
> > > 
> > > Anyway, see the commit here: 07cde313b2d2 ("x86/msr: Allow rdmsr_safe_on_cpu() to schedule")
> > 
> > Yes that makes sense.  Thanks for the pointer.
> > 
> > However, then my next confusion is why they can't provide a common
> > solution to the smp code again... I feel like it could be even easier
> > (please see below).  I'm not very familiar with smp code yet, but if
> > it works it should benefit all callers imho.
> 
> Ah, so going to sleep on wait_for_completion() is _much_ more expensive
> than a short spin. So it all depends on the expected behaviour of the
> IPI I suppose.
> 
> In general we expect these IPIs to be 'quick'.
> 
> Also, as is, you're allowed to use the smp_call_function*() family with
> preemption disabled, which pretty much precludes using
> wait_for_completion().

Yes you are right, thanks!

Though I feel like previous small patch could still be an small
enhancement in that it at least shortened the get_cpu() period of
smp_call_function_single() without losing anything - so that could
still give the caller a chance to be scheduled out of the spinning at
some point when the IPI conditionally takes time to finish, imho.

-- 
Peter Xu

