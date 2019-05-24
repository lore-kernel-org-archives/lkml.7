Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0EEC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A05F20879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2nXicON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389555AbfEXPWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:22:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37205 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389314AbfEXPWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:22:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id m15so6839243lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 08:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyF3o58FFX1H1q5j3kdiPxjWQwX8mwAfxQ1M8ShVyoI=;
        b=R2nXicON9l8j67j7PadKSRB4aV4W8j0X8VrwwypSh5dc/jQT2y5uUN8rZSpBv12B+g
         WI80lgH2mR8r7dRtZOOv2HePNQnSEUDtSG39KhmqNSiNiNkYA4OzyUBagAy3bsf7YDqU
         WpU+CA4s+vDA1kVZj7mmPnOOihogo5bRT1jbpXir6J/KOpZ27oTLsUSdfYAaozpPatwA
         1sRNLToQWgrSwoDi8cex+LE58QAxSyaW4ykyLPlSzUgydnGj2DgGMBXKvmwm1baKM5dv
         u848+Lu1/GSCycSO+lRYhXvlzCIviyFwen68e8/QHujHkVUwZLTw5Y6Vk3wuTMC3KND0
         JKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyF3o58FFX1H1q5j3kdiPxjWQwX8mwAfxQ1M8ShVyoI=;
        b=GZbAebv9bvjOqAYe65JTRJfUzjCO3UsV/H2rlo4msMeiPk8T2Pf51Esx6blWSPCbt8
         V12PGQXlGdLC75cfIbzo7MnyqiUwTcrAPqwb/ktX30osAQQo7gkUrrJ+/Lb26Tgpcg9O
         MhNH/YJNZXrYMjuHQ+LrpwAS7jrwWzs74HU8CE4PvwAHw9M12ebuXhEtpOw3kwRFBaGb
         3yHQ7fMYjeqxyZfi7UyrY6WYhjgBAQ/tMYaNZIX4828MnfuExiahUOwM0zKiBa9vsDDy
         oqcJfP8sAMUXPw/wY/OaUxyhiqnwa4geC/R/QIs0agNeRtzB7RMCVXBKTkV6FOtYzDMx
         pyMQ==
X-Gm-Message-State: APjAAAXoXyzRa1W/leYLxIhNWTgpeA7NA+NaZbHDXxjwyOnZC4v+9yoB
        7Z0BLnckzRK2SVQlv9SbkcP4L9VfkJcvzjBREfCGVw==
X-Google-Smtp-Source: APXvYqwmvwWHGvypE/OcPxIOvNOsboOsJx8yQtKE+WMD3B1aEcSgE8sirRO4jcp62+tgDg3VjDVnaACWJ1dbGLlT+EY=
X-Received: by 2002:a19:f60f:: with SMTP id x15mr351461lfe.61.1558711341073;
 Fri, 24 May 2019 08:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <1557474183-19719-1-git-send-email-alexandre.torgue@st.com>
 <CACRpkdZ4P=PSCu86p48nBPeVk-h5T0Ytc1CYV3XZGd4fLuJLGw@mail.gmail.com> <ae00fd9c-d25e-c401-4d21-d526a63538f2@st.com>
In-Reply-To: <ae00fd9c-d25e-c401-4d21-d526a63538f2@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 17:22:09 +0200
Message-ID: <CACRpkdbJKAGyeBU1tX77-wSYzGXDBqRYR1gQyzOZ_XT4RGFbsw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: add lock mechanism for irqmux selection
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 2:27 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> On 5/24/19 1:26 PM, Linus Walleij wrote:

> > Patch applied, can't say I fully understand it but you know what
> > you're doing!
>
> Thanks :). Do you need a better explanation ?

What I need to understand for hierarchical interrupt controllers
on GPIO is what I can pull into the gpio library. I am working
to extract some code from drivers/gpio/gpio-ixp4xx.c
to make generic simple hierarchical domain support available,
and Lina is working on generalizing some stuff.

But these complex domain operations in the STM32 seem
to be some special beast.

Yours,
Linus Walleij
