Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8C3C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47CD218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoMthU5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfGDO05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:26:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43558 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfGDO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:26:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so3145041plb.10;
        Thu, 04 Jul 2019 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ea4/rODN6ph1QT9+xWsfxewM+yS9hO6SZGH8wLobuag=;
        b=QoMthU5EO3/1uHCQ8F7N/qIc7VzqyGCf5AeOFGy5CY5RCYUKBU2whOqjvRkq64PAU5
         OGRZJFVxwBzwiaUlvHyE533s93MMIoK1+MG6cO3oVujF8me/q/9eQZKE2DvjtidBhNbD
         m5799fKYBMPo+UZoFXhe+FlQPcFYnUTvmBp/A1uosMMLLsmvDbDD/YB/T0F54xq2jtxD
         I181vAanD31XZlV+vHlzCYr3if0fTVf8edbp9eMA+l1Gkqk/KDS/W/zwKysWMCN3vAkz
         EtmESktASX6Df80R/TkZdu4yNdyD7ziwt3s9FrChbH/KCGBloR3nRdVU3q+rPaU6MULZ
         FM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ea4/rODN6ph1QT9+xWsfxewM+yS9hO6SZGH8wLobuag=;
        b=nnJRKLrkl+y7ZiVgMNITCGV/YLJKsMm+S0gAWe6I7AHkRDWXXJ/xBcQCIFWp/X+NXT
         PBSlhXwSK01sPLl+DUdHAP+y5ysT7Ksd3rzVMSwj82T6B6Ba6IHg/zNEln3AOmw0FKiE
         r0er0dk0JZCcCUgmncfygRyOAZd7itOEi9kreC4bkhg4N3N69XekEDzuhIJBwIyGbL3E
         VMp44OKRvCZUPtn8eJ3jsBhOKtvLJNOjlBJ3Ma2xZEV9wf0Zwyyflx/wRW7ww+mR6arD
         5k4Vi74c50vzGRpdId+OV6T2hZnexp7DxGzKrUkOPh0oS6AyFr4NjuwX7AjWTdntkiZ3
         gyaA==
X-Gm-Message-State: APjAAAU/+iluNEu9QSD14silucnVoK2dFmJ91DhIAagZaib1tpjnlGTf
        N82974rbMvCn40s+1aiBX4Q20SINNgNQm7MHcbg=
X-Google-Smtp-Source: APXvYqxoD1hHCdHZW9TWHGw5ylN1zuQevVM9I8c5GP4kJf46/EVvQqbekyhYVEhiYnMeyQDA7IjdhWlgh2PBxHx4jnk=
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr50649963plp.18.1562250416464;
 Thu, 04 Jul 2019 07:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190704090205.19400-1-fe@dev.tdt.de> <CAHp75Vcocs=9AwX32ouOWFc+wAduCFv2DT_p4JYPUVV0BumjqA@mail.gmail.com>
 <e2c50449b498c796de8258fac0b0aba6@dev.tdt.de>
In-Reply-To: <e2c50449b498c796de8258fac0b0aba6@dev.tdt.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Jul 2019 17:26:45 +0300
Message-ID: <CAHp75VdHPRXgg6YsBM8uAfuM4CBs1HHn1condus6uW5BqC5COg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Update pcengines-apuv2 platform device
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 5:00 PM Florian Eckert <fe@dev.tdt.de> wrote:
>
> Hello Andy,
>
> thanks for feedback
>
> >> This patchset adds the following changes to this pcengines-apuv2
> >> platform device.
> >>
> >
> > Before doing anything to this driver, what is the plan for previously
> > upstreamed:
> >
> > drivers/leds/leds-apu.c
>
> I think we can remove the related APU2/APU3 code stuff from this driver.
> The recently added pcengines-apuv2 driver does *not* support the APU1.
> So I think we need the related APU1 stuff if we still want to support
> this board.

So, I would like to see some unification (since it's material for v5.4
cycle anyway, we have time).

> > arch/x86/platform/geode/alix.c
>
> I think this is not related because this is a different platform driver.
> Maybe we should move them to drivers/platform/x86?

You mentioned somewhere ALIx, can you elaborate if these are platforms
of the same family (PC engines)?

Looking into the code, I think we may unify all three under umbrella
of one driver if the above is true.


--
With Best Regards,
Andy Shevchenko
