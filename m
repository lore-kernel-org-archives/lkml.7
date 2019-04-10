Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7B4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C71220674
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RWh6gChL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfDJHua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:50:30 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39413 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfDJHua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:50:30 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so1845489ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8YCZt4uI2tD+pDH/cW0KsRsRlGc9ugKR7IFDGw7nEzc=;
        b=RWh6gChL+BJGe+YahAg/zUe/pXeHrrY8x38P0ehT2eEhGl+TcyMHS1zOTe5ybRSiYE
         6erFiBZ7n5h8OEONsz/WQCpay5HfkXyt7vCZ9cVUlILAwpayQTQK1vPhEpbNHUhj/XSf
         T2RX81VTLKhk0Bj95VI7bbvI5UQkuBnZYhiAoJmfmfC7cs6pTRgm2yhnUFAbTaQ/xRPm
         g/MIVdyX0TbLlbAfegdkn+2TOyJb1n0lcJk4M5RKpyPFfYfG/ZxtO9tLrJ8vzFdgJTGS
         +3M4COOntO2ELHK21mbl2JDQoZO1MykRdpGh4ZDyFwQS0zOBdffztOArNK3TON5clD9R
         zsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8YCZt4uI2tD+pDH/cW0KsRsRlGc9ugKR7IFDGw7nEzc=;
        b=EQlvt697N08ArRpdM4o0wRwWvi/Ez17RumYnu5BFov/dGXtQFMfx43u88At8HTFLdJ
         aissR/NiSFTlHLEbd20vP7UY9AVfcp3LZF4+q2n3cQgy0ha/rQaZ2uOAP1EMLutQb3Bp
         +Bh0spgg/O/ixf1gThSCpN29qNpdDqjlL9i84j6sskp1fiXHOhgcNQwh0NNvEf3e5GKV
         SeFnTIqtT7CYo9ASQuoTfPLl9yMDvQU6dy/eX6RQ8p+pSGjtU/+WiCBYHP7mSdhP5YnW
         KA/ocGd0eEyWb3eOUdMeIcm9cP0PR3ZMFLiT/fej/pUGwkHO9phmOIspxAcj9LiGppoY
         rFuQ==
X-Gm-Message-State: APjAAAVTYlKbaOntEuSB++PBF42Oyhq7ByUQ9+KtGiCoIDZ1ieZPfgoB
        69XZ353bPZyZjd95JLcVOaRzUlMnYPX/rszV6fri5Q==
X-Google-Smtp-Source: APXvYqxdMMicCioRYbQvSZWiaNjNItG72ZXoIcNH1hc6PofzEb6WvaaFmDUBjScZWms7mpgDSeIEIuX4ZZr11J2w6eM=
X-Received: by 2002:a02:b053:: with SMTP id q19mr29975545jah.21.1554882629225;
 Wed, 10 Apr 2019 00:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190401081635.18673-1-brgl@bgdev.pl> <29cb0f74-672a-56f3-6e85-82f7e2a99ddf@codeaurora.org>
In-Reply-To: <29cb0f74-672a-56f3-6e85-82f7e2a99ddf@codeaurora.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 10 Apr 2019 09:50:18 +0200
Message-ID: <CAMRc=MdK-d-A=-eJWNktTX41PMx1AC=9GvGHOg3vytdaxmf9YA@mail.gmail.com>
Subject: Re: [PATCH] drivers: fix a typo in the kernel doc for devm_platform_ioremap_resource()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mukesh Ojha <mojha@codeaurora.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 1 kwi 2019 o 12:23 Mukesh Ojha <mojha@codeaurora.org> napisa=C5=82(a)=
:
>
>
> On 4/1/2019 1:46 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > It should have been 'management' not 'managemend'.
> >
> > Fixes: 7945f929f1a7 ("drivers: provide devm_platform_ioremap_resource()=
")
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   drivers/base/platform.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index dab0a5abc391..09c00d91094c 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -84,7 +84,7 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
> >    *                              device
> >    *
> >    * @pdev: platform device to use both for memory resource lookup as w=
ell as
> > - *        resource managemend
> > + *        resource management
>
>
> :-)
>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>
> Cheers,
> -Mukesh
>
> >    * @index: resource index
> >    */
> >   #ifdef CONFIG_HAS_IOMEM

Hi Greg,

can you pick this one up into your tree?

Thanks in advance,
Bartosz
