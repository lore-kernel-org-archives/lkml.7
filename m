Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1101C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FFA208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfF0VKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:10:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59868 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0VKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:10:10 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgbei-0000Fz-SI; Thu, 27 Jun 2019 23:10:08 +0200
Date:   Thu, 27 Jun 2019 23:10:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>
cc:     linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH v2] timer: document TIMER_PINNED
In-Reply-To: <20190627015019.21964-1-peterx@redhat.com>
Message-ID: <alpine.DEB.2.21.1906272304480.32342@nanos.tec.linutronix.de>
References: <20190627015019.21964-1-peterx@redhat.com>
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

On Thu, 27 Jun 2019, Peter Xu wrote:
> + * @TIMER_PINNED: A pinned timer will not be affected by any timer
> + * placement heuristics (like, NOHZ) and will always be run on the CPU
> + * when the timer was enqueued.

s/when/on which/

> + *
> + * Note: Because enqueuing of timers can actually migrate the timer
> + * from one CPU to another, pinned timers are not guaranteed to stay
> + * on the initialy selected CPU.  They move to the CPU on which the
> + * enqueue function is invoked via mod_timer() or add_timer().  If the
> + * timer should be placed on a particular CPU, then add_timer_on() has
> + * to be used.  It is also suggested that the user should always use
> + * add_timer_on() explicitly for pinned timers.

That last sentence is not correct. add_timer_on() has limitations over
mod_timer(). As pinned prevents the timer from being queued on a remote CPU
mod timer is perfectly fine for many cases.

add_timer_on() is really about queueing a timer on a dedicated CPU, which
is often enough a remote CPU.

Thanks,

	tglx
