Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADB4C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 23:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBA520449
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557012790;
	bh=qh4GWyx6IA4ISYVxjw7+RooUmFqfkX0HC1ZqwK7OyAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B/LLS5y1VarTLptieHgbjwGrE4498fkzubzVMQU9NBan3bigcC2O4XKgypGAYmx+t
	 kB+JIT+JFcIq/JEqVe+3NcZAH67poMm0pFrIL4pqjz3TbaBuK7H9wtyaNVhpjULCq3
	 oyVBrYJ63InBdx3LKbOAc1AtTvJttyjoB+nGhUcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfEDXdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 19:33:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:53068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbfEDXdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 19:33:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0BA5AEE3;
        Sat,  4 May 2019 23:33:06 +0000 (UTC)
Date:   Sat, 4 May 2019 19:33:02 -0400
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] signal: reorder struct sighand_struct
Message-ID: <20190504233302.GT29835@dhcp22.suse.cz>
References: <20190503192800.GA18004@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503192800.GA18004@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCing Oleg.

On Fri 03-05-19 22:28:00, Alexey Dobriyan wrote:
[...]
> add/remove: 0/0 grow/shrink: 8/68 up/down: 49/-1147 (-1098)
[...]
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -15,10 +15,10 @@
>   */
>  
>  struct sighand_struct {
> -	refcount_t		count;
> -	struct k_sigaction	action[_NSIG];
>  	spinlock_t		siglock;
> +	refcount_t		count;
>  	wait_queue_head_t	signalfd_wqh;
> +	struct k_sigaction	action[_NSIG];
>  };

Is it possible that this would cause false sharing of the cache line
that would have performance implications now?

-- 
Michal Hocko
SUSE Labs
