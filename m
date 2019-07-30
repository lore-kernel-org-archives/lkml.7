Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEB6C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1CC208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfG3NtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:49:14 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37768 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725871AbfG3NtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:49:13 -0400
Received: (qmail 1700 invoked by uid 2102); 30 Jul 2019 09:49:12 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jul 2019 09:49:12 -0400
Date:   Tue, 30 Jul 2019 09:49:12 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     Hillf Danton <hdanton@sina.com>, Takashi Iwai <tiwai@suse.de>,
        syzbot <syzbot+d952e5e28f5fb7718d23@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in snd_usb_motu_microbookii_communicate/usb_submit_urb
In-Reply-To: <CAAeHK+zT+VhrxPDNFxCoVDrgBhmTiAuRjQv_A6SC91x8w0HmoQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1907300941150.1507-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019, Andrey Konovalov wrote:

> On Sat, Jul 20, 2019 at 4:14 PM Hillf Danton <hdanton@sina.com> wrote:

> > Wow it finally comes up at the third time with sound/usb/quirks.c:999
> > tippointing to commit 801ebf1043ae ("ALSA: usb-audio: Sanity checks
> > for each pipe and EP types").
> >
> > That commit not only proves this warning is bogus but casts light
> > on fixing it.
> >
> > 1, Make the helper created in the commit available outside sound/usb
> > with a new name. No functionality change intended.
> >
> > --- a/include/linux/usb.h
> > +++ b/include/linux/usb.h
> > @@ -1748,7 +1748,20 @@ static inline int usb_urb_dir_out(struct urb *urb)
> >         return (urb->transfer_flags & URB_DIR_MASK) == URB_DIR_OUT;
> >  }
> >
> > -int usb_urb_ep_type_check(const struct urb *urb);
> > +int usb_pipe_ep_type_check(struct usb_device *dev, unsigned int pipe);
> > +
> > +/**
> > + * usb_urb_ep_type_check - sanity check of endpoint in the given urb
> > + * @urb: urb to be checked
> > + *
> > + * This performs a light-weight sanity check for the endpoint in the
> > + * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
> > + * a negative error code.
> > + */
> > +static inline int usb_urb_ep_type_check(const struct urb *urb)
> > +{
> > +       return usb_pipe_ep_type_check(urb->dev, urb->pipe);
> > +}

Okay, fine.

> >
> >  void *usb_alloc_coherent(struct usb_device *dev, size_t size,
> >         gfp_t mem_flags, dma_addr_t *dma);
> > --- a/drivers/usb/core/urb.c
> > +++ b/drivers/usb/core/urb.c
> > @@ -191,25 +191,24 @@ static const int pipetypes[4] = {
> >  };
> >
> >  /**
> > - * usb_urb_ep_type_check - sanity check of endpoint in the given urb
> > - * @urb: urb to be checked
> > + * usb_pipe_ep_type_check - sanity type check of endpoint against the given pipe
> > + * @dev: usb device whose endpoint to be checked
> > + * @pipe: the pipe type to match
> >   *
> > - * This performs a light-weight sanity check for the endpoint in the
> > - * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
> > - * a negative error code.
> > + * Return 0 if endpoint matches pipe, otherwise error code.
> >   */
> > -int usb_urb_ep_type_check(const struct urb *urb)
> > +int usb_pipe_ep_type_check(struct usb_device *dev, unsigned int pipe)
> >  {
> >         const struct usb_host_endpoint *ep;
> >
> > -       ep = usb_pipe_endpoint(urb->dev, urb->pipe);
> > +       ep = usb_pipe_endpoint(dev, pipe);
> >         if (!ep)
> >                 return -EINVAL;
> > -       if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
> > +       if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
> >                 return -EINVAL;
> >         return 0;
> >  }
> > -EXPORT_SYMBOL_GPL(usb_urb_ep_type_check);
> > +EXPORT_SYMBOL_GPL(usb_pipe_ep_type_check);

Again, fine.

> >
> >  /**
> >   * usb_submit_urb - issue an asynchronous transfer request for an endpoint
> > --
> >
> > 2, With helper in place, make the warning not bogus any more.
> >
> >
> > --- a/drivers/usb/core/message.c
> > +++ b/drivers/usb/core/message.c
> > @@ -242,7 +242,12 @@ int usb_bulk_msg(struct usb_device *usb_dev, unsigned int pipe,
> >
> >         if ((ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
> >                         USB_ENDPOINT_XFER_INT) {
> > -               pipe = (pipe & ~(3 << 30)) | (PIPE_INTERRUPT << 30);
> > +               /*
> > +                * change pipe unless we mess things up
> > +                */
> > +               if (usb_pipe_ep_type_check(usb_dev, pipe))
> > +                       pipe = (pipe & ~(3 << 30)) | (PIPE_INTERRUPT << 30);
> > +
> >                 usb_fill_int_urb(urb, usb_dev, pipe, data, len,
> >                                 usb_api_blocking_completion, NULL,
> >                                 ep->desc.bInterval);

What reason is there for adding this extra test?  It probably takes
longer to do the test than it does to just perform the bitmask and
store.

> > --
> >
> > 3, Do some cleanup in sound/usb.
> >
> >
> > --- a/sound/usb/helper.h
> > +++ b/sound/usb/helper.h
> > @@ -7,7 +7,6 @@ unsigned int snd_usb_combine_bytes(unsigned char *bytes, int size);
> >  void *snd_usb_find_desc(void *descstart, int desclen, void *after, u8 dtype);
> >  void *snd_usb_find_csint_desc(void *descstart, int desclen, void *after, u8 dsubtype);
> >
> > -int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe);
> >  int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe,
> >                     __u8 request, __u8 requesttype, __u16 value, __u16 index,
> >                     void *data, __u16 size);
> > --- a/sound/usb/helper.c
> > +++ b/sound/usb/helper.c
> > @@ -63,20 +63,6 @@ void *snd_usb_find_csint_desc(void *buffer, int buflen, void *after, u8 dsubtype
> >         return NULL;
> >  }
> >
> > -/* check the validity of pipe and EP types */
> > -int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe)
> > -{
> > -       static const int pipetypes[4] = {
> > -               PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
> > -       };
> > -       struct usb_host_endpoint *ep;
> > -
> > -       ep = usb_pipe_endpoint(dev, pipe);
> > -       if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
> > -               return -EINVAL;
> > -       return 0;
> > -}
> > -
> >  /*
> >   * Wrapper for usb_control_msg().
> >   * Allocates a temp buffer to prevent dmaing from/to the stack.
> > @@ -89,7 +75,7 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
> >         void *buf = NULL;
> >         int timeout;
> >
> > -       if (snd_usb_pipe_sanity_check(dev, pipe))
> > +       if (usb_pipe_ep_type_check(dev, pipe))
> >                 return -EINVAL;

This looks sane.  I'll leave to it Takashi to comment on the rest of 
the sound driver changes.

Alan Stern

