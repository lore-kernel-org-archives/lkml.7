Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0168BC4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DD521971
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A535mhzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbfIWJHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:07:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34837 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727392AbfIWJHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569229661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T8T8RjJYcGGqEc0WFaCwZbXoPKLFlizfkrKrigbsteU=;
        b=A535mhzS3PlFDWKRvfzViQAeeoRcUXJ7n9ERbVNRp/m9N7IvJDcZwVLcMwS1RDuE6YIs9P
        NiHZ6raC5AmQcTY8b+MBDpP2sJiTOvsd2JcPo9bSlO4kiH1LvZ8dkCMVKFUyIB67kIarCd
        4qzghlZ6/ROt3jCY1xkgW+2RKhwa+bQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-vslaCADiPbCjmOoldbpv0w-1; Mon, 23 Sep 2019 05:07:40 -0400
Received: by mail-ed1-f72.google.com with SMTP id k5so5632573edx.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 02:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z5+JUdEcNbNbYnUHKbmarfCuTHHHOe0SmXNsWUScQrU=;
        b=lafCcVnApHCQLDiQ8QDR7YrMZ9Zgbpe8W5qZAJjo1jA/ORTyaOFioQwd7HxLNeG+xw
         VOT6x+D4nmBw0DF4iNRJEpv9oS30BnYm2ay/qllD3c083ou1eJq+78pe3aafgs9GebSo
         o4f0a0T43p9jx7ucFrq5u2JaPZhBc2nCWYYvHrklv+iXkhGRf9Zr5niStjPItd+erzO4
         zQQHEH9VUQjf3cEB/AwhQZMThOd6yFIpZ8yhCS/gSggGuxN2BJePXCiUfKylz9x0wM/2
         Exwy0tQUfA119aLhhEUFFLD/JqPu0OgQHy5YB/wb+uO6tchZv3yV66mvMH3DtumDQuIq
         NaKw==
X-Gm-Message-State: APjAAAV36mbr2xoCqM79MkX51avq65C1TxYZj20HLPkBL5I4Vp55vNeL
        plYIGP92SgJB2sLK26Dhnkf7CDPzR7wrvUCKzjNcFFE+gDi1F8xqnI9EPtXW0XJ0pjcUcBhYUei
        Hi4BUmFDu8fE8JLsnjYVWhati
X-Received: by 2002:a50:fc0c:: with SMTP id i12mr34693069edr.82.1569229659513;
        Mon, 23 Sep 2019 02:07:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCzq+l6MJPGlCUee90zOAQDFcFCUx0OtBxlJM4Nzjg7r/Nu6TdCyo4uiEsmUp7Cb5ztI+lUw==
X-Received: by 2002:a50:fc0c:: with SMTP id i12mr34693051edr.82.1569229659394;
        Mon, 23 Sep 2019 02:07:39 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s16sm2244451edd.39.2019.09.23.02.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 02:07:38 -0700 (PDT)
Subject: Re: [PATCH] ata: libahci_platform: Use common error handling code in
 ahci_platform_get_resources()
To:     Markus Elfring <Markus.Elfring@web.de>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <6ca97aeb-0892-ed0e-a149-b25848adf324@web.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7463a1d5-e76f-99a6-5a1e-f9477da3c1da@redhat.com>
Date:   Mon, 23 Sep 2019 11:07:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <6ca97aeb-0892-ed0e-a149-b25848adf324@web.de>
Content-Language: en-US
X-MC-Unique: vslaCADiPbCjmOoldbpv0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22-09-2019 15:55, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Sep 2019 15:42:46 +0200
>=20
> Convert the call of the function =E2=80=9Cof_node_put=E2=80=9D to another=
 jump target
> so that it can be better reused at three places in this function.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/ata/libahci_platform.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platfor=
m.c
> index e742780950de..7b2e364f3bd5 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -497,8 +497,7 @@ struct ahci_host_priv *ahci_platform_get_resources(st=
ruct platform_device *pdev,
>=20
>   =09=09=09if (of_property_read_u32(child, "reg", &port)) {
>   =09=09=09=09rc =3D -EINVAL;
> -=09=09=09=09of_node_put(child);
> -=09=09=09=09goto err_out;
> +=09=09=09=09goto err_put_node;
>   =09=09=09}
>=20
>   =09=09=09if (port >=3D hpriv->nports) {
> @@ -515,18 +514,14 @@ struct ahci_host_priv *ahci_platform_get_resources(=
struct platform_device *pdev,
>   =09=09=09if (port_dev) {
>   =09=09=09=09rc =3D ahci_platform_get_regulator(hpriv, port,
>   =09=09=09=09=09=09=09=09&port_dev->dev);
> -=09=09=09=09if (rc =3D=3D -EPROBE_DEFER) {
> -=09=09=09=09=09of_node_put(child);
> -=09=09=09=09=09goto err_out;
> -=09=09=09=09}
> +=09=09=09=09if (rc =3D=3D -EPROBE_DEFER)
> +=09=09=09=09=09goto err_put_node;
>   =09=09=09}
>   #endif
>=20
>   =09=09=09rc =3D ahci_platform_get_phy(hpriv, port, dev, child);
> -=09=09=09if (rc) {
> -=09=09=09=09of_node_put(child);
> -=09=09=09=09goto err_out;
> -=09=09=09}
> +=09=09=09if (rc)
> +=09=09=09=09goto err_put_node;
>=20
>   =09=09=09enabled_ports++;
>   =09=09}
> @@ -558,6 +553,8 @@ struct ahci_host_priv *ahci_platform_get_resources(st=
ruct platform_device *pdev,
>   =09devres_remove_group(dev, NULL);
>   =09return hpriv;
>=20
> +err_put_node:
> +=09of_node_put(child);
>   err_out:
>   =09devres_release_group(dev, NULL);
>   =09return ERR_PTR(rc);
> --
> 2.23.0
>=20

