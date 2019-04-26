Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E17C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AED20693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gtvbVEDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfDZTZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:25:18 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45804 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDZTZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:25:17 -0400
Received: by mail-oi1-f193.google.com with SMTP id t189so796465oih.12;
        Fri, 26 Apr 2019 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Gip8+Pf10wfEmxo7QmFvkpn78fJQ8YyyfQBewGykss=;
        b=gtvbVEDl5KZ3CZ7/Q9xOIF2eA6y5XrXL/PdJKH6ZPHNQbu1dx/gtBheNyJ/C9kvzPj
         ZyQcWKds+0i3/JrWJFhp37IK646DjUKxMrzmjkaA1CMax9TeAwSIIBj2YBqNFT9ntFoy
         ONXSUz0qiqUfRyoFfsXeXeuyAzzNWqMoTC8ovazKhL/IGzAMcezMt1XkUpLA05HGOHqi
         ZRQpiEBV4HoroJ/YV5xtQ0gq2YODfLsSaXbVoUMlFZJP7gVP1cCuDSbR/x7yiuPd6Dbj
         xvvq8PRMtbtsVFjXrejd85n5IDo3qVRVXXK3/aVMDgGtTSJXamwt1/cTe4q+rdBa7Lsv
         wVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Gip8+Pf10wfEmxo7QmFvkpn78fJQ8YyyfQBewGykss=;
        b=CulkVF6VNa4TxwJndFDI9k4HYUIeAyza60Z6PIypNY+FO1rvcAMxmu6wYEoWz7RNa8
         kPK1eXz4lxPUNZyxCU7ETVVA31xaeYzc74ItRC5kijeRMR3rwHxdC52YJOwg34sCyTMo
         0DJr8GQXcPxxEQCWnDQm33yQu8IhPNuhBs2wjvkejGrZCUAvLZoYXlxrROo+4rKsylVp
         NXe/HYikmlmeRJ5A07JcOeo880JUNAfVZjo7XnxBjFIrquUM8Kx6J+fIaL8Uu7W5wVeU
         n213uLgiSEb3z2qok2n4FiFEB9NVcKuRzrv+MBiXuIx/lfM11iPRPuYFEkAQ7Yh5JMPj
         pRTg==
X-Gm-Message-State: APjAAAXl5fbDCE+b0y3GIzm7OsseKpfbpbX/+l8RSw3z4wJbGEMhsPFk
        fJAzo3yuTRGokjd0REeP+jZrcez+AmGcrSLtD0M=
X-Google-Smtp-Source: APXvYqwR1IPLvhwnmzRGhZmSmQZ3gpXM9iWVKYHj43LDV+SCD8OlNq3N3YotCjRKcFzBFbjheox6hWRQLypRR9PUOps=
X-Received: by 2002:aca:b905:: with SMTP id j5mr8036916oif.15.1556306715587;
 Fri, 26 Apr 2019 12:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190424093137.241407fe@canb.auug.org.au>
In-Reply-To: <20190424093137.241407fe@canb.auug.org.au>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 26 Apr 2019 21:25:04 +0200
Message-ID: <CAFBinCA9yPKzr=UPtGDe+fCxd3H6cjpoPKQwfZNvPq4QKC0EBg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rockchip tree with the amlogic tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Apr 24, 2019 at 1:31 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the rockchip tree got a conflict in:
>
>   arch/arm/configs/multi_v7_defconfig
>
> between commit:
>
>   029da5e5266c ("ARM: multi_v7_defconfig: enable the Amlogic Meson ADC and eFuse drivers")
>
> from the amlogic tree and commit:
>
>   366391f04177 ("ARM: multi_v7_defconfig: Enable missing drivers for supported Chromebooks")
>
> from the rockchip tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
I just checked the result in next-20190426 and it looks fine
thank you for taking care of this!

do you need anything from me (Acked-by, etc.) to avoid any issues
during the merge for Linus and/or the ARM maintainers?


Regards
Martin
