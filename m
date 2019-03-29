Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAFDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FF92173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nY8WajU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfC2Xil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:38:41 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44960 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbfC2Xik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 19:38:40 -0400
Received: by mail-yw1-f66.google.com with SMTP id c4so1276996ywa.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 16:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nnb+XafWAfVJKrtndiqrDclyjb/IXt0OS6W78ORcL2A=;
        b=nY8WajU8pkkwTnMD8LB4tCEhJK8DkLrd6equEWp/Z8XEl+7K/xoMGti7j0FNHard5+
         ibnxfKGpFEdg56y8XekMkUkxQVItgRZYQtOIBoKob1yP2OosGGoVPplwM/LyU+274GMj
         fj9ERu5dt7KxuTJwl2sKD96vIqN8GodL+Ilb98tjBFHzrR3lY9ES1gkIX9k8WQk/dkIM
         v6hIJyWbsR5l0DyJFpFWswclCs9yHJFMb9gyNRQMpptRpWgyD2EMJiXhIh5HXVUHSiki
         I8XxfW5GMXFgA6wHcUlukOdoGDo0ihnN45STmBs6kV3hKZF3C8arcM6bBcIPGi9m+Kaj
         K/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nnb+XafWAfVJKrtndiqrDclyjb/IXt0OS6W78ORcL2A=;
        b=KgvTrFc3980UTJKM8Jd7Sd1smIyBAkfm5lps2CJ9bq0ZhFF28r7y6dQbmOX9R3B90/
         plPtbwNEFJuC+kwpuy99likyEcNlllWjZiN59SRYvO3NMDulNeRHXKdp9BvdY+2H18jw
         bLuuPXiRO7RNe4VYsCwDv8aOnjBkA0XdEctDZWDIrUGpshJiDZIwW7n2PUWUBH9mP631
         daunOQe2xh1YY20RvTGJQtkN/Pdtq6SQSkth9j3r+IhiVOYXKB0c0sbBNPBA2RbgwiV/
         UTMEu3im2us73lOiztjmICjr/Rkr2kFRPNchVgU28Oa7E0aPuyGbTdhOemSOcSVh4PH4
         AAew==
X-Gm-Message-State: APjAAAWvmWGwoZtRg1FSa6Tfs7YXva+ZhxKTGRV7wdv4v7Ecu3/RfxM6
        nysaRJUAjGriwDq8uy4oUjXpsENLabau0nNkiM1cxA==
X-Google-Smtp-Source: APXvYqwFESLtmgIfyHZ3sOQOYxP91zRwUR2WKFmi5qJPWcSCcLDZ/yZWVSyYqe46cmamYO17aRyIX1PgYlyAeZt4F2Y=
X-Received: by 2002:a81:3d17:: with SMTP id k23mr43729341ywa.266.1553902719933;
 Fri, 29 Mar 2019 16:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUE2uskDvefZbt5Ydz8Eu3+Aavu+AzPY5WuAYj0ziYP373oRA@mail.gmail.com>
 <CAPUE2uu5SyVevcWbxc7B6Tf1jTOCmYBgfWsgZJBDLC4xf=rQ_A@mail.gmail.com>
 <CABXOdTfZNKEEC6a5-L9-cajvavXSk9jSMPU1-YdSYDgFYSjyiw@mail.gmail.com> <CAPUE2ut3vNioD-CbmZUqF5Pa3Y8KhBYu+N_SVEEJ5tOsJL6BLA@mail.gmail.com>
In-Reply-To: <CAPUE2ut3vNioD-CbmZUqF5Pa3Y8KhBYu+N_SVEEJ5tOsJL6BLA@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 29 Mar 2019 16:38:28 -0700
Message-ID: <CABXOdTfyj7Fi6HxEbsTSRjymhB73=_UNkHeKS2a-GhGHa7PvcQ@mail.gmail.com>
Subject: Re: [PATCH v5] iio: cros_ec: Add lid angle driver
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 3:37 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> On Fri, Mar 29, 2019 at 1:17 PM Guenter Roeck <groeck@google.com> wrote:
> >
> > On Fri, Mar 29, 2019 at 1:08 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> > >
> > > Add a IIO driver that reports the angle between the lid and the base for
> > > ChromeOS convertible device.
> ...
> > > --- a/drivers/mfd/cros_ec_dev.c
> > > +++ b/drivers/mfd/cros_ec_dev.c
> > > @@ -297,13 +297,15 @@ static void cros_ec_sensors_register(struct
> > > cros_ec_dev *ec)
> > >
> > >         resp = (struct ec_response_motion_sense *)msg->data;
> > >         sensor_num = resp->dump.sensor_count;
> > > -       /* Allocate 1 extra sensors in FIFO are needed */
> > > -       sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
> > > +       /*
> > > +        * Allocate 2 extra sensors if lid angle sensor and/or FIFO are needed.
> > > +        */
> > > +       sensor_cells = kcalloc(sensor_num + 2, sizeof(struct mfd_cell),
> > >                                GFP_KERNEL);
> > >         if (sensor_cells == NULL)
> > >                 goto error;
> > >
> > > -       sensor_platforms = kcalloc(sensor_num + 1,
> > > +       sensor_platforms = kcalloc(sensor_num,
> >
> > I still don't understand why the "+ 1" is no longer needed. It seems
> > to me that it would have to change to "+ 2".
> "+1" was never needed to begin with FIFO device will never use a
> struct cros_ec_sensor_platform. I mentioned it earlier:
> https://www.spinics.net/lists/linux-iio/msg43157.html
>
Ah yes, now I see. Thanks, and sorry for the noise.

Guenter

> Gwendal.
> >
> > Guenter
> >
> > >                                    sizeof(struct cros_ec_sensor_platform),
> > >                                    GFP_KERNEL);
> > >         if (sensor_platforms == NULL)
> > > @@ -363,6 +365,11 @@ static void cros_ec_sensors_register(struct
> > > cros_ec_dev *ec)
> > >                 sensor_cells[id].name = "cros-ec-ring";
> > >                 id++;
> > >         }
> > > +       if (cros_ec_check_features(ec,
> > > +                               EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> > > +               sensor_cells[id].name = "cros-ec-lid-angle";
> > > +               id++;
> > > +       }
> > >
> > >         ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
> > >                               NULL, 0, NULL);
> > > --
> > > 2.21.0.360.g471c308f928-goog
