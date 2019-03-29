Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE19DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755992184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553885413;
	bh=pQZnyx7z1bl8M0Zh90wSuauyzk4v8LtktYLjmNjH1m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LdBgeJm0vBuTLIHDTwlj92THNUqYAcALEisUT0k0/aychhHLZa29ZdWB2Au3d95oO
	 AR9Q1QpQ+ePcLSY3B/FWrabdGrqn2L2ks9+ZJqYCc+mslmjama+rtFj9xCSis89j/l
	 ApybGS9SoE0jE3Ssk2379OFh5n3eJ/wSAbjiU+dU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfC2SuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbfC2SuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:50:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B96E2184D;
        Fri, 29 Mar 2019 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553885410;
        bh=pQZnyx7z1bl8M0Zh90wSuauyzk4v8LtktYLjmNjH1m0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYWrEmsbqSzwLwTf+IjIbEE1PCIUiE1j2/lGCaRR2UPFbTszS/9dRVlABqGqjfw7L
         RGgovz8yKhXbyeykjn/7GPz4UNkGjoQyp3MBqzTrNUWp2CyzLbpR4vMeoF5sBePEwH
         zAck8W8ZUyBBSRIztHb152LKGGFDXAh4w9U6Ob+I=
Date:   Fri, 29 Mar 2019 19:50:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] habanalabs: improve error messages
Message-ID: <20190329185008.GA4809@kroah.com>
References: <20190328071313.5306-1-oded.gabbay@gmail.com>
 <20190329162955.GA10386@kroah.com>
 <CAFCwf12oTXFsOaMaFOq4AfPDC3qYExvP9yKB7Za8G7W76O_A0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12oTXFsOaMaFOq4AfPDC3qYExvP9yKB7Za8G7W76O_A0Q@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 08:29:08PM +0300, Oded Gabbay wrote:
> On Fri, Mar 29, 2019 at 7:29 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Mar 28, 2019 at 09:13:13AM +0200, Oded Gabbay wrote:
> > > This patch improves two error messages to help the user to
> > > better understand what error occurred.
> > >
> > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > ---
> > >  drivers/misc/habanalabs/command_submission.c | 3 ++-
> > >  drivers/misc/habanalabs/memory.c             | 2 +-
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
> > > index f908643f871f..02c48da0b645 100644
> > > --- a/drivers/misc/habanalabs/command_submission.c
> > > +++ b/drivers/misc/habanalabs/command_submission.c
> > > @@ -261,7 +261,8 @@ static void cs_timedout(struct work_struct *work)
> > >       ctx_asid = cs->ctx->asid;
> > >
> > >       /* TODO: add information about last signaled seq and last emitted seq */
> > > -     dev_err(hdev->dev, "CS %d.%llu got stuck!\n", ctx_asid, cs->sequence);
> > > +     dev_err(hdev->dev, "User %d command submission %llu got stuck!\n",
> > > +             ctx_asid, cs->sequence);
> > >
> > >       cs_put(cs);
> > >
> > > diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> > > index ce1fda40a8b8..39788b1cf8d0 100644
> > > --- a/drivers/misc/habanalabs/memory.c
> > > +++ b/drivers/misc/habanalabs/memory.c
> > > @@ -109,7 +109,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> > >                                                       page_size);
> > >                       if (!phys_pg_pack->pages[i]) {
> > >                               dev_err(hdev->dev,
> > > -                                     "ioctl failed to allocate page\n");
> > > +                                     "Failed to allocate device memory (out of memory)\n");
> >
> > No need for a message at all here, right?  The core should have already
> > told you you had a problem.
> >
> > greg k-h
> 
> No, I don't think so, because this function is called for allocating
> memory in the device's DRAM. So we don't pass through the Linux core
> code inside.
> We use the generic genalloc module to implement the device's DRAM
> physical page allocator, and AFAIK, you won't get any message in case
> genalloc fails to find a free memory in its pool.
> Even if genalloc prints something, I would prefer to display a more
> meaningful message to the user in this case. This allocation is
> directly requested by the user (its part of the IOCTL code) and he
> should know how it failed, no ?

Ok, that sounds reasonable, nevermind :)

greg k-h
