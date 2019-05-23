Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07D3C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8106420856
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kA31TSrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfEWJJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:09:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33107 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbfEWJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:09:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id m32so5866293qtf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZDRg3ieis6hoh/yJ9a80gOidWlG1G6Pw/YGxgRuSE94=;
        b=kA31TSrggwsJxxWDnJJPIOo3MgixNqwLlwlFlwOzYC28Qzv9rkp8BWwHIdODxR99Nt
         d7IFt6+f5xHBItXGp2Eu/3CYh18PpggLnYDWOPGEhC58NLAK8u/eOGkbZkra0hb+DjIW
         5fb8+ypRJRIiFczeHfu1xVkpxzf1gcGRUnImDzPZUWqkbSgL6KAMHL9W7a8Fu8M5DujO
         90V5srCCUOkBo351510PYMPxAxjqB4JtbYWAJ2PHaAarEBwCMnecaut6HWHq4qz/oqfM
         qo2HNtUzDfnS3OXjBi1JU+j+hPnA/OKdCeWoN/pvQm7TpUNlroxutZ/9RIUPko5fruIR
         BCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZDRg3ieis6hoh/yJ9a80gOidWlG1G6Pw/YGxgRuSE94=;
        b=CiG07S2pSxSL1YJekuxx2s2zWJfVge3ud3R4exR1ImvrxrV9/V1aeKfEwt93vkvD7b
         v5MquIFu030Joy8NvtffDc1Ed13XAJDUnyfVsDVnuaQhfJd247dF7J1KkhHY42b/JFL+
         RVHtUNiiLVB6Q/jkKZnrm9y9w914A30I2M1yf+GMeTyYPr0FSnRvL3dQh4dR12bqPwPR
         UC0bIRs+/fRw4v6rFurxL3SgVs6TdJtoUqW+HaBzHyeFHybTyl7MZh1APZPEeeebwIKB
         eGGhziP8tntcVyUG7aaKfc+bSFu1t3NOzKzbd9YDAwvMHnFY4y35fVvp0fmzsdsum5VP
         vFnQ==
X-Gm-Message-State: APjAAAWjLvjJAnJ2hBilLbTtz3dJ83zLf+daW0W6pwM4nCcteuugeEiU
        Z1GXxmSdMw1YDZYWVSkr+E1uxMdgCc+LdxIoBWcZBg==
X-Google-Smtp-Source: APXvYqzPHWai2cPVbmyi53PtZyW+rD0M2Kck+rs0vgo/buY2HBfBi20KQ1+3WaNRxJAeDdyBzyejy/NHzp/5Y2dGtco=
X-Received: by 2002:ac8:352d:: with SMTP id y42mr78662075qtb.209.1558602584218;
 Thu, 23 May 2019 02:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com> <45e934af-d677-d7d4-09ea-3ed01872dab6@st.com>
In-Reply-To: <45e934af-d677-d7d4-09ea-3ed01872dab6@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 23 May 2019 11:09:33 +0200
Message-ID: <CA+M3ks5O9YpZ-4f3x=bFn_LxJu+6i3pu7jsWv_93pe14y8V71w@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 0/3] Add PM support to STM32 LP Timer drivers
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>, tduszyns@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        u.kleine-koenig@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 10 mai 2019 =C3=A0 09:51, Fabrice Gasnier <fabrice.gasnier@st.com> =
a =C3=A9crit :
>
> On 4/18/19 11:37 AM, Fabrice Gasnier wrote:
> > This patch series adds power management support for STM32 LP Timer:
> > - PWM driver
> > - Document the pinctrl states for sleep mode
> >
> > It also adds device link between the PWM consumer and the PWM provider.
> > This allows proper sequencing for suspend/resume (e.g. user will likely
> > do a pwm_disable() before the PWM provider suspend executes), see [1].
> >
> > [1] https://lkml.org/lkml/2019/2/5/770
> >
>
> Hi Thierry,
>
> Please let me know if you have some more comments on this series. It's
> been under review since quite some time now.
>

Hi Thierry,

Does something is blocking on this series ?
How can we progress on it ?

Regards,
Benjamin

> Thanks in advance,
> Best Regards,
> Fabrice
>
> > ---
> > resend v5:
> > - update collected acks
> >
> > Changes in v5:
> > - improve a warning message, fix a style issue.
> >
> > Changes in v4:
> > - improve error handling when adding the PWM consumer device link.
> >
> > Changes in v3:
> > - Move the device_link_add() call to of_pwm_get() as discussed with Uwe=
.
> >
> > Changes in v2:
> > - Don't disable PWM channel in PWM provider: rather refuse to suspend
> >   and report an error as suggested by Uwe and Thierry.
> > - Add patch 3/3 to propose device link addition.
> > - No updates for STM32 LP Timer IIO driver. Patches can be send separat=
ely.
> >
> > Fabrice Gasnier (3):
> >   dt-bindings: pwm-stm32-lp: document pinctrl sleep state
> >   pwm: stm32-lp: Add power management support
> >   pwm: core: add consumer device link
> >
> >  .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 ++--
> >  drivers/pwm/core.c                                 | 50 ++++++++++++++=
++++++--
> >  drivers/pwm/pwm-stm32-lp.c                         | 25 +++++++++++
> >  include/linux/pwm.h                                |  6 ++-
> >  4 files changed, 82 insertions(+), 8 deletions(-)
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
