Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E50C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CCC218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEdJMIK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfCVO16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:27:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35849 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbfCVO16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:27:58 -0400
Received: by mail-it1-f195.google.com with SMTP id h9so3547733itl.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCXkqtJXweMtT7tkjAU9aokE2Llx9dELHbkDZghxZuc=;
        b=NEdJMIK9h2iWW4z/4DLDds0gdjLAJfcSG3gwWS4GiCWbhHKUQIw79yK8oSdAGIhDeK
         1raJXetJfp6kF94+UUB0srpLPbwGjekNgmFDlB6KgIty68/w/6/NLVcBpr+16x7u7nsb
         g0WCuYfXcivGP5WlTrH9iGAnxzRKZr7TIBgnkNp9ghvSryFQLeT87o12BVYrFeKK3Q6L
         2ukOqNOquDy52Q7drG2QLI3NNZgwnnmn1hkF3wpMKz4A1kVNN0vHDLUS0TiHLOFcwBv/
         PjQMrcqTgH6Q7iSOyRXS5y6Ki3qduxfM6RiTqkn08KwJ7p0sKykAxkGDVn/uqU4jrlZZ
         n6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCXkqtJXweMtT7tkjAU9aokE2Llx9dELHbkDZghxZuc=;
        b=DrpRZWhvO3OJh4LXhfb7300lpfgTf1110vCXFu+vtwexOs3CqIXoMDkQG7TLd8YSzb
         eoWs1+vE8rO95ZD5h49l295Urr8NPNmDMVrzKU48pV/23Dt0y47avcP5SBTQOdxUSc3w
         omTUwdUlZV/SQr4edqUwXbTvJN+3KqiB0AMZr7g/xIc/veEsD1AAMz0oGEIDqix/pNue
         vYWU+D1QL+ruHvIjGhO4Tota688xBT8hUCn+WnEIS96fG4bNdzKxA+i94tUV/OBklXO5
         OGryzU29lySYd/tI2GSQ+AGrwHZ+wUZ0j+Ecocp3rsQYz6ROWGdSrzV+9We7batTvBnT
         51xA==
X-Gm-Message-State: APjAAAUH+qI+AnWo2fqYS9TG1j6rOmVlmCBtaYWMc99r3pB8/pzItIdf
        aiC3cT1G1vQP/+AOZ7uuBfzYCK0mPCWMz9YFwBVBOQ==
X-Google-Smtp-Source: APXvYqy7pT8oa0KnMZcYwqn/r+clsMGOQpxbdKlTodcdpwjkR1KBQZWCAyI9+0ugN+QbgK+EKvR92pQUHFYCanUGxGo=
X-Received: by 2002:a02:ac14:: with SMTP id a20mr7591159jao.130.1553264877146;
 Fri, 22 Mar 2019 07:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190322103350.27764-1-jlee@suse.com> <20190322103350.27764-2-jlee@suse.com>
In-Reply-To: <20190322103350.27764-2-jlee@suse.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 22 Mar 2019 15:27:46 +0100
Message-ID: <CAKv+Gu8Xg3SBTpAFDSe5zyT8yjU71+HUT9LO18D+HiT+Hhp+Zg@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: print appropriate status message when loading certificates
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

On Fri, 22 Mar 2019 at 11:34, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
>
> When loading certificates list from UEFI variable, the original error
> message direct shows the efi status code from UEFI firmware. It looks
> ugly:
>
> [    2.335031] Couldn't get size: 0x800000000000000e
> [    2.335032] Couldn't get UEFI MokListRT
> [    2.339985] Couldn't get size: 0x800000000000000e
> [    2.339987] Couldn't get UEFI dbx list
>

Why is it an error in the first place if these EFI variables do not exist?


> So, this patch shows the status string instead of status code.
>
> On the other hand, the error message of EFI_NOT_FOUND
> (0x800000000000000e) doesn't need to be exposed because kernel
> already prints "Couldn't get UEFI..." message. This patch also
> filtered out it.
>
> Link: https://forums.opensuse.org/showthread.php/535324-MODSIGN-Couldn-t-get-UEFI-db-list?p=2897516#post2897516
> Cc: James Morris <jmorris@namei.org>
> Cc: Serge E. Hallyn" <serge@hallyn.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Nayna Jain <nayna@linux.ibm.com>
> Cc: Josh Boyer <jwboyer@fedoraproject.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  security/integrity/platform_certs/load_uefi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index 81b19c52832b..fe261166621f 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -48,7 +48,9 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>
>         status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
>         if (status != EFI_BUFFER_TOO_SMALL) {
> -               pr_err("Couldn't get size: 0x%lx\n", status);
> +               if (status != EFI_NOT_FOUND)
> +                       pr_err("Couldn't get size: %s\n",
> +                               efi_status_to_str(status));
>                 return NULL;
>         }
>
> @@ -59,7 +61,8 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>         status = efi.get_variable(name, guid, NULL, &lsize, db);
>         if (status != EFI_SUCCESS) {
>                 kfree(db);
> -               pr_err("Error reading db var: 0x%lx\n", status);
> +               pr_err("Error reading db var: %s\n",
> +                       efi_status_to_str(status));
>                 return NULL;
>         }
>
> --
> 2.16.4
>
