Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15A8FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ACC21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571241932;
	bh=Kx2mEOhlNQSvn3TSaXkT9PV90J17hLoKYSDzCwfVLhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0AYUljFp8SsczfsAIvFPokQ21fY4OSuJBj+Z/Rpmk2TOgGbvetHf/ew6k+XMPUGQS
	 hKRQ6kaL6bRjOwIulUFRbAGpgMMM1VAig1opURM7Yp8NWySUeSFUJX0Zx1ZEh4V+8L
	 Mg5X/dXQBqOzNxFkIkGIJdz80fQp77Xhdj337U0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfJPQFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbfJPQFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:05:31 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0B12067D;
        Wed, 16 Oct 2019 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571241930;
        bh=Kx2mEOhlNQSvn3TSaXkT9PV90J17hLoKYSDzCwfVLhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+eMBFhmov31ZYMZ9+meo/lpVNH9/YsFxHhNusz95iMu7HUIESsVWjsc7fX14EsFI
         m28DAug80KrXLHnJI3sQlu9UOdcOSnLYmGvWUiQ5QJPSLw1nnUHyU75hojgMSFpHO/
         dG+415nasZr/HEXyyjSxI8LLckvKSicPH6UAoWFA=
Date:   Wed, 16 Oct 2019 06:53:00 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Michael Moese <mmoese@suse.de>, Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH] drivers: mcb: use symbol namespaces
Message-ID: <20191016135300.GA302460@kroah.com>
References: <20191016100158.1400-1-jthumshirn@suse.de>
 <20191016125139.GA26497@kroah.com>
 <48f87640-d277-fdb6-3d6e-3f88b7623f22@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48f87640-d277-fdb6-3d6e-3f88b7623f22@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:45:08PM +0200, Johannes Thumshirn wrote:
> On 16/10/2019 14:51, Greg KH wrote:
> > On Wed, Oct 16, 2019 at 12:01:58PM +0200, Johannes Thumshirn wrote:
> >> Now that we have symbol namespaces, use them in MCB to not pollute the
> >> default namespace with MCB internals.
> >>
> >> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> >> ---
> >>  drivers/gpio/gpio-menz127.c            |  1 +
> >>  drivers/iio/adc/men_z188_adc.c         |  1 +
> >>  drivers/mcb/mcb-core.c                 | 28 ++++++++++++++--------------
> >>  drivers/mcb/mcb-lpc.c                  |  1 +
> >>  drivers/mcb/mcb-parse.c                |  2 +-
> >>  drivers/mcb/mcb-pci.c                  |  1 +
> >>  drivers/tty/serial/8250/8250_men_mcb.c |  1 +
> >>  drivers/tty/serial/men_z135_uart.c     |  1 +
> >>  drivers/watchdog/menz69_wdt.c          |  1 +
> >>  9 files changed, 22 insertions(+), 15 deletions(-)
> > 
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Btw do you want me to send it to you again shortly before the merge
> window opens or can you queue it up before?

I can take this now, into my -next tree.  I'll do so later this week
unless you object.

thanks,

greg k-h
