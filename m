Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B74C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21DB20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfEWFc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 01:32:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfEWFc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:32:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DDBA308213A;
        Thu, 23 May 2019 05:32:58 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2A8260BC3;
        Thu, 23 May 2019 05:32:56 +0000 (UTC)
Date:   Thu, 23 May 2019 13:32:54 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tick/sched: Drop duplicated tick_sched.inidle
Message-ID: <20190523053254.GA2517@xz-x1>
References: <20190522032906.11963-1-peterx@redhat.com>
 <20190522121837.GA11692@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522121837.GA11692@lerouge>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 23 May 2019 05:32:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 02:18:41PM +0200, Frederic Weisbecker wrote:
> On Wed, May 22, 2019 at 11:29:06AM +0800, Peter Xu wrote:
> > It is set before entering idle and cleared when quitting idle, though
> > it seems to be a complete duplicate of tick_sched.idle_active.  We
> > should probably be able to use any one of them to replace the other.
> 
> Not exactly.
> 
> @inidle is set on idle entry and cleared on idle exit.
> @idle_active is the same but it's cleared during idle interrupts
> so that idle_sleeptime only account real idle time.
> 
> And note below:
> 
> > @@ -1017,7 +1015,7 @@ void tick_nohz_irq_exit(void)
> >  {
> >  	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> >  
> > -	if (ts->inidle)
> > +	if (ts->idle_active)
> >  		tick_nohz_start_idle(ts);
> 
> idle_active will always be cleared here from tick_nohz_irq_enter().
> We actually want to conditionally set it again depending on the inidle value.

You are right; I've missed the calls from irq enter/exit. Thanks, Frederic.

-- 
Peter Xu
 
