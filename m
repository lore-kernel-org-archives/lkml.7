Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0EC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B81222DD
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzzV0/gE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfKSK7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:59:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52187 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726590AbfKSK7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574161151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcSCJldT6maD3sRjZ6u34JTh/bpqrmp3s9QOjR8YF3g=;
        b=WzzV0/gEgX+EaAoNW5fu05H1nA34e6GP1lsEtYJC2XYqTHC2Hx0aD38CFvaHooqESQnjhL
        1+n+iuI1kg3Zy+HhlRxssLSw3q3fPnwMbI/MqMKZ2lPEqZuCgJtxKKMw46jqE+qwK7+Hl8
        0xQYoVikRg1oJxwaJZVBUbOC9C1TMjY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-Y6XNMrRhOSy6FFYFQzRUWA-1; Tue, 19 Nov 2019 05:59:08 -0500
Received: by mail-wm1-f70.google.com with SMTP id f11so2216385wmc.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 02:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+O6R/soBFYD12X1MgAjfaQ7P5JGyL71HVn0kuh7PmlU=;
        b=C3l/suzKjHNQUeNiALyHsvpIvLEQkfPQQ8BpGydelT5TH0/KB3gaoB7E5e1uv/ECLj
         gAHI5UtF6BKLV1FGz/jGCM9YsL2wDlwl0RXfZW4J5Y6O5q0TBqBz41DGgaa/xdJkwKFv
         xQvhgBcgYnfpKPeKUkpZx/E2uhZXgCCaGP04CQYwPzxeEPTPjTlJ/LbtY/u/8KZ90YbC
         wFzd4KcUai9D3t0w0I9F3bJfrl+nLjndISffOsOOFhOhH1EtBIYFxYHzYMusVg0oKP24
         QAJH5NVoZk+OkxAE6m6JItYlNCeRHLIMu6QxAhhBYTcFGFbgIQVA9RjGyI4PlLFdgv3Y
         DcDw==
X-Gm-Message-State: APjAAAXUG7gT3pmNiExSKrS3VmgKhmuQg2FVrujqDu4muqX0VaKQXVKO
        WBSsAOsg2xGgGCv6F8VsNHmFNZGNsv+w/Xy3Ja9eiZUgo1sgm40mCyyDhpTljEV+i3jskXVMI3A
        +C6TWEZBR/ab9zVWyrwDc1syw
X-Received: by 2002:adf:f147:: with SMTP id y7mr28916124wro.236.1574161147064;
        Tue, 19 Nov 2019 02:59:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqy9UFRbKj3sx7hWovwNUvGiJyD1UjDmbrBrlm8ghZfaoRoLDjAUL7iEvPbK9uT2jP2EeII5/Q==
X-Received: by 2002:adf:f147:: with SMTP id y7mr28916103wro.236.1574161146841;
        Tue, 19 Nov 2019 02:59:06 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w17sm27975647wrt.45.2019.11.19.02.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 02:59:06 -0800 (PST)
Subject: Re: [PATCH] efi: Only print errors about failing to get certs if EFI
 vars are found
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
References: <20191119091822.276265-1-javierm@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <71e319d0-5fa9-f464-8546-b51629ae4ab3@redhat.com>
Date:   Tue, 19 Nov 2019 11:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191119091822.276265-1-javierm@redhat.com>
Content-Language: en-US
X-MC-Unique: Y6XNMrRhOSy6FFYFQzRUWA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-11-2019 10:18, Javier Martinez Canillas wrote:
> If CONFIG_LOAD_UEFI_KEYS is enabled, the kernel attempts to load the cert=
s
> from the db, dbx and MokListRT EFI variables into the appropriate keyring=
s.
>=20
> But it just assumes that the variables will be present and prints an erro=
r
> if the certs can't be loaded, even when is possible that the variables ma=
y
> not exist. For example the MokListRT variable will only be present if shi=
m
> is used.
>=20
> So only print an error message about failing to get the certs list from a=
n
> EFI variable if this is found. Otherwise these printed errors just pollut=
e
> the kernel ring buffer with confusing messages like the following:
>=20
> [    5.427251] Couldn't get size: 0x800000000000000e
> [    5.427261] MODSIGN: Couldn't get UEFI db list
> [    5.428012] Couldn't get size: 0x800000000000000e
> [    5.428023] Couldn't get UEFI MokListRT
>=20
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for this, I just noticed a potential issue which I missed
when you send this to me for testing:

>=20
> ---
>=20
>   security/integrity/platform_certs/load_uefi.c | 31 ++++++++++---------
>   1 file changed, 17 insertions(+), 14 deletions(-)
>=20
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/int=
egrity/platform_certs/load_uefi.c
> index 81b19c52832..336fa528359 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -39,16 +39,18 @@ static __init bool uefi_check_ignore_db(void)
>    * Get a certificate list blob from the named EFI variable.
>    */
>   static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
> -=09=09=09=09  unsigned long *size)
> +=09=09=09=09  unsigned long *size, efi_status_t *status)
>   {
> -=09efi_status_t status;
>   =09unsigned long lsize =3D 4;
>   =09unsigned long tmpdb[4];
>   =09void *db;
>  =20
> -=09status =3D efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
> -=09if (status !=3D EFI_BUFFER_TOO_SMALL) {
> -=09=09pr_err("Couldn't get size: 0x%lx\n", status);
> +=09*status =3D efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
> +=09if (*status =3D=3D EFI_NOT_FOUND)
> +=09=09return NULL;
> +
> +=09if (*status !=3D EFI_BUFFER_TOO_SMALL) {
> +=09=09pr_err("Couldn't get size: 0x%lx\n", *status);
>   =09=09return NULL;
>   =09}
>  =20
> @@ -56,10 +58,10 @@ static __init void *get_cert_list(efi_char16_t *name,=
 efi_guid_t *guid,
>   =09if (!db)
>   =09=09return NULL;
>  =20
> -=09status =3D efi.get_variable(name, guid, NULL, &lsize, db);
> -=09if (status !=3D EFI_SUCCESS) {
> +=09*status =3D efi.get_variable(name, guid, NULL, &lsize, db);
> +=09if (*status !=3D EFI_SUCCESS) {
>   =09=09kfree(db);
> -=09=09pr_err("Error reading db var: 0x%lx\n", status);
> +=09=09pr_err("Error reading db var: 0x%lx\n", *status);
>   =09=09return NULL;
>   =09}
>  =20
> @@ -144,6 +146,7 @@ static int __init load_uefi_certs(void)
>   =09efi_guid_t mok_var =3D EFI_SHIM_LOCK_GUID;
>   =09void *db =3D NULL, *dbx =3D NULL, *mok =3D NULL;
>   =09unsigned long dbsize =3D 0, dbxsize =3D 0, moksize =3D 0;
> +=09efi_status_t status;
>   =09int rc =3D 0;
>  =20
>   =09if (!efi.get_variable)
> @@ -153,8 +156,8 @@ static int __init load_uefi_certs(void)
>   =09 * an error if we can't get them.
>   =09 */
>   =09if (!uefi_check_ignore_db()) {
> -=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize);
> -=09=09if (!db) {
> +=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize, &status);
> +=09=09if (!db && status !=3D EFI_NOT_FOUND) {
>   =09=09=09pr_err("MODSIGN: Couldn't get UEFI db list\n");
>   =09=09} else {
>   =09=09=09rc =3D parse_efi_signature_list("UEFI:db",
> @@ -166,8 +169,8 @@ static int __init load_uefi_certs(void)
>   =09=09}
>   =09}
>  =20
> -=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize);
> -=09if (!mok) {
> +=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
> +=09if (!mok && status !=3D EFI_NOT_FOUND) {
>   =09=09pr_info("Couldn't get UEFI MokListRT\n");
>   =09} else {
>   =09=09rc =3D parse_efi_signature_list("UEFI:MokListRT",

This means that if status =3D=3D EFI_NOT_FOUND we end up still
trying to parse the signature list, I guess that moksize =3D=3D 0
or some such is saving us here, but I believe that
this should really be:

=09if (!mok) {
=09=09if (status !=3D EFI_NOT_FOUND)
=09=09=09pr_info("Couldn't get UEFI MokListRT\n");
=09} else {
=09=09rc =3D parse_efi_signature_list("UEFI:MokListRT",

> @@ -177,8 +180,8 @@ static int __init load_uefi_certs(void)
>   =09=09kfree(mok);
>   =09}
>  =20
> -=09dbx =3D get_cert_list(L"dbx", &secure_var, &dbxsize);
> -=09if (!dbx) {
> +=09dbx =3D get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
> +=09if (!dbx && status !=3D EFI_NOT_FOUND) {
>   =09=09pr_info("Couldn't get UEFI dbx list\n");
>   =09} else {
>   =09=09rc =3D parse_efi_signature_list("UEFI:dbx",

Idem.

Regards,

Hans

