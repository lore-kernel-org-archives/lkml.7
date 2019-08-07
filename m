Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE36C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFBB22293
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hxltUPay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfHGN5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:57:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39479 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388007AbfHGN5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:57:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so1373737wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JEGhf93f3Akg5xAiAZZbwAtjhXGTAB4HITGZRviUGbw=;
        b=hxltUPayeYBh+lxDyHLGBFwRsdfIsK3H03jSxiT/X/jXjZlCUPV9CmHMKclSe/HCBm
         /9zxcigUzAl1ZkmYidLc0CIWDPKORG4iM2/ni22+l3Z3ozLNU/92lKb2fwY989mKV0xy
         FhKG/1rS1kcl/WZyFLqyXP6tGemSZliw1rdVCNGHoR4/hpanz+LBPKs+Ji+mYYDiHerH
         YpfPI7LhoQlM8zBUon7PWChkmNIJKNakymjqeE1ftwmYJZ5q6/GHvXlsn2oeRH0rcO2f
         mHco3Srg1/In/v+lui9YNh1XO06OPo33pXMavv92Uzpqdgy3ELs+LpY0BEn7yqRNm2GK
         DTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JEGhf93f3Akg5xAiAZZbwAtjhXGTAB4HITGZRviUGbw=;
        b=TKc4vxMWqEWBqbKtP3SrZVRYhNypZjZ90UL8TJpYGOMFwM8dtw+BhwwxmkySzHm6I6
         n5gmdR3me811fv0OpHaF8VAZ9/F0LftSjGx8MU6bohP9JpTYl7lgqJY5g9f4z2LBFj8c
         iqoIBD+4e9OmJqzmQ8YpIPiFx5CMvVjJBXq+H2s3iBr1sqWZUSagnWgciivRdJt6L46F
         se7krO6YXPIVo9fqF7QkvYjhsMw/wiEdAfSkJW8ckWUIdxm/5oBmjHhSAxpeH39LmEqR
         FUgeDSMSwBJutpkMsMEKCJFNzFzECe8KULb6Lj+/GFTaoSOSygFeH9yoOftzVOskADvL
         hYeQ==
X-Gm-Message-State: APjAAAWbiypH/y63oSG2Iw2JqlcV692Cw/8VA2x3jJjlnga9MSCbAoUa
        S0YPBjl/fFn8zMMyC8MF2prjHQ==
X-Google-Smtp-Source: APXvYqxNBWO6G3Xg9M6cSGKJ3YUVTSJRRAVQcoPT8gpOxFh3XGef3u6b9macerFbJF++7wbX6faRHw==
X-Received: by 2002:adf:e2cb:: with SMTP id d11mr4614004wrj.66.1565186235445;
        Wed, 07 Aug 2019 06:57:15 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k9sm26301161wrd.46.2019.08.07.06.57.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 06:57:14 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/9] clk: meson: axg-audio: Don't reference clk_init_data after registration
In-Reply-To: <20190806214852.DE14F216F4@mail.kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org> <20190731193517.237136-4-sboyd@kernel.org> <1jwofqvftg.fsf@starbuckisacylon.baylibre.com> <20190806214852.DE14F216F4@mail.kernel.org>
Date:   Wed, 07 Aug 2019 15:57:13 +0200
Message-ID: <1j1rxxoz7q.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06 Aug 2019 at 14:48, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Jerome Brunet (2019-08-06 01:49:47)
>> On Wed 31 Jul 2019 at 12:35, Stephen Boyd <sboyd@kernel.org> wrote:
>> 
>> > A future patch is going to change semantics of clk_register() so that
>> > clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
>> > referencing this member here so that we don't run into NULL pointer
>> > exceptions.
>> 
>> Hi Stephen,
>> 
>> What to do you indend to do with this one ? Will you apply directly or
>> should we take it ?
>
> I said below:
>
>  Please ack so I can take this through clk tree
>

Missed it, sorry.

>> 
>> We have several changes for the controller which may conflict with this
>> one. It is nothing major but the sooner I know how this changes goes in,
>> the sooner I can rebase the rest.
>
> Will it conflict? I can deal with conflicts.

I'll check to be sure and notify you in the PR if necessary

>
>> 
>> Also, We were (re)using the init_data only on register failures.
>> I understand that you want to guarantee .init is NULL when the clock is
>> registered, but it this particular case, the registeration failed so the
>> clock is not registered.
>> 
>> IMO, it would be better if devm_clk_hw_register() left the init_data
>> untouched if the registration fails.
>
> Do you have other usage of the init_data besides printing out the
> name?

No other use

> I think we could have devm_clk_hw_register() print out the name of the
> clk that failed to register instead, and get rid of more code in drivers
> that way.

Sure, why not.

> Unless of course there are other uses of the init struct?

I was just commenting on the fact that initialization function tends to
rollback what they can in case of failures, usually.

>
>> 
>> >
>> > Cc: Neil Armstrong <narmstrong@baylibre.com>
>> > Cc: Jerome Brunet <jbrunet@baylibre.com>
>> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>> > ---
>> >
>> > Please ack so I can take this through clk tree
>> >
>> >  drivers/clk/meson/axg-audio.c | 7 +++++--
>> >  1 file changed, 5 insertions(+), 2 deletions(-)
>> >
