Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4169C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0D721D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="L8wPdO/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgACHlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 02:41:36 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:26211 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgACHlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 02:41:36 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47pxg13slBz7s;
        Fri,  3 Jan 2020 08:41:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578037293; bh=jJL9+zGNXcRs81d3ivI4BPhkQdaALU3ctyQK3i4Um/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8wPdO/2vvTaAoS0uO5cVkP8nXH43R2KrAZMpISMr4sWLAh+lNZ9C/JgDtmgio0yA
         qdsOKZ6w3W/MVyIJ+2AwtXK/ELPJOedW0QC5/Hb57CK26txY5JaQ68nt8x5J4Zu/8x
         Ja9fR40k8aLIKIAT+6ww8i/JXcVxw0Ul3j/vZ3ng0tgeUY6wcv5HdU6uSntao8tftZ
         hoGcpwse0WRP6oo7wW0OZZA22Rsa7WdqtYM+bPPNlg1qAFsPGI/fNX8mmwBSaYOcHd
         eXJ7lMvWQVpC/qmdGWq8ceALjnZoa+QoLZLJHFFRv7nyX2j139R2UxAbdl3PGuB6KC
         tFRw5CYk7VggQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Fri, 3 Jan 2020 08:41:32 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/16] usb: phy: tegra: Keep CPU interrupts enabled
Message-ID: <20200103074132.GB14228@qmqm.qmqm.pl>
References: <20191228203358.23490-1-digetx@gmail.com>
 <20191228203358.23490-14-digetx@gmail.com>
 <20191230203648.GA24135@qmqm.qmqm.pl>
 <ad1a2b09-12b0-112e-1556-6faf6a01c330@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad1a2b09-12b0-112e-1556-6faf6a01c330@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 05:40:48PM +0300, Dmitry Osipenko wrote:
> 30.12.2019 23:36, Michał Mirosław пишет:
> > On Sat, Dec 28, 2019 at 11:33:55PM +0300, Dmitry Osipenko wrote:
> >> There is no good reason for disabling of CPU interrupts in order to
> >> protect the utmip_pad_count modification.
> > 
> > Since there are sleeping functions called outside of the locked sections,
> > this should be a mutex instead. OTOH if the spin_lock is to protect register
> > write against IRQ handler, then the patch is wrong.
> > 
> > [...]
> >> -	spin_unlock_irqrestore(&utmip_pad_lock, flags);
> >> +	spin_unlock(&utmip_pad_lock);
> >>  
> >>  	clk_disable_unprepare(phy->pad_clk);
> 
> Hello Michał,
> 
> This spinlock isn't for protecting from the IRQ handler, it's used
> solely to protect modification of the registers that are shared by all
> USB controllers.
> 
> It's possible to use mutex instead of spinlock here, but it doesn't
> bring any benefits because mutex is more useful when protected code
> could block for a long time due to sleep or whatever, while spinlock is
> much more efficient when protected code doesn't sleep and takes no more
> than dozens microseconds to execute (which is the case here).
> 
> In this particular case of the Tegra USB PHY driver, the chance of
> getting a block on taking the utmip_pad_lock is zero unless USB
> controller drivers will start to use asynchronous probing. So this patch
> does a very minor clean-up change and nothing more.

I was concerned that this change allows the kernel to switch away to
another task, but I can see now that spin_lock() does disable preemtion.
So it looks OK after all. Would be nice to see the explanation in the
commit message (that the spinlock is only used to serialize probe()s).

Best Regards,
Michał Mirosław
