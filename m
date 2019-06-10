Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43702C28EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 01:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10046206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 01:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfFJBF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 21:05:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfFJBF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 21:05:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A66DA309265A;
        Mon, 10 Jun 2019 01:05:15 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 411185B684;
        Mon, 10 Jun 2019 01:05:11 +0000 (UTC)
Date:   Mon, 10 Jun 2019 09:05:08 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] timers: Fix up get_target_base() to use old base properly
Message-ID: <20190610010508.GB10028@xz-x1>
References: <20190603132944.9726-1-peterx@redhat.com>
 <20190606152805.GA3652@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190606152805.GA3652@amt.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 10 Jun 2019 01:05:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 12:28:08PM -0300, Marcelo Tosatti wrote:
> On Mon, Jun 03, 2019 at 09:29:44PM +0800, Peter Xu wrote:
> > get_target_base() in the timer code is not using the "base" parameter
> > at all.  My gut feeling is that instead of removing that extra
> > parameter, what we really want to do is "return the old base if it
> > does not suite for a new one".
> 
> Hi Peter,

Hi, Marcelo,

> 
> I think its a dead parameter: you always want to use the local base
> if the timer is not pinned.

Thanks for the comment.

But what if it was pinned?  Could the old code always do right even in
the scenario I mentioned below?

https://lkml.org/lkml/2019/6/4/34

Also note that if the timer was not pinned, IMHO it'll go into the
check below and it seems to likely to have another timer base instead
of the local base if it's not a housekeeping cpu (because
get_nohz_timer_target() will always try to provision timers onto the
housekeeping ones), or did I misunderstand your comment?

#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
	if (static_branch_likely(&timers_migration_enabled) &&
	    !(tflags & TIMER_PINNED))
		return get_timer_cpu_base(tflags, get_nohz_timer_target());
#endif

Regards,

-- 
Peter Xu
