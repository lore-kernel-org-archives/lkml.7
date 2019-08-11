Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C86C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 07:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F352173C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 07:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565509141;
	bh=rDPur0W+1VXoSFsqC7Oy5zZuS7kXVeH9wsZgVIf7ZHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zqt7IKe/uSbL7UV/1Z1NAu46q23aIZKHUsSXkVZanzWN4EHOs9WQ8bY/y5YXpt5Bf
	 PeLqE9VOK8vkuOkqvo9Hyn9wlg1Bp4HCAuyheNMpAopzZWYAK0peUn6kntgGO3mzix
	 3hGa1iDuhsJ1AW40rY4B0P5P586Ya9zI0vai8vw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHKHjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 03:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfHKHjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 03:39:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A76D6216F4;
        Sun, 11 Aug 2019 07:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565509139;
        bh=rDPur0W+1VXoSFsqC7Oy5zZuS7kXVeH9wsZgVIf7ZHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qCgHlruYxieESEdpthz2QuHYzRbXqhKPu1pEO9KK5lik556WYPpewm0Z20HXZos78
         DnO5VcsTQf8OsiX1xFhakXteFsLRBgb3FzDvL28wjGaZFg0A3rUGQZ/hH6jP4lmaEw
         Rje+5AHx2dqQMkQGIZwm7+vooj5+97/QxL3qbQ80=
Date:   Sun, 11 Aug 2019 09:38:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>
Subject: Re: [PATCH] habanalabs: print to kernel log when reset is finished
Message-ID: <20190811073856.GC3034@kroah.com>
References: <20190810123808.13845-1-oded.gabbay@gmail.com>
 <20190810125344.GE15251@kroah.com>
 <CAFCwf10SV0w-HQHuONSmdcDYFjmCJN3PLzc89MQMO4j37Qum=w@mail.gmail.com>
 <20190810172317.GA4482@kroah.com>
 <CAFCwf12E7CQFG1=etvYogp7rvg8+R=hYR0OBD3j1Zqba1u5Hug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12E7CQFG1=etvYogp7rvg8+R=hYR0OBD3j1Zqba1u5Hug@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 08:45:54PM +0300, Oded Gabbay wrote:
> On Sat, Aug 10, 2019 at 8:23 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Aug 10, 2019 at 06:29:16PM +0300, Oded Gabbay wrote:
> > > On Sat, Aug 10, 2019 at 3:53 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sat, Aug 10, 2019 at 03:38:08PM +0300, Oded Gabbay wrote:
> > > > > Now that we don't print the queue testing messages, we need to print when
> > > > > the reset is finished so whoever looks at the kernel log will know the
> > > > > reset process was finished successfully and the driver is not stuck.
> > > > >
> > > > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > > > ---
> > > > >  drivers/misc/habanalabs/device.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> > > > > index 9a5926888b99..1fac808c2546 100644
> > > > > --- a/drivers/misc/habanalabs/device.c
> > > > > +++ b/drivers/misc/habanalabs/device.c
> > > > > @@ -907,6 +907,8 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
> > > > >       else
> > > > >               hdev->soft_reset_cnt++;
> > > > >
> > > > > +     dev_info(hdev->dev, "Successfully finished resetting the device\n");
> > > >
> > > > Really?  For doing things "properly" there is no need to spam the kernel
> > > > log.  Only spit stuff out if an error happens.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > I beg to differ for two reasons:
> > > 1. Reset happens very rarely, if at all. So this message (that get
> > > printed after reset is done) will definitely not spam the kernel log.
> > > 2. When a reset starts we print an appropriate error message. I think
> > > it is expected by the user that we will also print if and when the
> > > reset has finished successfully. I really believe that lack of this
> > > printing might be deceiving for users.
> >
> > How is anyone going to parse the kernel log for anything to know if
> > something happens?
> 
> Actually our jenkins server parse the kernel log and look for bad
> messages from the driver...
> But the main reason for this, IMO, is for developers (in userspace)
> that run with a terminal open on the kernel log to see if something
> bad happens while they run their applications.
> 
> >
> > How do you trigger a reset?  Is it done by userspace?  If so, just
> > notify them then.
> 
> Reset can be triggered by two main reasons, but a userspace
> application is *not* one of them.
> It can be due to a command submission not finishing in time or from a
> major error in the device (e.g. double ECC error).
> That's why I think it is important to tell them the reset +
> re-initialization flow was finished successfully.
> Of course all this information, let's call it operational status, can
> be acquired by the INFO IOCTL the driver provides, but it is *really*
> convenient, IMHO, to see these type of messages in the kernel log
> while they happen.

Ah, yes, if this is something that userspace can not trigger then it's
ok.  But you should then make it a 'dev_warn' to match up with the
message level when the reset starts.

thanks,

greg k-h
