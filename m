Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E168C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862CB20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1r9GGLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbfDYVXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:23:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42997 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfDYVXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:23:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so539280pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UKfv/+2hxNXo3G0f1rs2ctgRlkVqpH5iJye5M7jma6w=;
        b=f1r9GGLoERmtzgX/NQ/h4vSipA8uc+NFmDN3XAryLlX9f9A3Yka0gS20g/yJ2kYpot
         uUwVbj2+F+71B16gxNDqujSdvO0dx0mZL2k239u/Sbe3z/sMXo+zXx68WsRqdSw5TCvY
         HFTb3y2TqXLh1ajZSSOz+1foND/Gm4nHCLFx3vyHQ9yT70nVcv9tBi6kcdUSTdi6tJVK
         tjk0LLyLKJNydZKcGxwModVIsy2YeCbOhw/HZkDjKZqumc1e3FE/4uzz6mYc5Yjg7nQN
         4S6rUXlY0nqXb4mFvxE3O9SAUyCbMVbUrnVB3kNs1I5GxKXK/e3Lv+qI9nAnhSWmST+G
         1QsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UKfv/+2hxNXo3G0f1rs2ctgRlkVqpH5iJye5M7jma6w=;
        b=nBown/pzCx4h4fzLrGl7xyVrFUeo7AMFT2D746D7i6xMc85De2zmR/qiTQgFbD67dT
         /MIYV5QI4vZ26FuAOwftc1QqKvEWlQo7xOz7ilJ/7VY6XHE9AtAhKfUr4WI2MRpENm3t
         erRjKyAOuQZVcUo2lEQJWln9L7OExHEit91DIuFICfU/MZogFtQE2qmY9D52jCPGB+tc
         9T5RAVwEp0PtWj1oOJdmMJX79MbHXDvTSXN7Snir8IjdJ+7VOu4uOlH4GEIlKzzNxeSE
         Oo7DBC6myKdmiRRZbzZ1+RhBe/vn6ZBXlYdJ9zBRE24hzoiKIb6RoQjgG4rbIIEHoI5G
         QBYQ==
X-Gm-Message-State: APjAAAWJ6cAZpirx2euWkKAJPMXVDqdx+D7z/FnKeUboOCW7hvam6m2W
        5HfJBwCB6pjtpNqaOMsZ8Sc=
X-Google-Smtp-Source: APXvYqzVie7r3lbmW+CTkPcDRJdDxl/xLvMX4jWnfOd1LFW/Je6jVNB4DJED4nWMHpacQEVmpXIweA==
X-Received: by 2002:a63:e048:: with SMTP id n8mr39673496pgj.41.1556227422606;
        Thu, 25 Apr 2019 14:23:42 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::3cda])
        by smtp.gmail.com with ESMTPSA id y1sm26597209pgc.29.2019.04.25.14.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 14:23:41 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:23:40 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] bpf: Fix preempt_enable_no_resched() abuse
Message-ID: <20190425212338.zo3gzg4avfy6ukxf@ast-mbp.dhcp.thefacebook.com>
References: <20190419130304.GV14281@hirez.programming.kicks-ass.net>
 <20190419131522.GW14281@hirez.programming.kicks-ass.net>
 <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
 <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
 <20190423141714.GO11158@hirez.programming.kicks-ass.net>
 <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
 <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com>
 <20190423193435.GX4038@hirez.programming.kicks-ass.net>
 <88ba7be0-9ec5-941e-1b3f-80fbe05fe3a0@redhat.com>
 <20190423195559.GY4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423195559.GY4038@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 09:55:59PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 23, 2019 at 03:41:32PM -0400, Waiman Long wrote:
> > On 4/23/19 3:34 PM, Peter Zijlstra wrote:
> > > On Tue, Apr 23, 2019 at 03:12:16PM -0400, Waiman Long wrote:
> 
> > >> You are right on that. However, there is a variant called
> > >> preempt_enable_no_resched() that doesn't have this side effect. So I am
> > >> going to use that one instead.
> > > Only if the very next line is schedule(). Otherwise you're very much not
> > > going to use that function.
> > 
> > May I know the reason why. 
> 
> Because it can 'consume' a need_resched and introduces arbitrary delays
> before the schedule() eventually happens, breaking the very notion of
> PREEMPT=y (and the fundamentals RT relies on).
> 
> > I saw a number of instances of
> > preempt_enable_no_resched() without right next a schedule().
> 
> Look more closely.. and let me know, if true, those are bugs that need
> fixing.
> 
> Argghhh.. BPF...
> 
> Also, with the recent RCU rework, we can probably drop that
> rcu_read_lock()/rcu_read_unlock() from there if we're disabling
> preemption anyway.
> 
> ---
> Subject: bpf: Fix preempt_enable_no_resched() abuse
> 
> Unless the very next line is schedule(), or implies it, one must not use
> preempt_enable_no_resched(). It can cause a preemption to go missing and
> thereby cause arbitrary delays, breaking the PREEMPT=y invariant.
> 
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f02367faa58d..944ccc310201 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -510,7 +510,7 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
>  		}					\
>  _out:							\
>  		rcu_read_unlock();			\
> -		preempt_enable_no_resched();		\
> +		preempt_enable();			\
>  		_ret;					\

Applied to bpf tree. Thanks!
It should have been fixed long ago. Not sure how we kept forgetting about it.

