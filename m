Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C78C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF152190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWFioAMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfCVRDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:03:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39918 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfCVRDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:03:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id l7so2654806ljg.6;
        Fri, 22 Mar 2019 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxPF6csDBZJ/fhT73vId5r2vk9Y2Vw4zwg9Vib06ILY=;
        b=tWFioAMTLy3x25Tehk5DkPP0lVdMoBmU1R09o53JtnA25ouCA4/UwFOCKokks+zQZ6
         pcECwedXiwGH/3i+w396dk4EbwInag7zoK0UvTGTKwEfW6nSIRBLUba/060VrP1FZuN8
         iLQHwxGvL6jEErrmkY4rX/N4inwVgwH1KlKCXqHrLMPqgtMQC+RNQxk1kw1Oi7fMJzPu
         nFzfSjB9CbGJmLnpSXshY4Cb8EMptOZbuSiTpk6kxu3QjrwU6ahFIldgvszEqz7c17sG
         exI8c6Npsjt9wy8dzjcMlLwiID7/dhrfWclX9ZGa/j9PayvuYzsMQOfVA5EULt+g8G4Q
         KzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxPF6csDBZJ/fhT73vId5r2vk9Y2Vw4zwg9Vib06ILY=;
        b=Rpqnkg7SM1LMnTFJb6c1fgzrgL3Yk8tAV35Gh+NqwJ3AVXSHO1Ug+gGI5yqvCz6E7A
         VlbFBsdg0H3UWzhYMnWwHzBVeABqiVuA7k/+P8S04253ZVhe/fZ22DOzLqMfpE/9W0Iu
         zhWc9oFNTHv4YM7UmB2QhLusfBWO8yDrlld1nYqk3R8+LrJr6acPL44E3mE1Xcpkewua
         ony6E8RCpyNJZWtrJN2nCse9NjingSFoEWMSQlV3i+y6WNj/P0/NlYG+N7arc1BKhAle
         EGa+EGJQBTQscxYd1iFekP5bPe0IMvESwlqEZvS6onOj/hurx6nwh0uBtidsjK7DVNB/
         4WlQ==
X-Gm-Message-State: APjAAAV7kU7D139tGrFu+U+FQV1iIwQhX+XwHP09pygDQRZljFWuWZJq
        lDV/Ih3taBBHVDNgn5ztEnhYJW7vwFGN1MJOVpw=
X-Google-Smtp-Source: APXvYqwtAk7jF/YOfFwGhwz4RuxtbMuF578vExk0uYnqvlcx9Na72vgWFKPRKbAxKx9ihGr18yvFikBI7Eq+flnC4Hg=
X-Received: by 2002:a2e:9ac3:: with SMTP id p3mr6405768ljj.109.1553274220172;
 Fri, 22 Mar 2019 10:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190322114345.26532-1-ulf.hansson@linaro.org>
In-Reply-To: <20190322114345.26532-1-ulf.hansson@linaro.org>
From:   Maxim Levitsky <maximlevitsky@gmail.com>
Date:   Fri, 22 Mar 2019 19:03:29 +0200
Message-ID: <CACAwPwY=rhfyoLvkPNB4Pdagv_wjKgnybeW1Az1gd3vAF_0exg@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add Ulf Hansson to the MEMORYSTICK section
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alex Dubov <oakad@yahoo.com>,
        Alex Dubov <alex.dubov@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rui Feng <rui_feng@realsil.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!
I also expect to start contributing again to maintain the code I have
in the kernel, after I done with upsteaming the nvme-mdev driver I
have just sent for initial review.
I work for Red Hat now, so I hope I'll find some time for that in the
future (still on a hobby basis of course).

Best regards,
     Maxim Levitsky

PS: my work email is mlevitsk@redhat.com


On Fri, Mar 22, 2019 at 1:43 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The amount of changes to the memorystick subsystem are limited as of today.
> However, I have a couple of times been funneling changes through my MMC
> tree and it have turned out fine. So, I am here by volunteering to continue
> doing this, by adding myself and the link to the MMC tree to the MEMSTICK
> section.
>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Alex Dubov <alex.dubov@gmail.com>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: Rui Feng <rui_feng@realsil.com.cn>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  MAINTAINERS | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61bdbade3daf..8434d6ffa243 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14463,11 +14463,15 @@ T:    git git://linuxtv.org/media_tree.git
>  S:     Maintained
>  F:     drivers/media/i2c/imx355.c
>
> -SONY MEMORYSTICK STANDARD SUPPORT
> +SONY MEMORYSTICK SUBSYSTEM
>  M:     Maxim Levitsky <maximlevitsky@gmail.com>
>  M:     Alex Dubov <oakad@yahoo.com>
> +M:     Ulf Hansson <ulf.hansson@linaro.org>
> +L:     linux-mmc@vger.kernel.org
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
>  S:     Maintained
> -F:     drivers/memstick/core/ms_block.*
> +F:     drivers/memstick/
> +F:     include/linux/memstick.h
>
>  SONY VAIO CONTROL DEVICE DRIVER
>  M:     Mattia Dongili <malattia@linux.it>
> --
> 2.17.1
>
