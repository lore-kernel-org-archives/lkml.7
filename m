Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B11C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958522075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfFUPa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:30:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55275 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfFUPa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:30:57 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1heLV6-0005xn-RP; Fri, 21 Jun 2019 17:30:53 +0200
Date:   Fri, 21 Jun 2019 17:30:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: NMI hardlock stacktrace deadlock [was Re: Linux 5.2-rc5]
In-Reply-To: <CAHk-=wjoeZ9_aiu+642ur=iGhGjfBQhRPURxX9Py+-B6coctXw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1906211725200.5503@nanos.tec.linutronix.de>
References: <CAHk-=whEQPvLpDbx+WR4Q4jf2FxXjf_zTX3uLy_6ZzHtgTV4LA@mail.gmail.com> <156094799629.21217.4574572565333265288@skylake-alporthouse-com> <CAHk-=wjhJNKVfHgwd0QX_bq769sxfP4jvfy0dd-WtFMfdivMwg@mail.gmail.com> <156097197830.664.13418742301997062555@skylake-alporthouse-com>
 <CAHk-=wjoeZ9_aiu+642ur=iGhGjfBQhRPURxX9Py+-B6coctXw@mail.gmail.com>
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

On Wed, 19 Jun 2019, Linus Torvalds wrote:

> On Wed, Jun 19, 2019 at 12:19 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> >
> > > Do you have the oops itself at all?
> >
> > An example at
> > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_6310/fi-kbl-x1275/dmesg0.log
> > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_6310/fi-kbl-x1275/boot0.log

The second once contains a lockdep splat which warns about a potential
deadlock in the iommu code.

> > The bug causing the oops is clearly a driver problem. The rc5 fallout
> > just seems to be because of some shrinker changes affecting some object
> > reaping that were unfortunately still active. What perturbed the CI
> > team was the machine failed to panic & reboot.
> 
> Hmm. It's hard to guess at the cause of that. The oopses themselves
> don't look like they are happening in any particularly bad context, so
> all the normal reboot-on-oops etc stuff _should_ work.
> 
> So it would help a lot if you could bisect the bad problem at least a
> bit, if it is at all reproducible. Because with no other clues, it's
> hard to even guess at what might be up.
> 
> The fact that you say "NMI watchdog firing as we dumped the ftrace"
> means that maybe it might be some ftrace / stacktrace issue where the
> dumping itself leads to some endless loop, but who knows.
> 
> For example, one thing that has happened during this development cycle
> is the stacktrace common infrastructure changes (arch_stack_walk() and
> friends). I'm, not seeing why that would cause your issues, but I'm
> adding a few random people for ftrace / stacktrace changes.

/me whistels innocently.

Chris, do you have the actual NMI lockup detector splats somewhere?

Thanks,

	tglx
