Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E339C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF0F206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs76Avm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfCFKPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:15:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44036 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbfCFKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:14:58 -0500
Received: by mail-lf1-f66.google.com with SMTP id u9so4368039lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 02:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQTtq3rGKMAQ/ce0pmjaR0fRPuu4KLxWNVqpk+T7nGc=;
        b=Hs76Avm0miwdMjRB2fGoqKrFWfBwSrRpKxPGTa0kPeYCwf78clkHbwhpqGay6JZdfJ
         PPiTFugGLOB1U0jIgOA6XhAP+KVmDkJqBCS26IXk5i9tgviLsk1rYOl3tz4OFNsJM2C1
         Xdlp3+ZB5EA6MNX1T30DqTdxTyktljR6XBdGDArvPIh7iXzc8Ue1/ZFqXM7Y3kGXGEI/
         fHqw+OJrXKA6qtcBidVf1TrIduUjyZsGab6GkLW/ChSzDsDJKDqHRig8laCAgNP7EFDC
         bwLgidRsGT0TsZYwe6qa3hiQkLOc4n8uRNHsxKF/ZB9O7JCKXIsf3F/IghMvZOypwcBf
         Dd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQTtq3rGKMAQ/ce0pmjaR0fRPuu4KLxWNVqpk+T7nGc=;
        b=RDzf0Ip/mxWeXoC+cuuEeHty0J3xE/amz8YCXeeAKAkElKAIqYiUA6MZuiR7K5DvU2
         Hwg42MK0suDR/wBRqDRU0FftNJjTwttozohfvLSWaZ+oEeI42zt0Movkm6tXMU4qnsP+
         R5QViliUz/IM0zvTEx1EPQN96Lk8c6KzR5oEMpjBRbpBp9/aXQUKboO5wx3j1O54q7Rd
         BCDC3ntpe/W/GH5fMCbyZVIf1JlwfkfFME375E2AAbfD5ajjZTYczbKf4Zp8/fTm78dc
         VPy8pDbxn8oAP/th71Z1VYRQuzMN8ojS5jvzJO/6lPKruzupidZ3oUl2pzGDcaiPtuaK
         5zyg==
X-Gm-Message-State: APjAAAXBqmbhdvyTMWbN1lTWNimeJLURbgPTlrv7zzagg9j94gK6Cex6
        nsZNS8ITYdJVUaCg31KM2MGAYEko7t3vLDPzSJE=
X-Google-Smtp-Source: APXvYqzhI7xDPUkgDWXX3OESNvErk8BhIkFR9VDxj+xxusxH6VGw5O5Oee/Xs3Uc1gWzPrv02Dc4haZ/t5Ik04OeR5Y=
X-Received: by 2002:ac2:510e:: with SMTP id q14mr3418910lfb.151.1551867295896;
 Wed, 06 Mar 2019 02:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20190301184816.784-1-mans@mansr.com>
In-Reply-To: <20190301184816.784-1-mans@mansr.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Mar 2019 11:14:45 +0100
Message-ID: <CANiq72=H1Gubbr+eoEKUR+m49fkcC7Sr_hsyP3azzpk=i-au+Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: deconfuse configuration
To:     Mans Rullgard <mans@mansr.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 7:48 PM Mans Rullgard <mans@mansr.com> wrote:
>
> The auxdisplay Kconfig is confusing.  It creates two separate menus
> even though the settings are closely related.  Moreover, the options
> for setting the boot message depend on CONFIG_PARPORT even though they
> are used by drivers that do not.
>
> Clear up the confustion by moving the "Parallel port LCD/Keypad" menu

"confustion" -> "confusion"

> under auxdisplay where it logically belongs.  Change the boot message
> options to depend only on CONFIG_CHARLCD, making them accessible also
> when only the HD44780 is selected.
>
> Since the "Parallel port LCD/Keypad" driver now has a new dependency
> on CONFIG_AUXDISPLAY, rename its Kconfig symbol and keep the old one
> such that make oldconfig will not disable the driver.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/auxdisplay/Kconfig  | 17 ++++++++++++-----
>  drivers/auxdisplay/Makefile |  2 +-
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index 57410f9c5d44..7d3fe27d6868 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -164,9 +164,7 @@ config ARM_CHARLCD
>           line and the Linux version on the second line, but that's
>           still useful.
>
> -endif # AUXDISPLAY
> -
> -menuconfig PANEL
> +menuconfig PARPORT_PANEL

Do we want the PARPORT_ prefix here but not on the suboptions?

Also, having PANEL_PARPORT and PARPORT_PANEL seems confusing...

>         tristate "Parallel port LCD/Keypad Panel support"
>         depends on PARPORT
>         select CHARLCD
> @@ -178,7 +176,7 @@ menuconfig PANEL
>           compiled as a module, or linked into the kernel and started at boot.
>           If you don't understand what all this is about, say N.
>
> -if PANEL
> +if PARPORT_PANEL
>
>  config PANEL_PARPORT
>         int "Default parallel port number (0=LPT1)"
> @@ -419,8 +417,11 @@ config PANEL_LCD_PIN_BL
>
>           Default for the 'BL' pin in custom profile is '0' (uncontrolled).
>
> +endif # PARPORT_PANEL
> +
>  config PANEL_CHANGE_MESSAGE
>         bool "Change LCD initialization message ?"
> +       depends on CHARLCD
>         default "n"
>         ---help---
>           This allows you to replace the boot message indicating the kernel version
> @@ -444,7 +445,13 @@ config PANEL_BOOT_MESSAGE
>           An empty message will only clear the display at driver init time. Any other
>           printf()-formatted message is valid with newline and escape codes.
>
> -endif # PANEL
> +endif # AUXDISPLAY
> +
> +config PANEL
> +       tristate "Parallel port LCD/Keypad Panel support (OLD OPTION)"

Hm... what do you mean by "OLD OPTION"? Should we keep it? (I don't
see any other place using this marking).

> +       depends on PARPORT
> +       select AUXDISPLAY
> +       select PARPORT_PANEL

I agree the menu was a bit convoluted and we didn't get to clean it.

Since you are touching the panel.c options, CC'ing the maintainers
(please do run get_maintainer.pl in that case!)

Cheers,
Miguel
