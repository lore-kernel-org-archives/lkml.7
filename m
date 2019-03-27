Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC02C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F375205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JF49+XbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390087AbfC0S6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:58:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44314 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387621AbfC0S6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:58:15 -0400
Received: by mail-io1-f66.google.com with SMTP id u12so15005901iop.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zpE6m1a2YTyZG87ILOfzQwFgJzFuGUtf1eqpd8KRqU=;
        b=JF49+XbQlHvrhKeFSkNt0c1PP7urYXc9wjfrHGAlFSny9O4jemrtAfFYRfuFTXlUll
         gKe0eJ2LxMe/JjAJwC+thLUP1522Zy/SCqwv3MKZEhw388npILx9xMeCts1uy4aHU9HF
         oGl3/26J5vaUN71sh7odS9PIzoc0ZL9X4qorTdg9GJk4EesWOKCSApMW3Ia76+GDHw/X
         uT/zGWNDA8M9Rw3v6djZ3ali3tRdsVUxZ8PrZSYDJc0yUuslRJBCSBmZu5HPhllwJR/3
         u+Mm4+vDmSR1gCRzAN2TgulXG/5JtiSosWNwb7CabwrXyO/Vl1lAUXt4jXR7peNmx0D5
         kNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zpE6m1a2YTyZG87ILOfzQwFgJzFuGUtf1eqpd8KRqU=;
        b=g/KpYwucUCVeYu9kuxVXtfn70ZAQXgD3eFr27/fLfdIVBovRt4MX24W6b4o2KpPiD4
         hzRVDrGX8yV8rGkwPsKTdOs7tQstdEnPA+vSWnlh5CokEU6MIOIW6Man6MwOmxFH+b9g
         Ot6MdXMyUa2P2pq8duqPYL5h1OTcULO2krrVE6C7aAVzFeZQpYa4jSZWUVy/+Y0Xzkj+
         kL4BJ6IeN2+5IxRc3//PwiHGqWxqn6kDh+pYOo1g8d5LlczBGg/PU6y4w6EO8bo5L5eY
         TaEZBRex2CxXcRugo14y/hNX/RpfUpCFiXlLRHL3d+QPF+Veg0iWUXqahb1xSXljLYw8
         fT1Q==
X-Gm-Message-State: APjAAAVajJrPfL+Aj1GEzBis5IrFwak2aRCkpNCqBkeglWNoUAouD2aQ
        wSrXjshK7XJcdaamGRtTNdnIaDI/SZuxtf+Rn1+09w==
X-Google-Smtp-Source: APXvYqzquubLmKExmfhRmQR2xjc8zoWw3XcGGZI9YFKAzGQlQ1eCCylqTNZ1SkzJY+3EDuKCBA/KACpGtLxukqTtz9g=
X-Received: by 2002:a5e:9b17:: with SMTP id j23mr5835816iok.60.1553713094815;
 Wed, 27 Mar 2019 11:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190324002621.3551-1-jlee@suse.com>
In-Reply-To: <20190324002621.3551-1-jlee@suse.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 27 Mar 2019 19:58:03 +0100
Message-ID: <CAKv+Gu9B6h3zGVTctepd1GE5LaaMaT5x14Le1v05AOhbH36bpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi: add a function for transferring status to string
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 at 01:26, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
>
> This function can be used to transfer EFI status code to string
> for printing out debug message. Using this function can improve
> the readability of log.
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  include/linux/efi.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 54357a258b35..a43cb0dc37af 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1768,4 +1768,32 @@ struct linux_efi_memreserve {
>  #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
>         / sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
>
> +#define EFI_STATUS_STR(_status) \
> +case EFI_##_status: \
> +       return "EFI_" __stringify(_status);
> +
> +static inline char *
> +efi_status_to_str(efi_status_t status)
> +{
> +       switch (status) {
> +       EFI_STATUS_STR(SUCCESS)
> +       EFI_STATUS_STR(LOAD_ERROR)
> +       EFI_STATUS_STR(INVALID_PARAMETER)
> +       EFI_STATUS_STR(UNSUPPORTED)
> +       EFI_STATUS_STR(BAD_BUFFER_SIZE)
> +       EFI_STATUS_STR(BUFFER_TOO_SMALL)
> +       EFI_STATUS_STR(NOT_READY)
> +       EFI_STATUS_STR(DEVICE_ERROR)
> +       EFI_STATUS_STR(WRITE_PROTECTED)
> +       EFI_STATUS_STR(OUT_OF_RESOURCES)
> +       EFI_STATUS_STR(NOT_FOUND)
> +       EFI_STATUS_STR(ABORTED)
> +       EFI_STATUS_STR(SECURITY_VIOLATION)
> +       default:
> +               pr_warn("Unknown efi status: 0x%lx", status);
> +       }
> +
> +       return "Unknown efi status";
> +}
> +
>  #endif /* _LINUX_EFI_H */
> --
> 2.16.4
>

Please turn this into a proper function so that not every calling
object has to duplicate all these strings.
