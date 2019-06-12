Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9803C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A83B20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6PcKyLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405792AbfFLGwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 02:52:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55894 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403835AbfFLGwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:52:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so5272773wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 23:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ulcq9xQCWAH/f9UsiQoGM9KGdiggu8TOlzSXG8MJFvc=;
        b=g6PcKyLgyxgXjOl38WQ3dtb/t1EvHgLpzS6nqkS1MhYS6WaJd4F5g1XKNvyYUwqpGC
         ZSf+5qCxgoCvK+JOGRePPereWPkLZWFsLe8e6KbOTyP74sX12epc1ubdK00Iz8OxTerM
         aNpy4wLrGX7BsRYrnlJ4CFICKYdjfZrW/0Vt5AHfzKr66JIH6evx6LbXbauI9BrHxrbF
         vts7VcpRjHrxtnFoJt84AFVBqUb5Y02QHOJTRoHoLXos0J9VsnCrH5UBU5cTHOBd5fCg
         68ODBOlPLix5Z9WG/dZWXuMsdTCjxgetp3T52NRotZzk3hWEav5QnzfpdAgZHSpfCUU7
         AAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ulcq9xQCWAH/f9UsiQoGM9KGdiggu8TOlzSXG8MJFvc=;
        b=bsebJsQdZ7h7/aSEG5f6N/mlLYofOd7b6jh6LLYNPxL6MLxO+RnhYohgn8453j4J2F
         Bv2gofWUH8Y9UiCDzZ98PVbmgeUj3OKd28mHHErHf60VROLKu3q23HRD0eRlRYGxCitS
         p/C6nk8zsYp+MglU9VhzX5kbaVMX6Na+KdaTzyJtaIuifVGfzCkg3gbrpSBkAPHeLyHP
         fSxyjMCfGOawejVrwYosiJbztZIMOLaSjNlXezoTkYM2l7QD6cBKR80IfPFO72atx0XL
         Lxmm8+MHl3cNODUfFPPHvc41qtq+/PUXefXdn/65JdrIsKwKD01mhZZzLchmC6DfTGyK
         DdAw==
X-Gm-Message-State: APjAAAVZerrm4V3vr4CWRTn36E3Mw3JRfbhgxSDhQA7eYvF0giNLY0l5
        h0phTV7KKc6GvlrSAO3LL7nESEL1efNMUk2aE7g=
X-Google-Smtp-Source: APXvYqwKztTk7/FeTwYoLGsG/mYqVgPTvTXh4npMNyAQdvR4Z7GHbkhBngHF6MEwzZWxtpCZ0X19H87b+wWCMZWlNUk=
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr19660271wmi.73.1560322319303;
 Tue, 11 Jun 2019 23:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190610141609.17559-1-daniel.baluta@nxp.com> <20190610141609.17559-3-daniel.baluta@nxp.com>
 <20190611055530.sl3krujmcqnq6ntt@pengutronix.de> <CAEnQRZB9irx7_AeYPCdv5WU3Q-MGt96BiUH8Yk8raeBDA0RjTQ@mail.gmail.com>
 <20190611084015.bjsusho5leqvfvhr@pengutronix.de>
In-Reply-To: <20190611084015.bjsusho5leqvfvhr@pengutronix.de>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 12 Jun 2019 09:51:48 +0300
Message-ID: <CAEnQRZDbuvpFfr9vNCQ5+EDNnbgR7EwNGT55=M-7PKRY2OttOA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] imx: mailbox: Introduce TX doorbell with ACK
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        jassisinghbrar@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:40 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> On Tue, Jun 11, 2019 at 10:52:47AM +0300, Daniel Baluta wrote:
> > Hi Oleksij,
> >
> > On Tue, Jun 11, 2019 at 8:56 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > >
> > > Hi Daniel,
> > >
> > > On Mon, Jun 10, 2019 at 10:16:09PM +0800, daniel.baluta@nxp.com wrote:
> > > > From: Daniel Baluta <daniel.baluta@nxp.com>
> > > >
> > > > TX doorbell with ACK will allow us to push the doorbell ring button
> > > > (trigger GIR) and also will allow us to handle the response from DSP.
> > > >
> > > > DSP firmware found on i.MX8 boards implements a duplex
> > > > communication protocol over MU channels.
> > > >
> > > > On the host side (Linux) we need to plugin into Sound Open Firmware IPC
> > > > communication infrastructure which handles all the details (e.g message
> > > > queuing, tx/rx logic) [1] and the users are only required to provide the
> > > > following callbacks:
> > > >
> > > >   - send_msg (for Tx)
> > > >   - irq_handler (Ack of Tx, request from DSP)
> > > >
> > > > In order to implement send_msg and irq_handler we will use two MU
> > > > channels:
> > > >       * channel #0, TX doorbell with ACK
> > > >       * channel #1, RX doorbell
> > > >
> > > > Sending a request Host -> DSP (channel #0)
> > > >   - send_msg callback
> > > >       - write data into SHMEM
> > > >       - push doorbell ring button (trigger GIR)
> > > >  - irq handler
> > > >       - handle DSP request (channel #1)
> > > >         - read SHMEM and trigger SOF IPC state machine
> > > >         - send ACK (push doorbell ring button for channel #1)
> > > >       - handle DSP response (ACK) (channel #0)
> > > >         - read SHMEM and trigger IPC state machine
> > > >
> > > > The easisest way to implement this is to directly access the MU
> > > > registers but since the MU is abstracted using the mailbox interface
> > > > we need to use that instead.
> > > >
> > > > [1] https://elixir.bootlin.com/linux/v5.2-rc4/source/sound/soc/sof/ipc.c
> > > >
> > > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > > ---
> > > >  drivers/mailbox/imx-mailbox.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> > > > index 9f74dee1a58c..3a91611e17d2 100644
> > > > --- a/drivers/mailbox/imx-mailbox.c
> > > > +++ b/drivers/mailbox/imx-mailbox.c
> > > > @@ -42,6 +42,7 @@ enum imx_mu_chan_type {
> > > >       IMX_MU_TYPE_RX,         /* Rx */
> > > >       IMX_MU_TYPE_TXDB,       /* Tx doorbell */
> > > >       IMX_MU_TYPE_RXDB,       /* Rx doorbell */
> > > > +     IMX_MU_TYPE_TXDB_ACK    /* Tx doorbell with Ack */
> > > >  };
> > > >
> > > >  struct imx_mu_con_priv {
> > > > @@ -124,6 +125,7 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
> > > >                       (ctrl & IMX_MU_xCR_RIEn(cp->idx));
> > > >               break;
> > > >       case IMX_MU_TYPE_RXDB:
> > > > +     case IMX_MU_TYPE_TXDB_ACK:
> > > >               val &= IMX_MU_xSR_GIPn(cp->idx) &
> > > >                       (ctrl & IMX_MU_xCR_GIEn(cp->idx));
> > > >               break;
> > > > @@ -200,6 +202,7 @@ static int imx_mu_startup(struct mbox_chan *chan)
> > > >               imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(cp->idx), 0);
> > > >               break;
> > > >       case IMX_MU_TYPE_RXDB:
> > > > +     case IMX_MU_TYPE_TXDB_ACK:
> > > >               imx_mu_xcr_rmw(priv, IMX_MU_xCR_GIEn(cp->idx), 0);
> > > >               break;
> > > >       default:
> > > > --
> > > > 2.17.1
> > >
> > > If I see it correctly, with your implementation  the mbox client
> > > communication on channel 0 will look as follow:
> > > mbox_client -> send_msg()
> > >             /* sheduling of mbox_chan_txdone tasklet is avoided */
> > > mbox_client <- cl->rx_callback()
> > > mbox_client -> mbox_client_txdone()
> > > mbox_client -> send_msg()
> > >
> >
> > Correct! But what I thought it is most important here is that
> > send_msg and rx_callback are called on the same "connection"
> > so that inside rx_callback I can figure out if I got an ACK or I got
> > a request from the other side.
> >
> > > Without your patch you will need to register tx and rx doorbell
> > > channels and the communication will looks like this:
> > > mbox_client -> send_msg()
> > > mbox_client <- mbox_chan_txdone() /* dummy notification, can be ignored */
> > > mbox_client <- cl->rx_callback()
> > > mbox_client -> send_msg()
> > >
> > > I assume, you are trying to optimize it and avoid dummy
> > > mbox_chan_txdone() notification. Correct?
> >
> > TBH I am little bit confused about the role of txdb_tasklet. Is it there
> > just to trigger the sending of the next message in the buffer?
>
> ACK. The TX type channel is acknowledged as soon as opposite side will
> read out the TX/RX FIFO. In this case we will get an interrupt and
> call mbox_chan_txdone(). With the TXDB type channels we have no this
> kind of interrupts, so we need to some how to tell the mailbox framework
> that this transmission is kind of done.

All clear! Thanks for the explanation.

>
> Beside, are there any reason why do you use TXDB instead of TX channel?
> In this case you will get your ACK for free.

TX doesn't work for me because I get an ACK as soon as the other side reads the
message.

On the other side (DSP) I need the following:
- DSP receives interrupt
- DSP reads some SHM
- DSP writes some SHM
- DSP raises an interrupt to the Host

With only TX channel I cannot do this. I really need a doorbell + shmem.

>
> > Using IMX mailbox with SOF IPC mechanism has a lot of overhead because
> > I think they are both doing the same thing.
>
> Sorry, I fail to follow this argumentation. If it important, please
> describe your issue.

Not important for the moment. I need to have a working version with mailbox API
and then can tell.

>
> >
> > E.g: On TX queuing the messages and then when ACK arrives it will send the
> > next message.
> >
> > >
> > > The problem is, that current mailbox-framework will set txdone_method
> > > inside of mbox_controller_register() for all channels even if
> > > imx-mailbox has different types of channels.
> > >
> > > The problem with your patch is, that it will silently merge two channels
> > > (TXDB and RXDB) and not setting actual ACK by controller - mbox_chan_txdone().
> > > Not sure, why we need to merge it in this case.
> > >
> > > So, with current imx_mailbox implementation your firmware should work as
> > > is. You will need to register two separate channels for TXDB and
> > > RXDB. It will run with some overhead by triggering txdone tasklet in
> > > imx-mailbox driver.
> >
> > I see your point. I think with the current imx_mailbox implementation SOF IPC
> > should work as it is with some overhead (at least when Host (Linux) initiates
> > the communication).
> >
> > The keypoint here (I figured it out now) is that the two channels
> > TXDB and RXDB share the same IDX right?
>
> ACK. Same idx with different types.
>
> > So, with
> > this idx we can figure out that we have an ACK from DSP or a request from DSP.
>
> Actually you will get it no by idx, you will get it by proper device
> tree configuration and assigned cl->rx_callback(). You assign rx_callback() per
> each rx-able channel.

I get your point. But maybe I can use the same rx_callback for each
rx-able channel
and can somehow differentiate on which channel I got the RX interrupt.
Like imx-scu
does.

>
> >
> > So we are set for communication when Host (Linux) starts the communication. It
> > should just work.
> >
> > How about the case when DSP initiates the communication and Host needs to
> > send an ACK.
> >
> > In this case we have:
> >
> > mbox_client <- cl->rx_callback()
> > mbox_client -> send_msg()
>
> The call chain of rx_callback() is:
> imx_mu_isr()
>   mbox_chan_received_data()
>     cl->rx_callback()
>
> Since rx_callback() is in interrupt context, send_msg() should be non
> blocking. You can use workqueue or some thing like this to mbox_send_message()
> out of interrupt context.

Yup send message won't be blocking. It just sets a bit in MU registers.

>
> > The problem here is that the Host needs to call send_msg() from inside
> > the rx_callback().
> > Do you see any problems with that:
> >
> > Basically the pseudocode will be something like this:
> >
> > Create connection #0 (RXDB0, TXDB0) Host -> DSP (Host initiates
> > communication, DSP sends ACK)
> > Create connection #1 (RXDB1, TXDB1) DSP -> Host (DSP initiates
> > communication, Host sends ACK).
> >
> > rx_callback:
> >  -> if (chan_id == 0) // this has to be an ACK from DSP
> >       get_reply_from_shmem
> >       trigger SOF IPC state machine (let them know we got a reply)
> >     else if (chan_id == 1) // this has to be a request from DSP
> >       get_request()
> >        mbox_send_message(sc_chan->ch, NULL); //send back ACK
> >
>
> If properly implemented, you will have separate rx_callback()s for each
> channel.
>
> I assume at some later point you will need to extend the ACK to some
> thing like:
> - ACK - message is ok and processed
> - BUSY - endpoint is still processing
> - ERR - message is corrupt or wrong formatting
> ... and so on.
>
> To be able to transmit different types of ACK you will probably
> use TX/RX type channels + shmem instead of the doorbell.

I think SOF framework already does this:

https://elixir.bootlin.com/linux/v5.2-rc4/source/sound/soc/sof/ipc.c#L203

When ACK is sent it also contains a reply_error field. Also, for BUSY we
just use a timeout on Host side.

Thanks a lot Oleksij for your help!

Daniel.
