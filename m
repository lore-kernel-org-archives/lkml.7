Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D282C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 09:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7324E217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 09:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWXfmIvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfHJJEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 05:04:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43039 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfHJJEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 05:04:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so71218285lfm.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2+7/rOX4aw3CppBe0IexN01CpzL88m+5LBEHDnN2Rw=;
        b=UWXfmIvt1zHaFkYC5PiEheTFjDL7HpdPy8/pWaB3rltMoL9ZOy12Kw00PkfDPqoeJQ
         jmRSwYU9WauFsE0125chERnsi49PwatStXmIjANuzt+o49gfza6ZiEewStFi2akTWgfH
         ZV+U45AZD5QA5/Op6qprG+kqufxr42/yviarDiT8gBrh08xIqESd5EqDzjccW13UtbOJ
         MZQaHFi21rewWbj4Bgp3SQPPwwUBLsNvl/1xla1CxRJ13EwijevHjFLBmIizayRtbJsa
         7j+8aXU3zI1JFycLadcUOet0i3qvQggkICji+NvunvHtjHlFDtKt1KTAGtO4U2THdX10
         Os7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2+7/rOX4aw3CppBe0IexN01CpzL88m+5LBEHDnN2Rw=;
        b=fNR+JavhZiQlMdxHMWBd3cbWtcbEHXzd5utFb+s6wy/V+Kydc7vunUZFOJSQVJqzeg
         9khztV4HrNZ80vsBzwp53K/Ui/NeI5vDxWTYEPlIgkvK5JEiVn3jV8ldleC205vBi7Yp
         58eXAf08ODUqaXVfblvsZEsH8tXiZO3U1IZ1XT2j+t9yQOI+59cvc0lZdoTi28C+M3fh
         JIRRI9I5Xb78LQSq8ObRMy3AZTzAQGG2uIqyf6ysQq8jLqZ3jDbZ6QP9Vlu/9CBAgroS
         cPGScvyivhTbDodA04z4RjZ7HsMnG6g9TCXJ0y6WVlSb0zJ0V33YIgu/A+fv/AS7Rl+g
         kMhg==
X-Gm-Message-State: APjAAAXIvQqTjLz2eLgRugrvUqs+NpMNKLuAsgURRKINoGkJYLKXCaS+
        ZKLMJX4K0fGQY6YVyOELHQj/HAZMI9RBXuDnAUmnug==
X-Google-Smtp-Source: APXvYqzI1OUT91BOym1WtVyDuCF8UlcJ0q+oCBXUIJCXfURb7tSXeCn2SRWNYfl0AXcRv204POPlchz1LNHOB+/AQyY=
X-Received: by 2002:a19:ed11:: with SMTP id y17mr15054737lfy.141.1565427842907;
 Sat, 10 Aug 2019 02:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190809202749.742267-1-arnd@arndb.de> <20190809202749.742267-4-arnd@arndb.de>
In-Reply-To: <20190809202749.742267-4-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 10 Aug 2019 11:03:51 +0200
Message-ID: <CACRpkdYRpsoxwCjGW2JOJCCgs2xGztKHk429gg4SMOwgqvG+Rg@mail.gmail.com>
Subject: Re: [PATCH 03/16] gpio: remove ks8695 driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 10:28 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The platform is getting removed, so there are no remaining
> users of this driver.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied. Thanks for cleaning out this old cruft.

Yours,
Linus Walleij
