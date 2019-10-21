Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D17CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 00:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B994D21A4A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 00:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571618996;
	bh=QR09s6vtpFYE53JDOxSGUtkXPL4lrs4CX2UWNH0WmKM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=p2cXXKpN5tBGKdWhXDwE4mDPs8DsE+/IPMxpIkkB9EX6tSqCf2CpXUKhJafQYo6bR
	 3PSBrbUSvqOQmQ/H9WPkM7IUUuLokTcKUDg3Cj3HsGy0xDBM6mgfYU0NLrRo7YmOwD
	 G1nWFZwpA9ogWwsxbl+ARI5unARMf5B3eXMeDFSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfJUAtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 20:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfJUAtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 20:49:51 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FDE3218BA;
        Mon, 21 Oct 2019 00:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571618990;
        bh=QR09s6vtpFYE53JDOxSGUtkXPL4lrs4CX2UWNH0WmKM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dQQvIa5qK0T9YKeOi/rFNl7iXlGyHKTs5lKnSip0dBTVk+hu6ROqBptLZy566ki38
         PhbQL8eKY9j3cyTR6HEmnieoNdu8n3mUxk0VxlEy68TN55AZJtPUVmt8lMO0v/sOK/
         cLEQk9EoUzqvFB+gjv1g7lBYV0UiJc6ELCtKhXP8=
Date:   Sun, 20 Oct 2019 17:49:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        up2wing@gmail.com, wang.liang82@zte.com.cn
Subject: Re: [PATCH] rcu/rcu_segcblist: fix -Wmissing-prototypes warnings
Message-ID: <20191021004949.GN2588@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1571615395-3657-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1571615395-3657-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 07:49:55AM +0800, Yi Wang wrote:
> We get these warnings when build kernel W=1:
> kernel/rcu/rcu_segcblist.c:91:6: warning: no previous prototype for ‘rcu_segcblist_set_len’ [-Wmissing-prototypes]
> kernel/rcu/rcu_segcblist.c:107:6: warning: no previous prototype for ‘rcu_segcblist_add_len’ [-Wmissing-prototypes]
> kernel/rcu/rcu_segcblist.c:137:6: warning: no previous prototype for ‘rcu_segcblist_xchg_len’ [-Wmissing-prototypes]
> 
> Commit eda669a6a2c5 ("rcu/nocb: Atomic ->len field in rcu_segcblist
> structure") introduced this, and make the functions static to fix
> them.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

Good catch!

However, both Ben Dooks, commit 292d1bb2 ("rcu: Several rcu_segcblist
functions can be static"), and ultimately the kbuild test robot beat
you to it.  This commit is still in -rcu, but will be part of my pull
request to -tip in a couple of weeks.

							Thanx, Paul

> ---
>  kernel/rcu/rcu_segcblist.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 495c58c..cbc87b8 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -88,7 +88,7 @@ struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp)
>  }
>  
>  /* Set the length of an rcu_segcblist structure. */
> -void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
> +static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
>  {
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	atomic_long_set(&rsclp->len, v);
> @@ -104,7 +104,7 @@ void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
>   * This increase is fully ordered with respect to the callers accesses
>   * both before and after.
>   */
> -void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
> +static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
>  {
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	smp_mb__before_atomic(); /* Up to the caller! */
> @@ -134,7 +134,7 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp)
>   * with the actual number of callbacks on the structure.  This exchange is
>   * fully ordered with respect to the callers accesses both before and after.
>   */
> -long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
> +static long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
>  {
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	return atomic_long_xchg(&rsclp->len, v);
> -- 
> 1.8.3.1
> 
