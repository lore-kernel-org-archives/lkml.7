Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7A9C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9022339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fRkSaGl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfHUF5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 01:57:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33517 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfHUF5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:57:33 -0400
Received: by mail-qk1-f194.google.com with SMTP id w18so869184qki.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 22:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6gYotOZasUlghj+5miHn6itbPw1Xxo5qoWX2c4AJZ0=;
        b=fRkSaGl8rcNZIMIyKlWAiXym9k7PM2Njj2vuF5xfVsWAvvzvhYS7QuzqjU8iNsynLW
         xjKCE0oaS2TZzsErSCZ+bXBoJshE2B6JY9ANXMpLIOzFkshoyNCGPE5lODc42z3c8AYn
         6EA+e6LSO18ss01/caCZqVLCqS5xyEzO+wHRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6gYotOZasUlghj+5miHn6itbPw1Xxo5qoWX2c4AJZ0=;
        b=bMefnOypGlwQaq2MZEHcNMwsPfIoDWzicWnfFj8M6ABNBiMCWmpzZIkPNW66d4g55p
         eqqFiQYt9tOLwFdQHXL9TFY+QADKysM+RLMuD/hUjzLX2iirWg6L36qMA+C+cl+Z0hFj
         YMMES6H/+S7iAI2mBQprdsomrarqCruPEJO1PhvjweVNEQVxQB2xqby/+JZZmcyNtRTP
         6iGeoGMP2rpT0Zv0CLNp7wo+1ObGCU8cAJAvrGKuA9BTCpwXLDuMG15lr8NXsnO5Bz5k
         w1Y5a/W4R+kLCqt8Pmc2WHfPXhUhmS1Qoenn7+9l8rc+04LPklFB0lwnnpecyToX9egS
         omOQ==
X-Gm-Message-State: APjAAAVfkDicLUiUp/1vyOdfdnGm5KfUuD/XuvNGWd6eJMS+zmYdSB05
        +8nB/9Y92bQM7pbNPr3YNIXMWNcrhaIKPSyQmDyZ4A==
X-Google-Smtp-Source: APXvYqxC6HcxP1uepjmB3Azy4g3yRYVzUlDR2q/OUNQULPHyMxoFB38jRqS6lWI2lvQ0KTTrE5fN1aakFroOXkZTJWc=
X-Received: by 2002:a05:620a:16c3:: with SMTP id a3mr28335159qkn.315.1566367052074;
 Tue, 20 Aug 2019 22:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190819071602.139014-1-hsinyi@chromium.org> <20190819071602.139014-3-hsinyi@chromium.org>
 <20190819181349.GE10349@mit.edu> <CAJMQK-ghQ8weMerXW7t0DFZTAg_c5M80Yp5DTAtyY2LA7YpS1A@mail.gmail.com>
 <CAKv+Gu_qJUU2hRujjv6e5yPqPQXRXokBU_2mSGD3civ2d2+xhw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_qJUU2hRujjv6e5yPqPQXRXokBU_2mSGD3civ2d2+xhw@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 21 Aug 2019 13:57:05 +0800
Message-ID: <CAJMQK-hdYz+pW5QL41nXkZAX1qiRynaWg7cne48qCaQsuPrSCg@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] fdt: add support for rng-seed
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Then we'd still use add_device_randomness() in case that bootloader
provides weak entropy.

On Tue, Aug 20, 2019 at 7:14 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 20 Aug 2019 at 10:43, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Hi Ted,
> >
> > Thanks for raising this question.
> >
> > For UEFI based system, they have a config table that carries rng seed
> > and can be passed to device randomness. However, they also use
> > add_device_randomness (not sure if it's the same reason that they
> > can't guarantee _all_ bootloader can be trusted)
>
> The config table is actually a Linux invention: it is populated by the
> EFI stub code (which is part of the kernel) based on the output of a
> call into the EFI_RNG_PROTOCOL, which is defined in the UEFI spec, but
> optional and not widely available.
>
> I have opted for add_device_randomness() since there is no way to
> establish the quality level of the output of EFI_RNG_PROTOCOL, and so
> it is currently only used to prevent the bootup state of the entropy
> pool to be too predictable, and the output does not contribute to the
> entropy estimate kept by the RNG core.
>
>
> > This patch is to let DT based system also have similar features, which
> > can make initial random number stronger. (We only care initial
> > situation here, since more entropy would be added to kernel as time
> > goes on )
> >
> > Conservatively, we can use add_device_randomness() as well, which
> > would pass buffer to crng_slow_load() instead of crng_fast_load().
> > But I think we should trust bootloader here. Whoever wants to use this
> > feature should make sure their bootloader can pass valid (random
> > enough) seeds. If they are not sure, they can just don't add the
> > property to DT.
>
> It is the firmware that adds the property to the DT, not the user.
