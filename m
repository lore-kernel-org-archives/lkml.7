Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0BDCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0271F21D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz/47V9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408803AbfJYJQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:16:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35591 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfJYJQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:16:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id v6so1243750wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LqL/giNmiaN7MjvzLD58EJ8vgYkA2PkROlxY25BcBj0=;
        b=hz/47V9ffmAwEV72alKSS5gIi736wBM4pfyrQiaf4tHCT7AY0ZUt+xpZeuYpSVRCCJ
         4YrOK0XZKNwPQMElY1rOA5IHnph8kq59CvVftwr8XZVOi11I6Ra14Qs0OPvFgVFNZQX3
         P5i4HnWhyNrlgvNeslyFqQm7AdbOLtL6tF3qgvd0hMXE9Sbnbk8AeNeE2sFOb/Mzqbuz
         Q80G0ZrfTuUkXR23+Um9mB9J9xKeVDJqKC0wN1rNf/3OCe27kXdnQZ6XV5FO0ZRXASJG
         y4XMDbx7I1AEuQIwb8EBbNtFZSLjOH5XUuWz5+XUDm3gz5favqlYq4db0SjpIBfQBF0S
         OgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqL/giNmiaN7MjvzLD58EJ8vgYkA2PkROlxY25BcBj0=;
        b=A84i+FVekJRXdtDjEyN9qNQ3VgW6iwG/2uhLIRfjSTDZ3XdV0ViuVgmfsSuhUBm2PR
         WB+wf5wFLkRIA0rGcJ29kJSEKgNdiIguWw8ScQBQrTEfPtlZbvZT800NHFXqkFbA1iPp
         uE1eXHW8/AIxStz28mBrKLv8vrPFHOU2jYjGxVCvfBy3Z/4q37LsnqUVgjvGaXDmPSN0
         Sp0GLrEjJWule9imTZVwkoqV9dxjcl93tdN7Nk7unI9povKpbAT0+7Qz6oyr4Ig43HJy
         bjuKY3Gic74+fxEZ8ymTwrylwtunyUKOc7KZYssdbb2XUcamTEgr6sZUwLK3uQ+ms3fJ
         WqQw==
X-Gm-Message-State: APjAAAWg2lnx3dmAvYIUleM5qn6MSR73+MrR0SU6Of6ppX+gUdylHB39
        0MoIeBra3TT1bEEliYAHKFfsBxx2i/Eq2fXRMCfbO7US
X-Google-Smtp-Source: APXvYqzDzOuefPYKqaMstm3Cj/vQ5UByIxrFzJrmYXD+eZvSfz3cMnMayHcuMMjIrZfl/2xuOJ/xVBDfLEoY9oAy5SI=
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr2295246wmi.123.1571994993205;
 Fri, 25 Oct 2019 02:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191024142939.25920-3-andrey.zhizhikin@leica-geosystems.com> <20191025080655.GF32742@smile.fi.intel.com>
In-Reply-To: <20191025080655.GF32742@smile.fi.intel.com>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Fri, 25 Oct 2019 11:16:22 +0200
Message-ID: <CAHtQpK7P2X42WxZzok+XVZESV7O_JWK3Th7JMnMQsaq6f0gELw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: add regulator cell to Cherry Trail Whiskey Cove PMIC
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 10:07 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 24, 2019 at 02:29:39PM +0000, Andrey Zhizhikin wrote:
> > Add a regulator mfd cell to Whiskey Cove PMIC driver, which is used to
> > supply various voltage rails.
> >
> > In addition, make the initialization of this mfd driver early enough in
> > order to provide regulator cell to mmc sub-system when it is initialized.
>
> Doesn't deferred probe mechanism work for you?
> MMC core returns that error till we have the driver initialized.

This would work for mmc sub-system, but my idea was that later when
more cells are added to this mfd - it might turn out that we would
require an early initialization anyway. So I decided to take an
opportunity to adjust it with this patch as well, and this is what I
roughly explained in the commit message. When I'm reading it now,
exactly this point was not mentioned in commit message at all, and I
rather coupled the early init with mmc sub-system, which creates a
source of confusion here. I guess if there would be no other
objections about early init - I'd go with v2 of this patch, where I
would clean-up the point below and adjust the commit description.

Thanks a lot for pointing this out!

>
> > +     }, {
> > +             .name = "cht_wcove_regulator",
> > +             .id = CHT_WC_REGULATOR_VSDIO + 1,
>
> > +             .num_resources = 0,
> > +             .resources = NULL,
>
> No need to put these.

Agreed, this was forgotten. Sorry for that.

>
> > -static struct i2c_driver cht_wc_driver = {
> > +static struct i2c_driver cht_wc_i2c_driver = {
>
> Renaming is not explained in the commit message.

True, this point I forgot to mention. Actually, this is tightly
coupled with the fact that mfd driver has been moved to an earlier
init stage and since it does belong to I2C sub-system (and represented
by i2c_device structure) - I decided to make a name sound more
logical.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

-- 
Regards,
Andrey.
