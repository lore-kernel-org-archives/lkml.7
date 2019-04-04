Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576D3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2611320882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFJEuK5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfDDVsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:48:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38108 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfDDVsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:48:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so3437099ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYCaefQYUTkhk2hWXuHW21QRYmTnkr+usMeFrkI/Fak=;
        b=eFJEuK5lUvJaRMPIS60AhxuGynYUV3SfCTEl65TCK9AEOEoiPTnvOTeu31B7Zgmykj
         ywBmCfcmHGBB5ozRmnd6wUF76AKNQx6KM/RWEo6j48QcfxR6GsJh3O+bcCOI7ME36u1c
         ZV01n2KEvwYDeKlMKiy9mZus82Fx1ccSY7vt8LRgVZ5jcE+J1MYQNkFdaVZ7uHGv/NxO
         5DdiKvNC/P9qTpYZ7Kj2+79Doa7ocpdtXSQbBS/H17HwrX23ocec9Kb6/4CW0IwQWCss
         XG8fs1caHmlLEX/bw4YO9/WpPZX1HOF1t6rh7xN0DqaLzTydZl8gAPmaihqbL49E4PSn
         OF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYCaefQYUTkhk2hWXuHW21QRYmTnkr+usMeFrkI/Fak=;
        b=IBWdcxgxTBmT1rb+yl7XRdcM3vq7k0s3Bu9S9Dd6fskGUmzg3CbWTbxJ9bK7gEfUt3
         0hD827D2E8NHSxqAyol1lz1dDW4VDGcEQUNARWM8ZaoTvptMUSGGZThVDvy12++KyBUf
         ORiXQhLI1/nMuCF/iHHjPjhS9/6A15T2XX63xth9qa7f+bTsjNRTQ7td30Yr0VLJGF2x
         TxQsYMzeVlvV1WEHUIEBS1EQsGLJHWJd6nTyELSf+f41sDUjVNpU24d+jNUAq6iUc6z4
         KlpfcYgYPp/aM6p/tGBpHjdErt3MGty7wGVFOAaagHD2tToHch0TO5hU7gelS4Av+8Jp
         bB0A==
X-Gm-Message-State: APjAAAUem5BpADwzKV7VKuTAadvTa/V4ARkpriXbjeO5J4r5sWnIFwUt
        9ntrr4r/hWPTn1d+Bx3cy1JCEqNIRuXKaho7P2Mdjg==
X-Google-Smtp-Source: APXvYqxOQfjKUkDoK2/pSa46o0UhiU889gur1wcFNVmJf+0Uc7RPOjnz9LkRJQdNeLNC0mBdhwKdC8pPxEY7mpNpyhg=
X-Received: by 2002:a2e:9655:: with SMTP id z21mr4759282ljh.60.1554414527400;
 Thu, 04 Apr 2019 14:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHX4x87cQLhZOEDxwBJs=UkDxwGxZOELGjHtp6aFLBWmjyQAFQ@mail.gmail.com>
 <CAE_wzQ8k4vO4yLsr2WNxYQ=-6JDmTsj6OxD0f3P=k8kJYFOD9Q@mail.gmail.com>
 <20190404185919.GB27340@amd> <CAE_wzQ-XuK7WOyPm6yXsmjp7z0=T92mMrfn1TVaavaLejcYVGA@mail.gmail.com>
 <20190404191931.GA29984@amd> <CAE_wzQ8y8i7C+_tv0CdnbUw0r21g1ggv2YUuzCog1xABivEvWA@mail.gmail.com>
 <20190404200658.GD29984@amd> <CAE_wzQ8WcMCzYqvxA_JBZKNza7ca3QE-VShmMxv5++_4F8RR=g@mail.gmail.com>
 <20190404202042.GF29984@amd> <CAE_wzQ-8XwzptH7EqNrELxjBzY2+0oHJGB3Va=vZwwK3csu_aA@mail.gmail.com>
 <20190404204207.GH29984@amd>
In-Reply-To: <20190404204207.GH29984@amd>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Thu, 4 Apr 2019 14:48:35 -0700
Message-ID: <CAE_wzQ8xe=x0uYcZkDRVKpUAQ_1vVdEPHU3XnEV1=_WN1-AMfw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Nick Crews <ncrews@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 1:42 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > > And what to do if internal keyboard is not platform but USB? Like
> > > > Google "Whiskers"? (I am not sure why you decided to drop my mention
> > > > of internal USB keyboards completely off your reply).
> > >
> > > I don't have answers for everything. Even if you have USB keyboard, you'll
> > > likely still have backlight connected to embedded controller. If not,
> > > then maybe you have exception userland needs to know about.
> > >
> > > Still better than making everything an exception.
> >
> > You do not need to make everything exception. You just need to look
> > beyond the name, and see how the device is connected. And then apply
> > your exceptions for "weird" devices.
>
> "Where it is connected" is not interesting to the userland. "Is it
> backlight for internal keyboard" is the right question. It may be
> connected to embedded controller or some kind of controller over
> i2c... my shell scripts should not need to know about architecture of
> every notebook out there.

Then your scripts will be failing for some setups.

>
> But I don't see why I should do additional work when its trivial for
> kernel to just name the LED in an useful way.
>
> "platform::kbd_backlight" has no disadvantages compared to
> "wilco::kbd_backlight" ... so lets just use it.

It has disadvantages because it promises more than it can deliver IMO.
If device name != "platform::kbd_backlight" it does not mean that it
is not internal keyboard. And you still have not resolved how you will
handle cases when there is more than one deice that can be considered
internal and may have a backlight.

Thanks.

-- 
Dmitry
