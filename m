Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03896C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C322080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywhFsERM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfFLH4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:56:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38665 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfFLH4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:56:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id o13so14236920lji.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpVyyIY+84Nucp0CGFI/TVYjVMVNEKw90ADvLXHqdCE=;
        b=ywhFsERMuu6cckroCnmO4n7s8QukIAuyz0zLikfSlsBUYZFkfXANfIGjA5/KhVSGhU
         wsTIS0bWPWJna21j3rW8yvYs+F3NDlNqUUNiwkURwt7WWjHQqvSdAVutVveDLoeATPmt
         YORL3OagMZLOBpPjV+Lzr3Zc5+emLQXq8fBsmzAk+ZzLkaAJi8UAoaKnj+VxyW7Gz8TH
         ZkfgwAA8LK1D47ev74wBPQDWl+uzPcltC2JGYtqEHXKChCSe2HGOK/amvFPZaQpfcYa8
         sP35dsdokzVNIdfr8KF3qAK8nz6YpxVF9GycG2qi5PIFNksCy8C4t63BybmL5wEh/Sng
         wPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpVyyIY+84Nucp0CGFI/TVYjVMVNEKw90ADvLXHqdCE=;
        b=gTjy0A9ZKJ1Q18sZvZgLkX85DeH8I1jlxCjxg3O9IPZNjkA1QRtjwTMoCV2xIuryLV
         8Q4eAfL/RIPQ+35u37uX6NaFr9U8xlDxVt1PGZ54BTGvU5udm1lYtdy/1s1jZq8RxNrz
         SLbZkNmDCjzsfTp4Sgaas0cSH3FfeNpH4mFTcbrVfFAmezxgY5dMVWweIukGBkW2SaTU
         6orbSjpAjQ9AGtiisrl2/Fg/tyQZkTWwYr/oJm4D9r32u4iQRzOl4991jn/IXAHn7A/t
         DeS+9O+niFOJKPSgJtkXAquK6PA2ZSdDrr1EZTDMLLyYaa91VziI/lUpUwAftk45nmQY
         A9mw==
X-Gm-Message-State: APjAAAVYesJfSRizB4HKHJ9SrJ12519XlMPuPNDD+vN3/Q6De+dD7jiR
        9OZuQw9KhaxuS/d8EuwYYuQluzvPLiN9eU8ke3nauQ==
X-Google-Smtp-Source: APXvYqwBtvb1aHOu8BGk+6o3Llz+ZVHUG284rkHqlGevLtNgB6RjYMYSnQnZgYw64OXncNMQfXgGGBNNy6xlBvlYPQA=
X-Received: by 2002:a2e:7508:: with SMTP id q8mr26686053ljc.165.1560326170850;
 Wed, 12 Jun 2019 00:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-3-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-3-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 09:55:59 +0200
Message-ID: <CACRpkdZdCxvFQp9xssmqToeT5FrC4quusEgJOAbYo+TxUzGujw@mail.gmail.com>
Subject: Re: [PATCH-next 02/20] gpio: gpio-omap: fix lack of irqstatus_raw0
 for OMAP4
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

On Mon, Jun 10, 2019 at 7:11 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Commit 384ebe1c2849 ("gpio/omap: Add DT support to GPIO driver") added
> the register definition tables to the gpio-omap driver. Subsequently to
> that commit, commit 4e962e8998cc ("gpio/omap: remove cpu_is_omapxxxx()
> checks from *_runtime_resume()") added definitions for irqstatus_raw*
> registers to the legacy OMAP4 definitions, but missed the DT
> definitions.
>
> This causes an unintentional change of behaviour for the 1.101 errata
> workaround on OMAP4 platforms. Fix this oversight.
>
> Fixes: 4e962e8998cc ("gpio/omap: remove cpu_is_omapxxxx() checks from *_runtime_resume()")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
