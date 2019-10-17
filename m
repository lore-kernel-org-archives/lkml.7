Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B70DECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF9420869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgiTnz8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394497AbfJQNXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:23:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54935 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbfJQNXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:23:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so2552096wmp.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=w6ztz66F+XUhul9dF9IbLT3GjbciXy1TD14N9xxwUhc=;
        b=rgiTnz8TbEsBCg1prLfdv0eg5SkZU1fwa2hpfuDtD1TuNuH56nwGXcWjVe2rDdSsgL
         My2TSbqBqTP+SxFwAQLulcSksIdQb1hTv9Ths5+IufIjuYBOBslMoy9vUCRjlQZH1NHN
         vY+gEtpTNqLG8aYs7eLaJ40/Bh7fiNh35pXrJQYBnd43/wsMXkfjQRyyEpW6hBdd7l7I
         KZTbEJRTZFPZ2o9c1ced83Z91QmSCbwDBChTjt8pCZ6Ry+va7Izul+/iEh7glpwWJA7j
         TUkVfotpb9T4QIJA5w10qaXrTrxVOdYe9Wn799NoWJgQ1BzzUTWzjPsZfF95wp9SJmoF
         8iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w6ztz66F+XUhul9dF9IbLT3GjbciXy1TD14N9xxwUhc=;
        b=NC1WgDZwwmsQ4CCE2abGlWASKkB7DvXhZ6x98KWUhOWBMG71OjOFrPhLA5gIcWaOAU
         u+bAPMviBxppdUCZhCTyQO58DJXP9n8W2tQIJsrDj37YzctPNSlyNX1mhgh9whBAQnbC
         l+ot2E8Oafug6vkKo89UDwy+6blkG/kNM7h86Pt+DXhoYZzkFvMr/PfekIGebgbGJWyF
         bC1Bd16upbP+r2d90U2uvY/7Rq/kXc4N7/i3F0ic18VpfY6mbYPExZz13sHqmPH97x2Z
         dfIv1QWIikPj+a2POm/laz/00T9Lz8ufKJQ1CHwUQjHV0P41/evRdCCQuwFHAxQC99jn
         LGQg==
X-Gm-Message-State: APjAAAW+WXSYPf57O7xdvjIa9Qzi/a2Av7jQdhwXDShMzlYLkEWSj7za
        AFHXjn6Hm7qnv14f002DxC2WvQ==
X-Google-Smtp-Source: APXvYqwLUwrX7DMEERuphZrAscX4CgBPVWC13LFneIeTdrAl+0BB4RRBD8tasC+m2a4yQj8hK+OrtQ==
X-Received: by 2002:a1c:1ad6:: with SMTP id a205mr2748694wma.110.1571318606936;
        Thu, 17 Oct 2019 06:23:26 -0700 (PDT)
Received: from dell ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id q14sm2703400wre.27.2019.10.17.06.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 06:23:26 -0700 (PDT)
Date:   Thu, 17 Oct 2019 14:23:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 29/34] backlight/jornada720: Use CONFIG_PREEMPTION
Message-ID: <20191017132324.GP4365@dell>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-30-bigeasy@linutronix.de>
 <20191017113707.lsjwlhi6b4ittcpe@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017113707.lsjwlhi6b4ittcpe@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019, Daniel Thompson wrote:

> On Tue, Oct 15, 2019 at 09:18:16PM +0200, Sebastian Andrzej Siewior wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> > Both PREEMPT and PREEMPT_RT require the same functionality which today
> > depends on CONFIG_PREEMPT.
> > 
> > Switch the Kconfig dependency to CONFIG_PREEMPTION.
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > [bigeasy: +LCD_HP700]
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> (I know... the review for this particular patch is trivial but an
> Acked-by from a maintainer means something specific and it is Lee
> Jones who coordinates landing cross sub-system patch sets for
> backlight).

Right.  Thanks Dan.

So what are the OP's expectations in that regard?  I see this is a
large set and I am only privy to this patch, thus lack wider
visibility.  Does this patch depend on others, or is it independent?
I'm happy to take it, but wish to avoid bisectability issues in the
next release kernel.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
