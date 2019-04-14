Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28D2C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE502084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3sVhsLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfDNBFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 21:05:17 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34380 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDNBFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 21:05:16 -0400
Received: by mail-it1-f194.google.com with SMTP id z17so3626799itc.1;
        Sat, 13 Apr 2019 18:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ld1A8EClqRDUtb4MEFGvtg+39sTSiFA8nA1t9Krb1Lc=;
        b=r3sVhsLsPBoCoD2jekKrEIFe6u5CaQ7aojbOqGqgSwxbUVDQ358qRpyjr4ecW9zXEU
         rL6rKVroQN2eBhq7I6NuiK9EqDNSwi/6NVnrWHSWpooXsQaPN36DzujyqQ8Yjq61JWlk
         7F+LvujSqJpZIPQD+ie1hWIDIHmKtDf1zSmgyylYn6+0kDcL7+8PD4Uv2PD+csgWnM1E
         xUwY47EcZcCRzn3wN9HkAekhc+hzzvdlH5+9ztWYaCxaDtHaYiIvDY25EUZZ/Ve9y/Ut
         6gl9Mwm6Mt1D55yLwUCMzQHZsj9+IwbJpiy32Y4sLYohijfsURL578atToCze/or7tLw
         rpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ld1A8EClqRDUtb4MEFGvtg+39sTSiFA8nA1t9Krb1Lc=;
        b=auRBUVFtc000mdNQX3BySK9ERIeqV4jW3Hi6g9kcleb6zPEwG9RAqS827IGWcPgtIE
         zahYJ5sySSv/Hv9hPeVaqp9vlQF8VmCO37lbofXUcBLXaxOzJYreNotSCFUXjtBonTuE
         Wev1iU8XqJ9NlKfHTtNGso8pFOn0frkH4E4SRsqZMvafDdWM1Ri50p/XfiAYxgGuRK0M
         E4AfSlvQN6FuuuK7nHi5SnZIzVsujIai7IeKI1oFLW0do4ErI0i7I35mjF2WZU/jq3F7
         wtGf3ctYTjrEV66Wcrnn4xSjlLrBRgxAt9AIquaSgB46Ya1kVjgK7c8hCjjDEI6T2+lC
         savw==
X-Gm-Message-State: APjAAAWfeEfs7nTjUmCxaSFdmQTy2DyE17hr7nH41Yfg7SOtt3u/YBAl
        yZ1XvA9KTxKl5SlZuLYUDn4bf/TxYB2hnMkPPtQ=
X-Google-Smtp-Source: APXvYqx2a/OuQknVo142EMrTwQX5v04tONv8DLsSmXXoA0MhLJ3XF+gpe5Ngnj1tXZHC4wj9xntG7X8dj97Lp3df6is=
X-Received: by 2002:a24:4702:: with SMTP id t2mr18474629itb.105.1555203915731;
 Sat, 13 Apr 2019 18:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190403070325.1077-1-andrew.smirnov@gmail.com>
 <20190403070325.1077-6-andrew.smirnov@gmail.com> <20190407121522.1d0fb39d@archlinux>
In-Reply-To: <20190407121522.1d0fb39d@archlinux>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sat, 13 Apr 2019 18:05:04 -0700
Message-ID: <CAHQ1cqEuLnyersMGudOCK7r6x4Jktsz0_KaL6VtR3cpCmY1A3A@mail.gmail.com>
Subject: Re: [PATCH 5/6] iio: imx7d_adc: Use imx7d_adc_resume() in imx7d_adc_probe()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Haibo Chen <haibo.chen@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 4:15 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed,  3 Apr 2019 00:03:24 -0700
> Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> > Initialization sequence performed in imx7d_adc_resume() is exactley
> > the same as what's being done in imx7d_adc_probe(). Make use of the
> > former in the latter to avoid code duplication.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: linux-iio@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> I'm not to going to apply this now, due to the ordering issue with the earlier
> and later patches.  However, it is fine in of itself.
>
> I do wonder if we want to rename resume to something else to reflect
> it's new usage?  imx7d_adc_enable perhaps?
> Similar question for suspend in the next patch.

Sure, will rename in v2.

Thanks,
Andrey Smirnov
