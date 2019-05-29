Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E4EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD7520B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOZ28q0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfE2Kha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:37:30 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41040 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2Kh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:37:29 -0400
Received: by mail-vs1-f66.google.com with SMTP id w19so1390475vsw.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjnCyAMKOLgkdZookUva/jit8+LoVCiTGzc0TNGq/oA=;
        b=wOZ28q0Dbsa83UgZEqBAyC7OuWb0kt0Le7tZXn7K4Cvh6Qd+xStSW7Yy8L8potaaWt
         vCbmGvPV8IcOQ/DvUiQ+adosG5dqCgOU0cxAlWaHwgdAWEQOwpa7mZd3r2dQfTTa/2Xp
         xfPvIdlyNqkUFyFUY7m71UUGC1xzQFWh/BD7nQZZSeEY2xfK/LMN48ajDbNJGFbWO1VN
         bLgEW84wPlSshhv5X9kGiTUuNdGdVICyMUMKraO5xgLstqh0aOGGWLQgBSCCB89yzogY
         Q9AQwpTs7/7RAYNEQnseubioA2ZJ7re36Nw2eitt4gpv7aqrecWSSXkKxIZOQg4hewD7
         y3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjnCyAMKOLgkdZookUva/jit8+LoVCiTGzc0TNGq/oA=;
        b=eRko2KiUQjrGXt8a0tacNFWe3Tj3Y1zILiA23HkFHghWeMAaL2TcJ2VEbiyLni9SrT
         Wd3qVP46IMp7LS43XT6AciZyqNtNjBIcI1UVTgz4EYP0Tiu1kP/3mnPkdZN2edS79mrw
         bAKU7iC+6fUZwFyYxia0wt+Ja5gbZP7I3+zYzEKHnaNgSGbjqDJTPJFHMq1WN77KYHJY
         KBiBqHW/F6m+fUAfvq0odYdFpyLCDdYj3uLNg8tZFYpFpPGBFXZzQ22bXMPAIx7DoUEv
         MP7+MBX1m4/EKXDdOoGM7tgEwjdGfKDjGRQ0izRaYE/embv6oYJ9txRP4arvGt3KXvcg
         1bKA==
X-Gm-Message-State: APjAAAVqqsx0A+eSvXOacIHIEdOZhjtGVePKaXtdQZf2a9dauq8NeT1v
        JQgPX0YJ0wdh/sOvP/A+2aYOocm3xurdwISP33tUJQ==
X-Google-Smtp-Source: APXvYqx8zt/2mUaOcclrGUfqtNcoqVnj8CT/3HypSvAAWyzH7F3cDGM/H+pIvoe/h4PMDjOkbfsFLwZh6e2SC0ttcNo=
X-Received: by 2002:a67:fa51:: with SMTP id j17mr38251200vsq.89.1559126247816;
 Wed, 29 May 2019 03:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
 <1556264798-18540-4-git-send-email-ludovic.Barre@st.com> <CAPDyKFrxp3Y3AudNvkkSRaph2Fe-A-F6Cs0jfy9RUja76GYeiA@mail.gmail.com>
 <a6a74431-50a6-6298-b77d-9d27a77fd6cc@st.com>
In-Reply-To: <a6a74431-50a6-6298-b77d-9d27a77fd6cc@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 29 May 2019 12:36:50 +0200
Message-ID: <CAPDyKFqzNy3hDzovSxb6pd37u7SxWqYoJeu9+tf_qDF7gs0euA@mail.gmail.com>
Subject: Re: [PATCH V2 3/5] mmc: mmci: fix clear of busy detect status
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 at 11:20, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> On 5/27/19 8:17 PM, Ulf Hansson wrote:
> > On Fri, 26 Apr 2019 at 09:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
> >>
> >> From: Ludovic Barre <ludovic.barre@st.com>
> >>
> >> The "busy_detect_flag" is used to read/clear busy value of
> >> mmci status. The "busy_detect_mask" is used to manage busy irq of
> >> mmci mask.
> >> For sdmmc variant, the 2 properties have not the same offset.
> >> To clear the busyd0 status bit, we must add busy detect flag,
> >> the mmci mask is not enough.
> >>
> >> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> >
> > Ludovic, again, apologies for the delay.
> >
> >> ---
> >>   drivers/mmc/host/mmci.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> >> index a040f54..3cd52e8 100644
> >> --- a/drivers/mmc/host/mmci.c
> >> +++ b/drivers/mmc/host/mmci.c
> >> @@ -1517,7 +1517,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
> >>                   * to make sure that both start and end interrupts are always
> >>                   * cleared one after the other.
> >>                   */
> >> -               status &= readl(host->base + MMCIMASK0);
> >> +               status &= readl(host->base + MMCIMASK0) |
> >> +                       host->variant->busy_detect_flag;
> >
> > I think this is not entirely correct, because it would mean we check
> > for busy even if we haven't unmasked the busy IRQ via the
> > variant->busy_detect_mask.
>
> if the variant is busy_detect false:
>   => no problem because the busy_detect_flag or busy_detect_mask is not
>      defined.

Right.

>
> if variant is busy_detect true:
> the busy handle is split in 3 steps (see mmci_cmd_irq):
> step 1: detection of busy line => unmasked the busy irq end
> step 2: in busy wait => ignore cmd irq while current busy flag is
> enabled.
> step 3: end of busy => clear and mask busy irq
>
> To detect the first step (see mmci_cmd_irq: which unmasks the busy irq)
> we need to know the current busy state. Actually, the status register is
> re-read in mmci_cmd_irq, why not used the status read in mmci_irq and in
> parameter ?

Right, I see your point.

On the other hand, that re-read of the status registers should really
not be needed. Maybe it's a leftover from my initial version of the
code, but in any case we should remove that.

>
> Regards,
> Ludo
>
> >
> > I suggest to store a new bool in the host (call it
> > "busy_detect_unmasked" or whatever makes sense to you), to track
> > whether we have unmasked the busy IRQ or not. Then take this flag into
> > account, before ORing the value of host->variant->busy_detect_flag,
> > according to above.
> >
> >>                  if (host->variant->busy_detect)
> >>                          writel(status & ~host->variant->busy_detect_mask,
> >>                                 host->base + MMCICLEAR);
> >> --
> >> 2.7.4

Kind regards
Uffe
