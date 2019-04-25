Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A1DC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD173217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfDYHmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:42:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46890 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfDYHmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:42:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id w73so10291568qkb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 00:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1op64QnAmieKTZSOLpdw0JxJz2nUcnF9mxhpgFOqTs=;
        b=Ye9rZkvkEzJ0ScFp29uhX5fUi3XTnGSE9nJW05AJ7lBtSC5ewYTjaQGk8gahU3B+Xu
         /AGrA48W7IgmpdGodusIXtwf7eL2DxKEcdPFM2YCEuqlDyDN8Tv7FV17BXM43cUq/QkA
         9HCzZtez6KsE8pHpV4uQ1S5vB4GP0ipuUInD+XvJdILNGACvUEpkGzw4gn/fmWe3/xAa
         qHg2CeLfBQo7BmlFYynMl1M5+trXwlvJ1189gjy2iW9AExyoz5518pMwRh7ssIWMQfFh
         sat2apekMoExdSBMHlIIsjqp9sRrgYtvv/3ZXBJKUUPVc6ivHso8gnOZMiIfbhdbVyBN
         82KQ==
X-Gm-Message-State: APjAAAUkxDLYQwTlm5hHvA3dIm7/wngDklDMQPEf9k76EkAqm0nXMqqT
        HxRh7LwANPjlk3HmA4f6uG59+UhQmAgNhdVODEYocXPyOBQ=
X-Google-Smtp-Source: APXvYqz4pbnbRJeyq+T1vonA+6dgY3BPga3ldNLredaHw2X0PPFtNhpQhlpagjUApORlobEnrQNvZC/iFS431jpm1zM=
X-Received: by 2002:a37:7b03:: with SMTP id w3mr8307278qkc.266.1556178139651;
 Thu, 25 Apr 2019 00:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190425073942.36980-1-yuehaibing@huawei.com>
In-Reply-To: <20190425073942.36980-1-yuehaibing@huawei.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 25 Apr 2019 09:42:08 +0200
Message-ID: <CAO-hwJ+hfza_e9ZsouqczO2PHva_bokAuz+ZekF3AuqEGwk4=w@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-dj: Fix build error without CONFIG_USB_HID
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 25, 2019 at 9:40 AM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> During randconfig builds, I occasionally run into an invalid configuration
>
> drivers/hid/hid-logitech-dj.o: In function `logi_dj_probe':
> hid-logitech-dj.c:(.text+0x32dc): undefined reference to `usb_hid_driver'
>
> This is because CONFIG_USB_HID is not set, So this
> patch selects it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: da12b224b7d5 ("HID: logitech-dj: deal with some KVMs adding an extra interface to the usbdev")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks a lot, but I already scheduled
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-5.2/logitech&id=c08f38e9fd0b5486957ed42438ec8fa9b6ebbf4f
in for-next.

It's weird it doesn't show up in your bot... :/

Cheers,
Benjamin

> ---
>  drivers/hid/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 76d8206..c3c390c 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -521,6 +521,7 @@ config HID_LOGITECH
>
>  config HID_LOGITECH_DJ
>         tristate "Logitech Unifying receivers full support"
> +       depends on USB_HID
>         depends on HIDRAW
>         depends on HID_LOGITECH
>         select HID_LOGITECH_HIDPP
> --
> 2.7.4
>
>
