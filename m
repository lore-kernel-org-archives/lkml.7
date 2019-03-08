Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A0DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA462081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IUElFpvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCHWBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:01:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44182 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfCHWBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:01:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id q128so18640354ljb.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 14:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zO3PfwFSKDKWJC3TDmz1MSCFMQZLNC4yHVXFwl6EQ4Q=;
        b=IUElFpvEH+VVOUCITY48gX3jUy1NiV9ZiNVSDbPD2KsrXiCcJqOp82f2jyHjw9y6iX
         ZQecgLDZxh+PauDk6lqGQusqfvjgAQwWwEVvi57ALQNNTAyKuTTh43D4dZr2LgTztsa5
         ETuS73nJYwoFlF9Hd3+M7hBU8B0QOH6oNxZGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zO3PfwFSKDKWJC3TDmz1MSCFMQZLNC4yHVXFwl6EQ4Q=;
        b=YIUj/OEymOs3E8ldIrEeU02NTxnY/WGzKn4lJjehF8lcqJy1uvp2HVpgemoJ6mrrBE
         48jLb0AwOOefvc2W2Tu4u7N612csmbtH3zxivujFOBoVHMyHGbCGe9ccPmM+53kfZUiP
         9IKnvSanC6UO6DtI58KjnllGyrd4cfSo+Sy/Et8lnU+xRJGbToLKz6H2V+PD5MmbWWA3
         k4qRaNk4D3U7ITjWg/JdcQpoZ8hsnlg68w+9Hz7Ru5XMM0J3WISBmHijTqy1Y1yUmISM
         kKMN6QPUD3u21rZn79OASpWOR1VoE/I9Ek1jX2rh++Awxed13ReNiesDYFb7LgyFNFmw
         oeKw==
X-Gm-Message-State: APjAAAU/AABopU99H+swtA4DTE+gSQV8nUHrEBZNcI9iMlFB+b33OSY5
        rNQdnruEGS1GnYjgOMEFbWgJNAKgCWo=
X-Google-Smtp-Source: APXvYqxtXXhfKwvD0uwiScvSGnwPNYZkUVmS2TY5ARjCs0ItN+sTiRHWq9an/KghdVn9/Xu8TlERug==
X-Received: by 2002:a2e:408:: with SMTP id 8mr10283928lje.15.1552082479896;
        Fri, 08 Mar 2019 14:01:19 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id s7sm1629252ljs.8.2019.03.08.14.01.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 14:01:19 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id k136so5007018lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 14:01:18 -0800 (PST)
X-Received: by 2002:ac2:4425:: with SMTP id w5mr6695190lfl.139.1552082478484;
 Fri, 08 Mar 2019 14:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20190308203801.57920-1-ncrews@chromium.org>
In-Reply-To: <20190308203801.57920-1-ncrews@chromium.org>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Fri, 8 Mar 2019 14:01:07 -0800
X-Gmail-Original-Message-ID: <CAE_wzQ-Ds5a9iPuLTpV5mBHBtoUUh_-fRw66s0Su7eOifygqKQ@mail.gmail.com>
Message-ID: <CAE_wzQ-Ds5a9iPuLTpV5mBHBtoUUh_-fRw66s0Su7eOifygqKQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Add Wilco EC keyboard backlight LEDs support
To:     Nick Crews <ncrews@chromium.org>
Cc:     enric.balletbo@collabora.com, Benson Leung <bleung@chromium.org>,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        Pavel Machek <pavel@ucw.cz>,
        lkml <linux-kernel@vger.kernel.org>, dlaurie@chromium.org,
        Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 12:41 PM Nick Crews <ncrews@chromium.org> wrote:
>
> This patch is meant to be applied on top of the for-next
> branch of the platform/chrome repository, as it uses some of
> the code staged there.
>
> The EC is in charge of controlling the keyboard backlight on
> the Wilco platform. We expose a standard LED class device at
> /sys/class/leds/wilco::kbd_backlight. This driver is modeled
> after the standard Chrome OS keyboard backlight driver at
> drivers/platform/chrome/cros_kbd_led_backlight.c
>
> Some Wilco devices do not support a keyboard backlight. This
> is checked in probe(), and in this case the sysfs entry will
> not appear, and everything will behave normally.

It would be even better if we did not register platform device if EC
does not support backlight.

> +       data->led.brightness_set = keyboard_led_set_brightness;
> +       data->led.brightness_get = keyboard_led_get_brightness;

wilco_ec_mailbox() may sleep, so you need to assign it to
led.brightness_set_blocking.

Thanks,
Dmitry
