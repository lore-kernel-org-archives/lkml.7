Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E33C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D09620693
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j1TPVsIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfDYQiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:38:21 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39556 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDYQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:38:21 -0400
Received: by mail-it1-f195.google.com with SMTP id e13so1147687itk.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHDZQTX3nTBqKHo1hwDhNBgtUmmqtkCr53n/vkeR56Q=;
        b=j1TPVsIhDKAuuO0VpVPCDmktnph6s35mRzixFM1NAho8Fq+Z/s0YMnD9bGYGOLL90T
         U1eJJrcQHy5O4bCAHLQYw24J83Ik0tKEDl3JU+R9b7H/HBj2Ne7ipEqgVUfSNKuyZQ3x
         7fiWkfcZlPYtP+Yf7sXyv0eV4KKPScuOZgM44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHDZQTX3nTBqKHo1hwDhNBgtUmmqtkCr53n/vkeR56Q=;
        b=rtZ9fBEGFhBYbl/rdCuNFfLumXrylHr3NRa5solgjA8rZQ4yM3B3XyhC94cPFQH6aK
         TKWA1zGTbRe+Z7mh1QWL5e0By+y9Uo/WIFMB9zZJjANJfIyFNOVBES22veGLPBTkSW5K
         v/XK6K3+02Cx11/pKX9r4sC6kJKxeYyHabWCBYg/NwV5jN1xvbbQbuHSMAvuoghRmcVi
         R3RwJJcsxaocsAvhKPdrHtbI4aD49HFrAV3LKOFkYRnNjPDJiGsNY9G4m/RlWeKgRzlE
         4xwnlWHUPFfWf+gtlbAbT3sNDooeBySgnBbYs35XS+dZJ3uoItW3PGZ7UNUlY0t/2QUl
         4SDw==
X-Gm-Message-State: APjAAAU7WbtfsO8viLlfQ3rgJruz+3FV423KCGDFsFTs6Ezg9wC8pB5T
        TPDJBIOn/569kVUAI5bIb2HRlxb4YuNYXV6DK+VgOA==
X-Google-Smtp-Source: APXvYqxNy4UeJbrXeclqdR151+4gMxTbAtwFxtI2swR6YMhD574KAt1e8MS4I5F0GpJLsf1ugAYv69xntqo8PDwhr74=
X-Received: by 2002:a24:90f:: with SMTP id 15mr4436683itm.100.1556210300671;
 Thu, 25 Apr 2019 09:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190424232918.243308-1-gwendal@chromium.org> <20190425081232.GA14758@dell>
 <aa1c0ab7-6491-69a8-936c-26460b78d6c2@collabora.com> <CAPUE2ussoqWAP-1Hpa2mGq-23NuTh=Ai3dssiZYYiqLBDTCJwQ@mail.gmail.com>
 <0fad0c23-7939-606e-86e1-748dd1115b82@collabora.com>
In-Reply-To: <0fad0c23-7939-606e-86e1-748dd1115b82@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 25 Apr 2019 09:38:09 -0700
Message-ID: <CAPUE2uu7npyi0jgHPLCD-3DWkiKuhRidBgyiVK6O1TesHLqkEg@mail.gmail.com>
Subject: Re: [PATCH 00/30] Update cros_ec_commands.h
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 9:11 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi,
>
> cc'ing some ASOC reviewers.
>
> On 25/4/19 18:00, Gwendal Grignou wrote:
> > On Thu, Apr 25, 2019 at 4:19 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >>
> >> Hi Gwendal, Lee
> >>
> >> On 25/4/19 10:12, Lee Jones wrote:
> >>> On Wed, 24 Apr 2019, Gwendal Grignou wrote:
> >>>
> >>>> The interface between CrosEC embedded controller and the host,
> >>>> described by cros_ec_commands.h, as diverged from what the embedded
> >>>> controller really support.
> >>>>
> >>>> The source of thruth is at
> >>>> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> >>>>
> >>>> That include file is converted to remove ACPI and Embedded only code.
> >>>>
> >>>> From now on, cros_ec_commands.h will be automatically generated from
> >>>> the file above, do not modify directly.
> >>>>
> >>>> Fell free to squash the commits below.
> >>>
> >>> This is going to need a bunch of Chromium reviews (and testing
> >>> ideally) before I can take this set.
> >>>
> >>
> >> I tested this patchset in different ways. With the full series applied I checked
> >> that didn't break any cros-ec driver on Kevin, Samus and Veyron devices. I also
> >> checked via userspace tool that I don't see any problem sending commands and
> >> finally I checked that applying one-by-one the patches didn't break the build on
> >> x86 and arm64, there is though, a problem,
> >>
> >> [PATCH 24/30] mfd: cros_ec: Update I2S API
> >>
> >> introduces a build problem because removes a struct that is currently used by
> >> the cros_ec_codec driver. I think that at the same time we should update that
> >> driver with the new struct name.
> > Sorry, I did not structure this patchset right. The i2s patch is available at
> > https://patchwork.kernel.org/patch/10877645/
> >
>
> I think would be better squash both patches, otherwise things like bisection
> would be a pain. The patch then touches two subsystems but won't break
> compilation, and is pretty simple, so I think should not be a problem go through
> i.e. the mfd tree.
I squashed both patches in [PATCH v2 24/30] mfd: cros_ec: Update I2S API

Thanks for the feedback,

Gwendal.
>
> > Gwendal.
> >>
> >> Once this is fixed,
> >>
> >> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>
> >> for the full series.
> >>
> >> Thanks,
> >>  Enric
> >>
