Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B749C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED892089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QDZk/EFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfG3RGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:06:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34959 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfG3RGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:06:55 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so129841145ioo.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thfSVMX6+HwxM/ty44YHwCabreMvWV/+Gb4a/AYAosM=;
        b=QDZk/EFUsh6U0OHs8YqCvTgja17nbMT2Y0sFIVcZgyTwIhEIGARc0EvYjU0bNaUDDw
         DhykaLBu959pAPwvEWt43vHt5h7OAeSRBBZov+gZsctSFuksXsHKukwZRmShoDWKA+8I
         wItHBj4PVtGEm32bkk7ccUJxqF53Ib3OaAdy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thfSVMX6+HwxM/ty44YHwCabreMvWV/+Gb4a/AYAosM=;
        b=bgmbJCjIKXYcvDfPxjoTEK18IKm0ERLuaGXrAYgAkePcUarncwWu5jvUXxuvIL3ymb
         bxmVgMuc7PJ2Bk4FvPm1JCHSNnbnQILQ3TbpJ4oEP8bkJaFcyQqOJh0Apyw456odHQV5
         YpR3H9ISNs4jCNGWoAKL61C+pnJgipycGeDWRMvVRp2QXf5I/aYJBb18dBw4dAhARiRN
         BL6GLg6S4f+MhF9Liohl0EG7GdsFb1iqrjKI5qIXh6H2u4vt1W6Td+2oE5QsQ6G/umKd
         zMaNVr56WUYOeenRRqOYHqlu1jqhG5OXIc5tdKQ0uQDxsbYP1vGyC+fPPIb9RRc+8iog
         YnoQ==
X-Gm-Message-State: APjAAAVDXARrWTaC4SrVh7vpdTJSw2tJz3Up2ihFLxjrfB4v8cAY89SX
        CaEpLGZ5To0vjYWx1s3Kdv62HuAxKgo=
X-Google-Smtp-Source: APXvYqyu48Lam+f3dlDk7pu/Md1fnQ4dhZJdltKQ6lfpjmrDJYsQ31Ycrwr27ioe6FxxWMUTQOpWxg==
X-Received: by 2002:a5e:8c16:: with SMTP id n22mr54371684ioj.105.1564506414399;
        Tue, 30 Jul 2019 10:06:54 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id o7sm55149523ioo.81.2019.07.30.10.06.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:06:54 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id e20so99395509iob.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:06:54 -0700 (PDT)
X-Received: by 2002:a02:5b05:: with SMTP id g5mr116310299jab.114.1564505994931;
 Tue, 30 Jul 2019 09:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190722193939.125578-1-dianders@chromium.org> <CALtMJEB871Redpzx1u6G5GVEXz-kAP=vT6Wt98=X=xm4SEMeAQ@mail.gmail.com>
In-Reply-To: <CALtMJEB871Redpzx1u6G5GVEXz-kAP=vT6Wt98=X=xm4SEMeAQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Jul 2019 09:59:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VfabHB=ALxvAZ_grg_V6Nkv1UkhHjHjp-_Fs=Bx94WAA@mail.gmail.com>
Message-ID: <CAD=FV=VfabHB=ALxvAZ_grg_V6Nkv1UkhHjHjp-_Fs=Bx94WAA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: core: Fix Marvell WiFi reset by adding SDIO
 API to replug card
To:     Andreas Fenkart <afenkart@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        netdev <netdev@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Xinming Hu <huxinming820@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 30, 2019 at 1:47 AM Andreas Fenkart <afenkart@gmail.com> wrote:
>
> > * Sometimes while I was testing I saw "Fail WiFi 1" indicating a
> >   transitory failure.  Usually this was an association failure, but in
> >   one case I saw the device do "Firmware wakeup failed" after I
> >   triggered the reset.  This caused the driver to trigger a re-reset
> >   of itself which eventually recovered things.  This was good because
> >   it was an actual test of the normal reset flow (not the one
> >   triggered via sysfs).
>
> This error triggers something. I remember that when I was working on
> suspend-to-ram feature, we had problems to wake up the firmware
> reliable. I found this patch in one of my old 3.13 tree
>
>     the missing bit -- ugly hack to force cmd52 before cmd53.

Thanks for the reference!  At the moment I'm not terribly worried
about this particular failure case (compared to other failure modes)
because it's rare and it self-heals.

...my best guess, though, is that the problem isn't exactly the same.
The "Firmware wakeup failed" is a pretty generic error message, kind
of like "something went wrong" and not all instances of this message
will have the same root cause.

I actually dealt with a few suspend/resume issues around mwifiex
recently though.  If you ever uprev, you might be interested in:

b82d6c1f8f82 mwifiex: Make resume actually do something useful again
on SDIO cards
83293386bc95 mmc: core: Prevent processing SDIO IRQs when the card is suspended

-Doug
