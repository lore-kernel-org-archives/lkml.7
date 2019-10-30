Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E39CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5E52054F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loU8peBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfJ3QR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:17:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36500 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfJ3QR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:17:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id c7so2638214otm.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Cj2/HXDLn8aS6ESVlsFGccn1N9mdAGQmhGwS0g3eOU=;
        b=loU8peBfVBq5shNbsqNfvsPiuBIenx6sek1Jikn6Qw5VElJ/47se4ZkXOea0N6HeSa
         9zAyMBnaKpBimNv0jGpE0U91oZAwjjqEThIvGbvEh/b0QLikNWo8VGlAmT/bTAHOUWmU
         3hFjaeUV34lRbrVScSy2IsEY9nR+gpOfVN8SVAGT1gKm0KFAyNXy2TPGmcXzK4srOTZr
         mo1wxLIuM5CHZriAkh9FZKoq3uS6L1IPsJ3HfPK0UYIMrImPc5E73qHHO11WtnN7oMrS
         HEEsXqengkEwOOwf6HOWS0EHde8/2ZyMabv0NgJ1o0X4IcmnChdnnEdjH8uqhxt4oHel
         4NHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Cj2/HXDLn8aS6ESVlsFGccn1N9mdAGQmhGwS0g3eOU=;
        b=F9weykgw9jRS0wNBdIo9Ow3q0Q77pXFVcYVFhrF/lX4S9xYEq7aN2lGv6dR7ccFagM
         MjV1aF370wCxzK7Dyf3axt3Kx5qcrHM+YvHLk3zj45nQIDi6ji5/d1xsptR0S4VxNksS
         4wwTkUW9SrYpIkhGJYDbj3p+Q/kBcSCS16okZ6TH8s/GrOIk+aaP4wwimUxQHCzm1vDp
         doFytyrbuP/wbBVYdwwmcU61vEULZ8Qxu0w0maJpWwYmVL+PACbzu3VjQeGKY1nYueK3
         RfO9gszaj/JHWsgrnEvpBUwby3PZE7JL4gsIAnQJYx7f4hntKbkkecfo31OsYmQ1ObhU
         orfw==
X-Gm-Message-State: APjAAAX+vQuQQ5oHRt7RrMyK9vfWpUlf0Lzy5svHAF3XItIz2nnILjYG
        kpDZRkzjSD9pnCu2ACij9Z5936lmRQrOtoxoqIJ/tA==
X-Google-Smtp-Source: APXvYqyGIZXSa+DtUjwBGchbvDWoC92JPTPDAXB5UsVtXZB+/gNvTOEkAQTyhFxO7Jk/E+0BUW/SIrYMDoyFssBoOgQ=
X-Received: by 2002:a9d:630c:: with SMTP id q12mr590885otk.332.1572452245946;
 Wed, 30 Oct 2019 09:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191029182943.GD17569@mwanda>
In-Reply-To: <20191029182943.GD17569@mwanda>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 30 Oct 2019 09:17:14 -0700
Message-ID: <CALAqxLU7k-z6JXbEFpK0D_7+jZz_Jdk7HxaSWm_rkBFEpQRQtg@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Fix a warning message in dma_heap_buffer_destroy()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        linux-media@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:31 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The first argument of WARN() is a condition so this will just print the
> function name instead of the whole warning message.
>
> Fixes: 7b87ea704fd9 ("dma-buf: heaps: Add heap helpers")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/dma-buf/heaps/heap-helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
> index 750bef4e902d..a31684c0d5b2 100644
> --- a/drivers/dma-buf/heaps/heap-helpers.c
> +++ b/drivers/dma-buf/heaps/heap-helpers.c
> @@ -52,7 +52,7 @@ static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
>  static void dma_heap_buffer_destroy(struct heap_helper_buffer *buffer)
>  {
>         if (buffer->vmap_cnt > 0) {
> -               WARN("%s: buffer still mapped in the kernel\n", __func__);
> +               WARN(1, "%s: buffer still mapped in the kernel\n", __func__);
>                 vunmap(buffer->vaddr);
>         }

Thanks for catching and reporting this!

Acked-by: John Stultz <john.stultz@linaro.org>

Sumit, do you mind picking this up for drm-misc-next?

thanks
-john
