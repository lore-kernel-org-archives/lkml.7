Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F962CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE50214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571762145;
	bh=DCWmZjJdn7DooparwAkurAchNPVcMkg3d42UECqiouU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PvBig8EOedumCJ6YTVJRtYhNhmYQbYE1lUODXqZp/QZJDuX1oo2DjkbQPb/64xBAz
	 Md66Kx7Kt9hNQGalGQ5UE/P3w1NkEQyXlzpVDyyDkCT9LfUOjfRyyIZrHMAOtYQE+A
	 8Sbi0JpZuAdP4qx1MS1wGsQLGvHPNBjuP0STG9SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbfJVQfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:35:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37434 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJVQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:35:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id 53so3139983otv.4;
        Tue, 22 Oct 2019 09:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZAk62VktTsx+Ob5O9T/IcWukBxIKCSIlZ2KMfpKjSc=;
        b=Tq4KtB0FuMuoXmcUzSundCvbSJdQdrRbgdQQQDuSY6CoyeUiVeFxew5RMZl1dEt7n4
         SOo27ORB/aukXzehw0h/Xof7eu/iBlt8LuspsyTaQO0gkzmmd8D3iEtBbAl6CkQjbCC/
         wm4Sfg35sZhYOXYLrXLKmGRQXSeTPfxSZhXmwveV8wOjt52DBjAulV1pJllMJ+6QHsqy
         mWLflW0VWNJHoTQhLs86iP4TJj2NKgqKAk5/q7MCtkKP6UbwpCaEGrdEYDVVbui8Ix6K
         r3YQ41reM9wVWZdVFAjBa2gTkti+IbBm5aefJFNRYp5jda1Kw2O1Tjy7OjsQHrpIAJlR
         AoSg==
X-Gm-Message-State: APjAAAUgkZX3ljNkwdCUc5bo76sp4dLNLeiCmzpJzpa7D7twD2qz1P9k
        VxBj2G/xH5G3EalSYYTwzzisYHi85bCzFl4nUMk=
X-Google-Smtp-Source: APXvYqyiUYppacOkbJofxp7QuUJl+cq2qZ0YPjnNVSiXTq67WvH+Mf7/GyLi7Db/N96lB5giKe21wKkj3mnO9yuE0Fc=
X-Received: by 2002:a9d:5907:: with SMTP id t7mr3368476oth.118.1571762142513;
 Tue, 22 Oct 2019 09:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <1570927586-12023-1-git-send-email-zhenzhong.duan@oracle.com>
In-Reply-To: <1570927586-12023-1-git-send-email-zhenzhong.duan@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Oct 2019 18:35:31 +0200
Message-ID: <CAJZ5v0iaWxu1vL08zyEfx6_Eku9yK5kh-HK4ZdbBtqZvSVd6tw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: not unset the driver if it already exist
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 2:43 AM Zhenzhong Duan
<zhenzhong.duan@oracle.com> wrote:
>
> __cpuidle_set_driver() check if there is an already exist driver and
> unset it before return with -EBUSY. The next call will succeed as it's
> just unset. This is strange as we should either keep old driver and
> return -EBUSY or unset and set new driver and return 0.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  drivers/cpuidle/driver.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 80c1a83..a200304 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -74,7 +74,6 @@ static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>         for_each_cpu(cpu, drv->cpumask) {
>
>                 if (__cpuidle_get_cpu_driver(cpu)) {
> -                       __cpuidle_unset_driver(drv);
>                         return -EBUSY;
>                 }

There is a bug here, but it needs to be fixed differently.

The function should check if any of the CPUs in the mask have a driver
(which is different from drv) already and if so return -EBUSY before
updating any cpuidle_drivers per-CPU pointers.
