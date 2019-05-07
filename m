Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3826C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF93205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6C8aXML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfEGGoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:44:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42900 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfEGGoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:44:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so45006qtc.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B2vlr+gYhYqDxiVaHfPOm+vOknwn/W9NfcSHpPrwI/4=;
        b=R6C8aXMLZzS3ycRXNxfxFrhDOoJAIqBu0TvWNJQ1wBoSrw166mQyu9lIYcqRQmfCW0
         LPolVCy7d+3N1uCMKJJYXn72lmme6DH4Agg14lzx0ZoQ6AEs6tZCehOyVesTKimbxYu4
         CAkLEbO819X+IhJBGdrwbGVcCoPjAtvE9+FHBO+z0kWjyMnyvDjEpfDqqWHWfyEXvUit
         OYuPnFNBkQcu5PxlvGSrhWv566NzGNV5Lp6hqxV5A6cYI32bDavmwVRszP53QIUH5Tci
         1wDkFEiCez8sIslyOA+EStBikhSqKxghORLCl9GqpBjqgy2ybOPlgvAGpWpA6hc/5uT1
         HZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B2vlr+gYhYqDxiVaHfPOm+vOknwn/W9NfcSHpPrwI/4=;
        b=fJl2AX6u3Oz8/eM3a0SlKj4xA7Ac9A1p5Zl5xFKfnL6aNzYyR7oMy0qWae551srPNP
         n8c3KyiJ8FEETraReu5575M4kVe13FFwUc0aKg8wHzcTheu9jia9MTmvmAzVgsn5A4KH
         ygDlI2B4I9D5HXDcG3nA+2129vyk+pb05bbaDhvt7oJGkodN7zWlSRHTdiJD8NOFytg1
         gKph3/7ol95NNZFzucV3ytaMxit/R6LVia3lCSiAQKM8URRzRWLCY6YplbBPUyNfB/oF
         LjroC9BmN/JQi65VofEhcT+AU8E3BH2VFwbjsLQchp/rX30QX5UuB8jC9Q7ER8nS5TXB
         V94g==
X-Gm-Message-State: APjAAAWaoaYVKv4xjMr55tWjxl0yMRymcQkVT7EsO/4bBLFEUcHrgIo2
        mZAaUvmej9KQ3Aj1Ky7QXdJehR8OYU8Nc/2Ci2k=
X-Google-Smtp-Source: APXvYqxu9EBSkkSnjtFjgC0zN7zhiubCUbMmnfmn/eFUd0aob1+Dq3sgpYY4B0gK8nIwX4BUMsIrMKWkp4LNxza/IPg=
X-Received: by 2002:a0c:d449:: with SMTP id r9mr19597862qvh.223.1557211469314;
 Mon, 06 May 2019 23:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190429115143.12498-1-hch@lst.de>
In-Reply-To: <20190429115143.12498-1-hch@lst.de>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 7 May 2019 14:43:52 +0800
Message-ID: <CAEbi=3c6Y3k=Jg2V3YLyHFWByxFjJGjAn1jSLtKpPXHnUjr41g@mail.gmail.com>
Subject: Re: [PATCH] nds32: don't export low-level cache flushing routines
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Christoph Hellwig <hch@lst.de> =E6=96=BC 2019=E5=B9=B44=E6=9C=8829=E6=97=A5=
 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> None of these is used by modules.  Nor should they as we have better
> highlevel primitives.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/nds32/kernel/nds32_ksyms.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/nds32/kernel/nds32_ksyms.c b/arch/nds32/kernel/nds32_ks=
yms.c
> index 5ecebd0e60cb..20719e42ae36 100644
> --- a/arch/nds32/kernel/nds32_ksyms.c
> +++ b/arch/nds32/kernel/nds32_ksyms.c
> @@ -23,9 +23,3 @@ EXPORT_SYMBOL(memzero);
>  EXPORT_SYMBOL(__arch_copy_from_user);
>  EXPORT_SYMBOL(__arch_copy_to_user);
>  EXPORT_SYMBOL(__arch_clear_user);
> -
> -/* cache handling */
> -EXPORT_SYMBOL(cpu_icache_inval_all);
> -EXPORT_SYMBOL(cpu_dcache_wbinval_all);
> -EXPORT_SYMBOL(cpu_dma_inval_range);
> -EXPORT_SYMBOL(cpu_dma_wb_range);

Acked-by: Greentime Hu <greentime@andestech.com>
Thanks for your patch. I will put in my next tree.
