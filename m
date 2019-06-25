Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249B3C4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 03:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F8920663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 03:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfFYDDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 23:03:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbfFYDDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 23:03:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 177533082133;
        Tue, 25 Jun 2019 03:03:49 +0000 (UTC)
Received: from treble (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC3C119722;
        Tue, 25 Jun 2019 03:03:47 +0000 (UTC)
Date:   Mon, 24 Jun 2019 22:03:45 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: NMI hardlock stacktrace deadlock [was Re: Linux 5.2-rc5]
Message-ID: <20190625030345.dwbydi2w67mpp4zq@treble>
References: <CAHk-=whEQPvLpDbx+WR4Q4jf2FxXjf_zTX3uLy_6ZzHtgTV4LA@mail.gmail.com>
 <156094799629.21217.4574572565333265288@skylake-alporthouse-com>
 <CAHk-=wjhJNKVfHgwd0QX_bq769sxfP4jvfy0dd-WtFMfdivMwg@mail.gmail.com>
 <156097197830.664.13418742301997062555@skylake-alporthouse-com>
 <CAHk-=wjoeZ9_aiu+642ur=iGhGjfBQhRPURxX9Py+-B6coctXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjoeZ9_aiu+642ur=iGhGjfBQhRPURxX9Py+-B6coctXw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 25 Jun 2019 03:03:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 01:42:53PM -0700, Linus Torvalds wrote:
> On Wed, Jun 19, 2019 at 12:19 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> >
> > > Do you have the oops itself at all?
> >
> > An example at
> > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_6310/fi-kbl-x1275/dmesg0.log
> > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_6310/fi-kbl-x1275/boot0.log
> >
> > The bug causing the oops is clearly a driver problem. The rc5 fallout
> > just seems to be because of some shrinker changes affecting some object
> > reaping that were unfortunately still active. What perturbed the CI
> > team was the machine failed to panic & reboot.
> 
> Hmm. It's hard to guess at the cause of that. The oopses themselves
> don't look like they are happening in any particularly bad context, so
> all the normal reboot-on-oops etc stuff _should_ work.

Looking at the dmesg, panic_on_oops doesn't seem to be enabled: it went
through the rewind_stack_do_exit() path instead of the panic() path.  So
the system is apparently not configured to reboot on oops.

So I'd say the hang was presumably caused by a lock held by the oopsing
code.  So it looks normal to me, other than the original oops.

-- 
Josh
