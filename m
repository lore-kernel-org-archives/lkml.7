Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55555C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F98F217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cWKXmJIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfC2Whz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:37:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45784 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfC2Why (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:37:54 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so3028625iom.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 15:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQnFdxP+GiLo0zBhSKb2tyVIye0h9nlxs6BumbharuI=;
        b=cWKXmJIFOO+x5bdzuCReSPSwHYKtLCNrKeyEiL/1HNYDISzR64raAQkoscdoS2FedM
         unPcgjpmJkBXe0HUXHP/hDe38746P7A5k3E/A9+Rwnk1ReqN+BK7euVgjYTp5Mbw7jEi
         tFoLvFEy0rN077OlIdbrNNI3zPyZ75rXhzu4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQnFdxP+GiLo0zBhSKb2tyVIye0h9nlxs6BumbharuI=;
        b=M/iUZXhYUBAacXU2AUnT0PaEeZYqW1SJpaU8UdXqFWwcnq3TYRv86oaQbfZJBGRAqs
         HBzNFyaK1OZjgLMqdt2zJuuQ1lAuwWxQx8plWnilU/hKKl9PTrc/tQvHULNyxtpHFanG
         Ooa4+IxJAwk5SsZZ7xO6uiNxSsovAJQTC5FwumU2sjJC+mtDzanhUV7DxnQsXMXy5hq7
         1h9Fa+WTt9SWZwyxnnRBvK2NTPtUvGBR6TMGJS1bUVlWWzbuzFe9SDvlAjg6dYKvGLmV
         FEGqrNgC23aVlZhHIWtyyYd3Fr3KqEtXhAq8TTShWYHMnxgiPyAIi96ZHUTysZ/DFLfP
         Q2Mw==
X-Gm-Message-State: APjAAAUclTNg4JmVhnghjo1ri9H4PSv4T3IMYlRNuRpWudH/2miOz1Bv
        NITiXyZ6/aQWqo3uUBtCH3tQMLKuYtYVzLUdvE/v3A==
X-Google-Smtp-Source: APXvYqzfOQLm0Q0q7QDjTcrCYzZBSOEz+f6sP8hPaX5izW7tI/GhFnhixQzx5/kSEYan62R8Vvd/Ld+iPEFihfc3sYI=
X-Received: by 2002:a5d:8b42:: with SMTP id c2mr26948316iot.192.1553899073564;
 Fri, 29 Mar 2019 15:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUE2uskDvefZbt5Ydz8Eu3+Aavu+AzPY5WuAYj0ziYP373oRA@mail.gmail.com>
 <CAPUE2uu5SyVevcWbxc7B6Tf1jTOCmYBgfWsgZJBDLC4xf=rQ_A@mail.gmail.com> <CABXOdTfZNKEEC6a5-L9-cajvavXSk9jSMPU1-YdSYDgFYSjyiw@mail.gmail.com>
In-Reply-To: <CABXOdTfZNKEEC6a5-L9-cajvavXSk9jSMPU1-YdSYDgFYSjyiw@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 29 Mar 2019 15:37:42 -0700
Message-ID: <CAPUE2ut3vNioD-CbmZUqF5Pa3Y8KhBYu+N_SVEEJ5tOsJL6BLA@mail.gmail.com>
Subject: Re: [PATCH v5] iio: cros_ec: Add lid angle driver
To:     Guenter Roeck <groeck@google.com>
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

On Fri, Mar 29, 2019 at 1:17 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Fri, Mar 29, 2019 at 1:08 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Add a IIO driver that reports the angle between the lid and the base for
> > ChromeOS convertible device.
...
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -297,13 +297,15 @@ static void cros_ec_sensors_register(struct
> > cros_ec_dev *ec)
> >
> >         resp = (struct ec_response_motion_sense *)msg->data;
> >         sensor_num = resp->dump.sensor_count;
> > -       /* Allocate 1 extra sensors in FIFO are needed */
> > -       sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
> > +       /*
> > +        * Allocate 2 extra sensors if lid angle sensor and/or FIFO are needed.
> > +        */
> > +       sensor_cells = kcalloc(sensor_num + 2, sizeof(struct mfd_cell),
> >                                GFP_KERNEL);
> >         if (sensor_cells == NULL)
> >                 goto error;
> >
> > -       sensor_platforms = kcalloc(sensor_num + 1,
> > +       sensor_platforms = kcalloc(sensor_num,
>
> I still don't understand why the "+ 1" is no longer needed. It seems
> to me that it would have to change to "+ 2".
"+1" was never needed to begin with FIFO device will never use a
struct cros_ec_sensor_platform. I mentioned it earlier:
https://www.spinics.net/lists/linux-iio/msg43157.html

Gwendal.
>
> Guenter
>
> >                                    sizeof(struct cros_ec_sensor_platform),
> >                                    GFP_KERNEL);
> >         if (sensor_platforms == NULL)
> > @@ -363,6 +365,11 @@ static void cros_ec_sensors_register(struct
> > cros_ec_dev *ec)
> >                 sensor_cells[id].name = "cros-ec-ring";
> >                 id++;
> >         }
> > +       if (cros_ec_check_features(ec,
> > +                               EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> > +               sensor_cells[id].name = "cros-ec-lid-angle";
> > +               id++;
> > +       }
> >
> >         ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
> >                               NULL, 0, NULL);
> > --
> > 2.21.0.360.g471c308f928-goog
