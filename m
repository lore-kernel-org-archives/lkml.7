Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91290C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 17:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C53208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565457802;
	bh=jCXzlGsK/hiiDUH92GLJA6mLdo0jK56z2ilQ5MY21Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jADX8XGfcJSBVZrLsZppOKLditu/26i56O4MOEYr4OOo3WH7eiVNF9V2pOn6poTRK
	 4kGiMU3L8HXlzXoY0CfUZl+M6oJbZIKI7Zr52s//hI7IE3+O2a9yIFrYlRH+ZUAgap
	 0URoYk2nMMitows9oEwXdjdKcPIkoGyS1i1sSRog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfHJRXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 13:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfHJRXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 13:23:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D0362085B;
        Sat, 10 Aug 2019 17:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565457799;
        bh=jCXzlGsK/hiiDUH92GLJA6mLdo0jK56z2ilQ5MY21Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pflZtSaJPK9kADkjnM/PHGpGWpQ+hMELDbMqvlByEVKMFCRxSyL2LTA8tjwVu6G/Z
         weqHOtUrWyuFOs/BdN9hiw1qNCYK0izRcXY8WQfbQKiaSS0grjPwrIiBvWGY8UtfDC
         xTtNLO/pzW0/XpqACo1U3ecVpxfbw8UQLBWRKVJY=
Date:   Sat, 10 Aug 2019 19:23:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>
Subject: Re: [PATCH] habanalabs: print to kernel log when reset is finished
Message-ID: <20190810172317.GA4482@kroah.com>
References: <20190810123808.13845-1-oded.gabbay@gmail.com>
 <20190810125344.GE15251@kroah.com>
 <CAFCwf10SV0w-HQHuONSmdcDYFjmCJN3PLzc89MQMO4j37Qum=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf10SV0w-HQHuONSmdcDYFjmCJN3PLzc89MQMO4j37Qum=w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 06:29:16PM +0300, Oded Gabbay wrote:
> On Sat, Aug 10, 2019 at 3:53 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Aug 10, 2019 at 03:38:08PM +0300, Oded Gabbay wrote:
> > > Now that we don't print the queue testing messages, we need to print when
> > > the reset is finished so whoever looks at the kernel log will know the
> > > reset process was finished successfully and the driver is not stuck.
> > >
> > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > ---
> > >  drivers/misc/habanalabs/device.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> > > index 9a5926888b99..1fac808c2546 100644
> > > --- a/drivers/misc/habanalabs/device.c
> > > +++ b/drivers/misc/habanalabs/device.c
> > > @@ -907,6 +907,8 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
> > >       else
> > >               hdev->soft_reset_cnt++;
> > >
> > > +     dev_info(hdev->dev, "Successfully finished resetting the device\n");
> >
> > Really?  For doing things "properly" there is no need to spam the kernel
> > log.  Only spit stuff out if an error happens.
> >
> > thanks,
> >
> > greg k-h
> 
> I beg to differ for two reasons:
> 1. Reset happens very rarely, if at all. So this message (that get
> printed after reset is done) will definitely not spam the kernel log.
> 2. When a reset starts we print an appropriate error message. I think
> it is expected by the user that we will also print if and when the
> reset has finished successfully. I really believe that lack of this
> printing might be deceiving for users.

How is anyone going to parse the kernel log for anything to know if
something happens?

How do you trigger a reset?  Is it done by userspace?  If so, just
notify them then.

thanks,

greg k-h
