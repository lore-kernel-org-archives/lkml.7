Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD16C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DF0206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570427973;
	bh=tfzGYeVYfOBZkfx+VycdiLQMeb8ivldNc8IJ+sPa3eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WZ2HllOYID2Cxr/JACW9oyF+LizYFnJ3hEeL7kZ9CORRFG/RZ298Ha7SENxDlEplK
	 CRUWlzjIGMsGHcDsCZZmShQsZqK5jdlRq3KNiJCg5YvGSZVEzLDWLa1eo9TEN7ZtP1
	 s4pv+6+I7WLdMtg1A9FEaA+espddzK4xpuzO3N30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfJGF7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 01:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfJGF7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 01:59:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29445206C2;
        Mon,  7 Oct 2019 05:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570427969;
        bh=tfzGYeVYfOBZkfx+VycdiLQMeb8ivldNc8IJ+sPa3eU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lr8sSv5hFUTUBbDz3oENh+kaSli4sPEaqqwswkTg8IHuPRYlvjB7e5+0mMK3zrzcN
         ng+T8ydUMizuyqTMoHzQvCwbtp8hYGpcAtkzAUB9x1TBLNMMMzxVdAn+KcslvCkrh3
         v2RSJ4oojISOAVq7h6jXosVv4DzuXsYCdydLcaMU=
Date:   Mon, 7 Oct 2019 07:59:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Question about using #ifdef CONFIG_PPC64 in driver code
Message-ID: <20191007055925.GA271894@kroah.com>
References: <CAFCwf11-MzroWUmj4qOgwLTibqsdOmPP9cHJjXZmS0Pgr3bEOQ@mail.gmail.com>
 <CAFCwf13AtwkWQ4Gnxi6pfKbcdEK95+X__7cFboN1FdHd1aKNQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13AtwkWQ4Gnxi6pfKbcdEK95+X__7cFboN1FdHd1aKNQw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 12:33:31PM +0300, Oded Gabbay wrote:
> Hi Greg,
> a while ago we had an argument about identifying in my driver's code
> whether I'm running on x86 or powerpc. I tried to do something
> dynamically (based on parent pci bridge ID), and you and other people
> objected to it.
> 
> I see in other drivers (more then a few) that they are using #ifdef
> CONFIG_PPC64 in some places for similar things (e.g. to run code that
> is only needed in case of powerpc).
> 
> e.g. from ocxl driver in misc:
> 
> #ifdef CONFIG_PPC64
> static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
> ...
> #endif
> and also:
> 
> #ifdef CONFIG_PPC64
> if (cpu_has_feature(CPU_FTR_P9_TIDR))
> arg.flags[0] |= OCXL_IOCTL_FEATURES_FLAGS0_P9_WAIT;
> #endif

ocxl is arguably maybe an exception here, given that it is a PPC64 bus
only from what I can tell.  Odd that they are using this option, but I
think it might be just to keep CONFIG_TEST to work properly.

> Is this approach acceptable on you ?
> Can I do something similar in my driver:
> 
> #ifdef CONFIG_PPC64
>       foo (64)
> #else
>       foo (48)
> #endif

The thing is, why do you need this?  What makes that platform somehow
unique for your driver?  Focus on that and you should be able to detect
it specifically, not just the processor type (which usually is on a wide
range of hardware types.)

thanks,

greg k-h
