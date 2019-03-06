Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6297C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA83120661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfCFJyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:54:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33509 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbfCFJyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:54:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B1263091753;
        Wed,  6 Mar 2019 09:54:45 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5772D5D6A9;
        Wed,  6 Mar 2019 09:54:44 +0000 (UTC)
Date:   Wed, 6 Mar 2019 10:54:42 +0100
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] ntp: Avoid undefined behaviour in second_overflow()
Message-ID: <20190306095442.GM21520@localhost>
References: <1551835710-53773-1-git-send-email-wangxiongfeng2@huawei.com>
 <CALAqxLXFGKDzxT-S9DDnjRRYvDB1Qq3T-tHYYGQXg3c47HtTbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLXFGKDzxT-S9DDnjRRYvDB1Qq3T-tHYYGQXg3c47HtTbQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 06 Mar 2019 09:54:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 05:42:25PM -0800, John Stultz wrote:
> > --- a/kernel/time/ntp.c
> > +++ b/kernel/time/ntp.c
> > @@ -677,6 +677,8 @@ static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai
> >
> >         if (txc->modes & ADJ_MAXERROR)
> >                 time_maxerror = txc->maxerror;
> > +       if (time_maxerror > NTP_PHASE_LIMIT)
> > +               time_maxerror = NTP_PHASE_LIMIT;
> 
> This looks sane to me.
> Acked-by: John Stultz <john.stultz@linaro.org>
> 
> Though it makes me wonder a bit more about the sanity checking on the
> other parameters passed via adjtimex(), tick_usec for instance looks
> like it could be similarly problematic.

The tick length is checked earlier in timekeeping_validate_timex(), so
that should be ok.

What I'd like to see clamped is the system time itself. ktime_t
overflows on Apr 11 2262. clock_settime() and adjtimex(ADJ_SETOFFSET)
can set the time close to the overflow and let everything break.

Boot a VM and try this:

# date -s 'Apr 11 23:47:15 UTC 2262'

There was a patch submitted couple years ago that prevented overflows
in 32-bit time_t and ktime_t.

http://lkml.iu.edu/hypermail/linux/kernel/1510.0/04719.html

-- 
Miroslav Lichvar
