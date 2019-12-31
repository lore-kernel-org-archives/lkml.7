Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E599BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 06:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0114206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 06:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="DalUh6mA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfLaGxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 01:53:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39429 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLaGxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 01:53:50 -0500
Received: by mail-qk1-f195.google.com with SMTP id c16so27799542qko.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 22:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8oUvpDvzRH5Q0vMA5hSnqJhBgUakZh+XLGeAmOlRnA=;
        b=DalUh6mATH2DoFJXM3BCv/x0xcU29Mo6A9vhC5r9fczuQzKa8rK4khRyyFkla0HPSt
         WXgEevDSkf6TLwG6qYfeJtcZh7JCsn9oAgmvaDR9MPFcAogSK/lWoJYPAiyj/u7HrUjQ
         KhUYxoe1mwFicr9u/UkaDff9IlSZ5K8c5eUlxRLNGpnB+FZzgXIFMTL9yXz56nTptORa
         qlP3yKhKBXQZ97RMLizIdAKrmSd4tEVXZxMJwBo8WTbP4LNaQRvYIUNAL43DvSt5zb0Y
         JdzLIUZg8mMrcitF0vUuaqp93mpW6ePUvWb3KJzNwjjmWVKMXbegOJVl5eLSgjhoYfcP
         GsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8oUvpDvzRH5Q0vMA5hSnqJhBgUakZh+XLGeAmOlRnA=;
        b=N7LJTauCxP1GfYULdYeM7p+5y6oLl9watO9ZwDQil+MXDkKLXI114hdh11CgzvtVhd
         UGtGXcBOKwtLwdsHoxVHqFI10pJ5Y4/leCExaOGVS9ymG40rHiky1VpY9QEaetHjcPW2
         jvx38N0Rh9pNcqCMpGDQKrZk7st6J9T/V6NaI/AGF3OSZfD0HEdFBpdy/WY2QUHo77RO
         80DEav77vR2YpdCT4V9lFb7sBLLcFMh69gAEsQAvi3Qo4b1uWhQQbX15Gbm4ROWcb5vh
         nbqe9xeaGerLv+sNxeo9smAnVTR4qUiNmYrCd4mK2v4EYuj6g6PzzGxIIBY3qwtqhKTb
         4TLg==
X-Gm-Message-State: APjAAAXNDAjTxDmNpV2rcfBw+5xGUQTUE6W3VrZ+FK4x2JjtPbkjV2gp
        mtGQwkIeg/lvaWDkNCRycM6KJHZjJkhUX28eiC/1Bg==
X-Google-Smtp-Source: APXvYqxjFQQ8f95+v4SL/EkqDB90/1NqXUvaD+c/be5LkfStv9ZQRYM6wy0IJqjmGOwN7fXZA8OgxqVESY85LvoYTxI=
X-Received: by 2002:ae9:f003:: with SMTP id l3mr58038977qkg.457.1577775228982;
 Mon, 30 Dec 2019 22:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20191230083044.11582-1-jian-hong@endlessm.com>
In-Reply-To: <20191230083044.11582-1-jian-hong@endlessm.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 31 Dec 2019 14:53:37 +0800
Message-ID: <CAD8Lp45Le=s=1Q9oi0JCJTPepNmX002hK7W6UwKztTq09QBUgw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Fix keyboard brightness cannot be
 set to 0
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        nweibley@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 4:32 PM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>
> Some of ASUS laptops like UX431FL keyboard backlight cannot be set to
> brightness 0. According to ASUS' information, the brightness should be
> 0x80 ~ 0x83. This patch fixes it by following the logic.
>
> Fixes: e9809c0b9670 ("asus-wmi: add keyboard backlight support")

The spec says says bit 7 is Set light on, and bits 0~3 are level,
similar to the comment being removed. But indeed it isn't entirely
clear about how to turn it off (since what does Light on but level 0
mean?).

This code goes back to 2011, so there's a risk of inversely affecting
old models with this change.

I checked our DSDT collection and the behaviour is quite inconsistent.

On the UX431FLC that you fixed with this patch, we reach:

        Method (SLKI, 1, NotSerialized)
        {
            Local0 = (Arg0 & 0x80)
            If (Local0)
            {
                Local1 = (Arg0 & 0x7F)
                If ((Local1 >= 0x04))
                {
                    Local1 = Zero
                }

                \_SB.PCI0.LPCB.H_EC.KBLL = Local1
                KBLV = Local1
            }

            Return (Local0)
        }

Nothing will happen unless bit 0x80 is set. So that's why your patch
fixes the problem in this case. But In 81 DSDTs examined this is the
only model that exhibits this behaviour. Perhaps it is the very latest
revision that will be rolled out from this point.

Many other models have this:

        Name (PWKB, Buffer (0x04)
        {
             0x00, 0x55, 0xAA, 0xFF                           // .U..
        })
        Method (SLKB, 1, NotSerialized)
        {
            KBLV = (Arg0 & 0x7F)
            If ((Arg0 & 0x80))
            {
                Local0 = DerefOf (PWKB [KBLV])
            }
            Else
            {
                Local0 = Zero
            }

            ST9E (0x1F, 0xFF, Local0)
            Return (One)
        }

for which your patch is also OK. You can follow it through and see
that value 0x0 and 0x80 both result in the same single register write
of value 0.

But there are 30 models (e.g. UX331UN) that will see a behaviour
change via this patch:

        Method (SLKB, 1, NotSerialized)
        {
            KBLV = (Arg0 & 0x7F)
            If ((Arg0 & 0x80))
            {
                Local0 = 0x0900
                Local0 += 0xF0
                WRAM (Local0, KBLV)
                Local0 = DerefOf (PWKB [KBLV])
            }
            Else
            {
                Local0 = Zero
            }

            ST9E (0x1F, 0xFF, Local0)
            Return (One)
        }

Here, writing 0x80 to turn off the keyboard LED will result in an
additional WRAM(0x9f0, 0) call that was not there before. I think we
should double check this detail.

Let's see if we can borrow one of the affected models and double check
this patch there before proceeding. I'll follow up internally.

(I also checked eeepc, but it seems like they don't have a keyboard backlight)


> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
>  drivers/platform/x86/asus-wmi.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 821b08e01635..982f0cc8270c 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -512,13 +512,7 @@ static void kbd_led_update(struct asus_wmi *asus)
>  {
>         int ctrl_param = 0;
>
> -       /*
> -        * bits 0-2: level
> -        * bit 7: light on/off
> -        */
> -       if (asus->kbd_led_wk > 0)
> -               ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
> -
> +       ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
>         asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
>  }
>
> --
> 2.20.1
>
