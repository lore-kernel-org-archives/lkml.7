Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3006BC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1E1208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn2UBoen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404506AbfFKHxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:53:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35335 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404064AbfFKHxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:53:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so1743667wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PsR1uMNskWCiaEKRGZYWd94CEQPhPEaiy0Vl1ILZFE=;
        b=mn2UBoenodifxg0P77dyoVoUnVeu4+uGvE+hcTxJytv8hOPa9T2vCglpsXT/cqqWtU
         y9FPAz+yMc6ryQhJLPq7N94QbOGDhm2iLCKoST+WRNtOac0TxcYo6RkAxi2sFX7M/evw
         8iOj3cvE8UaBGXWJAQknwdfguvVCgZHvgo5WCRy1XKiZcIS3nX/3MvTVIjprUgymio/g
         MwtX8KX7w+GraVVSmch85QHq5s31505o+xryemWmTOndVteDzd/zBaLN9y3K3ZSqSvrm
         4T7EqRUvMoARBaeszJuHO8SvdKlA5FIkfRYAIeGiCmgKHH1ONuDplh4aXqIlVPmNMeP/
         qlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PsR1uMNskWCiaEKRGZYWd94CEQPhPEaiy0Vl1ILZFE=;
        b=IlGW+EXa0P8QCxB5uwC3DgRZ78Wrq/eTonXOVZXmwE3SDvENbIlVlRNk/Vk9fEsCg/
         ZHnPjtprAw5UjZ3JbUlMKJjFeVvWs6Uz3Q0a+ssukqstuAPHBWxzpaqzPpRbEPlnwNfs
         3BkgZlSv6Z4bFyItTNFeQCDQr2/Jp83upX+GYHPOWavhU0FrydIGvEkzGN5Aij005kJL
         Tt1oqN1I5eUIXw4LiAccQAlqM41wVmH8XqblSjEaIDWb35cci5uL5Q5SJt/L9gGmxTRQ
         KA/AKUluky1A8/p6krQfSHcCB8f13n4sQrV0V0jMxh8irEoZLtgJuM47G3MLNp8Hqxar
         oN9g==
X-Gm-Message-State: APjAAAUmjivJUYtjWfUULVS6XDQJj9a+wRsQiwlL/MWc21GxL9SOZfG7
        VZlkJ4F3oBrR7/o71TGZ+E+4J0RWdqDzrb0YTE0=
X-Google-Smtp-Source: APXvYqyF5SIUSHmvr/zUiXBYqwiUEUowRdzvH15L9I89xnXliAVBtDAbkb+4ZlrKEzxAwasxqqY7JX7xtKEdekYs5Rk=
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr15768111wmi.73.1560239578870;
 Tue, 11 Jun 2019 00:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190610141609.17559-1-daniel.baluta@nxp.com> <20190610141609.17559-3-daniel.baluta@nxp.com>
 <20190611055530.sl3krujmcqnq6ntt@pengutronix.de>
In-Reply-To: <20190611055530.sl3krujmcqnq6ntt@pengutronix.de>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 11 Jun 2019 10:52:47 +0300
Message-ID: <CAEnQRZB9irx7_AeYPCdv5WU3Q-MGt96BiUH8Yk8raeBDA0RjTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] imx: mailbox: Introduce TX doorbell with ACK
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>, jassisinghbrar@gmail.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

On Tue, Jun 11, 2019 at 8:56 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Hi Daniel,
>
> On Mon, Jun 10, 2019 at 10:16:09PM +0800, daniel.baluta@nxp.com wrote:
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > TX doorbell with ACK will allow us to push the doorbell ring button
> > (trigger GIR) and also will allow us to handle the response from DSP.
> >
> > DSP firmware found on i.MX8 boards implements a duplex
> > communication protocol over MU channels.
> >
> > On the host side (Linux) we need to plugin into Sound Open Firmware IPC
> > communication infrastructure which handles all the details (e.g message
> > queuing, tx/rx logic) [1] and the users are only required to provide the
> > following callbacks:
> >
> >   - send_msg (for Tx)
> >   - irq_handler (Ack of Tx, request from DSP)
> >
> > In order to implement send_msg and irq_handler we will use two MU
> > channels:
> >       * channel #0, TX doorbell with ACK
> >       * channel #1, RX doorbell
> >
> > Sending a request Host -> DSP (channel #0)
> >   - send_msg callback
> >       - write data into SHMEM
> >       - push doorbell ring button (trigger GIR)
> >  - irq handler
> >       - handle DSP request (channel #1)
> >         - read SHMEM and trigger SOF IPC state machine
> >         - send ACK (push doorbell ring button for channel #1)
> >       - handle DSP response (ACK) (channel #0)
> >         - read SHMEM and trigger IPC state machine
> >
> > The easisest way to implement this is to directly access the MU
> > registers but since the MU is abstracted using the mailbox interface
> > we need to use that instead.
> >
> > [1] https://elixir.bootlin.com/linux/v5.2-rc4/source/sound/soc/sof/ipc.c
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  drivers/mailbox/imx-mailbox.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> > index 9f74dee1a58c..3a91611e17d2 100644
> > --- a/drivers/mailbox/imx-mailbox.c
> > +++ b/drivers/mailbox/imx-mailbox.c
> > @@ -42,6 +42,7 @@ enum imx_mu_chan_type {
> >       IMX_MU_TYPE_RX,         /* Rx */
> >       IMX_MU_TYPE_TXDB,       /* Tx doorbell */
> >       IMX_MU_TYPE_RXDB,       /* Rx doorbell */
> > +     IMX_MU_TYPE_TXDB_ACK    /* Tx doorbell with Ack */
> >  };
> >
> >  struct imx_mu_con_priv {
> > @@ -124,6 +125,7 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
> >                       (ctrl & IMX_MU_xCR_RIEn(cp->idx));
> >               break;
> >       case IMX_MU_TYPE_RXDB:
> > +     case IMX_MU_TYPE_TXDB_ACK:
> >               val &= IMX_MU_xSR_GIPn(cp->idx) &
> >                       (ctrl & IMX_MU_xCR_GIEn(cp->idx));
> >               break;
> > @@ -200,6 +202,7 @@ static int imx_mu_startup(struct mbox_chan *chan)
> >               imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(cp->idx), 0);
> >               break;
> >       case IMX_MU_TYPE_RXDB:
> > +     case IMX_MU_TYPE_TXDB_ACK:
> >               imx_mu_xcr_rmw(priv, IMX_MU_xCR_GIEn(cp->idx), 0);
> >               break;
> >       default:
> > --
> > 2.17.1
>
> If I see it correctly, with your implementation  the mbox client
> communication on channel 0 will look as follow:
> mbox_client -> send_msg()
>             /* sheduling of mbox_chan_txdone tasklet is avoided */
> mbox_client <- cl->rx_callback()
> mbox_client -> mbox_client_txdone()
> mbox_client -> send_msg()
>

Correct! But what I thought it is most important here is that
send_msg and rx_callback are called on the same "connection"
so that inside rx_callback I can figure out if I got an ACK or I got
a request from the other side.

> Without your patch you will need to register tx and rx doorbell
> channels and the communication will looks like this:
> mbox_client -> send_msg()
> mbox_client <- mbox_chan_txdone() /* dummy notification, can be ignored */
> mbox_client <- cl->rx_callback()
> mbox_client -> send_msg()
>
> I assume, you are trying to optimize it and avoid dummy
> mbox_chan_txdone() notification. Correct?

TBH I am little bit confused about the role of txdb_tasklet. Is it there
just to trigger the sending of the next message in the buffer?

Using IMX mailbox with SOF IPC mechanism has a lot of overhead because
I think they are both doing the same thing.

E.g: On TX queuing the messages and then when ACK arrives it will send the
next message.

>
> The problem is, that current mailbox-framework will set txdone_method
> inside of mbox_controller_register() for all channels even if
> imx-mailbox has different types of channels.
>
> The problem with your patch is, that it will silently merge two channels
> (TXDB and RXDB) and not setting actual ACK by controller - mbox_chan_txdone().
> Not sure, why we need to merge it in this case.
>
> So, with current imx_mailbox implementation your firmware should work as
> is. You will need to register two separate channels for TXDB and
> RXDB. It will run with some overhead by triggering txdone tasklet in
> imx-mailbox driver.

I see your point. I think with the current imx_mailbox implementation SOF IPC
should work as it is with some overhead (at least when Host (Linux) initiates
the communication).

The keypoint here (I figured it out now) is that the two channels
TXDB and RXDB share the same IDX right? So, with
this idx we can figure out that we have an ACK from DSP or a request from DSP.

So we are set for communication when Host (Linux) starts the communication. It
should just work.

How about the case when DSP initiates the communication and Host needs to
send an ACK.

In this case we have:

mbox_client <- cl->rx_callback()
   mbox_client -> send_msg()

The problem here is that the Host needs to call send_msg() from inside
the rx_callback().
Do you see any problems with that:

Basically the pseudocode will be something like this:

Create connection #0 (RXDB0, TXDB0) Host -> DSP (Host initiates
communication, DSP sends ACK)
Create connection #1 (RXDB1, TXDB1) DSP -> Host (DSP initiates
communication, Host sends ACK).

rx_callback:
 -> if (chan_id == 0) // this has to be an ACK from DSP
      get_reply_from_shmem
      trigger SOF IPC state machine (let them know we got a reply)
    else if (chan_id == 1) // this has to be a request from DSP
      get_request()
       mbox_send_message(sc_chan->ch, NULL); //send back ACK



>
> If this overhead is a problem, then this should be fixed.

I need to have a working version with the current implementation
and then tell if overhead is a problem.

> Merging two doorbell  channels in to one with ACK support is nice,
> but will introduce more issues if we need other doorbell channels
> without ACK support on same controller
>
> I personally would prefer to to extend mailbox framework to support
> controllers with mixed channel types and remove dummy txdone tasklet
> from imx-mailbox.
>
> Since we already initialize part of &mbox->chans[i] by imx-mailbox driver,
> we can set proper chan->txdone_method as well. So we need only to
> prevent mbox_controller_register() to overwrite it.

Thanks for your explanations! Thinks are much clearer now!

Will try to work on implementing what I need with the current IMX mailbox
support and send patches for review.

thanks,
Daniel.
