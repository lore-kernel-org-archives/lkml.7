Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0FCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690F42075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfCKO51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:57:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34218 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfCKO50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:57:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id x20so5357751qto.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ftwafbUdfi8At6dXwjpWqHbsdOL+nGx1QxQTVsHPjs=;
        b=BP09uspVuoNAJtiJPxTamG0m3m0t9zLTpBgOpGp7Hm8PDKMnwtn7WCgwIU7ZXaLM9b
         USmZTiRnWX5iPU2kouZoV9DPL5egEDHL4sKhcumdaOrt4T9LcnMS6v2frLe4aPDX1utC
         SIvUixVDCW7w0ArC/GpRY3ttJP690dVMNYPt111GdDG4MpTeuYFvbiEz/elbb64g3DRU
         qGqLy+lfpHweRWKRn6GK1fp49gaW2tr/y4opdh3Xrx/+fPpPUp9q+XvF01c8hQt34i/+
         EMT6l6OXeB53MSudjrBWUGb9LKapHVhopDMquwdxsscng6hDgqxd3K+SyZ2ITvR7NxaU
         tFTQ==
X-Gm-Message-State: APjAAAURPb4iLDSYPRm0CvNHAtMGlihlZoyLcM5rM0rP0W1diEqjG8uw
        yabgduTfFMgdlw38+CyJo84q/TTGsLDWpHcDFLgmLS0OLeo=
X-Google-Smtp-Source: APXvYqw5QVuLk7JovF4dObQUDTE9+0sWQecpeafvAAfMSAkMA9cTtZjg9q8RJMWUi1pVYU2BONHIKE4tL93MHB48bwg=
X-Received: by 2002:a0c:d963:: with SMTP id t32mr25842882qvj.231.1552316245634;
 Mon, 11 Mar 2019 07:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190304195536.1019650-1-arnd@arndb.de>
In-Reply-To: <20190304195536.1019650-1-arnd@arndb.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 11 Mar 2019 15:57:14 +0100
Message-ID: <CAO-hwJLRq-0dXyAS+gg8yasqQuvR82EOeLPb+duj22tpBstKNw@mail.gmail.com>
Subject: Re: [PATCH] HID: hid-asus: select CONFIG_POWER_SUPPLY
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 8:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The newly added power supply code fails to link when the power supply core
> code is disabled:
>
> drivers/hid/hid-asus.o: In function `asus_battery_get_property':
> hid-asus.c:(.text+0x11de): undefined reference to `power_supply_get_drvdata'
> drivers/hid/hid-asus.o: In function `asus_probe':
> hid-asus.c:(.text+0x170c): undefined reference to `devm_power_supply_register'
> hid-asus.c:(.text+0x1734): undefined reference to `power_supply_powers'
> drivers/hid/hid-asus.o: In function `asus_raw_event':
> hid-asus.c:(.text+0x1914): undefined reference to `power_supply_changed'
>
> Select the subsystem from Kconfig as we do for other hid drivers already.
>
> Fixes: 6311d329e12a ("HID: hid-asus: Add BT keyboard dock battery monitoring support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to for-5.1/upstream-fixes

Cheers,
Benjamin

>  drivers/hid/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 6ca8d322b487..4ca0cdfa6b33 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -150,6 +150,7 @@ config HID_ASUS
>         tristate "Asus"
>         depends on LEDS_CLASS
>         depends on ASUS_WMI || ASUS_WMI=n
> +       select POWER_SUPPLY
>         ---help---
>         Support for Asus notebook built-in keyboard and touchpad via i2c, and
>         the Asus Republic of Gamers laptop keyboard special keys.
> --
> 2.20.0
>
