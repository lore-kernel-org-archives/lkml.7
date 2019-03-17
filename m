Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F57C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DBA21738
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 09:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552816481;
	bh=tLDhiWuf6J1c0N65fdVnBhkRCK9WvZ+7RJc9zwAeyMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VbNEvofzoNrjeid8QsM5c0gVZ6ZDKNKDV8I6E2LoIx64bypg3le86rf1yMJTWKsyV
	 vCoYunaiNfWB+aTqgPJg/7dx1ChTQiuCm1eQsFRD9oFj5QDprZFyleLa0IlA7GZFHi
	 Pf/mSJx4nyjIgRYzPH0wxE7tLY2/cpxWfg2uA1uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCQJyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 05:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfCQJyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 05:54:39 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2846D2148D;
        Sun, 17 Mar 2019 09:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552816478;
        bh=tLDhiWuf6J1c0N65fdVnBhkRCK9WvZ+7RJc9zwAeyMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S12ijWzLwuMpFpQy7yJ/hv4wMoC6JQmqtsPKsVOkMVxor/MtqZehwvOmFs+vN+bYO
         VZQyNOJ7FoezQi3GBw1DdPomxDh+5Mkl5KyFkHuAXm8+aUZc7k9XDYlGJnEDKulDRS
         Ktz4ZsuV+YVGNVW+YfnXcF8GNYQIrpYnJC9xIuaU=
Date:   Sun, 17 Mar 2019 10:54:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, eric@anholt.net,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        matthias.bgg@gmail.com, yamada.masahiro@socionext.com,
        tklauser@distanz.ch, richard.genoud@gmail.com,
        macro@linux-mips.org, u.kleine-koenig@pengutronix.de,
        kernel@pengutronix.de, slemieux.tyco@gmail.com,
        andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
Message-ID: <20190317095435.GB6906@kroah.com>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
 <20190314225204.GB1795@kroah.com>
 <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
 <20190315142628.GA30650@kroah.com>
 <d81364fc-c5da-c1b2-f38a-3a23c701c50d@metux.net>
 <20190316032630.GB2499@kroah.com>
 <fd8d6a9b-3e85-9904-2195-1f1bbc42bd2d@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd8d6a9b-3e85-9904-2195-1f1bbc42bd2d@metux.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 10:17:11AM +0100, Enrico Weigelt, metux IT consult wrote:
> On 16.03.19 04:26, Greg KH wrote:
> 
> > No, it's just that those systems do not allow those devices to be
> > removed because they are probably not on a removable bus.
> 
> Ok, devices (hw) might not be removable - that also the case for uarts
> builtin some SoCs, or the good old PC w/ 8250. But does that also mean
> that the driver should not be removable ?

No, but 'rmmod' is not a normal operation that anyone ever does in a
working system.  It is only for developer's ease-of-use.

> IMHO, even if that's the case, it's still inconsistent. The driver then
> shouldn't support a remove at all (or even builtin only), not just
> incomplete remove.

Cleaning up properly when the module is unloaded is a good idea, but so
far the patches you submitted did not change anything from a logic point
of view.  They all just cleaned up memory the same way it was cleaned up
before, so I really do not understand what you are trying to do here.

> >> Okay, I was on a wrong track here - I had the silly idea that it would
> >> make things easier if we'd do it the same way everywhere.
> > 
> > "Consistent" is good, and valid, but touching old drivers that have few
> > users is always risky, and you need a solid reason to do so.
> 
> Understood.
> 
> By the way: do we have some people who have those old hw and could test?
> Should we (try to) create some ? Perhaps some "tester" entry in
> MAINTAINERS file ? (I could ask around several people who might have
> lots of old / rare hardware.)

Let's not clutter up MAINTAINERS with anything else please.

> >> Understood. Assuming I've found some of these cases, shall I use devm
> >> oder just add the missing release ?
> > 
> > If it actually makes the code "simpler" or "more obvious", sure, that's
> > fine.  But churn for churns sake is not ok.
> 
> Ok.
> 
> > I put the review of new patch submissions on hold, yes.  Almost all
> > maintainers do that as we can not add new patches to our trees at that
> > point in time.
> 
> hmm, looks like a pipeline stall ;-)
> why not collecting in a separate branch, which later gets rebased to
> mainline when rc is out ?

I do do that for subsystems that actually have a high patch rate.  The
tty/serial subsystem is not such a thing, and it can handle 2 weeks of
delay just fine.

> > And I do have other things I do during that period so it's not like I'm
> > just sitting around doing nothing :)
> 
> So it's also a fixed schedule for your other work. Understood.
> 
> It seems that this workflow can confuse people. Few days ago, somebody
> became nervous about missing reactions on patches. Your autoresponder
> worked for me, but maybe not for everybody.

Why would it not work for everybody?  Kernel development has been done
in this manner for over a decade.  Having a 2 week window like this is
good for the maintainers, remember they are the most limited resource we
have, not developers.

thanks,

greg k-h
