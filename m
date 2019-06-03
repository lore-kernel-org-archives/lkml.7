Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6F5C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC6C277A5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxKx13QG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfFCPIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:08:19 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:37617 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbfFCPIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:08:18 -0400
Received: by mail-oi1-f182.google.com with SMTP id i4so12688557oih.4;
        Mon, 03 Jun 2019 08:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TpWLC/3pjegvr7+ZY607fBn8ns10+mMnCutLvJGdDc=;
        b=BxKx13QGT/u12HpIJlheCSwymOrc6/3N741u0oXueQXTvXYPQk9FniPmJw02/PpwGP
         HPlkOXw5/oIVOgGgf4NZ75BgpVofdv/b1uUMVePU+MCoUiiYrFulNO6X7NULofrMRhv4
         rT9fzp5o2y2+BrHfLmo+EScZx89Yy5yrdcZ0U1nYfy52apl1I40mHD152CJHfUEAFA5c
         8zTdL7W/cmeYe/TLb5RO6XgskUpDYVOvPLbRtIkIXG6lKP7vdkGVgXZ4W/sOaGXxOMWF
         yZRPuW5R8utLHSiDQBiGPrpJNwgsQoC1ZKUkvrOBEPw+RYxETO4GevcJzD4Ah1v7nbjj
         eRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TpWLC/3pjegvr7+ZY607fBn8ns10+mMnCutLvJGdDc=;
        b=hX9o3nNcS1Z5NfZsuAphVwRNYmv/dL0/+Cr8lGv4HQqopNTfxnZbyMqyDsc91Rw+OA
         b2g621j6I7oDC3Cgu20rVZFkKnPX/tuzmnYIrhZ0bt4LTdweM05CEwfE6s00/QXVOKHC
         wZiJejuRVPwvjBTcGu/PL63RZOxKa5XKN7ZeFju2FJelaczkKb+7GuhaAQYGesK2Co1v
         0vmlj+51jwtURTaLO27BP1GPvvTxUKGXC5s3vkBKjmggzYB5OV5rog4PYdnGHUVYpgbj
         g1+KUxx+oa27qRMDegkahWXME5bWLAL5HyAEz8Z9OOgo63X46c80n6MM0GCTG8UXsJYu
         LGng==
X-Gm-Message-State: APjAAAWBP4NE4VAnwr/CIg9xJkh9p4eZ/MVn5tVi2Sj1MMJll1KJ1w8q
        KLtXQvT8YxLwRl7TMxak/F+W2w4yv1gFLhfq6Ic=
X-Google-Smtp-Source: APXvYqyN8niOOFjDc1/bu7+5/khKNtYwG2pVxy8zfSbxr3MBICAqPh21tPm0Vkra1Gsc84iWMeV0bfiWwSmfBMglGVE=
X-Received: by 2002:aca:5416:: with SMTP id i22mr1334706oib.103.1559574497679;
 Mon, 03 Jun 2019 08:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190601035709.85379-1-yuehaibing@huawei.com> <CAGngYiXZM0QUdKE_zDK763J9iDuiKSbmFeTVA1PJ_4WvjntjQQ@mail.gmail.com>
 <20190601160459.baedo5pp5hsrltzs@pengutronix.de> <CAGngYiUfGGF+PwaT4SE2ZJkrCidc7-QWeuRsPTDwrLL1onm88w@mail.gmail.com>
 <20190603114029.GC2781@lahna.fi.intel.com>
In-Reply-To: <20190603114029.GC2781@lahna.fi.intel.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 3 Jun 2019 11:08:06 -0400
Message-ID: <CAGngYiVDCCjo6VKt660Uz5mbEGOBOZpcUWeRHWx_L=TapZgv_w@mail.gmail.com>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable 'pwm'
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 7:40 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> I think you are right. pca9685_pwm_request() should take the mutex as
> long as it is requesting PWM.

Yes, but things get hairy because pca9685_pwm_request() will have to
give up the mutex when it returns. I cannot see a way to keep holding
this mutex while the in-use flag is set by the pwm core ?

Alternatively, we could set (void *)1 pwm_data inside the pwm_request,
wrapped inside the mutex.
But then things get 'messy'.

> A flag would probably be easier to understand than the magic we have
> now.

I have the feeling that a flag (plus a mutex) would be the clearest and
safest way forward. I'll post a patch soon, you guys tell me what you
think.

Unfortunately, I no longer have any test hardware. The project that
required this chip is long dead.
