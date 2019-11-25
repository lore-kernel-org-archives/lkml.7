Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9ACC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAAE2068E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZLjr6Tbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfKYQuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:50:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44132 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfKYQuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:50:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id a67so13341192edf.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 08:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PjZmTDNX7Oh8S6LopwDwjhGUMI/D1VBD8yGIc973Eio=;
        b=ZLjr6TbgcIihUmoMNl0Ej6deyjc6vOToFsszMeHb2am5LMBG1zVLdQ0Z5zsBGzzJHL
         5sfKG/G910/mXd9hnI00UbadaeLtomjktc3lFyCTvdMPO6a8JwO+yn+qSpDtbG6Bw758
         3CUrBkSsnHASdv2C4q5SeVp2/QlANHUAIPpYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjZmTDNX7Oh8S6LopwDwjhGUMI/D1VBD8yGIc973Eio=;
        b=ubntsRj7noO+Bx5m1Bla07oHt4UGAvhcv0fhC88eNW2P9CLsePSDGJhLwmmplqiycb
         USWTyTiiwsS0CaU5au6WOGrqshp3pyoE9+ZyCwGqd6+klwNEtI5+uzBVDLzp/8ZkyLG1
         HODacgI0oNCWUDqzQ1vIqaE5KNCk0J5QtAfmGrl2gjK0xfzYVGIY4G5TL0s7Hsbpi37n
         s5eK7nU92aYHeNEDmOYw+YlAgoHJAGZdYnHVe6oiqaG/SX/cTojudb6yWogT/ObOcNyo
         kDnB6PglzFzgPLxB8FW7lJPRNOsxZ4eZvBAhblSp3zwW5B3U0hOAn5YWT6h5br2TBWPu
         b11g==
X-Gm-Message-State: APjAAAWcgX/UUfdXjhFOGzVruKdhv0QQBF++aDRrWLFOKGtbqEz/VNSS
        zktsiRW8TxlK8PJRXU/NmaVFycuQ2Zg=
X-Google-Smtp-Source: APXvYqx5CrP7uevlEd1mkkRq39KjPBmQAwUMxB5pQe2UPxwHyVIu+YdBSfKSTHsa8NM6FpqMdXrl1Q==
X-Received: by 2002:a17:906:1983:: with SMTP id g3mr37972439ejd.84.1574700603651;
        Mon, 25 Nov 2019 08:50:03 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id e13sm272410edm.29.2019.11.25.08.50.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 08:50:02 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id u18so8764wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 08:50:02 -0800 (PST)
X-Received: by 2002:a7b:cd17:: with SMTP id f23mr27417713wmj.86.1574700601972;
 Mon, 25 Nov 2019 08:50:01 -0800 (PST)
MIME-Version: 1.0
References: <20191121115542.1.Iaf98f0ab455b626537e77cfa71cef6ff2ab6f37b@changeid>
 <4eef47ad-8d42-1ab4-0c99-028a121cc27c@collabora.com>
In-Reply-To: <4eef47ad-8d42-1ab4-0c99-028a121cc27c@collabora.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 25 Nov 2019 09:49:50 -0700
X-Gmail-Original-Message-ID: <CAHQZ30BOmBBHnDR2fTWA1_uoTd6c5+66PbpA57MpiWZcnU5y+A@mail.gmail.com>
Message-ID: <CAHQZ30BOmBBHnDR2fTWA1_uoTd6c5+66PbpA57MpiWZcnU5y+A@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Add response tracing
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 8:45 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Raul,
>
> Many tanks for sending this patch upstream, some few comments below.
>
> On 21/11/19 19:55, Raul E Rangel wrote:
> > Add the ability to view response codes as well.
> >
> > I renamed the trace event from cros_ec_cmd to cros_ec_request and added
> > a cros_ec_response.
> >
> > Example:
> > $ echo 1 > /sys/kernel/debug/tracing/events/cros_ec/enable
> > $ cat /sys/kernel/debug/tracing/trace
> >
> > cros_ec_request: version: 1, command: EC_CMD_CONSOLE_READ
> > cros_ec_response: version: 1, command: EC_CMD_CONSOLE_READ, result: EC_RES_SUCCESS, rc: 0
>
> I don't see the advantage of have two traces, one for the request and another
> one for the response. Do you expect get stuck between them?

It might if there is a bug in xfer_fxn, we miss an interrupt, or some
kind of communication problem on the bus (early bring up issues). It's
also possible to compute the latency of a transaction by having both.
The mmc subsystem has both mmc_request_start and mmc_request_done. If
you feel strongly, I can record just the response.
>
> What about just move the trace_cros_ec_cmd after the xfer_fnx call and add the
> results?
>
> Thanks,
>  Enric
>
> > cros_ec_request: version: 0, command: EC_CMD_USB_PD_POWER_INFO
> > cros_ec_response: version: 0, command: EC_CMD_USB_PD_POWER_INFO, result: EC_RES_SUCCESS, rc: 16
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> >
> >  drivers/platform/chrome/cros_ec_proto.c |  7 +++++-
> >  drivers/platform/chrome/cros_ec_trace.c | 24 +++++++++++++++++++
> >  drivers/platform/chrome/cros_ec_trace.h | 32 +++++++++++++++++++++++--
> >  3 files changed, 60 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index bd485ce98a42..ef2229047e0f 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -54,7 +54,7 @@ static int send_command(struct cros_ec_device *ec_dev,
> >       int ret;
> >       int (*xfer_fxn)(struct cros_ec_device *ec, struct cros_ec_command *msg);
> >
> > -     trace_cros_ec_cmd(msg);
> > +     trace_cros_ec_request(msg);
> >
> >       if (ec_dev->proto_version > 2)
> >               xfer_fxn = ec_dev->pkt_xfer;
> > @@ -73,6 +73,8 @@ static int send_command(struct cros_ec_device *ec_dev,
> >       }
> >
> >       ret = (*xfer_fxn)(ec_dev, msg);
> > +
> > +     trace_cros_ec_response(msg, ret);
> >       if (msg->result == EC_RES_IN_PROGRESS) {
> >               int i;
> >               struct cros_ec_command *status_msg;
> > @@ -95,7 +97,10 @@ static int send_command(struct cros_ec_device *ec_dev,
> >               for (i = 0; i < EC_COMMAND_RETRIES; i++) {
> >                       usleep_range(10000, 11000);
> >
> > +                     trace_cros_ec_request(status_msg);
> >                       ret = (*xfer_fxn)(ec_dev, status_msg);
> > +                     trace_cros_ec_response(status_msg, ret);
> > +
> >                       if (ret == -EAGAIN)
> >                               continue;
> >                       if (ret < 0)
> > diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
> > index 6f80ff4532ae..28eb94d99ba2 100644
> > --- a/drivers/platform/chrome/cros_ec_trace.c
> > +++ b/drivers/platform/chrome/cros_ec_trace.c
> > @@ -120,5 +120,29 @@
> >       TRACE_SYMBOL(EC_CMD_PD_GET_LOG_ENTRY), \
> >       TRACE_SYMBOL(EC_CMD_USB_PD_MUX_INFO)
> >
> > +// See enum ec_status
>
> Use the C comment style, please.
I used // because that was the comment format used above `#define
EC_CMDS`. Do you want me to change that as well?

Thanks
