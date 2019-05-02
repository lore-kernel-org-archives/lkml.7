Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440ACC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FC4206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mePCEJJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEBJEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 05:04:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42573 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfEBJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 05:04:47 -0400
Received: by mail-io1-f65.google.com with SMTP id c24so1364074iom.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dcwouIio3pquS1U6JPwTtxaMz1Fu2+GdN9Jw6GVROKA=;
        b=mePCEJJuEzrfQvE3aoi+jCxgYS6qYKpU+or/ChU5Y66Hv4q13yFsq3CBmEln+XUdBC
         lsFb8i592FuOLSVPS33kfO0MqBpIkbHavQWEPuELJTqoUm2/GfSHyacZkpMzCdIOxZnM
         p8g6WP5bxNm9QO7pS8AYZrM7clzCUOUO1ClHKeFUDLjKa2MwnnRJHy7ROPmgd6YSfDi1
         Ibm/SkQmUMgXLqLQbJVuWEbM6rtk+81RktYNjj3Lkp+4kyTt7JHCI66IdIbjLJwq27bh
         7bhCwYhztmVypJMPPBkilPl70cM9Kw7vsu2JEVDWZiG2jO9/PzbY9y9tg9cBF9zgw4b+
         Lx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcwouIio3pquS1U6JPwTtxaMz1Fu2+GdN9Jw6GVROKA=;
        b=n9zfqiE7uRvGUCRWNpZ9joaETQoVDaKWvqgC6RNwLMepWPgMWAMbUTIp/vws4hTfsN
         yK2tlTWRDxcbDymZqC8kXGLhouf0bMdm+/gXF9/CSnz0/4B6VItoO/NJCrQcLhMMQTRj
         BMLD/csg3IYFaWlKS2oNMYJHH8tXMfjEowWt1G5xSWqVAF8jNtlGo7DFXzcBaPVF221D
         rBVXwydrKcQYyNtXeOsbGI5GJR0TI0JEFMLMdkOn1HeGahpuFnwuBsjq2FN5AUZ0khzz
         7dP9wYgaruGzNS1TC9LJrIPEI3kkVh/EQVTm5SBbnSjNWYckp3pBnBVDIihkfmwL4Ng2
         rYOg==
X-Gm-Message-State: APjAAAUSiYXjQzlkPBe28cHcpNedkVF0ifWpRpTaIQ40U0i5BnaBo8Zv
        wNR9kPAja7Gp7LIdprbqXojsEusb4PjzTLbk6R7gAw==
X-Google-Smtp-Source: APXvYqzBhjbY1ZiG5tHgZmkpXFWtQYk+R89xVQ9byXWTO79kTZAxe32EvMBuTJDtHstIKynt+ZdjMu9BbR4KW+hGxTE=
X-Received: by 2002:a5e:9b17:: with SMTP id j23mr1837695iok.60.1556787885737;
 Thu, 02 May 2019 02:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040441.30372-1-jlee@suse.com> <20190502040441.30372-2-jlee@suse.com>
In-Reply-To: <20190502040441.30372-2-jlee@suse.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 May 2019 11:04:34 +0200
Message-ID: <CAKv+Gu8MESd3BXCKR=EH7Z1kWegm9XjTP38jBsizpgDAuyA3YQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] efi: print appropriate status message when loading certificates
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2019 at 06:04, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
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
> So, this patch shows the status string instead of status code.
>
> On the other hand, the "Couldn't get UEFI" message doesn't need
> to be exposed when db/dbx/mok variable do not exist. So, this
> patch set the message level to debug.
>
> v3.
> - Print messages similar to db/mok when loading dbx hash to blacklist:
> [    1.500952] EFI: Blacklisting hash of an executable: UEFI:dbx
> [    1.501773] blacklist: Loaded blacklisting hash
> 'bin:80b4d96931bf0d02fd91a61e19d14f1da452e66db2408ca8604d411f92659f0a'
>
> - Setting messages for the existence of db/mok/dbx lists to debug level.
>
> v2.
> Setting the MODSIGN messages level to debug.
>
> Link:
> https://forums.opensuse.org/showthread.php/535324-MODSIGN-Couldn-t-get-UEFI-db-list?p=2897516#post2897516
> Cc: James Morris <jmorris@namei.org>
> Cc: Serge E. Hallyn" <serge@hallyn.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Nayna Jain <nayna@linux.ibm.com>
> Cc: Josh Boyer <jwboyer@fedoraproject.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  certs/blacklist.c                             |  3 +-
>  security/integrity/platform_certs/load_uefi.c | 40 +++++++++++++++++++--------
>  2 files changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 3a507b9e2568..f91437e39e44 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -100,7 +100,8 @@ int mark_hash_blacklisted(const char *hash)
>         if (IS_ERR(key)) {
>                 pr_err("Problem blacklisting hash (%ld)\n", PTR_ERR(key));
>                 return PTR_ERR(key);
> -       }
> +       } else
> +               pr_notice("Loaded blacklisting hash '%s'\n", hash);
>         return 0;
>  }
>
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index 81b19c52832b..6b6996e5bc27 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#define pr_fmt(fmt) "EFI: "fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/cred.h>
> @@ -35,6 +37,18 @@ static __init bool uefi_check_ignore_db(void)
>         return status == EFI_SUCCESS;
>  }
>
> +static void str16_to_str(efi_char16_t *str16, char *str, int str_size)
> +{
> +       int i = 0;
> +
> +       while (str16[i] != '\0' && i < (str_size - 1)) {
> +               str[i] = str16[i];
> +               i++;
> +       }
> +
> +       str[i] = '\0';
> +}
> +
>  /*
>   * Get a certificate list blob from the named EFI variable.
>   */
> @@ -44,13 +58,20 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>         efi_status_t status;
>         unsigned long lsize = 4;
>         unsigned long tmpdb[4];
> +       char namestr[16];
>         void *db;
>
> +       str16_to_str(name, namestr, ARRAY_SIZE(namestr));

Please drop this (and the function above) - instead, just return NULL
if the variable is not found (without reporting an error).

>         status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
>         if (status != EFI_BUFFER_TOO_SMALL) {
> -               pr_err("Couldn't get size: 0x%lx\n", status);
> +               if (status == EFI_NOT_FOUND)
> +                       pr_debug("UEFI %s list doesn't exist\n", namestr);
> +               else
> +                       pr_err("Couldn't get size for UEFI %s list: %s\n",
> +                               namestr, efi_status_to_str(status));
>                 return NULL;
>         }
> +       pr_debug("UEFI %s list exists\n", namestr);
>
>         db = kmalloc(lsize, GFP_KERNEL);
>         if (!db)
> @@ -59,7 +80,8 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>         status = efi.get_variable(name, guid, NULL, &lsize, db);
>         if (status != EFI_SUCCESS) {
>                 kfree(db);
> -               pr_err("Error reading db var: 0x%lx\n", status);
> +               pr_err("Error reading UEFI %s list: %s\n",
> +                       namestr, efi_status_to_str(status));
>                 return NULL;
>         }
>
> @@ -95,6 +117,7 @@ static __init void uefi_blacklist_hash(const char *source, const void *data,
>  static __init void uefi_blacklist_x509_tbs(const char *source,
>                                            const void *data, size_t len)
>  {
> +       pr_info("Blacklisting X.509 TBS hash: %s\n", source);
>         uefi_blacklist_hash(source, data, len, "tbs:", 4);
>  }
>
> @@ -104,6 +127,7 @@ static __init void uefi_blacklist_x509_tbs(const char *source,
>  static __init void uefi_blacklist_binary(const char *source,
>                                          const void *data, size_t len)
>  {
> +       pr_info("Blacklisting hash of an executable: %s\n", source);
>         uefi_blacklist_hash(source, data, len, "bin:", 4);
>  }
>

These are separate changes - I don't have an opinion whether they are
appropriate or not, but they should be in a separate patch.

> @@ -154,9 +178,7 @@ static int __init load_uefi_certs(void)
>          */
>         if (!uefi_check_ignore_db()) {
>                 db = get_cert_list(L"db", &secure_var, &dbsize);
> -               if (!db) {
> -                       pr_err("MODSIGN: Couldn't get UEFI db list\n");
> -               } else {
> +               if (db) {
>                         rc = parse_efi_signature_list("UEFI:db",
>                                         db, dbsize, get_handler_for_db);
>                         if (rc)
> @@ -167,9 +189,7 @@ static int __init load_uefi_certs(void)
>         }
>
>         mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
> -       if (!mok) {
> -               pr_info("Couldn't get UEFI MokListRT\n");
> -       } else {
> +       if (mok) {
>                 rc = parse_efi_signature_list("UEFI:MokListRT",
>                                               mok, moksize, get_handler_for_db);
>                 if (rc)
> @@ -178,9 +198,7 @@ static int __init load_uefi_certs(void)
>         }
>
>         dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
> -       if (!dbx) {
> -               pr_info("Couldn't get UEFI dbx list\n");
> -       } else {
> +       if (dbx) {
>                 rc = parse_efi_signature_list("UEFI:dbx",
>                                               dbx, dbxsize,
>                                               get_handler_for_dbx);
> --
> 2.16.4
>

I think we should consider carefully what it means if some of these
variables don't exist:
- if secure boot is enabled, db and dbx must exist, so if they don't,
something is wrong
- secure boot might be enabled but we may be booting without shim.
- secure boot might be disabled.

Tweaking the severity of error messages without having a clear idea of
the policy we are aiming to implement is likely to cause trouble down
the road, so perhaps someone could explain what this code does, and
how it should behave in the above circumstances.
