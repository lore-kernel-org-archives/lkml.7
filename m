Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A18C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACC620811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWcICmXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfCHJQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:16:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33337 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHJQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:16:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id z7so16792217lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 01:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7/bOC9s2XquguMVvphTUm05f0wnk35pCiCklj7PQVkM=;
        b=PWcICmXO8/MWkzH7Hkqaqle5vUCYNMH/MxF4T9+s/N3U1DhqOqqjLJI9o543UqELwF
         Ueuwi8/NlCylKGgj2CVAFtUADxSXenWQ8CHy+JvoAtlK/r+kfYHxymu0hBdvAgxiK6L7
         Q5esut0zBLsjo2eWwz23frvrNnsZaSC+VAZrZPBicj5GuqFFgdGXlWZaKSSeaWNYSaXL
         kEJgPep5ZD7UidwXRsI2pkwC79lVWzUxMRbQjNV1NH3322nW4fMVqCK24zJ5ZtZDkFO9
         e6UXixX2ZSLeVB3+JauNJdyvtFSx4WZ2aTjFU2yjepA7v/SmZ4VOm60HzB+hxhOC1zvx
         Tf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7/bOC9s2XquguMVvphTUm05f0wnk35pCiCklj7PQVkM=;
        b=RhIkeB9WZ1Cw1neuVaDqqp/SgOAZmgf/1Q9Ma69kTPRaLZF8qwtCQRqRsGpi5MYEz4
         BnkmbTm85WhIejSmhXuBy4p+JLAIV/C6yW4y3iHisBNn8FaZsvAQEPsBPvM//2sZrdpa
         uPMDVkO+jMQOGrk620dyj9CrbZhL334Ya7+0YOtJoCUxAym1UMGRx9ypkBP6KyjQgfFf
         EXAMyO5hyJfsNsCy+rY7Ko6lc9BZ4IYYwCwWj84RXXULyQjw4bGc3nQieWOz9uBw57hx
         OMWKXXhs+O3+StbG9QGhtdKlHTUdyg2Ydc2Su4IO5DJiRef4nOqQkXLYT7QaKEjGdku2
         Ezyg==
X-Gm-Message-State: APjAAAXuPfMfCXWKJpUvupzm5AOs9Pr35I22a9lARkuqX8VCIfu9I6Cz
        9vuLXNxx5NqDVAhxjZvBJXvMgmKJAXeyiL6yygsKEg==
X-Google-Smtp-Source: APXvYqygvJm+WpiJBg8UVgFmbWHC/NYT/nOqz3ToivjsRfQa3kq5GifUkZHP4fvP3si5i0TifOo1Y8cY/kc+DpWZ7I8=
X-Received: by 2002:a2e:208a:: with SMTP id g10mr8490800lji.135.1552036561755;
 Fri, 08 Mar 2019 01:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20190111162516.28197-1-poeschel@lemonage.de> <CACRpkdZFFu=wgHw0BqXUHiC5euGwWuYbr5bH60zDvFr+q394=w@mail.gmail.com>
 <7ce47f34-ed9f-44ac-b966-68e3bbf3b052@cesnet.cz>
In-Reply-To: <7ce47f34-ed9f-44ac-b966-68e3bbf3b052@cesnet.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Mar 2019 10:15:50 +0100
Message-ID: <CACRpkdYJHyj+TMOde=veQsj8m+xFf0XGEnT0DS0qgMXCSA5iOA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mcp23s08: Allocate irq_chip dynamic
To:     =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 4:19 PM Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz> wro=
te:

> This commit should probably go to 5.0-stable and 4.20-stable as well

I doubt that this commit is fixing a regression, but who knows...
> If I cherry-pick the following two commits to my 5.0, my board boots once
> again:
>
> 16f4372fd7a5 pinctrl: mcp23s08: use struct_size() in devm_kzalloc()
> 19ab5ca9b77d pinctrl: mcp23s08: Allocate irq_chip dynamic

Hm weird.

> As on "why am I hitting this while nobody else did", my board has a share=
d
> IRQ line which is active during bootup, perhaps that might have something
> to do with this -- I don't know.

Sounds like the code in mcp23s08 .probe() should write to all
registers clearing and disabling interrupts before proceeding to
request interrupts or register the irqchip, else it will fire immediately
and cause oopses.

Yours,
Linus Walleij
