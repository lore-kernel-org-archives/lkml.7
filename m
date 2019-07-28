Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83293C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 16:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5840A2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 16:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="miIE5U6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfG1QvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 12:51:12 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45345 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfG1QvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 12:51:09 -0400
Received: by mail-io1-f67.google.com with SMTP id g20so114962185ioc.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iPSTb/ugUHYwVlT9/uQIlUkREIRlUpHM1TgwBqyHsyk=;
        b=miIE5U6vo4jaVkuTEOM7/ypLJ3V+22yx72Dn1jCqSFjPIFe/SSAYUvZWJK0GgkpuRo
         wIRC24qiddywrZDvNEz0d/bk94SqU34ES/OlW4GFVnyqq2h21yTR1op1wXW//lgFuMCe
         fdCSvcoWcI/rmok2/AAa4R8VXAXeAQskSKRZgxPq5Kyta0Oku/W/Ap9H1FGphG4P5tLH
         /1+JA3oTL7dCU4DQzfFLv70PsddVUxu/tG8yrd+qBRonh8UVXriUqWaY6IGo+hxrU6q/
         NXl+Nw32bDVGiEfx5A2/sypKeRrnQvXp4LtvtkVI//pL6arOEMpKPv3zCq1BW1My/1BW
         5qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iPSTb/ugUHYwVlT9/uQIlUkREIRlUpHM1TgwBqyHsyk=;
        b=MAl05iKdwC4kU7FcBQb4XlhZfHLPQO6GuyQ82MqIDRRgJ+bNNmJFds33/XVfXLN8sg
         5Rfu8t+37oLdDKiKbwt/hMaiAhTrW358GMUincOZCBp/1dlh21Tn2GihHKclOvHsEs1S
         4FluRm+DzqV7yAELh9VEQRpJVblhjFluQv1tzd93tVksmaf3mUMAwoeckCGZhpLpwoD0
         Km2tOTF2QalI6DC/aT2s1dM5GbMsltOsiaGOdmBTSre8lO9qEO1vU5QG/7qmdzKq4MN+
         Nlf2ADzF5lll60mgi8T7FwGJbPIjKmYoDKQ/VIe3Lb8Y3rz6HJldhmoOTq6zLYiG+5Y1
         mHow==
X-Gm-Message-State: APjAAAVNfPfy8r7L+/f6xMeuIlf10DT0rB2aYCZ0GD8c/cKo9v/2qLx4
        YhVXduWLQao1Ik7klp7+A120xFn13jPWmf5lGQA=
X-Google-Smtp-Source: APXvYqxDP/Xc4YvFTazXuFe3kUOMZmk9NmWfWq1JFLzpBh0f15mNtNVuIvC7ICSDFCC05pVsc3xEtlgwjKAkHlHwaiQ=
X-Received: by 2002:a02:c492:: with SMTP id t18mr108750115jam.67.1564332668827;
 Sun, 28 Jul 2019 09:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190728184138.78afc30f@endymion> <20190728184255.563332e6@endymion>
In-Reply-To: <20190728184255.563332e6@endymion>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 28 Jul 2019 18:50:58 +0200
Message-ID: <CAMRc=Mc6mB56zkhOzvBsJtyePx3H6DvVLLSYwPChBNoyD_zR2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nvmem: Use the same permissions for eeprom as for nvmem
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Linux I2C <linux-i2c@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 28 lip 2019 o 18:43 Jean Delvare <jdelvare@suse.de> napisa=C5=82(a)=
:
>
> The compatibility "eeprom" attribute is currently root-only no
> matter what the configuration says. The "nvmem" attribute does
> respect the setting of the root_only configuration bit, so do the
> same for "eeprom".
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: b6c217ab9be6 ("nvmem: Add backwards compatibility support for olde=
r EEPROM drivers.")
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes since V1:
>  * Split into 2 patches, one to the at24 driver and one to the nvmem
>    core. drivers/nvmem/nvmem-sysfs.c |   15 +++++++++++----
>
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> --- linux-5.2.orig/drivers/nvmem/nvmem-sysfs.c  2019-07-08 00:41:56.00000=
0000 +0200
> +++ linux-5.2/drivers/nvmem/nvmem-sysfs.c       2019-07-28 18:06:53.10514=
0893 +0200
> @@ -224,10 +224,17 @@ int nvmem_sysfs_setup_compat(struct nvme
>         if (!config->base_dev)
>                 return -EINVAL;
>
> -       if (nvmem->read_only)
> -               nvmem->eeprom =3D bin_attr_ro_root_nvmem;
> -       else
> -               nvmem->eeprom =3D bin_attr_rw_root_nvmem;
> +       if (nvmem->read_only) {
> +               if (config->root_only)
> +                       nvmem->eeprom =3D bin_attr_ro_root_nvmem;
> +               else
> +                       nvmem->eeprom =3D bin_attr_ro_nvmem;
> +       } else {
> +               if (config->root_only)
> +                       nvmem->eeprom =3D bin_attr_rw_root_nvmem;
> +               else
> +                       nvmem->eeprom =3D bin_attr_rw_nvmem;
> +       }
>         nvmem->eeprom.attr.name =3D "eeprom";
>         nvmem->eeprom.size =3D nvmem->size;
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>
>
> --
> Jean Delvare
> SUSE L3 Support

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
