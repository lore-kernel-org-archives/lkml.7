Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672CDCA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352DA2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZMBnR2U2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfJUSIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:08:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33637 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbfJUSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:08:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so22469108qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 11:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4x966FzqbSx/OKh4p5Ft123ZasqylypjRFf91DAyyOA=;
        b=ZMBnR2U2u4X68MXVm+8rsMwA+4duw05rldsVrPC4uH+6neLc/Y761o+A+e0P8mDu+F
         utweRWpB6iBzQPfEHGUPjFwESRMWYH1GX9VMij+Gzp5M6maRvvwBN4Bq2X01XUN62Dw5
         ToEe4Pv9IucB7UOv46I1/6GfMkaEGz+vfbqj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4x966FzqbSx/OKh4p5Ft123ZasqylypjRFf91DAyyOA=;
        b=TmoW9Sq34OTH3SR6H5lW6L56paC0S64MFr1P/wvoP+CNsjdwu0FkN9x4cAB7Atpry/
         kKa0N6f7KQE2PugDojuFujL6du6Vv3qrwEs6wS+SgVvKc1DbPo/ZtAtb6FMH93NxK/G+
         Gno/LVV7nLS9pLvme+/byq5MDc3CLJwDzZddu70uNk7MnHMDPNaGEoVCnoWyayNWDbme
         kxwyh5AIX/cw8UTokP/FS3pDluXrjiX/4vK0ecq82/v76/kI5Tw7L1eRg2GotBY0HsLi
         KMU5ogcZTFSKyCbL5TXANAYDS6zHrBOGZ1RfxKeq2YeItaqHUlgucSEvqPe51GfFcMZG
         opLw==
X-Gm-Message-State: APjAAAU6sZbSbNTjVqOJYoI5fnac2Bn8eztWw/LTBZek2OGLW3co7GVT
        Pdw7GTDGOhQYMcjkKrgY6dDx0n8ck/M=
X-Google-Smtp-Source: APXvYqzDlS69/6Yfsm1XCGDz8VS7zVRTO2wBc6EQWMEK+ZeX2yjIw+vWoDoXLZO5oL2icYLO8r6pKQ==
X-Received: by 2002:ac8:7692:: with SMTP id g18mr26614434qtr.127.1571681300895;
        Mon, 21 Oct 2019 11:08:20 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id r7sm8109376qkf.124.2019.10.21.11.08.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 11:08:20 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id e14so2636474qto.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 11:08:19 -0700 (PDT)
X-Received: by 2002:ac8:529a:: with SMTP id s26mr25589910qtn.238.1571681299254;
 Mon, 21 Oct 2019 11:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180521164222.149896-1-briannorris@chromium.org>
 <20191021161113.GZ3125@piout.net> <CA+ASDXOXSKoRcuRWZ1FGNcioFKSiazXGxOvMv5=px_pn46vJbw@mail.gmail.com>
 <20191021174809.GA3125@piout.net>
In-Reply-To: <20191021174809.GA3125@piout.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 21 Oct 2019 11:08:08 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMarBG5C1Kz42B9i_iVZ1=i6GgH9Yja2cdmSueKD_As_g@mail.gmail.com>
Message-ID: <CA+ASDXMarBG5C1Kz42B9i_iVZ1=i6GgH9Yja2cdmSueKD_As_g@mail.gmail.com>
Subject: Re: [PATCH] rtc: report time-retrieval errors when updating alarm
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 10:48 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 21/10/2019 10:20:08-0700, Brian Norris wrote:
> > Hi Alexandre!
> >
> > On Mon, Oct 21, 2019 at 9:11 AM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > > On 21/05/2018 09:42:22-0700, Brian Norris wrote:
> > > > __rtc_read_time() can fail (e.g., if the RTC uses an unreliable medium).
> > > > When it does, we don't report the error, but instead calculate a
> > > > 1-second alarm based on the potentially-garbage 'tm' (in practice,
> > > > __rtc_read_time() zeroes out the time first, so it's likely to still be
> > > > all 0).
> > > >
> > > > Let's propagate the error instead.
> > > >
> > >
> > > I submitted
> > > https://lore.kernel.org/linux-rtc/20191021155631.3342-2-alexandre.belloni@bootlin.com/T/#u
> > > to solve this after looking at all the implication checking the return
> > > value of __rtc_read_time had.
> >
> > Only about a year and a half late, nice!
>
> I know, right? :) The fact is that this is not a common issue or at
> least, I didn't have any report that this was causing real problems in
> the field. So it ended up being one of the longest standing patch in
> patchwork...

I suppose I could have put specific examples in here: the Rockchip
RK3399-based Gru family of Chromebooks
(arch/arm64/boot/dts/rockchip/rk3399-gru-{kevin,bob,scarlet}*.dts) use
the Chrome OS EC-based RTC (drivers/rtc/rtc-cros-ec.c), and the EC
protocol is prone to occasional errors. So we definitely have a
concrete case where this problem can be tickled. I guess I was too
terse in summarizing that as "if the RTC uses an unreliable medium"?

As for the actual symptoms: this was part of a variety of problems
that resulted in seeing interrupt storms from our EC/RTC when running
`hwclock -r`. I believe there were other patches that were more
critical to resolving the worst symptoms, but this error was noticed
along the way. If you care to read more, you can see our downstream
kernel patches here, when we first handled this problem:

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1067442
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1066984
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1069546

Unfortunately, the bug links are private (they were dealing with
partner/factory issues), so you can only glean the implicit
information from the code. And since this was over a year ago, my
memory is a little fuzzy on what exactly the source of the interrupt
storm was...

> >Fortunately we have a decent
> > (albeit time-consuming) process for rebasing our downstream patches in
> > Chrome OS kernels...
> >
>
> Do you need that patch backported to LTS kernels?

Eh, I dunno. If anything that'll just cause us merge troubles (but not
too much) on our Chrome OS kernels, which already carry my patch. But
if there are any non-Chrome-OS users of these Chromebooks (there are)
that are seeing this problem (I'm not sure), they might appreciate it.

By the way, I wonder if your patch actually deserves a "Reported-by".
I suppose I also left off Jeffy as the reporter, but it would be:

Reported-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reported-by: Brian Norris <briannorris@chromium.org>

Brian
