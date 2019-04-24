Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8600C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F68E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfDXLhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:37:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbfDXLhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:37:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5ED63B77F;
        Wed, 24 Apr 2019 11:37:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id CE6D25D705;
        Wed, 24 Apr 2019 11:37:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Apr 2019 13:37:05 +0200 (CEST)
Date:   Wed, 24 Apr 2019 13:37:04 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/sync: kill rcu_sync_type/gp_type
Message-ID: <20190424113704.GB16167@redhat.com>
References: <20190423120724.GA6132@redhat.com>
 <20190423193306.GU3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423193306.GU3923@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 24 Apr 2019 11:37:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23, Paul E. McKenney wrote:
>
> I wordsmithed the commit log and merged in the RCU-bh and RCU checks
> to rcu_sync_is_idle(), with the result shown below.  Does that work
> OK, or did I mess something up?

Yes, thanks!

the additional RCU-bh and RCU checks matches the "or introduce rcu_read_lock_any_held()"
note from the changelog, perhaps it makes some sense...

Just one nit below,

> - * Must be invoked within an RCU read-side critical section whose
> - * flavor matches that of the rcu_sync struture.
> + * Must be invoked within an RCU-sched read-side critical section.
                                ^^^^^^^^^

Given that the actual code:

>  static inline bool rcu_sync_is_idle(struct rcu_sync *rsp)
>  {
> -#ifdef CONFIG_PROVE_RCU
> -	rcu_sync_lockdep_assert(rsp);
> -#endif
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&
> +			 !rcu_read_lock_bh_held() &&
> +			 !rcu_read_lock_sched_held(),
> +			 "suspicious rcu_sync_is_idle() usage");

does RCU_LOCKDEP_WARN(!rcu_read_lock_any()) the comment should say

	Must be invoked within an RCU read-side critical section of
	any flavor

?

Oleg.

