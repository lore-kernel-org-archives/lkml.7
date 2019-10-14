Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73822C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA3C20650
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5tNTV2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfJNGuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:50:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52927 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbfJNGuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:50:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so15915506wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 23:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i556mFwYf8FJIzRWD0xRPKTAzAbrFIRwLz7tLTyc16I=;
        b=e5tNTV2IqKyLBADnPCHorrsl4DDZ/PyUC/We9ZJ/S4okZ5ea9QHFVwRi+yLk9Lji1W
         rdfo7ojt8NP98ddhlVY0DBUWsa5bGfknaH35L9jjjZOcsJ11Y+MlKc+dPNZfQuozaZyQ
         qRKqgEoXTFFwUovAtdAeqCLq+86rxoFgRU/TOPVzJ67GODjs10OBql/M5KHh94TotTGu
         Eha6u9Y93OjZ0J9i+s16TZiYGhykP5lDDwVOiwOZlKDHlGiqXDuxG4wFteH6nTVJibBq
         b+rvDd+8BVTlsgIUNXCS5TT6W2w/9opNbmiB73+3qXweE9hin9cWNWRfpvjGvnidr9ZH
         Yf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i556mFwYf8FJIzRWD0xRPKTAzAbrFIRwLz7tLTyc16I=;
        b=A6mFZ4EE7LlJTekFNRuN/LB2/OS8RM60dWb4HI4AZPA1MWBntzweHIKfuzzjQ33Mad
         tS8R5sIoLEVgkmz7CsiMHDegFGnKS1v5945+46pLQBjzEEa1k5TU1WsWBC7SQKq2i59O
         i2oM/3b4Kn+IzaGwy3MBZfqpoaHaBkFuAh8IiSovPQWioYDlH2GF3bvZ4IQy/7X2bCMn
         MFbsTisyC7zaRrsy4MllN7ffcLNmkTYskvfOdkF8+hTAN5RJ6FXk3auD3vvv042DKuW9
         VEAz5IvYDGH8Cx3tU8VHOaT/bES8xOpYLXt51erA5N4YbHLCJQE112YOH2IWZ2P43OM0
         QX3w==
X-Gm-Message-State: APjAAAWrAQaC9nmLgMwVzDHoI838Dsy+wPC44VCUByxFrSyhGPu/AGuz
        zDN9zxR7ywd3a8T7If5HBQyuvTatP5Kt99H5oIYeyforjpA=
X-Google-Smtp-Source: APXvYqwAq+OXNwY9aVo/Lrl690GryVGV8D6ew4C8ONbtihdPTW56ZKMcf1xOPQB/BVzluTNHdcktl0gSdrv92qMa37I=
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr14005321wml.10.1571035803709;
 Sun, 13 Oct 2019 23:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191013185643.GA2583@localhost.localdomain> <CAMuHMdVa_UaaKEf5sSDs+8AWJL7=X5JVPWuW23qtWqK9fpEecA@mail.gmail.com>
In-Reply-To: <CAMuHMdVa_UaaKEf5sSDs+8AWJL7=X5JVPWuW23qtWqK9fpEecA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 14 Oct 2019 08:49:51 +0200
Message-ID: <CAKv+Gu-aOHbdG2T9fPp7S4PvRAVosnsnCdsdHEk5PHnSN4gBrQ@mail.gmail.com>
Subject: Re: [PATCH v1] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Narendra K <Narendra.K@dell.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 at 08:41, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Narendra,
>
> On Sun, Oct 13, 2019 at 8:57 PM <Narendra.K@dell.com> wrote:
> > From: Narendra K <Narendra.K@dell.com>
> >
> > For the EFI_RCI2_TABLE kconfig option, 'make oldconfig' asks the user
> > for input on platforms where the option may not be applicable. This patch
> > modifies the kconfig option to ask the user for input only when CONFIG_X86
> > or CONFIG_COMPILE_TEST is set to y.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Fix-suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Suggested-by: ...?
>

Indeed

> > Signed-off-by: Narendra K <Narendra.K@dell.com>
>
> Thanks for your patch!
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Thanks all. I'll get this queued as a fix.
