Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB82C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 20:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956E020730
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 20:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="zziXcq55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfKPUGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 15:06:06 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43722 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfKPUGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 15:06:06 -0500
Received: by mail-io1-f68.google.com with SMTP id r2so9120861iot.10;
        Sat, 16 Nov 2019 12:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wY1wH3qJgZtpNtkLWPMs/Hx5JZ/6TSGVFBrFCFyrP5o=;
        b=zziXcq55OlVOLuZm7MpRDSXWx30fu7+5Cc3euyCJwYEaWyc2g7+EtTnm9Id9niU/Nm
         W+EZ8rWp14SISd2GKzLLAkXRwHYdzns3wsabAHX56ZN/2qTHNkqyCj9tymnEF1k3LUg4
         EtoLos0XdYzH0kq5sHpkiHLGBE7DKzR8NXHoiHIcTuZjlyRDZCb1AhH+U8F82bVIZQ1e
         604IsRtqHo7qfhCQh7bcBA6SoF1auC3TKjHgdDQkis2vYgvBQ/IHcG45+GUAoz1yyJVR
         0zPjpZWXLipG/qtReTR432LKjQdmnyUA7ZNQI4Q0IAXm2uTiNzzqici4JwcEQOLnrocm
         52bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wY1wH3qJgZtpNtkLWPMs/Hx5JZ/6TSGVFBrFCFyrP5o=;
        b=e/ngN2sabzG5ipZh3vnOYTIYSNlK7N5u0iCTHMbgeQAxO++DpJYt3NOGTqjewlkwNN
         ZleMDPxbGbW3gxBTjm4Q87gK9q5SaC2l84A6WE72LIVZMzgo/5Ay4b9GT6xdRW9fYEkm
         1Uq+eYkeHZdb6Q731hcSBNci2KD8mLbtdUBRD2qcT6roPZOo+2RpB1sLBjlrsegOqWE8
         W75ec3Rl9xcpLQdEHjQOXL8n5SRycJPL5znF8pdNug/nMnmiPx7qPOu1CNHy51dRkhjc
         q6FQIsCEUyBztDGiOZXyV50CccA5i+TPRk6SCNSK2mf53V0j9DFZQN+EkhMDL/H1JgHK
         p55g==
X-Gm-Message-State: APjAAAU+1cA/CH2IOrJZVava/CSwgQmyin5Y1JJpsYi0AlYhdsYlzGDV
        yWB6Ol6DAYj7BaBjw2L16kshX4njm99qqmwWYnM=
X-Google-Smtp-Source: APXvYqx/zTFaPfH9YteLnu1EegAq+Mr8e+ZMVdTnplK5tVIaEmn8DSRFW46uUDNs1gEkx9QMYUmrpUzKv4qefTtH9jQ=
X-Received: by 2002:a6b:b58b:: with SMTP id e133mr543469iof.86.1573934763525;
 Sat, 16 Nov 2019 12:06:03 -0800 (PST)
MIME-Version: 1.0
References: <cc03ba18-4949-9244-639c-94f461f03361@huawei.com>
In-Reply-To: <cc03ba18-4949-9244-639c-94f461f03361@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 16 Nov 2019 12:05:52 -0800
Message-ID: <CAA9_cmc7BuWkBHadHRAxfch43KWovb6rSr2AR9y3bVue0M9EhQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:17 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
>
> The commit 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel
> parameter cover all GPEs") says:
>   "Use a bitmap of size 0xFF instead of a u64 for the GPE mask so 256
>    GPEs can be masked"
>
> But the masking of GPE 0xFF it not supported and the check condition
> "gpe > ACPI_MASKABLE_GPE_MAX" is not valid because the type of gpe is
> u8.
>
> So modify the macro ACPI_MASKABLE_GPE_MAX to 0x100, and drop the "gpe >
> ACPI_MASKABLE_GPE_MAX" check. In addition, update the docs "Format" for
> acpi_mask_gpe parameter.
>
> Fixes: 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel parameter cover all GPEs")
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
> v1 -> v2:
>  - drop the "gpe > ACPI_MASKABLE_GPE_MAX" check
>  - update the docs "Format" from <int> to <byte> for acpi_mask_gpe parameter
>  - update the commit comment
>
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  drivers/acpi/sysfs.c                            | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Bisect flags commit eb09878e1301 "ACPI: sysfs: Change
ACPI_MASKABLE_GPE_MAX to 0x100" in -next as the reason for a boot
regression in my qemu-kvm test environment. It spews:

[    1.456728] ACPI: Masking GPE 0x0.
...
[  161.721420] ACPI: Masking GPE 0x0.

...and then hangs.

A straight revert gets the configuration back on its feet.

qemu-system-x86_64 --version
QEMU emulator version 4.0.50 (v4.0.0-928-g49c6c6ac0cd8)
