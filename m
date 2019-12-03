Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD128C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E51C207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YglsSYyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLCTUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:20:33 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38520 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfLCTUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:20:33 -0500
Received: by mail-io1-f67.google.com with SMTP id u7so2541177iop.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 11:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TvP+g3uBvcOeVSsYMJC2xWkgAecurGtEzVkTlid2Ttg=;
        b=YglsSYyhj3CbWpRQaNc1+jdSd4UFPkeL0FrBUG3JFYVDt6ZHcp4GHgOgfjFW63CeSq
         wjcVRMQypFrlxk43qsWO7E4gnvcN1jL4Or+j3wn/mnT2KNl8OODpzOsyjYkxJKKz1aPC
         rqou8VsOjXZa653rs/6OVRGcX3IuVVAG1nLWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvP+g3uBvcOeVSsYMJC2xWkgAecurGtEzVkTlid2Ttg=;
        b=Qnoe1upZCQygiuKjg44q3wQZtq+2XvodjhN+fWKMPygtzE0zu9iTVJtWMYUiFFX3Hn
         +JhxmduBvUDKruPTrW4u9pVjBVKvBuQP65ooE9L8nwhm8KqpzKtY5XTMm7nXCDZPFwP7
         x3fEvbkSsxcEsOix0E3FeyZmMI+CSgBQE5D0peq1F+wfpC9mdFQM3gsre604nnvBi5gB
         BvJ6vrSGGMFidw2AjAYfTSvgB6MWqlNXpqJzVYXkPvhsvyn2BXxmN5gQcIbWKVGYREk6
         6h52koUaxgJysGoh60ICW39GjT7rMnEXiibYBqzS5PKfYE8Ldv3IbcQ4hORhLqEC8JmK
         ARcQ==
X-Gm-Message-State: APjAAAV63E5AKBR/dcOKkZ3H5H0gSHhNHiLLJ1scq8U9v5zIVzMB2Yek
        NqrPACFoG0Yx2LTF78FS2h4fPn/2oKTchnb4AimKvA==
X-Google-Smtp-Source: APXvYqxIqbATMncaukJv5krUI4XksyqiCTVVumNG0PCuF2/zyV34+Khxq7cttOW40ZK1afQ27PWbTdPGPWqyaw99mpE=
X-Received: by 2002:a02:334b:: with SMTP id k11mr1805276jak.51.1575400831955;
 Tue, 03 Dec 2019 11:20:31 -0800 (PST)
MIME-Version: 1.0
References: <0f223903-ec93-a5ec-e858-fa0e2e282cf3@collabora.com>
 <20191125221517.91611-1-yichengli@chromium.org> <5fd3e86c-21ac-82fb-c3c5-4ff1f43e0219@collabora.com>
In-Reply-To: <5fd3e86c-21ac-82fb-c3c5-4ff1f43e0219@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 3 Dec 2019 11:20:21 -0800
Message-ID: <CAPUE2utpQGfX0XNNijYKEM+7=3BbbuvPxTfcrP-qq1OmYNAZzw@mail.gmail.com>
Subject: Re: [PATCH v4] mfd / platform: cros_ec: Query EC protocol version if
 EC transitions between RO/RW
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Yicheng Li <yichengli@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 1:56 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Yicheng,
>
> I looked at this patch deeply and I have a question.
>
> On 25/11/19 23:15, Yicheng Li wrote:
> > RO and RW of EC may have different EC protocol version. If EC transitions
> > between RO and RW, but AP does not reboot (this is true for fingerprint
> > microcontroller / cros_fp, but not true for main ec / cros_ec), the AP
> > still uses the protocol version queried before transition, which can
> > cause problems. In the case of fingerprint microcontroller, this causes
> > AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in the
> > interrupt handler, which in turn prevents RO to clear the interrupt
> > line to AP, in an infinite loop.
> >
> > Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that there
> > might have been a transition between RO and RW, so re-query the protocol.
> >
> > Signed-off-by: Yicheng Li <yichengli@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec.c           | 24 +++++++++++++++++++++
> >  include/linux/platform_data/cros_ec_proto.h |  3 +++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> > index 9b2d07422e17..38ec1fb409a5 100644
> > --- a/drivers/platform/chrome/cros_ec.c
> > +++ b/drivers/platform/chrome/cros_ec.c
> > @@ -104,6 +104,23 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> >       return ret;
> >  }
> >
> > +static int cros_ec_ready_event(struct notifier_block *nb,
> > +     unsigned long queued_during_suspend, void *_notify)
> > +{
> > +     struct cros_ec_device *ec_dev = container_of(nb, struct cros_ec_device,
> > +                                                  notifier_ready);
> > +     u32 host_event = cros_ec_get_host_event(ec_dev);
> > +
> > +     if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_INTERFACE_READY)) {
> > +             mutex_lock(&ec_dev->lock);
> > +             cros_ec_query_all(ec_dev);
>
> I am wondering if instead of calling cros_ec_query_all we can just set the proto
> version to unknown:
>
>    ec_dev->proto_version == EC_PROTO_VERSION_UNKNOWN
>
> and let the cros_ec_cmd_xfer function do its magic.

This has actually been used in cros_ec_query_all itself, when the EC
is not responding: when cros_ec_cmd_xfer is called,
cros_ec_query_all() is called again. This is used when
cros_ec_query_all() is called cros_ec_register(), but this is not
working properly anymore, because the irq and device driver will not
be registered anymore. See in cros_ec_register when cros_ec_query_all
is called and set _UNKNOWN, ret is not 0 and cros_ec_register() will
bail. I will work on it later. (crbug.com/1030373 for reference).

For our case at hand, we can not wait for a command coming from user
space to unlock us. Internal commands could use send_command directly,
if a new interrupt comes up for instance). Let's put all the check
code from cros_ec_cmd_xfer() in send_command() and indeed reset the
proto_version.

Gwendal.

>
> Should that work?
>
> Thanks,
>  Enric
>
> > +             mutex_unlock(&ec_dev->lock);
> > +             return NOTIFY_OK;
> > +     }
> > +
> > +     return NOTIFY_DONE;
> > +}
> > +
> >  /**
> >   * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
> >   * @ec_dev: Device to register.
> > @@ -201,6 +218,13 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
> >               dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
> >                       err);
> >
> > +     /* Register the notifier for EC_HOST_EVENT_INTERFACE_READY event. */
> > +     ec_dev->notifier_ready.notifier_call = cros_ec_ready_event;
> > +     err = blocking_notifier_chain_register(&ec_dev->event_notifier,
> > +                                            &ec_dev->notifier_ready);
> > +     if (err)
> > +             return err;
> > +
> >       dev_info(dev, "Chrome EC device registered\n");
> >
> >       return 0;
> > diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> > index 0d4e4aaed37a..a1c545c464e7 100644
> > --- a/include/linux/platform_data/cros_ec_proto.h
> > +++ b/include/linux/platform_data/cros_ec_proto.h
> > @@ -121,6 +121,8 @@ struct cros_ec_command {
> >   * @event_data: Raw payload transferred with the MKBP event.
> >   * @event_size: Size in bytes of the event data.
> >   * @host_event_wake_mask: Mask of host events that cause wake from suspend.
> > + * @notifier_ready: The notifier_block to let the kernel re-query EC
> > + *      communication protocol when the EC sends EC_HOST_EVENT_INTERFACE_READY.
> >   * @ec: The platform_device used by the mfd driver to interface with the
> >   *      main EC.
> >   * @pd: The platform_device used by the mfd driver to interface with the
> > @@ -161,6 +163,7 @@ struct cros_ec_device {
> >       int event_size;
> >       u32 host_event_wake_mask;
> >       u32 last_resume_result;
> > +     struct notifier_block notifier_ready;
> >
> >       /* The platform devices used by the mfd driver */
> >       struct platform_device *ec;
> >
