Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B1DCA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2742087E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572531059;
	bh=fVcJ1YoHP/ebgQ+YPr6vqVO+Ngjo3zOd7mH3hAZcT+M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=QrwWTcmVgn1CzF2ZQcoMP9CS7/Mns9jWbfnFtTHm58gjBj7tZWOC0nAnvHxv0mPt0
	 xj6Wzk1Bs2kITziup/dg+h9u7RDbaHsQX/Tk6MYthnRWdR2iUc+kx4/zDaFeMkqAD9
	 wAcpkoEkkBD+CjyiieYfgKgvxwmApYNm+mKb1agM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfJaOK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfJaOK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:10:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 114352080F;
        Thu, 31 Oct 2019 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572531057;
        bh=fVcJ1YoHP/ebgQ+YPr6vqVO+Ngjo3zOd7mH3hAZcT+M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lP06XwrLn3KR3FJCfDPcInfOUe/R4MEnV5PxQyqOCo9oKtgUb4HGqpX0wx9YJf5Sy
         q39pJht5ZhQOMaSqnpUEHoCJxlb/C7ABB8vfO4sy5CH2GaEaigj8vGOSll+xRzLgKm
         TTAXtLEufUpJBcegc+8WdQwkaXe+w9sKJ8Spe9ec=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C437A3520744; Thu, 31 Oct 2019 07:10:56 -0700 (PDT)
Date:   Thu, 31 Oct 2019 07:10:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 04/11] rcu: cleanup rcu_preempt_deferred_qs()
Message-ID: <20191031141056.GR20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-5-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031100806.1326-5-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 10:07:59AM +0000, Lai Jiangshan wrote:
> Don't need to set ->rcu_read_lock_nesting negative, irq-protected
> rcu_preempt_deferred_qs_irqrestore() doesn't expect
> ->rcu_read_lock_nesting to be negative to work, it even
> doesn't access to ->rcu_read_lock_nesting any more.
> 
> It is true that NMI over rcu_preempt_deferred_qs_irqrestore()
> may access to ->rcu_read_lock_nesting, but it is still safe
> since rcu_read_unlock_special() can protect itself from NMI.

Hmmm...  Testing identified the need for this one.  But I will wait for
your responses on the earlier patches before going any further through
this series.

							Thanx, Paul

> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  kernel/rcu/tree_plugin.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 82595db04eec..9fe8138ed3c3 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -555,16 +555,11 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>  static void rcu_preempt_deferred_qs(struct task_struct *t)
>  {
>  	unsigned long flags;
> -	bool couldrecurse = t->rcu_read_lock_nesting >= 0;
>  
>  	if (!rcu_preempt_need_deferred_qs(t))
>  		return;
> -	if (couldrecurse)
> -		t->rcu_read_lock_nesting -= RCU_NEST_BIAS;
>  	local_irq_save(flags);
>  	rcu_preempt_deferred_qs_irqrestore(t, flags);
> -	if (couldrecurse)
> -		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
>  }
>  
>  /*
> -- 
> 2.20.1
> 
