Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB882C5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A085A208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xXfwBtzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfF1QEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:04:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44642 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfF1QEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=afW446socrCTj7b00xQ9nuN6qxk9wXvs1a9518imP1M=; b=xXfwBtzVHV3OzDxxlaOAd+2up
        0b4fUklmXhVyeDeWZ4T4SRovDVQaXhkNThCaManBZ6/gVcr72u7zTKyuJTpUVgQoKHinX1ms9hekl
        xlpxXc6i3aoxb+c+8V6hm7AqTefoLF08RRUwQRbbtZeVPFQpdYi8oCOYHfsdMwkAuFo7PwR7rmplM
        Xuy/o6qESXUY8cwDF1sjB65rt71S1bPckGzI99IicBSIeqUjMOplYvQuh2gKcLULi9GOv25WB9V7F
        Ihgfh8o84JOJri0fhV4Njmz8yXWK2+QukK1+9u1wJQbjz7puU0LCX/koOLb0YLphvHTTGi5KBoljt
        LzV6sH16Q==;
Received: from [31.161.200.126] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgtME-0001dw-9L; Fri, 28 Jun 2019 16:04:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6909D9802C5; Fri, 28 Jun 2019 18:04:08 +0200 (CEST)
Date:   Fri, 28 Jun 2019 18:04:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628160408.GH32547@worktop.programming.kicks-ass.net>
References: <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628141522.GF3402@hirez.programming.kicks-ass.net>
 <20190628155404.GV26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628155404.GV26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 08:54:04AM -0700, Paul E. McKenney wrote:
> Thank you!  Plus it looks like scheduler_ipi() takes an early exit if
> ->wake_list is empty, regardless of TIF_NEED_RESCHED, right?

Yes, TIF_NEED_RESCHED is checked in the interrupt return path.
