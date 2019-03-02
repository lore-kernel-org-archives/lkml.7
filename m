Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3FCC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828C520836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVAvkNwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfCBJFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 04:05:10 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36889 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfCBJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 04:05:10 -0500
Received: by mail-io1-f65.google.com with SMTP id v10so240201iop.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 01:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAvkCRQePpvlokHlpGhy/8CGCcGTFNt7ygGtzz6KllQ=;
        b=mVAvkNwzDoT26/8N3Z0DJy8UP7RV5I1yKvOrAJWxGXSwyr+VA4o6iEXuhSS6adc+59
         WFR7/hIzvR9TOQrOYDVc1/Q84pQP4jZyvBvLkeZBMsVCgKwvJwU7Q4eo2/R37PQ8Lw13
         Zt5rb/CXUvPmhfPmQB3dgk2rOfHmPcMP1iEXqD/ROcq9oJVXqhJOjnX8I0HS1QiImgcu
         kQ5/w8ZnKHATNnicAuRqYVF3fl3a8So6C8jnnWN9n3w0ROZzHHOFduHWQSjMID7TrmiC
         Ha/7XVx0amMP+nsIpS2AJq48cWBv7Udn+k5NGmmKW0ztKJIPqHWziqEeqsT9sKFlwjSL
         b9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAvkCRQePpvlokHlpGhy/8CGCcGTFNt7ygGtzz6KllQ=;
        b=ZqBL+4RvS5azMyUS+LLHk961bLE7tnxrEYugXdYBp2ewhTGAolgBHo36NwdVpSJLV0
         zZGDEINqQKVWEQLooGWBY6sXtzFTRRvdUYILKCFFHMZO1kCNF8C4cf1zmLphz27g+cBx
         yZOA+uOjvWTLoN3HLquA3dy3PiYO2yx2yG4jM5ybrUJYOUR4GL+KqG8+8t3+DxTZa0Zk
         ujcZrqYFvLjhfkgjEuEtlyHWyDJdowZ04c34MscSV5gMuE+PSPSeBfB6up7K3fRwwKjl
         lsqhMmsnW7+76WxSq0Kfw1OpML+JXbuNkco+fTmarI0Qr2GyLo0s1zRAfRUuTDT+LkyB
         DTsA==
X-Gm-Message-State: APjAAAW10VkRPpO0bOd0iW/wrbttipkXZO162xSC6WOs1ry13Blt7LFW
        swcn6/99otYlcssqc2GAO0Z5e3rv+7nJhMwemjiVUw==
X-Google-Smtp-Source: APXvYqz+tGjA1ydVDUmNGHQsNP/VY8nzeQMgWaR3C29Q8OsY0GyqxJurNbpM5AUWjk9gWkJxLkly9cB8ugDnUB8eOzs=
X-Received: by 2002:a6b:6511:: with SMTP id z17mr1776944iob.173.1551517508781;
 Sat, 02 Mar 2019 01:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20190212180441.15340-1-keescook@chromium.org> <20190212180441.15340-2-keescook@chromium.org>
 <CAK8P3a2xC3OVckPnweSjor3AH5LpSzichKxAjkAcgXDtCf0QmQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2xC3OVckPnweSjor3AH5LpSzichKxAjkAcgXDtCf0QmQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 2 Mar 2019 10:04:56 +0100
Message-ID: <CAKv+Gu_+GZ8Ut0nN+za+V48Eo6O27P_go3Dk1rDe1Wederad1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] gcc-plugins: structleak: Generalize to all variable types
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Emese Revfy <re.emese@gmail.com>,
        Alexander Popov <alex.popov@linux.com>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 at 21:27, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 12, 2019 at 7:08 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > This adjusts structleak to also work with non-struct types when they
> > are passed by reference, since those variables may leak just like
> > anything else. This is exposed via an improved set of Kconfig options.
> > (This does mean structleak is slightly misnamed now.)
> >
> > Building with CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL should give the
> > kernel complete initialization coverage of all stack variables passed
> > by reference, including padding (see lib/test_stackinit.c).
> >
> > Using CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE to count added initializations
> > under defconfig:
> >
> >         ..._BYREF:      5945 added initializations
> >         ..._BYREF_ALL: 16606 added initializations
> >
> > There is virtually no change to text+data size (both have less than 0.05%
> > growth):
>
> I just resumed my randconfig build testing after a longer break, and found
> a regression for stack usage that I bisected to your change. It shows up in a
> variety of files depending on the configuration, so far the worst one is the
> configuration at https://pastebin.com/UK54qbKa that leads to
>
> ../drivers/media/dvb-frontends/stv090x.c: In function 'stv090x_start_search':
> ../drivers/media/dvb-frontends/stv090x.c:1595:1: error: the frame size
> of 5320 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> ../drivers/media/dvb-frontends/stv090x.c: In function 'stv090x_optimize_track':
> ../drivers/media/dvb-frontends/stv090x.c:3090:1: error: the frame size
> of 5872 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> ../drivers/media/dvb-frontends/stv090x.c: In function 'stv090x_algo':
> ../drivers/media/dvb-frontends/stv090x.c:3431:1: error: the frame size
> of 5144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>  }
>
> At least for this specific file, I also see a significant (though not alarming)
> increase in code size:
>
>    text       data        bss        dec        hex    filename
> 179196       4632        256     184084      2cf14
> obj-x86/drivers/media/dvb-frontends/stv090x-before.o
>  216740       4632        256     221628      361bc
> obj-x86/drivers/media/dvb-frontends/stv090x-after.o
>
> Part of the problem here is definitely interaction with the asan-stack
> sanitizer. Changing asan-stack=1 to asan-stack=0, it looks a lot
> better:
>
> ../drivers/media/dvb-frontends/stv090x.c: In function 'stv090x_start_search':
> ../drivers/media/dvb-frontends/stv090x.c:1595:1: warning: the frame
> size of 120 bytes is larger than 20 bytes [-Wframe-larger-than=]
> ../drivers/media/dvb-frontends/stv090x.c: In function 'stv090x_optimize_track':
> ../drivers/media/dvb-frontends/stv090x.c:3090:1: warning: the frame
> size of 168 bytes is larger than 20 bytes [-Wframe-larger-than=]
> ../drivers/media/dvb-frontends/stv090x.c: In function 'stv090x_algo':
> ../drivers/media/dvb-frontends/stv090x.c:3431:1: warning: the frame
> size of 192 bytes is larger than 20 bytes [-Wframe-larger-than=]
>
>    text       data        bss        dec        hex    filename
> 184061       4632        256     188949      2e215
> obj-x86/drivers/media/dvb-frontends/stv090x.o
>
> I get similar results with asan-stack=1 but without your plugin, only
> the combination of the two has the explosive stack size growth.
>
> I can help analyze this further, but maybe you can have a look first,
> there might be something obvious when you read the input to the
> plugin.
>

Is this before or after use-after-scope was disabled entirely?
