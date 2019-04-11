Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57233C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212CF2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VVGyhNv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDKUct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:32:49 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44124 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfDKUcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:32:48 -0400
Received: by mail-vs1-f65.google.com with SMTP id j184so4264903vsd.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9ffPpZWZSFDmzqrYJMKaghLmxEb8zkLpb7Gwn9WbSQ=;
        b=VVGyhNv9UWJe+P4Vs1rphtpfW9mk7prj5YNPHiZvXGxx5PehFCsl/5HRpis6fQ3ad7
         wBH/H6QveUhnARroIKDQPnwoI4PHL4gI508PXcMUxZmzJW7SBAe3JRP3RNosAiA94TOf
         nO7RC7PJeGT8GKT0dn4jH1uXwysyOiO+nFvB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9ffPpZWZSFDmzqrYJMKaghLmxEb8zkLpb7Gwn9WbSQ=;
        b=ug7xzq0YCtRLDczN7S7w814Z8GDyDM6OR7ZM0+difaTQ8rbr9a6HpQ6B//5Qe79lsq
         nPHATaO0elINiIdNwN1E0gh2QIQH4IJkueOS5l0gyWBgN/Fk9vHYsHpye547StnNPpyb
         Q426iy/6ZBlBt3pk2co1SO9qRBPa9A7lvT8/qQTVGbgvgPWPuEJGs/vD5KZVqFY+hkzy
         hDZivEtlQGuOWAwbW/pEnLl0YIBtUa+4IvMBwRqlzau7X1FEqEVezRWcJReZWNtvG2Mh
         6Xqq8T9BEtOxxmDHY5k21ybJk0sRg9swxO4rknKy+qUYNyAdaIjF5pQvenoa7Iv/AlKB
         9dDg==
X-Gm-Message-State: APjAAAWVos09/WOcKqMXemJZmV7tI00GUvDvjV/p9zW+CcbgDtOGBn3x
        Q/RS7RJpoE0xNpv/XKi/ZcyCfM0+z/I=
X-Google-Smtp-Source: APXvYqxihaBi9pOn4esxVS/PJz/ZCWj4NLaY8QgUSYBFc4eBSTbMfouxO8N/g+BvibNS2EElDPq/xA==
X-Received: by 2002:a67:f693:: with SMTP id n19mr29062127vso.89.1555014766158;
        Thu, 11 Apr 2019 13:32:46 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id w79sm13482566vkw.51.2019.04.11.13.32.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:32:45 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id l17so2502822uar.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 13:32:44 -0700 (PDT)
X-Received: by 2002:ab0:60cd:: with SMTP id g13mr27523621uam.85.1555014764346;
 Thu, 11 Apr 2019 13:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190411192607.GD225654@gmail.com> <20190411192827.72551-1-ebiggers@kernel.org>
In-Reply-To: <20190411192827.72551-1-ebiggers@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Apr 2019 13:32:32 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ8k7fP5Vb=ygmQ0B45GfrK2PeaV04bPWmcZ6Vb+swgyA@mail.gmail.com>
Message-ID: <CAGXu5jJ8k7fP5Vb=ygmQ0B45GfrK2PeaV04bPWmcZ6Vb+swgyA@mail.gmail.com>
Subject: Re: [PATCH] crypto: testmgr - allocate buffers with __GFP_COMP
To:     Eric Biggers <ebiggers@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-crypto <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 12:31 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> This is needed so that CONFIG_HARDENED_USERCOPY_PAGESPAN=y doesn't
> incorrectly report a buffer overflow when the destination of
> copy_from_iter() spans the page boundary in the 2-page buffer.
>
> Fixes: 3f47a03df6e8 ("crypto: testmgr - add testvec_config struct and helper functions")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  crypto/testmgr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index 0f6bfb6ce6a46..3522c0bed2492 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -156,7 +156,8 @@ static int __testmgr_alloc_buf(char *buf[XBUFSIZE], int order)
>         int i;
>
>         for (i = 0; i < XBUFSIZE; i++) {
> -               buf[i] = (char *)__get_free_pages(GFP_KERNEL, order);
> +               buf[i] = (char *)__get_free_pages(GFP_KERNEL | __GFP_COMP,
> +                                                 order);

Is there a reason __GFP_COMP isn't automatically included in all page
allocations? (Or rather, it seems like the exception is when things
should NOT be considered part of the same allocation, so something
like __GFP_SINGLE should exist?.)

-Kees

>                 if (!buf[i])
>                         goto err_free_buf;
>         }
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Kees Cook
