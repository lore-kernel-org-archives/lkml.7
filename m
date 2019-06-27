Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E3C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF9F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nENRI+O/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfF0LYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:24:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41333 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfF0LYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:24:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id 136so1306080lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4KskJ1NAl/aeAMSSANWZVmj0vaROvOll7pDHlQvKrE=;
        b=nENRI+O/Sos7OKNBFX4fcuIjQJRwvWzpnQUI823OhuXy+g5L/2I06M0BvsD+EPBkBU
         jnMzz/8KF3lE8zGW4CZDHMmVSPuFkrs5D4b92ModrlnG7TNh9x/cgwb45aONOdqKlEec
         qS39kC+nzP1BDmIUzDeRmazx/dGoP61W2XHfSAtWn3ha5bU5t+BZA1+MNUIR4nBz4tOl
         NAX57XZMuQsMyPqhE+DroIbq+/20QvpPbo+0VMKO0XfCbCXNeQGCCgQ1pIrfPwdKeTta
         XzBI5e2tKYh0r3WdeMUnXmSkKv+DdJ5WiGWdmeTlnDcanzuEXZ+F1JSocegrhnetAmjw
         IkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4KskJ1NAl/aeAMSSANWZVmj0vaROvOll7pDHlQvKrE=;
        b=m3w7ow8YJlwdCLTgoWR4H0xtTpX1ilf+65A66oG1RysTZvTt/DwJG9TBBB4J4sWROQ
         IkcXxgCom5H6MGBF/njuAYkhYi4JI2TGj2qtPwPGmIDEU2U2RmQN6nO9vouEuJSPOEYH
         M+lC1wQKOKWp+vfHx45idtv6DnBdva5OPERs3DJcr/zzq87KGs8Bfx7WaHOhI+kQIcLC
         hu+I9AnFpMcvC2XM1bTC/4SKqfFKXpDyiHkOcXtLtLKGSo3EcwfuWEHmkjk6Pnt8UPQX
         Jx1iwfH/pvq/ACE/jkCIQrLiuX3gLs5sdxPIcJtS4yiXi0wvPRlLh2F7eJQjUsLCflcL
         FMuw==
X-Gm-Message-State: APjAAAUiC6Y/7zCHlGeL8qboJ6YIokEVZvKh4u91cS7nvAcxBNlCLMVX
        CtzPEmcpjUtQp3vEAfBvgyWwb3TzRFN46IGCx7uuSw==
X-Google-Smtp-Source: APXvYqyeGnTnUh82XE5crL0FuoMFaSxBuAjA0pp9mZU9u9i/T+re4EBzmrybXpa77YjcTHZpDZQGFRLaagUdWo7XHdQ=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr1788889lfu.141.1561634640859;
 Thu, 27 Jun 2019 04:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190626035445.236406-1-drinkcat@chromium.org>
In-Reply-To: <20190626035445.236406-1-drinkcat@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Jun 2019 12:23:49 +0100
Message-ID: <CACRpkdaK1A2eS5_5Fg40hTV3bwRNvRmqfWidVMpNkxFkzVEVmw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: mediatek: Update cur_mask in mask/mask ops
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 4:54 AM Nicolas Boichat <drinkcat@chromium.org> wrote:

> During suspend/resume, mtk_eint_mask may be called while
> wake_mask is active. For example, this happens if a wake-source
> with an active interrupt handler wakes the system:
> irq/pm.c:irq_pm_check_wakeup would disable the interrupt, so
> that it can be handled later on in the resume flow.
>
> However, this may happen before mtk_eint_do_resume is called:
> in this case, wake_mask is loaded, and cur_mask is restored
> from an older copy, re-enabling the interrupt, and causing
> an interrupt storm (especially for level interrupts).
>
> Step by step, for a line that has both wake and interrupt enabled:
>  1. cur_mask[irq] = 1; wake_mask[irq] = 1; EINT_EN[irq] = 1 (interrupt
>     enabled at hardware level)
>  2. System suspends, resumes due to that line (at this stage EINT_EN
>     == wake_mask)
>  3. irq_pm_check_wakeup is called, and disables the interrupt =>
>     EINT_EN[irq] = 0, but we still have cur_mask[irq] = 1
>  4. mtk_eint_do_resume is called, and restores EINT_EN = cur_mask, so
>     it reenables EINT_EN[irq] = 1 => interrupt storm as the driver
>     is not yet ready to handle the interrupt.
>
> This patch fixes the issue in step 3, by recording all mask/unmask
> changes in cur_mask. This also avoids the need to read the current
> mask in eint_do_suspend, and we can remove mtk_eint_chip_read_mask
> function.
>
> The interrupt will be re-enabled properly later on, sometimes after
> mtk_eint_do_resume, when the driver is ready to handle it.
>
> Fixes: 58a5e1b64b ("pinctrl: mediatek: Implement wake handler and suspend resume")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Acked-by: Sean Wang <sean.wang@kernel.org>

Patch applied after extending the has for Fixes: to 12 digits.

Yours,
Linus Walleij
