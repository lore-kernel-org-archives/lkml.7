Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3421CC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8AA222A2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cg87kGls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfKSLir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:38:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727529AbfKSLiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574163526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AkZlm6E02ulJgDlH0RkS2V1x/K8KjwOJZQWY1e0nQBw=;
        b=Cg87kGlsBXU4pxoAfwK7PPpMdgaNQQBhPYpRDn75x6PxcKS3J30KdUBiTaDDTrG0+7jApB
        Quff6Hv0Kf7BT/0CXgE3PJiO87a97Dhi0rFlQRm8p8M0SALJbdMBrcZF95f9M54f3MLDHh
        vDCFeRJiWmRk98gwSqvKiLwWLm7gYWc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-oSjfGxNsOq6QebmqwI-84g-1; Tue, 19 Nov 2019 06:38:43 -0500
Received: by mail-wr1-f70.google.com with SMTP id w4so18134141wro.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 03:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tBC89zQQD/AIZWQ54xzAZ6FCQSbLpsx+iUlFOBJT2jA=;
        b=SejpYG1++/hg1eE8Jebug6u7zNo+7sfM16d0LLSVBhqIp8v0nbguf6HkjpEyEjhPqY
         M6ELzON4EcQJLeycDD/rFbniDxespKYnc5sKgijQo8klOdSAhJ+jvjFkBdNLNuRAtQ7s
         nhTvXpEIznTkhbifHAT0ARyeWnD6NZfIQL6s2Q0txQbP80Dt4sQpgBjitumBotrLOGH0
         LBCFq+lvq6lLvwQTBKJ3AxHWxCClQg+D0xm3HaopdMq2pcMSEHVOYvK5N7OzFky0dsEq
         insXfWSlF/yJbz3h5rSzq9Szs4XgLA9x5dP+ZrmRNm/Y8CExKP4GWSlztsx2Ixg7vI+r
         TxOQ==
X-Gm-Message-State: APjAAAXu6NfxkyewrZrGEj9tYyQy9SyE8aIdwQl5LLvX5nInzVnAPOp3
        P9geRxeC6CQpoAzO1FKSgDlIf3N7MY8sGedxdG+f8aCHVDTkDtSANDyPZjakvGJeivjzXuDkAnb
        HNMVTcsRA2WAcUmz5uzLQUavY
X-Received: by 2002:adf:e885:: with SMTP id d5mr24089870wrm.117.1574163522130;
        Tue, 19 Nov 2019 03:38:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZB78L4BEdN+A/ezzjn+MXYfPdVZVxSGjlhlq0u9QUcjy76IGgeH4QcXH1TAhBJC+onn5fTw==
X-Received: by 2002:adf:e885:: with SMTP id d5mr24089844wrm.117.1574163521897;
        Tue, 19 Nov 2019 03:38:41 -0800 (PST)
Received: from [192.168.1.14] ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id d20sm29937766wra.4.2019.11.19.03.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 03:38:41 -0800 (PST)
Subject: Re: [PATCH] efi: Only print errors about failing to get certs if EFI
 vars are found
To:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
References: <20191119091822.276265-1-javierm@redhat.com>
 <71e319d0-5fa9-f464-8546-b51629ae4ab3@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <c021654a-8d34-b34b-098b-b7622e7b0b39@redhat.com>
Date:   Tue, 19 Nov 2019 12:38:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <71e319d0-5fa9-f464-8546-b51629ae4ab3@redhat.com>
Content-Language: en-US
X-MC-Unique: oSjfGxNsOq6QebmqwI-84g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans,

Thanks a lot for your feedback.

On 11/19/19 11:59 AM, Hans de Goede wrote:
> Hi,
>=20
> On 19-11-2019 10:18, Javier Martinez Canillas wrote:
>> If CONFIG_LOAD_UEFI_KEYS is enabled, the kernel attempts to load the cer=
ts
>> from the db, dbx and MokListRT EFI variables into the appropriate keyrin=
gs.
>>
>> But it just assumes that the variables will be present and prints an err=
or
>> if the certs can't be loaded, even when is possible that the variables m=
ay
>> not exist. For example the MokListRT variable will only be present if sh=
im
>> is used.
>>
>> So only print an error message about failing to get the certs list from =
an
>> EFI variable if this is found. Otherwise these printed errors just pollu=
te
>> the kernel ring buffer with confusing messages like the following:
>>
>> [    5.427251] Couldn't get size: 0x800000000000000e
>> [    5.427261] MODSIGN: Couldn't get UEFI db list
>> [    5.428012] Couldn't get size: 0x800000000000000e
>> [    5.428023] Couldn't get UEFI MokListRT
>>
>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>=20
> Thanks for this, I just noticed a potential issue which I missed
> when you send this to me for testing:
>=20

[snip]

>>  =20
>>   =09if (!efi.get_variable)
>> @@ -153,8 +156,8 @@ static int __init load_uefi_certs(void)
>>   =09 * an error if we can't get them.
>>   =09 */
>>   =09if (!uefi_check_ignore_db()) {
>> -=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize);
>> -=09=09if (!db) {
>> +=09=09db =3D get_cert_list(L"db", &secure_var, &dbsize, &status);
>> +=09=09if (!db && status !=3D EFI_NOT_FOUND) {
>>   =09=09=09pr_err("MODSIGN: Couldn't get UEFI db list\n");
>>   =09=09} else {
>>   =09=09=09rc =3D parse_efi_signature_list("UEFI:db",

You are correct, this is another instance of the same issue that you mentio=
ned.

>> @@ -166,8 +169,8 @@ static int __init load_uefi_certs(void)
>>   =09=09}
>>   =09}
>>  =20
>> -=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize);
>> -=09if (!mok) {
>> +=09mok =3D get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
>> +=09if (!mok && status !=3D EFI_NOT_FOUND) {
>>   =09=09pr_info("Couldn't get UEFI MokListRT\n");
>>   =09} else {
>>   =09=09rc =3D parse_efi_signature_list("UEFI:MokListRT",
>=20
> This means that if status =3D=3D EFI_NOT_FOUND we end up still
> trying to parse the signature list, I guess that moksize =3D=3D 0
> or some such is saving us here, but I believe that
> this should really be:
>=20
> =09if (!mok) {
> =09=09if (status !=3D EFI_NOT_FOUND)
> =09=09=09pr_info("Couldn't get UEFI MokListRT\n");
> =09} else {
> =09=09rc =3D parse_efi_signature_list("UEFI:MokListRT",
>=20

Agreed. I'll fix the issues and post a v2. Since we are adding these statem=
ents,
I could also print debug messages for the case that status =3D=3D EFI_NOT_F=
OUND.

Best regards,
--=20
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat

