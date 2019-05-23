Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4440C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B303920879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeUasp/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392068AbfEWTe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:34:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34376 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387947AbfEWTeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:34:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id j24so6585697ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zEdXi9YQ9/PVR4ABDgc5oGstALKw+UDObwes1f/BG98=;
        b=VeUasp/nnilSR6G52vcxOnkUGJ5BU1C3y+jVW5I+Sk31loGDYD+0/OPsfjHw47uxRD
         XrahVXJxoor8ACcJ27z0OySYERZUEw7TzTBWEDU2mGo2DdFb3uIrbTMYcnz/QTQHfwYG
         +F3f+cK3YX5vYB1mNMAk16hmd5y44YYJuFU7n/VvSwBttfzg15gvV9UYhLSSI25lgXH9
         8Dcv1E/j3LZhKUEUXkPCM4sokOXChPvpUfAYb9nIiQ4ODUlM/aekq1QzOTUR+3mYLxCL
         w3qEh67Z4vDW4/T2Y9ZqmE3+M/TAHoeYBryiLSUXViQg9LWV3ApsJHDm3vuo3ValJI4S
         vlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEdXi9YQ9/PVR4ABDgc5oGstALKw+UDObwes1f/BG98=;
        b=ZanirnOr96HVNFdrUL54NPdyIQREzD5AHAnRnHBCZacsajxuEq7iW8kaMW6nK1MmVZ
         oTjdlZsxSqDgHkMCezbf/VrcT0Cq8B/BaD0Uck2v9bMvqLmwPiR+TEngtCw29rJ6FWiW
         2Obu3psRNdY9jaF8GtpxdEHR0dls0ngL66CTAtRzkbQqLSFMe7+mXFdnA0Z2sdvApgci
         7sb2+F76cjb2gJFdZXiy49eX17sXLnkjcz4Kcirp5Ih3/nfoF19ozdUg8k8hNLlycWr0
         q9/kxGEqy6Q4emvFMZBpbiGgIgLPrymBqzM/I5Ofnsm3muoDssoM5BFFlFjz6YIcE44V
         Ew+w==
X-Gm-Message-State: APjAAAXKJkUTSOdOJALUw29lvL0Tjh/s1DyyPJ9Nu0oBaWh7gN9D7OqR
        8d0xljcIuYoodZnsez2OvyABVFM9cTMV8olWeOlqag==
X-Google-Smtp-Source: APXvYqxS49q1gB/9+MX0Pw4nbYPSIUWDf6r45GnAk81uVyDOoTg2BLY0kTVzeVnskN1RmSdLk4myFHA4dwsnUm3QOI0=
X-Received: by 2002:a2e:874b:: with SMTP id q11mr21679456ljj.48.1558640061895;
 Thu, 23 May 2019 12:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190523181602.3284-1-linus.walleij@linaro.org> <3496e81f-ea63-794d-0d8a-8eba9f2f6853@linaro.org>
In-Reply-To: <3496e81f-ea63-794d-0d8a-8eba9f2f6853@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 May 2019 21:34:09 +0200
Message-ID: <CACRpkdZ5LCeqkvJrN-TAcSy7knNOQhGV7M_wfZZ4Rz5ah87KnA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/ixp4xx: Implement delay timer
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 9:21 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 23/05/2019 20:16, Linus Walleij wrote:

> > This adds delay timer functionality to the IXP4xx
> > timer driver.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> The patch does not apply on tip/timers/core

This seems to be because tip/timers/core is not yet containing
the commits from v5.2-rc1.

Maybe I just send my patches too early after the merge window :)

Yours,
Linus Walleij
