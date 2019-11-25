Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D5BC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E372071E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EblvNfcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfKYTiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 14:38:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35104 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKYTix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 14:38:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id r16so13880286edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 11:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=djEAfYHreXKtPBDNkFF0syVNOskqLgoPYGB55xHve3U=;
        b=EblvNfcAHkVrVcIa52iC9sAg7eSYwWrAe2+R+DWbqwdY9a+6FpI7rAEI9E89d6uMQw
         PUueHUYpOOYfvgLu1Yn1/5xHVONiJI9kzrfSZdEOgYaMZZLR/f3IuiXBt5pPN2+KDucu
         BfquVNrw39/qyxNAIZDz42pFa7ykBBU8DBVXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djEAfYHreXKtPBDNkFF0syVNOskqLgoPYGB55xHve3U=;
        b=aYn0bcyzWs9VZOQJXLf+YwAvriu5tpgMlHnN4k4CV34k16s4kWOjNzye3t5rALQMdm
         x/73Bp5PI26gjgvfLZoae2I4cKIRj7+cDiV6biE2lyU2xJkjxU47zLO6WV0cuIwfgQ2U
         2FF+ixkNSO/FeE8Oq0e7LdDV8lBZPC7QomZt85uuMDDafljCONaxVVAddP36D2SuXg09
         FBtNDgAnngOVfFqyXn1TaGpNkPXL4uk4KXw1NmoOsAqQQTdl5gWGQOMChzA2spNBkapz
         u84VV0eOu8jSJmDcUYsjFxdAsNeyz3kpl1EXlYYBA+3noouc6DSVrzuSNXNdnqZK/4Hy
         gbhw==
X-Gm-Message-State: APjAAAXm2a6B4ayfVAic1nkmevct0NLuYarG1bceDMB0xpZ7yhuw27DG
        z6Hr9CVL0wQ8lRmyTgYfprb5rstPxSQ=
X-Google-Smtp-Source: APXvYqyWvPCwCWhllbWGE4Kw8N6/WOUn6e298wFOcMaWG45sZNMl9kg0bp7/ZJHZ5Sql3iD2gTSQWQ==
X-Received: by 2002:a17:906:1354:: with SMTP id x20mr39704599ejb.131.1574710730937;
        Mon, 25 Nov 2019 11:38:50 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id r22sm314855edt.47.2019.11.25.11.38.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 11:38:49 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id a15so19628004wrf.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 11:38:48 -0800 (PST)
X-Received: by 2002:adf:9185:: with SMTP id 5mr34386955wri.389.1574710728150;
 Mon, 25 Nov 2019 11:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20191121211053.48861-1-rrangel@chromium.org> <20191121140830.4.Iddc7dd74f893297cb932e9825d413e7890633b3d@changeid>
 <f8645254-ce59-3d3e-0f82-975f9e283a9c@collabora.com>
In-Reply-To: <f8645254-ce59-3d3e-0f82-975f9e283a9c@collabora.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 25 Nov 2019 12:38:36 -0700
X-Gmail-Original-Message-ID: <CAHQZ30ALXjfnpvbqRrVw6q3jk5C-3g6vRWCQP7cwOxr5kBEk7g@mail.gmail.com>
Message-ID: <CAHQZ30ALXjfnpvbqRrVw6q3jk5C-3g6vRWCQP7cwOxr5kBEk7g@mail.gmail.com>
Subject: Re: [PATCH 4/4] platform/chrome: i2c: i2c-cros-ec-tunnel: Convert i2c
 tunnel to MFD Cell
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        Guenter Roeck <groeck@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +     if (!ec) {
> > +             dev_err(dev, "%s: ec is missing!\n", __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!ec->ec_dev) {
> > +             dev_err(dev, "%s: ec->ec_dev is missing!\n", __func__);
> > +             return -EINVAL;
> > +     }
> > +
>
> Are those checks needed? Is that possible?
I don't think it's possible anymore now that the driver has been
converted into an MFD Cell. Previously it would panic if the
i2c-cros-ec-tunnel was compiled as a built-in because it could be
probed before the cros_ec. If the i2c-cros-ec-tunnel was compiled as a
module it worked as expected. So this patch really just fixes the race
condition on initialization.

[    3.733397] BUG: kernel NULL pointer dereference, address: 0000000000000060
...
[    3.734358] RIP: 0010:ec_i2c_probe+0x2f/0x158
0xffffffff81834990 is in ec_i2c_probe
(/mnt/host/source/src/third_party/kernel/next/drivers/i2c/busses/i2c-cros-ec-tunnel.c:250).
245             struct device *dev = &pdev->dev;
246             struct ec_i2c_device *bus = NULL;
247             u32 remote_bus;
248             int err;
249
250             if (!ec->cmd_xfer) {
251                     dev_err(dev, "Missing sendrecv\n");
252                     return -EINVAL;
253             }
254

If you want, I can remove them. But I also don't think they hurt
anything either.

> > -static const struct of_device_id cros_ec_i2c_of_match[] = {
> > -     { .compatible = "google,cros-ec-i2c-tunnel" },
> > -     {},
> > -};
> > -MODULE_DEVICE_TABLE(of, cros_ec_i2c_of_match);
> > -
> > -static const struct acpi_device_id cros_ec_i2c_tunnel_acpi_id[] = {
> > -     { "GOOG0012", 0 },
>
> So, you're removing something that you just added in a previous patch. So is
> really the change in the previous patch needed?

The previous patch also switched over to using
device_property_read_u32, so it's still needed.

> > -     { }
> > -};
> > -MODULE_DEVICE_TABLE(acpi, cros_ec_i2c_tunnel_acpi_id);
> > -
> >  static struct platform_driver ec_i2c_tunnel_driver = {
> >       .probe = ec_i2c_probe,
> >       .remove = ec_i2c_remove,
> >       .driver = {
> >               .name = "cros-ec-i2c-tunnel",
> > -             .acpi_match_table = ACPI_PTR(cros_ec_i2c_tunnel_acpi_id),
> > -             .of_match_table = of_match_ptr(cros_ec_i2c_of_match),
>
> I don't understand this change, why? The id should be in the driver to match.

I removed it here because I want the driver to enumerate as an MFD
cell instead of a stand alone driver.

> >       },
> >  };
> >
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index 1efdba18f20b..61b20e061f75 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -113,6 +113,18 @@ static const struct mfd_cell cros_ec_vbc_cells[] = {
> >       { .name = "cros-ec-vbc", }
> >  };
> >
> > +static struct mfd_cell_acpi_match cros_ec_i2c_tunnel_acpi_match = {
> > +     .pnpid = "GOOG0012"
> > +};
> > +
> > +static struct mfd_cell cros_ec_fw_cells[] = {
> > +     {
> > +             .name = "cros-ec-i2c-tunnel",
> > +             .acpi_match = &cros_ec_i2c_tunnel_acpi_match,
> > +             .of_compatible = "google,cros-ec-i2c-tunnel"
>
> Ah, I see. The acpi_match and the of_compatible should be in the
> i2c-cros-ec-tunnel driver not here. Why you changed? Didn't work?

The cell needs to be the one that defines the ACPI match so the MFD
can find the node and set the parent correctly.

>
> > +     },
> > +};
> > +
> >  int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> >  {
> >       struct cros_ec_command *msg;
> > @@ -485,6 +497,13 @@ static int ec_device_probe(struct platform_device *pdev)
> >                        "failed to add cros-ec platform devices: %d\n",
> >                        retval);
> >
> > +     retval = mfd_add_hotplug_devices(ec->dev, cros_ec_fw_cells,
> > +                                      ARRAY_SIZE(cros_ec_fw_cells));
> > +     if (retval)
> > +             dev_warn(ec->dev,
> > +                      "failed to add cros-ec fw platform devices: %d\n",
> > +                      retval);
> > +
>
> I think this should go inside the cros_ec_platform_cells, so drop this and
> add the "cros-ec-i2c-tunnel" in the cros_ec_platform_cells[] table is enough.

Good idea. I'll do that.

Thanks
