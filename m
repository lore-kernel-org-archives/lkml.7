Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B23C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1634A2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cX/5/YR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfJGIxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:53:10 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43513 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfJGIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:53:10 -0400
Received: by mail-vs1-f68.google.com with SMTP id b1so8346024vsr.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 01:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XziM4hA4Gmod9STm0oZGOi/d+jlnR7kuU5XbW9R6uD8=;
        b=cX/5/YR7k5pAylNLIqPAAPAbqQyoHj+bpqk7ufj7PajazKDW9ENMGiSjrcmOeaOmJM
         WIlLHO7sq2wYdat4obJgNS/mHRUu9pNK/rBux1Ls6ASSnwKc2LtO8EQFsqBH/pRbhsKs
         BfJuOROtLOUPFdNOr+TBr1t8dUAWxKlmsKkrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XziM4hA4Gmod9STm0oZGOi/d+jlnR7kuU5XbW9R6uD8=;
        b=MYCZ19Bn5mlX7QsyEvF1iRqoBwQdTb8PBpegAFQ/3TIuKR7nkKYCpWsEiaT/X3jW7E
         L3YZtOe6xFbmGYEkQvTfljQ74MHcvcWbxQIjklr3/TNSdLXhzEaKrwNW6t/LxDNg02hh
         L0M3f5Hg1SfZmEs12r6c5R+Wjwa+V3D1hA9Om3aGgIhJPX+paWz9tY94bymXtMAPgVJn
         QMVFVRK+8nFZ20E+ZhQcBaZAwmGEOnJKILLtifXLWiBJQlR/A5CnKD2FtaTcbqEN3PbU
         URO2HitP1M+tzKaNJANdlORptZ921I6mOrFNlmgETgphX5OAbXbQRMvRJLnbSqhOSwoF
         jqbw==
X-Gm-Message-State: APjAAAVTyo6BI0lEmX+mx/AXku91CaBYNqEL3BAsLzEVkuemR9fR4vN6
        4X1Uzpjc3WN7zXGkPl4/A47BTrkeCY8PsUnM430llA==
X-Google-Smtp-Source: APXvYqyCRLg+qUZT9unfn57Tqrts1U2AADTp/EWbz0rzG3BQN2HWuUEFxTZufHm0MxoBjaVXzzffUnzl3GjLy5LL/fs=
X-Received: by 2002:a67:2b86:: with SMTP id r128mr15127774vsr.119.1570438387453;
 Mon, 07 Oct 2019 01:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191007071610.65714-1-cychiang@chromium.org> <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com>
In-Reply-To: <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Mon, 7 Oct 2019 16:52:41 +0800
Message-ID: <CAFv8Nw+DEXePD-G-ujKgd9zAq+pDAaHF_rZTbRyDupVANGmqsQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: vpd: Add an interface to read VPD value
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Guenter Roeck <linux@roeck-us.net>,
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

On Mon, Oct 7, 2019 at 4:03 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Mon, Oct 7, 2019 at 3:16 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> >
> > Add an interface for other driver to query VPD value.
> > This will be used for ASoC machine driver to query calibration
> > data stored in VPD for smart amplifier speaker resistor
> > calibration.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  drivers/firmware/google/vpd.c              | 16 ++++++++++++++++
> >  include/linux/firmware/google/google_vpd.h | 18 ++++++++++++++++++
> >  2 files changed, 34 insertions(+)
> >  create mode 100644 include/linux/firmware/google/google_vpd.h
> >
> > diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
> > index db0812263d46..71e9d2da63be 100644
> > --- a/drivers/firmware/google/vpd.c
> > +++ b/drivers/firmware/google/vpd.c
> > @@ -65,6 +65,22 @@ static ssize_t vpd_attrib_read(struct file *filp, struct kobject *kobp,
> >                                        info->bin_attr.size);
> >  }
> >
> > +int vpd_attribute_read_value(bool ro, const char *key,
> > +                            char **value, u32 value_len)
> > +{
> > +       struct vpd_attrib_info *info;
> > +       struct vpd_section *sec = ro ? &ro_vpd : &rw_vpd;
> > +
> > +       list_for_each_entry(info, &sec->attribs, list) {
> > +               if (strcmp(info->key, key) == 0) {
> > +                       *value = kstrndup(info->value, value_len, GFP_KERNEL);
>
> Value is not necessary a NULL-terminated string.
> kmalloc(info->bin_attr.size) and memcpy(...) would make the most
> sense.
>
> The value_len parameter makes less sense.  It seems the caller knows
> the length of the value in advance.
> Suggest to change the value_len to report the length of value.  I.e.
> *value_len = info->bin_attr.size;
>
> Also please check the return value for memory allocation-like
> functions (e.g. kstrndup, kmalloc) so that *value won't be NULL but
> the function returned 0.

Thanks for the review.
I will them in v2.

>
> > +                       return 0;
> > +               }
> > +       }
> > +       return -EINVAL;
> > +}
> > +EXPORT_SYMBOL(vpd_attribute_read_value);
> > +
> >  /*
> >   * vpd_section_check_key_name()
> >   *
> > diff --git a/include/linux/firmware/google/google_vpd.h b/include/linux/firmware/google/google_vpd.h
> > new file mode 100644
> > index 000000000000..6f1160f28af8
> > --- /dev/null
> > +++ b/include/linux/firmware/google/google_vpd.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Google VPD interface.
> > + *
> > + * Copyright 2019 Google Inc.
> > + */
> > +
> > +/* Interface for reading VPD value on Chrome platform. */
> > +
> > +#ifndef __GOOGLE_VPD_H
> > +#define __GOOGLE_VPD_H
> > +
> > +#include <linux/types.h>
> > +
> > +int vpd_attribute_read_value(bool ro, const char *key,
> > +                            char **value, u32 value_len);
> > +
> > +#endif  /* __GOOGLE_VPD_H */
> > --
> > 2.23.0.581.g78d2f28ef7-goog
> >
