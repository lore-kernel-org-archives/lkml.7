Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9689FC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FCA21555
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BV0w8QAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfLDQEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:04:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33463 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfLDQEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:04:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so100658pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eByo4q9faNp6zGI9FakktXazM1EDxbjClMkzxr8m7r0=;
        b=BV0w8QAZZ5xXily8kG1uCAy00f3Fo9uhHJ6ajdFZpadL45LzYbAWAFq9Zmqnts4hCo
         IgZU7ZQjc4RvQqz7ENmpIgYdYDaszImbpYkyNK+CjCELQeCY/J7WzCrJ1EX8+YcFsBvz
         Ta/bfolTf0p/NzXzMT+8JaLPdoLKYluBojmjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eByo4q9faNp6zGI9FakktXazM1EDxbjClMkzxr8m7r0=;
        b=F5NbdsMUwVaWCVCnayXil5fnozj8sXc99vhpOicmrGvYp/KcQUR9ruZUMqRxSEAORx
         U5RsxnQk2r8bR464Wnm39fIijqsjYkslT3G1wVGs46TaVBhBuGLeXJWkxmRumrv1BjJA
         AAYeMo6RmteBm1hxqfjuhf06Amk8PEwN6QndEPRjXCQLvm96P1aLduO3m27FrGlVRmDW
         OPJ+ctWJqa3zKFFp1hEbMtGMvadFKKwgsHfvakHFlfly23F3x1KtiAK8nTaYvbWXuc5A
         yeF3m71ZwTustBwqQw6V0v/zoQyws7K9STco3P2rRINKUrFcLJWIK6/1YrRxdeC2UPQD
         oHWw==
X-Gm-Message-State: APjAAAVxHRmn23bcjO1ZH4EBy+3VA+LGazvjrl2KbLc8qdAGtc1g5Vve
        VwaTyK2X6GcrF9MgQxJpnoUJpFTNbhU=
X-Google-Smtp-Source: APXvYqwYZ6RInRzgXvlj/cFCMRejFpnNht5sE2GGDmMGO+ouJL7B/qBhkYEoAxyP90L6dPIAl4JAyg==
X-Received: by 2002:a63:c103:: with SMTP id w3mr4273542pgf.275.1575475449097;
        Wed, 04 Dec 2019 08:04:09 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g10sm8073496pgh.35.2019.12.04.08.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 08:04:08 -0800 (PST)
Date:   Wed, 4 Dec 2019 11:04:07 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Antonio Borneo <antonio.borneo@st.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] tracing: Fix printing ptrs in preempt/irq enable/disable
 events
Message-ID: <20191204160407.GB17404@google.com>
References: <20191127154428.191095-1-antonio.borneo@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127154428.191095-1-antonio.borneo@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 04:44:28PM +0100, Antonio Borneo wrote:
> This tracing event class is the only instance in kernel that logs
> in the trace buffer the instruction pointer as offset to _stext,
> instead of logging the full pointer.
> This looks like a nice optimization for 64 bits platforms, where a
> 32 bit offset can take less space than a full 64 bits pointer. But
> the symbol _stext is incorrectly resolved as zero in the expansion

I didn't get this. If _stext is 0 on any platform, then your patch doesn't
really do anything because the offset will be equal to the ip.

Could you provide an example with real numbers showing the overflow?

> of TP_printk(), which then prints only the hex offset instead of
> the name of the caller function. Plus, on arm arch the kernel
> modules are loaded at address lower than _stext, causing the u32
> offset arithmetics to overflow and wrap at 32 bits.

If we use signed 32-bit, will that solve the module issue?

> I did not identified a 64 bit arch where the modules are loaded at
> offset from _stext that exceed u32 range, but I also did not
> identified any constraint to feel safe with a u32 offset.
> 
> Log directly the instruction pointer instead of the offset to
> _stext.

I am not comfortable with this patch at the moment, mainly because it will
increase the size of this rather high frequency event. But I'm not saying
there isn't an issue on 32-bit. Let's discuss more.

thanks,

 - Joel


> 
> Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
> Fixes: d59158162e03 ("tracing: Add support for preempt and irq enable/disable events")
> ---
>  include/trace/events/preemptirq.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/trace/events/preemptirq.h b/include/trace/events/preemptirq.h
> index 95fba0471e5b..d548a6aafa18 100644
> --- a/include/trace/events/preemptirq.h
> +++ b/include/trace/events/preemptirq.h
> @@ -18,18 +18,18 @@ DECLARE_EVENT_CLASS(preemptirq_template,
>  	TP_ARGS(ip, parent_ip),
>  
>  	TP_STRUCT__entry(
> -		__field(u32, caller_offs)
> -		__field(u32, parent_offs)
> +		__field(unsigned long, caller_ip)
> +		__field(unsigned long, parent_ip)
>  	),
>  
>  	TP_fast_assign(
> -		__entry->caller_offs = (u32)(ip - (unsigned long)_stext);
> -		__entry->parent_offs = (u32)(parent_ip - (unsigned long)_stext);
> +		__entry->caller_ip = ip;
> +		__entry->parent_ip = parent_ip;
>  	),
>  
>  	TP_printk("caller=%pS parent=%pS",
> -		  (void *)((unsigned long)(_stext) + __entry->caller_offs),
> -		  (void *)((unsigned long)(_stext) + __entry->parent_offs))
> +		  (void *)__entry->caller_ip,
> +		  (void *)__entry->parent_ip)
>  );
>  
>  #ifdef CONFIG_TRACE_IRQFLAGS
> -- 
> 2.24.0
> 
