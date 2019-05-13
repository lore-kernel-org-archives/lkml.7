Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4830DC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E552086A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hs5Gxkxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfEMHyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:54:49 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39406 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfEMHys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:54:48 -0400
Received: by mail-it1-f193.google.com with SMTP id 9so11621573itf.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 00:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hMKCJuK6rSD3LVExCwUPzA6XGItnU5aIo+GZfePKqHM=;
        b=hs5GxkxzwleyU4quaW1XaB5N2OkDLJkgq+lGI0FcFJci/1eAZKILfcTeOU41yO28+D
         fwL/Oi2xtPSEbV0SUPenURf7FD9v/ZRyw/fiAjj7LebCYANxuSzcTBV1XhmUllbOutzZ
         Ix4BZZk39tF4/SvzxMHTnRAx1+i52/bMVHR5sw0OMIc/Xe8HDkW2hpEVuWg53V5sDsu9
         F35vDENnn3gUuyx8gddD6dF8yvdEhn5ZoO/g/mZd7locpngtRvBv2YLSnbFIoulFcamX
         dds2m/hH6GQUr463riVABAN/qjH2inBonheCriXHwhfDtZesiIVZRxe33CCBCS5T8blJ
         XAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hMKCJuK6rSD3LVExCwUPzA6XGItnU5aIo+GZfePKqHM=;
        b=oguo/QAecHEJWl6WI+N2LHKAWHvJw1jySLRKpSUjOSfipwF1CBF1j66ZZ6IJolocT0
         d1rRKDr9LOyBLGl33uRWaWcUcAFnkacJwzcYBjFEyD17cOd3nhpg6u/CdI4wKnMszYA9
         e75y01JCkTqE9mxiMbvYH3kYL3UQGcPSm0B3IQqF+gtEM26AStRm4TXBu1lsMOCMOFhb
         0N4M6aDFacpq5ai59YKXLRD0pn7WeuPYq4EoOewCVVe+rPdSKPwymvgY/hOO1x3lCMar
         M7F8af+zKHu4jMV8Ux9pFCNe8QL+ltWtZiC9YGV0bfM+50+2BK8yEsS1b0jv0XtSL0JB
         DAlQ==
X-Gm-Message-State: APjAAAWXT+nN4o7U2EbISGX2vZFEfJCqgTeynDFtVW1APHJFaGENOfqy
        mdxafg7hbUO9GSiPtxcfQMdxvkFc605094ddQYm8Ow==
X-Google-Smtp-Source: APXvYqyugyGW2l843vtjeo2K0Rw/fI3D/GR7RImYKoiL4vSMh/+fnOIfjAo8KCQWbriSiNcM+VNAPDDMS25ao3jTZFY=
X-Received: by 2002:a24:3d8f:: with SMTP id n137mr18160227itn.96.1557734087743;
 Mon, 13 May 2019 00:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190417144709.19588-1-brgl@bgdev.pl>
In-Reply-To: <20190417144709.19588-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 13 May 2019 09:54:36 +0200
Message-ID: <CAMRc=MdhfEM_CndCjCkY9kWeu+3VPTA7tmTy5PH=2XforZ6aLw@mail.gmail.com>
Subject: Re: [RFC 0/2] clocksource: davinci-timer: new driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        David Lechner <david@lechnology.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 17 kwi 2019 o 16:47 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Hi Daniel,
>
> as discussed - this is the davinci timer driver split into the clockevent
> and clocksource parts.
>
> Since it won't work without all the other (left out for now) changes, I'm
> marking it as RFC.
>
> The code has been simplified as requested, the duplicated enums and the
> davinci_timer structure have been removed.
>
> Please let me know if that's better. I retested it on da850-lcdk, da830-e=
vm
> and dm365-evm.
>
> Bartosz Golaszewski (2):
>   clocksource: davinci-timer: add support for clockevents
>   clocksource: timer-davinci: add support for clocksource
>
>  drivers/clocksource/Kconfig         |   5 +
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/timer-davinci.c | 342 ++++++++++++++++++++++++++++
>  include/clocksource/timer-davinci.h |  44 ++++
>  4 files changed, 392 insertions(+)
>  create mode 100644 drivers/clocksource/timer-davinci.c
>  create mode 100644 include/clocksource/timer-davinci.h
>
> --
> 2.21.0
>

Hi Daniel,

it's been almost a month so a gentle ping. Any comments on that?

Best regards,
Bartosz Golaszewski
