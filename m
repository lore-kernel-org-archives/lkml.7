Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B16C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647042133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 05:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpp/wAae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfJGFAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 01:00:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39411 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJGFAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 01:00:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id a15so11160149edt.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 22:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTKd9BxTt/PAleEHYrjbGfQDxHC83timSY4p9uhdwxY=;
        b=jpp/wAaeud60o+Kl7w9WlxT8iTwbj6sHztRpaSL75wX9NPyzkBBrCkH/6sPyflDarl
         vxUtZbmPjoPH5/m3TQ9hmxXwpzzKdlsqzwtO/TY+jSVi80hfcp4dkC2b04oHL+fchDbx
         uvNFIxIWDgTqvMqC0DR5jLGEsLOipA46UEJmYEPciuuKdjvN9FLXhiQX/dog7ReUYs1n
         CY7RVtN/yQbS1jy8jkmKICkUWFe/ReaIV17hnqUAwSXytHuUayYDfMuJHl2YOvSxEBSI
         IGmv45HX59a3KyVfBunrXGeq7noibUuPEH0T76jZAwkpKRikGQgncqHxmouWDIRheR8M
         vy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTKd9BxTt/PAleEHYrjbGfQDxHC83timSY4p9uhdwxY=;
        b=AIw6hKtGKt9GdlcWqWsM7pT/gFHnS3Yi5zrZjZThbODVcqjn5Zw0M3XMpPUsYeRjIZ
         9hRputxeYXy9hOiA1G6jtOq20SM87MuuJ3WIRSlxQuNHf1ivJhgpMhaHEplDIE0uVCLw
         Vyrf1xRT7cv1lXcG6DjcYOSUAAD+lbE7DNKZxC1w6L7HKUhLYhBcFuqPteU9w/qrjFWp
         peKDimxZ7T7cU8cQ7nsfACflwWho7nXIFbb8oB/srZp97nXM6BCkdSBFeJc6HOTQXtl7
         qdUzByJgtsgWQAZ5rIl7w11dN/kha1LLLXCfv8kROycHLhk2zPyUkBJsZCkCjsb/RLp3
         fAwA==
X-Gm-Message-State: APjAAAUQJvNgUm3Xolz6PqyF2KxECoGQEycZkQuz8G23zZJ/KRN+9enS
        xwVswhA2mVgaMt7K+fX3F2NYw/RwVJ6g9VLhApYyHQ==
X-Google-Smtp-Source: APXvYqwCVgUVK4pofULcj6U6CcXacuCiAQAAUYp38BKbJHzMKdZXN0wRWYmmhSAPZ6sV0SFKGw/arB24iK2NwnfUvtU=
X-Received: by 2002:a17:906:57ce:: with SMTP id u14mr22483243ejr.184.1570424430064;
 Sun, 06 Oct 2019 22:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk> <20191004133207.6663-7-linux@rasmusvillemoes.dk>
In-Reply-To: <20191004133207.6663-7-linux@rasmusvillemoes.dk>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Sun, 6 Oct 2019 22:00:19 -0700
Message-ID: <CAOCOHw7TXj2zr7qoown0rM=W0dns4n1o+9gOHr_8=vebzH=bMw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] pwm: update comment on struct pwm_ops::apply
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 6:33 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Commit 71523d1812ac (pwm: Ensure pwm_apply_state() doesn't modify the
> state argument) updated the kernel-doc for pwm_apply_state(), but not
> for the ->apply callback in the pwm_ops struct.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  include/linux/pwm.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index b2c9c460947d..0ef808d925bb 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -243,10 +243,7 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
>   * @request: optional hook for requesting a PWM
>   * @free: optional hook for freeing a PWM
>   * @capture: capture and report PWM signal
> - * @apply: atomically apply a new PWM config. The state argument
> - *        should be adjusted with the real hardware config (if the
> - *        approximate the period or duty_cycle value, state should
> - *        reflect it)
> + * @apply: atomically apply a new PWM config
>   * @get_state: get the current PWM state. This function is only
>   *            called once per PWM device when the PWM chip is
>   *            registered.
> --
> 2.20.1
>
