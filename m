Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22372C49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E983120717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwkOtNt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfKEJWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:22:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33025 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbfKEJWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:22:20 -0500
Received: by mail-lf1-f66.google.com with SMTP id y127so14534703lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 01:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zT+1Y7p9/KJc9h5D2GRF7qfZtVnGufdHVpBg/W0NqHo=;
        b=ZwkOtNt5VUl11C77Q+z56zLs2I+csPAQAsgRQjB47zGyNSCR0Kg6cRabic9UhhWEwA
         N0Gv7FmAv/516sORohvg4vdXZFunZZarxm8ZdPsc50kbb31tvdjv4Vj6woz+w9YnntMz
         B0Qdzkx08jMesl1R2NO8wOct84UjT0XGvNHWJGi52lgYp5wjPBFiJ8KiaSDJ4pEXZH2R
         G05DJFV6PDy7slo60/TCchbTZvPcTuIwKkfMqfsyCPdSMf9a2ETL3CQLbPHez+AyIHdK
         3m4lBve1nyb78ScgbOCRuwcW/1kOcpLp8yP81uetBqFoJCgyMdTuJSsHrniPMAgAio+V
         UALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zT+1Y7p9/KJc9h5D2GRF7qfZtVnGufdHVpBg/W0NqHo=;
        b=PIqD3B2BfiP9baeGJlldVNmoBe8duHUX2SevLEFZuNy00NaIaFRsHO8QIqzQAQnPDp
         Jkdo9yv5BNEoZet1BBhSSkefd2ZInM4aajdmntwVP3sts/33eNnuaAQMNqKP2pFYRP/D
         DgjQ0kBvdRnHxLZ/nISoBHGSw0Dt+ctyUpnIjnBC1znjRojlR92rIlKhZqadTIkfCaq5
         HuLu4Cq8nKyqE58ROD0TojLDtz37nRZ55blEaAPblcD/ri4vPrd1XpT9otfbM0O9H8sg
         frFb74tW4RC++SDZuydm+12h6K8hlPDlmEOcA/AjxWd+5nSfWJxqEaRrpYOPi9hL9tTg
         IdRw==
X-Gm-Message-State: APjAAAWtqoA1PBI9HUtcH65pMFKoc8SHJKhnJP0wzvABFWtiEHUxmEll
        9pEPkO/D1RgMXgRv9FyqzWZREunpdtiAQtnxMzfmm032JKI=
X-Google-Smtp-Source: APXvYqzpYAIITTHyBlX7CRUeDoZEPf4WEShwX/ix+K2/HWFa8VXeIGqJrHDlKgc52PfZ9txl+qufupLsU//qO5Q8CZQ=
X-Received: by 2002:a19:6a0d:: with SMTP id u13mr11068219lfu.86.1572945738652;
 Tue, 05 Nov 2019 01:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-23-arnd@arndb.de>
In-Reply-To: <20191018154201.1276638-23-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Nov 2019 10:22:07 +0100
Message-ID: <CACRpkdb8FQ8qqkSJic-7S5nA8c_fzNruYMrTC=dWwTridxygAg@mail.gmail.com>
Subject: Re: [PATCH 23/46] ARM: pxa: z2: use gpio lookup for audio device
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 5:43 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The audio device is allocated by the audio driver, and it uses a gpio
> number from the mach/z2.h header file.
>
> Change it to use a gpio lookup table for the device allocated by the
> driver to keep the header file local to the machine.
>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
