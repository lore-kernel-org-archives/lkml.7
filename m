Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0270C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6233206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lmcxJg+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfJHMKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:10:50 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43281 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbfJHMKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:10:49 -0400
Received: by mail-vk1-f193.google.com with SMTP id p189so3691654vkf.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qc61QyZfZZYMqB8OD9rsg9gHOoNYnkxxv7LFR8LDv3U=;
        b=lmcxJg+WAumgYsryhw1/rF2wSdetdsrVtKSmsoEXbgowdVvGVIzdMGBxgiUogalR6w
         pdGBW7IF1uVYrcXD1XWnUsJPNXl/lfI2wl2UaHC04Fy6NjB2SOukNg8I1TqSTn4iNQbX
         FAh8tSWkRqkUrXnaB/WQ/Ow2m+iIkdMG/YENI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qc61QyZfZZYMqB8OD9rsg9gHOoNYnkxxv7LFR8LDv3U=;
        b=V/Zi/c9ARunHXDPfnJUZ6wsNcn5Fjsgk8Fw7P318jOuZGoAlcYqyBwSRw4hM6SZwhK
         Yl9/hylEQSzlEv6fWc9aCXPTTSBCdsTBGnacUg4pJxZ2bY/78zdLik6/pVrEPAtt7xH0
         erx1bb/AVSenK77u2dDRaegLhAZvcYLINhsSAF3OJjXJWarEcsSOP1mqNX6FfmcLVoJK
         z50cJ6+nMJCnGIy54MAo3/9vRCMoTS/7+L07k1fgnkja2g/1MlL6PzI+cKjvnuEFOzYM
         JL2SPLWUfMsnZh2K/mdE2unKB6newjFd/P6iu9TqRjIuCFdI2/PUKh6pK5iOLs5GViuX
         GcSw==
X-Gm-Message-State: APjAAAWywfbUXvYDz7A41SuPB0jL+Kpu+VPvYYcx1sXiyx8orQxgumEu
        W3gQX2mZJ3ewSfc4+9/Bu9Zd4tlSLLERaTCjz9gwjg==
X-Google-Smtp-Source: APXvYqwxv7te0+g5CNTJMkvkyE0zFacwdpsQDxej3YHeqIGBVQ5w5lPw/kLCFgvz5h6g5SEqlsPKUjZrX2lW7zRSn0o=
X-Received: by 2002:a1f:2192:: with SMTP id h140mr16721053vkh.92.1570536648132;
 Tue, 08 Oct 2019 05:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191008101144.39342-1-cychiang@chromium.org> <20191008120649.GC2761030@kroah.com>
In-Reply-To: <20191008120649.GC2761030@kroah.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 8 Oct 2019 20:10:21 +0800
Message-ID: <CAFv8NwL2xRFUSRwiD4=mPg1zWm0gmzUQmhaU9SKCdc+=r7pjrg@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: vpd: Add an interface to read VPD value
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Guenter Roeck <linux@roeck-us.net>,
        Hung-Te Lin <hungte@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Shuming Fan <shumingf@realtek.com>,
        "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 8:06 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 08, 2019 at 06:11:44PM +0800, Cheng-Yi Chiang wrote:
> > Add an interface for other driver to query VPD value.
> > This will be used for ASoC machine driver to query calibration
> > data stored in VPD for smart amplifier speaker resistor
> > calibration.
> >
> > The example usage in ASoC machine driver is like:
> >
> > #define DSM_CALIB_KEY "dsm_calib"
> > static int load_calibration_data(struct cml_card_private *ctx) {
> >     char *data = NULL;
> >     int ret;
> >     u32 value_len;
> >
> >     /* Read calibration data from VPD. */
> >     ret = vpd_attribute_read(1, DSM_CALIB_KEY,
> >                             (u8 **)&data, &value_len);
> >
> >     /* Parsing of this string...*/
> > }
> >
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
>
> I can't take this patch without a real user of this function in the
> kernel tree at the same time.  Please submit it as part of a patch
> series with that change as well.
>

Hi Greg,
I see.
There is an ongoing discussion with Mark in

https://patchwork.kernel.org/patch/11179237/

I will resend this after machine driver is merged, and after codec
driver change get sorted out there.
Thanks!

> thanks,
>
> greg k-h
