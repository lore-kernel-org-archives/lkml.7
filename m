Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0D0C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2E12085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZ1X/sIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfENJhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:37:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44523 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfENJhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:37:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so269290pll.11;
        Tue, 14 May 2019 02:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvMTiTp630B1RClH7jSrtIkHfKMtygVVx68tUAbzGQc=;
        b=uZ1X/sICHLjRWIm1T95SwqeFod/jCmB0IDLQf9xRYTAXDmPepVuoX4qFz1uVdggbSV
         /x807dOc2tlpIfYooURCHEbgAvlcKYqm4T61DDEPa39E6yGabRqE9DmnH368/IjFHG8i
         SDJwny4kz5XblkgbqBq3WgO7F4eUmH5YYzyJXYQC5yGZVSg2gCrXAd56b62NPAKFNvuU
         bO31pI2pPcLfuQ2ofo1JEAFlmrEmAsueziKO4zsJ+gfPkMINl2ByPU5H+2y5Y8ABohyB
         56EgOXNU5G4vGVYKfpZm2A7hBnO5Q52OHvCrw5EpI1BSMAI4zvuArM6BmmyUwE3TLbBu
         WYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvMTiTp630B1RClH7jSrtIkHfKMtygVVx68tUAbzGQc=;
        b=L0FJ8TRrATE415wn/3SLWsti7JW9u7NjNm9+z7tXQNLF93kRRXz8yXH3XChZKkqvDJ
         3GaYK4ziIroq2dADAnKhBRq/hYzar2ZwUMU0Utmd7vP9gNa3H0I93XKFb2c4ag77yMUA
         4xI2vUbiT1nTXgL/XeCn9xzpleBnOPnFXzVuEvWJIcpp53unQ99H1HSg1Nzr5hpUAu4v
         T/8DWsYWvRYlov4K5vI0bnxo9NvE3ylQc9VtEk8tLoBMlk+ytu9ZevM5cLM1kkOREL9J
         DfnrkdxnQ57zzMsF791cb6gpxHKVENCX98Z0jyS7VRkGQEa5/lhwnjQEnrHLG16pgHsF
         GVhw==
X-Gm-Message-State: APjAAAVcwc2fAq270oKulOQVtngRrHq+w+wh0Lf7qn/aluMV/eiKy/FO
        4TZJ4/KyhX2xptPFf2Jc0GG1KzeDKTigAx2d4zN3H+Q/
X-Google-Smtp-Source: APXvYqywlyuT/yYUMuVyxYjm8M1x9tR+efDT6lZyKMLEiLPXIxwFVggHCyUkrd6eNliOjK2YJZqkiJWYNi42YUa8ir8=
X-Received: by 2002:a17:902:7407:: with SMTP id g7mr2022271pll.311.1557826656741;
 Tue, 14 May 2019 02:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190430140416.4707-1-esben@geanix.com> <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk> <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk> <20190507093239.GB4529@dell>
 <87sgtqjy3l.fsf@haabendal.dk> <20190507115325.GV9224@smile.fi.intel.com>
 <87k1f2jvyd.fsf@haabendal.dk> <20190507150847.GW9224@smile.fi.intel.com>
 <87k1etmrfk.fsf@haabendal.dk> <CAHp75VfrP6SLVzmp6LepN7dU1c7QYxfRDRtj7dCTuWzmYp2tCA@mail.gmail.com>
In-Reply-To: <CAHp75VfrP6SLVzmp6LepN7dU1c7QYxfRDRtj7dCTuWzmYp2tCA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 May 2019 12:37:25 +0300
Message-ID: <CAHp75VetoajaeqUnUuj4sNjhujqDkbqvQmxE+LMtzFN4so_jwA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device resources
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 12:23 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, May 14, 2019 at 10:24 AM Esben Haabendal <esben@haabendal.dk> wrote:

> > Please take a look at https://lkml.org/lkml/2019/4/9/576
> > ("[PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip")
>
> Thank you for this link.
> Now, look at this comment:
>
> + /*
> + * Map all IOC3 registers.  These are shared between subdevices
> + * so the main IOC3 module manages them.
> + */
>
> Is it your case? Can we see the code?

They do not request resources by the way.
You may do the same, I told you this several times.

-- 
With Best Regards,
Andy Shevchenko
