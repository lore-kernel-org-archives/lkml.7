Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CC8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E4C206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2OQdRuPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLCKAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:00:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50316 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLCKAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ldpcFFEJZV+rNWeZJvIbhct0EoBcbcOrWoRkoH4FTL4=; b=2OQdRuPvifOCzwJO5/BOcF8Uc
        To/e4SFa+6PzKcUW+CyK6OiUAD6H5dqzRNPWpSV+NMmkTE7HV4h7XkkOLSacM+op7XZj3xPSOqDMz
        2YnRx/r5pA3mCRBbefOfJ7CXYoWntJcS4SdUtK1yZbg111ujRCzoBV5Pokw3BnhuAianGSMPvLOqt
        1ts60C6F9htywIyjTxINbhlSWjgyZMaIc7APNqBuJXkOIJ8dcVLwgYS7cmmn7nYu9Wc5uQ/1DBpaw
        /4g+jGz+KB7bDlyhZgwxUN0igIksZe/HpA3NdOw88aSGkSVnW+R+dTqqoCmDkF4zF3v9/r1ASM1FE
        rxzOK5Baw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic4ya-0005xW-00; Tue, 03 Dec 2019 10:00:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 449D6303144;
        Tue,  3 Dec 2019 10:58:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77C9420230B0A; Tue,  3 Dec 2019 11:00:10 +0100 (CET)
Date:   Tue, 3 Dec 2019 11:00:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191203100010.GI2827@hirez.programming.kicks-ass.net>
References: <20191125230312.GP2889@paulmck-ThinkPad-P72>
 <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191202233944.GY2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202233944.GY2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 03:39:44PM -0800, Paul E. McKenney wrote:

> I think that I do not understand the code, but I never let that stop
> me from asking stupid questions!  ;-)
> 
> Suppose that a given worker is bound to a particular CPU, but has no
> work pending, and is therefore sleeping in the schedule() call near the
> end of worker_thread().  During this time, its CPU goes offline and then
> comes back online.  Doesn't this break that task's affinity to that CPU?

No. The thing about sleeping tasks is that they're not in fact on any
CPU at all. Only when a task wakes up do we concern ourselves with
placing it. If at that time we find the CPU it was constrained to is no
longer with us, then we go break affinity.

But if the CPU went away and came back while the task was asleep, it
will not notice anything.

