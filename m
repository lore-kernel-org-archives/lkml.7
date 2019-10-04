Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12682C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4E7222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570227845;
	bh=XLwYCnID1Gf3Btqn0jMgJPQ36SrEYDwWDAvaaqYIRpg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=J1M8aRpcmVwNKXdmjbUr8fVeN6in3VT6ja/BQidCPGmTVgPb9wqzSH83Fi57ROwmL
	 4qA3jiTQHJ60qyFT4BIgdlqAN6dUPv0RRqdh4AoUGohyNbRCSZDUNDlNkKO8ztxyGK
	 CW376fps+c9J8d3/5hlk9vm8svNHmkiARPuPCn+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbfJDWYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfJDWYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:24:04 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CEA215EA;
        Fri,  4 Oct 2019 22:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570227844;
        bh=XLwYCnID1Gf3Btqn0jMgJPQ36SrEYDwWDAvaaqYIRpg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ef53b4zmNmdqBEhd58hMZWvdlCPF3zOjmLqFCoVjPmAywGSlj4E3vIjqy+EZ9sFnB
         9K+fB9KKSpOJEwKbi3ULvxm31b1T6e8dtSaZKg+g6j+t07Bkq97dnxYTZbI1LpySIn
         9mESkRUaR9eteI2kh09c7xWDmefbkjJ9mWuzUfWk=
Date:   Fri, 4 Oct 2019 15:24:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stefan Reiter <stefan@pimaker.at>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix dump_tree hierarchy print always active
Message-ID: <20191004222402.GQ2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191004194854.11352-1-stefan@pimaker.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004194854.11352-1-stefan@pimaker.at>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 07:49:10PM +0000, Stefan Reiter wrote:
> Commit 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if
> dump_tree") added print statements to rcu_organize_nocb_kthreads for
> debugging, but incorrectly guarded them, causing the function to always
> spew out its message.
> 
> This patch fixes it by guarding both pr_alert statements with dump_tree,
> while also changing the second pr_alert to a pr_cont, to print the
> hierarchy in a single line (assuming that's how it was supposed to
> work).
> 
> Fixes: 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if dump_tree")
> Signed-off-by: Stefan Reiter <stefan@pimaker.at>

Queued for testing and review, thank you!

> ---
> 
> First time contributing to the kernel, hope I'm doing this right :)

Looks good so far.  Then again, I just kicked off the tests.  ;-)

							Thanx, Paul

>  kernel/rcu/tree_plugin.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 2defc7fe74c3..7cbf4a0f3eff 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -2346,15 +2346,19 @@ static void __init rcu_organize_nocb_kthreads(void)
>  			nl = DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
>  			rdp->nocb_gp_rdp = rdp;
>  			rdp_gp = rdp;
> -			if (!firsttime && dump_tree)
> -				pr_cont("\n");
> -			firsttime = false;
> -			pr_alert("%s: No-CB GP kthread CPU %d:", __func__, cpu);
> +			if (dump_tree) {
> +				if (!firsttime)
> +					pr_cont("\n");
> +				firsttime = false;
> +				pr_alert("%s: No-CB GP kthread CPU %d:",
> +					 __func__, cpu);
> +			}
>  		} else {
>  			/* Another CB kthread, link to previous GP kthread. */
>  			rdp->nocb_gp_rdp = rdp_gp;
>  			rdp_prev->nocb_next_cb_rdp = rdp;
> -			pr_alert(" %d", cpu);
> +			if (dump_tree)
> +				pr_cont(" %d", cpu);
>  		}
>  		rdp_prev = rdp;
>  	}
> -- 
> 2.23.0
> 
> 
