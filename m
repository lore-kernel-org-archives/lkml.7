Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B54C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5168C20651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWsXoM80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfEBIxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:53:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38515 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfEBIxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:53:44 -0400
Received: by mail-it1-f194.google.com with SMTP id q19so2064770itk.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1X9ipyrjBCgysbixO7mllniKFp0zrqAX+YLVm+Qy1S0=;
        b=yWsXoM80YUTgdMB6oO2DDbeU8DPDbcmA+PC+5sSaToOqaTpIKARGyOV/boF39l6Q1e
         0aVuAgi17sn11G4czZdsXIIJkkaqL5RwBNxp2WmHWGQ0do7X2cYx5WD9ZEZgo4pNA4eM
         jQeldBHxndo5h2SYoCG+q9P+M52Zgdto9W0VS1nmNRxaq9lQxMuYeHsQMqJOD1PiJBJL
         ZbHxxKVWhhaxPoCfu7IaDYqyN9xb9KuFVUCbvvm5JUBTMgU9qJ+Cy7s2nVCb+dPkiDWV
         FNdrFBiSFR1EnoD5PIjaMUH7Ka1MQhnuK2F3cSwxw0wBXszsZbDKh7ybJR69Ihjcb57D
         zysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1X9ipyrjBCgysbixO7mllniKFp0zrqAX+YLVm+Qy1S0=;
        b=THlZ50L+mHFV1bN/Xntfw6nhuzE4xheuQxmUEv/7lHU4yR1zbJLqc8hkdgAr0eqBhc
         J1rIEYGbvs1Cnos5qry6G3mxF0+yv3+ERnyY1DtyWGWtFO5PhefLmA2sNSxJDEu1beRN
         YHLHFLm7Cm0OJgYh0eamo0dvKBfh1XzkNZ+5/V2EeQBNWIQBpPQqtHaQY54dL8egFQs7
         5SPgIdNEKzom+PEd81SRbRpCE3zC56smYR5Mc7zic3cmKJfomX+9Qj99geKg3fO6IQzo
         kqrOqOSeSdewWtfnSlwfvn2/cHvkigzuIX9yMf/sA/b/GQKscNUlqmbFk3uEsySrJMfs
         quDQ==
X-Gm-Message-State: APjAAAXMrZI6ENXSL5fjMJHXYQiVBbuv10bZGnzcxq94m9+6HQcyCJo8
        YoJCQ93crkCLuin+3X64tP4w33imSGUUt8ZQaw25XQ==
X-Google-Smtp-Source: APXvYqx/xmKUay1hTDkSxXbGcJPVRadVdpD5CE7BMBOOohtgLIELm0otn+yCvfcjJqOQCM5tLVNFRPp2zEAvFndl3JM=
X-Received: by 2002:a24:b342:: with SMTP id z2mr1327414iti.121.1556787223814;
 Thu, 02 May 2019 01:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040441.30372-1-jlee@suse.com>
In-Reply-To: <20190502040441.30372-1-jlee@suse.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 May 2019 10:53:31 +0200
Message-ID: <CAKv+Gu9mjtNEWN-w4ix7VJMZ_kk-Qf6FfYFRu2mCosaAjMA4Vg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] efi: add a function to convert the status value to string
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

On Thu, 2 May 2019 at 06:04, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
>
> This function can be used to convert EFI status value to string
> for printing out debug message. Using this function can improve
> the readability of log.
>
> v2.

Please move the changelog out of the commit log (move it below the ---
further down)

> - Changed the wording in subject and description.
> - Moved the marco immediately after the status value definitions.
> - Turned into a proper function instead of inline.
>

You missed my point here. A proper function means the function in a .c
file, and only the declaration in a .h file. This way, you are still
duplicating the literal strings into every object file that references
this function.

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
> index 54357a258b35..6f3f89a32eef 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -42,6 +42,34 @@
>  #define EFI_ABORTED            (21 | (1UL << (BITS_PER_LONG-1)))
>  #define EFI_SECURITY_VIOLATION (26 | (1UL << (BITS_PER_LONG-1)))
>
> +#define EFI_STATUS_STR(_status) \
> +case EFI_##_status: \
> +       return "EFI_" __stringify(_status);
> +
> +static __attribute__((unused)) char *
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
> +       default:
> +               pr_warn("Unknown efi status: 0x%lx", status);
> +       }
> +
> +       return "Unknown efi status";
> +}
> +
>  typedef unsigned long efi_status_t;
>  typedef u8 efi_bool_t;
>  typedef u16 efi_char16_t;              /* UNICODE character */
> --
> 2.16.4
>
