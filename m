Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CDBC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A8720989
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OorWjiDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDFH5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 03:57:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42163 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfDFH5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 03:57:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id b74so5217059qkg.9;
        Sat, 06 Apr 2019 00:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywTJBU52gsQooH11i6+QDSqGA1ijQZVBn5uFBOOcsnk=;
        b=OorWjiDBHd3LT2WgEfjTui/WZUWdfoAUCWqOeK5b3eEQiLe98dN+4PuKi6HNmjrfYk
         5LQSJqUC0axynaNBPNl2mBvJctn22ZpmEsRYhdnkONLUIriHquT1tjDxOsOGSlsks8vC
         BR0OVhwnbVRwJqBiRC9p2ffkKLkHkBTFruTySfI/cl9ZC5GlRi2u5amC3NS2J4odXxAP
         JwUumsxBi1ewamZjY9b/70RNgDeD03/rwwMUoeDetuq0M158I8LoNXgQreGGonInIpky
         KX6CwD+CoP1oy9rbVF9/3XrlroXlP3buvriSAi4Mi3eudit+bXHLM2J9KKXwZs3i9kgc
         Gq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywTJBU52gsQooH11i6+QDSqGA1ijQZVBn5uFBOOcsnk=;
        b=bOkYnyrwb4sfgdTyLyRpGNCA3Iw2RROiqsSp0iXJaBxsPbCHweUJEcn7HJUMReaXMl
         1GPfEZVUPqcyVABFXi4pz84Kg+lTUMH8EhARXxlxi36kN/MHfplHHHEPgP9AD+3qvvM5
         IJkrb+TnMzySrvLNsjn46OWL7vFbAOoCIuBmqm26uxSsZwxXFXSathifaskCsUwsVEcL
         Z4ybIDS0jsExca2vNIPJmRgarLrU1yy+rFUqv0XUBN+iSjBo2lR8/T/gexWib7Pbib/k
         +p8QbCQyyO+w0m0SrDuaeaZfZrcpDuPwzHNfHspRFGR5Wu9Uuc6URTrqYcnjIay6bLxv
         quPw==
X-Gm-Message-State: APjAAAXF/4MqRFlHNHlUSnvTLoYLfzBV94gUJkbQMGGBgtGMDisHLjgn
        umar+Yh36MLoawt+/ozujh+bahVSv5Qw4t8GEf4=
X-Google-Smtp-Source: APXvYqxeU5OmVzXLWpIhMDTl4lW5D0ypirtuInrzTotDRiuc6qMI0K0yfWIXkv8Mylqu0p3/Tt/9frDwzjC9qu8qgBk=
X-Received: by 2002:a37:6186:: with SMTP id v128mr14650797qkb.320.1554537426912;
 Sat, 06 Apr 2019 00:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <1553183239-13253-1-git-send-email-fabien.dessenne@st.com>
 <1553183239-13253-3-git-send-email-fabien.dessenne@st.com>
 <CAH2Cfb8K5hB=UeMOeTEXud1XZVp12Qbw9NYoxJ0XQK4FFuF3wQ@mail.gmail.com>
 <4857555a-812d-0b96-9a70-2984ffb50ca9@st.com> <CAH2Cfb8NzsOZDt8zBypY9ZiD6oOFWUBkZoPpKfU97ZRF_O0z+A@mail.gmail.com>
 <770c71bc-f387-62b6-f799-07ba6446e7e8@st.com> <CAH2Cfb87Wacgsh=xz9h9kgwYgBkxNBDbcDJ4W3uPs2LiKbTD9A@mail.gmail.com>
 <760819dc-4c26-b492-a0ba-8b27c189d5b1@st.com>
In-Reply-To: <760819dc-4c26-b492-a0ba-8b27c189d5b1@st.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Sat, 6 Apr 2019 15:56:52 +0800
Message-ID: <CAH2Cfb-EvWeP28W=Hqzvwaue55hBFCMecqvt3p8mRh52BZMdNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: add rpmsg driver
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 6, 2019 at 12:08 AM Arnaud Pouliquen
<arnaud.pouliquen@st.com> wrote:
>
>
>
> On 4/5/19 4:03 PM, xiang xiao wrote:
> > On Fri, Apr 5, 2019 at 8:33 PM Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:
> >>
> >>
> >>
> >> On 4/5/19 12:12 PM, xiang xiao wrote:
> >>> On Fri, Apr 5, 2019 at 12:14 AM Arnaud Pouliquen
> >>> <arnaud.pouliquen@st.com> wrote:
> >>>>
> >>>> Hello Xiang,
> >>>>
> >>>>
> >>>> On 4/3/19 2:47 PM, xiang xiao wrote:
> >>>>> On Thu, Mar 21, 2019 at 11:48 PM Fabien Dessenne <fabien.dessenne@st.com> wrote:
> >>>>>>
> >>>>>> This driver exposes a standard tty interface on top of the rpmsg
> >>>>>> framework through the "rpmsg-tty-channel" rpmsg service.
> >>>>>>
> >>>>>> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
> >>>>>> per rpmsg endpoint.
> >>>>>>
> >>>>>
> >>>>> How to support multi-instances from the same remoteproc instance? I
> >>>>> saw that the channel name is fixed to "rpmsg-tty-channel" which mean
> >>>>> only one channel can be created for each remote side.
> >>>> The driver is multi-instance based on muti-endpoints on top of the
> >>>> "rpmsg-tty-channel" service.
> >>>> On remote side you just have to call rpmsg_create_ept with destination
> >>>> address set to ANY. The result is a NS service announcement that trigs a
> >>>>  probe with a new endpoint.
> >>>> You can find code example for the remote side here:
> >>>> https://github.com/STMicroelectronics/STM32CubeMP1/blob/master/Projects/STM32MP157C-DK2/Applications/OpenAMP/OpenAMP_TTY_echo/Src/main.c
> >>>
> >>> Demo code create two uarts(huart0 and huart1), and both use the same
> >>> channel name( "rpmsg-tty-channel").
> >>> But rpmsg_create_channel in kernel will complain the duplication:
> >>> /* make sure a similar channel doesn't already exist */
> >>> tmp = rpmsg_find_device(dev, chinfo);
> >>> if (tmp) {
> >>>         /* decrement the matched device's refcount back */
> >>>         put_device(tmp);
> >>>         dev_err(dev, "channel %s:%x:%x already exist\n",
> >>>                    chinfo->name, chinfo->src, chinfo->dst);
> >>>         return NULL;
> >>> }
> >>> Do you have some local change not upstream yet?
> >> Nothing is missing. There is no complain as the function
> >> rpmsg_device_match returns 0, because the chinfo->dst (that corresponds
> >> to the remote ept address) is different.
> >>
> >
> > Yes, you are right.
> >
> >> If i well remember you have also a similar implementation of the service
> >> on your side. Do you see any incompatibility with your implementation?
> >>
> >
> > Our implementation is similar to yours, but has two major difference:
> > 1.Each instance has a different channel name but share the same prefix
> > "rpmsg-tty*", the benefit is that:
> >    a.Device name(/dev/tty*) is derived from rpmsg-tty*, instead the
> > random /dev/ttyRPMSGx
> >    b.Don't need tty_idr to allocate the unique device id
> I understand the need but in your implementation it look like you hack
> the rpmsg service to instantiate your tty... you introduce a kind of
> meta rpmsg tty service with sub-service related to the serial content.
> Not sure that this could be upstreamed...

Not too much hack here, the only change in common is:
1.Add match callback into rpmsg_driver
2.Call match callback in rpmsg_dev_match
so rpmsg driver could join the bus match decision process(e.g. change
the exact match to the prefix match).
The similar mechanism exist in other subsystem for many years.

> proposal to integrate your need in the ST driver: it seems possible to
> have /dev/ttyRPMSGx with x corresponding to the remote endpoint address?
> So if you want to have a fixed tty name you can fix the remote endpoint.
> Is it something reasonable for you?

But in our system, we have more than ten rpmsg services running at the
same time, it's difficult to manage them by the hardcode endpoint
address.

>
>
> > 2.Each transfer need get response from peer to avoid the buffer
> > overflow. This is very important if the peer use pull
> > model(read/write) instead of push model(callback).
> I not sure to understand your point... You mean that you assume that the
> driver should be blocked until a response from the remote side?

For example, in your RTOS demo code:
1.VIRT_UART0_RxCpltCallback save the received data in a global buffer
VirtUart0ChannelBuffRx
2.Main loop poll VirtUart0RxMsg flag and echo the data back to kernel
if this flag is set
Between step1 and step 2, kernel may send additional data and then
overwrite the data not get processed by main loop.
It's very easy to reproduce by:
  cat /dev/ttyRPMSGx > /tmp/dump &
  cat /a/huge/file > /dev/ttyRPMSGx
  diff /a/hug/file /tmp/dump
The push model mean the receiver could process the data completely in
callback context, and
the pull model mean the receiver just save the data in buffer and
process it late(e.g. by read call).

> This seems not compatible with a "generic" tty and with Johan remarks:
> "Just a drive-by comment; it looks like rpmsg_send() may block, but
> the tty-driver write() callback must never sleep."
>

The handshake doesn't mean the write callback must block, we can
provide write_room callback to tell tty core to stop sending.

> Why no just let rpmsg should manage the case with no Tx buffer free,
> with a rpmsg_trysend...

We can't do this since the buffer(e.g. VirtUart0ChannelBuffRx) is
managed by the individual driver:
The rpmsg buffer free, doesn't mean the driver buffer also free.

>
> >
> > Here is the patch for kernel side:
> > https://github.com/xiaoxiang781216/linux/commit/f04d2386eb11e0781f0eb47d99fae838abf7eb53
> > https://github.com/xiaoxiang781216/linux/commit/1a41be362d916eb9104bf21065cb38a0a63d2e91
> >
> > And RTOS side:
> > https://github.com/PineconeCode/nuttx/blob/song-u1/include/nuttx/serial/uart_rpmsg.h
> > https://github.com/PineconeCode/nuttx/blob/song-u1/drivers/serial/uart_rpmsg.c
> >
> > Maybe, we can consider how to unify these two implementation into one.
> Yes sure.
>
> >
> >>>
> >>>> using some wrapper functions available here:
> >>>> https://github.com/STMicroelectronics/STM32CubeMP1/tree/master/Middlewares/Third_Party/OpenAMP
> >>>>
> >>>>
> >>>> Best Regards
> >>>> Arnaud
> >>>>
> >>>>>
> >>>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >>>>>> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> >>>>>> ---
> >>>>>>  drivers/tty/Kconfig     |   9 ++
> >>>>>>  drivers/tty/Makefile    |   1 +
> >>>>>>  drivers/tty/rpmsg_tty.c | 309 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>>>  3 files changed, 319 insertions(+)
> >>>>>>  create mode 100644 drivers/tty/rpmsg_tty.c
> >>>>>>
> >>>>>> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> >>>>>> index 0840d27..42696e6 100644
> >>>>>> --- a/drivers/tty/Kconfig
> >>>>>> +++ b/drivers/tty/Kconfig
> >>>>>> @@ -441,4 +441,13 @@ config VCC
> >>>>>>         depends on SUN_LDOMS
> >>>>>>         help
> >>>>>>           Support for Sun logical domain consoles.
> >>>>>> +
> >>>>>> +config RPMSG_TTY
> >>>>>> +       tristate "RPMSG tty driver"
> >>>>>> +       depends on RPMSG
> >>>>>> +       help
> >>>>>> +         Say y here to export rpmsg endpoints as tty devices, usually found
> >>>>>> +         in /dev/ttyRPMSGx.
> >>>>>> +         This makes it possible for user-space programs to send and receive
> >>>>>> +         rpmsg messages as a standard tty protocol.
> >>>>>>  endif # TTY
> >>>>>> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> >>>>>> index c72cafd..90a98a2 100644
> >>>>>> --- a/drivers/tty/Makefile
> >>>>>> +++ b/drivers/tty/Makefile
> >>>>>> @@ -33,5 +33,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
> >>>>>>  obj-$(CONFIG_GOLDFISH_TTY)     += goldfish.o
> >>>>>>  obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
> >>>>>>  obj-$(CONFIG_VCC)              += vcc.o
> >>>>>> +obj-$(CONFIG_RPMSG_TTY)                += rpmsg_tty.o
> >>>>>>
> >>>>>>  obj-y += ipwireless/
> >>>>>> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
> >>>>>> new file mode 100644
> >>>>>> index 0000000..9c2a629
> >>>>>> --- /dev/null
> >>>>>> +++ b/drivers/tty/rpmsg_tty.c
> >>>>>> @@ -0,0 +1,309 @@
> >>>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>>> +/*
> >>>>>> + * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
> >>>>>> + * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com> for STMicroelectronics.
> >>>>>> + *          Fabien Dessenne <fabien.dessenne@st.com> for STMicroelectronics.
> >>>>>> + * Derived from the imx-rpmsg and omap-rpmsg implementations.
> >>>>>> + */
> >>>>>> +
> >>>>>> +#include <linux/module.h>
> >>>>>> +#include <linux/rpmsg.h>
> >>>>>> +#include <linux/slab.h>
> >>>>>> +#include <linux/tty.h>
> >>>>>> +#include <linux/tty_flip.h>
> >>>>>> +
> >>>>>> +#define MAX_TTY_RPMSG          32
> >>>>>> +
> >>>>>> +static DEFINE_IDR(tty_idr);            /* tty instance id */
> >>>>>> +static DEFINE_MUTEX(idr_lock);         /* protects tty_idr */
> >>>>>> +
> >>>>>> +static struct tty_driver *rpmsg_tty_driver;
> >>>>>> +
> >>>>>> +struct rpmsg_tty_port {
> >>>>>> +       struct tty_port         port;   /* TTY port data */
> >>>>>> +       unsigned int            id;     /* TTY rpmsg index */
> >>>>>> +       spinlock_t              rx_lock; /* message reception lock */
> >>>>>> +       struct rpmsg_device     *rpdev; /* rpmsg device */
> >>>>>> +};
> >>>>>> +
> >>>>>> +static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int len,
> >>>>>> +                       void *priv, u32 src)
> >>>>>> +{
> >>>>>> +       int space;
> >>>>>> +       unsigned char *cbuf;
> >>>>>> +       struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
> >>>>>> +
> >>>>>> +       dev_dbg(&rpdev->dev, "msg(<- src 0x%x) len %d\n", src, len);
> >>>>>> +
> >>>>>> +       print_hex_dump_debug(__func__, DUMP_PREFIX_NONE, 16, 1, data, len,
> >>>>>> +                            true);
> >>>>>> +
> >>>>>> +       /* Flush the recv-ed none-zero data to tty node */
> >>>>>> +       if (!len)
> >>>>>> +               return -EINVAL;
> >>>>>> +
> >>>>>> +       spin_lock(&cport->rx_lock);
> >>>>>> +       space = tty_prepare_flip_string(&cport->port, &cbuf, len);
> >>>>>> +       if (space <= 0) {
> >>>>>> +               dev_err(&rpdev->dev, "No memory for tty_prepare_flip_string\n");
> >>>>>> +               spin_unlock(&cport->rx_lock);
> >>>>>> +               return -ENOMEM;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       if (space != len)
> >>>>>> +               dev_warn(&rpdev->dev, "Trunc buffer from %d to %d\n",
> >>>>>> +                        len, space);
> >>>>>> +
> >>>>>> +       memcpy(cbuf, data, space);
> >>>>>> +       tty_flip_buffer_push(&cport->port);
> >>>>>> +       spin_unlock(&cport->rx_lock);
> >>>>>> +
> >>>>>> +       return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int rpmsg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
> >>>>>> +{
> >>>>>> +       struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
> >>>>>> +
> >>>>>> +       if (!cport) {
> >>>>>> +               dev_err(tty->dev, "cannot get cport\n");
> >>>>>> +               return -ENODEV;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       return tty_port_install(&cport->port, driver, tty);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int rpmsg_tty_open(struct tty_struct *tty, struct file *filp)
> >>>>>> +{
> >>>>>> +       return tty_port_open(tty->port, tty, filp);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void rpmsg_tty_close(struct tty_struct *tty, struct file *filp)
> >>>>>> +{
> >>>>>> +       return tty_port_close(tty->port, tty, filp);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int rpmsg_tty_write(struct tty_struct *tty, const unsigned char *buf,
> >>>>>> +                          int total)
> >>>>>> +{
> >>>>>> +       int count, ret = 0;
> >>>>>> +       const unsigned char *tbuf;
> >>>>>> +       struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
> >>>>>> +       struct rpmsg_device *rpdev;
> >>>>>> +       int msg_size;
> >>>>>> +
> >>>>>> +       if (!cport) {
> >>>>>> +               dev_err(tty->dev, "cannot get cport\n");
> >>>>>> +               return -ENODEV;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       rpdev = cport->rpdev;
> >>>>>> +
> >>>>>> +       dev_dbg(&rpdev->dev, "%s: send message from tty->index = %d\n",
> >>>>>> +               __func__, tty->index);
> >>>>>> +
> >>>>>> +       if (!buf) {
> >>>>>> +               dev_err(&rpdev->dev, "buf shouldn't be null.\n");
> >>>>>> +               return -ENOMEM;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       msg_size = rpmsg_get_buf_payload_size(rpdev->ept);
> >>>>>> +       if (msg_size < 0)
> >>>>>> +               return msg_size;
> >>>>>> +
> >>>>>> +       count = total;
> >>>>>> +       tbuf = buf;
> >>>>>> +       do {
> >>>>>> +               /* send a message to our remote processor */
> >>>>>> +               ret = rpmsg_send(rpdev->ept, (void *)tbuf,
> >>>>>> +                                min(count, msg_size));
> >>>>>> +               if (ret) {
> >>>>>> +                       dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
> >>>>>> +                       return ret;
> >>>>>> +               }
> >>>>>> +
> >>>>>> +               if (count > msg_size) {
> >>>>>> +                       count -= msg_size;
> >>>>>> +                       tbuf += msg_size;
> >>>>>> +               } else {
> >>>>>> +                       count = 0;
> >>>>>> +               }
> >>>>>> +       } while (count > 0);
> >>>>>> +
> >>>>>
> >>>>> We need the flow control(or handshake) here, otherwise it's very easy
> >>>>> to lose the data if kernel keep send the data as fast as possible.
> >>>>>
> >>>>>> +       return total;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int rpmsg_tty_write_room(struct tty_struct *tty)
> >>>>>> +{
> >>>>>> +       struct rpmsg_tty_port *cport = idr_find(&tty_idr, tty->index);
> >>>>>> +
> >>>>>> +       if (!cport) {
> >>>>>> +               dev_err(tty->dev, "cannot get cport\n");
> >>>>>> +               return -ENODEV;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       /* report the space in the rpmsg buffer */
> >>>>>> +       return rpmsg_get_buf_payload_size(cport->rpdev->ept);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static const struct tty_operations rpmsg_tty_ops = {
> >>>>>> +       .install        = rpmsg_tty_install,
> >>>>>> +       .open           = rpmsg_tty_open,
> >>>>>> +       .close          = rpmsg_tty_close,
> >>>>>> +       .write          = rpmsg_tty_write,
> >>>>>> +       .write_room     = rpmsg_tty_write_room,
> >>>>>> +};
> >>>>>> +
> >>>>>> +struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
> >>>>>> +{
> >>>>>> +       struct rpmsg_tty_port *cport;
> >>>>>> +
> >>>>>> +       cport = kzalloc(sizeof(*cport), GFP_KERNEL);
> >>>>>> +       if (!cport)
> >>>>>> +               return ERR_PTR(-ENOMEM);
> >>>>>> +
> >>>>>> +       mutex_lock(&idr_lock);
> >>>>>> +       cport->id = idr_alloc(&tty_idr, cport, 0, MAX_TTY_RPMSG, GFP_KERNEL);
> >>>>>> +       mutex_unlock(&idr_lock);
> >>>>>> +
> >>>>>> +       if (cport->id < 0) {
> >>>>>> +               kfree(cport);
> >>>>>> +               return ERR_PTR(-ENOSPC);
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       return cport;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void rpmsg_tty_release_cport(struct rpmsg_tty_port *cport)
> >>>>>> +{
> >>>>>> +       mutex_lock(&idr_lock);
> >>>>>> +       idr_remove(&tty_idr, cport->id);
> >>>>>> +       mutex_unlock(&idr_lock);
> >>>>>> +
> >>>>>> +       kfree(cport);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
> >>>>>> +{
> >>>>>> +       struct rpmsg_tty_port *cport;
> >>>>>> +       struct device *tty_dev;
> >>>>>> +       int ret;
> >>>>>> +
> >>>>>> +       cport = rpmsg_tty_alloc_cport();
> >>>>>> +       if (IS_ERR(cport)) {
> >>>>>> +               dev_err(&rpdev->dev, "failed to alloc tty port\n");
> >>>>>> +               return PTR_ERR(cport);
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       tty_port_init(&cport->port);
> >>>>>> +       cport->port.low_latency = cport->port.flags | ASYNC_LOW_LATENCY;
> >>>>>> +
> >>>>>> +       tty_dev = tty_port_register_device(&cport->port, rpmsg_tty_driver,
> >>>>>> +                                          cport->id, &rpdev->dev);
> >>>>>> +       if (IS_ERR(tty_dev)) {
> >>>>>> +               dev_err(&rpdev->dev, "failed to register tty port\n");
> >>>>>> +               ret = PTR_ERR(tty_dev);
> >>>>>> +               goto err_destroy;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       spin_lock_init(&cport->rx_lock);
> >>>>>> +       cport->rpdev = rpdev;
> >>>>>> +
> >>>>>> +       dev_set_drvdata(&rpdev->dev, cport);
> >>>>>> +
> >>>>>> +       dev_info(&rpdev->dev, "new channel: 0x%x -> 0x%x : ttyRPMSG%d\n",
> >>>>>> +                rpdev->src, rpdev->dst, cport->id);
> >>>>>> +
> >>>>>> +       return 0;
> >>>>>> +
> >>>>>> +err_destroy:
> >>>>>> +       tty_port_destroy(&cport->port);
> >>>>>> +       rpmsg_tty_release_cport(cport);
> >>>>>> +       return ret;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void rpmsg_tty_remove(struct rpmsg_device *rpdev)
> >>>>>> +{
> >>>>>> +       struct rpmsg_tty_port *cport = dev_get_drvdata(&rpdev->dev);
> >>>>>> +
> >>>>>> +       dev_info(&rpdev->dev, "removing rpmsg tty device %d\n", cport->id);
> >>>>>> +
> >>>>>> +       /* User hang up to release the tty */
> >>>>>> +       if (tty_port_initialized(&cport->port))
> >>>>>> +               tty_port_tty_hangup(&cport->port, false);
> >>>>>> +
> >>>>>> +       tty_unregister_device(rpmsg_tty_driver, cport->id);
> >>>>>> +       tty_port_destroy(&cport->port);
> >>>>>> +
> >>>>>> +       rpmsg_tty_release_cport(cport);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static struct rpmsg_device_id rpmsg_driver_tty_id_table[] = {
> >>>>>> +       { .name = "rpmsg-tty-channel" },
> >>>>>> +       { },
> >>>>>> +};
> >>>>>> +MODULE_DEVICE_TABLE(rpmsg, rpmsg_driver_tty_id_table);
> >>>>>> +
> >>>>>> +static struct rpmsg_driver rpmsg_tty_rpmsg_drv = {
> >>>>>> +       .drv.name       = KBUILD_MODNAME,
> >>>>>> +       .id_table       = rpmsg_driver_tty_id_table,
> >>>>>> +       .probe          = rpmsg_tty_probe,
> >>>>>> +       .callback       = rpmsg_tty_cb,
> >>>>>> +       .remove         = rpmsg_tty_remove,
> >>>>>> +};
> >>>>>> +
> >>>>>> +static int __init rpmsg_tty_init(void)
> >>>>>> +{
> >>>>>> +       int err;
> >>>>>> +
> >>>>>> +       rpmsg_tty_driver = tty_alloc_driver(MAX_TTY_RPMSG, TTY_DRIVER_REAL_RAW |
> >>>>>> +                                           TTY_DRIVER_DYNAMIC_DEV);
> >>>>>> +       if (IS_ERR(rpmsg_tty_driver))
> >>>>>> +               return PTR_ERR(rpmsg_tty_driver);
> >>>>>> +
> >>>>>> +       rpmsg_tty_driver->driver_name = "rpmsg_tty";
> >>>>>> +       rpmsg_tty_driver->name = "ttyRPMSG";
> >>>>>> +       rpmsg_tty_driver->major = 0;
> >>>>>> +       rpmsg_tty_driver->type = TTY_DRIVER_TYPE_CONSOLE;
> >>>>>> +       rpmsg_tty_driver->init_termios = tty_std_termios;
> >>>>>> +
> >>>>>> +       tty_set_operations(rpmsg_tty_driver, &rpmsg_tty_ops);
> >>>>>> +
> >>>>>> +       err = tty_register_driver(rpmsg_tty_driver);
> >>>>>> +       if (err < 0) {
> >>>>>> +               pr_err("Couldn't install rpmsg tty driver: err %d\n", err);
> >>>>>> +               goto error_put;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       err = register_rpmsg_driver(&rpmsg_tty_rpmsg_drv);
> >>>>>> +       if (err < 0) {
> >>>>>> +               pr_err("Couldn't register rpmsg tty driver: err %d\n", err);
> >>>>>> +               goto error_unregister;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       return 0;
> >>>>>> +
> >>>>>> +error_unregister:
> >>>>>> +       tty_unregister_driver(rpmsg_tty_driver);
> >>>>>> +
> >>>>>> +error_put:
> >>>>>> +       put_tty_driver(rpmsg_tty_driver);
> >>>>>> +
> >>>>>> +       return err;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void __exit rpmsg_tty_exit(void)
> >>>>>> +{
> >>>>>> +       unregister_rpmsg_driver(&rpmsg_tty_rpmsg_drv);
> >>>>>> +       tty_unregister_driver(rpmsg_tty_driver);
> >>>>>> +       put_tty_driver(rpmsg_tty_driver);
> >>>>>> +       idr_destroy(&tty_idr);
> >>>>>> +}
> >>>>>> +
> >>>>>> +module_init(rpmsg_tty_init);
> >>>>>> +module_exit(rpmsg_tty_exit);
> >>>>>> +
> >>>>>> +MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
> >>>>>> +MODULE_AUTHOR("Fabien Dessenne <fabien.dessenne@st.com>");
> >>>>>> +MODULE_DESCRIPTION("virtio remote processor messaging tty driver");
> >>>>>> +MODULE_LICENSE("GPL v2");
> >>>>>> --
> >>>>>> 2.7.4
> >>>>>>
