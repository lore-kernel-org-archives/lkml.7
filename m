Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18976C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 04:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE152206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 04:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOfl1eEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfEDEVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 00:21:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41822 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfEDEVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 00:21:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id d9so3658460pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 21:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gt01AfOetDzcKf21xssimOsxGdNcsgRMqPBrhJOYNzE=;
        b=eOfl1eEEVF0oWu8cAyXB2JksYkfWv3I2Xdt1iddeZviy+41P+3a82jGGDvsvsm72hx
         e0hTUozh4BcA0FXITK6wR1UIUyK9uf9X/0NQ4iI2uMUTIvCX+DqOtpbvD2zWiobFvdcM
         1MUbWi9RyaSLgmSvYzeV5BkPWo3iAtdvzVELt+bz3Rc7ME5Yfk+8SYMraKvoHgIVxGkX
         DeLpIR4H+CDL7nPxX42cP8cm6cOfmTal7KXnyA0xBRb0iaMt0+YUCu8DCvKBZ4+yc5CI
         fpnE1czINVDd08K5kOSHIumwLLVh/YNpSPmI0QTI1eip7uCpkXeMdAdyu3Fxx+bElhX6
         L1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gt01AfOetDzcKf21xssimOsxGdNcsgRMqPBrhJOYNzE=;
        b=gBTE2INcJeYgxCF0oQvH34CQTkO3NHxKVCFcwkaXxtQ1rvBhXLxmsuvmCfprUeDYRG
         8ksnb7+TApYkGp5CMp6q3PexJYBLLEnoKH9Oz1VIa1dnyz1nmaWJ8CHly4m562ld7yEb
         iLO09KnxRR0aBPlFqCn1mme7qVlZeZ0dTLcgPyFyj4ebpLkGSn9P+VYSGXvOAuXL8TJ7
         GXivGWHU8EqR1wJiRgyj0x5keY/vOKA1/gx9TMyk6BhDZWKiDweMWVbho+Dc4gL0Gtmy
         qa1VlHUuttitn0zGk+BzL/CHcc9aIpc3Yluvuptd1YKGinrcYOD3Hf1rGWIS3hvhQBaH
         EDTw==
X-Gm-Message-State: APjAAAWRtK3rwchOAV2UfEivszYuCIAwRkSNdyussueILV0kfuD8S4oU
        DQGmD1pI+gMKFZHG/jkFHk4=
X-Google-Smtp-Source: APXvYqzlDKD4gHF5pi1mHed/Phhe76+FLoplbyj84ZnS/mRoEc06k/H7H4lsngXZf/kFFse7BSPRHg==
X-Received: by 2002:a17:902:7611:: with SMTP id k17mr16083398pll.30.1556943703221;
        Fri, 03 May 2019 21:21:43 -0700 (PDT)
Received: from localhost ([2601:640:d:fe8a:ec58:f256:b33e:bd28])
        by smtp.gmail.com with ESMTPSA id d126sm5225970pfc.96.2019.05.03.21.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 21:21:42 -0700 (PDT)
Date:   Fri, 3 May 2019 21:21:41 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v3 0/2] sys/prctl: expose TASK_SIZE value to userspace
Message-ID: <20190504042141.GA12920@yury-thinkpad>
References: <1556907021-29730-1-git-send-email-jsavitz@redhat.com>
 <20190503204912.GA5887@yury-thinkpad>
 <20190503215731.GB10302@x230.aquini.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503215731.GB10302@x230.aquini.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 05:57:31PM -0400, Rafael Aquini wrote:
> On Fri, May 03, 2019 at 01:49:12PM -0700, Yury Norov wrote:
> > On Fri, May 03, 2019 at 02:10:19PM -0400, Joel Savitz wrote:
> > > In the mainline kernel, there is no quick mechanism to get the virtual
> > > memory size of the current process from userspace.
> > > 
> > > Despite the current state of affairs, this information is available to the
> > > user through several means, one being a linear search of the entire address
> > > space. This is an inefficient use of cpu cycles.
> > > 
> > > A component of the libhugetlb kernel test does exactly this, and as
> > > systems' address spaces increase beyond 32-bits, this method becomes
> > > exceedingly tedious.
> > > 
> > > For example, on a ppc64le system with a 47-bit address space, the linear
> > > search causes the test to hang for some unknown amount of time. I
> > > couldn't give you an exact number because I just ran it for about 10-20
> > > minutes and went to go do something else, probably to get coffee or
> > > something, and when I came back, I just killed the test and patched it
> > > to use this new mechanism. I re-ran my new version of the test using a
> > > kernel with this patch, and of course it passed through the previously
> > > bottlenecking codepath nearly instantaneously.
> > > 
> > > As such, I propose that the prctl syscall be extended to include the
> > > option to retrieve TASK_SIZE from the kernel.
> > > 
> > > This patch will allow us to upgrade an O(n) codepath to O(1) in an
> > > architecture-independent manner, and provide a mechanism for future
> > > generations to do the same.
> > 
> > So the only reason for the new API is boosting some random poorly
> > written userspace test? Why don't you introduce binary search instead?
> >
> 
> there's no real cost in exposing the value that is known to the kernel,

Really? We all here used to think that kernel programming is one of
the most difficult professions in the world. There is huge cost of
proper implementation of a feature, careful review, spread testing on
various platforms and long-term maintenance and support.

In this specific example of exposing TASK_SIZE your team made too much
things wrong to realize it, I hope.

> anyways, as long as it's not a freaking hassle (like trying to go with
> this prctl(2) stunt). We just need to get it properly exported alongside
> other task's VM-related values at /proc/<pid>/status.

I found this thread thrilling. Please keep me in CC with your
/proc/<pid>/status effort.

Yury
  
> > Look at /proc/<pid>/maps. It may help to reduce the memory area to be
> > checked.
