Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F6BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857992133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554324877;
	bh=eIdJhARtDbQsSMGOl0+VyK9vQxyJt9OnI2DZG/S1G2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KIVXj9S/7RP2xv1HqKk8T8iE+BLlfVfX/qGMMLrBEEwzWAnh+XBIVujlpa3+nScv0
	 bOCKZr/tg6CI6xTTiEhXxvORyb/qfxmHYylcLx748yeIlI3JdyjVz19dd/LhZ1RGQz
	 7acrIsvLiurdo2MFvjqu98r0xsc1zXkE4eRZlW/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDCUyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:54:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41099 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCUyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:54:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so280136otb.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 13:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMNiQJpCYrgsSJq4y5K2SgmqoiP0YH+pXeQN305Fal8=;
        b=j9eYCbsrZS8M+dypggedBMIX5ZhxUmMqBdEjlqD50din7ID8YaXhzhms01ofgEecfa
         0QaxAbX6iD/cQn2otbmVAHu4ZNrTq2ioq0R93RqcQcqCOnEdkR4EXrwq6NNVN9GvhBWl
         cJwn2lnUoy3JbEGlF4no3G5WfydE+7makpnwqGTzQGIAPoHJYx3NX2skXiEWzz48sOcQ
         FfcVOHOnJyFJ5/L+Ow9q0NYfBWNHObPfPSYotwNs6R7bhGqGqBByfWBH6nglj3zQY6Ay
         Nwn9qm/OOXyO5sv62Y1GFX9xZC7caqTBzz5Ky7WSVBkIsg3Y9Ba7MfUEgqPw2X6S+qB/
         z+bQ==
X-Gm-Message-State: APjAAAX82qhwyFhWKiDR5BNrOozXBT3JUe0iiNFEy8jDJxxu0ow2XEEu
        Qw6ApzFHoy4gKBm8UXIv0JlVpCGJfgoHHlMUTog=
X-Google-Smtp-Source: APXvYqzsdpOLd5tyMa1zzmXpjZ8t/avhmb1tNr/Fw42nQqhPdVI0AtgrekWw567uRS1SSAXwlxHM0hAQQDzRD3m7Aus=
X-Received: by 2002:a9d:6646:: with SMTP id q6mr1410546otm.20.1554324874414;
 Wed, 03 Apr 2019 13:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190402155914.78166-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0hCrpyxJzMOQXthHkqLBaYBH44f_XsHy-YUfxxUU_o41w@mail.gmail.com> <20190403112923.GV9224@smile.fi.intel.com>
In-Reply-To: <20190403112923.GV9224@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Apr 2019 22:54:22 +0200
Message-ID: <CAJZ5v0hR_0Do+jv79wxA4BRgrUKDfes2K5gYud9-2SoWOOEf0g@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: platform: Propagate error from insert_resource()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 1:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 02, 2019 at 06:02:40PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 2, 2019 at 5:59 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Since insert_resource() might return an error we don't need
> > > to shadow its error code and would safely propagate to the user.
>
> > > -               if (p && insert_resource(p, r)) {
> > > +               if (p && (ret = insert_resource(p, r))) {
> >
> > I would put the assignment here.
> >
> > >                         dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
> > > -                       ret = -EBUSY;
> > >                         goto failed;
> > >                 }
>
> Something like this?

Yes.

> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index dab0a5abc391..9cf9e2af9efd 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -438,10 +438,12 @@ int platform_device_add(struct platform_device *pdev)
>                                 p = &ioport_resource;
>                 }
>
> -               if (p && insert_resource(p, r)) {
> -                       dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
> -                       ret = -EBUSY;
> -                       goto failed;
> +               if (p) {
> +                       ret = insert_resource(p, r);
> +                       if (ret) {
> +                               dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
> +                               goto failed;
> +                       }
>                 }
>         }
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
