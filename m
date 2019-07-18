Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4440C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC15B2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CxBHd/RX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390497AbfGRNVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:21:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37544 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390356AbfGRNVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:21:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id i70so2156668pgd.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VxIj7dTtj9q2yI2i58D0deKruMz+tclfFnwAic5jf9E=;
        b=CxBHd/RXkwlY3wwcWK9hjWpkRNa0WCIATIrV0fwaIBDVz73eRA425pTQu+L2AcyGKA
         lO6WF9C01QsmVGQCYbsCG/JqprRFd9wZgBmtu6El5pWbZ0r4u1jArEtFSsz8WzVYj2oO
         My8eo0wVW3fYzE3SiwsCS+tdc/l8SOqOGVyYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VxIj7dTtj9q2yI2i58D0deKruMz+tclfFnwAic5jf9E=;
        b=rjooPjZgRSm+SGNATCvjH50WcCzq7HkqyzL4pY9JStp7qa3VLQQYHrslUfAYVj/14n
         7+PmCv/5KUhH04y4dcf/0jBbq+An1GRojfJoH7TWQyQfChhXjvBUcZp3uNLhsP/BrwFd
         HmkC8ViymTp4JiBrnCJbZMZFfETpyCMyjs5XEstsTTPubB4N2QwnY02wqsl+KrWG9GeZ
         vtvp6h3DC0Hpo0JUf/XRlBiz6d+lkqkuYVwbPYKWTvdnlGwBFdrbWKZR9m9OJcKyOZPP
         KUaKQQZ9OpKVH4xBv6lkY6c27fqYM9mrP4dmFm6Qv40uI1w1UabQrSUyGvUwdvHIloro
         ZEcA==
X-Gm-Message-State: APjAAAVavgyOiAj6l/PdNoc2CDDFPjyrdLs2vnBHc4xjS0Ho/byJ4yzH
        1zF4epxucbm2vkrVkLyHmmY=
X-Google-Smtp-Source: APXvYqyXj8OhcWahZPu5wg4U4oMONsYLM3+qU7fC4rjCpXXlrXhjNWKXukegETCztH0gsrCQZ0Rt0g==
X-Received: by 2002:a63:494d:: with SMTP id y13mr48528915pgk.109.1563456076261;
        Thu, 18 Jul 2019 06:21:16 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w2sm21898289pgc.32.2019.07.18.06.21.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 06:21:15 -0700 (PDT)
Date:   Thu, 18 Jul 2019 09:21:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, rostedt@goodmis.org,
        luto@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        devel@etsukata.com
Subject: Re: [PATCH] stacktrace: Force USER_DS for stack_trace_save_user()
Message-ID: <20190718132114.GB116002@google.com>
References: <20190711114054.406765395@infradead.org>
 <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
 <20190717080725.GK3402@hirez.programming.kicks-ass.net>
 <b0a3406c-5de7-20e0-0f09-dbb7222426e2@oracle.com>
 <20190718085754.GM3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718085754.GM3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 10:57:54AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 17, 2019 at 10:09:45AM +0200, Vegard Nossum wrote:
> > On 7/17/19 10:07 AM, Peter Zijlstra wrote:
> 
> > > Does something like the below help?
> 
> > Yes.
> 
> Thanks!
> 
> ---
> Subject: stacktrace: Force USER_DS for stack_trace_save_user()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Jul 18 10:47:47 CEST 2019
> 
> When walking userspace stacks, we should set USER_DS, otherwise
> access_ok() will not function as expected.
> 
> Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
> Tested-by: Vegard Nossum <vegard.nossum@oracle.com>
> Reported-by: Eiichi Tsukata <devel@etsukata.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -226,12 +226,17 @@ unsigned int stack_trace_save_user(unsig
>  		.store	= store,
>  		.size	= size,
>  	};
> +	mm_segment_t fs;
>  
>  	/* Trace user stack if not a kernel thread */
>  	if (current->flags & PF_KTHREAD)
>  		return 0;
>  
> +	fs = get_fs();
> +	set_fs(USER_DS);
>  	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
> +	set_fs(fs);
> +
>  	return c.len;
>  }
>  #endif
