Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20142C35280
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEB4206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qVn3MqVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfJHQab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:30:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38662 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfJHQab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:30:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so11075323pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jb1e68IiBAcctWybGAcBifRERsBYBG2XWgpUo+6+j8s=;
        b=qVn3MqVktxq2PUYzf97Mb1SsnXuU+CFrRmTeW9eaoQCcqc50A6TjepVChlhQLfxJZI
         eYrx9Up4Gdlbf5bIb8lWUhiLDhQAqDJWA7l6T0Xv4Icv/pU8iWZwMdT+a/XvwA0n+jnF
         56H1E9/RMO6FNRHq4K14CXMhUJ90a+rGI1IiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jb1e68IiBAcctWybGAcBifRERsBYBG2XWgpUo+6+j8s=;
        b=aCadKLwJoxKPjwLBm/Xs6wDs9ZI3LFCzeucKhcTUZ15KWWmxFOYGTFF0eYJgoabn+a
         9ilHQ4qDDCKp1L5Ov6RmGNoxOfyu/DImYoxJgpGRa+O5SjJCnU5iITnxg4VMgU1uWpeR
         NQAgNJI9ydJpPSzF3glM+8YrP++IkBXwQGuwAH3drfwqDECB/X4AGnwMNvbvSIxN8xxf
         armNtBshIbgUdjIV2EAg/6hJbCS62pri4DI+I81qJVD3EdgmVK2EszKJNEAB2hj2XTQt
         O3HP9G0Ktefp5xRoeU5s/H8Dy/Pcvv0MGId0L+d5yejWRLi5hr9iWhCSreVZAfKu/wyy
         7iYQ==
X-Gm-Message-State: APjAAAX9f/XslXCU0HU50iYPJxoW9IFeFCPyxIxZv+JFCT+cZIt6F9aL
        ZMinHlBH1TxqfMoiH76aop/l/A==
X-Google-Smtp-Source: APXvYqwjuiy6CnH1/xDdp+rt+p65xPZO6oE3SNppoNWoz7D5UyGsdWqbYJXadjf/wHbWyR+ZjUvoLw==
X-Received: by 2002:a63:60e:: with SMTP id 14mr10751012pgg.179.1570552230117;
        Tue, 08 Oct 2019 09:30:30 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l192sm25589080pga.92.2019.10.08.09.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 09:30:29 -0700 (PDT)
Date:   Tue, 8 Oct 2019 12:30:28 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, elver@google.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Avoid to modify mask_ofl_ipi in
 sync_rcu_exp_select_node_cpus()
Message-ID: <20191008163028.GA136151@google.com>
References: <20191008050145.4041702-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008050145.4041702-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 01:01:40PM +0800, Boqun Feng wrote:
> "mask_ofl_ipi" is used for iterate CPUs which IPIs are needed to send
> to, however in the IPI sending loop, "mask_ofl_ipi" along with another
> variable "mask_ofl_test" might also get modified to record which CPU's
> quiesent state can be reported by sync_rcu_exp_select_node_cpus(). Two
> variables seems to be redundant for such a propose, so this patch clean
> things a little by solely using "mask_ofl_test" for recording and
> "mask_ofl_ipi" for iteration. This would improve the readibility of the
> IPI sending loop in sync_rcu_exp_select_node_cpus().
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

>  kernel/rcu/tree_exp.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 69c5aa64fcfd..212470018752 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -387,10 +387,10 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
>  		}
>  		ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
>  		put_cpu();
> -		if (!ret) {
> -			mask_ofl_ipi &= ~mask;
> +		/* The CPU responses the IPI, and will report QS itself */
> +		if (!ret)
>  			continue;
> -		}
> +
>  		/* Failed, raced with CPU hotplug operation. */
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  		if ((rnp->qsmaskinitnext & mask) &&
> @@ -401,13 +401,12 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
>  			schedule_timeout_uninterruptible(1);
>  			goto retry_ipi;
>  		}
> -		/* CPU really is offline, so we can ignore it. */
> -		if (!(rnp->expmask & mask))
> -			mask_ofl_ipi &= ~mask;
> +		/* CPU really is offline, and we need its QS to pass GP. */
> +		if (rnp->expmask & mask)
> +			mask_ofl_test |= mask;
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	}
>  	/* Report quiescent states for those that went offline. */
> -	mask_ofl_test |= mask_ofl_ipi;
>  	if (mask_ofl_test)
>  		rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
>  }
> -- 
> 2.23.0
> 
