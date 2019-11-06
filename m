Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A1DC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4860D2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbfKFWQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:16:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45430 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKFWQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:16:54 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSTbf-0004AT-Vz; Wed, 06 Nov 2019 23:16:52 +0100
Date:   Wed, 6 Nov 2019 23:16:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Eric Dumazet <edumazet@google.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to
 timer->state
In-Reply-To: <CANn89iKBaEdCzgF-MT1wrxBZtBD2Ktr9qeThTG_XKOy742XcmQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911062316310.1869@nanos.tec.linutronix.de>
References: <20191106174804.74723-1-edumazet@google.com> <157307438959.29376.9644507314555163943.tip-bot2@tip-bot2> <CANn89iKBaEdCzgF-MT1wrxBZtBD2Ktr9qeThTG_XKOy742XcmQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019, Eric Dumazet wrote:
> > -static inline int hrtimer_is_queued(struct hrtimer *timer)
> > +static inline bool hrtimer_is_queued(struct hrtimer *timer)
> >  {
> > -       return timer->state & HRTIMER_STATE_ENQUEUED;
> > +       /* The READ_ONCE pairs with the update functions of timer->state */
> > +       return !!READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED;
> 
> You probably meant :
> 
> return !!(READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED);
> 
> Sorry for not spotting this earlier.

Yes, I'm a moron....

