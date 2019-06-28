Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5B6C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E5420645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfF1KzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:55:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfF1KzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:55:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E974C3082A98;
        Fri, 28 Jun 2019 10:55:21 +0000 (UTC)
Received: from xz-x1 (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 840395D98E;
        Fri, 28 Jun 2019 10:55:16 +0000 (UTC)
Date:   Fri, 28 Jun 2019 18:55:13 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH v2] timer: document TIMER_PINNED
Message-ID: <20190628105513.GA10844@xz-x1>
References: <20190627015019.21964-1-peterx@redhat.com>
 <alpine.DEB.2.21.1906272304480.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906272304480.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 28 Jun 2019 10:55:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:10:08PM +0200, Thomas Gleixner wrote:
> On Thu, 27 Jun 2019, Peter Xu wrote:
> > + * @TIMER_PINNED: A pinned timer will not be affected by any timer
> > + * placement heuristics (like, NOHZ) and will always be run on the CPU
> > + * when the timer was enqueued.
> 
> s/when/on which/

Fixed.

> 
> > + *
> > + * Note: Because enqueuing of timers can actually migrate the timer
> > + * from one CPU to another, pinned timers are not guaranteed to stay
> > + * on the initialy selected CPU.  They move to the CPU on which the
> > + * enqueue function is invoked via mod_timer() or add_timer().  If the
> > + * timer should be placed on a particular CPU, then add_timer_on() has
> > + * to be used.  It is also suggested that the user should always use
> > + * add_timer_on() explicitly for pinned timers.
> 
> That last sentence is not correct. add_timer_on() has limitations over
> mod_timer(). As pinned prevents the timer from being queued on a remote CPU
> mod timer is perfectly fine for many cases.
> 
> add_timer_on() is really about queueing a timer on a dedicated CPU, which
> is often enough a remote CPU.

Frankly speaking I still think add_timer_on() is preferred here
because mod_timer() users will really need to be careful to make sure
they'll pin the timers correctly all the time, and I assume that's why
we've tried to find all the TIMER_PINNED users and tried to make sure
there's nothing wrong on using them during previous discussion (and
more than half of them do use add_timer_on() which seems to be good).
In all cases, I'll take your suggestion to drop the last sentence.

Thanks for reviewing this document patch.  I'll repost.

-- 
Peter Xu
