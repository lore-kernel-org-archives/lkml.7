Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633C3C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D821206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvQx/Xwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436773AbfFLIwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:52:03 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:35904 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbfFLIwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:52:02 -0400
Received: by mail-lf1-f52.google.com with SMTP id q26so11453635lfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvnEwm7NrmJqxKF1DLKlWHS86ykeGU7LMVuI1wlnXfM=;
        b=nvQx/XwkGBISeAxB7a9NU6MmYROO/n7mGr7NTsoQWdsqa5EtyR4BTyqSECTPNLgVw3
         JEQGmqmpU5NJ665xaxRV2ccWfHlGn0AKreA5k+leMyxvZ8lun2y6Jf7jrdhfqENyPXA7
         zozU2ReuZLPlDrxOQNNm/pPVtx6Df1DiMjKyRd6ITEFN2Gmr/j1vt7CrY2labmr3iFfQ
         +YIALfWDLtB1kVULQGxyBFwp+bfpJwj1g6xW3P4gbUiW8wl0NZ2xbwePnsva5z+1O8Gi
         juWx2VxQvQfiasvNM7ot+oE9dHV9u+NBIq1NNTV4ByGK+XgggTKNnEWjhhVYfDtbdSxL
         2iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvnEwm7NrmJqxKF1DLKlWHS86ykeGU7LMVuI1wlnXfM=;
        b=SSoQ4Y9SX32Yk/b7UcAqoN+7NFs2KWIz4HJ7/J5G1Aulff1u2XYEIQQJ36B5499cNi
         Ule1J6ihDOB1Mt1qZBCltAvM21khGdr4GkGPWurNXc63q9FNvGjQFSFosd65gupHt/pr
         xmuCPMVPzGdlNs1o/3y8/Mjc9lNZhO0ZmIcvRkEVL/qtB7AnVhrh55fL10m5HZQJJf3c
         Bml9S7W7bqHXQvfg/0vSapfxVcsY8cybUC0KIDoWyRxrZcpApsCImEuYyLur0Ghx+nEb
         2fIcsW9dNK2Mw4FjERy2jL+pyXK2FNeGhcUWH8kVMF9qB18wsrKkMdlrMHtj8F1Ydug2
         u/Yw==
X-Gm-Message-State: APjAAAX9hJmv52Dk7yqU+T1kIVmxKZguUk7i0/U0rT4EY2oVSAXlJNGc
        bjrzG3xD6mJbw2cOuYjyoU2xaLDbhA9ZT6o0sRZJBw==
X-Google-Smtp-Source: APXvYqwU/lJWV35YphHgwrB/OkNmwKon6VRJi5Gu4EcAkblIAF9yMwvQMCgoqcIq46RrdC7A0lWiAGgfzI2AiovDU7g=
X-Received: by 2002:a19:dc0d:: with SMTP id t13mr16890333lfg.152.1560329520422;
 Wed, 12 Jun 2019 01:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-11-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-11-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 10:51:49 +0200
Message-ID: <CACRpkdYCiPRPM7evyZsL2jvsfiAYZ36fL1PRjoG7a0jvduqpwQ@mail.gmail.com>
Subject: Re: [PATCH-next 10/20] gpio: gpio-omap: simplify set_multiple()
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:12 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> One of the reasons for set_multiple() to exist is to allow multiple
> GPIOs on the same chip to be changed simultaneously - see commit
> 5f42424354f5 ("gpiolib: allow simultaneous setting of multiple GPIO
> outputs"):
>
>  - Simultaneous glitch-free setting of multiple pins on any kind of
>    parallel bus attached to GPIOs provided they all reside on the
>    same chip and bank.
>
> In order for this to work, we should not use the atomic set/clear
> registers, but instead read-modify-write the dataout register.  We
> already take the spinlock to ensure that happens atomically, so
> move the code into the set_multiple() function and kill the two
> helper functions.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
