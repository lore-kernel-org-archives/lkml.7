Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1327C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894DC20878
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zxl2RCMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKSILU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:11:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58148 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726980AbfKSILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 03:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574151079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYpGRqlZ79gShGcxr9nZMiDNSw56rOuWXuGDiw1tjtA=;
        b=Zxl2RCMJQVSUSyXv2F7ti1Q8IGtLPjaZwnbOy9BkQWC+2lhcHvfaEY9AVriyVomyn/zeOG
        fWBnAcU6rwYlm8NiwStn/t9r2nZtXIAptV7QnmLA+pR4fCxLRiU+WeCb8nlDP/r0VwmE3E
        imo67bY7xT97YXk3cgyZdnpylTTnFDA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-n6iUxUVqNeSlZj1pmddBpg-1; Tue, 19 Nov 2019 03:11:15 -0500
Received: by mail-wr1-f70.google.com with SMTP id h7so17902846wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 00:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TbCjg00ROYqbcfn2fYTagiY6x5F8HKQPvmZOtUZA9LU=;
        b=V35SW2GPRVK7+bJBHShEPujx/7bDxdwH3E61aDiKiVRojgsJcUulJcWhJY8QTDhbsB
         znIAoOs6OepXXg2eYZYZ/H1lmwnXXTuhxkO1d1ip10+yNp+9NQ4SObV+N/qAjYww11/o
         2gTjqjtSVDmGdDGK8tpr2VyUOsBOkrNW2NFX2glEt4ofH0TP+HtQ0Xl+1o23KFUMhLVU
         9KwTC79idSHEzOo5/FLrsTcOyEqbOVU54nemi+JH3MYiTssTrBuZ2FA/KoWKoW40Po4L
         2yYPmQ2HioTiXs1vUbFuhCNIEOOKiayLWjD+VzYUFgmwKYbv1E/0NVWHNrJQK6R0dPKt
         5Drw==
X-Gm-Message-State: APjAAAW18Z4RBBQm9JthVX3vk07hNCLO30uJCfwQ++1SplvzBiXczo1v
        /q+GquEFfGiEeyUOS8DnbbvNJ9bPbFP2h8jXDjkwjdsDDciDX9wjrzA/0lf+WrIBz9Cc1y8kgq0
        Xzt8iPDuYm5wp2/MW8vhJ6yVG
X-Received: by 2002:a5d:51c9:: with SMTP id n9mr18635222wrv.6.1574151074702;
        Tue, 19 Nov 2019 00:11:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1WdmEcZgq8Ru42cFxmubo9c0srM3mEX5+ycGUtl1ZXlAfcMSdDjHH7HPd2t/AWy6rw2SZ+w==
X-Received: by 2002:a5d:51c9:: with SMTP id n9mr18635200wrv.6.1574151074490;
        Tue, 19 Nov 2019 00:11:14 -0800 (PST)
Received: from steredhat.homenet.telecomitalia.it (a-nu5-32.tin.it. [212.216.181.31])
        by smtp.gmail.com with ESMTPSA id y2sm2318028wmy.2.2019.11.19.00.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 00:11:13 -0800 (PST)
Date:   Tue, 19 Nov 2019 09:11:11 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Mao Wenan <maowenan@huawei.com>, netdev@vger.kernel.org,
        davem@davemloft.net
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, alexios.zavras@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] vsock/vmci: make vmci_vsock_cb_host_called static
Message-ID: <20191119081111.gz2adojvsdcukvwk@steredhat.homenet.telecomitalia.it>
References: <20191119032534.52090-1-maowenan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20191119032534.52090-1-maowenan@huawei.com>
X-MC-Unique: n6iUxUVqNeSlZj1pmddBpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 11:25:34AM +0800, Mao Wenan wrote:
> When using make C=3D2 drivers/misc/vmw_vmci/vmci_driver.o
> to compile, below warning can be seen:
> drivers/misc/vmw_vmci/vmci_driver.c:33:6: warning:
> symbol 'vmci_vsock_cb_host_called' was not declared. Should it be static?
>=20
> This patch make symbol vmci_vsock_cb_host_called static.
>=20
> Fixes: b1bba80a4376 ("vsock/vmci: register vmci_transport only when VMCI =
guest/host are active")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/misc/vmw_vmci/vmci_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/=
vmci_driver.c
> index 95fed46..cbb706d 100644
> --- a/drivers/misc/vmw_vmci/vmci_driver.c
> +++ b/drivers/misc/vmw_vmci/vmci_driver.c
> @@ -30,7 +30,7 @@ static bool vmci_host_personality_initialized;
> =20
>  static DEFINE_MUTEX(vmci_vsock_mutex); /* protects vmci_vsock_transport_=
cb */
>  static vmci_vsock_cb vmci_vsock_transport_cb;
> -bool vmci_vsock_cb_host_called;
> +static bool vmci_vsock_cb_host_called;
> =20
>  /*
>   * vmci_get_context_id() - Gets the current context ID.
> --=20
> 2.7.4
>=20

Same patch already sent by "kbuild test robot" <lkp@intel.com>
https://lkml.org/lkml/2019/11/18/609

If we want to merge this, maybe we can also add:
Reported-by: kbuild test robot <lkp@intel.com>

Anyway, it is my fault:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

