Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A367C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF74218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbfB1U1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:27:31 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42123 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732602AbfB1U11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:27:27 -0500
Received: by mail-qt1-f193.google.com with SMTP id u7so15936999qtg.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 12:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stBWwMqpBSCGcZFqSFF0JHMo+oJlyyG8lS4bB2+/gWU=;
        b=JU+n5rg/1u1JPT0PbELcIA6tpA6P1/uPlDiLo2YLCWvzSB5lVik/IATH2rIwBTSinR
         0TTizO5mPjEeh72WM9+kdMz/v8t+4SArm99IgH/Rfaab1AtBvA/oDjT6QQTFlGVeLSGc
         azRiuRGAPM+EMxlYHiaaLQiKsQBS+rvYpxJCNEX3vRtz/Fr4Ys7BSO5vorqI7MvZbibg
         VIAwEUOIUbW6PACwgr6EbSxT1kgraiRVeE7yWO8Qingd8g5+5fgK//HCApOnAVU5U5AG
         wRCxAoMuxn/y7y5AjxLjsbcPV4C5eSCojlzvwGmY9WriiMTJB3EaV73JA55OStg5oCZw
         lOyw==
X-Gm-Message-State: APjAAAVm3ICwJTdPpooiF8BdyH5Ou4+Tn2GmkkxQdLlEJ4GWA16tjsd2
        GP8BE2MYK+fQvR+sdOqy0RCOxMdPotfIN3lNS9w=
X-Google-Smtp-Source: APXvYqzIRoi3bTmtVoQukOcUUIxkJLj2LfvRVJgNj5czLHzeyDTSM6Q8Wwby/GnfrSE54UzDVUocKJBOse4sq4pFGxE=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr876035qve.180.1551385646079;
 Thu, 28 Feb 2019 12:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20190212180441.15340-1-keescook@chromium.org> <20190212180441.15340-2-keescook@chromium.org>
In-Reply-To: <20190212180441.15340-2-keescook@chromium.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Feb 2019 21:27:08 +0100
Message-ID: <CAK8P3a2xC3OVckPnweSjor3AH5LpSzichKxAjkAcgXDtCf0QmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gcc-plugins: structleak: Generalize to all variable types
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Emese Revfy <re.emese@gmail.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 7:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> This adjusts structleak to also work with non-struct types when they
> are passed by reference, since those variables may leak just like
> anything else. This is exposed via an improved set of Kconfig options.
> (This does mean structleak is slightly misnamed now.)
>
> Building with CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL should give the
> kernel complete initialization coverage of all stack variables passed
> by reference, including padding (see lib/test_stackinit.c).
>
> Using CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE to count added initializations
> under defconfig:
>
>         ..._BYREF:      5945 added initializations
>         ..._BYREF_ALL: 16606 added initializations
>
> There is virtually no change to text+data size (both have less than 0.05%
> growth):

I just resumed my randconfig build testing after a longer break, and found
a regression for stack usage that I bisected to your change. It shows up in a
variety of files depending on the configuration, so far the worst one is the
configuration at https://pastebin.com/UK54qbKa that leads to

../drivers/media/dvb-frontends/stv090x.c: In function 'stv090x_start_search':
../drivers/media/dvb-frontends/stv090x.c:1595:1: error: the frame size
of 5320 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
../drivers/media/dvb-frontends/stv090x.c: In function 'stv090x_optimize_track':
../drivers/media/dvb-frontends/stv090x.c:3090:1: error: the frame size
of 5872 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
../drivers/media/dvb-frontends/stv090x.c: In function 'stv090x_algo':
../drivers/media/dvb-frontends/stv090x.c:3431:1: error: the frame size
of 5144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
 }

At least for this specific file, I also see a significant (though not alarming)
increase in code size:

   text       data        bss        dec        hex    filename
179196       4632        256     184084      2cf14
obj-x86/drivers/media/dvb-frontends/stv090x-before.o
 216740       4632        256     221628      361bc
obj-x86/drivers/media/dvb-frontends/stv090x-after.o

Part of the problem here is definitely interaction with the asan-stack
sanitizer. Changing asan-stack=1 to asan-stack=0, it looks a lot
better:

../drivers/media/dvb-frontends/stv090x.c: In function 'stv090x_start_search':
../drivers/media/dvb-frontends/stv090x.c:1595:1: warning: the frame
size of 120 bytes is larger than 20 bytes [-Wframe-larger-than=]
../drivers/media/dvb-frontends/stv090x.c: In function 'stv090x_optimize_track':
../drivers/media/dvb-frontends/stv090x.c:3090:1: warning: the frame
size of 168 bytes is larger than 20 bytes [-Wframe-larger-than=]
../drivers/media/dvb-frontends/stv090x.c: In function 'stv090x_algo':
../drivers/media/dvb-frontends/stv090x.c:3431:1: warning: the frame
size of 192 bytes is larger than 20 bytes [-Wframe-larger-than=]

   text       data        bss        dec        hex    filename
184061       4632        256     188949      2e215
obj-x86/drivers/media/dvb-frontends/stv090x.o

I get similar results with asan-stack=1 but without your plugin, only
the combination of the two has the explosive stack size growth.

I can help analyze this further, but maybe you can have a look first,
there might be something obvious when you read the input to the
plugin.

      Arnd
