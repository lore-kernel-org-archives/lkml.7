Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6D0C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35E021655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uE9JMWvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfLLLUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:20:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40586 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfLLLUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:20:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so2302719wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 03:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivFqEZVMxDlluXkfjhIVuukwLoQ6ml1igOQ8Cc9Zm9w=;
        b=uE9JMWvt9vyswBy+Wt2xquQ2Jxww+cR1AM7yoJaiBdl8vUvUH53yUArHc4DDfSubGU
         MgPoUHG7z3CJoyjqb32H/gdCza7zfL3T8sm+Sxsq7k3QpNnS0T/CcgcS6wM2VveKQ8Ce
         +7M/koJ4H6xi5KqDHpLSqyAwhNL9hgn4YtGWvoM13a6UtLqyhQOORfihzCdMAehDb5Nm
         MhzavXgfohIRgl/vFp/nEk1kJ2VmtwgxxpME6Y3LaA/JkJ+xvmpqn49s/EjBFuO5EVsW
         gqFsNDK9Nwe+1g2l/MorDGeno6XXeGuhka9PRL7vSRZbytZFEHIPGmq/4UF3EhIwUL0u
         8Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivFqEZVMxDlluXkfjhIVuukwLoQ6ml1igOQ8Cc9Zm9w=;
        b=BfR0J5gw1DDQI6ufdKuHa9U6e8KB9jHV3QpnJVSMELHPiZRRVYUkRi5zP7g5JZOaYA
         6xy0LmhMvkYeOomDxeVFzbC21EphVdhXLd2XVLqTgChbh6QDDgQagwB95M2RJb2SpPXK
         bA6Z5U9d0gdQLegTChSbwV+sxY8CG9ai5d+QZKYj9gsewI3EF0rzztxU8m2pso55Q7Ds
         VQVB2B06kvYTbhbaDgXNHZfdIQGH+QMwTJOjCXs+vhTyaj4uwN56IzYFDJrEZiP5uIYZ
         3mjqFpGu4ghXORc2q/8VJEW+uuroJe+C64R63BRzH5qhRv7ddW9nmIxJTZmqpbrNXvR1
         TdRg==
X-Gm-Message-State: APjAAAURM6cPvXFvy4w5oWxdKnpVBH1hzrQYjMWJjLqYCBQQhU36pCup
        ly8FTaOJ43KbqH4gQNNxH4H2qEu4D2I0008JDyP6NA==
X-Google-Smtp-Source: APXvYqzqMS/j40WHSQb5IK30a+VRBSABj69lx+KJOU+ZZYD3Jv7P7N1myxgQOHYZaxJgWZHLWz45pzWqu+o1zRlzfDI=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr5609828wrs.200.1576149649548;
 Thu, 12 Dec 2019 03:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20191212093812.10518-1-jlee@suse.com> <20191212093812.10518-2-jlee@suse.com>
In-Reply-To: <20191212093812.10518-2-jlee@suse.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 12 Dec 2019 11:20:48 +0000
Message-ID: <CAKv+Gu83Ndu8XWDAUTmHu6udRCXbodqzTyq5wZJvfGiLfidwbw@mail.gmail.com>
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
        "Lee, Chun-Yi" <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019 at 10:38, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
>
> This function can be used to transfer EFI status code to string
> to improve the readability of debug log.
>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

I think I mentioned this the last time you sent this patch: by making
this a static inline, those strings will be copied into each object
file that uses this routine.
Instead, please make it an ordinary function.

> ---
>  include/linux/efi.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index d87acf62958e..08daf4cdd807 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -42,6 +42,32 @@
>  #define EFI_ABORTED            (21 | (1UL << (BITS_PER_LONG-1)))
>  #define EFI_SECURITY_VIOLATION (26 | (1UL << (BITS_PER_LONG-1)))
>
> +#define EFI_STATUS_STR(_status) \
> +       case EFI_##_status: \
> +               return "EFI_" __stringify(_status);
> +
> +static inline char *
> +efi_status_to_str(unsigned long status)
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
> +       }
> +
> +       return "";
> +}
> +
>  typedef unsigned long efi_status_t;
>  typedef u8 efi_bool_t;
>  typedef u16 efi_char16_t;              /* UNICODE character */
> --
> 2.16.4
>
