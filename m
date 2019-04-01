Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F364C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD7820880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j488x6ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfDAVMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:12:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39925 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfDAVMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:12:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so2425778otb.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=my+8kMrogBOyXJrCZPeMJC88daxVsQMYdE+rBltktwg=;
        b=j488x6tiM97EhXQc/V0QqchABBaTyH78NFyaCmrkFem7gAtMk15wihd5zSYn+QTzWL
         jCP8ef69w+NtciWMP0rB++VuHdApxi4cByB8/wn71c8/SOi+m57mLTVLF4UhqYGDLvwd
         4FBtacF/J8ZJlR2ykZ7YF+FMN2YqPd/Pm7ZCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=my+8kMrogBOyXJrCZPeMJC88daxVsQMYdE+rBltktwg=;
        b=i0qgvmVKh/n13dV0E4YLVUXXlAQrdOqL2jmIYQyLU0/qoKzuv1oCz2OkKmW9DaroZ8
         chVVe1Sijk4Adu1L2ojRfFCdKWeert/3Hs69/quGV0i/03HUjdIbO/TblAiGTzlnuWPG
         LdVCT7D7YzD/7xV0DaABodXnSgT0zNgHdRYlIaPzwbfXG6EjZAlRh706ShI134v1v+1m
         xOFdO11+ofDs7hymHylP6gl3M4HkjpDdYLOm4HO3oVgFimYmW8Yarlo5OvozeNiHX1kW
         Wkp92UwMpq6Qnkq9ckOARCYrgI2n//G2fg1DbVJtSjJkZRJ4vVsJ+deqZGvFoQdufl66
         S8IA==
X-Gm-Message-State: APjAAAX4TrFXkVf6ZYPmOF5KKOWzaLoi1UjlDlS9oAYs6Kuj2E7Hvec4
        p4Ohxb6mFxZ2daoEWvraIXAxZyiQu3s=
X-Google-Smtp-Source: APXvYqzmNm3y1SMwVQ2SI8KCfHpIrD4oEmQFizfxd2lvg/L8+L9nPHR4rDEBMmLgosEfrgruGd6aaw==
X-Received: by 2002:a9d:694e:: with SMTP id p14mr21956201oto.193.1554153155426;
        Mon, 01 Apr 2019 14:12:35 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id i17sm4505438otc.67.2019.04.01.14.12.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:12:35 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 3so8600687oir.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:12:34 -0700 (PDT)
X-Received: by 2002:aca:3905:: with SMTP id g5mr9847863oia.49.1554153154276;
 Mon, 01 Apr 2019 14:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <5d7229de06286b4ec06daee3411e39e9b638d66c.camel@perches.com>
In-Reply-To: <5d7229de06286b4ec06daee3411e39e9b638d66c.camel@perches.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 1 Apr 2019 15:12:23 -0600
X-Gmail-Original-Message-ID: <CAHX4x85RUfLG8caUY0fvN11qSNWiuzDjud_3Do8mUwM69M1OCg@mail.gmail.com>
Message-ID: <CAHX4x85RUfLG8caUY0fvN11qSNWiuzDjud_3Do8mUwM69M1OCg@mail.gmail.com>
Subject: Re: [PATCH] coding-style.rst: Generic alloc functions do not need OOM logging
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Joe, this is a great detail to add.

On Sat, Mar 30, 2019 at 11:25 AM Joe Perches <joe@perches.com> wrote:
>
> Generic allocation functions already emit a dump_stack()
> so additional error logging isn't useful.
>
> Document it as such and add a reference to the allocation
> API.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  Documentation/process/coding-style.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 8ea913e99fa1..fa864a51e6ea 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -843,7 +843,8 @@ used.
>  The kernel provides the following general purpose memory allocators:
>  kmalloc(), kzalloc(), kmalloc_array(), kcalloc(), vmalloc(), and
>  vzalloc().  Please refer to the API documentation for further information
> -about them.
> +about them.  :ref:`Documentation/core-api/memory-allocation.rst
> +<memory_allocation>`
>
>  The preferred form for passing a size of a struct is the following:
>
> @@ -874,6 +875,9 @@ The preferred form for allocating a zeroed array is the following:
>  Both forms check for overflow on the allocation size n * sizeof(...),
>  and return NULL if that occurred.
>
> +These generic allocation functions all emit a stack dump on failure when used
> +without __GFP_NOWARN so there is no use in emitting an additional failure
> +message when NULL is returned.
>
>  15) The inline disease
>  ----------------------
>

Acked-by: Nick Crews <ncrews@chromium.org>
