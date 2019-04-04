Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF59C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4607221741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Au5ToeJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfDDRnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:43:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40534 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfDDRnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:43:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so2855488ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 10:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGSyyrPaPmnoL0ndsLJSTpVaKw/4YG9rkuv7M6qYYhI=;
        b=Au5ToeJge72gEP8ySm/G6J+etDoaulRBlzouu2chPh4Li9k0iZioDn3/ZZV9l1aZW/
         Q3M/M2SCUo6l7mVZRRkWK3iffg4cEQRKuVr4DkvrXOcnLFnWitgWY+cN/AtA/o7eN0jU
         vLCRMyqo40ltkykuIGf3cAo8hmAh8fPa5f2Zfqpmp08lBMyiq5XtTajRvN8rD9mppAKi
         eSOjqhZ80Gh+qW8x3+7j/Mm1u16fMm9+gWJZzRHkyFR+4JaHMq86doabt5P9IVvtHVl3
         9/Nznr6HPtZ1DY/Q2Xura1lYakyu5xlO+QpJGUJ5in/g7jHsMzk0HSCyC6nkf8/38Iiw
         Qimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGSyyrPaPmnoL0ndsLJSTpVaKw/4YG9rkuv7M6qYYhI=;
        b=QLBt0DkrKZ8rj8sfUuFIQNA/Riy2SllILRJwLBvwCWtlkRdKrBU8U8lXUr9zB0f4OQ
         ucEf/MnINy/2maYRtDbh3bkpfqm7w8rTZdvzoYks+ohYrsnfJXjvaTqsTxEArLGyjU4+
         8hK6bgTIyeDdgRCnWMmilwmwDO4kxr8skeemDmbbuqjrxN2Y4V0qaj2ZNZshiqmevJ/2
         4y4s8DgAPZ4RdGI6Z43LN2+5RNScbJySpSCbbxgMWvo0Zf2gE2SUjnCqNGoux5rxzJgM
         wspx8IlKHtmTOuHr1K5BMiPgeeDjHClm9LsJlxV11NtJKiLaW/Afstb1yuMbu/Le0okm
         n2Mg==
X-Gm-Message-State: APjAAAVKV7q4Fr5EcfED5oNfBdq30JjY9gYqQgrTFb22DUZvgVXm38zU
        AxbiqgHBzFFzrA+kKoqog0xirccM5MzJwnaXqJdS7w==
X-Google-Smtp-Source: APXvYqzAz8UwMxYGXOb1VpBU7/MY8ZPQKVNQcSUrYMp1CHxHYDE0dPh7xvmfoHgRrlNA5qrUTAuKdzuqNvvN0FmCyq4=
X-Received: by 2002:a2e:7d19:: with SMTP id y25mr1717234ljc.126.1554399816638;
 Thu, 04 Apr 2019 10:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190404171007.160878-1-ncrews@chromium.org> <20190404171007.160878-3-ncrews@chromium.org>
 <CABXOdTeFnohENJrZ+=_W-EgsrKWttSFYKoR=LaCwzbhEbaOxzw@mail.gmail.com>
In-Reply-To: <CABXOdTeFnohENJrZ+=_W-EgsrKWttSFYKoR=LaCwzbhEbaOxzw@mail.gmail.com>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Thu, 4 Apr 2019 10:43:24 -0700
Message-ID: <CAE_wzQ8xS+zvSKNVs1v4B_y3NDu2qB65p_hD+j=qGHFxQWOmSg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
To:     Guenter Roeck <groeck@google.com>
Cc:     Nick Crews <ncrews@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, alexandre.belloni@bootlin.com,
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

On Thu, Apr 4, 2019 at 10:36 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Thu, Apr 4, 2019 at 10:11 AM Nick Crews <ncrews@chromium.org> wrote:
> >
> > We want all backlights for the system keyboard to
> > use a common name, so the name "platform::kbd_backlight"
> > would be better than the current "chromeos::kbd_backlight"
> > name. Normally this wouldn't be worth changing, but the new
> > Wilco keyboard backlight driver uses the "platform" name.
> > We want to make it so all Chrome OS devices are consistent,
> > so we'll change the name here too.
> >
>
> Wondering - who is the "we" you are talking about ?

This also has a potential of breaking existing setups if somebody did
happen to match on entire name instead of suffix. Such changes have to
be considered very carefully; at this point I am against of doing
this.

Thanks.

-- 
Dmitry
