Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB0BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C81220718
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0K8frmXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfKOKRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:17:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58934 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfKOKRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zVnMI/UTYlwDA1YdxIZ76WyrLjTckvFSUwJdOR6cRe0=; b=0K8frmXEYTzRoeIjlk+UtotAW
        0nwOzbiVM3sKSI9TrSNJnNWk8dAONjiI8PG7qULXJmVJYJ0VufpK/tm+JKbtQTC5TI7Tu5cW0/bcn
        nyq7LymBs9duyBhoOv6aFXOvFCv8gsMZqHuURzOZEiYf0Er4Zy4DjLAPj0dBn84jff7nBZizMW7hw
        iDSKc5B8wHJ1xUk+fN+JwqTEgtbgCEovtnG8DrjUlbCmzDs38HQdhe6GrKHsosBnsRcGXPvFBGm/7
        S4o7j5ptvVWgm7+T8q7dHbEHSv7fwuLzCC9Y1UDBLnxWQ3D3FJMxGTC8QJu3xKCS9ISY4dk9SDaCs
        7ft5ht8Aw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVYeo-00069x-DS; Fri, 15 Nov 2019 10:16:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D78503006FB;
        Fri, 15 Nov 2019 11:15:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E42AB2B128BE6; Fri, 15 Nov 2019 11:16:48 +0100 (CET)
Date:   Fri, 15 Nov 2019 11:16:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Pavel Machek <pavel@ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 3/9] sched/vtime: Handle nice updates under vtime
Message-ID: <20191115101648.GC4131@hirez.programming.kicks-ass.net>
References: <20191106030807.31091-1-frederic@kernel.org>
 <20191106030807.31091-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106030807.31091-4-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 04:08:01AM +0100, Frederic Weisbecker wrote:
> The cputime niceness is determined while checking the target's nice value
> at cputime accounting time. Under vtime this happens on context switches,
> user exit and guest exit. But nice value updates while the target is
> running are not taken into account.
> 
> So if a task runs tickless for 10 seconds in userspace but it has been
> reniced after 5 seconds from -1 (not nice) to 1 (nice), on user exit
> vtime will account the whole 10 seconds as CPUTIME_NICE because it only
> sees the latest nice value at accounting time which is 1 here. Yet it's
> wrong, 5 seconds should be accounted as CPUTIME_USER and 5 seconds as
> CPUTIME_NICE.
> 
> In order to solve this, we now cover nice updates withing three cases:
> 
> * If the nice updater is the current task, although we are in kernel
>   mode there can be pending user or guest time in the cache to flush
>   under the prior nice state. Account these if any. Also toggle the
>   vtime nice flag for further user/guest cputime accounting.
> 
> * If the target runs on a different CPU, we interrupt it with an IPI to
>   update the vtime state in place. If the task is running in user or
>   guest, the pending cputime is accounted under the prior nice state.
>   Then the vtime nice flag is toggled for further user/guest cputime
>   accounting.

But but but, I thought the idea was to _never_ send interrupts to
NOHZ_FULL cpus ?!?
