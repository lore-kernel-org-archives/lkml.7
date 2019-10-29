Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF95CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD922087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DO1hZp2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbfJ2TOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:14:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20103 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729263AbfJ2TOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572376471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxayejYSVXr47U447mSkKDwpy7jX9q8NIi6Fc4NbQBc=;
        b=DO1hZp2rjjvGs0jb/saN3Upvu+3I57KcitSChkmaHYFCzWvmrMpmhjglL/wfI7B2FF/bwh
        Q4ADd1EqsE0IKPHgmeZeqLippB+3uN9FjtnbxzKVKIyGhOHTIkEP8P17C2IyL+pycV2Csn
        HmYA+tCZgpoeOFwz+723SuMVnUzaipA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-hexKA29EONG8U60qkByC_Q-1; Tue, 29 Oct 2019 15:14:29 -0400
Received: by mail-lf1-f71.google.com with SMTP id o140so1990181lff.18
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 12:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwzekU6FTVb4WJ1KYylvE2Fm3CGIkd3DwRcFLlZGbuw=;
        b=BXGNJZhfM4WOIZZJ++SeR9hcEpXhNABTW3A4xqg5d1uCzBytjBHbeSLAdu3jTLHP6+
         CoK3E4LcHh2Ag711N+d1V7WTjXLdEbv7f90gAc6gtjqLrr/6Qqqh6FpcKKgRPd8LhaDU
         DgVnIaXRvTvUnPqM5SB8wBStmxUxU1HLc+1fCH8BAs7bPTBLKD+Va1XcFPHr8mPIOP30
         WHgT9gIgQWPccOXz3ZWiekzJPiBo/Ea2b/Bnq3ghhZ79Bc9y1lxq5ABR31hrD8MH+kD4
         m6ozw9PcU2OEDPwx1nMuy4jQnYSdJdbB3QF9m3ptq+xxKz30wAjIbGEltaHmU0AUHbBO
         mn4A==
X-Gm-Message-State: APjAAAW0l35Ar+CYOA9yrcyfB05vtOLd68ZBcwkc6P92Dxy84U+oVoCE
        HBu5Vu20zUGZ/PyVH+By/mmbxo6fFqWte5uYpMKkKpRtQna93itWEyTQFYr4SuYmKgT/ToxJBCy
        a0rADXNG7ImWDfSq6WnO9EBhtdkygzTdf0Rd/rbuO
X-Received: by 2002:a19:ac04:: with SMTP id g4mr3546581lfc.63.1572376467662;
        Tue, 29 Oct 2019 12:14:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyB0C3Ii5OEJM05OMOUAAZ49o0SiI0p8Oyn3T8k9fDZCZX9ZMdZD7rNOLGdjhWiT4TOIpbqxNY+7kioHW7fcD4=
X-Received: by 2002:a19:ac04:: with SMTP id g4mr3546566lfc.63.1572376467423;
 Tue, 29 Oct 2019 12:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191029173755.27149-1-ardb@kernel.org> <20191029173755.27149-4-ardb@kernel.org>
In-Reply-To: <20191029173755.27149-4-ardb@kernel.org>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Wed, 30 Oct 2019 00:44:14 +0530
Message-ID: <CACi5LpMAagnn_yEmqRBGfxJFZcAUzohU30NACeGvdXaHFZwAMA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] efi/random: treat EFI_RNG_PROTOCOL output as
 bootloader randomness
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-MC-Unique: hexKA29EONG8U60qkByC_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Oct 29, 2019 at 11:10 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> From: Dominik Brodowski <linux@dominikbrodowski.net>
>
> Commit 428826f5358c ("fdt: add support for rng-seed") introduced
> add_bootloader_randomness(), permitting randomness provided by the
> bootloader or firmware to be credited as entropy. However, the fact
> that the UEFI support code was already wired into the RNG subsystem
> via a call to add_device_randomness() was overlooked, and so it was
> not converted at the same time.
>
> Note that this UEFI (v2.4 or newer) feature is currently only
> implemented for EFI stub booting on ARM, and further note that
> CONFIG_RANDOM_TRUST_BOOTLOADER must be enabled, and this should be
> done only if there indeed is sufficient trust in the bootloader
> _and_ its source of randomness.
>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> [ardb: update commit log]
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Seems my Tested-by was dropped which I provide for the RFC version of
this patch.
See <https://www.mail-archive.com/linux-efi@vger.kernel.org/msg12281.html>
for details.

I can provide a similar Tested-by for this version as well.

Thanks,
Bhupesh


> ---
>  drivers/firmware/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 69f00f7453a3..e98bbf8e56d9 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -554,7 +554,7 @@ int __init efi_config_parse_tables(void *config_table=
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
> --
> 2.17.1
>

