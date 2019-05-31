Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096AEC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0C426F21
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="AHSFVG4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfEaVIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:08:24 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40232 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfEaVIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:08:24 -0400
Received: by mail-qk1-f194.google.com with SMTP id c70so7211926qkg.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JT7dDjnTKBL9VZjxy4yAmtt7AKDxUXO0Wr5vb0mPuy8=;
        b=AHSFVG4T/EVCI+NTTlS/LFS1YdiMiSE69oFVhV4W20TnqP0nvTADRgdq57kiHdUd17
         GavVgP9o1ktb0SnZ/kSUFjfcVJzD9joMcQeduPHtmjIR/slEwFOjzDtXz6Q5YG8znHue
         qHQVr1yR0DjZoH1neQJ9vZLbyRHzzDDuQhBA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JT7dDjnTKBL9VZjxy4yAmtt7AKDxUXO0Wr5vb0mPuy8=;
        b=VW7SyPov6jTPkUpMSwgqWImctHTbS/TamVlM1N5q0/T7Yu/9b6VkKTRsD5SCqhBXFh
         iF/FAKSrcQ1Nf6CNuipMR1J0ADK2WXWxVzATvPKEjLdN4GIx4hl2odRm/J0kxEOwAHiV
         b7+78GnslteB8mOSLmeu2vBLTMVl+NTA6NwBMBk4or38kx0iZ1pAlQb3hp1CuyqJRJ18
         zEHD6fcTCTzhDnl/jwvkg/+IAzEDByjJhoRSuJH0vMueSiDiVtblq3AVT+sjA3LsAoTk
         J6EMVKs0Aqj8BfGfPc3/lesdFhu2PRIaQ/JQbXnepZeKjWX6QUQE2cRfC9yL1KmDR6Uk
         ecvw==
X-Gm-Message-State: APjAAAVuP1kkXIqtfsFJkryZPolKVs2QOY2yyFxPx81I8l21/jlsupP7
        zDnfet0eq8FKpGr3PiL3SGRSEw==
X-Google-Smtp-Source: APXvYqxrzdWw9pJNwyeOhVUNM92Ccg98D69X77yj0hNxXfUQh0J+i90hIL+nrb300PP+ItCPdFIZ6g==
X-Received: by 2002:ae9:c017:: with SMTP id u23mr10544052qkk.245.1559336903531;
        Fri, 31 May 2019 14:08:23 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id j37sm4256293qtb.76.2019.05.31.14.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 14:08:22 -0700 (PDT)
Date:   Fri, 31 May 2019 17:08:16 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190531210816.GA24027@sinkpad>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> My first reaction is: when shell wakes up from sleep, it will
> fork date. If the script is untagged and those workloads are
> tagged and all available cores are already running workload
> threads, the forked date can lose to the running workload
> threads due to __prio_less() can't properly do vruntime comparison
> for tasks on different CPUs. So those idle siblings can't run
> date and are idled instead. See my previous post on this:
> 
> https://lore.kernel.org/lkml/20190429033620.GA128241@aaronlu/
> (Now that I re-read my post, I see that I didn't make it clear
> that se_bash and se_hog are assigned different tags(e.g. hog is
> tagged and bash is untagged).
> 
> Siblings being forced idle is expected due to the nature of core
> scheduling, but when two tasks belonging to two siblings are
> fighting for schedule, we should let the higher priority one win.
> 
> It used to work on v2 is probably due to we mistakenly
> allow different tagged tasks to schedule on the same core at
> the same time, but that is fixed in v3.

I confirm this is indeed what is happening, we reproduced it with a
simple script that only uses one core (cpu 2 and 38 are sibling on this
machine):

setup:
cgcreate -g cpu,cpuset:test
cgcreate -g cpu,cpuset:test/set1
cgcreate -g cpu,cpuset:test/set2
echo 2,38 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems
echo 2,38 > /sys/fs/cgroup/cpuset/test/set1/cpuset.cpus
echo 2,38 > /sys/fs/cgroup/cpuset/test/set2/cpuset.cpus
echo 0 > /sys/fs/cgroup/cpuset/test/set1/cpuset.mems
echo 0 > /sys/fs/cgroup/cpuset/test/set2/cpuset.mems
echo 1 > /sys/fs/cgroup/cpu,cpuacct/test/set1/cpu.tag

In one terminal:
sudo cgexec -g cpu,cpuset:test/set1 sysbench --threads=1 --time=30
--test=cpu run

In another one:
sudo cgexec -g cpu,cpuset:test/set2 date

It's very clear that 'date' hangs until sysbench is done.

We started experimenting with marking a task on the forced idle sibling
if normalized vruntimes are equal. That way, at the next compare, if the
normalized vruntimes are still equal, it prefers the task on the forced
idle sibling. It still needs more work, but in our early tests it helps.

Thanks,

Julien
