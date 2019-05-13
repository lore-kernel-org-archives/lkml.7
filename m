Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E334EC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B62208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RYLQChAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfEMP53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:57:29 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33364 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbfEMP53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:57:29 -0400
Received: by mail-vs1-f68.google.com with SMTP id y6so8353097vsb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjnGlq1ohCd0W6xCd80xJkwkNhN63u76f9BdkZ0Jn7A=;
        b=RYLQChAOwvWzDDP10EWoPE2WZgLkeAHe9e5TCyAbKdUVa5X8FOdbfhN5Si7TWPFR66
         Z3yvhWWPUsm1OhvqlkIpHZToYFNzH5sr67anIodWdRUkJ/ACRsswQySRAe83wSRs+lyU
         iG6YOeo8I5sADkmMu4VsSDyWh5/8PbVKiNl0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjnGlq1ohCd0W6xCd80xJkwkNhN63u76f9BdkZ0Jn7A=;
        b=YSzlitlX+uxwU9Co6LXockXgGA+Sjfyc9DpAPfYR+VHVV3SleE6HBk1TwxM2ry1fhv
         p9jBSHr7rnp6tgVUeKLn7TgUGMx2bdLif4feB4XquaRZ/Kp6rOPdsK5JPHsSEvTsBEEz
         8Frb/2piinSMg+fUTco1iqEubatqSURIq4yeHDk477c2RKjulrCCIGVDy/Ys7RHgq34c
         hVZbSgra27lmyzh121/c4wNRbkRk8HIU2zYSSwK7U2ZrJeKCiobenETv4NfaBScrVnfi
         ZPo/WJS50HgtoVYN8PGG7QUY3juJr4R2ItlX7Mtg9KDtg7msrvyKloe2B5+chCrhNmtr
         TJQw==
X-Gm-Message-State: APjAAAVVvUd9PX6mj/wAbvDxNh3wBSxLGfmujR7BAfjsVbAhZjmZPb0s
        ce8Ot+hWJfbCnf0OqceZJcQISudHuDs=
X-Google-Smtp-Source: APXvYqzsR7aq0pj20gHmrbmBnJaOdrPU7K5aeiTp69d3V5hHXFJDVva5ZrjVTtOsz6/1jePjJ17+1w==
X-Received: by 2002:a67:8042:: with SMTP id b63mr12693989vsd.202.1557763047571;
        Mon, 13 May 2019 08:57:27 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id g135sm6938675vkd.51.2019.05.13.08.57.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 08:57:24 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id d7so3443679vkf.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 08:57:24 -0700 (PDT)
X-Received: by 2002:a1f:d884:: with SMTP id p126mr12860211vkg.70.1557763043730;
 Mon, 13 May 2019 08:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-5-dianders@chromium.org>
 <20190512074538.GE21483@sirena.org.uk>
In-Reply-To: <20190512074538.GE21483@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 May 2019 08:57:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xg96SGg-JDjEJRtC6jACcN9Xizcr-zV4rQwXYvuEvmRA@mail.gmail.com>
Message-ID: <CAD=FV=Xg96SGg-JDjEJRtC6jACcN9Xizcr-zV4rQwXYvuEvmRA@mail.gmail.com>
Subject: Re: [PATCH 4/4] Revert "platform/chrome: cros_ec_spi: Transfer
 messages at high priority"
To:     Mark Brown <broonie@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 12, 2019 at 10:05 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, May 10, 2019 at 03:34:37PM -0700, Douglas Anderson wrote:
> > This reverts commit 37a186225a0c020516bafad2727fdcdfc039a1e4.
> >
> > We have a better solution in the patch ("platform/chrome: cros_ec_spi:
> > Set ourselves as timing sensitive").  Let's revert the uglier and less
> > reliable solution.
>
> It isn't clear to me that it's a bad thing to have this even with the
> SPI thread at realime priority.

The code that's there right now isn't enough.  As per the description
in the original patch, it didn't solve all problems but just made
things an order of magnitude better.  So if I don't do this revert I
instead need a patch to bump cros_ec SPI up to realtime to get SPI
transfers _truly_ reliable.  I actually have a patch coded up to do
just that.  ...but then Guenter pointed out that I was effectively
duplicating the work that the SPI framework could already do for me if
I could use the pumping thread at real time priority.

My current plan is parameterize things so that cros_ec_spi can request
a forced transition to the realtime pump thread without breaking
existing users.  I'll code that up this morning and send out a v2 soon
so you can see what you think of it.  :-)

NOTE: I actually tracked down one reason why the high priority thread
wasn't enough and I needed something like real time.  I found that
commit a1b89132dc4f ("dm crypt: use WQ_HIGHPRI for the IO and crypt
workqueues") was making dm-crypt preempt me.  I'll start a separate
discussion about that, but in the end it still seems better to use
something like a real time priority for cros_ec.


-Doug
