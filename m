Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D08AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AC420883
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfDOI5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:57:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36002 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfDOI5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:57:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id l203so13118246oia.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 01:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=woh+rQbAg21s4xCzgE2PmJvwDo7fKL2KR6ssihi4zOM=;
        b=kZ4LCmhCglkLx++rTJCmu0ZgKLLfdwv0S8+TUMVXomRDqDV0B2asYPSi8QkwrQM9Zu
         7juYc6yzmqHimQ6Cf19BrpNbf6Fzc4YqFj2mSmw+BSzfn0JoRzjWgceKva55/Cg7xjUz
         Y+P0gL/WTrhcKHeyLP292MKz2x2Ri/taCWNFRKMRuT+njzvIFKo/Yel2cnkEkGU/fyU9
         1og1RBOeAO8+hWn8chCKjZeVbH666pzjManfDTH5emgjFgxEgVc1zxx1yaCXuMNWpE8R
         t5nVjIUnZcznMsENsEecOkOoj4Wwzf1FLgLaX5atjw7fM8b6lV2yJet4vQNgkfZyyo+U
         I7yw==
X-Gm-Message-State: APjAAAXngjhjzpEx71Oixv/DAPuBq1jdFavvUhAzrR+x8tqt+koDYLrR
        8gdwWwhDPoYo5eM2AKjp2D1f6iXZaPZPLFfI8KBY1A==
X-Google-Smtp-Source: APXvYqyMxR+1So+DRyC7IguvKW6X0OggVu5UxIQuxdzCXmHS5F+1Mw7CNSvuvxn10qPuwAltaf0h5gda6jL/2KmvpeY=
X-Received: by 2002:aca:5241:: with SMTP id g62mr18831726oib.103.1555318624085;
 Mon, 15 Apr 2019 01:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002bb2b105867bcd11@google.com> <20190414120338.edioq25dkafp2m7h@gondor.apana.org.au>
 <20190415063519.fs3li4h5i6yiycm6@gondor.apana.org.au>
In-Reply-To: <20190415063519.fs3li4h5i6yiycm6@gondor.apana.org.au>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 15 Apr 2019 10:56:53 +0200
Message-ID: <CAFqZXNsJPLYQ=OGEj+TrfLn7Odbs4LuYnjGFuV9+ZT8uF7U9kA@mail.gmail.com>
Subject: Re: [v2 PATCH] crypto: xts - Fix atomic sleep when walking skcipher
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     syzbot <syzbot+6f72c20560060c98b566@syzkaller.appspotmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 8:35 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> When we perform a walk in the completion function, we need to ensure
> that it is atomic.
>
> Reported-by: syzbot+6f72c20560060c98b566@syzkaller.appspotmail.com
> Fixes: 78105c7e769b ("crypto: xts - Drop use of auxiliary buffer")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

>
> diff --git a/crypto/xts.c b/crypto/xts.c
> index 847f54f76789..2f948328cabb 100644
> --- a/crypto/xts.c
> +++ b/crypto/xts.c
> @@ -137,8 +137,12 @@ static void crypt_done(struct crypto_async_request *areq, int err)
>  {
>         struct skcipher_request *req = areq->data;
>
> -       if (!err)
> +       if (!err) {
> +               struct rctx *rctx = skcipher_request_ctx(req);
> +
> +               rctx->subreq.base.flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
>                 err = xor_tweak_post(req);
> +       }
>
>         skcipher_request_complete(req, err);
>  }
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
