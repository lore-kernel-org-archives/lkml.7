Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA439C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DC82077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfD0HBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 03:01:13 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:57926 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfD0HBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 03:01:13 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 1D7A85C1337; Sat, 27 Apr 2019 09:00:21 +0200 (CEST)
Date:   Sat, 27 Apr 2019 09:00:21 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] staging: fieldbus: anybus-s: use proper type for
 wait_for_completion_timeout
Message-ID: <20190427070021.GA2290@osadl.at>
References: <1556339208-7722-1-git-send-email-hofrat@osadl.org>
 <CAGngYiXBrNu7Jrk535=L89-mOSNx-6EfqL=1EwwG49Sf44R0Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiXBrNu7Jrk535=L89-mOSNx-6EfqL=1EwwG49Sf44R0Vg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 02:17:42AM -0400, Sven Van Asbroeck wrote:
> Hello Nicholas, thank you for your contribution, I really appreciate it !
> See inline comments below.
> 
> On Sat, Apr 27, 2019 at 12:32 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> >
> > wait_for_completion_timeout() returns unsigned long (0 on timeout or
> > remaining jiffies) not int.
> 
> Nice catch !
> 
> > thus there is no negative case to check for
> > here.
> 
> The current code can only break if wait_for_completion_timeout()
> returns an unsigned long large enough to make the "int ret" turn
> negative. This could result in probe() returning a nonsensical error
> value, even though the wait did not time out.
> 
> Fortunately that currently cannot happen, because TIMEOUT
> (2*HZ) won't overflow an int.

ok - thats benign then -  never the less since code tends to get copied 
it would be good to make it comply with API spec

> 
> That being said, this return value type mismatch should definitely
> be fixed up.
> 
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> >
> > Problem located with experimental API conformance checking cocci script
> >
> > Q: It is not really clear if the proposed fix is the right thing here or if
> >    this should not be using wait_for_completion_interruptible - which would
> >    return -ERESTARTSYS on interruption. Someone that knows the details of
> >    this driver would need to check what condition should initiate the
> >    goto err_reset; which was actually unreachable in the current code.
> 
> It's used in probe(), so no need for an interruptible wait, AFAIK.
> It can stay as-is.
> 
> >
> > Patch was compile-tested with. x86_64_defconfig + FIELDBUS_DEV=m,
> > HMS_ANYBUSS_BUS=m
> > (some unrelated sparse warnings (cast to restricted __be16))
> 
> That sounds interesting too. Could you provide more details?

make C=1
drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted __be16
drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted __be16
drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted __be16
drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted __be16
drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted


> 
> <snip>
> 
> > -       ret = wait_for_completion_timeout(&cd->card_boot, TIMEOUT);
> > -       if (ret == 0)
> > +       time_left = wait_for_completion_timeout(&cd->card_boot, TIMEOUT);
> > +       if (time_left == 0)
> >                 ret = -ETIMEDOUT;
> > -       if (ret < 0)
> > -               goto err_reset;
> 
> NAK. This does not jump to err_reset on timeout.
> 
> May I suggest the following instead ? (manual formatting)
> 
> - ret = wait_for_completion_timeout(&cd->card_boot, TIMEOUT);
> - if (ret == 0)
> -         ret = -ETIMEDOUT;
> - if (ret < 0)
> -         goto err_reset;
> + if (!wait_for_completion_timeout(&cd->card_boot, TIMEOUT)) {
> +         ret = -ETIMEDOUT;
> +         goto err_reset;
> + }

Ah - ok - that was the bit missing for me !
how that goto branch would be reached or if it should be
dropped as it had not been reachable in the past.

I'll send the V2 later today then.

thx!
hofrat

