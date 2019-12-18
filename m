Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E6FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A232465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576699586;
	bh=3L7/LCfX70ZSfZYg6b0sMUdpnBzhD9sC4HrRn/l6Crk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PI7/ZHkc7Svyjl4rm/8ljIsrPfaQ5OdHxOofoZUDCJDIyjhssPLxYrDF5QZoK32sD
	 /ISkmL5gJgxY1Pag97HUt6zFrNLHd2cj1ZveaGWUvZAHk9J0uz+R8dZHJh2k/yRaUY
	 lMx7fDF42pfDo8/Y4qYp9iTwCSPGqTStsG76z2s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfLRUGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:06:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbfLRUGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:06:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ECE32176D;
        Wed, 18 Dec 2019 20:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576699584;
        bh=3L7/LCfX70ZSfZYg6b0sMUdpnBzhD9sC4HrRn/l6Crk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ElTrCCrf8flkRWXdFBw/HZ6zcBHW6CscH87FWYXx73+kOHysnrNbwPfPiL7whHLnM
         +b5r2sp+BLgYV8hnGxvWARgg7Us5H6vZoCTfPt05+UEZxMv2EZu31iY4gZbqR5E74k
         8gR1zQX7fwl2oj7c1sR8BvWkoaTrcgzQj7veIsK8=
Date:   Wed, 18 Dec 2019 21:06:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v3 1/1] usb: gadget: add raw-gadget interface
Message-ID: <20191218200621.GA913802@kroah.com>
References: <cover.1576087039.git.andreyknvl@google.com>
 <f45a20db3e5b01002ae8c91b3a8ea58e38b7bb65.1576087039.git.andreyknvl@google.com>
 <20191218132328.GA121143@kroah.com>
 <CAAeHK+zXegV1GmSKD8Y3-hTbKUQceWdfo+GJPxSSzYr0zQTYKw@mail.gmail.com>
 <20191218181921.GA882018@kroah.com>
 <CAAeHK+zqzXBwdBnfPjN+tY4y3dZ2Fb_FR0es5_-ynOZyhrL6uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zqzXBwdBnfPjN+tY4y3dZ2Fb_FR0es5_-ynOZyhrL6uQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 08:22:47PM +0100, Andrey Konovalov wrote:
> > > > > +static void gadget_unbind(struct usb_gadget *gadget)
> > > > > +{
> > > > > +     struct raw_dev *dev = get_gadget_data(gadget);
> > > > > +     unsigned long flags;
> > > > > +
> > > > > +     spin_lock_irqsave(&dev->lock, flags);
> > > > > +     set_gadget_data(gadget, NULL);
> > > > > +     spin_unlock_irqrestore(&dev->lock, flags);
> > > > > +     /* Matches kref_get() in gadget_bind(). */
> > > > > +     kref_put(&dev->count, dev_free);
> > > >
> > > > What protects the kref from being called 'put' twice on the same
> > > > pointer at the same time?  There should be some lock somewhere, right?
> > >
> > > Hm, kref_put() does refcount_dec_and_test(), which in turns calls
> > > atomic_dec_and_test(), so this is protected against concurrent puts
> > > (which is the whole idea of kref?), and no locking is needed. Unless I
> > > misunderstand something.
> >
> > It's late, but there should be some lock somewhere to prevent a race
> > around this type of thing.  That's why we have kref_put_mutex() and
> > kref_put_lock().
> >
> > Odds are you are fine here, but just something to be aware of...
> 
> Ah, I see. So AFAIU kref_put_lock/mutex() are meant to be used in
> cases when there might be a concurrent user that doesn't have the
> reference counter incremented, but holds the lock? We don't do this
> kind of stuff here.

Ok, as long as there is a lock somewhere preventing this type of thing
from happening.  Last time I looked at this, it took me and 2 grad
students an hour with a whiteboard to work it all out.  Which is why the
lock variants are there now :)

thanks,

greg k-h
