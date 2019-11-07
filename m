Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DC6C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEC72178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oxqtvIN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388986AbfKGPmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:42:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sQcFjgpx6TV06uR/K58BPWgeUoTItTYfSwgHTWOyYCE=; b=oxqtvIN/n9w8O0qEIbonqAVqQ
        PSUTG1nDwflONub5P5gHsTmp1fOXHGJj6tU5VuBdKrNxWvVNvdtJ98z9qOr49Cy4iZMN2Aw/Tztjh
        Igt2CZ8nG1FXv0KKWffX3FCHU3tNGitZlAU5L2p/1I+WNA5SR+zgtEE7Uc8VKOA72FBotYnKLjJHZ
        sp/+XhZ/9iycAD4c4QsPJZNQDQKCVH4CW0D+5wecVYv4G4x5H1LC6nMta9BTIhWgHPmcKor3o1lF2
        FHXrnmR0VaFi759CCMytpO+r6T3SSIFf9XXVtXts19T98AeZYSt1Xj+cRP+nltJyGs7z3c5sCghWx
        sg2OOgzPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSjvm-0006u4-CD; Thu, 07 Nov 2019 15:42:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B12B301747;
        Thu,  7 Nov 2019 16:41:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D056C2025EDB2; Thu,  7 Nov 2019 16:42:39 +0100 (CET)
Date:   Thu, 7 Nov 2019 16:42:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Quentin Perret <qperret@google.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191107154239.GE4114@hirez.programming.kicks-ass.net>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <79ecf426-8728-f36b-57ad-5948e5633ffb@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79ecf426-8728-f36b-57ad-5948e5633ffb@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 06:12:07PM +0300, Kirill Tkhai wrote:
> On 07.11.2019 16:26, Peter Zijlstra wrote:

> > Urgh... throttling.

> One more thing about current code in git. After rq->lock became able to
> be unlocked after put_prev_task() is commited, we got a new corner case.
> We usually had the same order for running task:
> 
>   dequeue_task()
>   put_prev_task()
> 
> Now the order may be reversed (this is also in case of throttling):
> 
>   put_prev_task() (called from pick_next_task())
>   dequeue_task()  (called from another cpu)
> 
> This is more theoretically, since I don't see a problem here. But there are
> too many statistics and counters in sched_class methods, that it is impossible
> to be sure all of them work as expected.

Hmm,.. where does throttling happen on a remote CPU? I through both
cfs-bandwidth and dl throttle locally.

Or are you talking about NO_HZ_FULL's sched_remote_tick() ?
