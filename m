Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28088C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB081218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GcH8KUXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLSNyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:54:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47100 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfLSNyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z7obWPRua+ECbSKbrq1eKOe5Xc284mCnD5PiHcQRuRk=; b=GcH8KUXB+W12rkpgXcmf4qyVv
        cjt4Pjbj4rEvEIyg52GuYu8l6g2oHOkVDg8fyo4lzBUYmNTuOMoLJW3IZROo1MPW8bDiDUo61sY+4
        ma8AMsXFmUGnb2c5HuIZkPdBVYzHo+R9xb0VrWVcOmQOL3gpYI9Bmoq8ouXpkixu12k56NGErFAl5
        hamOxtifkGJsdr8gU+bozCK/gAsIxvtyJbhXnLKI3fgW8kIvuOc59ZjMV9quSQvxAMpLzUiz/FgwH
        KgSUMsPzRgjYZijlNJMVI0AdMiS5KILDemlobSf2S2dIHznjcw+gOF6QLlLd7tu1W+yosLh3BzJih
        x6wP4KpYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihwFU-0000op-Bd; Thu, 19 Dec 2019 13:53:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B7E23006E3;
        Thu, 19 Dec 2019 14:52:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A5832B3E1690; Thu, 19 Dec 2019 14:53:50 +0100 (CET)
Date:   Thu, 19 Dec 2019 14:53:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
Message-ID: <20191219135350.GA2844@hirez.programming.kicks-ass.net>
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
 <20191219085042.0a29437b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219085042.0a29437b@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 08:50:42AM -0500, Steven Rostedt wrote:
> On Thu, 19 Dec 2019 15:39:14 +0300
> Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 
> > @@ -6569,6 +6558,11 @@ void __init sched_init(void)
> >  	unsigned long ptr = 0;
> >  	int i;
> >  
> > +	BUG_ON(&idle_sched_class > &fair_sched_class ||
> > +		&fair_sched_class > &rt_sched_class ||
> > +		&rt_sched_class > &dl_sched_class ||
> > +		&dl_sched_class > &stop_sched_class);
> > +
> 
> Can this be a BUILD_BUG_ON? These address should all be constants.

Nope, BUILD_BUG_ON() is for compile time constants, these are link time
constants.
