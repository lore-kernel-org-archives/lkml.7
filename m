Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2B4C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D75E21835
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/qz53e5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfLPU6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:58:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54543 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726275AbfLPU6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576529918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I5pwpugbvcPhx5HIZe/i1XJaYa2LrwKg/AuycQPjBPw=;
        b=U/qz53e5PfBSGwR+cA12LZNmsPrCDesiAex2B9sAjOJmZE+gVXpCLL7EcFB2n6g4jSDrmr
        y6xF+QysJQ4YwcaYhnsG/J73EBXxy6iNhakqYA9yX94qept7yM/Sgvy2RPdvPuiHvFyIdC
        J2DNxW8wb7dp76cAdCHqrJzzcCpEbcw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-wUfTHmq0OdiAmUyda6FvbQ-1; Mon, 16 Dec 2019 15:58:37 -0500
X-MC-Unique: wUfTHmq0OdiAmUyda6FvbQ-1
Received: by mail-qt1-f200.google.com with SMTP id g22so5496553qtr.23
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 12:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I5pwpugbvcPhx5HIZe/i1XJaYa2LrwKg/AuycQPjBPw=;
        b=FRUjd66leU2XImGuhLwdWFXyFSmDJLWpzc10198zGAeUWDAAd+9PXlYcHlgGORSM/+
         CVLXyqMVsITATrUCr5yvnOcsqjJsmFwYKWViQb3phmF4aH/RdmfpP2/6kIWFXWOfNE1O
         6yRa8Xsn/yEUE7r2XLLJwKIScwq+8b0yrVVX9xLd2atYtI5fL4LeT/kwPYryY9cCEhDP
         ECKj9C1oiRUV2+qnGjQ2PYxDT4GuMZl00AZ89e7vDipcLTFbR3U0mTAR3fwZv/0ceNVf
         mMZ6OMMss1CSek/lOxXBtxUX4VbTgoJqzk71OEdZPQscyJLH7bZ5x4D/omi/xB1a8DZM
         3t6A==
X-Gm-Message-State: APjAAAWsXNZTBCk/J/umxK09/+j8hSz1RXgUUPe09AoBlK3ZWSlmZDlk
        6uCd5n0rXVwgRtKwVZRa2jldBhW9LE7Fhb1BDIebe4UgDyS9zbFvA7LqR11PWaxPxD9JhTMUQR9
        9EQQLSn09xJ9pdORoUrDWlEBq
X-Received: by 2002:a05:620a:718:: with SMTP id 24mr1375216qkc.77.1576529915759;
        Mon, 16 Dec 2019 12:58:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTwkyU6Q4/8odVAHhOw4zGJwJ266SrjxU7PkBPT2stY0ZvTERV5XECgK3szqPte8OvZJxskg==
X-Received: by 2002:a05:620a:718:: with SMTP id 24mr1375199qkc.77.1576529915391;
        Mon, 16 Dec 2019 12:58:35 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id l31sm7254803qte.30.2019.12.16.12.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 12:58:34 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:58:33 -0500
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
Message-ID: <20191216205833.GB161272@xz-x1>
References: <20191204204823.1503-1-peterx@redhat.com>
 <20191211154058.GO2827@hirez.programming.kicks-ass.net>
 <20191211162925.GD48697@xz-x1>
 <20191216203705.GV2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216203705.GV2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 09:37:05PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 11, 2019 at 11:29:25AM -0500, Peter Xu wrote:
> > This is also true.
> > 
> > Here's the statistics I mentioned:
> > 
> > =================================================
> > 
> > (1) Implemented the same counter mechanism on the caller's:
> > 
> > *** arch/mips/kernel/smp.c:
> > tick_broadcast[713]            smp_call_function_single_async(cpu, csd);
> > *** drivers/cpuidle/coupled.c:
> > cpuidle_coupled_poke[336]      smp_call_function_single_async(cpu, csd);
> > *** kernel/sched/core.c:
> > hrtick_start[298]              smp_call_function_single_async(cpu_of(rq), &rq->hrtick_csd);
> > 
> > (2) Cleared the csd flags before calls:
> > 
> > *** arch/s390/pci/pci_irq.c:
> > zpci_handle_fallback_irq[185]  smp_call_function_single_async(cpu, &cpu_data->csd);
> > *** block/blk-mq.c:
> > __blk_mq_complete_request[622] smp_call_function_single_async(ctx->cpu, &rq->csd);
> > *** block/blk-softirq.c:
> > raise_blk_irq[70]              smp_call_function_single_async(cpu, data);
> > *** drivers/net/ethernet/cavium/liquidio/lio_core.c:
> > liquidio_napi_drv_callback[735] smp_call_function_single_async(droq->cpu_id, csd);
> > 
> > (3) Others:
> > 
> > *** arch/mips/kernel/process.c:
> > raise_backtrace[713]           smp_call_function_single_async(cpu, csd);
> 
> per-cpu csd data, seems perfectly fine usage.

I'm not sure whether I get the point, I just feel like it could still
trigger as long as we do it super fast, before IPI handled,
disregarding whether it's per-cpu csd or not.

> 
> > *** arch/x86/kernel/cpuid.c:
> > cpuid_read[85]                 err = smp_call_function_single_async(cpu, &csd);
> > *** arch/x86/lib/msr-smp.c:
> > rdmsr_safe_on_cpu[182]         err = smp_call_function_single_async(cpu, &csd);
> 
> These two have csd on stack and wait with a completion. seems fine.

Yeh this is true, then I'm confused why they don't use the sync()
helpers..

> 
> > *** include/linux/smp.h:
> > bool[60]                       int smp_call_function_single_async(int cpu, call_single_data_t *csd);
> 
> this is the declaration, your grep went funny
> 
> > *** kernel/debug/debug_core.c:
> > kgdb_roundup_cpus[272]         ret = smp_call_function_single_async(cpu, csd);
> > *** net/core/dev.c:
> > net_rps_send_ipi[5818]         smp_call_function_single_async(remsd->cpu, &remsd->csd);
> 
> Both percpu again.
> 
> > 
> > =================================================
> > 
> > For (1): These probably justify more on that we might want a patch
> >          like this to avoid reimplementing it everywhere.
> 
> I can't quite parse that, but if you're saying we should fix the
> callers, then I agree.
> 
> > For (2): If I read it right, smp_call_function_single_async() is the
> >          only place where we take a call_single_data_t structure
> >          rather than the (smp_call_func_t, void *) tuple.
> 
> That's on purpose; by supplying csd we allow explicit concurrency. If
> you do as proposed here:
> 
> >		I could
> >          miss something important, but otherwise I think it would be
> >          good to use the tuple for smp_call_function_single_async() as
> >          well, then we move call_single_data_t out of global header
> >          but move into smp.c to avoid callers from toucing it (which
> >          could be error-prone).  In other words, IMHO it would be good
> >          to have all these callers fixed.
> 
> Then you could only ever have 1 of then in flight at the same time.
> Which would break things.

Sorry, I think you are right.

> 
> > For (3): I didn't dig, but I think some of them (or future users)
> >          could still suffer from the same issue on retriggering the
> >          WARN_ON... 
> 
> They all seem fine.
> 
> So I'm thinking your patch is good, but please also fix all 1).

Sure.  Thanks,

-- 
Peter Xu

