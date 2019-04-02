Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDA7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6EF2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dt+3WzDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfDBDTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:19:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39831 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbfDBDTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:19:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id m13so7817366lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTsXK1B5YNFzHF5onXiH5Wm8KUgesIRe0xZ0fyO5how=;
        b=dt+3WzDM4bIpkuqCgUNX56cWXNYcLyb4XyoQwMBDde6iSvlAL/i0ba9kZVgFNz6XT2
         THUZ+3h4g8fRGKXHDzutYTou07ADHnCISFLno0aYg3HF2I3FdoQ0OzWepjDPzau6FZwo
         zsTx3AO7L/Ns450jDNtMYL+KRL8ji9selg1pnjx7FPVZfs8AL3K0NNSqFLNZsIujEvPK
         RhbJlhpSyr49rct8mMPIP56WlihnWNa2zbHCYI672wUluKwho4Y+AV0CRUj5c5mJ9MEu
         QhwpOpwlnEgnjH+j/rgcbWhZw0y+3UeuTqAUchaK9ybzm3C61l2FiffrA70rgbXj2njc
         DWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTsXK1B5YNFzHF5onXiH5Wm8KUgesIRe0xZ0fyO5how=;
        b=hVJnpNsxSpN5a3lwAFaUlvx3bBFWq+6mYvAvC2EV94esXqiUXU6QP+1gCSqISpFaER
         esnN/xd3j5YKcVSOm+0ZSilmwvEu9l7O7rWNmFMmnOzFIyWeLIlPhDkZdf7prCBJYSmC
         OEKF+mb8/a8vexLch+al0S6qwfDe2iM00rtzWDiwY9scJ7uh8GQI0YCyd3gFsNneRuTB
         iogq6U8oghODJ5HtqfkF9tdgOYUqAg/ob0MG+Ju45PdjArW5G8634VocLMeU+/o/jVgd
         91yGmm+jSbmkdLsqGRt2HesulfH45JiRW73ZU8Vmg3/zYxLEt1ABye6eaOZAyVkuO6AT
         g2eQ==
X-Gm-Message-State: APjAAAWo9n6OFyZjBMGp95JTLr49Y+KhHKOkAiR/v7FcrwnatfyNid5m
        lP89zHflNlNlm1sOscooibvx2O1P5lTIXb2YpxBPHA==
X-Google-Smtp-Source: APXvYqwl9/XP1cJHPuKT+9H6V5EJbkQvLOAbC1WY6HBBLUZWDyDlBhGxVYaWy4/PxHV1ecOZWPkODtt1O8seONnU624=
X-Received: by 2002:ac2:491a:: with SMTP id n26mr19605977lfi.122.1554175171067;
 Mon, 01 Apr 2019 20:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554026842.git.hns@goldelico.com> <2D0BC383-A57A-4C36-AC48-539B4E8811C0@goldelico.com>
In-Reply-To: <2D0BC383-A57A-4C36-AC48-539B4E8811C0@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 10:19:19 +0700
Message-ID: <CACRpkdaM4t6c5gkLxv6CS559o_X=r14oP4=VoEhzyH4Du9socg@mail.gmail.com>
Subject: Re: [BUG/PATCH 0/4] gpiolib: fix issues with legacy spi-cs-high handling
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 11:59 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> I learned just some minutes ago that a new patch for gpiolib
> came through 5.1-rc3 which does fix this in almost the same way
> as I proposed.

I am sorry for not being very attentive, I have been travelling.
I collected the most urgent fixes and this was fixed as part of
that quick patchup.

> Except that it seems to check for "cs-gpios" and then disable the
> legacy handling.

Yups.

> So we do not need to add a config option for this legacy
> handling (although I'd prefer to have it anyways to remove
> some dead code).
>
> Summary: this series can now be ignored.

OK please verify that we are doing things right now, the big
worry I have is some interrim DTBs that use the GPIO flag
GPIO_ACTIVE_HIGH, which is zero and therefore often the
default, and expect it to actually work, while the SPI bindings
by definition will ignore that and make the line active low.

I'm not very happy about this but it is a result of how we quickly
implemented some bindings in the past while the GPIO flags
were not yet standardized.

Yours,
Linus Walleij
