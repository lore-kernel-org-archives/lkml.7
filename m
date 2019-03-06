Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CF9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1D520663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="un5XrjC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfCFR2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:28:45 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46815 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfCFR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:28:44 -0500
Received: by mail-yw1-f66.google.com with SMTP id n12so10625676ywn.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpuLNU2Kuec6CYG2jcXVc/5+sYpINIjuPXPul/4MwGI=;
        b=un5XrjC5oPNUb99gN5qDnHU/FiBgsnQ5briB0mcxtM/Ob+T4Q0W91XSjLWmCXFATIW
         FqMAs5hKrInYdxgSJh+zyAJbyGz2HObY1HdBT5Def5cHuAhtUrEBRM+W14zqu5Kf75Ga
         Ff/dzd5jaGahn+1Mj6LZEfyra02COr+fS+5atSq3ZFQLx9JcD2lPabIFtnGDVmn05963
         nxWvvI68JH6DGKRsUgQQ9IF5sFW88+21vP5ydRRBlOJmMjBVibD9ARsM3IdDfVybrIEw
         ThQ4qaqzLigZl9y7//GhCJSR9kIRNoo68tP7Zwp+MytflJJzk1ESku1LtbfERnjQSyhs
         N2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpuLNU2Kuec6CYG2jcXVc/5+sYpINIjuPXPul/4MwGI=;
        b=Z3HE2uB9FM5Mh0aujmMhPGsSTZUqttjAww21b5Z1l2HVmHBs3fyNSLA5kKkaXNanCF
         BFiU44oZDAJ/dxuqmE0KTzX/qQsIyrIFzgs9ORxPDSib+Fz25W1EryEEHrrHBRnh41m+
         zbBF1ZZ1abjzZ4x9XE1KgIPN5HifAXZurUVvu4UzcdCoeiek/hERLZMxYDjE5t1Lfb6m
         ulh3k+DJ8v2KmlkuSu0pNp207jg6NBp7WZm/+PLjdQvYrgxGT0ob1EhDxW1G1FKwy/vV
         GVT+D07Q32hBfXBCuGa6i8WprX3IfnyPmkDIoSlZuLJurVDgDsr9+JF9sCY/yQttd9AM
         e5EA==
X-Gm-Message-State: APjAAAW1T3RFeOu9YaMkBpCvLAdHY5abVYiN87mB+4OKh+vqBCyjwiF4
        cidUQuNVbIeNsCJ3cwaDpQKFKWNbwqGoHkmaLHYsDA==
X-Google-Smtp-Source: APXvYqyyeA2+Cm4bXd0ODcR59c+cSaKJ5kh1RrLInpl3Q3r7AAOsq8IIhWFrGvSYQKshIqJNsu9H9esVm00FTsU0c40=
X-Received: by 2002:a81:5987:: with SMTP id n129mr6417958ywb.95.1551893323782;
 Wed, 06 Mar 2019 09:28:43 -0800 (PST)
MIME-Version: 1.0
References: <CADYN=9KkjPSP4KJ+AzG=Njq49zJ5fbWNZ4V_jOvHkq_kt0biyA@mail.gmail.com>
 <20190304153714.GD13452@kadam>
In-Reply-To: <20190304153714.GD13452@kadam>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 6 Mar 2019 18:28:33 +0100
Message-ID: <CADYN=9+9UrN9R=M5ode43ZkebaDrm8a9m5t1eyAmR+wNhWypMA@mail.gmail.com>
Subject: Re: BUG: KASAN: i2c dev use after free
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     erico.nunes@datacom.ind.br, wsa@the-dreams.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2019 at 16:37, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> I wasn't trying to fix anything so complicated as this, it was a
> more obvious use after free.  It does feel intuitively that we should
> call device_destroy() before the cdev_del() so that it's in the reverse
> order from how it was allocated but I don't see any reason to think
> that will make a difference.

No that didn't make any difference... =/

>
> ---
>  drivers/i2c/i2c-dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index 3f7b9af11137..7e85e2cf26c1 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -687,9 +687,9 @@ static int i2cdev_detach_adapter(struct device *dev, void *dummy)
>         if (!i2c_dev) /* attach_adapter must have failed */
>                 return 0;
>
> +       device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
>         cdev_del(&i2c_dev->cdev);
>         put_i2c_dev(i2c_dev);
> -       device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
>
>         pr_debug("i2c-dev: adapter [%s] unregistered\n", adap->name);
>         return 0;
> --
> 2.17.1
>
