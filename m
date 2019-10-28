Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6190CCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5EE218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F46ev0SL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbfJ1VtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:49:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34352 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbfJ1VtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y+3ByL1NFha0OQHrVmcEx+qAYWBPgvk/yuNuappc9Ak=; b=F46ev0SLhQ+6Z3YQU9gYJSRJz
        rGczGjUNX0n9PVm/PhvXfhzbgbr1/7tMohcOIESobf+14rPpueFB4bCTUpMPJZ7V7rQVDAP5pU1P6
        KN7Iqoem1dS2yhyRHmJ1rmNVsn67ySmjemMucAsDBhODlNcjONujxdQ0vT2sNBXFWoGeLcLvhppZT
        ll8BovQ0O9R4MdLbkbvE73yqyOFkVQ5r3OV5mlI1w7rA+WV1EqPwOcbyu1K9IMRzS0VjizGj0pyVo
        88/HXIa6MzwwnxKziASWykcIqkncpX8fwejERCkNe79Gmc9XlHsXA4jiGNvNdBr897hcMwu1YA60l
        4tGd5qBrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPCsr-0004WY-K4; Mon, 28 Oct 2019 21:49:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D2B1980D8F; Mon, 28 Oct 2019 22:49:02 +0100 (CET)
Date:   Mon, 28 Oct 2019 22:49:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, aaron.lwe@gmail.com,
        valentin.schneider@arm.com, mingo@kernel.org, pauld@redhat.com,
        jdesfossez@digitalocean.com, naravamudan@digitalocean.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191028214902.GN4643@worktop.programming.kicks-ass.net>
References: <20191028174603.GA246917@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028174603.GA246917@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 05:46:03PM +0000, Quentin Perret wrote:

> The issue is very transient and relatively hard to reproduce.
> 
> After digging a bit, the offending commit seems to be:
> 
>     67692435c411 ("sched: Rework pick_next_task() slow-path")
> 
> By 'offending' I mean that reverting it makes the issue go away. The
> issue comes from the fact that pick_next_entity() returns a NULL se in
> the 'simple' path of pick_next_task_fair(), which causes obvious
> problems in the subsequent call to set_next_entity().
> 
> I'll dig more, but if anybody understands the issue in the meatime feel
> free to send me a patch to try out :)

The only way for pick_next_entity() to return NULL is if the tree is
empty and !cfs_rq->curr. But in that case, cfs_rq->nr_running _should_
be 0 and or it's related se should not be enqueued in the parent cfs_rq.

Now for the root cfs_rq we check nr_running this and jump to the idle
path, however if this occurs in the middle of the hierarchy, we're up a
creek without no paddles. This is something that really should not
happen (because empty cfs_rq should not be enqueued)

Also, if we take the simple patch, as you say, then we'll have done a
put_prev_task(), regardless of how we got there, so we know cfs_rq->curr
must be NULL. Which, with the above, means the tree really is empty.

And as stated above, when the tree is empty and !cfs_rq->curr, the
cfs_rq's se should not be enqueued in the parent cfs_rq so we should not
be getting here.

Clearly something is buggered with the cgroup state. What is your cgroup
setup, are you using cpu-bandwidth?
