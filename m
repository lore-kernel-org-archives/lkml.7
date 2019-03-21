Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE19C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F280221916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="frXOmjtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfCUVJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:09:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39708 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfCUVJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mt9MxTKWlYPpGxuEe5DvXX3WJlApJzZCylUmBvmrers=; b=frXOmjtGV0uGp23OWPZkON+Ow
        DctxidM8Tj3v6VKMuPk6jcMJzLkQqnZMdSjk2Qc7C3+Tz2FdGM28HYONSh+g+xhfzLVy6x8ZMc4xu
        KK63AIqPQSQpCnSprgpysj85dkqC6Q0J9LwoTt2OfExEFIDcykFZJSv3+lxP3UHI2DkOb/lc/hBvj
        EFj7BhEEgawSlf2pxADJcQ5L6KNxGyncRAL8w855FoBcKMbsfbdS7fzYeZ4t97ZcJE0QO5b5KZOnX
        lusEV3MEW8NyuAT5w6q/G7r8jh98oJGEfn6uaLyugNlVOYSAshykvNpdyJPfpB4+KJuuYjeU63QRb
        AuSgRsAvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h74wb-0002d1-8y; Thu, 21 Mar 2019 21:09:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1469C984EEA; Thu, 21 Mar 2019 22:09:42 +0100 (CET)
Date:   Thu, 21 Mar 2019 22:09:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V2 06/23] perf/x86: Support constraint ranges
Message-ID: <20190321210942.GA7905@worktop.programming.kicks-ass.net>
References: <20190321205703.4256-1-kan.liang@linux.intel.com>
 <20190321205703.4256-7-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321205703.4256-7-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 01:56:46PM -0700, kan.liang@linux.intel.com wrote:
> From: Andi Kleen <ak@linux.intel.com>

That might be a stretch at this point...


> @@ -263,18 +268,25 @@ struct cpu_hw_events {
>  	void				*kfree_on_online[X86_PERF_KFREE_MAX];
>  };
>  
> -#define __EVENT_CONSTRAINT(c, n, m, w, o, f) {\
> +#define __EVENT_CONSTRAINT_RANGE(c, e, n, m, w, o, f) {	\
>  	{ .idxmsk64 = (n) },		\
>  	.code = (c),			\
> +	.size = (e) - (c),		\
>  	.cmask = (m),			\
>  	.weight = (w),			\
>  	.overlap = (o),			\
>  	.flags = f,			\
>  }
>  
> +#define __EVENT_CONSTRAINT(c, n, m, w, o, f) \
> +	__EVENT_CONSTRAINT_RANGE(c, c, n, m, w, o, f)
> +
>  #define EVENT_CONSTRAINT(c, n, m)	\
>  	__EVENT_CONSTRAINT(c, n, m, HWEIGHT(n), 0, 0)
>  
> +#define EVENT_CONSTRAINT_RANGE(c, e, n, m) \
> +	__EVENT_CONSTRAINT_RANGE(c, e, n, m, HWEIGHT(n), 0, 0)
> +

^ that one needs a comment that it doesn't work for AMD events.

>  #define INTEL_EXCLEVT_CONSTRAINT(c, n)	\
>  	__EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT, HWEIGHT(n),\
>  			   0, PERF_X86_EVENT_EXCL)
