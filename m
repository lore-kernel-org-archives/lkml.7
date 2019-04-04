Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C17C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F71206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq/Rob6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfDDSCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:02:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41531 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:02:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so4918196wrq.8;
        Thu, 04 Apr 2019 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R/X4KGAOrn8p8WQqB1vXISXlABvnNdOPZ+VNYM7eKxQ=;
        b=Pq/Rob6fl9+mgNPaqkz+hZb6gyvwIOSKFjjR4WCxyc6a4toWH35GLCqNm0qyGz6N3H
         jM9UsyjfHrVzppB83zup1HMTcwrae3YwQRXxrAH+nbg0cSH+c2tPS9IihZd+BqYz4pAe
         tTC434P1srDQXRapSvV0ASzOVg2cctTl7WLqoA+6usTwp0dqx/yRVYQ929M3QfSdc13B
         +uub+Z1z299qP+eXH2RjiSE+9ZtQ4RaJ1jilZHHSf97PeyiQ0dKj2D5iDODQrA/PnbpI
         9f5CyXK4JZtjGu2NbXoM/aOabcpc5BQT5BaVYhqRbPaZbnZlndj3y8roXS7VnY25L/NC
         Qw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R/X4KGAOrn8p8WQqB1vXISXlABvnNdOPZ+VNYM7eKxQ=;
        b=ewbjDCMicTwOX8F5gQcqyrAvupPK/LF7L2HrCuG9SsLpnmmA7uleUPJw1GC/BNcrxS
         w/SPJPPut37jb5GZ9F6/zTm3NcP66gOAtfXbUj2uLwquBmyH1h60Ytk+RRF4P5hP4tjH
         IAZDRHgAdexF2WbX0uA5smN0u2qj6wKAfPgSKD8UUH5Mat6IRIziOq0CqN7PdpvVd6AD
         pX5j0NLZ9ZnKPtnjPulfkVBfikt5Zp8apWGRKOrq6PFWkJxRnd1lP7puhj0aGTab+oze
         OVQnkXP+ho75B/Uh8ISroV77d1fFuQMC7v4jiz91OR0wstz637LpBkGwe5RL1LL+AKvn
         34iQ==
X-Gm-Message-State: APjAAAUbd+zgiRhlr8fF00zUahDgvk65i/e/u6yw237A0kCqsSWSq8z/
        xWSJOySVAp51cXL6OCfNtj+w/SU=
X-Google-Smtp-Source: APXvYqzMLMCGZf/jBI+eGteTBl6iusSyHxc2JQr7omHxsX1FS8+g7oeITb8eApMVBLtrfSF1WklqNQ==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr5399467wrn.51.1554400954052;
        Thu, 04 Apr 2019 11:02:34 -0700 (PDT)
Received: from avx2 ([46.53.242.20])
        by smtp.gmail.com with ESMTPSA id 61sm68054247wre.50.2019.04.04.11.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 11:02:32 -0700 (PDT)
Date:   Thu, 4 Apr 2019 21:02:30 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] sched/core: expand sched_getaffinity(2) to return number
 of CPUs
Message-ID: <20190404180230.GA14800@avx2>
References: <20190403200809.GA13876@avx2>
 <20190404084249.GS4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404084249.GS4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:42:49AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 03, 2019 at 11:08:09PM +0300, Alexey Dobriyan wrote:
> > Currently there is no easy way to get the number of CPUs on the system.
> 
> And this patch doesn't change that :-)

It does! Application or a library could do one idempotent system call
in a constructor.

> Still, it does the right thing and I like it.

Thanks.

> The point is that nr_cpu_ids is the length of the bitmap, but does not
> contain information on how many CPUs are in the system. Consider the
> case where the bitmap is sparse.

I understand that but how do you ship number of CPUs _and_ possible mask
in one go?

> > Applications are divided into 2 groups:
> > One group allocates buffer and call sched_getaffinity(2) once. It works
> > but either underallocate or overallocates and in the future such application
> > will become buggy as Linux will start working on even more SMP-ier systems.
> > 
> > Glibc in particular shipped with 1024 CPUs support maximum at some point
> > which is quite surprising as glibc maitainers should know better.
> > 
> > Another group dynamically grow buffer until cpumask fits. This is
> > inefficient as multiple system calls are done.
> > 
> > Nobody seems to parse "/sys/devices/system/cpu/possible".
> > Even if someone does, parsing sysfs is much slower than necessary.
> 
> True; but I suppose glibc already does lots of that anyway, right? It
> does contain the right information.

sched_getaffinity(3) does sched_getaffinity(2) + memset()

sysconf(_SC_NPROCESSORS_ONLN) does "/sys/devices/system/cpu/online"

sysconf(_SC_NPROCESSORS_CONF) does readdir("/sys/devices/system/cpu")
which is 5 syscalls. I'm not sure which cpumask readdir represents.

> > Patch overloads sched_getaffinity(len=0) to simply return "nr_cpu_ids".
> > This will make gettting CPU mask require at most 2 system calls
> > and will eliminate unnecessary code.
> > 
> > len=0 is chosen so that
> > * passing zeroes is the simplest thing
> > 
> > 	syscall(__NR_sched_getaffinity, 0, 0, NULL)
> > 
> >   will simply do the right thing,
> > 
> > * old kernels returned -EINVAL unconditionally.
> > 
> > Note: glibc segfaults upon exiting from system call because it tries to
> > clear the rest of the buffer if return value is positive, so
> > applications will have to use syscall(3).
> > Good news is that it proves noone uses sched_getaffinity(pid, 0, NULL).
> 
> This also needs a manpage update. And I'm missing the libc people on Cc.

[nods]
Shipping "man/2/" with kernel is long overdue. :^)

> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4942,6 +4942,9 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
> >  	int ret;
> >  	cpumask_var_t mask;
> >  
> > +	if (len == 0)
> > +		return nr_cpu_ids;
> > +
> >  	if ((len * BITS_PER_BYTE) < nr_cpu_ids)
> >  		return -EINVAL;
> >  	if (len & (sizeof(unsigned long)-1))
