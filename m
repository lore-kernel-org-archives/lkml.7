Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8C9C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 21:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E594420833
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 21:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558214198;
	bh=yJSk1NIeZrHzHSFnPF2cJD8bD4fnPOPzDiTtUflbemM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PRJbyKXx0NpU5IuLErI7DL/c/ewVNtBK7tk9fNvVL+kdAjsmLpebIb0XnwKxrvYg/
	 xSzH4MHGLUmjVxXouinKLFSfRLAd5zbaud6OtIlqbZ+BfRDC2B1fh7Xkv802nZoAGi
	 c/+rE9oi/wzdKFle732BSKnkFSrfzNGlSGdks6vY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfERVQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 17:16:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36739 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfERVQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 17:16:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id j187so9609777wmj.1;
        Sat, 18 May 2019 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cXYOS4OOSBMv4Ps0Tiqsu4mWp1GxtDuXE3E/KT5J9/I=;
        b=uyYxczNureCbUUwGvYKMEfWyjymj/EM8IVIhJ6VJ6Bf6Q06xWNqUhjBcChE7N6xF76
         cwO14JKN/TJwHJerjNKEa7I26T8H/EIw+3/ZFTizPTsxBR0ZoBT1ZChYyYwCkc7UmWgi
         f77Dtj4mVQzLidXt/Zau1R89BkH0MPoqlQSqqiIYpsEmSK2OaaNM1TAk7tgrV1UYuZmg
         ffF5V1VgQqwFzv9WGX6RUjfOH3o3LNogroCwLtcMPmxN5Zl54Ge1kyEmz4miK+LLsr07
         NMwUyfHDResyKqRHZ0rO6Wwmll344+lJNKI6sRJjam96cLeTH6DzrTPkOt5l/AlQX23O
         RQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cXYOS4OOSBMv4Ps0Tiqsu4mWp1GxtDuXE3E/KT5J9/I=;
        b=lCcnLRi5ohSh4G1w17tRQ/JpYzI3xPvxu8Ju7GeC+xrmCqYANu9P3R8aOTL9RtmMTH
         6usYHCQfgKBzRYjIDmDd7YETBV6YGjxXXiDZ52kSdVUAnynXhHmLwma/XjrV6nI8uTRY
         SBuss2nD9yelm49A4DHTAhQc0T/XeH2anFKEkExSlgz7hJTju+kRmM2o5ScVa7Z/+z8G
         pXQcO7IyzVH4L4vhLk0U7U0cLCULQSz/JJhb1Uyn8qcF0LzMkZd5neVU5U6TkfdrRN/b
         DzTsABn6tkJ4Fg3FaSWrRI5WchOA/2jPJYGg+OfsqlLX6lmVZ7xB7UcPa+4TWFx+c4jP
         GVMQ==
X-Gm-Message-State: APjAAAU++u3MMczUsgLVYZFsrhrbM0aUvGInc5ojVFvKSb9HY4LlcsHZ
        4d7KwE2bNsTgjTAj6TI15mA=
X-Google-Smtp-Source: APXvYqz6Rf1bfpudSSsbbsRfT3sEXwYaBGH1ulyHiedeTtQakR8H4zI1d9YK3xiHWwlSe15RAxO0gA==
X-Received: by 2002:a1c:1941:: with SMTP id 62mr6668435wmz.100.1558214193195;
        Sat, 18 May 2019 14:16:33 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z8sm10927055wrs.84.2019.05.18.14.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 14:16:32 -0700 (PDT)
Date:   Sat, 18 May 2019 23:16:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     hpa@zytor.com, vincent.weaver@maine.edu, acme@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        eranian@google.com, tglx@linutronix.de, peterz@infradead.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/urgent] perf/x86/intel: Fix
 INTEL_FLAGS_EVENT_CONSTRAINT* masking
Message-ID: <20190518211630.GC51669@gmail.com>
References: <20190509214556.123493-1-eranian@google.com>
 <tip-6b89d4c1ae8596a8c9240f169ef108704de373f2@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-6b89d4c1ae8596a8c9240f169ef108704de373f2@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot for Stephane Eranian <tipbot@zytor.com> wrote:

> Commit-ID:  6b89d4c1ae8596a8c9240f169ef108704de373f2
> Gitweb:     https://git.kernel.org/tip/6b89d4c1ae8596a8c9240f169ef108704de373f2
> Author:     Stephane Eranian <eranian@google.com>
> AuthorDate: Thu, 9 May 2019 14:45:56 -0700
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Fri, 10 May 2019 08:04:17 +0200
> 
> perf/x86/intel: Fix INTEL_FLAGS_EVENT_CONSTRAINT* masking
> 
> On Intel Westmere, a cmdline as follows:
> 
>   $ perf record -e cpu/event=0xc4,umask=0x2,name=br_inst_retired.near_call/p ....
> 
> was failing. Yet the event+ umask support PEBS.
> 
> It turns out this is due to a bug in the the PEBS event constraint table for
> westmere. All forms of BR_INST_RETIRED.* support PEBS. Therefore the constraint
> mask should ignore the umask. The name of the macro INTEL_FLAGS_EVENT_CONSTRAINT()
> hint that this is the case but it was not. That macros was checking both the
> event code and event umask. Therefore, it was only matching on 0x00c4.
> There are code+umask macros, they all have *UEVENT*.
> 
> This bug fixes the issue by checking only the event code in the mask.
> Both single and range version are modified.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vince Weaver <vincent.weaver@maine.edu>
> Cc: kan.liang@intel.com
> Link: http://lkml.kernel.org/r/20190509214556.123493-1-eranian@google.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/events/perf_event.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 07fc84bb85c1..a6ac2f4f76fc 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -394,10 +394,10 @@ struct cpu_hw_events {
>  
>  /* Event constraint, but match on all event flags too. */
>  #define INTEL_FLAGS_EVENT_CONSTRAINT(c, n) \
> -	EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
> +	EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)
>  
>  #define INTEL_FLAGS_EVENT_CONSTRAINT_RANGE(c, e, n)			\
> -	EVENT_CONSTRAINT_RANGE(c, e, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
> +	EVENT_CONSTRAINT_RANGE(c, e, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)

This commit broke one of my testboxes - and unfortunately I noticed this 
too late and the commit is now upstream.

The breakage is that 'perf top' stops working altogether, it errors out 
in the event creation:

 $ perf top --stdio
 Error:
 The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles).

I bisected it back to this commit:

 6b89d4c1ae8596a8c9240f169ef108704de373f2 is the first bad commit
 commit 6b89d4c1ae8596a8c9240f169ef108704de373f2
 Author: Stephane Eranian <eranian@google.com>
 Date:   Thu May 9 14:45:56 2019 -0700

    perf/x86/intel: Fix INTEL_FLAGS_EVENT_CONSTRAINT* masking

The system is IvyBridge model 62, running a defconfig-ish kernel, and 
with perf_event_paranoid set to -1:

 [    3.756600] Performance Events: PEBS fmt1+, IvyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.

 processor	: 39
 vendor_id	: GenuineIntel
 cpu family	: 6
 model		: 62
 model name	: Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz
 stepping	: 4
 microcode	: 0x428

If I revert the commit 'perf top' starts working again.

Thanks,

	Ingo
