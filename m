Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8F3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8342082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uyM0soYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfCEHu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:50:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42130 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfCEHu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:50:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id p1so5461473lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 23:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wIFD5JEJZtHSxCTVh07tlzCFUz7ZVCNP4Pj4vSOLSBg=;
        b=uyM0soYmL0qY3qcS1erak3p+XVgd6HG8sVwaKcSlveh/LqP22/Pr6u2HU0eccGCkgM
         2aaUHx2GsPnNnkszkzO6gu7PUpDXAcXh+6dpYI+lbpmL26tfPrvoarBIom4L04wj/isK
         G7z1tyT+yrLo1LD3BqP2X8MYaSOIVDBZurmytKxcde0SWqTe1pr/xVryf+8MhpJYfJB0
         +NX2sC6Fp0Buai8CdMq4w3Bm/UetpDa330ywe60K/qxe8Met/hwRi9FJejFeMabsGsEj
         wzxJN41y07GXhlsXpL8wxDVQg9fTYmtABQlel5Pj29Rg9JEp5Zx1ne0wuwyBegrsN5Oh
         ecww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wIFD5JEJZtHSxCTVh07tlzCFUz7ZVCNP4Pj4vSOLSBg=;
        b=UskiRS8rXZxwfzzgABYmScBMmvT4HjlLErTlYbvyRAPpLkUED+a2Nvhz5B1fwX5J0x
         /xIUMBkJS2qWp3OSXyNy3LIrBVaRCizQmrOP3y2u6ucqi+KN848siuLg6YttpmkfntJF
         O/tJobbBKk73wqYuFwwxO5vfhviwpj2jeeAOn5iZtkwIrXXgzeqFn5IlQFlQF0lF6ckE
         kN3Q9g2VlQ+cFiVE7lswyJVY2JqhwiXlc8sjGJtvqoFxSGN0imyAwY/R4KUVgGzeMmEU
         WHp5e6QFAhQu9ONQW+PgPEC/f4o2TRP6fayHOSOraB1WXJSCbAKH3CSJOiOLfRbt7rN6
         gmNg==
X-Gm-Message-State: APjAAAUrAv0YeKclu/FFDbLUiK5CctSIrF52/fYvoi73U6ikLMwh4p5T
        qcycTm/rAz4r5ZOGRRW5PCyCSktFE2BoK6HG1GUQdA==
X-Google-Smtp-Source: APXvYqwEtaZgcB5KFTRyteFhxC3hVHwEYyEp8C9K9bLdmJ6mIFkASFNAxzjTqEbqJIVgQyry4EJR33BzZ1moP2vt5W0=
X-Received: by 2002:ac2:4219:: with SMTP id y25mr12333210lfh.130.1551772256245;
 Mon, 04 Mar 2019 23:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20190210121657.4200-1-masneyb@onstation.org>
In-Reply-To: <20190210121657.4200-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Mar 2019 08:50:45 +0100
Message-ID: <CACRpkdYGnAxCteTuCbwJY_StrGm0BJ9ThQAdEEKCUYpF8AL_hw@mail.gmail.com>
Subject: Re: [PATCH] ARM: qcom_defconfig: add options for LG Nexus 5 phone
To:     Brian Masney <masneyb@onstation.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 1:17 PM Brian Masney <masneyb@onstation.org> wrote:

> Add wcn36xx wireless, msm vibrator, pm8941 power key, bq24190 charger,
> spmi-iadc, spmi-vadc, mpu6515 gyroscope / accelerometer, and tsl2772
> proximity / light drivers as modules to support the LG Nexus 5
> (hammerhead) phone.
>
> CFG80211 is changed to be a module to match MAC80211 since this isn't
> required for initial bootup.
>
> Device manager support is also added as a module since this is needed by
> postmarketOS.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Brian if this doesn't get applied because of the occasional maintainer overload
just send it directly to the ARM SoC maintainers arm@kernel.org that's
what I do.

Yours,
Linus Walleij
