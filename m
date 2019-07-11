Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7525EC74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E7821537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562828448;
	bh=8tYiPo23RhF+zMZps2Ew0kc5pCJq6pKf0897T8FJ+mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v2CUWKtvRd8z2i+xkjxjJmcKn5Eq88fUFvzPpRYrxZ4y5n7s6j+EN+3G/Jk2o31bG
	 45gFZTqqc80610wLspzrPMOT3fsBoN89E9+3AOcGoaxtSiW+RK9qTl87ea4wchNPM5
	 jvDlAJFPyju47TZLVQKlSPB1Scmy3mUmeg3ugczI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfGKHAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 03:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfGKHAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 03:00:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D0D721019;
        Thu, 11 Jul 2019 07:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562828445;
        bh=8tYiPo23RhF+zMZps2Ew0kc5pCJq6pKf0897T8FJ+mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iV0jZspRmlN9/eN2/iuxb829Lq2LG2suZ25E6HocavImKwEzdEv108DDo4NCerNEm
         7kVfWGPvYAKHrpHMGfChBYvD8/+wbDUbvW8+x3gc1HSB8LCF+LSejxETDVJHT3AHlu
         Y6O63tlyFRfvSFZOZ9Abr7F0aKIkbhep61tYYQ6Q=
Date:   Thu, 11 Jul 2019 09:00:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     devel@driverdev.osuosl.org, Alex Elder <elder@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, David Lin <dtwlin@gmail.com>
Subject: Re: [PATCH] staging: greybus: add logging statement when kfifo_alloc
 fails
Message-ID: <20190711070042.GA28487@kroah.com>
References: <20190710122018.2250-1-iamkeyur96@gmail.com>
 <20190710163538.GA30902@kroah.com>
 <20190710142406.GA6669@keyur-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710142406.GA6669@keyur-pc>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 10:24:06AM -0400, Keyur Patel wrote:
> On Wed, Jul 10, 2019 at 06:35:38PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jul 10, 2019 at 08:20:17AM -0400, Keyur Patel wrote:
> > > Added missing logging statement when kfifo_alloc fails, to improve
> > > debugging.
> > > 
> > > Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
> > > ---
> > >  drivers/staging/greybus/uart.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
> > > index b3bffe91ae99..86a395ae177d 100644
> > > --- a/drivers/staging/greybus/uart.c
> > > +++ b/drivers/staging/greybus/uart.c
> > > @@ -856,8 +856,10 @@ static int gb_uart_probe(struct gbphy_device *gbphy_dev,
> > >  
> > >  	retval = kfifo_alloc(&gb_tty->write_fifo, GB_UART_WRITE_FIFO_SIZE,
> > >  			     GFP_KERNEL);
> > > -	if (retval)
> > > +	if (retval) {
> > > +		pr_err("kfifo_alloc failed\n");
> > >  		goto exit_buf_free;
> > > +	}
> > 
> > You should have already gotten an error message from the log if this
> > fails, from the kmalloc_array() call failing, right?
> > 
> > So why is this needed?  We have been trying to remove these types of
> > messages and keep them in the "root" place where the failure happens.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Didn't notice that. I agree that this will result only into redundancy. 
> Quick look over files reveal that there are multiple places
> where people are using print statements after memory allocation fails. 
> Should I go ahead and send patches to remove those
> redundant print statements?

It all depends on where in the kernel those are.  Some subsystems want
minor cleanups like this, but most do not.  So unless the issue you find
is in the drivers/staging/ directory, I would not worry about it.

thanks,

greg k-h
