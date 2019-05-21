Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809BAC04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604822173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfEUPaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:30:17 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33556 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728045AbfEUPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:30:17 -0400
Received: (qmail 5537 invoked by uid 2102); 21 May 2019 11:30:16 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 May 2019 11:30:16 -0400
Date:   Tue, 21 May 2019 11:30:16 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] signal/usb: Replace kill_pid_info_as_cred with
 kill_pid_usb_asyncio
In-Reply-To: <87zhnfooe6.fsf@xmission.com>
Message-ID: <Pine.LNX.4.44L0.1905211129020.1634-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Eric W. Biederman wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:

> >> 	req = (struct usb_ctrlrequest *) buf;
> >> 	req->bRequestType = USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE;
> >> 	req->bRequest = USB_REQ_GET_DESCRIPTOR;
> >> 	req->wValue = htole16(USB_DT_DEVICE << 8);
> >> 	req->wIndex = htole16(0);
> >> 	req->wLength = htole16(sizeof(buf) - sizeof(*req));
> >
> > In fact, these values are supposed to be in host-endian order, not 
> > necessarily little-endian.  The USB core converts them if necessary.
> 
> Please look again.  In include/uapi/linux/ch9.h those fields are
> explicitly defined as little endian and the code in devio.c for
> USBDEVFS_URB_TYPE_CONTROL treats them as little endian.   Perhaps there
> is a mismatch here but I haven't seen it and I needed this change to get
> the code to work on big endian.

Oops -- you're right.  I was thinking of the USBDEVFS_CONTROL ioctl.  
Sorry for the mistake.

Alan Stern

