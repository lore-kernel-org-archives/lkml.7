Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BCAC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C912084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3NtVl0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfDKK2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:28:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46728 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDKK2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:28:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id s81so3077076qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=grdc76U9tDNbOgB+7NdKk/TMxPFcXxSaUorB6uoVnUA=;
        b=J3NtVl0WurflsV8IDr2rfNvAox03n3YYyVnLeI8teywRGSYuHnX9CKwMJXkca1T/ga
         sIbBbPhK9nZfkO5hM2pQWnWV1a3mOPtp5UVJbE+Ey2iPNYFzRs26qbtgxEo8gzn4RKfv
         aBGRh69m3t2Qv5xDPUYFcoGcY7e6Od4/vxuG6+QjDl1glJZ1w9+KVQluf4H70mxRSbVE
         i5OFugnjhuEmA9hBMPd1gHaVWO61XtOj2UuKFOopU2JifeEMQeNXQBc+mfFKNsNpfhnH
         Xu0QzFu8Zw+0ARMuD7ckh/RmPMuHzo3lNOQ7qK74qfK8ALb4Z8MOmLUbFd0iZNL3uFLi
         1QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=grdc76U9tDNbOgB+7NdKk/TMxPFcXxSaUorB6uoVnUA=;
        b=YLUu7ufZeD2sXLQdfUMWpmsQ/rmprsJN82B85MXJTO+NZjaiT6f2QDGURrPbX4aVsT
         KsDkIKHWO/+ql7mhBSkL34eN8l3PelJtF43D61zh3EA2z7oMf6u0n8CduNvAlHSR23JT
         xLwGPcgl7pfpT2/JrwLypoCqXMQTVWW468LSmts/H+MD87BHiAoj4FGLg1XNxZ1v5Z8z
         phjM9wYnIlTlpNpu0WctLxJ0QvtWnh4nbAEDKhJp4MrIPe/O6BQwgCB9Dwrb1VPJ6Ump
         jb9VZvH6OEf3eJmi2VHpxqcwCvecqcj+BuHavqzJLdOcNP4kwN20WxUpPKX8SRgk8yXM
         8Jpg==
X-Gm-Message-State: APjAAAXGTaiCL2+x6juiphwo9QU0PUqsGPIoeZreyKygM21FdzkrQb64
        unUPclD80ei56v2KmlXRBq2YwIDpFX1o5rNdKzc=
X-Google-Smtp-Source: APXvYqwJyM7+o+Rsfj89I4izFbDmn4xBiJkwh6h+ig1/cg6ofeDEe1mp0AXans0cAvYlyErlXo5nYeeWyHXtkl0xrsA=
X-Received: by 2002:a37:a4d6:: with SMTP id n205mr38533211qke.234.1554978479414;
 Thu, 11 Apr 2019 03:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190327051450.16222-1-pihsun@chromium.org> <20190327051450.16222-7-pihsun@chromium.org>
 <CAFqH_51BYkGW_jma-WpE5tsJs=daXDZB1dD6RYCErZ64RNuyTQ@mail.gmail.com> <CANdKZ0ec_aux+tWatB563LJEmOt=RVJb5wH5eknQh6u1NraAqg@mail.gmail.com>
In-Reply-To: <CANdKZ0ec_aux+tWatB563LJEmOt=RVJb5wH5eknQh6u1NraAqg@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 11 Apr 2019 12:27:47 +0200
Message-ID: <CAFqH_52DaLP98woJM_Kj9AZkxZZ48MVpck0cXrHLPSxnFUX_2w@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] platform/chrome: cros_ec: add EC host command
 support using rpmsg.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Missatge de Pi-Hsun Shih <pihsun@chromium.org> del dia dc., 10 d=E2=80=99ab=
r.
2019 a les 9:13:
>
> Hi,
>
> On Thu, Mar 28, 2019 at 7:16 PM Enric Balletbo Serra
> <eballetbo@gmail.com> wrote:
> >
> > Hi
> >
> > Thanks for sending this upstream, Some few comments and questions
> > below. Apart from these LGTM.
> >
> > Missatge de Peter Shih <pihsun@chromium.org> del dia dc., 27 de mar=C3=
=A7
> > 2019 a les 6:17:
> > >
> > > From: Pi-Hsun Shih <pihsun@chromium.org>
> > >
> > > Add EC host command support through rpmsg.
> > >
> > > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> > > ---
> > > ...
> > > diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platfo=
rm/chrome/cros_ec_rpmsg.c
> > > new file mode 100644
> > > index 000000000000..2ecae806cfc5
> > > --- /dev/null
> > > +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> > > ...
> > > +static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *=
data,
> > > +                                 int len, void *priv, u32 src)
> > > +{
> > > +       struct cros_ec_device *ec_dev =3D dev_get_drvdata(&rpdev->dev=
);
> > > +       struct cros_ec_rpmsg *ec_rpmsg =3D ec_dev->priv;
> > > +       struct cros_ec_rpmsg_response *resp;
> > > +
> > > +       if (!len) {
> > > +               dev_warn(ec_dev->dev, "rpmsg received empty response"=
);
> >
> > Is this is unlikely to happen?
>
> Yes this should not happen unless the firmware is broken. Should I
> change this to `if(unlikely(!len))`, or use dev_err instead ?
>
> >
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       resp =3D data;
> > > +       len -=3D offsetof(struct cros_ec_rpmsg_response, data);
> > > +       if (resp->type =3D=3D HOST_COMMAND_MARK) {
> > > +               if (len > ec_dev->din_size) {
> > > +                       dev_warn(
> > > +                               ec_dev->dev,
> > > +                               "received length %d > din_size %d, tr=
uncating",
> > > +                               len, ec_dev->din_size);
> >
> > How often this warning appears? Should be this a dev_dbg?
>
> This also should not happen unless the firmware is broken, so I think
> it's better to have a warning here when there's something wrong.
>

Ok, fine with me.

> >
> > > +                       len =3D ec_dev->din_size;
> > > +               }
> > > +
> > > +               memcpy(ec_dev->din, resp->data, len);
> > > +               complete(&ec_rpmsg->xfer_ack);
> > > +       } else if (resp->type =3D=3D HOST_EVENT_MARK) {
> > > +               schedule_work(&ec_rpmsg->host_event_work);
> > > +       } else {
> > > +               dev_warn(ec_dev->dev, "rpmsg received invalid type =
=3D %d",
> > > +                        resp->type);
> >
> > Is this is unlikely to happen?
>
> Same as above, this should not happen unless the firmware is broken.
>
> >
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
> > > +{
> > > +       struct device *dev =3D &rpdev->dev;
> > > +       struct cros_ec_device *ec_dev;
> > > +       struct cros_ec_rpmsg *ec_rpmsg;
> > > +       int ret;
> > > +
> > > +       ec_dev =3D devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
> > > +       if (!ec_dev)
> > > +               return -ENOMEM;
> > > +
> > > +       ec_rpmsg =3D devm_kzalloc(dev, sizeof(*ec_rpmsg), GFP_KERNEL)=
;
> > > +       if (!ec_rpmsg)
> > > +               return -ENOMEM;
> > > +
> > > +       ec_dev->dev =3D dev;
> > > +       ec_dev->priv =3D ec_rpmsg;
> > > +       ec_dev->cmd_xfer =3D cros_ec_cmd_xfer_rpmsg;
> > > +       ec_dev->pkt_xfer =3D cros_ec_pkt_xfer_rpmsg;
> > > +       ec_dev->phys_name =3D dev_name(&rpdev->dev);
> > > +       ec_dev->din_size =3D sizeof(struct ec_host_response) +
> > > +                          sizeof(struct ec_response_get_protocol_inf=
o);
> > > +       ec_dev->dout_size =3D sizeof(struct ec_host_request);
> > > +       dev_set_drvdata(dev, ec_dev);
> > > +
> > > +       ec_rpmsg->rpdev =3D rpdev;
> > > +       init_completion(&ec_rpmsg->xfer_ack);
> > > +       INIT_WORK(&ec_rpmsg->host_event_work,
> > > +                 cros_ec_rpmsg_host_event_function);
> > > +
> > > +       ret =3D cros_ec_register(ec_dev);
> > > +       if (ret) {
> > > +               dev_err(dev, "cannot register EC\n");
> > > +               return ret;
> > > +       }
> > > +
> > > +       return 0;
> >
> > cros_ec_register returns 0 on success and prints an error message if
> > something went wrong. Remove the above and just do:
> >
> > return cros_ec_register(ec_dev);
> >
>
> Ack, would change this in v7.
>

Will wait for v7.

Thanks,
 Enric

> >
> > > +}
> > > +
> > > +static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
> > > +{
> > > +       struct cros_ec_device *ec_dev =3D dev_get_drvdata(&rpdev->dev=
);
> > > +       struct cros_ec_rpmsg *ec_rpmsg =3D ec_dev->priv;
> > > +
> > > +       cancel_work_sync(&ec_rpmsg->host_event_work);
> > > +}
> > > +
> > > +static const struct of_device_id cros_ec_rpmsg_of_match[] =3D {
> > > +       { .compatible =3D "google,cros-ec-rpmsg", },
> > > +       { }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, cros_ec_rpmsg_of_match);
> > > +
> > > +static struct rpmsg_driver cros_ec_driver_rpmsg =3D {
> > > +       .drv =3D {
> > > +               .name   =3D KBUILD_MODNAME,
> > > +               .of_match_table =3D cros_ec_rpmsg_of_match,
> > > +       },
> > > +       .probe          =3D cros_ec_rpmsg_probe,
> > > +       .remove         =3D cros_ec_rpmsg_remove,
> > > +       .callback       =3D cros_ec_rpmsg_callback,
> > > +};
> > > +
> > > +module_rpmsg_driver(cros_ec_driver_rpmsg);
> > > +
> > > +MODULE_LICENSE("GPL v2");
> > > +MODULE_DESCRIPTION("ChromeOS EC multi function device (rpmsg)");
> > > --
> > > 2.21.0.392.gf8f6787159e-goog
> > >
