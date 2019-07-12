Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D6DC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D0F20989
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7yvs9oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfGLVyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 17:54:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45966 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfGLVyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 17:54:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so11278503wre.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 14:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezp/81M7BENZPKnx1WnKUk8Kc7XjQxmW1Vz+hS9hBlE=;
        b=F7yvs9oixj5hjp+eiYH1qU6SjFYkhjw1IgWZ9aV9FAWKtP24t50TNH6Yw2OMljAvMe
         lvMW757gJjSPxz46QZmWKzUNzppvtSbOZLFFHHcbguFxJct/eFeaU4bS+tMFgdRNBl5y
         zJWM6qgOyiAayFFES4VqF9nRmO7lhAa8yhapem7E8R46LdOr/dwHj7TGeIMhonBMB3QR
         omWT3uJimoFtlANRpHj4TFgmLp9RQYQQR0NeOG38IXKsd+nv0pr98yMCmcAzOtDzxSr9
         XrTIMJxUWsHA8MaarZ0USitUPkbFYsRDGXykK2KO3KFBImSIatA+hwPIewHX3rGWmVYL
         HCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezp/81M7BENZPKnx1WnKUk8Kc7XjQxmW1Vz+hS9hBlE=;
        b=L/CveZBy0cw3Y9Wg3UCUPVbdryPOtZDs4DTwXzyaaO8D1aH+5RGJ8gE2nvL9SmhYQ7
         isfCpsKHUSCSBaB/w7F7NveyRGml7NkGThq2kAn9L9YAQjq8q64riC/K1O45usLuKcSv
         0HiQbx2FkCgrEjDkdGx97SZCM82XEjrjyKQ02+FIYVeQk6Olu/NGO+/GohsG7n89/Xgj
         XO2nGPaF20fn/PUlsaLBL6bQJaBAzLJv6KyecZiUwCMbCL7Jr0hBBoh5MjWCRJAwLkGA
         e3s8nYy9iKihNnMHlKcLvP4NmJpgPmPMgNEAMDmQ3EFnNEzVrZtArZ/Ux0EfGNnJKaQ5
         4zqA==
X-Gm-Message-State: APjAAAWLnJIKXV01jPKvZUc/pjSnLVraB5OcZFY7zMyRn6QOEcJsYQc2
        QQ20lkoT0afjrj/uswKuxxFjhV8CPm6DEmr6wEuFhZzR
X-Google-Smtp-Source: APXvYqxQeEczSKIZ7O8yTeAs+UoffMtTZQCaI4aZsUiXrcx4Aq6lM4Lvjh+nPFm7F1X3KdvocvBcg3UAN80c3hr/Erk=
X-Received: by 2002:a5d:498a:: with SMTP id r10mr13585194wrq.28.1562968479204;
 Fri, 12 Jul 2019 14:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <1561723581-70340-1-git-send-email-chengzhihao1@huawei.com>
In-Reply-To: <1561723581-70340-1-git-send-email-chengzhihao1@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 12 Jul 2019 23:54:27 +0200
Message-ID: <CAFLxGvwHO9nSLiMEpqtEr1Y-5TSjs_M4+_pbwUG6_Fojk+CUvA@mail.gmail.com>
Subject: Re: [PATCH RFC v2] mtd: ubi: Add fastmap sysfs attribute
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        yi.zhang@huawei.com, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 2:01 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> The UBI device can be attached to a MTD device via fastmap by setting
> CONFIG_MTD_UBI_FASTMAP to 'y' (If there already exists a fastmap on the
> UBI device). To support some debugging scenarios, attaching process by
> fastmap can be confirmed in dmesg. If the UBI device is attached by
> fastmap, logs like following will appear in dmesg:
>
>   ubi0: attached by fastmap
>
> If multiple UBI devices are attached to multiple MTD devices at the same
> time, how to distinguish which UBI devices are successfully attached by
> fastmap? Extracting attaching information for each UBI device one by one
> from dmesg is a way. A better method is to record fastmap existence in
> sysfs, so it can be obtained by userspace tools.
>
> This patch exposes fastmap on sysfs. Suppose you attach an UBI device to a
> MTD device by fastmap: if fastmap equals to '1', that is, the fastmap
> generated before last detaching operation is confirmed valid. Else, there
> may be some problems with old fastmap. Besides, userspace tool can also
> check whether the fastmap updating triggered by other operations (such as
> resize volume) is successful by reading this sysfs attribute.
>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Sorry for the delay.

[...]

No locks in sysfs, please. :-)

> +               ret = sprintf(buf, "%d\n", ubi->fm ? 1 : 0);
> +               up_write(&ubi->fm_protect);
> +       } else

So, I like the idea to expose that information and I gave it
a second thought.

Basically you want to export two distinct infos.
1. Did we attach using fastmap?
2. Is *currently* a fastmap on the flash?

For 1, just expose ubi->fast_attach via sysfs.
To expose 2, you need to create a shadow variable of ubi->fm.
The problem is ubi->fm is internal and can be NULL while an
update happens.

-- 
Thanks,
//richard
