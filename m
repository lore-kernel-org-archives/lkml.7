Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05BCC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7205E2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiQfuvdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfDKPk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:40:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41113 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:40:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id o129so3722391qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9lsZK+fg8QrQe5rlaRvnhW288eucc61zftb6COYu8kA=;
        b=WiQfuvdPQ3fmmPmgu6+WituIM2WrVo7v4toZoeCTpVyyz1beAo2fFpUmw6soiTxaut
         mK2ZcV4PjbjwO6oj26alucoPvcd4O/LCoDSJAwdjJPJYi3EVlcG4OEYmJA+KnundTjIM
         OK11bhw9Oxv9a4/a6kQwf9vWwirxogT4UDrEkZEg4kz65oqBzspArTSogFsc507CCxdT
         yfTTUNNbBM0RQpZZSUd/V/J/WHGtt9LTbAFYB+rNwxiDWDh0Wne8mJpLQrARCBvK7/V/
         i8JLhYNHgzzDDp+C8N/ekkFWntH6nPv6aVO0nqikPYIqtS1Yl/7fGROWUDJq4hnlnkoC
         LWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9lsZK+fg8QrQe5rlaRvnhW288eucc61zftb6COYu8kA=;
        b=AOGHdZj9M9dWRC+3Yr7Co39BHi+rXz5V1vyEnSNpuWWlOAv5OeEdS71lU9Ftd0xv+/
         fsaQbThLZ6AMrLI4gGLsVA7y3xvUB9Ud5lz+b5m/p8pv/PgKAz5pDzIvSx1LxIiqhcLk
         Vbt3cNG6MMU9bquTJqxYcszmjMp2QWD1agmyBwELorp8ukJA3rqWJVWHu9VYWhajHxnG
         JOgxHPqLP0zNPESRlGPBRwHf5wSFncV7deKseuGX7UQFl9NifziQbBd6WMIQpEuQ6ow6
         N+E/gxUwcVS/0DYzuRplNSDSRzUNi79ylGeyb7ociwV2caxO8oBn38oyCyOPgZVbh9gM
         oX+A==
X-Gm-Message-State: APjAAAXp2M+HVDlFyohPsgiHe2koAje4Eax++0TcYKZLuyx3joOlVVmg
        owhMZftZOZo7XUiCKsA7Ywzx5H9yJIhKiN/DsNw=
X-Google-Smtp-Source: APXvYqw03+fErRk3PH82WRl4wcYYNpqkimjknc1ftZgK866EY57k+aGMknjzBR8o/CUowHObGy6UUWtqDmu2UocPzAA=
X-Received: by 2002:a37:7381:: with SMTP id o123mr37898715qkc.96.1554997223582;
 Thu, 11 Apr 2019 08:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190403135123.8723-1-enric.balletbo@collabora.com> <CABXOdTe3sYq2bKPEajHu9LzMLXhEbABQAAGc8OfcYU3Z9LY7xQ@mail.gmail.com>
In-Reply-To: <CABXOdTe3sYq2bKPEajHu9LzMLXhEbABQAAGc8OfcYU3Z9LY7xQ@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 11 Apr 2019 17:40:12 +0200
Message-ID: <CAFqH_52r_uL2BARRnTdKAxtnTwKsnQRE7T3QSH+pEp7bgKNrpA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Also return invalid
 command in cros_ec_cmd_xfer_status
To:     Guenter Roeck <groeck@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Missatge de Guenter Roeck <groeck@google.com> del dia dc., 3 d=E2=80=99abr.
2019 a les 18:27:
>
> On Wed, Apr 3, 2019 at 6:51 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > The commit 9798ac6d32c1 ("mfd: cros_ec: Add cros_ec_cmd_xfer_status()
> > helper") was introduced to remove duplicated code in several users of
> > the cros_ec_cmd_xfer function. The idea behind that commit is mask all
> > the EC errors as protocol error when the EC command fails, what is
> > really useful because as a user you probably don't care of the exact
> > error reported by the EC, you only want to know if the command succeede=
d
> > or not.
> >
> > That works for most of the errors returned by the EC, but we might be
> > also interested on report the EC_RES_INVALID_COMMAND, which happens whe=
n
> > the command is not supported by the EC. An use case for this is when yo=
u
> > need to show/hide a sysfs attribute for a specific command and you don'=
t
> > have a EC feature flag that tells you that the command is supported or
> > not.
> >

Actually, I discarded this patch, I assumed wrongly that this patch
will avoid some boilerplate on the above cases but that's not true
because there is no difference between check that ret =3D=3D -EINVAL or
check that msg->result =3D=3D EC_RES_INVALID_COMMAND.

> > While here, also document properly the cros_ec_cmd_xfer_status
> > function.
> >

Also, this function was properly documented in the header, so that is
not needed, my bad.

Thanks,
 Enric

> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
>
> > ---
> >
> >  drivers/platform/chrome/cros_ec_proto.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform=
/chrome/cros_ec_proto.c
> > index 97a068dff192..a4e0d3a6d891 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -478,6 +478,16 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev=
,
> >  }
> >  EXPORT_SYMBOL(cros_ec_cmd_xfer);
> >
> > +/**
> > + * cros_ec_cmd_xfer_status() - Send EC command.
> > + * @ec_dev: EC device.
> > + * @msg: EC message data for request and response.
> > + *
> > + * Return:
> > + * 0 - OK
> > + * -EINVAL - Invalid command.
> > + * -EPROTO - Protocol error.
> > + */
> >  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >                             struct cros_ec_command *msg)
> >  {
> > @@ -486,6 +496,11 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device =
*ec_dev,
> >         ret =3D cros_ec_cmd_xfer(ec_dev, msg);
> >         if (ret < 0) {
> >                 dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", r=
et);
> > +       } else if (msg->result =3D=3D EC_RES_INVALID_COMMAND) {
> > +               dev_dbg(ec_dev->dev,
> > +                       "Command %d not supported for this device\n",
> > +                       msg->command);
> > +               return -EINVAL;
> >         } else if (msg->result !=3D EC_RES_SUCCESS) {
> >                 dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg-=
>result);
> >                 return -EPROTO;
> > --
> > 2.20.1
> >
