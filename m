Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F136FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15884214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfKHU7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:59:32 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32916 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfKHU7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:59:31 -0500
Received: by mail-oi1-f193.google.com with SMTP id m193so6496248oig.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 12:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHMB6rGLleO6OxcrYYe8ZvDxdU9fIQ0DXLT+ABSPcOU=;
        b=OL6zOyJEY45ikFO0pBebvS2mfc8bDuK6K+UZnnpof0skCqJ9iXuH8n4F915JbCO5Uj
         OPUr5DJkbRR677LJ/YzD8fmDREkzRXHIBPktl6llBXmupcQJNV4HVOaiWE+aqP9dVE3t
         jKPiXZsJLMQOYhPAnzlmEZUbS3X33X/gsQ/Is3h8ponXpgcQBP1qC5hNKkDqnyeMT9wD
         n4rNvDxcEYiQoA9hqCQiXlaRL6imfuVv7dPhVeXhLyQffgNOk1PlOIuo8AS9HjdI5h/7
         VFVxuKBu1ooJyHC/2tVzJElm610A8JSPekYjZGL1tGYcitWIfGQmoH2h0TTefbyxqsgu
         ZcVg==
X-Gm-Message-State: APjAAAWotJoJwCctoFi8pQYBG82MaPScgQKL2QrYJyw77gfA43YHQpOp
        De8wgjQbPT4U6yCqsyluNoQODitT
X-Google-Smtp-Source: APXvYqz/BnBgzeR/4jvcQeOStltRjtEOKOu8nily60vwxLhWz6+XO/KpJocmtSNEQfuaR8zVflSxQQ==
X-Received: by 2002:aca:adc1:: with SMTP id w184mr11118894oie.138.1573246770332;
        Fri, 08 Nov 2019 12:59:30 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id 18sm283882oip.57.2019.11.08.12.59.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 12:59:29 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id d5so6380396otp.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 12:59:29 -0800 (PST)
X-Received: by 2002:a9d:173:: with SMTP id 106mr10294718otu.205.1573246769515;
 Fri, 08 Nov 2019 12:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20191108130213.23684-1-yuehaibing@huawei.com> <20191108151720.GB216543@piout.net>
In-Reply-To: <20191108151720.GB216543@piout.net>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 8 Nov 2019 14:59:18 -0600
X-Gmail-Original-Message-ID: <CADRPPNS0z913xkwJwZRU_37RHOs_-AjivR_aqOh-LGZPm607iA@mail.gmail.com>
Message-ID: <CADRPPNS0z913xkwJwZRU_37RHOs_-AjivR_aqOh-LGZPm607iA@mail.gmail.com>
Subject: Re: [PATCH -next] soc: fsl: Enable COMPILE_TEST
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 9:20 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hi,
>
> On 08/11/2019 21:02:13+0800, YueHaibing wrote:
> > When do COMPILE_TEST buiding for RTC_DRV_FSL_FTM_ALARM,
> > we get this warning:
> >
> > WARNING: unmet direct dependencies detected for FSL_RCPM
> >   Depends on [n]: PM_SLEEP [=y] && (ARM || ARM64)
> >   Selected by [m]:
> >   - RTC_DRV_FSL_FTM_ALARM [=m] && RTC_CLASS [=y] && (ARCH_LAYERSCAPE || SOC_LS1021A || COMPILE_TEST [=y])
> >
> > This enable COMPILE_TEST for FSL_RCPM to fix the issue.
> >
> > Fixes: e1c2feb1efa2 ("rtc: fsl-ftm-alarm: allow COMPILE_TEST")
>
> I've removed that patch until the fsl maintainers apply this one.

I think it is wrong to have RTC_DRV_FSL_FTM_ALARM select FSL_RCPM from
the begining.  The FTM_ALARM is primarily used as a wakeup source for
the deep sleep.  But it shouldn't be depending on it or selecting it.
I will create a patch to move that.

Regards,
Leo

>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> > In commit c6c2d36bc46f ("rtc: fsl-ftm-alarm: Fix build error without PM_SLEEP")
> > I posted a wrong kconfig warning(which PM_SLEEP is n), sorry for confusion.
> > ---
> >  drivers/soc/fsl/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> > index 4df32bc..e142662 100644
> > --- a/drivers/soc/fsl/Kconfig
> > +++ b/drivers/soc/fsl/Kconfig
> > @@ -43,7 +43,7 @@ config DPAA2_CONSOLE
> >
> >  config FSL_RCPM
> >       bool "Freescale RCPM support"
> > -     depends on PM_SLEEP && (ARM || ARM64)
> > +     depends on PM_SLEEP && (ARM || ARM64 || COMPILE_TEST)
> >       help
> >         The NXP QorIQ Processors based on ARM Core have RCPM module
> >         (Run Control and Power Management), which performs all device-level
> > --
> > 2.7.4
> >
> >
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
