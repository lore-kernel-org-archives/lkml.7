Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1B2083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvHsPOOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfCAW1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:27:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39934 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfCAW1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:27:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id i20so12056061pfo.6;
        Fri, 01 Mar 2019 14:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bEOgc4StkJSlGw9cw3sakcOvmcoT32vro6KU3cCF3QM=;
        b=uvHsPOOoi6BNA9U2Yy8QXQ5LqJE1dC7/OzbVpZrPPvRgHHzv6N9RHhM3B8/SezWEvg
         xuveq1fCjXgXOxy1OtxCAZGub6VjbaR1Z1+n7dOzoQf1/g8aVTXHMXB50Zcf/hiTIexz
         AxInHOrzAYtc8YH0NRfGxTA4iLNg3v2WjeDxf82RlftHu3NRIT9K77A628IDKw56S021
         9nNzwNzqBxGnT/shGMcFbBD763DYtEH8/jIHxyZw2Ta4u7osQcVhygmL8ND6x9Z0h2Qm
         eIFNcyRqTNg9T6KxhiKYCraJBz8Jv4kaivVZcJIW4pX4fkIJuDOQaVmhMgX2TAPLdP6l
         A9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bEOgc4StkJSlGw9cw3sakcOvmcoT32vro6KU3cCF3QM=;
        b=mypiWhw/HutebUupCt39cHte6ZwdbzU76/sHrPPQXX6FeDdd6sUCmaMnXKveUu7+wx
         7ewn73F1lyMNU57eNX5HQ2DVSqkM2Xox+JVR4SOvrxWPe64yM4na35Gm8Y/bKQIAuHZZ
         q8JXO9ZSMb9axTfJjLQJEOPQRCfQUwBt60cwkCnL0YwyMI1rTvfJsgf7O5NY/57zIsLx
         CmQX2CGG8LJghKEWOdggZEogmtvGGb7S1UzjT5If4yTiQg9ANS52IP6JGj5wOsh9rhmr
         +ECwYY2TazF7PCU44udjpPy1Y0vLTJvHPawDTac8pbeRE6yOuz1RvidWpfed4NhMAgmu
         5XIg==
X-Gm-Message-State: APjAAAUmn2Tio2Aa7/ZqkhaPC3AopIk4dv5+WJSHF+/W2RH9ktCaoJxF
        0J17jcnDwnKbqz2mwDEKV4M=
X-Google-Smtp-Source: APXvYqy2OkJOvf/Ac+FruHNGCd+AMzOT/Em8o//VY0AQ7fPoZbkYT9iCDXF0WbxuU79pG6iA1QnHFQ==
X-Received: by 2002:a63:1a5d:: with SMTP id a29mr6639223pgm.369.1551479261997;
        Fri, 01 Mar 2019 14:27:41 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p7sm11612236pfn.17.2019.03.01.14.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 14:27:40 -0800 (PST)
Date:   Fri, 1 Mar 2019 14:27:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: enable program stats
Message-ID: <20190301222739.GA24192@roeck-us.net>
References: <20190301220323.GA13770@roeck-us.net>
 <47e1aa53-61c9-653e-3958-3e47082887d0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47e1aa53-61c9-653e-3958-3e47082887d0@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 02:17:40PM -0800, Eric Dumazet wrote:
> 
> 
> On 03/01/2019 02:03 PM, Guenter Roeck wrote:
> > Hi,
> > 
> > On Mon, Feb 25, 2019 at 02:28:39PM -0800, Alexei Starovoitov wrote:
> >> JITed BPF programs are indistinguishable from kernel functions, but unlike
> >> kernel code BPF code can be changed often.
> >> Typical approach of "perf record" + "perf report" profiling and tuning of
> >> kernel code works just as well for BPF programs, but kernel code doesn't
> >> need to be monitored whereas BPF programs do.
> >> Users load and run large amount of BPF programs.
> >> These BPF stats allow tools monitor the usage of BPF on the server.
> >> The monitoring tools will turn sysctl kernel.bpf_stats_enabled
> >> on and off for few seconds to sample average cost of the programs.
> >> Aggregated data over hours and days will provide an insight into cost of BPF
> >> and alarms can trigger in case given program suddenly gets more expensive.
> >>
> >> The cost of two sched_clock() per program invocation adds ~20 nsec.
> >> Fast BPF progs (like selftests/bpf/progs/test_pkt_access.c) will slow down
> >> from ~10 nsec to ~30 nsec.
> >> static_key minimizes the cost of the stats collection.
> >> There is no measurable difference before/after this patch
> >> with kernel.bpf_stats_enabled=0
> >>
> > 
> > This patch causes my qemu tests for 'parisc' to crash. Reverting this patch
> > as well as "bpf: expose program stats via bpf_prog_info" fixes the problem.
> > 
> > Crash log and bisect results are attached. Bisect ends with the merge;
> > I identified the two patches manually.
> > 
> > I suspect that
> > 	prog->aux->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
> > 	...
> > 	u64_stats_init(&prog->aux->stats->syncp);
> > may be wrong. At the very least it looks odd, and I don't find a similar use
> > of u64_stats_init() anywhere else in the kernel.
> 
> Yes, a loop is needed there.
> 
> Something like :
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 1c14c347f3cfe1f7c0cf8a7eccff8135b16df81f..3f08c257858e1570339cd64a6351824bcc332ee3 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -109,6 +109,7 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
>  {
>         gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
>         struct bpf_prog *prog;
> +       int cpu;
>  
>         prog = bpf_prog_alloc_no_stats(size, gfp_extra_flags);
>         if (!prog)
> @@ -121,7 +122,12 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
>                 return NULL;
>         }
>  
> -       u64_stats_init(&prog->aux->stats->syncp);
> +       for_each_possible_cpu(cpu) {
> +               struct bpf_prog_stats *pstats;
> +
> +               pstats = per_cpu_ptr(prog->aux->stats, cpu);
> +               u64_stats_init(&pstats->syncp);
> +       }
>         return prog;
>  }
>  EXPORT_SYMBOL_GPL(bpf_prog_alloc);
> 

Yes, that works, or at least my test no longer crashes after applying the
above patch. Feel free to add

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter
