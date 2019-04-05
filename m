Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78F8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EA4217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9JUZ0JA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbfDEJ5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:57:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37280 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbfDEJ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:57:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id c1so3441287qkk.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5KJJmiF1Fm9Npp/DopUzpgwkiBqmlbLH2IvCa7WjJ2E=;
        b=d9JUZ0JA1YFJpbyB9Vd5FEbFAPbUaiRo2vtX3VFI0a6rk+O/GeCUVXqq0WgyRcny2D
         uBRszLR9LKWj+o/n1by8zuVlH/E10d0WqDjlJhMhq/8SfRz2Hed/NrqixNJOyoNmXvTG
         NmnlEBkIWk120kt3wq5+wjGrbGW7n2Lgvvx/xud1/NUfkVyY9g9f/OWQPetimHeDc7UX
         VHFCRjP0ps8nXYYdBCenCJheF6aqj4fdTEIG1NlRNwgzrEoNqJm4GyTvF7qC7O6NMLrZ
         90rreXDzAYaflObJh7OqmbAp7b44DTVSiaq+8MAuWZiYFrf35kj/h0hDyWGFOGak93h0
         sMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5KJJmiF1Fm9Npp/DopUzpgwkiBqmlbLH2IvCa7WjJ2E=;
        b=SmDXxOYCLN2+o2brOMdObuF/nWVnKftWuySi0Xu3qLQ8vVOge3AoD/5Jn3rmvhXpw4
         TVkc+cHhGzOWNvj5I1n7TaofvSFLaJflIgQISlhQk3jSRv7dQVvPQSSUP+U0nOrmH/Tq
         a2E4MdsgKbdJNzqWtQMSzFBsMjg0SiHAtZsZkluHgX0gTI2Xd35GB/5ZscwadmhH0OEK
         6QVtbMCWoGI1EbdxuRs+kelwHdDSzxfUdAICXy1FZ/CixS9w8JtMCHNLyb+eu0ilVoB/
         b3k1EY+cmqW3Q0i3HiCgf4d6MYqRIyDFjeUbhswBoyESFr+zyYC1f2MZ3A5WEuSohFhv
         mdNw==
X-Gm-Message-State: APjAAAWmas4Hne763bOTmCHJzmoAsQFGc522YKQlKhx6EcrF2gzClaVS
        IMi5YGRGI0ywqROiCcowlqCbBiaQX3V+bovtwTE=
X-Google-Smtp-Source: APXvYqz6lHLjb1XzwbBZB+8ayiU0u852TZtIWbwAWlmIoc6HxMPG3yjtVYF2RAF/L9wRpf6KGQWvHSbfMeIx78jWpG4=
X-Received: by 2002:a37:7381:: with SMTP id o123mr9075526qkc.96.1554458266367;
 Fri, 05 Apr 2019 02:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190403213428.89920-1-evgreen@chromium.org> <20190403213428.89920-3-evgreen@chromium.org>
 <CACK8Z6Ev-7Yikmdhy89hWuCr-Lj3=ZGaK_eCyrdUzL17dVaCHQ@mail.gmail.com>
In-Reply-To: <CACK8Z6Ev-7Yikmdhy89hWuCr-Lj3=ZGaK_eCyrdUzL17dVaCHQ@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 5 Apr 2019 11:57:35 +0200
Message-ID: <CAFqH_51+vvnAQ0tNgDT=oph0V+hDk+tGu_9RGEQY0oN83NBWxw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] platform/chrome: Add support for v1 of host sleep event
To:     Rajat Jain <rajatja@google.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missatge de Rajat Jain <rajatja@google.com> del dia dj., 4 d=E2=80=99abr. 2=
019
a les 20:41:
>
> On Wed, Apr 3, 2019 at 2:34 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > Add support in code for the new forms of the host sleep event.
> > Detects the presence of this version of the command at runtime,
> > and use whichever form the EC supports. At this time, always
> > request the default timeout, and only report the failing response
> > via a WARN_ONCE(). Future versions could accept the sleep parameter
> > from outside the driver, and return the response information to
> > usermode or elsewhere.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Rajat Jain <rajatja@chromium.org>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

>
> >
> > ---
> >
> > Changes in v3:
> > - Consolidated boolean logic for host_sleep_v1 (Guenter)
> >
> > Changes in v2:
> > - Removed unnecessary version assignment (Guenter)
> > - Changed WARN to WARN_ONCE (Guenter)
> > - Fixed C code to use anonymous unions
> > - insize is only bigger for resume events.
> >
> >  drivers/mfd/cros_ec.c                   | 39 +++++++++++++++++++++----
> >  drivers/platform/chrome/cros_ec_proto.c |  6 ++++

Lee, how do you want to manage this, do you want to create an
immutable branch? Or do you want I do?

Thanks,
 - Enric

> >  include/linux/mfd/cros_ec.h             |  2 ++
> >  3 files changed, 42 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> > index 6acfe036d522..bd2bcdd4718b 100644
> > --- a/drivers/mfd/cros_ec.c
> > +++ b/drivers/mfd/cros_ec.c
> > @@ -75,20 +75,49 @@ static irqreturn_t ec_irq_thread(int irq, void *dat=
a)
> >
> >  static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep=
_event)
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
> > -       buf.req.sleep_event =3D sleep_event;
> > +       if (ec_dev->host_sleep_v1) {
> > +               buf.u.req1.sleep_event =3D sleep_event;
> > +               buf.u.req1.suspend_params.sleep_timeout_ms =3D
> > +                               EC_HOST_SLEEP_TIMEOUT_DEFAULT;
> > +
> > +               buf.msg.outsize =3D sizeof(buf.u.req1);
> > +               if ((sleep_event =3D=3D HOST_SLEEP_EVENT_S3_RESUME) ||
> > +                   (sleep_event =3D=3D HOST_SLEEP_EVENT_S0IX_RESUME))
> > +                       buf.msg.insize =3D sizeof(buf.u.resp1);
> > +
> > +               buf.msg.version =3D 1;
> > +
> > +       } else {
> > +               buf.u.req0.sleep_event =3D sleep_event;
> > +               buf.msg.outsize =3D sizeof(buf.u.req0);
> > +       }
> >
> >         buf.msg.command =3D EC_CMD_HOST_SLEEP_EVENT;
> > -       buf.msg.version =3D 0;
> > -       buf.msg.outsize =3D sizeof(buf.req);
> >
> > -       return cros_ec_cmd_xfer(ec_dev, &buf.msg);
> > +       ret =3D cros_ec_cmd_xfer(ec_dev, &buf.msg);
> > +
> > +       /* For now, report failure to transition to S0ix with a warning=
. */
> > +       if (ret >=3D 0 && ec_dev->host_sleep_v1 &&
> > +           (sleep_event =3D=3D HOST_SLEEP_EVENT_S0IX_RESUME))
> > +               WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions=
 &
> > +                         EC_HOST_RESUME_SLEEP_TIMEOUT,
> > +                         "EC detected sleep transition timeout. Total =
slp_s0 transitions: %d",
> > +                         buf.u.resp1.resume_response.sleep_transitions=
 &
> > +                         EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
> > +
> > +       return ret;
> >  }
> >
> >  int cros_ec_register(struct cros_ec_device *ec_dev)
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform=
/chrome/cros_ec_proto.c
> > index 97a068dff192..52ca564a64e7 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -414,6 +414,12 @@ int cros_ec_query_all(struct cros_ec_device *ec_de=
v)
> >         else
> >                 ec_dev->mkbp_event_supported =3D 1;
> >
> > +       /* Probe if host sleep v1 is supported for S0ix failure detecti=
on. */
> > +       ret =3D cros_ec_get_host_command_version_mask(ec_dev,
> > +                                                   EC_CMD_HOST_SLEEP_E=
VENT,
> > +                                                   &ver_mask);
> > +       ec_dev->host_sleep_v1 =3D (ret >=3D 0 && (ver_mask & EC_VER_MAS=
K(1)));
> > +
> >         /*
> >          * Get host event wake mask, assume all events are wake events
> >          * if unavailable.
> > diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> > index 8f2a8918bfa3..b6442201f77f 100644
> > --- a/include/linux/mfd/cros_ec.h
> > +++ b/include/linux/mfd/cros_ec.h
> > @@ -120,6 +120,7 @@ struct cros_ec_command {
> >   * @pkt_xfer: Send packet to EC and get response.
> >   * @lock: One transaction at a time.
> >   * @mkbp_event_supported: True if this EC supports the MKBP event prot=
ocol.
> > + * @host_sleep_v1: True if this EC supports the sleep v1 command.
> >   * @event_notifier: Interrupt event notifier for transport devices.
> >   * @event_data: Raw payload transferred with the MKBP event.
> >   * @event_size: Size in bytes of the event data.
> > @@ -153,6 +154,7 @@ struct cros_ec_device {
> >                         struct cros_ec_command *msg);
> >         struct mutex lock;
> >         bool mkbp_event_supported;
> > +       bool host_sleep_v1;
> >         struct blocking_notifier_head event_notifier;
> >
> >         struct ec_response_get_next_event_v1 event_data;
> > --
> > 2.20.1
> >
