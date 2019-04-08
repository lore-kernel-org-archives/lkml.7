Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EBAC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E05A20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554752288;
	bh=oCZj0I6q+HNknBYs8/M9pFSRm3fQO+nY7ODd0WPZWu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vxx1I5YY5pgivrupMqyYjBJCHq8lvD7FdaDDaxD9u6AKKBpsS1PrGYG/sYCMYZLSF
	 Jlf9JxoeyVxcIlWd4VqwXMvSPCK5wR1g8xB2w8Ov9zltXfE5HnbvK/f6MCqWzgzaUQ
	 /5ULps+Eb/sDb36i3ZbEkWTjTtGE8TxjFznkllPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfDHTiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:38:07 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37512 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDHTiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:38:06 -0400
Received: by mail-yb1-f194.google.com with SMTP id p134so4936675ybc.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 12:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PlrrD0hKadd0rsLNpkqwRfBpObSey3Ho11gqeYD66us=;
        b=UvMo9ulVi7Ou9z2aXoNhHXGdSRajUFhxUfauEEwu3UvmKVBBDowJiRCphNCv4fB8Jt
         p9brI90+Fzs23xfXmAblZPUo97WMXOV2RKCaYM4hZpIyBp9a19D2BL48JhT3YqNZKxOe
         BoETtYLEWglixWPPe1Wd9+9p4OssmecWSZ8kmEmwZ7aiM8qDpl9gAKY818q5neLj/Joz
         sKwBwOUlFKdP4SyHjoxj66644aiJiE02nYv76lrEa90N5LL/ekUZH7DLA/Is7gDKajSc
         ojGJNjDceGRHFxFxvGEnUpVQNk3SXK9wH6M/GvM+eU3kZ1lPs7S77siW/P+IFEoVBBL1
         B7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PlrrD0hKadd0rsLNpkqwRfBpObSey3Ho11gqeYD66us=;
        b=DmRcmTII810aosa27O7Jbb6fPngtVUM9vb3CO0eR5hcBE49+hk81yYrMh/rz/q8rbf
         zDf1ohYe5w55M3J+AnhUkTSGE9b9AqedDY64J8ObI+GPDmv6JSpFhHpoS5l9KTLe/MXC
         Dq0TB4AxXETyoxRLeBbwDXah16hLvR2fQ9Nhk6Wv7akcIdBWvY9Q7++80w1qPBT/T/xY
         Y4Vw6KBZhntmMxzDD/GIkmuDdt3vrwtG9VKKbSXTjTxr1Q0yzGpH6Fm2bpE7TUCP4xI5
         CEF3Ptua9Nq2u/RiUOJ2IJFnPUxwi0zvOE7cABdhYoZKPlsc0JOFeOwRNtOWf+ai1J0q
         dsvw==
X-Gm-Message-State: APjAAAUf+gdDncIS1o7RaaMEKruw4YFKYrJCkFkNZbXkQdJZ238GiF0Q
        H7eilcwaZ2E1yvVDvUUplFQ=
X-Google-Smtp-Source: APXvYqzM4v9PrEeh76yvS2p1w93RgXeOHXSsjlRkpkFsc+XGuXmhdCLBS0T4kJ1CJDevI1wFp1DJwg==
X-Received: by 2002:a5b:50f:: with SMTP id o15mr23315004ybp.54.1554752285369;
        Mon, 08 Apr 2019 12:38:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:135c])
        by smtp.gmail.com with ESMTPSA id v123sm10915515ywv.89.2019.04.08.12.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:38:04 -0700 (PDT)
Date:   Mon, 8 Apr 2019 12:38:02 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] workqueue: Use normal rcu
Message-ID: <20190408193802.GJ1975820@devbig004.ftw2.facebook.com>
References: <20190313165548.19713-1-bigeasy@linutronix.de>
 <20190313165548.19713-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313165548.19713-2-bigeasy@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 05:55:47PM +0100, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> There is no need for sched_rcu. The undocumented reason why sched_rcu
> is used is to avoid a few explicit rcu_read_lock()/unlock() pairs by
> the fact that sched_rcu reader side critical sections are also protected
> by preempt or irq disabled regions.
> 
> Replace rcu_read_lock_sched with rcu_read_lock and acquire the RCU lock
> where it is not yet explicit acquired. Replace local_irq_disable() with
> rcu_read_lock(). Update asserts.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: mangle changelog a little]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to wq/for-5.2.

Thanks.

-- 
tejun
