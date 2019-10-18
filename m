Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998D6CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4DC222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="cm6uu8Lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407569AbfJRFUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:20:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36992 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfJRFUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:20:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id p14so4737600wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4IN8nkOuZaw4qMQqgoM+lr6oMWm+8vooDBY/2Fj6u8A=;
        b=cm6uu8LpVpbMuL7DTMw6/Q94OH+JJ/d/EbywAS5toHgB/ZqGU2lf3f/Y7MvvSD8lq0
         zNa9dTRgHlPFKlPi86zmTIIkzEww9tHfPahEgiexjHmiad5TCjHzyaOZqtatTvUT+Hpd
         3gK91DBP38CMpuk5/U6gqYK7VIe9sq2MO2Iu5sNIR1MhEQOVzhbghc+gB1RZPw8AFrqx
         imhGyqmHueePDv38KOcLpANTNfPnCBMsQY3LwE8BQktBZ9vBz/ffbZuew4YQAZ5/+IG3
         trx2cV7+nnnj9WZC90wmQxPUY+Xz3PEerkymbiEcJxxiop6/tPvpOhwfFgKfL54zUZzk
         ig2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IN8nkOuZaw4qMQqgoM+lr6oMWm+8vooDBY/2Fj6u8A=;
        b=ubJClb8NuJHd5C7r0kVLBuN4HwmTqYBecSsCOve8Fd0oiT74A6ovwJKpoAvmi5/nqv
         kMtKowlLN2aWlOdgbpdYwEvhiJGrSHHXmUCRDFi/1RJjjTLnW9SBnA3A+IW4H1vCZ+Le
         5RJp0h4kDFd2yHReAlp8gxUO0jhz8In5qsT0ybzRahg6qR3bfOBZ0O08iuoXekJjNQRe
         shvWtMlxkCJhEimWNAZInfVfQ3nvxvzAT81cx575UrPBHbWj7kpF6jdwjqPmjwQuJdP4
         NCR2O3VKJqxrTjkJzSDo93Mx5dJOJjHxFyQPepQLJwqe2cxuDOl23S6lb20YIF/Ter9a
         SQnQ==
X-Gm-Message-State: APjAAAUCaInQfdRKYMU+N1xvkG2Q4jMrdjyQR69NMCi1r4nE2c1ju2Nq
        HyXz6bH9p+fx8/u1P6o+1ZhjMEf0WNcABc0cUQdjUxvSTUg=
X-Google-Smtp-Source: APXvYqxZtU4Zdishzaj1EdrbSwuCs4hJmh3Nm9boGXA21TSzBjIiq3CCeMGIKdggwniwp7AwhXHQUGRPWxdMMSIGcIQ=
X-Received: by 2002:adf:f145:: with SMTP id y5mr5400621wro.330.1571367191529;
 Thu, 17 Oct 2019 19:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-6-hch@lst.de>
In-Reply-To: <20191017173743.5430-6-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:23:00 +0530
Message-ID: <CAAhSdy3MjGvPuAtsfdtbxe9N8LG3FYjQh=6rLpUqx7r73nNiWw@mail.gmail.com>
Subject: Re: [PATCH 05/15] riscv: poison SBI calls for M-mode
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no SBI when we run in M-mode, so fail the compile for any code
> trying to use SBI calls.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/sbi.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 21134b3ef404..b167af3e7470 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -8,6 +8,7 @@
>
>  #include <linux/types.h>
>
> +#ifdef CONFIG_RISCV_SBI
>  #define SBI_SET_TIMER 0
>  #define SBI_CONSOLE_PUTCHAR 1
>  #define SBI_CONSOLE_GETCHAR 2
> @@ -93,5 +94,5 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>  {
>         SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
>  }
> -
> -#endif
> +#endif /* CONFIG_RISCV_SBI */
> +#endif /* _ASM_RISCV_SBI_H */
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
