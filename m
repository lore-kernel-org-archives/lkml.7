Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B1FCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6BA21D71
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIOdbhWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfKDObU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:31:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33851 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:31:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id e4so11430799pgs.1;
        Mon, 04 Nov 2019 06:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHM+Nw/8jOJvv4TBTdEZSFA2s4Y3e3lovWANcXpAB3E=;
        b=hIOdbhWwtMCBydD/NiFvFvyTYNWGcsVlwT1ldA2nksr7jJXY22Eb4rwji4+5s2FsCe
         SOsKwzFHhFBYe4/V/zi41UNssZFcfRhgmifDni4n/QPlABu6o7Abnhj4phbNvGyMgl/L
         wplo3DdL9N0IVfahkBM87ROl593oSo7UfUfu8kFNAMe47FoJiYyyqX91YxbeUQ8E1IV6
         NTkPC0N9WDQjypbK0NOkYI592Q9DmYBrifVHUEK2oqq9wN4cy3xEspZgkTZUOxIdtE6E
         xoEkeaoZjtYQ/lkWLue0sQSul8k7nhah597D1nZqGG7yGbQMPX50TaVLGsktsqxqsWO4
         VE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHM+Nw/8jOJvv4TBTdEZSFA2s4Y3e3lovWANcXpAB3E=;
        b=Am/JrSweTNB7VEODen6U3fWGmCSal/A/Ggt1keJoZQySxBvChDK5vAgDMpluHFaIAU
         7BUP2KGWcwzpZXBTj0fLfLpRuVHNyHVK+VINYJw77tv/8sp6rlpAuQpAbLobBMfFVIci
         8sEPmDnEUzyiqD67Zqxae4vtZwhx37HVLmQoNIf6nGiGTdxj6Lwni2aJ5AdlnbL8tIkd
         yyyUfkeyVHX0RSDhaYtd4Oc6E68K7rGcu/9jnIum2PSKoyPQRcVR6DYGWBiARIogQzyj
         XqlZuAkZONvTkwr5Ih8JhBCjFGMCZEsMGMkc8ex3L6Ye3dIuVuuNZDboq7lDjahpCbmc
         Flyw==
X-Gm-Message-State: APjAAAWRNYLuFMZ6CzCYCGP6F0MK6h/B0+qu97FWvpy56wqGxt2VJQXd
        CDbucoW/N8ueV7HubfJiUvb80z8fdTioHmd8Bsmt41xFDpE=
X-Google-Smtp-Source: APXvYqw6KOPjWc2b09oNvxgMcJ2S3F00dCe5H/tm0SJ/9zK/yaeulcXhQWqKh2vy08N3hQv5MkL86yZkiAJrnfbHs7k=
X-Received: by 2002:a62:1ad6:: with SMTP id a205mr31347462pfa.64.1572877878124;
 Mon, 04 Nov 2019 06:31:18 -0800 (PST)
MIME-Version: 1.0
References: <CAPW-Pu0KuxqbKSQ2JQaxh5AHbdZdNQZJfOgxoe_XZSxow+9e3A@mail.gmail.com>
 <CAPW-Pu0qCfNXwjDW90To5ZpwtfpXAzm93CWFaUvA_9YQW5Ke-g@mail.gmail.com>
In-Reply-To: <CAPW-Pu0qCfNXwjDW90To5ZpwtfpXAzm93CWFaUvA_9YQW5Ke-g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Nov 2019 16:31:07 +0200
Message-ID: <CAHp75VfxN-CEeMiQDfuBge81sFnDbQuOQ-W4Ksc3d2QGJCWC1w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] platform/x86: asus_wmi: Fix return value of fan_boost_mode_store
To:     Leon Maxx <leonmaxx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 12:54 PM Leon Maxx <leonmaxx@gmail.com> wrote:
>
> Function fan_boost_mode_store should return number of bytes written
> but instead it returns return value of kstrtou8 which is 0 if
> conversion is succefull. This leads to infinite loop after any
> write to it's SysFS entry.
>

Fixes tag missing.

> Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
> ---
>  drivers/platform/x86/asus-wmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 821b08e..723aa4d 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1718,7 +1718,7 @@ static ssize_t fan_boost_mode_store(struct device *dev,
>   asus->fan_boost_mode = new_mode;
>   fan_boost_mode_write(asus);
>
> - return result;
> + return count;
>  }
>
>  // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
> --
> 1.8.3.1



-- 
With Best Regards,
Andy Shevchenko
