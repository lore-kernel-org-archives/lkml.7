Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7FCC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8977221473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tB7+4Gem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfDHN3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:29:32 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33484 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDHN3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:29:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id k189so7942675qkc.0;
        Mon, 08 Apr 2019 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLGgCRgUvFUP4jDYbOGUZGTzRDc3wbIryVid0UzofyA=;
        b=tB7+4GemWLhy5TRJiWBlPERs9JzPxU8EhkEISQ35ndEZ7Hy9HmDS/k+XJ5fx+Fmbjv
         YB4oxRGj1HOuZVNuVjb4hc/nnDiyfSbnp9vbLMJAvHj05SJTdCWdUvXVdsdgMt4wxwBK
         YI9lmHkOOKNj/9NJYiH+lt92DoaDciSmOpND8M3jx29PcB46rmItSY2qMc9HSez7Cy8h
         SiXdYfES2VES4gTovJuRm0HbnPx2MNDndKXu6L/tMDLoq+dirVjtAaGOG3GGn8iKJmgl
         l+TMQHAbOWeAc+z6OopHFg4/I1ILQ3kngMzNEXDE2wJrcdludy10TnNSmhmYCQ9BOV59
         +kQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLGgCRgUvFUP4jDYbOGUZGTzRDc3wbIryVid0UzofyA=;
        b=UhSTgMYYYccWapyWwpbKxxY1CRNal4phqjVfC66WOJ63lG51yxc8O3GpQAHHR76TDT
         bebU5BJdOwyd5UcPaiI9hULM/rd3eO9qYNAMOHA16H7//Fwp9WDCsYHrERadFqlZ6HNk
         irM4exI1qBbI8KQwnPcZdHA7lixRX1wPpryFa7OKmEVb5iK37d2MQKta2XbLoASReQry
         meJ9e+bAXYGyhuBes2ZaNpFz2JQI5tGbI2ObLV7Gkizd/DDMmxfSSkBSoTexoSY+8006
         Bp+dTfsNIn+Q8fTnMGC4/bR4LcRQoRTb1KMnSjvQKUpi2+qc5L0bqhBFQNCPxjfPNhTO
         Eg5g==
X-Gm-Message-State: APjAAAUx72Apwwq8dJdA+ZaTjxJwXzvGU/FTqEIRag4SpDHT199Z5RDB
        x0GYrnvxwZhqYoYoS/O0IWSBm4FhEjG1zlAsF10=
X-Google-Smtp-Source: APXvYqxiHy0eU6L2H+5bfEeoHA6VbxyrWXIbjzylWZPJRYW3IW3z3kCP4GgO2IHfirR2/9uKZz4OJE9h1toXn9Lz+c0=
X-Received: by 2002:a05:620a:1503:: with SMTP id i3mr22808702qkk.59.1554730169787;
 Mon, 08 Apr 2019 06:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <1553183239-13253-1-git-send-email-fabien.dessenne@st.com>
 <1553183239-13253-3-git-send-email-fabien.dessenne@st.com>
 <CAH2Cfb8K5hB=UeMOeTEXud1XZVp12Qbw9NYoxJ0XQK4FFuF3wQ@mail.gmail.com>
 <4857555a-812d-0b96-9a70-2984ffb50ca9@st.com> <CAH2Cfb8NzsOZDt8zBypY9ZiD6oOFWUBkZoPpKfU97ZRF_O0z+A@mail.gmail.com>
 <770c71bc-f387-62b6-f799-07ba6446e7e8@st.com> <CAH2Cfb87Wacgsh=xz9h9kgwYgBkxNBDbcDJ4W3uPs2LiKbTD9A@mail.gmail.com>
 <760819dc-4c26-b492-a0ba-8b27c189d5b1@st.com> <CAH2Cfb-EvWeP28W=Hqzvwaue55hBFCMecqvt3p8mRh52BZMdNg@mail.gmail.com>
 <596f9e4d-2db1-8040-211b-173ad19d9d0e@st.com>
In-Reply-To: <596f9e4d-2db1-8040-211b-173ad19d9d0e@st.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Mon, 8 Apr 2019 21:29:17 +0800
Message-ID: <CAH2Cfb87+MR5SNmm2zQU+44mV+3gTv4M2moFxQDXhEGHO00W+A@mail.gmail.com>
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

On Mon, Apr 8, 2019 at 8:05 PM Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:
>
>
>
> On 4/6/19 9:56 AM, xiang xiao wrote:
> > On Sat, Apr 6, 2019 at 12:08 AM Arnaud Pouliquen
> > <arnaud.pouliquen@st.com> wrote:
> >>
> >>
> >>
> >> On 4/5/19 4:03 PM, xiang xiao wrote:
> >>> On Fri, Apr 5, 2019 at 8:33 PM Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 4/5/19 12:12 PM, xiang xiao wrote:
> >>>>> On Fri, Apr 5, 2019 at 12:14 AM Arnaud Pouliquen
> >>>>> <arnaud.pouliquen@st.com> wrote:
> >>>>>>
> >>>>>> Hello Xiang,
> >>>>>>
> >>>>>>
> >>>>>> On 4/3/19 2:47 PM, xiang xiao wrote:
> >>>>>>> On Thu, Mar 21, 2019 at 11:48 PM Fabien Dessenne <fabien.dessenne@st.com> wrote:
> >>>>>>>>
> >>>>>>>> This driver exposes a standard tty interface on top of the rpmsg
> >>>>>>>> framework through the "rpmsg-tty-channel" rpmsg service.
> >>>>>>>>
> >>>>>>>> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
> >>>>>>>> per rpmsg endpoint.
> >>>>>>>>
> >>>>>>>
> >>>>>>> How to support multi-instances from the same remoteproc instance? I
> >>>>>>> saw that the channel name is fixed to "rpmsg-tty-channel" which mean
> >>>>>>> only one channel can be created for each remote side.
> >>>>>> The driver is multi-instance based on muti-endpoints on top of the
> >>>>>> "rpmsg-tty-channel" service.
> >>>>>> On remote side you just have to call rpmsg_create_ept with destination
> >>>>>> address set to ANY. The result is a NS service announcement that trigs a
> >>>>>>  probe with a new endpoint.
> >>>>>> You can find code example for the remote side here:
> >>>>>> https://github.com/STMicroelectronics/STM32CubeMP1/blob/master/Projects/STM32MP157C-DK2/Applications/OpenAMP/OpenAMP_TTY_echo/Src/main.c
> >>>>>
> >>>>> Demo code create two uarts(huart0 and huart1), and both use the same
> >>>>> channel name( "rpmsg-tty-channel").
> >>>>> But rpmsg_create_channel in kernel will complain the duplication:
> >>>>> /* make sure a similar channel doesn't already exist */
> >>>>> tmp = rpmsg_find_device(dev, chinfo);
> >>>>> if (tmp) {
> >>>>>         /* decrement the matched device's refcount back */
> >>>>>         put_device(tmp);
> >>>>>         dev_err(dev, "channel %s:%x:%x already exist\n",
> >>>>>                    chinfo->name, chinfo->src, chinfo->dst);
> >>>>>         return NULL;
> >>>>> }
> >>>>> Do you have some local change not upstream yet?
> >>>> Nothing is missing. There is no complain as the function
> >>>> rpmsg_device_match returns 0, because the chinfo->dst (that corresponds
> >>>> to the remote ept address) is different.
> >>>>
> >>>
> >>> Yes, you are right.
> >>>
> >>>> If i well remember you have also a similar implementation of the service
> >>>> on your side. Do you see any incompatibility with your implementation?
> >>>>
> >>>
> >>> Our implementation is similar to yours, but has two major difference:
> >>> 1.Each instance has a different channel name but share the same prefix
> >>> "rpmsg-tty*", the benefit is that:
> >>>    a.Device name(/dev/tty*) is derived from rpmsg-tty*, instead the
> >>> random /dev/ttyRPMSGx
> >>>    b.Don't need tty_idr to allocate the unique device id
> >> I understand the need but in your implementation it look like you hack
> >> the rpmsg service to instantiate your tty... you introduce a kind of
> >> meta rpmsg tty service with sub-service related to the serial content.
> >> Not sure that this could be upstreamed...
> >
> > Not too much hack here, the only change in common is:
> > 1.Add match callback into rpmsg_driver
> > 2.Call match callback in rpmsg_dev_match
> > so rpmsg driver could join the bus match decision process(e.g. change
> > the exact match to the prefix match).
> > The similar mechanism exist in other subsystem for many years.
> The mechanism also exists in rpmsg but based on the service. it is
> similar to the compatible, based on the rpmsg_device_id structure that
> should list the cervices supported.

But match callback is much flexible than rpmsg_device_id table, the
table is fixed at compile time, match callback could do all matic at
the runtime.

> My concern here is that you would like to expose the service on top of
> the tty while aim of this driver is just to expose a tty over rpmsg. So
> in this case seems not a generic implementation but a platform dependent
> implementation.
>

I can't understand why the implementation is platform dependent, could
you explain more details?

> >
> >> proposal to integrate your need in the ST driver: it seems possible to
> >> have /dev/ttyRPMSGx with x corresponding to the remote endpoint address?
> >> So if you want to have a fixed tty name you can fix the remote endpoint.
> >> Is it something reasonable for you?
> >
> > But in our system, we have more than ten rpmsg services running at the
> > same time, it's difficult to manage them by the hardcode endpoint
> > address.
> Seems not so difficult. Today you identify your service by a name. Seems
> just a matter of changing it by an address, it just an identifier by an
> address instead of a string.

But I still prefer to use string(channel name) not number(port) to
manage the multiple rpmsg instance:
1.Just like nobody prefer use ip address not domain name.
2.rpmsg protocol support name and port mapping natively, why not use it?

>
> >
> >>
> >>
> >>> 2.Each transfer need get response from peer to avoid the buffer
> >>> overflow. This is very important if the peer use pull
> >>> model(read/write) instead of push model(callback).
> >> I not sure to understand your point... You mean that you assume that the
> >> driver should be blocked until a response from the remote side?
> >
> > For example, in your RTOS demo code:
> > 1.VIRT_UART0_RxCpltCallback save the received data in a global buffer
> > VirtUart0ChannelBuffRx
> > 2.Main loop poll VirtUart0RxMsg flag and echo the data back to kernel
> > if this flag is set
> > Between step1 and step 2, kernel may send additional data and then
> > overwrite the data not get processed by main loop.
> > It's very easy to reproduce by:
> >   cat /dev/ttyRPMSGx > /tmp/dump &
> >   cat /a/huge/file > /dev/ttyRPMSGx
> >   diff /a/hug/file /tmp/dump
> Yes our example is very limited, aim is not to be robust for this use
> case but just giving a simple sample to allow user to send a simple text
> in console and echo it.
> > The push model mean the receiver could process the data completely in
> > callback context, and
> > the pull model mean the receiver just save the data in buffer and
> > process it late(e.g. by read call).
> Thanks for the clarification.
> >> This seems not compatible with a "generic" tty and with Johan remarks:
> >> "Just a drive-by comment; it looks like rpmsg_send() may block, but
> >> the tty-driver write() callback must never sleep."
> >>
> >
> > The handshake doesn't mean the write callback must block, we can
> > provide write_room callback to tell tty core to stop sending.
> In the write function you have implemented the wait_for_completion that
> blocks, waiting answer from the remote side. For instance in case of
> remote firmware crash, you should be blocked.

This just make the code simple, and can be fixed by the classic slide
window algo easily.

>
> >
> >> Why no just let rpmsg should manage the case with no Tx buffer free,
> >> with a rpmsg_trysend...
> >
> > We can't do this since the buffer(e.g. VirtUart0ChannelBuffRx) is
> > managed by the individual driver:
> > The rpmsg buffer free, doesn't mean the driver buffer also free.
> Yes but this should be solved by your implementation in the remote
> firmware and/or in the linux client code, not by blocking the write,
> waiting an answer from remote.
> If you want a mechanism it should be manage in your application or in a
> client driver.
>

The communication between all standard virtual channel is
reliable(e.g. pipe, fifo and unix socket), why is rpmsg virtual uart
unreliable?

> I think the main difference here is that the rpmsg_tty driver we propose
> is only a wrapper that should have same behavior as a standard UART
> link. This is our main requirement to allow to have same communication
> with a firmware running on a co-processor or a external processor (with
> an UART link).
> In your driver, you introduce some extra mechanisms that probably
> simplify your implementation, but that seems not compatible with a basic
> link:
>  - write ack
>  - wakeup
> ...

But the standard UART also support the flow control through RTC/CTS
pin. I think that rpmsg uart should enable the flow control by
default, otherwise it's difficult to make it work reliable in AMP
environment, because CPU/MCU/DSP speed is very different.

>
>
> >
> >>
> >>>
> >>> Here is the patch for kernel side:
> >>> https://github.com/xiaoxiang781216/linux/commit/f04d2386eb11e0781f0eb47d99fae838abf7eb53
> >>> https://github.com/xiaoxiang781216/linux/commit/1a41be362d916eb9104bf21065cb38a0a63d2e91
> >>>
> >>> And RTOS side:
> >>> https://github.com/PineconeCode/nuttx/blob/song-u1/include/nuttx/serial/uart_rpmsg.h
> >>> https://github.com/PineconeCode/nuttx/blob/song-u1/drivers/serial/uart_rpmsg.c
> >>>
> >>> Maybe, we can consider how to unify these two implementation into one.
> >> Yes sure.
> >>
> >>>
