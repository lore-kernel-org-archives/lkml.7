Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35893C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005C4206D9
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVXLRxQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfKQOW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 09:22:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41638 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfKQOW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 09:22:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id 94so12189335oty.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 06:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBBWYG/+c5ldPryHsf5eFGeS1K4sMEdoNycmM/BbPSs=;
        b=eVXLRxQuz/44ibheIO1zBi5Zd82/vwRtZvSJD8oQhmt2N/MJKJxuk3mbOogtVtPOdC
         sNPpD/RqzFELI0IHUxQjqsOEEBj7jWOPI0pyy+9bUClF0EiyXOEFew0fKsItQ5HKg+YF
         YrZr2GVvndUbsjQsk6+ug1ZFaNyqt+6C3YZtXfQfvLWHNFSavV1xLMli6fDg7CnNhMZz
         6eqCxy56Hvs4889Y+ya4/BxzxsfuyysdK2mTS/bo7gKchr0efYbVAEsX4tW4B0M8fm7/
         u3Pu4A9o3PqoT73GNjO43SrYuCw0EqGBY9uha6GxjU1wavNGrxxt9lzT9RSa5KY/3BpE
         Upcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBBWYG/+c5ldPryHsf5eFGeS1K4sMEdoNycmM/BbPSs=;
        b=r4u0hC3ptTX8wW/+oVfEYnusO4ok0iEqFudMfdDfUmGb0DjSFHEVdAW6DP/V2DUF5Q
         wvAwpOFTeg/EyA2ztUtJXb8P0lOzgIjZXlwcZi5t5abjBrRsoCbQQkm/+dVaKt8FXMR5
         qzSdJQFuegKi/QLqkCyEiZYcey3m0ABQXz0P3DmubM0Pa7u1uPCJLa5uQa+ZdeI0wcAO
         2vEC4ZFL385IbItz+6hEz3Nvvcq2aWU4IgCre3bmviZEXCixxkRE7EaZbPyheXVA+Oz5
         LL66n2hxCTYwjlyy+n0R8e7KfKZ1e9E0iFRWcwVKXVzbOnCfzY3jziy5LkNFr70nJMOd
         NhZg==
X-Gm-Message-State: APjAAAW1e1DQaldv/6Nm4IhzQrTsznp9F9Oga1vcXuArSDQWNlJ3zN1y
        7UqepX/CuN/CMvz0HqdurTyGYU193neGq7N+QuBlNw==
X-Google-Smtp-Source: APXvYqzse67pl4kqu/siCg0wumffzj5GbqEiS5VUx5pi2k8HHFVyi+mrwc9OoyE2LcCldd3coboHUuNiy3JdCrimPUI=
X-Received: by 2002:a05:6830:2371:: with SMTP id r17mr19318806oth.324.1574000546502;
 Sun, 17 Nov 2019 06:22:26 -0800 (PST)
MIME-Version: 1.0
References: <20191115105353.GA26176@jax> <20191116234048.oas2rlfwxlz65jvp@localhost>
In-Reply-To: <20191116234048.oas2rlfwxlz65jvp@localhost>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Sun, 17 Nov 2019 15:22:12 +0100
Message-ID: <CAHUa44EQ-1SUd0dDBp43_EGPMPArq_g8=1hSKZ3EC0uELUKH_A@mail.gmail.com>
Subject: Re: [GIT PULL] tee subsys fixes for v5.4 (take two)
To:     Olof Johansson <olof@lixom.net>
Cc:     arm-soc <arm@kernel.org>, soc@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 12:45 AM Olof Johansson <olof@lixom.net> wrote:
>
> On Fri, Nov 15, 2019 at 11:53:53AM +0100, Jens Wiklander wrote:
> > Hello arm-soc maintainers,
> >
> > Please pull these OP-TEE driver fixes. There's one user-after-free issue if
> > in the error handling path when the OP-TEE driver is initializing. There's
> > also one fix to to register dynamically allocated shared memory needed by
> > kernel clients communicating with secure world via memory references.
> >
> > "tee: optee: Fix dynamic shm pool allocations" is now from version 2 which
> > includes a fix up with a small but vital dependency.
> >
> > If you think it's too late for v5.4 please queue this for v5.5 instead.
>
> Hi,
>
> I noticed you based this on -rc3 -- all our other branches are on -rc2 or
> older.

I'm sorry, I thought -rc3 was old enough. I'll stick to -rc2 or older
in next time.

>
> Anyway, I brought this in to the fixes branch, it's the only thing we have
> queued up at this time so I'll give it a few days in -next before I send it in.

Great.

Thanks,
Jens

>
>
> -Olof
