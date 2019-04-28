Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CBBC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82BA2064A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP7OsTV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfD1TxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 15:53:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45464 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfD1TxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 15:53:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id b3so9722725qtc.12;
        Sun, 28 Apr 2019 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ow0hOBCWNf9L4Sr2+kvBTmny91Rm+CzMXx0+dpHwDRU=;
        b=ZP7OsTV7OnO15ur8/sU+Vk4YTNDhi/gFAmnK2tuUeF9s+hZY9txYbrw5JydmT9L471
         ByHrvrG/OcyFjzqkFEiM0kcRuC0bEcdpb8hCYSc2lLPbyNiMem69tgyY5XHlYHwWw9tz
         ehzRrfKtU51Mna/DuGIie3Ora8+3utNt+BaTuJ6IjuV2Egv0tme9zPjWlXXYTtNypTQ1
         63H4dT2aaOySOywLwePW5IhvrqI02Gn5I0LReUYhXKB6JuWyhP1Zys5YFsv1sRMNrKrT
         K48z1BER14z1kkolRo6vK+yIxbmz/GorjCXF5LMhJ2Iv+ur7kQuSOIphH5NrbiMdMy1c
         r9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ow0hOBCWNf9L4Sr2+kvBTmny91Rm+CzMXx0+dpHwDRU=;
        b=isFtPsjfWYSnrHNj58XIey63tYfF18ys0pEL9TxPMzdOF1BYcZ+0CTyQ8OL5FKc+kC
         fNJjtVT/WebcG1oqJViEwVq9V9c+E/JTdv4NOsiRdpAcqX6VJOivGpoBDaOwkSx+UJVs
         QQW53STSG3xbTdE7mXhemhGT82P+lDdLM0/dNU6OJAgECIYgGnea32Lur2heJTTp5t9o
         oiGHLqvTWQRRL0uuJx1GKq4SPtikcs2LF8c3hcWuPNSVgFxw/Nk73G12C5/vZap30oDU
         ruCqPtu5zr2PrLIlJpv1e8OVqXVjXgx3kxTGdD2KqXDTePLfOqLeKyVXn8y31f0rVCZz
         vk/Q==
X-Gm-Message-State: APjAAAXk3k+kyQ6DK/Fj4skhTICYyM/lwyes6pcm2Q6Vd0LFUFL39vf9
        +MVMPnmk+rzlX49yJkVrSFlGDAHOtpAkQ9yh8QM=
X-Google-Smtp-Source: APXvYqxJr720rnkWKPkc5JGyrhBMI5hcbhWPbKEDFJnpuIfvysAHkAX22RM2cYKDtlTZpdNgzbezwC8Coh9r7/tQyxU=
X-Received: by 2002:ac8:25b8:: with SMTP id e53mr10755423qte.194.1556481201803;
 Sun, 28 Apr 2019 12:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190428104041.11262-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20190428104041.11262-1-lukas.bulwahn@gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sun, 28 Apr 2019 12:53:10 -0700
Message-ID: <CAPhsuW575DC_ME2nEHmQtGo11ksVQGzZzN3Awm9xXT9ho37Ggg@mail.gmail.com>
Subject: Re: [PATCH] md: properly lock and unlock in rdev_attr_store()
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Shaohua Li <shli@kernel.org>, Neil Brown <neilb@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Himanshu Jha <himanshujha199639@gmail.com>,
        clang-built-linux@googlegroups.com,
        linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 3:41 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> rdev_attr_store() should lock and unlock mddev->reconfig_mutex in a
> balanced way with mddev_lock() and mddev_unlock().
>
> But when rdev->mddev is NULL, rdev_attr_store() would try to unlock
> without locking before. Resolve this locking issue..
>
> This locking issue was detected with Clang Thread Safety Analyser:
>
> drivers/md/md.c:3393:3: warning: releasing mutex 'mddev->reconfig_mutex' that was not held [-Wthread-safety-analysis]
>                 mddev_unlock(mddev);
>                 ^
>
> This warning was reported after annotating mutex functions and
> mddev_lock() and mddev_unlock().
>
> Fixes: 27c529bb8e90 ("md: lock access to rdev attributes properly")
> Link: https://groups.google.com/d/topic/clang-built-linux/CvBiiQLB0H4/discussion
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Arnd, Neil, here a proposal to fix lock and unlocking asymmetry.
>
> I quite sure that if mddev is NULL, it should just return.

I think current code will just return -EBUSY when mddev is NULL, right?

Song


>
> I am still puzzled if the return value from mddev_lock() should be really
> return by rdev_attr_store() when it is not 0. But that was the behaviour
> before, so I will keep it that way.
>
>  drivers/md/md.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 05ffffb8b769..a9735d8f1e70 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -3384,7 +3384,9 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
>                 return -EIO;
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EACCES;
> -       rv = mddev ? mddev_lock(mddev): -EBUSY;
> +       if (!mddev)
> +               return -EBUSY;
> +       rv = mddev_lock(mddev);
>         if (!rv) {
>                 if (rdev->mddev == NULL)
>                         rv = -EBUSY;
> --
> 2.17.1
>
