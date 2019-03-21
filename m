Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADB0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C318F2190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfCUU7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:59:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39520 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfCUU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:59:39 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h74ml-0005nK-Py; Thu, 21 Mar 2019 21:59:36 +0100
Date:   Thu, 21 Mar 2019 21:59:35 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] workqueue: Use normal rcu
Message-ID: <20190321205935.7ndo5k5zumc77h37@linutronix.de>
References: <20190313165548.19713-1-bigeasy@linutronix.de>
 <20190313165548.19713-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190313165548.19713-2-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-13 17:55:47 [+0100], To linux-kernel@vger.kernel.org wrote:
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

A gentle ping.

Sebastian
