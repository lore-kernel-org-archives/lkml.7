Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE19C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C95620815
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Q+QEOYsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFZX6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:58:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37830 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZX6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 19:58:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so559151qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 16:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgWBuqzxaFAQK/FVOErV8KvjirWmmsySw/PKmrxAmeo=;
        b=Q+QEOYshpEmibbJUJT4fHh7GJi5tuodRocxnmajC3x+24kWpL3xwppzIjWBXBfeqie
         VV6FcuQjkYqL+1RfmUlR76Hs0n+096RHHaZBZOaLkdHASE7adAfT3tG2VYhwcdgiWQRX
         1Npb1UpldNlocpga7yeiyzU0mPYkDk1OoF91B2y58BQN9tOTDZpo++2pLs/HxtPn+Wc+
         /Y58Qook4qToF+0f3tgJD3GTlb0ciqhkRPACHi1mrvQnXPfDKsyzzYF0lVcrOswfkTtI
         qqomkqLQcdteeoIml5DVHgHPLh46IKYRZYfAvwjE6kT8AQkFAO2KhPOzGQXVcHG4beAU
         YjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgWBuqzxaFAQK/FVOErV8KvjirWmmsySw/PKmrxAmeo=;
        b=f8M9KdLkj56VTfuv7LQpvmhQZBJUiOesQ9Si+8TqFrUt6XFX2XO1qT0ypkaDcrmIju
         FBn9DQDWrmy0JekvT1rnSZaWLGrCuWt3MMa7UHQk5H6fD1rv1wCZSECFHsOC+yiLa/Wj
         RCIxmiScpepBqT0NaKUZTzFsZfZYafKT3fHblTvQSaat/nOQ7cc2f5i0Gjf+8V99CqBs
         Dwe1Z1GyNiUrvymB4zn3SHwwnyUudHc1OnKo6BD1ApWHeKv/vwicgweKM2pKE5wTt70S
         7FQO4IIwZ+ZHBptoAjdzQs/ZDrKIdK5zrLrrN/ikUsfWQj2qH+QgSbtXG1tcfPRHpvw+
         0QZg==
X-Gm-Message-State: APjAAAVox8LwCo79l2F4ppbu9Kbls84Qacep22JLEmZbYgjWmX/5BZhM
        oigivekqLVkF0lH5xVDNZrtEeYMpE8t0+lC9jGevCA==
X-Google-Smtp-Source: APXvYqxfGzQZW9hxKnBGpGZYZ8xSkuuTe5XK+S7+E8Cewmif+IAxLiq5FKManBPi1i8ScCkeuowvV0DpS4QErD9i4Kg=
X-Received: by 2002:ac8:270e:: with SMTP id g14mr567929qtg.65.1561593514470;
 Wed, 26 Jun 2019 16:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190626132632.32629-1-axel.lin@ingics.com> <20190626132632.32629-2-axel.lin@ingics.com>
 <e1ba816f-1ecc-acc1-1f69-bc474da1061a@ti.com> <CAFRkauCtHtG0mfqXp=FuBYYqGhhMGfP3o_N3iBoRHwkQNQYtNw@mail.gmail.com>
 <b5452465-3dd4-855b-1a17-3da96070903c@ti.com>
In-Reply-To: <b5452465-3dd4-855b-1a17-3da96070903c@ti.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Thu, 27 Jun 2019 07:58:23 +0800
Message-ID: <CAFRkauBxJKcYbiT6UmKw81SAKm=AuDFu1Ez6Ttuc_EcMh_SudQ@mail.gmail.com>
Subject: Re: [RFT][PATCH 2/2] regulator: lm363x: Fix n_voltages setting for lm36274
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > With your current code where LM36274_LDO_VSEL_MAX and n_voltages is 0x34,
> > the maximum voltage will become 400000 + 50000 * 0x34 = 6.6V which
> > does not match the datasheet.
>
> Not sure how you get 6.6v the LDO max is 6.5v.
>
> After 0x32->0x7f maps to 6.5v
>
> 000000 = 4 V
> 000001 = 4.05 V
> :
> 011110 = 5.5 V (Default)
> :
> 110010 = 6.5 V
>
> 110011 to 111111 map to 6.5 V <- Should never see 6.6v from LDO
>
> Page 7 of the Datasheet says range is 4v->6.5v
Hi Dan,

The device indeed can only support up to 6.5V, the point is you are using
linear equation to calculate the voltage of each selecter.
In your current code:
#define LM36274_LDO_VSEL_MAX           0x34 (and it's .n_voltages)
So it supports selector 0 ... 0x33.
For selector 0x33 in the linear equation is
4000000 + 50000 * 51 = 6550000 (i.e. 6.55V)
i.e. The device actually only support up to 6.5V but the driver
reports it support up to 6.55V
     because regulator_list_voltage() will return 6.55V for selector 0x33.
(I have off-by-one in my previous reply because when .n_voltages is
0x34, it supports up to 0x33)

Regards,
AXel
