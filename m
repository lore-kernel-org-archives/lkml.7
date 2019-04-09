Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71811C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2470920857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtfWenXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfDIKOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:14:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34153 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIKOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:14:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so19048461qtm.1;
        Tue, 09 Apr 2019 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDyd+7XMwA9YBAUtLSLvB3sTeb1rT9gKLsvfMEWnOpg=;
        b=XtfWenXRvf6e+WzNyKtXO2aKTHchAVcXQxK5rLJVk1bhlDSr+maCFygHcUVx4gnIr0
         LF3AvN5tcvePqXxms8+ola4ZfwxtgYs1TRvDpHybU5jFpDbgjXqJ2Yl941wvhUrAlyIN
         7jBaixNm2iNBsoVknAV2IW13VYK6YEeAzRwB6/hxpm+5FjJTSWlZGt08XFwVkRdo2QM8
         TRwRADjebqv8ty/V7IYQ2VapFiAvafRqKvdiYhcMlRFp6CkBJxs8fd7qeajOOR19RcDA
         TwOOAJXERqr4MyMREADcHSfvcnjz5KVjA4fo65jJkc3dOHcIBI0GHfk40P76nXfMeHyo
         yAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDyd+7XMwA9YBAUtLSLvB3sTeb1rT9gKLsvfMEWnOpg=;
        b=YFrFusQuwVSXzGjnSCS9pq+Srm1+Qr5Gs8/Yrv/mtQXTRmhMCZVPsUpxYsxHG8wOvr
         ABNKCqLQROa/o7RnW2JU7fBjFGuDrViMCfGAiBMF1yrOCWdXhhsMZM3dMpSvGYGZ5Fs3
         csErDFWafs3yaHWdolMS8ARAZl/QPHfX7xN8GEVtF2MdVCNMbp3eReptDVcxu3/85g3t
         hP4kQWF91M3ptv/+XSClrTQzfMzzV+Xk+qJNjESV6BMk2+15o78wGA+mVECT3KPUnut0
         8hNWMYnCL4yroy9Rba3p31ZfhHZqEMpGYgPHaP7CrFyA8VqPaDPBjCpL2baJiqHjs1sm
         unig==
X-Gm-Message-State: APjAAAU4fU0hXnX1LJcsmQ//m6Ym4j6M3oR0cToJFpTlfuDs5c9J2kCI
        CMD6y7t/MR+Um34kj6pU9cuGIX4bAUb7rO1H+II=
X-Google-Smtp-Source: APXvYqyWZpo+q+77ZUWf6iwZ/Lt03QURvVcF49P3csifLuDqR48aBYuP50wiAT6P30SZsbGscZMVGDUfvYt/LwS428Q=
X-Received: by 2002:a0c:9599:: with SMTP id s25mr28130958qvs.119.1554804886708;
 Tue, 09 Apr 2019 03:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <1553183239-13253-1-git-send-email-fabien.dessenne@st.com>
 <1553183239-13253-3-git-send-email-fabien.dessenne@st.com>
 <CAH2Cfb8K5hB=UeMOeTEXud1XZVp12Qbw9NYoxJ0XQK4FFuF3wQ@mail.gmail.com>
 <4857555a-812d-0b96-9a70-2984ffb50ca9@st.com> <CAH2Cfb8NzsOZDt8zBypY9ZiD6oOFWUBkZoPpKfU97ZRF_O0z+A@mail.gmail.com>
 <770c71bc-f387-62b6-f799-07ba6446e7e8@st.com> <CAH2Cfb87Wacgsh=xz9h9kgwYgBkxNBDbcDJ4W3uPs2LiKbTD9A@mail.gmail.com>
 <760819dc-4c26-b492-a0ba-8b27c189d5b1@st.com> <CAH2Cfb-EvWeP28W=Hqzvwaue55hBFCMecqvt3p8mRh52BZMdNg@mail.gmail.com>
 <596f9e4d-2db1-8040-211b-173ad19d9d0e@st.com> <CAH2Cfb87+MR5SNmm2zQU+44mV+3gTv4M2moFxQDXhEGHO00W+A@mail.gmail.com>
 <45511e33-df29-1a3c-66a1-151dc42bf10d@st.com>
In-Reply-To: <45511e33-df29-1a3c-66a1-151dc42bf10d@st.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Tue, 9 Apr 2019 18:14:34 +0800
Message-ID: <CAH2Cfb9vJG=ujkB9G7P6OmgRZQUiKoH6DGfOu4NuwB+cnXOs1A@mail.gmail.com>
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

On Tue, Apr 9, 2019 at 3:28 PM Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:
>
>
>
> On 4/8/19 3:29 PM, xiang xiao wrote:
> > On Mon, Apr 8, 2019 at 8:05 PM Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:
> >>
> >>
> >>
> >> On 4/6/19 9:56 AM, xiang xiao wrote:
> >>> On Sat, Apr 6, 2019 at 12:08 AM Arnaud Pouliquen
> >>> <arnaud.pouliquen@st.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 4/5/19 4:03 PM, xiang xiao wrote:
> >>>>> On Fri, Apr 5, 2019 at 8:33 PM Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 4/5/19 12:12 PM, xiang xiao wrote:
> >>>>>>> On Fri, Apr 5, 2019 at 12:14 AM Arnaud Pouliquen
> >>>>>>> <arnaud.pouliquen@st.com> wrote:
> >>>>>>>>
> >>>>>>>> Hello Xiang,
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 4/3/19 2:47 PM, xiang xiao wrote:
> >>>>>>>>> On Thu, Mar 21, 2019 at 11:48 PM Fabien Dessenne <fabien.dessenne@st.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> This driver exposes a standard tty interface on top of the rpmsg
> >>>>>>>>>> framework through the "rpmsg-tty-channel" rpmsg service.
> >>>>>>>>>>
> >>>>>>>>>> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
> >>>>>>>>>> per rpmsg endpoint.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> How to support multi-instances from the same remoteproc instance? I
> >>>>>>>>> saw that the channel name is fixed to "rpmsg-tty-channel" which mean
> >>>>>>>>> only one channel can be created for each remote side.
> >>>>>>>> The driver is multi-instance based on muti-endpoints on top of the
> >>>>>>>> "rpmsg-tty-channel" service.
> >>>>>>>> On remote side you just have to call rpmsg_create_ept with destination
> >>>>>>>> address set to ANY. The result is a NS service announcement that trigs a
> >>>>>>>>  probe with a new endpoint.
> >>>>>>>> You can find code example for the remote side here:
> >>>>>>>> https://github.com/STMicroelectronics/STM32CubeMP1/blob/master/Projects/STM32MP157C-DK2/Applications/OpenAMP/OpenAMP_TTY_echo/Src/main.c
> >>>>>>>
> >>>>>>> Demo code create two uarts(huart0 and huart1), and both use the same
> >>>>>>> channel name( "rpmsg-tty-channel").
> >>>>>>> But rpmsg_create_channel in kernel will complain the duplication:
> >>>>>>> /* make sure a similar channel doesn't already exist */
> >>>>>>> tmp = rpmsg_find_device(dev, chinfo);
> >>>>>>> if (tmp) {
> >>>>>>>         /* decrement the matched device's refcount back */
> >>>>>>>         put_device(tmp);
> >>>>>>>         dev_err(dev, "channel %s:%x:%x already exist\n",
> >>>>>>>                    chinfo->name, chinfo->src, chinfo->dst);
> >>>>>>>         return NULL;
> >>>>>>> }
> >>>>>>> Do you have some local change not upstream yet?
> >>>>>> Nothing is missing. There is no complain as the function
> >>>>>> rpmsg_device_match returns 0, because the chinfo->dst (that corresponds
> >>>>>> to the remote ept address) is different.
> >>>>>>
> >>>>>
> >>>>> Yes, you are right.
> >>>>>
> >>>>>> If i well remember you have also a similar implementation of the service
> >>>>>> on your side. Do you see any incompatibility with your implementation?
> >>>>>>
> >>>>>
> >>>>> Our implementation is similar to yours, but has two major difference:
> >>>>> 1.Each instance has a different channel name but share the same prefix
> >>>>> "rpmsg-tty*", the benefit is that:
> >>>>>    a.Device name(/dev/tty*) is derived from rpmsg-tty*, instead the
> >>>>> random /dev/ttyRPMSGx
> >>>>>    b.Don't need tty_idr to allocate the unique device id
> >>>> I understand the need but in your implementation it look like you hack
> >>>> the rpmsg service to instantiate your tty... you introduce a kind of
> >>>> meta rpmsg tty service with sub-service related to the serial content.
> >>>> Not sure that this could be upstreamed...
> >>>
> >>> Not too much hack here, the only change in common is:
> >>> 1.Add match callback into rpmsg_driver
> >>> 2.Call match callback in rpmsg_dev_match
> >>> so rpmsg driver could join the bus match decision process(e.g. change
> >>> the exact match to the prefix match).
> >>> The similar mechanism exist in other subsystem for many years.
> >> The mechanism also exists in rpmsg but based on the service. it is
> >> similar to the compatible, based on the rpmsg_device_id structure that
> >> should list the cervices supported.
> >
> > But match callback is much flexible than rpmsg_device_id table, the
> > table is fixed at compile time, match callback could do all matic at
> > the runtime.
> Today this not the way rpmsg implements the service but declares it on
> registration. This is an evolution of the rpmsg, so better to propose it
> in a separate thread.
>

Here is the patch I post before:
https://patchwork.kernel.org/patch/10791741/

> >
> >> My concern here is that you would like to expose the service on top of
> >> the tty while aim of this driver is just to expose a tty over rpmsg. So
> >> in this case seems not a generic implementation but a platform dependent
> >> implementation.
> >>
> >
> > I can't understand why the implementation is platform dependent, could
> > you explain more details?In your uart_rpmsg/c.
> the rpmsg service is "rpmsg-tty" this is a "standard" service. But you
> define a "rpmsg-ttyxxxx" service because you want to expose a service on
> top of the tty service, not the tty service itself. In this way you are
> not able to list this service in rpmsg_device_id because not standard
> static service, you have to implement the match. This look like you
> adapt rpmsg protocol to match with your platform implementation.
>
> >
> >>>
> >>>> proposal to integrate your need in the ST driver: it seems possible to
> >>>> have /dev/ttyRPMSGx with x corresponding to the remote endpoint address?
> >>>> So if you want to have a fixed tty name you can fix the remote endpoint.
> >>>> Is it something reasonable for you?
> >>>
> >>> But in our system, we have more than ten rpmsg services running at the
> >>> same time, it's difficult to manage them by the hardcode endpoint
> >>> address.
> >> Seems not so difficult. Today you identify your service by a name. Seems
> >> just a matter of changing it by an address, it just an identifier by an
> >> address instead of a string.
> >
> > But I still prefer to use string(channel name) not number(port) to
> > manage the multiple rpmsg instance:
> > 1.Just like nobody prefer use ip address not domain name.
> when i have a look in /dev/tty, a number is generaly used to instantiate
> the same device type. For instance if you have several tty over USB, you
> have several instantiation of the ttyACM, nothing linked to the service
> on top of the link.
> Here from my point of view it is the same.
>
> > 2.rpmsg protocol support name and port mapping natively, why not use it?
> Precisely we want to use native implementation of the protocol, not to
> extend it with the match function that introduces a meta service notion.
>
> I'm not sure that we can find a compromise on this point. So I would
> like to propose you to do this in 2 steps:
> step 1: we start on basic RPMsg service, (with ept addr as port ID, if
> you are interesting in).
> step 2: you send patch on top to propose rpmsg match function, with tty
> naming based on feature name (with support of the legacy).
>

It is fine to put the naming tty to another patch.

> >>>
> >>>>
> >>>>
> >>>>> 2.Each transfer need get response from peer to avoid the buffer
> >>>>> overflow. This is very important if the peer use pull
> >>>>> model(read/write) instead of push model(callback).
> >>>> I not sure to understand your point... You mean that you assume that the
> >>>> driver should be blocked until a response from the remote side?
> >>>
> >>> For example, in your RTOS demo code:
> >>> 1.VIRT_UART0_RxCpltCallback save the received data in a global buffer
> >>> VirtUart0ChannelBuffRx
> >>> 2.Main loop poll VirtUart0RxMsg flag and echo the data back to kernel
> >>> if this flag is set
> >>> Between step1 and step 2, kernel may send additional data and then
> >>> overwrite the data not get processed by main loop.
> >>> It's very easy to reproduce by:
> >>>   cat /dev/ttyRPMSGx > /tmp/dump &
> >>>   cat /a/huge/file > /dev/ttyRPMSGx
> >>>   diff /a/hug/file /tmp/dump
> >> Yes our example is very limited, aim is not to be robust for this use
> >> case but just giving a simple sample to allow user to send a simple text
> >> in console and echo it.
> >>> The push model mean the receiver could process the data completely in
> >>> callback context, and
> >>> the pull model mean the receiver just save the data in buffer and
> >>> process it late(e.g. by read call).
> >> Thanks for the clarification.
> >>>> This seems not compatible with a "generic" tty and with Johan remarks:
> >>>> "Just a drive-by comment; it looks like rpmsg_send() may block, but
> >>>> the tty-driver write() callback must never sleep."
> >>>>
> >>>
> >>> The handshake doesn't mean the write callback must block, we can
> >>> provide write_room callback to tell tty core to stop sending.
> >> In the write function you have implemented the wait_for_completion that
> >> blocks, waiting answer from the remote side. For instance in case of
> >> remote firmware crash, you should be blocked.
> >
> > This just make the code simple, and can be fixed by the classic slide
> > window algo easily.
> But i still not understand while we should wait an answer on a message.

With the slide window algo:
1.Exchange the buffer size at the beginning
2.Any side send data and decrease the buffer size
3.Implement write_room callback to return the left buffer size
4.tty framework stop to call write callack if write_room return 0
Since rpmsg transport is reliable, the receiver don't need send
acknowledge and then the sender don't need wait the response.
But the receiver need to send the message to report the new slide
window size after anybody read some data from buffer.

> The ack should be client dependent, not part of the protocol.
> Furthemore a issue of this is that the line discipline allows to echo
> every chars received on tty dev. This would generate an infinite loop as
> the remote also echo it.

For the loopback test, we should disable line discipline echo.

>
> >
> >>
> >>>
> >>>> Why no just let rpmsg should manage the case with no Tx buffer free,
> >>>> with a rpmsg_trysend...
> >>>
> >>> We can't do this since the buffer(e.g. VirtUart0ChannelBuffRx) is
> >>> managed by the individual driver:
> >>> The rpmsg buffer free, doesn't mean the driver buffer also free.
> >> Yes but this should be solved by your implementation in the remote
> >> firmware and/or in the linux client code, not by blocking the write,
> >> waiting an answer from remote.
> >> If you want a mechanism it should be manage in your application or in a
> >> client driver.
> >>
> >
> > The communication between all standard virtual channel is
> > reliable(e.g. pipe, fifo and unix socket), why is rpmsg virtual uart
> > unreliable?
> RTS management could help for this.
>
> >
> >> I think the main difference here is that the rpmsg_tty driver we propose
> >> is only a wrapper that should have same behavior as a standard UART
> >> link. This is our main requirement to allow to have same communication
> >> with a firmware running on a co-processor or a external processor (with
> >> an UART link).
> >> In your driver, you introduce some extra mechanisms that probably
> >> simplify your implementation, but that seems not compatible with a basic
> >> link:
> >>  - write ack
> >>  - wakeup
> >> ...
> >
> > But the standard UART also support the flow control through RTC/CTS
> > pin. I think that rpmsg uart should enable the flow control by
> > default, otherwise it's difficult to make it work reliable in AMP
> > environment, because CPU/MCU/DSP speed is very different.
> You are right the control flow is missing in our implementation.
> This is also an elegant way to enable the communication in both direction.
> So the wakeup in your implementation is used for this, right?

Yes, wakeup mean the peer has more free buffer again, it is very
simple but not effiecent as the slide window algo.

> Do you test the dtr_rts ops on your side?
> tty_port_operations ops should also be added...
>

dtr_rts just add the complexity, but don't have any benifit, because:
1.The flow control support isn't very expense(e.g. no RTC/CTS pin)
2.All existed virtual channel is always reliable(fifo, pipe and domain socket)
I prefer to make rpmsg tty always reliable and disable userspace change it.


> >
> >>
> >>
> >>>
> >>>>
> >>>>>
> >>>>> Here is the patch for kernel side:
> >>>>> https://github.com/xiaoxiang781216/linux/commit/f04d2386eb11e0781f0eb47d99fae838abf7eb53
> >>>>> https://github.com/xiaoxiang781216/linux/commit/1a41be362d916eb9104bf21065cb38a0a63d2e91
> >>>>>
> >>>>> And RTOS side:
> >>>>> https://github.com/PineconeCode/nuttx/blob/song-u1/include/nuttx/serial/uart_rpmsg.h
> >>>>> https://github.com/PineconeCode/nuttx/blob/song-u1/drivers/serial/uart_rpmsg.c
> >>>>>
> >>>>> Maybe, we can consider how to unify these two implementation into one.
> >>>> Yes sure.
> >>>>
> >>>>>
