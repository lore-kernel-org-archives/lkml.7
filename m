Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6652C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B727420851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="pKRcA/99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfFNIfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:35:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46476 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfFNIff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:35:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so1109605lfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pWi+5Am3aiah73yNoWhssqvYmNUO+DbKo0cUh/HhkqE=;
        b=pKRcA/99Kn1RlfqkHCYqITsKL7wcnLiDSjciQMsaMhyKPrztKtivTtE5j6rxb/p5mm
         m9XTZ4uAkazuHYYFeuR92f/e88xXmS32is65BsB2JBkW6wS0oiYDvfo+Y+c0cXfPJF/B
         r9FM/Df0Rb/33FclCysY54h+m5sSqYcwvaqnXP3YyIlemTEuVl+7OaUdilcQbnk6A4lR
         LU/f5FEfNUuL9DGNwp2Pg+v0B0BOXwVZpQ9RSJLtV4VVl5VMRs/3ApUkL6ieZSnrQ3Vv
         EABPOWr8yihT8hyr5T9ABQSv57oEbueA1tmjA49U0HVBi7OZAojYps6AEv+Nny2MR4oJ
         sJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pWi+5Am3aiah73yNoWhssqvYmNUO+DbKo0cUh/HhkqE=;
        b=R/dHKt3WbrwmV3fkC6X/tBh1NYrNjIgGJCyMtsiPoC1V7g+W2XEuIH3ikNjZlPHRLu
         KWmNeQlh6JgHATj6QgaOKbX7GRjuCOvZoQZaqjK/76UvI6BZaxa+o1J11tXyD8HI3oBn
         JlHI+NlNQiAycfiSqXce3g5VHXJWKaFIPnJKd7UaSP+LegWnRdz9oXe5b1ySI5TdA4DA
         S2Ztnj2shZ4NWQNe4eDFNmbbHYYh1NROJHeZsD+n2vDZafpA+A0IAkqIokvUTcAo4smw
         3tAEwMlK+eo/u45DIjYKIxRX1qrwtgEfKSzOkWnCMIQ80Dgg1nzlGzdmONkyk+vTme6O
         GkoQ==
X-Gm-Message-State: APjAAAVuOAgR+toU8UioMDjQ883MPjpEnWizz2jIp7WnJ13/GtyNIQbm
        7Lje0pLC0QKdjdaWPc8h+KquvyNZ5fM=
X-Google-Smtp-Source: APXvYqx2uAm03uGrknxT6QYWcLV22zpl1XfOYxHWcwU5kxumOqNqeSXIVWkf4PB3EpjuqDpve5pyOw==
X-Received: by 2002:a19:22d8:: with SMTP id i207mr44177294lfi.97.1560501333006;
        Fri, 14 Jun 2019 01:35:33 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.84.143])
        by smtp.gmail.com with ESMTPSA id 24sm504402ljs.63.2019.06.14.01.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 01:35:32 -0700 (PDT)
Subject: Re: [PATCH 15/17] binfmt_flat: move the MAX_SHARED_LIBS definition to
 binfmt_flat.c
To:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
References: <20190613070903.17214-1-hch@lst.de>
 <20190613070903.17214-16-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <e000b92e-a047-936e-c20a-9cc8b4f524bb@cogentembedded.com>
Date:   Fri, 14 Jun 2019 11:35:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613070903.17214-16-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 13.06.2019 10:09, Christoph Hellwig wrote:

> MAX_SHARED_LIBS is an implementation detail of the kernel loader,
> and should be kept away from the file format definition.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/binfmt_flat.c     | 6 ++++++
>   include/linux/flat.h | 6 ------
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index 0ca65d51bb01..ccd9843e979e 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -68,6 +68,12 @@
>   #define RELOC_FAILED 0xff00ff01		/* Relocation incorrect somewhere */
>   #define UNLOADED_LIB 0x7ff000ff		/* Placeholder for unused library */
>   
> +#ifdef CONFIG_BINFMT_SHARED_FLAT
> +#define	MAX_SHARED_LIBS			(4)
> +#else
> +#define	MAX_SHARED_LIBS			(1)
> +#endif

    Perhaps the time to remove ()?

[...]

MBR, Sergei
