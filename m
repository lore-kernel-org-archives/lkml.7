Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F45C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD56320657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558020852;
	bh=c/Ww38rbeWEMoEnApqwj/Lfd8wWBBmTodZUl6xVKf8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gsQ/wQ3YwQjMlJTNKjiltSHI4MQY2X27Ba0K4JkwuA1mgnwbMZMpW/YdTa6wBgvZg
	 1hsW4mjALDeYmXN0WLzTSQlj8qfwyzaXPoeFAzBdqunfXaCOSzHuqqWLr7YpUVjCSa
	 worwCL83mYrZrGEN0ho2Vjqgw9PPeRQZdEN+oNLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfEPPeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:34:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33961 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfEPPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:34:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id j24so3557171ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RgkwpdYQl9vPdtySryKdVHRySf6tMU0/Ia1tcv4ix30=;
        b=DKcHZXmijDxQRqkKIEARtaTrF1akUPSYdG4y1zbgCZsstI2PKmflfIqn9R57e8r0bh
         beB+bnHkDd1niy82QG5AzYmQWg6fbD+h8mWkc+3ifWzxXdAYcZjoEFdaTZdz1cx7ceUL
         B5FI8/pi3t8ENGgO3YVnls3F5P42rYCR/JXvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RgkwpdYQl9vPdtySryKdVHRySf6tMU0/Ia1tcv4ix30=;
        b=QBgPKunxzlE2pzAeAYn34diiwrYc5l2i3WqYTVjvcx8PymtX2JKJtdWC83Gliee6sf
         EIrYInLiYXG93Mkf86fdAMVTjCyLnAsBMcT3pdJk4/5lJfTCbwiuUJALHIpBuIWcLjr3
         sEw28a71czhHK44iKj7hBjzyUACvRXxLK3/ymYwOAlJHV+WSP2zJHrhYNjv1iu8Q+BN7
         K2rixEGyMCrSUhSlVbhN/fclYdy+oXYsvx+3jnbm/hFSwfmo/BglS8AYKxeK+EmhXm+m
         qn6tCtjSor1pjkRGSpOmYtxxC8D0sLrGfuFwxP2eP6G87Za4YCFAWrSGDELPEaFkuyEa
         ZvAg==
X-Gm-Message-State: APjAAAXuNGQvj5BVrQW/3rzmUaYp2BwReGGSaNEKFsT7fZK4pfv/64gC
        jlfmrWWBJtWliRj8hzFISiXC2jXEDhY=
X-Google-Smtp-Source: APXvYqyEalNyHAapoC3EXhVfTWyFQSisSDv7f9FgyD+C/BE0ZsY+bBJERpYP1sot59FZ0oYv/j+Umw==
X-Received: by 2002:a2e:9747:: with SMTP id f7mr21731187ljj.34.1558020848491;
        Thu, 16 May 2019 08:34:08 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id b15sm957177ljj.1.2019.05.16.08.34.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 08:34:07 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id j24so3557058ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 08:34:07 -0700 (PDT)
X-Received: by 2002:a2e:9a94:: with SMTP id p20mr14460647lji.2.1558020847152;
 Thu, 16 May 2019 08:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190516064304.24057-1-olof@lixom.net> <20190516064304.24057-2-olof@lixom.net>
In-Reply-To: <20190516064304.24057-2-olof@lixom.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 08:33:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7uZ+rLecwEP+U3jRRPWRoB1QVTr8pHzTcmQadE=Ngvg@mail.gmail.com>
Message-ID: <CAHk-=wj7uZ+rLecwEP+U3jRRPWRoB1QVTr8pHzTcmQadE=Ngvg@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] ARM: SoC platform updates
To:     Olof Johansson <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     ARM SoC <arm@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:43 PM Olof Johansson <olof@lixom.net> wrote:
>
> SoC updates, mostly refactorings and cleanups of old legacy platforms.
> Major themes this release:

Hmm. This brings in a new warning:

  drivers/clocksource/timer-ixp4xx.c:78:20: warning:
=E2=80=98ixp4xx_read_sched_clock=E2=80=99 defined but not used [-Wunused-fu=
nction]

because that drivers is enabled for build testing, but that function
is only used under

  #ifdef CONFIG_ARM
        sched_clock_register(ixp4xx_read_sched_clock, 32, timer_freq);
  #endif

It's not clear why that #ifdef is there. This driver only builds
non-ARM when COMPILE_TEST is enabled, and that #ifdef actually breaks
that build test.

I'm going to remove that #ifdef in my merge, because I do *not* want
to see new warnings, and it doesn't seem to make any sense.

Maybe that's the wrong resolution, please holler and let me know if
you want something else.

                Linus
