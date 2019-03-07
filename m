Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9059CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641AE20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8roESNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCGSVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:21:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38018 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfCGSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:21:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so11898385pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qzER3O3vaFjGinKBDoc8dyaZXPNBFOrAVxaHw4AHUEQ=;
        b=D8roESNdEyg3JrpExZkR5NybTW1dsL3L5Ek/JmLYjyWMJCzr1o7anX7nIRiWhwFTrQ
         TZVRSlTS4Ep1qAqTU9gYMpktjPO/z2f/i33KRlh8wmjIZR2SDoJFEj4x6bRyjMDYej62
         ohijlGu1lrmDEHGtjladGWgX11FRymBvrtwnJYcN1SdL3cbB5bL65lSAoCcEKTglPcQT
         j5Uxc974P9Mqh3mN0X9j8NMGT4X0OqNSrsV5Ir6ndEjLT9qz9TpCnJ7nRdywhM4w7gCq
         zOMry7C5BX3s8FSJxXHZ0zcqhDXKdntUY2vGlZke5VMEaRnzRAZSrtc9pQCIiN7HJoGZ
         y6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzER3O3vaFjGinKBDoc8dyaZXPNBFOrAVxaHw4AHUEQ=;
        b=fgAoQ3707XDoSZzo0PdxGnyc8ZaGahfyttIUi+QeX6mKJlk0U8W5Ic7suIHMIrGuP0
         bkknl1wmFTTU1QLhyCaEnZkHOQlMTcUM8lib9QXQ6AbgObhqcHXqwTL5NAlQD6+LLPKu
         TR+z6pUVTYiZOovtY0nijJIsocJKniCjSA2AFufpBSOjMu7KlvR6tZd9In95znnlp++o
         3p+ia0qNnvtj5j/1OmWrburXDhHZsN/1psna8u0+ZKbWgBZBRRnYXI0R6zTdz77sbM4X
         y5sVkpVIe9z6RjVosoSc+EmGDzd3qSr+LzOCXBijUSJBvvENIMp8WyuHfCu7jsyZSdIE
         eFpA==
X-Gm-Message-State: APjAAAV0Kth1slsEgqgwzr9kDi+C9pVN8RlMFJaUXXmToBHNO2mbuA3P
        P7gte0JagsXbfUBy1Lc3Ftq0HoBHP3Bvuc24XJ7hIA==
X-Google-Smtp-Source: APXvYqyRS2TkLVR4XQInWMb9RTCHMSVGhcBullgmAJdqXy6ZW5YLjz1DUXk6UiJX0M496EVsozi/TIYSeghja405CEc=
X-Received: by 2002:a63:c70c:: with SMTP id n12mr12809764pgg.302.1551982875171;
 Thu, 07 Mar 2019 10:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20190307173802.3448-1-natechancellor@gmail.com>
In-Reply-To: <20190307173802.3448-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 10:21:04 -0800
Message-ID: <CAKwvOdkfW6ipodrfLcGspLP3RaKdxLEvz=odBqh4PcoyVYyzwA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / sysfs: Restructure get_status
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 9:38 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/acpi/sysfs.c:667:13: warning: variable 'result' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>
> Clang can't determine that all cases are covered by the two separate if
> statements. We could combine then to look like this:
>
>     int result;
>
>     if (...) {
>         ...
>     } else if {
>         ...
>     } else {
>         result -EINVAL;
>     }
>
>     return result;
>
> However, at that point, we can further simplify this function by only
> using result when absolutely needed and just direct returning the value
> of the function.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/388
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/acpi/sysfs.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 41324f0b1bee..6ed785cadad9 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -651,23 +651,18 @@ static void acpi_global_event_handler(u32 event_type, acpi_handle device,
>  static int get_status(u32 index, acpi_event_status *status,
>                       acpi_handle *handle)
>  {
> -       int result;
> -
> -       if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
> -               return -EINVAL;
> -
>         if (index < num_gpes) {
> -               result = acpi_get_gpe_device(index, handle);
> +               int result = acpi_get_gpe_device(index, handle);

I'm surprised this does not trip -Wdeclaration-after-statement.

>                 if (result) {
>                         ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
>                                         "Invalid GPE 0x%x", index));
>                         return result;
>                 }
> -               result = acpi_get_gpe_status(*handle, index, status);
> +               return acpi_get_gpe_status(*handle, index, status);
>         } else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
> -               result = acpi_get_event_status(index - num_gpes, status);
> +               return acpi_get_event_status(index - num_gpes, status);
>
> -       return result;
> +       return -EINVAL;
>  }


LGTM, thanks Nathan!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
