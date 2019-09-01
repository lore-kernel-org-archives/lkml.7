Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0153BC3A5A8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 18:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8D622CF7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 18:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="eq6vzzUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfIASX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 14:23:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32995 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbfIASX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 14:23:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id z17so10885956ljz.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRqNO50sqHwmWj5P/z58Oe0GaZOHE7FRmJRU0BNdRwA=;
        b=eq6vzzUPapsds+MIIuvqwfoZXAY0z41n2/7fdowjYx2O5oU38D0z/W/9glcxHRQa2e
         WYf410OXkTry4hw084nNU6/X7cFg1locgtY1vqUfOpwr826VafO+TCzi/6t+ttlshkC+
         Sijt9vi6vCi5dE6sI0/8gicWxGp5RchwTfcn7sp2LKVu62LRHYFb14OqYn/1pJpGmPef
         Aj7b+7Bjar191/oCxIVpcgP7PF40d+4DN5npPXMykV6beMkf4rgkProguELGZMDzpeLM
         PrbjKM3rbaqyDlThN1cmN4fO3M5I2yb3ZTA5WYMWuKdsF5nZiMa/eBim7YPJaP48caWx
         hkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRqNO50sqHwmWj5P/z58Oe0GaZOHE7FRmJRU0BNdRwA=;
        b=qly6EPzWAc78iKi/30Km/J/Z+hzEbypv1l+kYtkieUec/ffA0Assd0fODlVz0HADDI
         z2ymSq/otDQ5Y3uGCQb5657tZVUu3P2bvKvKI+V03dTNMhRB5GjeUdprl2ZaEMJYk1ma
         4yr3rRXMd7HhYgp0ckKX+4bRsHgyS06PxFDd4kdv+ij99w0pnU/aOenOojFOadntphWD
         ujPx8YiVR15HxGqM6GAz/em3AhLsDGCffw+NuVfziTjSjA1g+63gpHTFtfGMmthLEQFZ
         yznRvj7akA4LHNDjr1YLpx4EHASzKrD7N+uMgcfKOgxXW0vocga7kPFkSAm85ESV8cW4
         cXQw==
X-Gm-Message-State: APjAAAUv7Os0mVRDL3/rU+hBtIeJy0HKW5seF3CI+HbCgFff2yOgUjs5
        RzOI6D0AgpKtymxtm/cWmTWmeMYbLT6IrR16FFWD
X-Google-Smtp-Source: APXvYqxR838XZ/vlMKbRK5g41cM9jK0LAXal1wmVLKOlFPo3+6Zm04hAQdB16tAZbBIQ1PFDnVj27P0uotkvqRNwnFI=
X-Received: by 2002:a05:651c:93:: with SMTP id 19mr14338697ljq.0.1567362204210;
 Sun, 01 Sep 2019 11:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190901155205.16877-1-colin.king@canonical.com>
In-Reply-To: <20190901155205.16877-1-colin.king@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 1 Sep 2019 14:23:12 -0400
Message-ID: <CAHC9VhR-dBHz_8=OH-8YbidMOO_ecqjioorUTr1GFDV1tTqCJw@mail.gmail.com>
Subject: Re: [PATCH] netlabel: remove redundant assignment to pointer iter
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 1, 2019 at 11:52 AM Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer iter is being initialized with a value that is never read and
> is being re-assigned a little later on. The assignment is redundant
> and hence can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/netlabel/netlabel_kapi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 2b0ef55cf89e..409a3ae47ce2 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -607,7 +607,7 @@ static struct netlbl_lsm_catmap *_netlbl_catmap_getnode(
>   */
>  int netlbl_catmap_walk(struct netlbl_lsm_catmap *catmap, u32 offset)
>  {
> -       struct netlbl_lsm_catmap *iter = catmap;
> +       struct netlbl_lsm_catmap *iter;
>         u32 idx;
>         u32 bit;
>         NETLBL_CATMAP_MAPTYPE bitmap;
> --
> 2.20.1

-- 
paul moore
www.paul-moore.com
