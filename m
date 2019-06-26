Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11FCC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FE520663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfFZM0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZM0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:26:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCABF204FD;
        Wed, 26 Jun 2019 12:26:10 +0000 (UTC)
Date:   Wed, 26 Jun 2019 08:26:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: NMI hardlock stacktrace deadlock [was Re: Linux 5.2-rc5]
Message-ID: <20190626082609.5c8489f0@gandalf.local.home>
In-Reply-To: <20190625030345.dwbydi2w67mpp4zq@treble>
References: <CAHk-=whEQPvLpDbx+WR4Q4jf2FxXjf_zTX3uLy_6ZzHtgTV4LA@mail.gmail.com>
        <156094799629.21217.4574572565333265288@skylake-alporthouse-com>
        <CAHk-=wjhJNKVfHgwd0QX_bq769sxfP4jvfy0dd-WtFMfdivMwg@mail.gmail.com>
        <156097197830.664.13418742301997062555@skylake-alporthouse-com>
        <CAHk-=wjoeZ9_aiu+642ur=iGhGjfBQhRPURxX9Py+-B6coctXw@mail.gmail.com>
        <20190625030345.dwbydi2w67mpp4zq@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 22:03:45 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Looking at the dmesg, panic_on_oops doesn't seem to be enabled: it went
> through the rewind_stack_do_exit() path instead of the panic() path.  So
> the system is apparently not configured to reboot on oops.

"Command line: BOOT_IMAGE=/boot/drm_intel root=/dev/sda1 rootwait fsck.repair=yes intel_iommu=igfx_off nmi_watchdog=panic,auto panic=5 softdog.soft_panic=5 drm.debug=0xe log_buf_len=1M 3 ro"

> 
> So I'd say the hang was presumably caused by a lock held by the oopsing
> code.  So it looks normal to me, other than the original oops.
> 

Looks like its missing "oops=panic", as the documentation says:


        oops=panic      Always panic on oopses. Default is to just kill the
                        process, but there is a small probability of
                        deadlocking the machine.
                        This will also cause panics on machine check exceptions.
                        Useful together with panic=30 to trigger a reboot.

-- Steve
