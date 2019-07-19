Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FF3C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC242173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VuGnrjDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfGSNGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:06:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51894 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSNGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=do4VL4rnZdrQMVJNSrSfBRli7eL5EZ08Arm5F4ZNsI4=; b=VuGnrjDwUjwQIVnvsL9GbO/6p
        rktYnEp3YjvYI8j8S69bNiuBj/C0qwqcLK5NtRNJndaORhL/SKdnhSRV+Hja81YInHtqSUyqmonIu
        9lrscAM2svSP6sspjXS3u6+9r7xonEpDmyiXc90oU9sw4la7iWDxROD1khp05PdzFM/e6XevaXQqG
        7nK6jjZ0Wi4KhyTC4OoQ4piq/LZLuohHhCvegUcf4F7DLZUvW9qtG3tWYiaqxAmcmJb9ABjK0dZPx
        Q2XsAA/y78b4yN0KBJu5FmyFKzrV1ngczOwwYjEeWhC2a0a/RAkWrCahto274wq/0YDu5/Q1bq+0k
        I/W4oBCDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hoSag-0007rU-Ii; Fri, 19 Jul 2019 13:06:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 38F6D20197A71; Fri, 19 Jul 2019 15:06:24 +0200 (CEST)
Date:   Fri, 19 Jul 2019 15:06:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, pauld@redhat.com
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
Message-ID: <20190719130624.GK3419@hirez.programming.kicks-ass.net>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 09:58:23AM +0200, Vincent Guittot wrote:
> @@ -7887,7 +7908,7 @@ static inline int sg_imbalanced(struct sched_group *group)
>  static inline bool
>  group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
>  {
> -	if (sgs->sum_h_nr_running < sgs->group_weight)
> +	if (sgs->sum_nr_running < sgs->group_weight)
>  		return true;
>  
>  	if ((sgs->group_capacity * 100) >
> @@ -7908,7 +7929,7 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
>  static inline bool
>  group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
>  {
> -	if (sgs->sum_h_nr_running <= sgs->group_weight)
> +	if (sgs->sum_nr_running <= sgs->group_weight)
>  		return false;
>  
>  	if ((sgs->group_capacity * 100) <

I suspect this is a change you can pull out into a separate patch after
the big change. Yes it makes sense to account the other class' task
presence, but I don't think it is strictly required to be in this patch.
