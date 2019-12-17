Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177B0C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB12621582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpRov7ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfLQPbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:31:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28907 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727552AbfLQPbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576596691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQZ59uXAMtxRWtQtFi+0EEfQLrBsNEJcWIBF1zY1XjY=;
        b=gpRov7iazavWcy9Rluk3p0PhZqjoKYdMI7V7fUk0J8sdySEAvA8g6Pip808tiSw1m+X6az
        t1AkHiGCArsfChAIwGkcfdMiUMKL8sLiztYt4yWI5ZxvimAF/Svg2v0jbj7FryU2j2rN9g
        IAunXswPxPEXXs9iLijgYuVB2CGRt6M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-JYuvgqUJOx6Eyio_Lci7YA-1; Tue, 17 Dec 2019 10:31:30 -0500
X-MC-Unique: JYuvgqUJOx6Eyio_Lci7YA-1
Received: by mail-qv1-f69.google.com with SMTP id a14so3969498qvy.23
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 07:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aQZ59uXAMtxRWtQtFi+0EEfQLrBsNEJcWIBF1zY1XjY=;
        b=HZVGMpYYSYlbG2jMVOpdXjw3ewpJShribz4zvMgHc5CH7q7uR0DDTcXTMDhdzVw1Hc
         CrWPuSWnzB4WETErA8L1xxwsUIsVsfcTuU62HgL5hjPtDMutMfLMoDsN5CjInyHz8MIX
         tzeKI/1NKsGWEl8LEwevgjMulRcsLqc3iPb/NWoc/7T8fllKeozfDB/LLjfnQerUrRBn
         nQb4oR6ekzb8a5wtzhT8S96zovHrLtC7rIjBQHYF/vkLYUH3bL8tAXdGwN7JAlY8MRx6
         CdDonzn8MKKzaD8QJtXxVGuSybe2/SRp5cc2s0DMwHH+XLrhrtxirhlbDB4EfUcRaLy8
         n4Aw==
X-Gm-Message-State: APjAAAV16etp3/MP34E0WjTtzlKDMSRKxwnx+xBTYjMp6p8Cmt+4G02c
        a7f8dGaXehFpUpHNOFvCslSUA/PpHzG1kw3pCg2HbD23lWn2wZu71eZDSaZVJWbU64URCnBUNHl
        cLrsXn+m3DLToh8AOzoicr1wC
X-Received: by 2002:ac8:508:: with SMTP id u8mr5094866qtg.128.1576596690096;
        Tue, 17 Dec 2019 07:31:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJKyoHGsSRgU0T1utkojggcn0UqYsM5ID+mx3lUgp5cxlfumKY/Jo78Nwtiow5zSoY2Q8WYw==
X-Received: by 2002:ac8:508:: with SMTP id u8mr5094849qtg.128.1576596689873;
        Tue, 17 Dec 2019 07:31:29 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id b42sm8448933qtb.36.2019.12.17.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:31:29 -0800 (PST)
Date:   Tue, 17 Dec 2019 10:31:28 -0500
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
Message-ID: <20191217153128.GB7258@xz-x1>
References: <20191204204823.1503-1-peterx@redhat.com>
 <20191211154058.GO2827@hirez.programming.kicks-ass.net>
 <20191211162925.GD48697@xz-x1>
 <20191216203705.GV2844@hirez.programming.kicks-ass.net>
 <20191216205833.GB161272@xz-x1>
 <20191217095156.GZ2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217095156.GZ2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:51:56AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 03:58:33PM -0500, Peter Xu wrote:
> > On Mon, Dec 16, 2019 at 09:37:05PM +0100, Peter Zijlstra wrote:
> > > On Wed, Dec 11, 2019 at 11:29:25AM -0500, Peter Xu wrote:
> 
> > > > (3) Others:
> > > > 
> > > > *** arch/mips/kernel/process.c:
> > > > raise_backtrace[713]           smp_call_function_single_async(cpu, csd);
> > > 
> > > per-cpu csd data, seems perfectly fine usage.
> > 
> > I'm not sure whether I get the point, I just feel like it could still
> > trigger as long as we do it super fast, before IPI handled,
> > disregarding whether it's per-cpu csd or not.
> 
> No, I wasn't paying attention last night. I'm thinking this one might
> maybe be in 1). It does the state check using that bitmap.

Indeed.  Though I'm not very certain to change this one too, since I'm
not sure whether that pr_warn is really intended:

        if (cpumask_test_and_set_cpu(cpu, &backtrace_csd_busy)) {
                pr_warn("Unable to send backtrace IPI to CPU%u - perhaps it hung?\n",
                        cpu);
                continue;
        }

I mean, that should depend on if it can really hang somehow (or it's
the same issue as what we're trying to fix)...  If it won't hang, then
it should be safe I think, and this pr_warn could be helpless after all.

> 
> > > > *** arch/x86/kernel/cpuid.c:
> > > > cpuid_read[85]                 err = smp_call_function_single_async(cpu, &csd);
> > > > *** arch/x86/lib/msr-smp.c:
> > > > rdmsr_safe_on_cpu[182]         err = smp_call_function_single_async(cpu, &csd);
> > > 
> > > These two have csd on stack and wait with a completion. seems fine.
> > 
> > Yeh this is true, then I'm confused why they don't use the sync()
> > helpers..
> 
> I suspect to be nice for virt. Both CPUID and MSR accesses can trap. but
> now I'm confused, because it is mostly WRMSR that traps.
> 
> Anyway, see the commit here: 07cde313b2d2 ("x86/msr: Allow rdmsr_safe_on_cpu() to schedule")

Yes that makes sense.  Thanks for the pointer.

However, then my next confusion is why they can't provide a common
solution to the smp code again... I feel like it could be even easier
(please see below).  I'm not very familiar with smp code yet, but if
it works it should benefit all callers imho.

diff --git a/kernel/smp.c b/kernel/smp.c
index dd31e8228218..7a1b163d1e4b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -307,11 +307,12 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 
        err = generic_exec_single(cpu, csd, func, info);
 
+       put_cpu();
+
+       /* If wait, csd is on stack so it's safe without get_cpu() */
        if (wait)
                csd_lock_wait(csd);
 
-       put_cpu();
-
        return err;
 }
 EXPORT_SYMBOL(smp_call_function_single);

Thanks,

-- 
Peter Xu

