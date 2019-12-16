Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2C8C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A97207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WUP++Ukk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfLPJNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:13:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40808 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfLPJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:13:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so5821522wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 01:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=hGz9qWdY8ZcUU5/VcrTyxse6NvOSG2JsP6RQHgyur6o=;
        b=WUP++UkkkRHAngukuNoFL6QdnnAcsECwDXGu5MQfgjJHODHN6xd2WMIiokGIBHeJeY
         Xtr1sfbZVaBjybPoIos7VuR8uYpG2CQ6mV7+A9FhXATLlJdFc21aKVjsQctJD3oOVJI+
         j0gaFHhyX0/J//241U49HhKK5tv0N7vfW8xW9nsL+FPYkfo7loQk7KaEkpgiFgXb26FY
         bbd35FmlBznv/3K5Dw4098MXk+dR5bhE1BZFGdprT0krRVjCR5XeI/758Sqgk5ZBKLBy
         DTlU59r2daKnL4q0/U9E4IeAjQIt7ZYunYv05taTdrauBJUWbfi0v5Pr3wcN7Phj0ZOw
         DreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=hGz9qWdY8ZcUU5/VcrTyxse6NvOSG2JsP6RQHgyur6o=;
        b=WJR9j7CRmcWeIYTNRd9FfbiXZWfA+7qDM4G4vxZppZSoLozYejTz3ye6mhftT+xEHv
         Q54h3whQ+7fLw0PSM6xlCXUpG9zV3eY6CNVJqQg5YRqSFnuIAZL9vxBkOWuQv/LxQksi
         hvk/uXjGdDbVfAEi3lDfFKYfrKrLu2e4nQ9lwQ4l6x34oWXY/SVTdFBoijscoo908CWn
         lz8jBT3fC4rUe4Y0KmkotkxkaIZtki7SdyYGOPL0f9qhNotkrtZW1RbO0Ri2ShJm9NtY
         n42qNhPfmmwM/Ri/o9AfGMuw70UkeFnstMSfWTi0cHK7wMMounnV3XpQU+vuW44qquYq
         Dvnw==
X-Gm-Message-State: APjAAAXdGljKjIZ1tWysNFuiZ6ZUmPkrmmq1Kug3nmjXV+6cfrxxAMxC
        4/mWMfGFieybxOtIZEt5HDBAmQ==
X-Google-Smtp-Source: APXvYqy19YVm/1kSejmA9wVlq3iOrl0I2bxY+X47LQj5Bypu9SC2jPZAIHgTCn3wIgxj4Ti9RIfJaw==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr27710908wma.121.1576487613009;
        Mon, 16 Dec 2019 01:13:33 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id b10sm21088066wrt.90.2019.12.16.01.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 01:13:32 -0800 (PST)
References: <20191215210153.1449067-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] clk: Meson8/8b/8m2: fix the mali clock flags
In-reply-to: <20191215210153.1449067-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 16 Dec 2019 10:13:31 +0100
Message-ID: <1jr214bpl0.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 15 Dec 2019 at 22:01, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> While playing with devfreq support for the lima driver I experienced
> sporadic (random) system lockups. It turned out that this was in
> certain cases when changing the mali clock.
>
> The Amlogic vendor GPU platform driver (which is responsible for
> changing the clock frequency) uses the following pattern when updating
> the mali clock rate:
> - at initialization: initialize the two mali_0 and mali_1 clock trees
>   with a default setting and enable both clocks
> - when changing the clock frequency:
> -- set HHI_MALI_CLK_CNTL[31] to temporarily use the mali_1 clock output
> -- update the mali_0 clock tree (set the mux, divider, etc.)
> -- clear HHI_MALI_CLK_CNTL[31] to temporarily use the mali_0 clock
                                      ^ no final setting then ? :P
>    output again
>
> With the common clock framework we can even do better:
> by setting CLK_SET_RATE_PARENT for the mali_0 and mali_1 output gates
                ^
From your patch, I guess you mean CLK_SET_RATE_GATE ?

> we can force the common clock framework to update the "inactive" clock
> and then switch to it's output.
>
> I only tested this patch for a limited time only (approx. 2 hours).
> So far I couldn't reproduce the sporadic system lockups with it.
> However, broader testing would be great so I would like this to be
> applied for -next.

CLK_SET_RATE_GATE guarantees that a clock cannot be updated while in
use. While it works at your advantage here, I'm not sure CCF guarantees
the assumption this implementation is based on. Some explanation below:

In your case, if it works as you expect when calling set_rate() on the
top clock, it goes as this:

- mali0 is use with rate X:
- => set_rate(mali_top, Y)
- mali0 is in use, cannot change, will round rate Y to X
- mali1 is not in use, can provide Y
- mali1 is determined to be the new best parent for mali top

So far so good.

- CCF pick the mali1 subtree
  *start updating the clock from the root to the leaf*

So the mali top mux, which choose between mali0 and mali1, will be
*updated last* which crucial to your use case.

I just wonder if this crucial part something CCF guarantee and you can
rely on it ... or if it might break in the future.

Stephen, any thoughts on this ?

PS: If CCF does guarantee "root-to-leaf" updates, I think this
implementation is a clever trick to solve this usual glitch free clock
update issue ... much more elegant that the notifier solution we have
been using so far.

>
>
> Martin Blumenstingl (1):
>   clk: meson: meson8b: make the CCF use the glitch-free "mali" mux
>
>  drivers/clk/meson/meson8b.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

