Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A015C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186662184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PkSWtjdE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfCOJJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:09:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38642 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfCOJJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1cGhHP5z8Y64YH1TdqXCwGMVqukrIVE+84UtmemA3vs=; b=PkSWtjdEJeFKxLfE+WSs6T6Txv
        KBiDDb5MWhExPT3CJUSrgpQudSmbISJVEaapAhq6b4U6vcPw4+AaCSKSYFPN/pQ6xdbeIpAn0hmO6
        fopCWBhEzYt0EfmvRn6HNPlJfVz7djcwLCi6VbsZKzN98iX7TvoCeihcl4G0+qgrlMl7W7iWH2XgQ
        iHao/PmPrykHYVR0uX/DJtX3kocfDZ5rVBQtPWUf6n3AwLH3OqeGqUpryK5CVkAR/4JIOxGzfP8pk
        8YOPxxszHNOFfg4oRSAo8PSAdVkcSnyokiyKwRcGnZDU+X3njIQ2bzfZEbk6scd8DobN3V9JvGvim
        rIa++2Ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4iqe-0004RT-Mn; Fri, 15 Mar 2019 09:09:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4438C21A7734B; Fri, 15 Mar 2019 10:09:50 +0100 (CET)
Date:   Fri, 15 Mar 2019 10:09:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas =?iso-8859-1?Q?M=FCller?= <thomas@mathtm.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: disabling secondary CPU hangs / system fails to suspend with
 kernel 4.19+
Message-ID: <20190315090950.GT5996@hirez.programming.kicks-ass.net>
References: <5c48095e-028a-404f-aaa1-964f83c83817@mathtm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c48095e-028a-404f-aaa1-964f83c83817@mathtm.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 04:17:28PM +0100, Thomas Müller wrote:
> Hi,
> 
> starting with kernel 4.19 my Lenovo ThinkPad X1 Carbon 5th no longer properly suspends.
> 
> This is 100% reproducible and git bisect points to the following commit:
> > [be45bf5395e0886a93fc816bbe41a008ec2e42e2] watchdog/softlockup: Fix cpu_stop_queue_work() double-queue bug
> > be45bf5395e0886a93fc816bbe41a008ec2e42e2 is the first bad commit
> > commit be45bf5395e0886a93fc816bbe41a008ec2e42e2
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Fri Jul 13 12:42:08 2018 +0200
> > 
> >     watchdog/softlockup: Fix cpu_stop_queue_work() double-queue bug
> >     
> >     When scheduling is delayed for longer than the softlockup interrupt
> >     period it is possible to double-queue the cpu_stop_work, causing list
> >     corruption.
> >     
> >     Cure this by adding a completion to track the cpu_stop_work's
> >     progress.
> >     
> >     Reported-by: kernel test robot <lkp@intel.com>
> >     Tested-by: Rong Chen <rong.a.chen@intel.com>
> >     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >     Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Cc: Thomas Gleixner <tglx@linutronix.de>
> >     Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
> >     Link: http://lkml.kernel.org/r/20180713104208.GW2494@hirez.programming.kicks-ass.net
> >     Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > 
> > :040000 040000 6aca2dbb84bc33fe442b18b3d0a135c27adff7b9 2710af12d32e4b98df07768716689b213bce45fc M      kernel
> 
> The bugzilla reports have some additional details:
> * https://bugzilla.redhat.com/show_bug.cgi?id=1671504
> * https://bugzilla.kernel.org/show_bug.cgi?id=202679
> * https://bugzilla.kernel.org/show_bug.cgi?id=202137
> 
> I'm happy to provide additional information or test a patch or two (as long as it doesn't
> eat up my notebook ;))

I obviously cannot reproduce :/ Both cpu-hotplug and suspend works just
fine on my test boxes. I even tried my thinkpad (x240) and that too goes
to sleep and wakes up just fine.

What .config do you have? And what, if anything do you see on the
console when it goes funny?

I think you wrote that hot-un-plug never completes? Is there anything in
dmesg when it's stuck in:

  echo 0 > /sys/devices/system/cpu/cpu1/online

?
