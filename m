Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CD9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8292133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DRGDGxTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfCRVr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:47:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41216 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfCRVr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:47:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so12300752pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agYS0IwXFgBu4pc5CJZTRwoxt1/eC7gb+mIihEfUuM4=;
        b=DRGDGxTDjF2JkqDldJKrdDbMJQ1kNz53JgDxarSWUOJi2zUIIn90abi/oB89xQY2fY
         vb4MuT/TPdb+DwN/OSu9kv8B1izlneXRHQLVtlv4bWoIWO+SUBuywTXG3OLYh1xnMlOA
         Nn5OiG6l2j5YVDUt3DTRaIVn0yx86N26dSGzjWVOzCdVFFERrFkJC6V9gvxoJzP0+or6
         nBYPCwZ97hyYT7U6SBVZH03WhujcIBXlRdqLgQfaUUCVWq5Q0HB//6KhVhdSazCzCgqT
         v9gUb+1cH0NZ9O/V7fhjKXsOmaLVh9nmUMjUCk8pX+K9udHzodfWxJOYVrH6bfHD0mcE
         3CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agYS0IwXFgBu4pc5CJZTRwoxt1/eC7gb+mIihEfUuM4=;
        b=aKbT2Gn5S1NRwe73w3fpJ/pyfTaQzWSiCNCvWecqZ8f78ouLjdmBGZWWPp5NwbeSP6
         SPzJuLhbYA0MgK8cTC2jWFqK3yx8SO+zbkjeY21gFqrwcuYghkXzG9Qs+u6cwilyNGkV
         nkMolCIr8hgvpxOHoseN5Xg8K5cQ/3dSYlDBNIXuFEz96aU7J5PtthJ0xh2U/fxm4ZGb
         H80YuZh94ffHnWMO2tlhffhsT4mDzzXGvFA9I2dRRlZzBoSsK6ytf8qwd+BR2VWY5F2W
         FT+uszpcHcX9dsaqonBOXtkVWob0sBo/+bhMXWS+82DsP8UXhmS4IMeeFNP2fpzn2Bex
         brrQ==
X-Gm-Message-State: APjAAAU0mH6UAcE83RY/yIVKzTMLywE2eENA34Tkn9HpqmI3KB4Sxmln
        injfFiPZZt2hzd1dajb6tWEBqEPAUsllsRbLMBoU9w==
X-Google-Smtp-Source: APXvYqyeLCvfyNkMNMkqW+B0wm7kb0DABcM7lN1cvqtKR+oisumkx22qYuXN+4xcYHCTg6iCO+mXI32rNBUeqXgj6u4=
X-Received: by 2002:a63:5a20:: with SMTP id o32mr18904379pgb.225.1552945644929;
 Mon, 18 Mar 2019 14:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAG5bF+RvumzKK0E-GAT223jnBvkRe1RN_0J9cGpfPOqCBvfWyw@mail.gmail.com>
In-Reply-To: <CAG5bF+RvumzKK0E-GAT223jnBvkRe1RN_0J9cGpfPOqCBvfWyw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Mar 2019 14:47:13 -0700
Message-ID: <CAKwvOdnms16AC3jPcc_7MXD7QF43dKvHsi+aqmsz0wX-u1GTpA@mail.gmail.com>
Subject: Re: [PATCH] Revert "kbuild: use -Oz instead of -Os when using clang"
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Behan Webster <behanw@converseincode.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 2:10 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The clang option -Oz enables *aggressive* optimization for size,
> which doesn't necessarily result in smaller images, but can have
> negative impact on performance. Switch back to the less aggressive
> -Os.
>
> This reverts commit 6748cb3c299de1ffbe56733647b01dbcc398c419.

Does scripts/checkpatch.pl complain about this format (full sha, no
title)?  Not sure that necessitates a v2, but if so would be good to
mention that Clang generates excessive calls into libgcc/compiler-rt
at -Oz.  Thanks for the patch and the discussion/sanity check.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 9ef547fc7ffe..191f3ce3cb5e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -667,7 +667,7 @@ KBUILD_CFLAGS       += $(call cc-disable-warning, format-overflow)
>  KBUILD_CFLAGS  += $(call cc-disable-warning, int-in-bool-context)
>
>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> -KBUILD_CFLAGS  += $(call cc-option,-Oz,-Os)
> +KBUILD_CFLAGS  += -Os
>  else
>  KBUILD_CFLAGS   += -O2
>  endif
> --
> 2.21.0.225.g810b269d1ac-goog



-- 
Thanks,
~Nick Desaulniers
