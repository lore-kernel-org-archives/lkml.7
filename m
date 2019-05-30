Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D164FC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B4F25115
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfE3EJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:09:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42476 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfE3EJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:09:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id r22so3047870pfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 21:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=RgBvtow3SG/L3onZEkvF3GT1l11iLnZpHBpHe6+yVVA=;
        b=SigOXi6vok01p/DElvycZ2DP261VnH9DpaGGk5REMSbPepOBj/LeSAdm9gG4pxFx9V
         jC1u4EERcEcCnkpuvcglK9mFxhW6N0rJBt35bk+IBoMxBOF6GKLVdveevIupSnPDiu+I
         m8rphBeXiDsi9Cy5ZwyzT0Tr3XyS5Zl+7N2xolgvLEQvNFpT3mY0wvVt1eGJjZkXcAq+
         mZT/hCC/DsBWWOxUqEEL5bWmhDgtqabJ1opGzpnVaiOJXcRLyBr2Juo/2xnj6oIKg00b
         E4icAxQrF/eKxBMmU2TjJhcWCslBqk/eLNqc1444ZkEFgxB6zlNEkPtYGPpBdy+F/5VD
         Gnkg==
X-Gm-Message-State: APjAAAXLnYzE9bUdjLVYFrUX16m+UV4bJ15McXmj2VjpBMSuc83F1Oag
        qyjxtqV7x0wpt2ch9vQLdIqHLA==
X-Google-Smtp-Source: APXvYqxL7nHH1tWDIGiRjh1quoIV4ZyKReZOGaf2heGTQIPnVWf6k8qKr5CbyLKzE+36RS6bp4/Rng==
X-Received: by 2002:aa7:8e46:: with SMTP id d6mr1664198pfr.91.1559189358490;
        Wed, 29 May 2019 21:09:18 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id v93sm1035350pjb.6.2019.05.29.21.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 21:09:17 -0700 (PDT)
Date:   Wed, 29 May 2019 21:09:17 -0700 (PDT)
X-Google-Original-Date: Wed, 29 May 2019 20:42:12 PDT (-0700)
Subject:     Re: [PATCH] riscv: Fix udelay in RV32.
In-Reply-To: <381ee6950c84b868ca6a3c676eb981a1980889a3.1559035050.git.nickhu@andestech.com>
CC:     greentime@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, nickhu@andestech.com,
        green.hu@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     nickhu@andestech.com
Message-ID: <mhng-681a0d18-f477-4e76-ae16-b64fe7265ec4@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 02:26:49 PDT (-0700), nickhu@andestech.com wrote:
> In RV32, udelay would delay the wrong cycle.
> When it shifts right "UDELAY_SHITFT" bits, it
> either delays 0 cycle or 1 cycle. It only works
> correctly in RV64. Because the 'ucycles' always
> needs to be 64 bits variable.
>
> Signed-off-by: Nick Hu <nickhu@andestech.com>
> ---
>  arch/riscv/lib/delay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/lib/delay.c b/arch/riscv/lib/delay.c
> index dce8ae24c6d3..da847f49fb74 100644
> --- a/arch/riscv/lib/delay.c
> +++ b/arch/riscv/lib/delay.c
> @@ -88,7 +88,7 @@ EXPORT_SYMBOL(__delay);
>
>  void udelay(unsigned long usecs)
>  {
> -	unsigned long ucycles = usecs * lpj_fine * UDELAY_MULT;
> +	unsigned long long ucycles = (unsigned long long)usecs * lpj_fine * UDELAY_MULT;
>
>  	if (unlikely(usecs > MAX_UDELAY_US)) {
>  		__delay((u64)usecs * riscv_timebase / 1000000ULL);

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
