Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E86CC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A77207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573148219;
	bh=WYkdmBoVd2wyuEGWsQ+5wzEay2CjX7glRFYBTLk9U24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LYrbMhEAk+IrXskwYhBSQ/ZqVbtjrA3z+dfUW549YMnFLgBDjfnXKClrZrUrL4LNo
	 KWhVGd/7SQ9Zwill2uHmwF8SQKegnTb0Na/8cQXEyfMhKYoZHh6zLrLK/SZ9pZqUSF
	 cIRtRkFQ5dtBmJyFUWy+152msirwplh4oQX8kxGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfKGRg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:36:58 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40895 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbfKGRg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:36:57 -0500
Received: by mail-qv1-f68.google.com with SMTP id i3so931457qvv.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 09:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jnz13T5PvKAXfEd7CGomZWIateMaBfjZihfFaSqZe+A=;
        b=j8G3kn2DKWl7MPoDYCnrCS1bNY7JftX53zxK8B7X4p28wosoV2J6yUAnwY5gWr6AMy
         TU2mDefL3rjbolgzJAJjCNjry7/emQ4X/0nnaYDiLtUYUERq33HItzdwoYtJ1y5GD4hA
         qg2RwT1HQQGg+DnKTFES4jloEvwNg5pg4PepyI3yGccHH7M4aIkutJpZsm0dS7DWmpDO
         GXRocwk4TiZpBeTlivSzzpNAMx+GSZVnNZucYHB6+Sl/KBARKClncHFJp7vjje+xdbRn
         BRC4HMl3s1kWCl2qv2tcORllPW+K1k9s31lx5laTVrKvYtJvBQw1lgngXFW6AMeOKbVw
         8feQ==
X-Gm-Message-State: APjAAAXIPcYEgIkG0ub1mbnvBm6lEQ+sRb2cbX1LpIJHlRHwtGycrWeG
        IE3l4Z1at7UJPtyTHO90RrMbw2RLWhA=
X-Google-Smtp-Source: APXvYqxNG9Cczs1Pxdy0Pbc/LP+UYNN7aZFaWB0EOtvo6ib9mUP4KtrT3m0bEUYO9DWNI+rRFc23dA==
X-Received: by 2002:a0c:b88f:: with SMTP id y15mr4639681qvf.161.1573148216795;
        Thu, 07 Nov 2019 09:36:56 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:500::3:db5f])
        by smtp.gmail.com with ESMTPSA id u189sm1404705qkd.62.2019.11.07.09.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 09:36:55 -0800 (PST)
Date:   Thu, 7 Nov 2019 12:36:53 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] percpu-refcount: Use normal instead of RCU-sched"
Message-ID: <20191107173653.GA1242@dennisz-mbp>
References: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
 <20191107091319.6zf5tmdi54amtann@linutronix.de>
 <20191107161749.GA93945@dennisz-mbp>
 <20191107162842.2qgd3db2cjmmsxeh@linutronix.de>
 <20191107165519.GA99408@dennisz-mbp>
 <20191107172434.ylz4hyxw4rbmhre2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107172434.ylz4hyxw4rbmhre2@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 06:24:34PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-11-07 11:55:19 [-0500], Dennis Zhou wrote:
> > On Thu, Nov 07, 2019 at 05:28:42PM +0100, Sebastian Andrzej Siewior wrote:
> > > > I just want to clarify a little bit. Is this patch aimed at fixing an
> > > > issue with RT kernels specifically? 
> > > 
> > > Due to the implications of preempt_disable() on RT kernels it fixes
> > > problems with RT kernels.
> > > 
> > 
> > Great, do you mind adding this explanation with what the implications
> > are in the commit message?
> 
> some RCU section here invoke callbacks which acquire spinlock_t locks.
> This does not work on RT with disabled preemption.
> 

Yeah, so adding a bit in the commit message about why it's an issue for
RT kernels with disabled preemption as I don't believe this is an issue
for non-RT kernels.


> > > > It'd also be nice to have the
> > > > numbers as well as if the kernel was RT or non-RT.
> > > 
> > > The benchmark was done on a CONFIG_PREEMPT kernel. As said in the commit
> > > log, the numbers were mostly the same, I can re-run the test and post
> > > numbers if you want them.
> > > This patch makes no difference on PREEMPT_NONE or PREEMPT_VOLUNTARY
> > > kernels.
> > > 
> > 
> > I think a more explicit explanation in the commit message would suffice.
> 
> What do you mean by "more explicit explanation"? The part with the
> numbers or that it makes no difference for PREEMPT_NONE and
> PREEMPT_VOLUNTARY?
> 

I just meant the above, the benchmarking is fine.

Thanks,
Dennis
