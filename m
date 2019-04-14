Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61D1C282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2882084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKICTP/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfDNBEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 21:04:21 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54534 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDNBEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 21:04:20 -0400
Received: by mail-it1-f193.google.com with SMTP id a190so5159332ite.4;
        Sat, 13 Apr 2019 18:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TthJUdUqLVX4DpWSa0y1JjAzPtP4dPzxlxe7/SaEmIc=;
        b=LKICTP/38wl/Sp/1TYzEd7nP71dXLQ3IflknZ/B12pQHCRI8TTkY7vkFAz7GhJItiz
         k+ag1IkK1g0eRtAq9F47xpJqwOxrx/Ma3LfUtRj1V3M0V0JwmkcHMlZghOitdh8a4KhD
         z/KWO4D2lmuQqUdMQEDGbBhGRXpJ2Q4m39goXeOt2afAqKe+ZuJO6uQmxVoR/NrYmlaG
         wRA25yj4U/dR5xZXBVw9Jt74BlNvS5M3L4hnDlQSCUrMMv8193nhQP/CJ521uLHVWOF+
         7tUlSt/M8lXDWFS7p7Y0pvgxzTe2e8pHX7FdKcv1tQzFbEbCuOeAqZpz/NgZ8gzrAgr3
         +iUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TthJUdUqLVX4DpWSa0y1JjAzPtP4dPzxlxe7/SaEmIc=;
        b=Gw4e/1A677mMMsf5v6JRrXHGFk+IoBueUuKM7gEJTNTi29k7dsA732sdYCvOYV5VOw
         LXQMuCA7THX8Ub+n2fL7y5Kbt6f3fimWsIfF/nDR124rgtQvUz9qOjIp+Y/Gm4TQq4MJ
         lmCMYAX9PC2jhr7OhDvXdZydXe7uhvyvXoZ8Bt/d27/wgq8EONRnR4h/l1MSI8ebHn0w
         nU/2Gmf3W/a7Vr0Fvr7rChwRZU/qdjnwVLMlBsZgsk7ug8akqLWkDcDO0OeAvDzCKwYb
         7Ukftqc9dmaXP00LcucMpopnjPb45EskCw2fLmFaArSyGzeeI7cf8c9uPqArjc292xNC
         ByIw==
X-Gm-Message-State: APjAAAXFnzMR+QuH+DsqdnOX74O9arSCI1lLmOu791ic1UJnq2tul+W1
        ans2EGI615TQs3KKrVU/GFJFxhMC9Mei4r/i6wI=
X-Google-Smtp-Source: APXvYqzp685M9zKbP1qSVCXG3/eF5NXoS7N5dn3LGRQOSk7mAN/wmu+Tssi0N3i6b5ZUw5T3MP9WrAceZqqCcqz/8H4=
X-Received: by 2002:a24:9a86:: with SMTP id l128mr18553221ite.126.1555203859770;
 Sat, 13 Apr 2019 18:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190403070325.1077-1-andrew.smirnov@gmail.com>
 <20190403070325.1077-4-andrew.smirnov@gmail.com> <20190407120735.6fe78a5b@archlinux>
In-Reply-To: <20190407120735.6fe78a5b@archlinux>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sat, 13 Apr 2019 18:04:08 -0700
Message-ID: <CAHQ1cqEWCib3tOFAEy_iGj2RkM1VdLx78EPR_V2BPm_TmUjXbA@mail.gmail.com>
Subject: Re: [PATCH 3/6] iio: imx7d_adc: Use devm_iio_device_register()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 4:07 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed,  3 Apr 2019 00:03:22 -0700
> Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> > Use devm_iio_device_register() and drop explicit call to
> > iio_device_unregister().
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: linux-iio@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> No to this one.  The thing to think about is the resulting order
> of the unwinding that happens in remove.
>
> Do take a look at the code flow, but in short what happens is:
>
> 1. driver.remove()
> 2. Devm release functions run in the opposite order to they were
>    called during setup.
>
> The upshot of the change you just made here is that we turn the power
> off to the device before we remove the userspace interfaces, giving
> potentially interesting failures..
>
> There are two options to avoid this:
>
> 1. Make everything use devm_ calls (often using devm_add_action_or_reset
> for the ones that don't have their own versions).
>
> 2. Stop using devm managed functions at the first non devm_ call that needs
> unwinding.  From that point onwards in probe / remove you have to do everything
> manually.
>

Yeah, missed the ordering proble, sorry about that. I'll re-order
changes such that this conversion happens last to avoid said problem
in v2.

Thanks,
Andrey Smirnov
