Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D935DECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC57F20684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kDOH59OZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfJGN7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:59:10 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34441 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfJGN7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:59:09 -0400
Received: by mail-vs1-f66.google.com with SMTP id d3so8968930vsr.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ctSXe3Qibn7SwlKCbsSDIKSVJbFoB8K7abxEy4a8a2Y=;
        b=kDOH59OZ6r1FcPSXe+JGbtRsP2+75ns0l5OY5gHErPOOKope1DPRHLXTxUrkcPgf6z
         bLCUrMwDkb0U8f1EbVgdAYQXz+IY/WPdw2QVF8FpuYOIqlo3/g+rPGykW5dJExYIIRbs
         gBiPr5yJigX15w4y1wtSGnsdBzV6QSQO13RXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctSXe3Qibn7SwlKCbsSDIKSVJbFoB8K7abxEy4a8a2Y=;
        b=LmxdHFGVFTspgs4SilsqH7/d/YIurZ0t0FaKidyZWx7zpX0ZiVVznM+gu53PKNw29A
         zAJw5Bd34tVrzSa3vDKovlfC3Unqq4LmbaJrUxNrdZCUCXsyhGjTDDagBLJ5H6/lbyGB
         Rr70TUEk/P0uZg2k7Ji0Q9NoJ7/pTyWaIi953X4ahNu3ZPNxUOeuCRCIKYwohp8J71cN
         8eBCJ7jxmOutM+X+YKmQrrYwPLNvi5Xs9M2JxTWWMgssBsbkF3oFlZGwZYQAE8uRVA6r
         TBk07WValOtLtpLYzUJufeLyFw1YaQv2LW6V6fUh/k+BqNx4i48OGsq7yhX8FyzawlgV
         pdjQ==
X-Gm-Message-State: APjAAAXgXtR9ixU+6y9w6H4WUdFsfRcX5XHW1bByNP3exbE4lQn+2Y38
        4rvc5AUSS1WytzKuCawKpB3G3Z8x1YYEdr2kzpQzzg==
X-Google-Smtp-Source: APXvYqzvEfSO3HqKvInVixjThDGPwl6gp+QVYjOFJmfDBQtcYmmYhlgtXAGem4GcilN/j4BZcMBegIbfRsM/k/N7jPA=
X-Received: by 2002:a67:2b86:: with SMTP id r128mr15828347vsr.119.1570456748312;
 Mon, 07 Oct 2019 06:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191007071610.65714-1-cychiang@chromium.org> <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com>
 <ebf9bc3f-a531-6c5b-a146-d80fe6c5d772@roeck-us.net>
In-Reply-To: <ebf9bc3f-a531-6c5b-a146-d80fe6c5d772@roeck-us.net>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Mon, 7 Oct 2019 21:58:41 +0800
Message-ID: <CAFv8NwLuYKHJoG9YR3WvofwiMnXCgYv-Sk7t5jCvTZbST+Ctjw@mail.gmail.com>
Subject: Re: [PATCH] firmware: vpd: Add an interface to read VPD value
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Hung-Te Lin <hungte@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 8:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/7/19 1:03 AM, Tzung-Bi Shih wrote:
> > On Mon, Oct 7, 2019 at 3:16 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> >>
> >> Add an interface for other driver to query VPD value.
> >> This will be used for ASoC machine driver to query calibration
> >> data stored in VPD for smart amplifier speaker resistor
> >> calibration.
> >>
> >> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> >> ---
> >>   drivers/firmware/google/vpd.c              | 16 ++++++++++++++++
> >>   include/linux/firmware/google/google_vpd.h | 18 ++++++++++++++++++
> >>   2 files changed, 34 insertions(+)
> >>   create mode 100644 include/linux/firmware/google/google_vpd.h
> >>
> >> diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
> >> index db0812263d46..71e9d2da63be 100644
> >> --- a/drivers/firmware/google/vpd.c
> >> +++ b/drivers/firmware/google/vpd.c
> >> @@ -65,6 +65,22 @@ static ssize_t vpd_attrib_read(struct file *filp, struct kobject *kobp,
> >>                                         info->bin_attr.size);
> >>   }
> >>
> >> +int vpd_attribute_read_value(bool ro, const char *key,
> >> +                            char **value, u32 value_len)
>
> FWIW, I don't think the "_value" in this function name adds any value,
> unless there is going to be some other read function.
ACK
>
> The API should be documented, and state clearly that the caller must release
> the returned value.
ACK
>
> >> +{
> >> +       struct vpd_attrib_info *info;
> >> +       struct vpd_section *sec = ro ? &ro_vpd : &rw_vpd;
> >> +
> >> +       list_for_each_entry(info, &sec->attribs, list) {
> >> +               if (strcmp(info->key, key) == 0) {
> >> +                       *value = kstrndup(info->value, value_len, GFP_KERNEL);
> >
> > Value is not necessary a NULL-terminated string.
> > kmalloc(info->bin_attr.size) and memcpy(...) would make the most
> > sense.
> >
> kmemdup() ?
ACK
>
> > The value_len parameter makes less sense.  It seems the caller knows
> > the length of the value in advance.
> > Suggest to change the value_len to report the length of value.  I.e.
> > *value_len = info->bin_attr.size;
> >  > Also please check the return value for memory allocation-like
> > functions (e.g. kstrndup, kmalloc) so that *value won't be NULL but
> > the function returned 0.
> >
> >> +                       return 0;
> >> +               }
> >> +       }
> >> +       return -EINVAL;
>
> Maybe something like -ENOENT would be more appropriate here.
>
ACK
> >> +}
> >> +EXPORT_SYMBOL(vpd_attribute_read_value);
> >> +
>
> I would suggest to use EXPORT_SYMBOL_GPL().
>
ACK

Hi Guenter,
Thanks for the quick review.
I'll update accordingly in v2.

> >>   /*
> >>    * vpd_section_check_key_name()
> >>    *
> >> diff --git a/include/linux/firmware/google/google_vpd.h b/include/linux/firmware/google/google_vpd.h
> >> new file mode 100644
> >> index 000000000000..6f1160f28af8
> >> --- /dev/null
> >> +++ b/include/linux/firmware/google/google_vpd.h
> >> @@ -0,0 +1,18 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Google VPD interface.
> >> + *
> >> + * Copyright 2019 Google Inc.
> >> + */
> >> +
> >> +/* Interface for reading VPD value on Chrome platform. */
> >> +
> >> +#ifndef __GOOGLE_VPD_H
> >> +#define __GOOGLE_VPD_H
> >> +
> >> +#include <linux/types.h>
> >> +
> >> +int vpd_attribute_read_value(bool ro, const char *key,
> >> +                            char **value, u32 value_len);
> >> +
> >> +#endif  /* __GOOGLE_VPD_H */
> >> --
> >> 2.23.0.581.g78d2f28ef7-goog
> >>
> >
>
