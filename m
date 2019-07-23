Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17494C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A7E223BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chFIHmor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390965AbfGWRDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 13:03:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44426 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbfGWRDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:03:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so19429374pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKGzsnNbo5fu1aH8bTo2DamYZKTo8Iui0R3ANSx0cMY=;
        b=chFIHmorjaFTB9tyIfbdCKVVuJfAONRd+Wvbp9x+QGWWwj+IscZ1JYRLkt1SR2HFpr
         YNpNM21CyYkf8PlKOggtATeLhj/kHoxdTgEzGoZL6x79GB5Hu4t3w6zekSS5QPH0hv1u
         h/R/TvDNifKNFP9/xIXybKQokBZXGQNGqKsmipfRkzVoHaip6U6QQfhn+OV26O7rGevC
         KPVAiHckzKaMeKqtCZllPu0Qj2wibqTHgqDkNZxP8030v80HK9pV35GFVeFDu26educ4
         MlxKK25UBlUMs+odvXHqQfoJ9hrByIczrCqY7axlUNrRwNfhM3m5fjVOlD8LBiGZLSSf
         jdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKGzsnNbo5fu1aH8bTo2DamYZKTo8Iui0R3ANSx0cMY=;
        b=bYb9pLu9HKCa0qW6bmevFL47SFkDNj83id58Jvu4vm+gaNswa1exxu5mSCeO56mPSG
         vToXm0GanVcMpklhVTwb30qfg7YcdwyyB+pi/TA6df7dKZ9EkZ0ILj4/Yf3lbTrxs02v
         dYxrds+7dpzegMCpLPKLD0DICcu/61YmlH+09nlaBBY+Tn2+AE6mvVx0xGksI9G6kdGs
         Zx1DVkWimNKgnphKfP2ota2IuuNmIUVxoxGXnHHfpgYDk5GqiGvjjduhA0cgSjQ9JhzP
         BCH1OAv96y/kenxq1DmGtPlzuvKrz5Qa75cmi4gMNGQaD2FaNw23gtf8Y93uQuh6K6up
         t2XQ==
X-Gm-Message-State: APjAAAVwu1gGi1DmRbSjSe53ja1iCDtE8HezN5s6MsnjNjtQu50MVKvH
        du6WRKHXmrOZmkrma/5g3P+ghA6r0GLgQzeAePB3cw==
X-Google-Smtp-Source: APXvYqynh5+89A7gSkNmrYA4J0NBxNEei9fbqKgf6M4cMpQxlQIu0qfq5kU9qzZRW9dV9JnNjVi7PBJfbeWcPIdq9i4=
X-Received: by 2002:aa7:97bb:: with SMTP id d27mr6713331pfq.93.1563901421607;
 Tue, 23 Jul 2019 10:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000acb99a058b0d5741@google.com> <000000000000ac8f77058e0d11e9@google.com>
In-Reply-To: <000000000000ac8f77058e0d11e9@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 23 Jul 2019 19:03:29 +0200
Message-ID: <CAAeHK+zT+VhrxPDNFxCoVDrgBhmTiAuRjQv_A6SC91x8w0HmoQ@mail.gmail.com>
Subject: Re: WARNING in snd_usb_motu_microbookii_communicate/usb_submit_urb
To:     Hillf Danton <hdanton@sina.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Takashi Iwai <tiwai@suse.de>
Cc:     syzbot <syzbot+d952e5e28f5fb7718d23@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 4:14 PM Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Fri, 19 Jul 2019 11:41:05 -0700 (PDT)
> > syzbot has found a reproducer for the following crash on:
> >
> > HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=149006d0600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d952e5e28f5fb7718d23
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1710cd48600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17650a34600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+d952e5e28f5fb7718d23@syzkaller.appspotmail.com
> >
> > usb 1-1: string descriptor 0 read error: -22
> > usb 1-1: New USB device found, idVendor=07fd, idProduct=0004, bcdDevice=59.23
> > usb 1-1: New USB device strings: Mfr=5, Product=75, SerialNumber=0
> > usb 1-1: Waiting for MOTU Microbook II to boot up...
> > ------------[ cut here ]------------
> > usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> > WARNING: CPU: 1 PID: 21 at drivers/usb/core/urb.c:477
> > usb_submit_urb+0x1188/0x13b0 /drivers/usb/core/urb.c:477
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.2.0-rc6+ #15
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >   __dump_stack /lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e /lib/dump_stack.c:113
> >   panic+0x292/0x6c9 /kernel/panic.c:219
> >   __warn.cold+0x20/0x4b /kernel/panic.c:576
> >   report_bug+0x262/0x2a0 /lib/bug.c:186
> >   fixup_bug /arch/x86/kernel/traps.c:179 [inline]
> >   fixup_bug /arch/x86/kernel/traps.c:174 [inline]
> >   do_error_trap+0x12b/0x1e0 /arch/x86/kernel/traps.c:272
> >   do_invalid_op+0x32/0x40 /arch/x86/kernel/traps.c:291
> >   invalid_op+0x14/0x20 /arch/x86/entry/entry_64.S:986
> > RIP: 0010:usb_submit_urb+0x1188/0x13b0 /drivers/usb/core/urb.c:477
> > Code: 4d 85 ed 74 2c e8 f8 d3 f4 fd 4c 89 f7 e8 a0 51 1c ff 41 89 d8 44 89
> > e1 4c 89 ea 48 89 c6 48 c7 c7 00 0e f7 85 e8 83 98 ca fd <0f> 0b e9 20 f4
> > ff ff e8 cc d3 f4 fd 4c 89 f2 48 b8 00 00 00 00 00
> > RSP: 0018:ffff8881d9efee68 EFLAGS: 00010286
> > RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3dfdbf
> > RBP: ffff8881cfd97b70 R08: ffff8881d9e36000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> > R13: ffff8881cfcdea98 R14: ffff8881d0f511a0 R15: ffff8881d4b46200
> >   usb_start_wait_urb+0x108/0x2b0 /drivers/usb/core/message.c:57
> >   usb_bulk_msg+0x228/0x550 /drivers/usb/core/message.c:253
> >   snd_usb_motu_microbookii_communicate.constprop.0+0xe3/0x240 /sound/usb/quirks.c:999
> >   snd_usb_motu_microbookii_boot_quirk /sound/usb/quirks.c:1039 [inline]
> >   snd_usb_apply_boot_quirk.cold+0x140/0x36b /sound/usb/quirks.c:1268
> >   usb_audio_probe+0x2ec/0x2010 /sound/usb/card.c:576
> >   usb_probe_interface+0x305/0x7a0 /drivers/usb/core/driver.c:361
> >   really_probe+0x281/0x660 /drivers/base/dd.c:509
> >   driver_probe_device+0x104/0x210 /drivers/base/dd.c:670
> >   __device_attach_driver+0x1c2/0x220 /drivers/base/dd.c:777
> >   bus_for_each_drv+0x15c/0x1e0 /drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 /drivers/base/dd.c:843
> >   bus_probe_device+0x1e4/0x290 /drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 /drivers/base/core.c:2111
> >   usb_set_configuration+0xdf6/0x1670 /drivers/usb/core/message.c:2023
> >   generic_probe+0x9d/0xd5 /drivers/usb/core/generic.c:210
> >   usb_probe_device+0x99/0x100 /drivers/usb/core/driver.c:266
> >   really_probe+0x281/0x660 /drivers/base/dd.c:509
> >   driver_probe_device+0x104/0x210 /drivers/base/dd.c:670
> >   __device_attach_driver+0x1c2/0x220 /drivers/base/dd.c:777
> >   bus_for_each_drv+0x15c/0x1e0 /drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 /drivers/base/dd.c:843
> >   bus_probe_device+0x1e4/0x290 /drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 /drivers/base/core.c:2111
> >   usb_new_device.cold+0x6a4/0xe61 /drivers/usb/core/hub.c:2536
> >   hub_port_connect /drivers/usb/core/hub.c:5098 [inline]
> >   hub_port_connect_change /drivers/usb/core/hub.c:5213 [inline]
> >   port_event /drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x1abd/0x3550 /drivers/usb/core/hub.c:5441
> >   process_one_work+0x905/0x1570 /kernel/workqueue.c:2269
> >   worker_thread+0x96/0xe20 /kernel/workqueue.c:2415
> >   kthread+0x30b/0x410 /kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
>
> Wow it finally comes up at the third time with sound/usb/quirks.c:999
> tippointing to commit 801ebf1043ae ("ALSA: usb-audio: Sanity checks
> for each pipe and EP types").
>
> That commit not only proves this warning is bogus but casts light
> on fixing it.
>
> 1, Make the helper created in the commit available outside sound/usb
> with a new name. No functionality change intended.
>
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1748,7 +1748,20 @@ static inline int usb_urb_dir_out(struct urb *urb)
>         return (urb->transfer_flags & URB_DIR_MASK) == URB_DIR_OUT;
>  }
>
> -int usb_urb_ep_type_check(const struct urb *urb);
> +int usb_pipe_ep_type_check(struct usb_device *dev, unsigned int pipe);
> +
> +/**
> + * usb_urb_ep_type_check - sanity check of endpoint in the given urb
> + * @urb: urb to be checked
> + *
> + * This performs a light-weight sanity check for the endpoint in the
> + * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
> + * a negative error code.
> + */
> +static inline int usb_urb_ep_type_check(const struct urb *urb)
> +{
> +       return usb_pipe_ep_type_check(urb->dev, urb->pipe);
> +}
>
>  void *usb_alloc_coherent(struct usb_device *dev, size_t size,
>         gfp_t mem_flags, dma_addr_t *dma);
> --- a/drivers/usb/core/urb.c
> +++ b/drivers/usb/core/urb.c
> @@ -191,25 +191,24 @@ static const int pipetypes[4] = {
>  };
>
>  /**
> - * usb_urb_ep_type_check - sanity check of endpoint in the given urb
> - * @urb: urb to be checked
> + * usb_pipe_ep_type_check - sanity type check of endpoint against the given pipe
> + * @dev: usb device whose endpoint to be checked
> + * @pipe: the pipe type to match
>   *
> - * This performs a light-weight sanity check for the endpoint in the
> - * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
> - * a negative error code.
> + * Return 0 if endpoint matches pipe, otherwise error code.
>   */
> -int usb_urb_ep_type_check(const struct urb *urb)
> +int usb_pipe_ep_type_check(struct usb_device *dev, unsigned int pipe)
>  {
>         const struct usb_host_endpoint *ep;
>
> -       ep = usb_pipe_endpoint(urb->dev, urb->pipe);
> +       ep = usb_pipe_endpoint(dev, pipe);
>         if (!ep)
>                 return -EINVAL;
> -       if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
> +       if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
>                 return -EINVAL;
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(usb_urb_ep_type_check);
> +EXPORT_SYMBOL_GPL(usb_pipe_ep_type_check);
>
>  /**
>   * usb_submit_urb - issue an asynchronous transfer request for an endpoint
> --
>
> 2, With helper in place, make the warning not bogus any more.
>
>
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -242,7 +242,12 @@ int usb_bulk_msg(struct usb_device *usb_dev, unsigned int pipe,
>
>         if ((ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
>                         USB_ENDPOINT_XFER_INT) {
> -               pipe = (pipe & ~(3 << 30)) | (PIPE_INTERRUPT << 30);
> +               /*
> +                * change pipe unless we mess things up
> +                */
> +               if (usb_pipe_ep_type_check(usb_dev, pipe))
> +                       pipe = (pipe & ~(3 << 30)) | (PIPE_INTERRUPT << 30);
> +
>                 usb_fill_int_urb(urb, usb_dev, pipe, data, len,
>                                 usb_api_blocking_completion, NULL,
>                                 ep->desc.bInterval);
> --
>
> 3, Do some cleanup in sound/usb.
>
>
> --- a/sound/usb/helper.h
> +++ b/sound/usb/helper.h
> @@ -7,7 +7,6 @@ unsigned int snd_usb_combine_bytes(unsigned char *bytes, int size);
>  void *snd_usb_find_desc(void *descstart, int desclen, void *after, u8 dtype);
>  void *snd_usb_find_csint_desc(void *descstart, int desclen, void *after, u8 dsubtype);
>
> -int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe);
>  int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe,
>                     __u8 request, __u8 requesttype, __u16 value, __u16 index,
>                     void *data, __u16 size);
> --- a/sound/usb/helper.c
> +++ b/sound/usb/helper.c
> @@ -63,20 +63,6 @@ void *snd_usb_find_csint_desc(void *buffer, int buflen, void *after, u8 dsubtype
>         return NULL;
>  }
>
> -/* check the validity of pipe and EP types */
> -int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe)
> -{
> -       static const int pipetypes[4] = {
> -               PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
> -       };
> -       struct usb_host_endpoint *ep;
> -
> -       ep = usb_pipe_endpoint(dev, pipe);
> -       if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
> -               return -EINVAL;
> -       return 0;
> -}
> -
>  /*
>   * Wrapper for usb_control_msg().
>   * Allocates a temp buffer to prevent dmaing from/to the stack.
> @@ -89,7 +75,7 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
>         void *buf = NULL;
>         int timeout;
>
> -       if (snd_usb_pipe_sanity_check(dev, pipe))
> +       if (usb_pipe_ep_type_check(dev, pipe))
>                 return -EINVAL;
>
>         if (size > 0) {
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -832,7 +832,7 @@ static int snd_usb_accessmusic_boot_quirk(struct usb_device *dev)
>         static const u8 seq[] = { 0x4e, 0x73, 0x52, 0x01 };
>         void *buf;
>
> -       if (snd_usb_pipe_sanity_check(dev, usb_sndintpipe(dev, 0x05)))
> +       if (usb_pipe_ep_type_check(dev, usb_sndintpipe(dev, 0x05)))
>                 return -EINVAL;
>         buf = kmemdup(seq, ARRAY_SIZE(seq), GFP_KERNEL);
>         if (!buf)
> @@ -861,7 +861,7 @@ static int snd_usb_nativeinstruments_boot_quirk(struct usb_device *dev)
>  {
>         int ret;
>
> -       if (snd_usb_pipe_sanity_check(dev, usb_sndctrlpipe(dev, 0)))
> +       if (usb_pipe_ep_type_check(dev, usb_sndctrlpipe(dev, 0)))
>                 return -EINVAL;
>         ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
>                                   0xaf, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> @@ -970,7 +970,7 @@ static int snd_usb_axefx3_boot_quirk(struct usb_device *dev)
>
>         dev_dbg(&dev->dev, "Waiting for Axe-Fx III to boot up...\n");
>
> -       if (snd_usb_pipe_sanity_check(dev, usb_sndctrlpipe(dev, 0)))
> +       if (usb_pipe_ep_type_check(dev, usb_sndctrlpipe(dev, 0)))
>                 return -EINVAL;
>         /* If the Axe-Fx III has not fully booted, it will timeout when trying
>          * to enable the audio streaming interface. A more generous timeout is
> @@ -1004,7 +1004,7 @@ static int snd_usb_motu_microbookii_communicate(struct usb_device *dev, u8 *buf,
>  {
>         int err, actual_length;
>
> -       if (snd_usb_pipe_sanity_check(dev, usb_sndintpipe(dev, 0x01)))
> +       if (usb_pipe_ep_type_check(dev, usb_sndintpipe(dev, 0x01)))
>                 return -EINVAL;
>         err = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x01), buf, *length,
>                                 &actual_length, 1000);
> @@ -1016,7 +1016,7 @@ static int snd_usb_motu_microbookii_communicate(struct usb_device *dev, u8 *buf,
>
>         memset(buf, 0, buf_size);
>
> -       if (snd_usb_pipe_sanity_check(dev, usb_rcvintpipe(dev, 0x82)))
> +       if (usb_pipe_ep_type_check(dev, usb_rcvintpipe(dev, 0x82)))
>                 return -EINVAL;
>         err = usb_interrupt_msg(dev, usb_rcvintpipe(dev, 0x82), buf, buf_size,
>                                 &actual_length, 1000);
> --

+Alan and Takashi to take a look at this.

(Takashi, with your helper check syzkaller now generates a new bug
report (not reported by syzbot yet due to breakage during kernel boot
on 5.3-rc1, so see below) and I guess this has to do with a missing ep
!= NULL check).

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 74 Comm: kworker/1:1 Not tainted 5.3.0-rc1+ #40
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:snd_usb_pipe_sanity_check+0x80/0x130 sound/usb/helper.c:75
Code: 48 c1 ea 03 80 3c 02 00 0f 85 b3 00 00 00 48 8b 6d 00 c1 eb 1e
48 b8 00 00 00 00 00 fc ff df 48 8d 7d 03 48 89 fa 48 c1 ea 03 <0f> b6
04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 7b 48 b8 00 00
RSP: 0018:ffff88806c33f0a8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff833819c2
RDX: 0000000000000000 RSI: ffffffff833819dc RDI: 0000000000000003
RBP: 0000000000000000 R08: ffff88806c330000 R09: fffffbfff0d1a792
R10: fffffbfff0d1a791 R11: ffffffff868d3c8f R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88806975cc80 R15: ffff88806975c4a0
FS:  0000000000000000(0000) GS:ffff88806d100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc3a48c000 CR3: 000000006861c003 CR4: 0000000000160ee0
Call Trace:
 snd_usb_accessmusic_boot_quirk sound/usb/quirks.c:835 [inline]
 snd_usb_apply_boot_quirk+0xa19/0xc60 sound/usb/quirks.c:1267
 usb_audio_probe+0x2ec/0x1f40 sound/usb/card.c:576
 usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
 really_probe+0x281/0x650 drivers/base/dd.c:548
 driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
 __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
 bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
 __device_attach+0x217/0x360 drivers/base/dd.c:882
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
 device_add+0xa85/0x1690 drivers/base/core.c:2111
 usb_set_configuration+0xde7/0x1650 drivers/usb/core/message.c:2023
 generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
 usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
 really_probe+0x281/0x650 drivers/base/dd.c:548
 driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
 __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
 bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
 __device_attach+0x217/0x360 drivers/base/dd.c:882
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
 device_add+0xa85/0x1690 drivers/base/core.c:2111
 usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
 hub_port_connect drivers/usb/core/hub.c:5098 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
 port_event drivers/usb/core/hub.c:5359 [inline]
 hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
 process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
 worker_thread+0x96/0xe20 kernel/workqueue.c:2415
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace d916533ad631874a ]---
RIP: 0010:snd_usb_pipe_sanity_check+0x80/0x130 sound/usb/helper.c:75
Code: 48 c1 ea 03 80 3c 02 00 0f 85 b3 00 00 00 48 8b 6d 00 c1 eb 1e
48 b8 00 00 00 00 00 fc ff df 48 8d 7d 03 48 89 fa 48 c1 ea 03 <0f> b6
04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 7b 48 b8 00 00
RSP: 0018:ffff88806c33f0a8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff833819c2
RDX: 0000000000000000 RSI: ffffffff833819dc RDI: 0000000000000003
RBP: 0000000000000000 R08: ffff88806c330000 R09: fffffbfff0d1a792
R10: fffffbfff0d1a791 R11: ffffffff868d3c8f R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88806975cc80 R15: ffff88806975c4a0
FS:  0000000000000000(0000) GS:ffff88806d100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc3a48c000 CR3: 000000006861c003 CR4: 0000000000160ee0


>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000ac8f77058e0d11e9%40google.com.
