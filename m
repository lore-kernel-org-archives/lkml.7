Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAB1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92129218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j30RP5CJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfCVSjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:39:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39824 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfCVSjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 14:39:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id l7so2886764ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 11:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSYM/lE/KT01QaZoImFD4qe2O3y+6F5gGaiZ9Y7krzg=;
        b=j30RP5CJiEC9HQuoBvVR7YhB1WTHVLaZW2cXcLIdivbsjOCbtxAukzY0FXuleFTqIX
         Dykbi1SdnIJoAobJCMqDkEx9Lsdxym9Hdgo8dgOg4BGJECeKQm/xSCpBDGl4pBm+Cs+8
         D+PUtlrzPzZWRj5W5G85nCHbXkbK/Y1ZCEVO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSYM/lE/KT01QaZoImFD4qe2O3y+6F5gGaiZ9Y7krzg=;
        b=UQ/5tR7azqjiZbNxYteYyo7bri+kVddYFt9MgMi9IZAjZvRu0BBXV3JN5Yo7AE6bWb
         dmqgPXffv8oMR621VrMwJL5oFFzLxNqyIh59eENPB66AyS9SsazIZ9r4nUFHU7OZ50gO
         TSOaAuzsvJI0M1xf+96w7AapagkLGYwUXzdmzBg1Nt+HmcPb07qhZa2HITpbLnznpzSw
         PIy9Mvgo6F9fx7/Cm1a+YsEYJkgrt5meHxyrvQ4NzbxAC9LjilvicF31YpZaQzQfb5WQ
         ZMTtnToG9Uzn+wFabpcc31wAOnaCwfT7MSjVTdy8OxTA8y4Nb/gAYkDVPakergf1DYkP
         padg==
X-Gm-Message-State: APjAAAUe2mNUuc3Cd9cxcFVh9DVKrLlAO9qa8CAzpMTtZPzC+hKJdEkx
        WsDHN8csXft0P7hSDPA8bG7p7mSMLXY=
X-Google-Smtp-Source: APXvYqwQVA+OUdCF4Skx8oaYrUnMq2XaM9N3EMU3srcb3KAPAB7k40qZ+pac4W0pD9uDu0pHB4xUnQ==
X-Received: by 2002:a2e:9597:: with SMTP id w23mr1034537ljh.111.1553279988340;
        Fri, 22 Mar 2019 11:39:48 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id x76sm1828435ljb.17.2019.03.22.11.39.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 11:39:47 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id v14so2154150lfi.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 11:39:47 -0700 (PDT)
X-Received: by 2002:a19:7105:: with SMTP id m5mr5971597lfc.154.1553279987372;
 Fri, 22 Mar 2019 11:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190320212030.43682-1-evgreen@chromium.org> <20190320212030.43682-3-evgreen@chromium.org>
 <CABXOdTfPfyxWfAvAaphfbhei4wuTxZLCbqS8gr=uCemepJRkkA@mail.gmail.com>
In-Reply-To: <CABXOdTfPfyxWfAvAaphfbhei4wuTxZLCbqS8gr=uCemepJRkkA@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 22 Mar 2019 11:39:10 -0700
X-Gmail-Original-Message-ID: <CAE=gft7S3L9-Hg4CqwhbZhy7w=zZEf9JBWPpgmgH=pWSH5_2hg@mail.gmail.com>
Message-ID: <CAE=gft7S3L9-Hg4CqwhbZhy7w=zZEf9JBWPpgmgH=pWSH5_2hg@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: Add support for v1 of host sleep event
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 8:15 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Wed, Mar 20, 2019 at 2:21 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > Add support in code for the new forms of the host sleep event.
> > Detects the presence of this version of the command at runtime,
> > and use whichever form the EC supports. At this time, always
> > request the default timeout, and only report the failing response
> > via a WARN(). Future versions could accept the sleep parameter
> > from outside the driver, and return the response information to
> > usermode or elsewhere.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > ---
> >
> >  drivers/mfd/cros_ec.c                   | 37 +++++++++++++++++++++----
> >  drivers/platform/chrome/cros_ec_proto.c |  9 ++++++
> >  include/linux/mfd/cros_ec.h             |  2 ++
> >  3 files changed, 43 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> > index 6acfe036d522..5305ea706aa9 100644
> > --- a/drivers/mfd/cros_ec.c
> > +++ b/drivers/mfd/cros_ec.c
> > @@ -75,20 +75,47 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
> >
> >  static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> >  {
> > +       int ret;
> >         struct {
> >                 struct cros_ec_command msg;
> > -               struct ec_params_host_sleep_event req;
> > +               union {
> > +                       struct ec_params_host_sleep_event req0;
> > +                       struct ec_params_host_sleep_event_v1 req1;
> > +                       struct ec_response_host_sleep_event_v1 resp1;
> > +               } u;
> >         } __packed buf;
> >
> >         memset(&buf, 0, sizeof(buf));
> >
> > -       buf.req.sleep_event = sleep_event;
> > +       if (ec_dev->host_sleep_v1) {
> > +               buf.u.req1.sleep_event = sleep_event;
> > +               buf.u.req1.u.suspend_params.sleep_timeout_ms =
> > +                               EC_HOST_SLEEP_TIMEOUT_DEFAULT;
> > +
> > +               buf.msg.outsize = sizeof(buf.u.req1);
> > +               buf.msg.insize = sizeof(buf.u.resp1);
> > +               buf.msg.version = 1;
> > +
> > +       } else {
> > +               buf.u.req0.sleep_event = sleep_event;
> > +               buf.msg.outsize = sizeof(buf.u.req0);
> > +               buf.msg.version = 0;
>
> Unnecessary assignment (already 0).

Ok.

> > +       }
> >
> >         buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
> > -       buf.msg.version = 0;
> > -       buf.msg.outsize = sizeof(buf.req);
> >
> > -       return cros_ec_cmd_xfer(ec_dev, &buf.msg);
> > +       ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
> > +
> > +       /* For now, report failure to transition to S0ix with a warning. */
> > +       if (ret >= 0 && ec_dev->host_sleep_v1 &&
> > +           (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
> > +               WARN(buf.u.resp1.u.resume_response.sleep_transitions &
>
> Is WARN really appropriate here, or would dev_warn() do ?

I think we want to be pretty loud here. This represents a failure to
enter suspend as detected by the EC.

>
> > +                    EC_HOST_RESUME_SLEEP_TIMEOUT,
> > +                    "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
> > +                    buf.u.resp1.u.resume_response.sleep_transitions &
> > +                    EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
> > +
> > +       return ret;
> >  }
> >
> >  int cros_ec_register(struct cros_ec_device *ec_dev)
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index 97a068dff192..78ceab659a36 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -414,6 +414,15 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
> >         else
> >                 ec_dev->mkbp_event_supported = 1;
> >
> > +       /* Probe if host sleep v1 is supported for S0ix failure detection. */
> > +       ret = cros_ec_get_host_command_version_mask(ec_dev,
> > +                                                   EC_CMD_HOST_SLEEP_EVENT,
> > +                                                   &ver_mask);
> > +       if (ret < 0 || !(ver_mask & EC_VER_MASK(1)))
> > +               ec_dev->host_sleep_v1 = 0;
> > +       else
> > +               ec_dev->host_sleep_v1 = 1;
>
> This is a boolean.
>         ec_dev->host_sleep_v1 = (ret >= 0 && (ver_mask & EC_VER_MASK(1)));

Ok.
