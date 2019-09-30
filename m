Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3E7C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F03216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URAqQQkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfI3LLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 07:11:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30391 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729415AbfI3LLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569841902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlumoVOzIdYLDp6+Vo+umOHfpwvjOI5RrcNU/6Q1HEU=;
        b=URAqQQkjrG6k1yOvrgGZVqBSaniMjwL1YQhG/TNGOawDGDJlShdcohD9gQ1MI9mz+RGRE4
        zdgvYPDlgVA08T+pWnN1pJB71VT6ygyR6c+5HMGW4abvyEZNObVNKrhNGDVIfJegtt2aPz
        37/dXPtl/HaQyQqlZAZ4gqTl1wEvaQ4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-WrammayiPzycFfABBriKEA-1; Mon, 30 Sep 2019 07:11:39 -0400
Received: by mail-lj1-f197.google.com with SMTP id y12so2929350ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 04:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJt8HAO0DFL0fynknBXiN2/8HO0H09tDjTGGULs1KX0=;
        b=Ehmu2+NV3F3jUBhwubExCnut+MjRihDPFtPn9Ggn0tNhXC8tXl08vfiWBhLxzFajBD
         kvW42BKLAsWhiqVJAJZitDt2tRuRtHiWhy4zaAxCQKAfNV1prt129/7ba46ANXkOTuOh
         gBVhOajEVAqNWywRmURnXQ8JsmEYHRYfAmN8/ouXwKXG5HngfS0iXcmOU3uUArGse5wN
         gE/vxBLbAcaH6RMDllDYPImj5yZ0RKNvoe30hO/qzctHaH5Wgt+7luUTNhwFQjSMSeb/
         x+/i0zFy0DG5src84SZCQeVuuzubXKXj1uwEo5fAl/XqzOsUQ2qwY3uZpCzdo+a5ysUU
         sKzg==
X-Gm-Message-State: APjAAAXIeXN2pedC9GKXXAhy2UG/VZ7eskifT0VHbzQEl0efNeYzojZX
        zg0eGr/OwWeqBtV3AUUWdKlOGD6lH/h65K3Y2+6gGpvA6sUdH6WDCng9rY/qTJTYBIOkC2jH9QJ
        T+XWlTPWYVWjO0R4IoIrDOFic8drZtr11wbHN2uTa
X-Received: by 2002:a19:428f:: with SMTP id p137mr11196439lfa.149.1569841897599;
        Mon, 30 Sep 2019 04:11:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz38ZJm+DSgCqke02/fY9q09FlSBMIV7g9ErLRRWK0GDo7iJQI5Kn+IQAtRkNWrytP/wPV4N1+puInI7pesTCQ=
X-Received: by 2002:a19:428f:: with SMTP id p137mr11196424lfa.149.1569841897386;
 Mon, 30 Sep 2019 04:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190928101428.GA222453@light.dominikbrodowski.net>
In-Reply-To: <20190928101428.GA222453@light.dominikbrodowski.net>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Mon, 30 Sep 2019 16:41:24 +0530
Message-ID: <CACi5LpMR4VLrg3SvbQ2_DJb9TgpurhGm5iQuKxQgWUwm4Z3Kjw@mail.gmail.com>
Subject: Re: [RFC] random: UEFI RNG input is bootloader randomness
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>, hsinyi@chromium.org,
        swboyd@chromium.org, robh@kernel.org, tytso@mit.edu,
        Kees Cook <keescook@chromium.org>, joeyli.kernel@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org
X-MC-Unique: WrammayiPzycFfABBriKEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 3:54 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Depending on RANDOM_TRUST_BOOTLOADER, bootloader-provided randomness
> is credited as entropy. As the UEFI seeding entropy pool is seeded by
> the UEFI firmware/bootloader, add its content as bootloader randomness.
>
> Note that this UEFI (v2.4 or newer) feature is currently only
> implemented for EFI stub booting on ARM, and further note that
> RANDOM_TRUST_BOOTLOADER must only be enabled if there indeed is
> sufficient trust in the bootloader _and_ its source of randomness.
>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Lee, Chun-Yi <joeyli.kernel@gmail.com>
>
> ---
>
> Untested patch, as efi_random_get_seed() is only hooked up on ARM,
> and the firmware on my old x86 laptop only has UEFI v2.31 anyway.
>
> Thanks,
>         Dominik
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 8f1ab04f6743..db0bffce754e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -545,7 +545,7 @@ int __init efi_config_parse_tables(void *config_table=
s, int count, int sz,
>                                               sizeof(*seed) + size);
>                         if (seed !=3D NULL) {
>                                 pr_notice("seeding entropy pool\n");
> -                               add_device_randomness(seed->bits, seed->s=
ize);
> +                               add_bootloader_randomness(seed->bits, see=
d->size);
>                                 early_memunmap(seed, sizeof(*seed) + size=
);
>                         } else {
>                                 pr_err("Could not map UEFI random seed!\n=
");

Tested the patch on my arm64 board which support EFI_RNG_PROTOCOL
(i.e. EFI firmware acts as the entropy source) and has
'CONFIG_RANDOM_TRUST_BOOTLOADER=3Dy', so:

Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks.

