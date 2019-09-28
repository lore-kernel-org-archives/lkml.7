Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF6DC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 17:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F3120863
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 17:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yb2XIR7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfI1RJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 13:09:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38224 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfI1RJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 13:09:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so3244129pfe.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oLQmc4hwUEu3xnoa2S+3QbtvjdTX2KY49B7iSjpzTkI=;
        b=Yb2XIR7QPiqiyJm4VTW8hALAotgdRj4BJqTml1CKd2Zk6IuFN17BriJ0LU6Ld4La6F
         Okb4c03BSvazvh4aGidRtX917DsAEMN385Fp3T5vfYp5ysDXAfnGiFESdQfACdfCGD4g
         dxPDOso9ewu6jnD3bfmeqpTENXEgy2yXg7fUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oLQmc4hwUEu3xnoa2S+3QbtvjdTX2KY49B7iSjpzTkI=;
        b=Dld4bp22B67EMuFYAnr14V+YxkmxlfNFtSBZ4nQnwNBbfPnVU19ZL134N6dttLGTk4
         kmTU/PXvuGqX7DzLDBgC6RgqM69BrLuma6OTf2tORF28gOrS49CiEhTdrrIJXtKFQHq6
         nCoIkJXF58n1sa0f70PIY7Pf62DUBkk3unDU6wASkmtLnFS79h3HJ2O3kHxUusKPkZNR
         pY73MmkOK3InqNiL9/mtRwmiO5QuRjtOQFUs7QizExxZWQCXmFT2WHslpvroVzfzPzij
         3NcdXORkVwKqVzs1D41YWPI6xgfc0LWEpQNuI9yfebekmL/y2U8AW2HRz5csq4BtwYcd
         Apzw==
X-Gm-Message-State: APjAAAX0N1ebGHYo19zE6VOe2EtngbE9adEkR6EnHVhXfEwkCgj1vZ4Z
        U7g2aNo0aoS1Rlmi2Tfai122WQ==
X-Google-Smtp-Source: APXvYqxmILc7bn3X3rTtw+wv+JImSmCUFpMzj93DGVdTwb6gUYftXOUfXgL42HGRRZA3nAHbD48l+w==
X-Received: by 2002:a63:5703:: with SMTP id l3mr16388923pgb.112.1569690571280;
        Sat, 28 Sep 2019 10:09:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7sm8442612pjv.0.2019.09.28.10.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 10:09:30 -0700 (PDT)
Date:   Sat, 28 Sep 2019 10:09:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     ard.biesheuvel@linaro.org, hsinyi@chromium.org,
        swboyd@chromium.org, robh@kernel.org, tytso@mit.edu,
        joeyli.kernel@gmail.com, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [RFC] random: UEFI RNG input is bootloader randomness
Message-ID: <201909281008.C2039DBDB3@keescook>
References: <20190928101428.GA222453@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190928101428.GA222453@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 12:14:28PM +0200, Dominik Brodowski wrote:
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

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> ---
> 
> Untested patch, as efi_random_get_seed() is only hooked up on ARM,
> and the firmware on my old x86 laptop only has UEFI v2.31 anyway.
> 
> Thanks,
> 	Dominik
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 8f1ab04f6743..db0bffce754e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -545,7 +545,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
>  					      sizeof(*seed) + size);
>  			if (seed != NULL) {
>  				pr_notice("seeding entropy pool\n");
> -				add_device_randomness(seed->bits, seed->size);
> +				add_bootloader_randomness(seed->bits, seed->size);
>  				early_memunmap(seed, sizeof(*seed) + size);
>  			} else {
>  				pr_err("Could not map UEFI random seed!\n");

-- 
Kees Cook
