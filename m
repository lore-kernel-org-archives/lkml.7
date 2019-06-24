Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FECC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7BD208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqahhA0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfFXNnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:43:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39732 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbfFXNnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:43:00 -0400
Received: by mail-io1-f67.google.com with SMTP id r185so823616iod.6;
        Mon, 24 Jun 2019 06:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JAY+HO+se6M27BJLGy2WaRXVtQjt3tup0p+M/AykcYU=;
        b=WqahhA0vGT09ygQXdubtYD5Lz8cEW9fjhcYm97RgfF6N2/isRXcUjN3KMzuLlAScL2
         uB1+yrJlpzeAGIVXLqeyKk4Vv85+P8jeJFXi+iruawOOdanDNRNg8aoHp1CPiDmlYVSC
         6U6VpETeSl0kXNREKCfsI8At3rHRNCu0EpJHK/dETrHs2ALcqFSRc3oLzsWKipgN8xM/
         T1+lJaRW9mkfN/FM8N2bu1xaMckb8WFtWM0ymwCaaUbnCX6j5Wl3/3Fcu7P6cZBagDZm
         qF6gd2YkmuYRFi1rjW+ke9AcQTdaKKhb/17oQHB4k5i+20d0/O1EfWR42JOMSVp5noas
         SpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JAY+HO+se6M27BJLGy2WaRXVtQjt3tup0p+M/AykcYU=;
        b=VYo1nZniLZ+uc3YiobzkbQh2s3ZTLPFBt9y5Dd+pRZ0E4zObzc8QOYpvN+6awrkbTd
         7zBWcvLCT68O0PjaIQtL5R+M6Fm5SD8H6fNo8FLURY9aFHUuWvjSKVwSz+ifBmgooqAB
         KcIRCnek2XJxx1BNJd+YXHMikXD+kowGv86o/u74GUsRd8KfqitLG79zxV1U5wN89Lye
         07JsTtLcmT7nfUd/1bXrmnGTKJpgt7oITsXU7eQwJRc0YKU+wKNLJBcnJzy0RTJQ+4ps
         uLAa4oQxeTfEtQMb5dPoUSRcbmjRkKnHhEY1iFoPywQOLNrrJwiZamLHhzo8g13l3/Kh
         VE0w==
X-Gm-Message-State: APjAAAWXdA8aNWkpIRWnXzW+wpqLlvOcsWIdVY7cWG98RPblV/XWFzE0
        3xmQsHtGT0qNzjZDEHgYDaIVQ1NhR+KBz/XM9qI=
X-Google-Smtp-Source: APXvYqypl0IrSyDO/f7SI42d4NpFHa/7OZX0jXNbFpUASMxwh2fx0mJgfs/qVOYaLSUhLwF6DwSrz304TPAq9G/BjWs=
X-Received: by 2002:a5e:c30f:: with SMTP id a15mr8320747iok.246.1561383779652;
 Mon, 24 Jun 2019 06:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190621155845.7079-1-krzk@kernel.org> <20190621155845.7079-3-krzk@kernel.org>
 <CGME20190623160226epcas2p3449814deb1faf7bf939481e6d4da2b86@epcas2p3.samsung.com>
 <CANAwSgTFQo8wL5s-djwPXFFOLtTHvRQif6234kFC=23PwMhuEQ@mail.gmail.com>
 <d94a2f99-fb99-c238-7011-9bbb4c0cd90f@samsung.com> <CAJKOXPeXELUjsuW9eyGuRj56067qnL-J2Lt4U42mYiyx=X+F_Q@mail.gmail.com>
 <2f58b63e-adf1-7935-8849-f311dc991b84@samsung.com>
In-Reply-To: <2f58b63e-adf1-7935-8849-f311dc991b84@samsung.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 24 Jun 2019 19:12:46 +0530
Message-ID: <CANAwSgTymg=u8oJy4bOoREpY1DvVqav=FfdizumeUJMYhntKaQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: exynos: Add regulator suspend
 configuration to Odroid XU3/XU4/HC1 family
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek / Krzysztof,

On Mon, 24 Jun 2019 at 14:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Krzysztof,
>
> On 2019-06-24 09:41, Krzysztof Kozlowski wrote:
> > On Mon, 24 Jun 2019 at 09:20, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >> On 2019-06-23 18:02, Anand Moon wrote:
> >>> Thanks for this patch. Please add my
> >>>
> >>> Tested-by: Anand Moon <linux.amoon@gmail.com>
> >>>
> >>> [snip]
> >>>
> >>> Could you integrate below small changes into this patch.
> >>> with these below changes suspend and resume work correctly at my end.
> >>>
> >>> [1] XU4_suspendresume.patch
> >>>
> >>> As per S2MPS11B PMIC 1.2.1 Regulator (Features)
> >>> Fix the min max value for *Buck7* and *Buck8*
> >>>
> >>> -- Buck7 (VDD_1.0V_LDO) 1.5 A (1.2 V to 1.5 V, 12.5 mV step, default on 1.35 V)
> >>> -- Buck8 (VDD_1.8V_LDO) 2.5 A (1.8 V to 2.1 V, 12.5 mV step, default on 2.0 V)
> >> Could you elaborate why such change for Buck7 and Buck8 is needed?
> > Anand has here valid point - the constraints in DTS do not match
> > hardware manual. This leads to question whether voltage table in
> > driver is proper... Another point is the voltage itself. The
> > schematics describes them as at specific voltage (1.35 V and 2.0 V)
> > but after boot they are 1.2 V and 1.85 V. Maybe this shift comes from
> > the problem above.
> >
> >>> Also add suspend-off for *Buck9*
> >>> Buck9 internally controls the power of USB hub.
> >>> Adding suspend the this node help proper reset of USB hub on Odroid
> >>> XU4 / HC1/ XU3
> >>> during suspend and resume. Below it the logs from my testing.
> >> Disabling Buck9 in suspend indeed reduces the power consumed by the
> >> board during suspend-to-ram from about 80mA to as little as 7-10mA, what
> >> matches the results of OdroidXU3. Thanks for the hint!
> > Although I did not get what is the difference in the logs (Anand
> > pasted two logs but they look the same) but the power consumption is
> > reason is good enough. I would be happy to put in the changelog entire
> > consumption  difference. I can measure it on XU3-Lite but can you give
> > me the XU4 (before and after)?\
>
>
> HC1:
>
> next-20190620: 120mA (@5V)
> this patchset: 72mA (@5V)
> this patchset + fixup from Anand: 7-10mA (@5V)
>
> XU4 (SDcard):
>
> next-20190620: 88mA (@5V)
> this patchset: 74mA (@5V), sometimes 42mA (@5V)
> this patchset + fixup from Anand: 6-9mA (@5V)
>
>
> XU4 (eMMC):
>
> next-20190620: 100mA (@5V)
> this patchset: 72mA (@5V), sometimes 41mA (@5V)
> this patchset + fixup from Anand: 6-9mA (@5V)
>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Thanks for this results.

Best Regards
-Anand
