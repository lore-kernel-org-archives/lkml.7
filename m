Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248B4C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A8B20578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfIWO6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:58:52 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33515 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727164AbfIWO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:58:51 -0400
Received: (qmail 27342 invoked by uid 500); 23 Sep 2019 10:58:50 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Sep 2019 10:58:50 -0400
Date:   Mon, 23 Sep 2019 10:58:50 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Austin Kim <austindh.kim@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <mathias.nyman@linux.intel.com>, <Thinh.Nguyen@synopsys.com>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>, <malat@debian.org>,
        <dianders@chromium.org>
Subject: Re: [PATCH] usb: hub: Minor refactoring in usb_hub_init()
In-Reply-To: <20190923071145.GB2746429@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1909231053500.24712-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019, Greg KH wrote:

> On Mon, Sep 23, 2019 at 03:19:21PM +0900, Austin Kim wrote:
> > Normally when creation of workqueue fails, exception handling takes place
> > after the call to alloc_workqueue() is made.
> > 
> > But looking into usb_hub_init() function, 'return 0' statement is executed,
> > when alloc_workqueue() returns valid workqueue pointer.
> >        if (hub_wq)
> >                return 0;
> > 
> > This might make other Linux driver developers get confused 
> > because they could deduce that this is exceptional handling routine.
> > 
> > So perform minor refactoring by adding NULL pointer dereference check
> > routine right after the call to alloc_workqueue() is made.
> > 
> > Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> > ---
> >  drivers/usb/core/hub.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index e8ebacc..0ddbfe6 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -5530,9 +5530,12 @@ int usb_hub_init(void)
> >  	 * over to the companion full-speed controller.
> >  	 */
> >  	hub_wq = alloc_workqueue("usb_hub_wq", WQ_FREEZABLE, 0);
> > -	if (hub_wq)
> > -		return 0;
> > +	if (unlikely(!hub_wq))
> 
> Only ever use likely/unlikely if you can measure the difference without
> it.  Otherwise the compiler and cpu will almost always do this better
> than you.
> 
> So please remove this.
> 
> > +		goto err_workqueue;
> > +
> > +	return 0;
> >  
> > +err_workqueue:
> >  	/* Fall through if kernel_thread failed */
> 
> This comment is now incorrect.
> 
> But really, there is nothing wrong with the original code here.  It
> works properly, and while it is not identical to normal code "style"
> here, there's nothing wrong with it that I can see.

Indeed.  In fact, I suspect that this change would make the code less 
understandable, because the reader would wonder why anybody would go to 
the trouble of jumping over a return statement.  After all, this:

	if (!test)
		jump error;
	return 0;
 error:

just looks like a strange and inefficient way of writing:

	if (test)
		return 0;

Anyone reading it would wonder what the original author was thinking.

If you really want to fix up this subroutine, you could change the two 
"return -1" statements.  They should return an appropriate error code, 
not just -1.

Alan Stern

