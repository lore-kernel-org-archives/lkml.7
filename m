Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87392C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A5F2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbfB1KJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:09:36 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54635 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbfB1KJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:09:35 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gzIdA-0001DH-59; Thu, 28 Feb 2019 11:09:32 +0100
Date:   Thu, 28 Feb 2019 11:09:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chris Wilson <chris@chris-wilson.co.uk>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/fence: Do not use TIMER_IRQSAFE
In-Reply-To: <155134800668.5847.13013477917200660218@skylake-alporthouse-com>
Message-ID: <alpine.DEB.2.21.1902281105520.1821@nanos.tec.linutronix.de>
References: <20190212162857.20003-1-bigeasy@linutronix.de> <20190226160038.5vwk465gwzfwn75i@linutronix.de> <155134800668.5847.13013477917200660218@skylake-alporthouse-com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019, Chris Wilson wrote:

> Quoting Sebastian Andrzej Siewior (2019-02-26 16:00:38)
> > On 2019-02-12 17:28:57 [+0100], To linux-kernel@vger.kernel.org wrote:
> > > The timer is initialized with TIMER_IRQSAFE flag. It does look like the
> > > timer callback requires this flag at all. Its sole purpose is to ensure
> > > synchronisation in the workqueue code.
> > > 
> > > Remove TIMER_IRQSAFE flag because it is not required.
> > 
> > ping
> 
> We call del_timer_sync from irq context, which mandates using
> TIMER_IRQSAFE. Failure to do so results in lots of explosions across CI
> -- every machine managed to hit the warning.
> 
> It may not be the best of api, but it's the only one available for the
> driver to use...

The comment in the header files says clearly:

 * Note: The irq disabled callback execution is a special case for
 * workqueue locking issues. It's not meant for executing random crap
 * with interrupts disabled. Abuse is monitored!                                   

So what's so special in drm that you need to call del_timer_sync() from
interrupt context?

Thanks

	tglx




