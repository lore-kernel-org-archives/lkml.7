Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E3AC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E6320872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571198932;
	bh=bZ478axXOWGbKSBVZCgds71t4S8YiTYGO2WxDdTjZxw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Bmnhrolj96z9DntCRFLRhWc3YraVN/dUUtk9tNgRj/BkD+jlb+kxIm+pv68eyBDnS
	 A8RdwPbf+IH1WKUj9KNJUPJFoCq6PhYRcFWXDsyjyRwjSi1R3hHrbrf280op6vP6cb
	 Qc8K9dqYn/39+VyKSkwI9Yml8rF1GnO0UtlEkXZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfJPEIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 00:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728768AbfJPEIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 00:08:50 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FDFD2086A;
        Wed, 16 Oct 2019 04:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571198929;
        bh=bZ478axXOWGbKSBVZCgds71t4S8YiTYGO2WxDdTjZxw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LkG06i028kF5YE6DxVdcJvGeL2/PGNi6jCB+p1qyEpbMRNpD9IR4FB97kgEydM0SB
         7xp59ugZcBfSLWUs6xIGPM9ZbWXn2W4VEuR6H1HJ+yNRtuKRTe9hB3Kv7MtXkMErwg
         6jLk+2vpopRcl0IkN/vV+jukWiPhK9uzMMR7jrT4=
Date:   Tue, 15 Oct 2019 21:08:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: move rcu_{expedited,normal} definitions into
 rcupdate.h
Message-ID: <20191016040847.GE2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191015134822.28063-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015134822.28063-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 02:48:22PM +0100, Ben Dooks wrote:
> Move the rcu_{expedited,normal} definitions into rcupdate.h
> to make sure they are in sync, and avoid the following
> warning from sparse:
> 
> kernel/ksysfs.c:150:5: warning: symbol 'rcu_expedited' was not declared. Should it be static?
> kernel/ksysfs.c:167:5: warning: symbol 'rcu_normal' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Good point, queued for review and testing, thank you!

								Thanx, Paul

> ---
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: rcu@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/rcupdate.h | 4 ++++
>  kernel/rcu/update.c      | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 75a2eded7aa2..a175d6e3ad77 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -894,4 +894,8 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
>  	return false;
>  }
>  
> +/* kernel/ksysfs.c definitions */
> +extern int rcu_expedited;
> +extern int rcu_normal;
> +
>  #endif /* __LINUX_RCUPDATE_H */
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 1861103662db..294d357abd0c 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -51,9 +51,7 @@
>  #define MODULE_PARAM_PREFIX "rcupdate."
>  
>  #ifndef CONFIG_TINY_RCU
> -extern int rcu_expedited; /* from sysctl */
>  module_param(rcu_expedited, int, 0);
> -extern int rcu_normal; /* from sysctl */
>  module_param(rcu_normal, int, 0);
>  static int rcu_normal_after_boot;
>  module_param(rcu_normal_after_boot, int, 0);
> -- 
> 2.23.0
> 
