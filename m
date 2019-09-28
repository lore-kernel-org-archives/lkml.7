Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8384BC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 09:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6A12082F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 09:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGHoJOmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfI1Jya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 05:54:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30629 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbfI1Jya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 05:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569664466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DdZFOFPdh8tpxXNy7VJ2reV39R3vNgvnQfC0/ZeicTU=;
        b=XGHoJOmg3P4MkxWQ/y7MMJcLhJI88ngCCYv0b/fzUTl+yHSYUl9yA8hWEKkvfoEKn4HsIC
        g4sVreqSooE+30oYkqg2WHOd6M69ukrP22kpNJrcwqQD0G1Ao2S0TD+89tfVw9YPfbMCla
        Fi+fCDpSQcbdankY0wvkmrKDTxjy0Nw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-trmue1KXNr-CC8dG9WzW6w-1; Sat, 28 Sep 2019 05:54:24 -0400
Received: by mail-ed1-f71.google.com with SMTP id s29so3148135eds.21
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 02:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nx7S+KLokIU61DJtpeyQwyl/k25Y1pZggOU8zFhK2cM=;
        b=pI8Ktan34cuDP8tHUOwpCkc6pBzed+A+C1nZe4aPb8F/Zuaa/pQY7rJ5D8R+9zp/8/
         JZ8PhErqnW0MqGdvsQrGC9M1NrQ9ngWImyJkTfjLiU7/KKXt7ArPMdVl5N9ZvbtgCyNo
         1gn+35GVw6B4ZILGpeVdw8WnleYFyT93A+wFmHpqsql5y7U8DIst6+U47mDKzEFSs+cG
         RwGG0dpJBmLtzA5Y41cSE4ewLSg4j/rn6ojUUO4iZzaCMpfgiDY+T6jTBSrbSabCjb4t
         pXX3Hvaffktwxv9+Al2XlvVD5iW0gMNsW19Y6Cvpr1zw3XhsvqSwYmnw9fPYAMA/x9bg
         dIUg==
X-Gm-Message-State: APjAAAUjvdujNjqneIjBTIab+PKV0XnAUF1Cytc/kZ5ZBKizkacnHHl/
        7XE+1GrGJJJPcbk6quswbr7xiLnsTtlUfkiKEE0Oe9iuud4Et8al0iaMyf0n+bx270VMB3K5vkZ
        TLuZujqwAjPYszC8mBdepVr42
X-Received: by 2002:aa7:d688:: with SMTP id d8mr9219288edr.156.1569664462882;
        Sat, 28 Sep 2019 02:54:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx1f2EVlnShNEl3nCCShNpo3IA1jC2mCubvlRrg0Sag+I4BaT2pjjNDD0AO3SrW5EAMOf84Cw==
X-Received: by 2002:aa7:d688:: with SMTP id d8mr9219264edr.156.1569664462597;
        Sat, 28 Sep 2019 02:54:22 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id a26sm1103792edm.45.2019.09.28.02.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2019 02:54:21 -0700 (PDT)
Subject: Re: [PATCH] virt: vbox: fix memory leak in
 hgcm_call_preprocess_linaddr
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190927230421.20837-1-navid.emamdoost@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3b5913e3-856a-db81-7708-929e62ee53d4@redhat.com>
Date:   Sat, 28 Sep 2019 11:54:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927230421.20837-1-navid.emamdoost@gmail.com>
Content-Language: en-US
X-MC-Unique: trmue1KXNr-CC8dG9WzW6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28-09-2019 01:04, Navid Emamdoost wrote:
> In hgcm_call_preprocess_linaddr memory is allocated for bounce_buf but
> is not released if copy_form_user fails. The release is added.
>=20
> Fixes: 579db9d45cb4 ("virt: Add vboxguest VMMDEV communication code")
>=20
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Thank you for catching this, I agree this is a bug, but I think we
can fix it in a cleaner way (see below).

> ---
>   drivers/virt/vboxguest/vboxguest_utils.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vbox=
guest/vboxguest_utils.c
> index 75fd140b02ff..7965885a50fa 100644
> --- a/drivers/virt/vboxguest/vboxguest_utils.c
> +++ b/drivers/virt/vboxguest/vboxguest_utils.c
> @@ -222,8 +222,10 @@ static int hgcm_call_preprocess_linaddr(
>  =20
>   =09if (copy_in) {
>   =09=09ret =3D copy_from_user(bounce_buf, (void __user *)buf, len);
> -=09=09if (ret)
> +=09=09if (ret) {
> +=09=09=09kvfree(bounce_buf);
>   =09=09=09return -EFAULT;
> +=09=09}
>   =09} else {
>   =09=09memset(bounce_buf, 0, len);
>   =09}
>=20

First let me quote some more of the function, pre leak fix, for context:

=09bounce_buf =3D kvmalloc(len, GFP_KERNEL);
=09if (!bounce_buf)
=09=09return -ENOMEM;

=09if (copy_in) {
=09=09ret =3D copy_from_user(bounce_buf, (void __user *)buf, len);
=09=09if (ret)
=09=09=09return -EFAULT;
=09} else {
=09=09memset(bounce_buf, 0, len);
=09}

=09*bounce_buf_ret =3D bounce_buf;

This function gets called repeatedly by hgcm_call_preprocess(), and the
caller of hgcm_call_preprocess() already takes care of freeing the
bounce bufs both on a (later) error and on success:

=09ret =3D hgcm_call_preprocess(parms, parm_count, &bounce_bufs, &size);
=09if (ret) {
=09=09/* Even on error bounce bufs may still have been allocated */
=09=09goto free_bounce_bufs;
=09}

=09...

free_bounce_bufs:
=09if (bounce_bufs) {
=09=09for (i =3D 0; i < parm_count; i++)
=09=09=09kvfree(bounce_bufs[i]);
=09=09kfree(bounce_bufs);
=09}

So we are already taking care of freeing bounce-bufs allocated for previous
parameters to the call (which me must do anyways), so a cleaner fix would
be to store the allocated bounce_buf in the bounce_bufs array before
doing the copy_from_user, then if copy_from_user fails it will be cleaned
up by the code at the free_bounce_bufs label.

IOW I believe it is better to fix this by changing the part of
hgcm_call_preprocess_linaddr I quoted to:

=09bounce_buf =3D kvmalloc(len, GFP_KERNEL);
=09if (!bounce_buf)
=09=09return -ENOMEM;

=09*bounce_buf_ret =3D bounce_buf;

=09if (copy_in) {
=09=09ret =3D copy_from_user(bounce_buf, (void __user *)buf, len);
=09=09if (ret)
=09=09=09return -EFAULT;
=09} else {
=09=09memset(bounce_buf, 0, len);
=09}

This should also fix the leak in IMHO is a clear way of doing so.

Regards,

Hans





