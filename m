Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61639CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3265221783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnADVe92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbfJVHnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 03:43:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54745 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbfJVHnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 03:43:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so15976558wmp.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nh2LJWcAA6+F58FkBmsDYADEarvpFUTo1V/7oVQrNLc=;
        b=dnADVe925smBvR+rSpyj4PtIlJk5/q3GB4C2JSunmryH/ihy/PAiXj+FVebkWFYq7h
         Vhy49WWqi7OJpoWSOJ9a/i3mE2seYWQfEvw/wTU/QS7L/aD4oysMQQ3jgn7MhGSO2G2R
         qv88wCmhp/vLRFQnQUR9IL1SUsC2x33PjpeCdt2aVQelQWXkF6ZxD5VpPOMVgJ0KRrub
         rfLOd9AJiPeOyFEKQT+skRwT7ZYS4zmIsbUxzvYwJRaypgVAMGDfjmP/91MRWtuHkCb5
         W+iZfnoUhIBqsXz47EwLknza6gSLZUpCm/lXGzfu0LlKxgP2yGGFY1VNnaHnSNo1WBFE
         fOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nh2LJWcAA6+F58FkBmsDYADEarvpFUTo1V/7oVQrNLc=;
        b=q0fjDDnLknFtz/mBX6aia0y354GH9AZrBa9o+iIsxvIRO66QE2DbJDzITyjDtuaYMH
         7yuNmmqKvN6E6Twdea5Ks5Mz4Al/lD/9Cvxi7jipXlzKaPcUOhnFxnrQBtzZ2CqyC24N
         2mjS5NxjmOEamkaZkWEfJL3m9oa4p/vq4JM0ryt6fns4FTTXiErlI3O2YyCYt48YfgtR
         C1qmcRfju4Zh8/e2xXor31yUlCMr8FLg1FMYB+ZU+wTEMqxF3DL/W3KEPTlYX5lhhbBx
         PHB1y1uzLrQMw9Rl5UTgb26JbCAXNHk4mcprBvQa5VXorIoM+aPoe2RZ9EPpSJcMNMrT
         KuSA==
X-Gm-Message-State: APjAAAVoPf5v2snAt5101cY/HUaV652fYlh9ML1AV2Mmb5pWnOoIOr5E
        lhW5q1rX4Z2Esr/fVneYT5HzO++Jc2JhZ914UuQbrw==
X-Google-Smtp-Source: APXvYqzja7xl0D4V5WYVo1mTlFrVTbTKv6QHAypbeOH/fy5ot9cR72w/UPWY151nEVaz/vrxF6wPxmJhMQmVAt9CRLA=
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr1719270wml.10.1571730185195;
 Tue, 22 Oct 2019 00:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <0812dca3-8447-be46-b84c-e89f25176cbf@huawei.com>
In-Reply-To: <0812dca3-8447-be46-b84c-e89f25176cbf@huawei.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 22 Oct 2019 09:43:00 +0200
Message-ID: <CAKv+Gu_+ab6KuvFdp+=F4M4JYm+eO7tN0ea=1ePrwEdG9tLNmQ@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: arm64/aes-neonbs - add return value of
 skcipher_walk_done() in __xts_crypt()
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hushiyuan@huawei.com, linfeilong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 at 09:28, Yunfeng Ye <yeyunfeng@huawei.com> wrote:
>
> A warning is found by the static code analysis tool:
>   "Identical condition 'err', second condition is always false"
>
> Fix this by adding return value of skcipher_walk_done().
>
> Fixes: 67cfa5d3b721 ("crypto: arm64/aes-neonbs - implement ciphertext stealing for XTS")
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
> v1 -> v2:
>  - update the subject and comment
>  - add return value of skcipher_walk_done()
>
>  arch/arm64/crypto/aes-neonbs-glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/crypto/aes-neonbs-glue.c b/arch/arm64/crypto/aes-neonbs-glue.c
> index ea873b8904c4..e3e27349a9fe 100644
> --- a/arch/arm64/crypto/aes-neonbs-glue.c
> +++ b/arch/arm64/crypto/aes-neonbs-glue.c
> @@ -384,7 +384,7 @@ static int __xts_crypt(struct skcipher_request *req, bool encrypt,
>                         goto xts_tail;
>
>                 kernel_neon_end();
> -               skcipher_walk_done(&walk, nbytes);
> +               err = skcipher_walk_done(&walk, nbytes);
>         }
>
>         if (err || likely(!tail))
> --
> 2.7.4.3
>
