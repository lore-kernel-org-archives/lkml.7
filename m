Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4779C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741112184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="KArX4Xqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfH0GXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 02:23:51 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:38493 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfH0GXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:23:51 -0400
Received: by mail-qk1-f177.google.com with SMTP id u190so16160668qkh.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 23:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/hxD6Hr7ptf3a0nm0wbNiKDwCnbC2CQ3RkjlONhTig=;
        b=KArX4XqmEObsHnaBm4GjJXAaKYPwjDKAogelYpBiv9dFe6ZsED4vHJZhoudhagRq1W
         5r8RB28TQGkYfHmdt6aypcTB6kGnkxs9+5gsCwlowKkBHWVzytbsTCdfOsBOh8FpJT4f
         rh4pKTU95hwocUpqRKimsgOR3E9G+xBFPhlB3iezYeBu/UUO+CG7ODlXN5iESTcbLA0A
         /QUuUdbjBhrRTXqKkdyy7ndpbSbV1YJyzrfA8ELJPe8zfv7BqKktY+EDY9tdoWHfQYjC
         2wcyoOrtbMiP23RnT+T2kIxtSIdgd7H+fZm+oscWtJ5ECPFMfY/YSJm/tHiLoemwmppJ
         dToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/hxD6Hr7ptf3a0nm0wbNiKDwCnbC2CQ3RkjlONhTig=;
        b=WVVJVVh4Q1/44F0PLmhuZprg4MIcG0NCxXsDvhO0FMfcEjSgyN6NFRHoJAXHwootLs
         T0wqp5mEQYPmc2sm42ZQzj7i7lpAQ4/VaNlLBDUWDEUYHZI34MVaa7gPTAgxbC5oMFdf
         btnYsnjZUQIzWT8wAC0lfsAE8KbcdnyCHYABmPEC7p/qE6ak7/KLB2XpxPR3ZPufkizI
         /GB1gy1hIWBuMjj/1z8oa5ULfV3M6S5X07o7/3zxLVGUT9qOymVjSNyEEt9LTi+AjXzs
         ZCpqxP1hdNnheprp3nEIya4jBTZcJALYk3j7x/XEz0dwecUQRD5X+o2e0bk9y5G1UTxJ
         Mg3g==
X-Gm-Message-State: APjAAAWvd4vu9UXt7LWi2G5O2jnd9CmSyMjkEjUNpfJoHAkqblG6Bwap
        DSFdkEGrvuB2YD6sUjI+vQyeSVsKZ+LF7r+9QpH//w==
X-Google-Smtp-Source: APXvYqym5CmRL8vHwAZrqeyLTETMdDqFYUYLDO9U8NmrNR74AAMhTnAm/keGm3idiJ+yi5+UHPn6k+e3XVxzLhF0Mxc=
X-Received: by 2002:a37:4ed3:: with SMTP id c202mr20171340qkb.457.1566887030069;
 Mon, 26 Aug 2019 23:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp47V5G+3UfEzt9wNRr7U-RdLAdCO7JFLQ+QF1JbkuhCcPg@mail.gmail.com>
In-Reply-To: <CAD8Lp47V5G+3UfEzt9wNRr7U-RdLAdCO7JFLQ+QF1JbkuhCcPg@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 27 Aug 2019 14:23:39 +0800
Message-ID: <CAD8Lp44Z8ZsPoxTrsXkvRg80FNyMfGH7jN-pdWjjVTdHWXcB5A@mail.gmail.com>
Subject: Re: Early EFI-related boot freeze in parse_setup_data()
To:     linux-efi@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>, x86@kernel.org
Cc:     Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 2:14 PM Daniel Drake <drake@endlessm.com> wrote:
> Anyway, the system freeze occurs in parse_setup_data(), specifically:
>
>         data = early_memremap(pa_data, sizeof(*data));
>         data_len = data->len + sizeof(struct setup_data);
>
> Dereferencing data->len causes the system to hang. I presume it
> triggers an exception handler due to some kind of invalid memory
> access.
>
> By returning early in that function, boot continues basically fine. So
> I could then log the details: pa_data has value 0x892bb018 and
> early_memremap returns address 0xffffffffff200018. Accessing just a
> single byte at that address causes the system hang.

I noticed a complaint about NX in the logs, right where it does the
early_memremap of this data (which is now at address 0x893c0018):

 Notice: NX (Execute Disable) protection missing in CPU!
 e820: update [mem 0x893c0018-0x893cec57] usable ==> usable
 e820: update [mem 0x893c0018-0x893cec57] usable ==> usable
 e820: update [mem 0x893b3018-0x893bf057] usable ==> usable
 e820: update [mem 0x893b3018-0x893bf057] usable ==> usable

Indeed, in the BIOS setup menu, "NX Mode" was Disabled.
Setting it to Enabled avoids the hang and Linux boots as normal. Weird!

Daniel
