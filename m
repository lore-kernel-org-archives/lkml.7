Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BB2C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E6C2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YodcmsOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfHPC6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:58:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41251 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfHPC6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:58:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so2196628pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 19:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YtVSxAhqmLmaZlh2TsP7vbj4SsCXa4o14qm4MdzQM3A=;
        b=YodcmsOmhsDjkCJOgPqbCLZnaJgBGEo+MVJs2tC8NwBzd56aDyXcNWFH+i+H7zCzhv
         A7LXPj1WbPPuJczkMLkUOBAgyc6SPn8IO3mWnir1sdXkeAlxg1lz7cdNJZBOGquPBSp7
         9YbjQptJUsoeUs33mfAPYNob6arq0fZcyxGtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YtVSxAhqmLmaZlh2TsP7vbj4SsCXa4o14qm4MdzQM3A=;
        b=CxcZlgQkqi+qPybZbRWqST4rHwhXU5qO+QunaOwcYoCb2W9C35T8BRkMaMrsJnntGG
         oQSYgosavPWjIa5x3GtSfRNMhl09hHSZWWHWD2+dEE8mVPzn97xil+tc7fFSf89suZRM
         isSMchugs0BaJgAA3089mJo8BYrL8EkDL3EajPgUFrqmj5RCQy/SvoyHUcWcZFhSeQgh
         psNUjNsFq67mUelHVoMjhwYnevyoqNsX2RFw3+GGS1G8pKZQGMYve9o47ovk9SIFdoJC
         dpuLx08swS+0T8ISzZMrLoc5JAp3Ef7VAElQMd6kYGo9lYeNf511qtnILJYcNoUnqa9Z
         tq5A==
X-Gm-Message-State: APjAAAXFTo5ZpanZrZeP79zyfIZLg6utbodpDzYVKpZOgM51L0KZf66s
        UL2QW1bn77PiDCCgjGkrFQ1lNOuvQEE=
X-Google-Smtp-Source: APXvYqw4/rZERyh5roKWAxzUuwlbuQc0ChvNdlv9/ntweB0nYScM+MYren8mxvM48laxtRbG0RoQxQ==
X-Received: by 2002:a62:1808:: with SMTP id 8mr8607111pfy.177.1565924294327;
        Thu, 15 Aug 2019 19:58:14 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id y16sm4283794pfn.173.2019.08.15.19.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 19:58:13 -0700 (PDT)
Date:   Thu, 15 Aug 2019 22:57:56 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        frederic@kernel.org
Subject: Re: [PATCH -rcu dev 2/3] rcu/tree: Fix issue where sometimes
 rcu_urgent_qs is not set on IPI
Message-ID: <20190816025756.GA242309@google.com>
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190816025311.241257-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816025311.241257-2-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:53:10PM -0400, Joel Fernandes (Google) wrote:
> Sometimes I see rcu_urgent_qs is not set. This could be when the last
> IPI was a long time ago, however, the grace period just started. Set
> rcu_urgent_qs so the tick can indeed be stopped.
Here I meant:
                                   not be stopped.

I will resend the patch as v2.
thanks,

 - Joel


> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 322b1b57967c..856d3c9f1955 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1091,6 +1091,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>  	if (tick_nohz_full_cpu(rdp->cpu) &&
>  		   time_after(jiffies,
>  			      READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
> +		WRITE_ONCE(*ruqp, true);
>  		resched_cpu(rdp->cpu);
>  		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
>  	}
> -- 
> 2.23.0.rc1.153.gdeed80330f-goog
> 
