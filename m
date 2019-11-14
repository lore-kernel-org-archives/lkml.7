Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F4AC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C7120725
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdkk2lcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKNSRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:17:34 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45765 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfKNSRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:17:31 -0500
Received: by mail-yb1-f196.google.com with SMTP id i7so2917090ybk.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 10:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PL2/BS0frIN9r/rql9vL+NYiXX+POn906WNUO708kb8=;
        b=tdkk2lclgAaaumaNuSA2n62iBAg3Vc2V1Cb8sFANskZSlwGCCgptxnkvvRwnz3qULC
         /tCHSmgVFORwe95/A/AS7NECcmHhE9zkiCxRrqMxONwuZIfnCbszRQ4rXmnH/eENuicE
         ZRIgZFBVgGGX1VHS0eOQPHWxS0aU4PYeLs2/QCsfMFgXSxT7a0JylQ+8Vk4pWGafzeTl
         FUy9hvkPIbKiiAj3JMvm1hgjl+xCWiRbB4ANJIBbz0MEW3+yt3+Gd1Dg2nP+MnVbItMs
         vx8/5948mpDKlbpB2wVhBfJFXO2I6drHuSXoIaOtvuYWbvrN+dPLNGKtLiI+QG9VjDz1
         4UUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PL2/BS0frIN9r/rql9vL+NYiXX+POn906WNUO708kb8=;
        b=XejETBHrLZtppO7CL5bvAbYyUreveFGqhBfHYLiLfhYcGVrDnjMG/iePQZP1yix+4y
         mlr5U8wQSUqfqTRzgK6zEFcwyuTZcgfkm+xj05cWtftOmCD6fUbdad7buVM6HAEhRLR7
         lDE4Zg33+HT7SpAzLBuTDx84lO9W4yAdhObyON9lDBUekupfLPxrZdFWJl0MY9HzOwfC
         xWg8oh1sEno7LNBFNV6E919PhI6UuSLGuB0DSukWOzsSoqqEAy/jB5t6EsRVrX7tarlU
         So5uLsm3uooLxChPiBbeDYL0zrk2LO7X6LA+EG2eaBfsIDOA2yg/aUkkIzq5d0xFzr73
         xPpQ==
X-Gm-Message-State: APjAAAXigkZDzSLOgqVJ8IGKTJTuYZ4AOGTJclOKskGjmd185/wy5D6q
        +ATmbsxkOogrf9Ka4REW3tTZZMdnbm5ArJe9mXUlo9T+
X-Google-Smtp-Source: APXvYqxwKK1fcX3dN/1WnWVywPIQVg3vwTClEHlB2e9J8UOycek5FQVewADIfuiWdljL74dEyViCieXwgHIHFupeDAQ=
X-Received: by 2002:a25:778c:: with SMTP id s134mr8530150ybc.143.1573755450272;
 Thu, 14 Nov 2019 10:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20190923143620.29334-1-valentin.schneider@arm.com> <20190923143620.29334-10-valentin.schneider@arm.com>
In-Reply-To: <20190923143620.29334-10-valentin.schneider@arm.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 14 Nov 2019 10:17:19 -0800
Message-ID: <CAMo8BfJ86CH1w1NUKz-hWNstCARbivaBrx0_uKOrBgxCfNq9OA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] xtensa: entry: Remove unneeded need_resched() loop
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 7:36 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/xtensa/kernel/entry.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've applied this patch to the xtensa tree as it doesn't seem to be taken
anywhere else.

-- 
Thanks.
-- Max
