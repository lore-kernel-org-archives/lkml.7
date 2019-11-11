Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD515C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD274204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcluWyIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKKIR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:17:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40108 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKIR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:17:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id i10so13529734wrs.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VsDEMrW/RrcxhRY1vm2HEmbhOBjQCGmnH7miF+ASOOE=;
        b=dcluWyIwC0AdhNW+RROY3tTV7NkIFLNALJW6YRUeoVaa82SQwt80DfSxG1hGtkz2pq
         VELwGauGVA+xgVx0MK+yrpkr65Bsw8gfIgFPGpg1Qe4V/boROsLDw5WjHU7IZNpjt39B
         zGtNnDZ6Il+huxIOnoaJqLX7un8nvqDdqrwy+Y7LJUENYR6O8crz7HtuhJpfN61/AzgZ
         8fKYF4TVSk+fnXFT4lBf8vdGMlCT1w5UUE2+WMqs0TYdJYvK8gSxYJU8BGZDtuRoIrSw
         Tso2FqKD1HWi/+RUWE7FY7PVocvZKmfMYdJcHYDaVMkqsCjmtpfY7v0A4uzZG0z/tjxa
         42rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VsDEMrW/RrcxhRY1vm2HEmbhOBjQCGmnH7miF+ASOOE=;
        b=JSf/12SRMRM3WzLL90LnbnEm6vzscosMkEln8odbsAVM7rrDYJLuVHNsPoITYvW272
         LF725Q7Fdb75Ew3Xkb9vnkhMLr+bgK2OvC7PUsaInWa8aCjZ8LBybaRpnzOsm5nqV7F6
         glI7ZXe8PMISwNNGqBWAKb/uWNGmJ+YKLrgmPyyPdsXGkInRmwhs6j1iPKVGZrFSyx48
         eIIo3pckRhhfYfLoE8UNHyiqoz935Gofupc5NOYv97vHQZhSgj+MywkSlfgSr8QKDmVz
         f9Mrnopx0HlraHTaI+LadEXLWCqKNPy9TkBGqHcBjnL5dMPkYLY/pULwx+8+fyLVE7P/
         TMWQ==
X-Gm-Message-State: APjAAAWOtwZVkWG8d83vE+NYijwZjtCAJvgc5SPbLJRCVc8NixZ3ZpIQ
        FcYzQG+JxUT4DhQaCU27FKlOSQ==
X-Google-Smtp-Source: APXvYqw50g+Lc1op/Iwn+RwSQf/NtoeqZxi2CTsp1TjaRTk3Ol3VsnEatrEJSlf2I+YA9Qr0Q0gKvw==
X-Received: by 2002:a05:6000:1083:: with SMTP id y3mr18797692wrw.290.1573460244631;
        Mon, 11 Nov 2019 00:17:24 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id i71sm31948761wri.68.2019.11.11.00.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:17:24 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:17:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, arm@kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v3] mfd: db8500-prcmu: Support U8420-sysclk firmware
Message-ID: <20191111081717.GG18902@dell>
References: <20191026214732.17725-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191026214732.17725-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Oct 2019, Linus Walleij wrote:

> There is a distinct version of the Ux500 U8420 variant
> with "sysclk", as can be seen from the vendor code that
> didn't make it upstream, this firmware lacks the
> ULPPLL (ultra-low power phase locked loop) which in
> effect means that the timer clock is instead wired to
> the 32768 Hz always-on clock.
> 
> This has some repercussions when enabling the timer
> clock as the code as it stands will disable the timer
> clock on these platforms (lacking the so-called
> "doze mode") and obtaining the wrong rate of the timer
> clock.
> 
> The timer frequency is of course needed very early in
> the boot, and as a consequence, we need to shuffle
> around the early PRCMU init code: whereas in the past
> we did not need to look up the PRCMU firmware version
> in the early init, but now we need to know the version
> before the core system timers are registered so we
> restructure the platform callbacks to the PRCMU so as
> not to take any arguments and instead look up the
> resources it needs directly from the device tree
> when initializing.
> 
> As we do not yet support any platforms using this
> firmware it is not a regression, but as PostmarketOS
> is starting to support products with this firmware we
> need to fix this up.
> 
> The low rate of 32kHz also makes the MTU timer unsuitable
> as delay timer but this needs to be fixed in a separate
> patch.
> 
> Cc: arm@kernel.org
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - It's a bad idead to return -ENODEV in a function
>   that returns void.
> ChangeLog v1->v2:
> - Change the style of the ULPPLL check function (more
>   compact)
> - Fix a missing of_node_put() by actually returning
>   with -ENODEV on error.
> 
> ARM SoC folks: as this mostly affects the MFD subsystems
> I think it'd be best if Lee can merge it, I do not
> plan any other changes to the ARM core files that the
> patch touches.
> ---
>  arch/arm/mach-ux500/cpu-db8500.c |  2 +-
>  drivers/mfd/db8500-prcmu.c       | 63 ++++++++++++++++++++++----------
>  include/linux/mfd/db8500-prcmu.h |  4 +-
>  include/linux/mfd/dbx500-prcmu.h |  7 ++--
>  4 files changed, 50 insertions(+), 26 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
