Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F501C606D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68D5216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfGIGq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:46:27 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:57850 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725832AbfGIGq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:46:26 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 9 Jul 2019 15:46:24 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 9 Jul 2019 15:46:24 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Tue, 9 Jul 2019 15:45:31 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190709064531.GA15734@X58A-UD3R>
References: <1562565609-12482-1-git-send-email-byungchul.park@lge.com>
 <20190708125013.GG26519@linux.ibm.com>
 <20190708130359.GA42888@google.com>
 <20190709055815.GA19459@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709055815.GA19459@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 02:58:16PM +0900, Byungchul Park wrote:
> On Mon, Jul 08, 2019 at 09:03:59AM -0400, Joel Fernandes wrote:
> > > Actually, the intent was to only allow this to be changed at boot time.
> > > Of course, if there is now a good reason to adjust it, it needs
> > > to be adjustable.  So what situation is making you want to change
> > > jiffies_till_sched_qs at runtime?  To what values is it proving useful
> > > to adjust it?  What (if any) relationships between this timeout and the
> > > various other RCU timeouts need to be maintained?  What changes to
> > > rcutorture should be applied in order to test the ability to change
> > > this at runtime?
> > 
> > I am also interested in the context, are you changing it at runtime for
> > experimentation? I recently was doing some performance experiments and it is
> > quite interesting how reducing this value can shorten grace period times :)
> 
> Hi Joel,
> 
> I've read a thread talking about your experiment to see how the grace
> periods change depending on the tunnable variables which was interesting
> to me. While reading it, I found out jiffies_till_sched_qs is not
> tunnable at runtime unlike jiffies_till_{first,next}_fqs which looks
> like non-sense to me that's why I tried this patch. :)
> 
> Hi Paul,
> 
> IMHO, as much as we want to tune the time for fqs to be initiated, we
> can also want to tune the time for the help from scheduler to start.

Let me mention one more thing here...

This is about jiffies_till_sched_qs, I think, used to directly set
jiffies_to_sched_qs.

> I thought only difference between them is a level of urgency.

Of course, they are coupled in case jiffies_to_sched_qs is calculated
from jiffies_till_{first,next}_fqs though, I'm just talking about its
original motivation or concept.

Thanks,
Byungchul
