Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4668C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 05:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD6020692
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 05:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="jLkzEE1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfLHF1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 00:27:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34723 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfLHF1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 00:27:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so12333540wrr.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 21:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9pquV3bCMWDZGt16luo26JnnZC+AO01g0+9zHilts8=;
        b=jLkzEE1Emr1PE83CAnq1AgI/inVp1i1XP/A3KxFtGeJPzlHjql/AW7qbDdoJ6RkwP/
         M/blOWuFrHwTqVu0HD7XU6oBygARII63Io7FMuwFIxSBZNWXQE31nohsv70D5gUG4c0i
         lNvmgd8v9iiNwDU13GC2k+iVIOlGqM5ZLBBwFS0BOKt6JCa7on8rMz9kSlcs7esYIHgo
         fvsHYFEuxDFHfp+pl5oEMOHRNsbovOC8155cnN2xpFkU2AfJHF/8Ko8IyKuo7p2XDSiq
         71OYrCMOENeHGiW1mvRDeWIrxseD+Z++mGviUs4LIgYBh6i6l3P4WQsYall4BQaOHbjs
         zn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9pquV3bCMWDZGt16luo26JnnZC+AO01g0+9zHilts8=;
        b=acEQjW6HI7SHZX5nHrVrHKGjFsb0bF5gQC8bm/qYyGGFRbv5yduc1QKuSriPb+Sc0i
         w3EqawFrHYIYd4PPpVq+LWNYI7e+uMKyC6vJR1dQN1J7zdMttzYY2bv99jzmOE0mdy13
         PvsXEhyCevaIEC0K5uk2ANsghpenqLhfyM5r7ifTXWC7CZ3EJ8PtSrr4vn9FfTjUO7HT
         T63pLIC4xS0tm2n0E40GeKhOx8ku+eqGuqZMssnfbIuCkLK+uPdKvvdrOcecHDQvtp1f
         7K5WRiZRcKYizpcjcaIDVhgusJKwr9hhxngT1LFWgKaVrQzO4pYCrZ7ENJaCC/eqo9x5
         sezQ==
X-Gm-Message-State: APjAAAU9b7G6Ut1CD25uzUEAMtcB2Fcoq/kathZMgdcw+8jIRAE2/obt
        epEHkHX1XP0ZZKFHQruhiRXr8ou2CVdGcpCE4Ju8xw==
X-Google-Smtp-Source: APXvYqw49COcOiWILG4CPx3KrlSGO4gmMkeSr4gqepLQqQqL+tWII/HFy4Sqica4vGqIHrcRGxBt0cpTksMJcfg5rEs=
X-Received: by 2002:adf:d850:: with SMTP id k16mr22791152wrl.96.1575782858366;
 Sat, 07 Dec 2019 21:27:38 -0800 (PST)
MIME-Version: 1.0
References: <20191207212916.130825-1-olof@lixom.net>
In-Reply-To: <20191207212916.130825-1-olof@lixom.net>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 8 Dec 2019 10:57:27 +0530
Message-ID: <CAAhSdy0ERFToCEPtpaV9WX=RTyVD_=2GKutE7=cLnYtY-dU-OA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix build dependency for loader
To:     Olof Johansson <olof@lixom.net>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 8, 2019 at 2:59 AM Olof Johansson <olof@lixom.net> wrote:
>
> The Makefile addition for the flat image loader missed an obj prefix.
>
> For most parallel builds this worked out fine, but with -j1 the dependency
> wasn't fulfilled and thus fails:
>
> arch/riscv/boot/loader.S: Assembler messages:
> arch/riscv/boot/loader.S:7: Error: file not found: arch/riscv/boot/Image
>
> Fixes: 405fe7aa0dba ("riscv: provide a flat image loader")
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Olof Johansson <olof@lixom.net>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/boot/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> index a474f98ce4fae..36db8145f9f46 100644
> --- a/arch/riscv/boot/Makefile
> +++ b/arch/riscv/boot/Makefile
> @@ -24,7 +24,7 @@ $(obj)/Image: vmlinux FORCE
>  $(obj)/Image.gz: $(obj)/Image FORCE
>         $(call if_changed,gzip)
>
> -loader.o: $(src)/loader.S $(obj)/Image
> +$(obj)/loader.o: $(src)/loader.S $(obj)/Image
>
>  $(obj)/loader: $(obj)/loader.o $(obj)/Image $(obj)/loader.lds FORCE
>         $(Q)$(LD) -T $(obj)/loader.lds -o $@ $(obj)/loader.o
> --
> 2.11.0
>
