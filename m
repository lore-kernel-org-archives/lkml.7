Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022DBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98992064A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LfNIE058"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfH0Vuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:50:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfH0Vuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FB8pN+BfPxkb7VhVcHVNo4pDuBs87uFREFm8kjgxbXI=; b=LfNIE0589Ir9nLcNlwkc4H5Gr
        q8+xmVwFYXlyGZIMD1twy/HYuEsVWkM29dacB5CxEQaq1LE+E7pmg0QDl8iIRE0VHaedB4giOhHJo
        G+1tmfRtbau8m8fboQbiuo0Z8g0G7blndf4vbOs3WOTS4jVAjTsk2JkiFV2N5NndH947kxdWc5OhT
        v2SvywIk5gES4IjtsmzvZ8FLv8b14R3I9Tv2QzchtvciiFiwBtf4rvuBzTHa4y9KaF6iJsPehkE3c
        prqkLJ7NwyJt6aJNR1/Jt1twuPjSbhBN6XH+Tlkv8o0e8yLxawYLmTeSWnGnUwrRErTNARwt6d91a
        9XSyawtYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2jMN-00033M-19; Tue, 27 Aug 2019 21:50:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6036330768B;
        Tue, 27 Aug 2019 23:50:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA5CF203CEC05; Tue, 27 Aug 2019 23:50:35 +0200 (CEST)
Date:   Tue, 27 Aug 2019 23:50:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190827215035.GH2332@hirez.programming.kicks-ass.net>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <20190827211417.snpwgnhsu5t6u52y@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827211417.snpwgnhsu5t6u52y@srcf.ucam.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 10:14:17PM +0100, Matthew Garrett wrote:
> Apple have provided a sysctl that allows applications to indicate that 
> specific threads should make use of core isolation while allowing 
> the rest of the system to make use of SMT, and browsers (Safari, Firefox 
> and Chrome, at least) are now making use of this. Trying to do something 
> similar using cgroups seems a bit awkward. Would something like this be 
> reasonable? 

Sure; like I wrote earlier; I only did the cgroup thing because I was
lazy and it was the easiest interface to hack on in a hurry.

The rest of the ABI nonsense can 'trivially' be done later; if when we
decide to actually do this.

And given MDS, I'm still not entirely convinced it all makes sense. If
it were just L1TF, then yes, but now...

> Having spoken to the Chrome team, I believe that the 
> semantics we want are:
> 
> 1) A thread to be able to indicate that it should not run on the same 
> core as anything not in posession of the same cookie
> 2) Descendents of that thread to (by default) have the same cookie
> 3) No other thread be able to obtain the same cookie
> 4) Threads not be able to rejoin the global group (ie, threads can 
> segregate themselves from their parent and peers, but can never rejoin 
> that group once segregated)
> 
> but don't know if that's what everyone else would want.
> 
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 094bb03b9cc2..5d411246d4d5 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -229,4 +229,5 @@ struct prctl_mm_map {
>  # define PR_PAC_APDBKEY			(1UL << 3)
>  # define PR_PAC_APGAKEY			(1UL << 4)
>  
> +#define PR_CORE_ISOLATE			55
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 12df0e5434b8..a054cfcca511 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2486,6 +2486,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			return -EINVAL;
>  		error = PAC_RESET_KEYS(me, arg2);
>  		break;
> +	case PR_CORE_ISOLATE:
> +#ifdef CONFIG_SCHED_CORE
> +		current->core_cookie = (unsigned long)current;

This needs to then also force a reschedule of current. And there's the
little issue of what happens if 'current' dies while its children live
on, and current gets re-used for a new process and does this again.

> +#else
> +		result = -EINVAL;
> +#endif
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;
> 
> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org
