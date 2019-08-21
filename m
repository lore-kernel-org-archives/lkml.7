Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608F7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A5C22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nmacleod-com.20150623.gappssmtp.com header.i=@nmacleod-com.20150623.gappssmtp.com header.b="GfievykS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfHUTqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:46:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43888 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbfHUTqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:46:32 -0400
Received: by mail-io1-f66.google.com with SMTP id 18so7006281ioe.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nmacleod-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IrhyO1xAriI0x3SJAPuRls7zHHEanwvviwP/gURxosE=;
        b=GfievykSxX+taJCq1ixH6D5IHrMNPeTe/QbjmzP7QeVJIH9gbDkspPIUiYXaLDSXuQ
         D9Kw6/wSIaF991TN63nLsO1t3QOgCAKx4NXqsIg86EFphb//xiOleNSubdDU4GAMhmyF
         b2LyCQATPIc0ixkEiFX7vyOGNhLyOExGYtO6v7/xegsISI8+FcQNJy0ikef45qa6thda
         nXzCqa56JDBqawJx0eQJItSV39MDW+eCYp8XCsq8IQq5lXFzHab6Gh5UFWWIhGWiLJFW
         7Cxklx2mDhT1qLB+yzrfF69DVW9QZSDIFtRaVUeM7QIOe7CAHif+58LdXjUwruhbD6ma
         WE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IrhyO1xAriI0x3SJAPuRls7zHHEanwvviwP/gURxosE=;
        b=SMDn8HCTPY7w7GWHaQg9OEBLH8DSuPNsPRudXeX1WUZ5+L+CY6atRHEWAzMHmd6Sdv
         Z73N3nbRAl+KWcn6MdP5UWcvolr188Zj/PIps15DDqIq1Jz0v7Bp6M+bak2wxrHUi+v6
         kneI8dzaewrj0ffunOr3AFsltUlxWyKMBRso22+FVB8mSZGd8JGflR3fUQUiLcPVKHdT
         6xC4WwUeX37yrBDBSApBFrP7p/SwMYz0/wiXpzMc7IT7HN+2HJAxI0rxlnfTgJ5wRvkV
         9fPKKA+bCBq221IpRNiA3/XVjZJhE6zuZkzmmeO0PN3fUP0zdNFhStvTQanjpKYZ7uBd
         RmEg==
X-Gm-Message-State: APjAAAWlkT1EjgEVgIGvwdTfCsXISa21EKZT756lg8rejPlWBn4R9woO
        2MW4VGBYGBFSZduydLsHA497zXBpAHPK/1Lu1HnzJg==
X-Google-Smtp-Source: APXvYqzkEGCbF52whPiC7JcrVWKDsn/1hFSQDxZirY2/IOn/+SfmgCqpDkQzuI7oaqgfNNMAlwa32d1DuAlHQjw27QE=
X-Received: by 2002:a5d:8908:: with SMTP id b8mr17412303ion.237.1566416791134;
 Wed, 21 Aug 2019 12:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAFbqK8=RUaCnk_WkioodkdwLsDina=yW+eLvzckSbVx_3Py_-A@mail.gmail.com>
 <20190821192513.20126-1-jhubbard@nvidia.com>
In-Reply-To: <20190821192513.20126-1-jhubbard@nvidia.com>
From:   Neil MacLeod <neil@nmacleod.com>
Date:   Wed, 21 Aug 2019 20:46:12 +0100
Message-ID: <CAFbqK8=BodLiMr4pdHjdqsZtk8iHUC_9oyRRALJt0xLz4y_4sQ@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Fix boot failure regression
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        gregkh@linuxfoundation.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm 5.3-rc5 is booting again from internal M2 drive on
Skylake i5 NUC with this commit - many thanks!

Regards
Neil

On Wed, 21 Aug 2019 at 20:25, John Hubbard <jhubbard@nvidia.com> wrote:
>
> commit a90118c445cc ("x86/boot: Save fields explicitly, zero out
> everything else") had two errors:
>
>     * It preserved boot_params.acpi_rsdp_addr, and
>     * It failed to preserve boot_params.hdr
>
> Therefore, zero out acpi_rsdp_addr, and preserve hdr.
>
> Fixes: a90118c445cc ("x86/boot: Save fields explicitly, zero out everything else")
> Reported-by: Neil MacLeod <neil@nmacleod.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  arch/x86/include/asm/bootparam_utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
> index f5e90a849bca..9e5f3c722c33 100644
> --- a/arch/x86/include/asm/bootparam_utils.h
> +++ b/arch/x86/include/asm/bootparam_utils.h
> @@ -59,7 +59,6 @@ static void sanitize_boot_params(struct boot_params *boot_params)
>                         BOOT_PARAM_PRESERVE(apm_bios_info),
>                         BOOT_PARAM_PRESERVE(tboot_addr),
>                         BOOT_PARAM_PRESERVE(ist_info),
> -                       BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
>                         BOOT_PARAM_PRESERVE(hd0_info),
>                         BOOT_PARAM_PRESERVE(hd1_info),
>                         BOOT_PARAM_PRESERVE(sys_desc_table),
> @@ -71,6 +70,7 @@ static void sanitize_boot_params(struct boot_params *boot_params)
>                         BOOT_PARAM_PRESERVE(eddbuf_entries),
>                         BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
>                         BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
> +                       BOOT_PARAM_PRESERVE(hdr),
>                         BOOT_PARAM_PRESERVE(e820_table),
>                         BOOT_PARAM_PRESERVE(eddbuf),
>                 };
> --
> 2.22.1
>
