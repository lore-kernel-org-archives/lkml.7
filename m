Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D900C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6A820835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwMUWG3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCDUVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:21:52 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46484 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDUVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:21:51 -0500
Received: by mail-ua1-f68.google.com with SMTP id j8so5587509uae.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 12:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HmQU9HE2kvZFD8YwI08DcfcXKDd63qmf8wkeC7PAYQ=;
        b=GwMUWG3gQJDJSKAUA6rendPH+r4moeaCEFIIvdEN3NAoFsSQi3cV20GCdd98QtQW42
         vM2OnHEuQCSwDgvKOCa/FwLNJwnPq8iYVVoq6R5baBuC0skHHDWXOmVwGTu7N0pA7TXf
         N/zdFp/qGvlCXwDvktHOLHmO48ayBEITy9HGWGT+ovZYz6H0UEzKdLrJjQmwY9FkFbE3
         WYv8KZyFtMXTq8klqrej0KvWx+qQU+YfQ/pM0GKsuS0NwHrToJyEFX2Bgsom1+31zvoT
         +MJYzEeEeJCIKyNglRCEj0GAwMqR2nv0l3n4tWUrj9nZ6ml+b6oSxi3ibaQEXcNXTIZd
         Wlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HmQU9HE2kvZFD8YwI08DcfcXKDd63qmf8wkeC7PAYQ=;
        b=LpdgLsqp0SO/Mw/5AUjiybPmDKhAxgTDxofh4u8oDGQwk+c0Ypry1rEB9Bcoh3fjat
         wCcGcB06N2LgAbJGO8oNDDyWUIsKWJQMVCBFdinz5aAF9MwchJugym0/oG+K5k5KQv0f
         ykc6ra7M+2EjSfpI8VzmSF/sura1lopCS5FtCuY35FWoO+CwhZ43OHckjjw9GP34l4r+
         tbReQsJDwR4rRWhKYK1kKwJX6D0iwy0QwZk1vu4vgXI9ZhKZ47/GtlYcWw2tKVyFJWPi
         aNI8YdtPnSo+esBDRMosKqsBbtT71AzjmUg6/brSHmmWAgZtpNPuUbWp0RzksQGLkM1M
         2FZw==
X-Gm-Message-State: APjAAAVQKOSyBL99hrUQeoUJVvHVjHpAvLTD07Hv/L+/Aha6B2Iw1yLS
        xQBxpAYAoJak6w0c31b4ej1zQJPPez+rkzeOlHM=
X-Google-Smtp-Source: APXvYqx7FAvXojFijr2QAJUeSYaXPcZc26N8CTG1cRorJoS/AmfmS8dHNU+HaxTrLlQXBd9fYrV3aKxE/V16qhGAPrs=
X-Received: by 2002:a67:6849:: with SMTP id d70mr10668748vsc.61.1551730910260;
 Mon, 04 Mar 2019 12:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20190304200412.1269035-1-arnd@arndb.de>
In-Reply-To: <20190304200412.1269035-1-arnd@arndb.de>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 4 Mar 2019 22:21:24 +0200
Message-ID: <CAFCwf132vLS4jkc6QriNmV8bf4LzRGCyKXkdxQteJPcwuJBjUg@mail.gmail.com>
Subject: Re: [PATCH] misc: habanalabs: avoid HWMON dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 10:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When CONFIG_HWMON is disabled, we currently get a link error for this driver:
>
> ERROR: "hwmon_device_unregister" [drivers/misc/habanalabs/habanalabs.ko] undefined!
> ERROR: "hwmon_device_register_with_info" [drivers/misc/habanalabs/habanalabs.ko] undefined!
>
> As the hardware monitoring is not a required part of the functionality,
> make it possible to compile without HWMON by ignoring all that functionality
> depending on the configuration.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/misc/habanalabs/hwmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
> index 77facd25c4a2..933746639831 100644
> --- a/drivers/misc/habanalabs/hwmon.c
> +++ b/drivers/misc/habanalabs/hwmon.c
> @@ -423,7 +423,7 @@ int hl_hwmon_init(struct hl_device *hdev)
>         struct device *dev = hdev->pdev ? &hdev->pdev->dev : hdev->dev;
>         int rc;
>
> -       if ((hdev->hwmon_initialized) || !(hdev->fw_loading))
> +       if (!IS_ENABLED(CONFIG_HWMON) || (hdev->hwmon_initialized) || !(hdev->fw_loading))
>                 return 0;
>
>         if (hdev->hl_chip_info->info) {
> @@ -451,7 +451,7 @@ int hl_hwmon_init(struct hl_device *hdev)
>
>  void hl_hwmon_fini(struct hl_device *hdev)
>  {
> -       if (!hdev->hwmon_initialized)
> +       if (!IS_ENABLED(CONFIG_HWMON) || !hdev->hwmon_initialized)
>                 return;
>
>         hwmon_device_unregister(hdev->hwmon_dev);
> --
> 2.20.0
>

Hi Arnd,
I sent a patch to gkh to fix this last week (and he merged that into
his tree), but I took a different approach of selecting HWMON in
kconfig (with an added depends on of HAS_IOMEM to prevent dependency
breakage).
I don't really want the driver to load without HWMON support. I took
the example from AMD's amdgpu driver which does the same thing.

Thanks,
Oded
