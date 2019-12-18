Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE736C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD324218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWOnSco1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfLRNBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:01:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35309 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLRNBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:01:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so958869plt.2;
        Wed, 18 Dec 2019 05:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZptkc+GxTuIJF+XEs6PYuaFq609ei0Ww4tW+wMvzUM=;
        b=QWOnSco1vUEci+FTu/ERgDd5ODTU1yRgJ5CFxyks7cwHl4SPTSh9BiEBSYQLctIy7R
         cRmFSdGo/gBlsCkZ1WJxCKDU5HyanPNu1/gD0TC6OLlNz3TBAgta8qVs/n1bSsBwpEA6
         mshJNtOTuralAKZB6982zhyzKUWGjIh8RlZILaaJ3eMDWu8fUggnpcLL2ubQBjbQFQwB
         HZ4ZPiBvqXI3wIkCkm7YcKINTxqm3Rdu9YM5HO8nWzzn3XQN5JvyfuPlzDUZmMRlvwEv
         r4bW1w+4UHmLAtrYhdH+ENS1Yn/ZDipN+quvGMFCSQXxWaskH1ljD71DSio+gNpJEcOm
         n+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZptkc+GxTuIJF+XEs6PYuaFq609ei0Ww4tW+wMvzUM=;
        b=uh3kjctHD5+/YoqgQkvxCBNuKAOVxfmZ6xSdpWQA7qOA7UYMIYeI6eDB44+tG4s4hu
         PtN39IPEGVlJJvcxJuqAR/85DrgpMgSQYVGti9hjHhQM7emZtpgKD89PZKi8wo+q5Y7d
         84E/QWbGI0GZw6HqI/1vgfw6LpvKa5KUBD5wxbQwjt/4uHVvjWG0MFDXfjcpHHdM0wwy
         vtZc8KvMOmFA03OcBUvT3EjpV5YDZ2D8gRTaKa6ZVmXwskPi5T/82e9/F7T5qocuQJFw
         oft+yKjWPIO77X1GG9xUGBbdcfsrOKhl6Z6oAuaIykdAfGc6DLAkwAej8fcYRtf7vWv3
         Bjig==
X-Gm-Message-State: APjAAAXPR9gl5cCc75cT8YfQV//OjePMQuEYpx8z8MD4FWXVcMmtv7Pg
        vM82caRgnZP56+c7Db04/2K+mNXn7zlqZGqk4Ek=
X-Google-Smtp-Source: APXvYqwFa1VVOox0bgLP/ZaV5eFPyn9nZy4cqLbzhsgajI+6QuOaRSW6NB+26LHIswhsE7DftaQPinQ0v/uyPNAg+vs=
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr2702457pjb.30.1576674069386;
 Wed, 18 Dec 2019 05:01:09 -0800 (PST)
MIME-Version: 1.0
References: <94727fab054309cd98c876748fd27b130ce5031f.1575918870.git.lsun@mellanox.com>
 <1576250484-27291-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <1576250484-27291-1-git-send-email-lsun@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Dec 2019 15:00:59 +0200
Message-ID: <CAHp75VfVL8fs_VXQgL85QPnW2N+zsLq4dWYkhs3xdMAjcfRgTg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/mellanox: fix the mlx-bootctl sysfs
To:     Liming Sun <lsun@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 5:21 PM Liming Sun <lsun@mellanox.com> wrote:

> +       ret = sysfs_create_group(&dev->kobj, &mlxbf_bootctl_group);
> +       if (ret) {
> +               dev_err(dev, "failed to create attributes, err=%d\n", ret);
> +               return ret;
> +       }
> +
>         /* Ensure we have the UUID we expect for this service. */
>         arm_smccc_smc(MLXBF_BOOTCTL_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0, &res);
>         guid_parse(mlxbf_bootctl_svc_uuid_str, &guid);
> @@ -305,8 +312,16 @@ static int mlxbf_bootctl_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int mlxbf_bootctl_remove(struct platform_device *pdev)
> +{
> +       sysfs_remove_group(&pdev->dev.kobj, &mlxbf_bootctl_group);
> +
> +       return 0;
> +}
> +
>  static struct platform_driver mlxbf_bootctl_driver = {
>         .probe = mlxbf_bootctl_probe,
> +       .remove = mlxbf_bootctl_remove,
>         .driver = {
>                 .name = "mlxbf-bootctl",
>                 .groups = mlxbf_bootctl_groups,

Please, use dev_groups member of the struct driver instead of above approach.

-- 
With Best Regards,
Andy Shevchenko
