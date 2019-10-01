Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B925C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 06:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C80C206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 06:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqWivwEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbfJAGPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 02:15:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51557 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731822AbfJAGPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 02:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569910529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RaDvnMbLxrkazX0FheBlc5k/BJaQuhfFQB7rxFi7w4I=;
        b=ZqWivwEFgytJTnDLm3QrdKUgTy1+7k0daqJQZewuKd4yNGK5volaB94zNTmWC5WOkPNceT
        hRcsr4teUOOrRAR3/CgDQ5flZZF4FM+d/9q0c6WoZXw27amUxGhD3Gyry3Iqe/PclM4GfG
        BXhyRRSThIIeDCdX2nuuVPcOz0s8Nhw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-C5Wr7pi_MYiQr1nE2jxiuQ-1; Tue, 01 Oct 2019 02:15:26 -0400
Received: by mail-ed1-f69.google.com with SMTP id h12so7888677eda.19
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 23:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GWWMZLIGumGHax9H0h3X9Y0A4H9SN5QPKJSfyEBYC5I=;
        b=Iqf7oz5U0CkX93W+Kd8EmhoLeHsWAZxmeI4ZEx5FmKe+mMpx3cIULeAUA6lmwhBzB7
         rDKQKagd8VFjO0N/G+t+bK8CO3O6xZ7jkFLtOhdSHMVmEG478xfbDuxg97/hxObxSR9v
         xsU04xNAJZ5s7se8X0X9r3zP0RdNBNRNculrQdK24Sx2hyLbQUYzGuqEWEXE2WCuJkUv
         9KsGsp7omgspDpUZUGi4JOjhlChJkqzw5EExJ5PXqN1kQA2mV3rQl55KTOjJlC4Va9YH
         vzpbxkJLtlPYJ2bUSgWIcyEL7M18jTJUU7j4fAQLObcAseQhT2CkaF3oKK+WusVVSLOI
         2glA==
X-Gm-Message-State: APjAAAWC1CgZSrcb2lTH6ZPJb8CkMmPHIvp1xQKe51p1R6YJHEiG1OPP
        4vz3EHxZO1/RSYXK6jqKohYeaz0BWTOx/gWr84/Yb4PAwFSzjs8kVVLLMjslfU+6ISEIUwSp9vd
        VqZ6ztzQuMIpbe+hfZtXaQ4BB
X-Received: by 2002:a17:907:441d:: with SMTP id om21mr23215420ejb.188.1569910525080;
        Mon, 30 Sep 2019 23:15:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0BznTJyAsTVjo5pCJTdBKgZR1znwvk5eXNetuzl3vkDGg/8PK5IbG/C1rmjBEH5WUMvACKw==
X-Received: by 2002:a17:907:441d:: with SMTP id om21mr23215406ejb.188.1569910524881;
        Mon, 30 Sep 2019 23:15:24 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id 36sm2921211edz.92.2019.09.30.23.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 23:15:24 -0700 (PDT)
Subject: Re: [PATCH v2] virt: vbox: fix memory leak in
 hgcm_call_preprocess_linaddr
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <664aab6a-37c9-7239-a817-25dfbab00c7f@redhat.com>
 <20190930204223.3660-1-navid.emamdoost@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <48a2ad9b-bcdb-6146-0911-37961e07b1d9@redhat.com>
Date:   Tue, 1 Oct 2019 08:15:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930204223.3660-1-navid.emamdoost@gmail.com>
Content-Language: en-US
X-MC-Unique: C5Wr7pi_MYiQr1nE2jxiuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-09-2019 22:42, Navid Emamdoost wrote:
> In hgcm_call_preprocess_linaddr memory is allocated for bounce_buf but
> is not released if copy_form_user fails. In order to prevent memory leak
> in case of failure, the assignment to bounce_buf_ret is moved before the
> error check. This way the allocated bounce_buf will be released by the
> caller.
>=20
> Fixes: 579db9d45cb4 ("virt: Add vboxguest VMMDEV communication code")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Thank you.

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/virt/vboxguest/vboxguest_utils.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vbox=
guest/vboxguest_utils.c
> index 75fd140b02ff..43c391626a00 100644
> --- a/drivers/virt/vboxguest/vboxguest_utils.c
> +++ b/drivers/virt/vboxguest/vboxguest_utils.c
> @@ -220,6 +220,8 @@ static int hgcm_call_preprocess_linaddr(
>   =09if (!bounce_buf)
>   =09=09return -ENOMEM;
>  =20
> +=09*bounce_buf_ret =3D bounce_buf;
> +
>   =09if (copy_in) {
>   =09=09ret =3D copy_from_user(bounce_buf, (void __user *)buf, len);
>   =09=09if (ret)
> @@ -228,7 +230,6 @@ static int hgcm_call_preprocess_linaddr(
>   =09=09memset(bounce_buf, 0, len);
>   =09}
>  =20
> -=09*bounce_buf_ret =3D bounce_buf;
>   =09hgcm_call_add_pagelist_size(bounce_buf, len, extra);
>   =09return 0;
>   }
>=20

