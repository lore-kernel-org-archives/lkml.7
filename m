Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FBBC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709702230E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfKTIVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:21:08 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39970 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKTIVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:21:08 -0500
Received: by mail-qk1-f194.google.com with SMTP id z16so20513347qkg.7;
        Wed, 20 Nov 2019 00:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bWG2DNPmUa6jaFc0nId1+Kbe3D+HivJV9rytpu5WPY=;
        b=QZrEiObIzEbFCyjr965BEiSWvlU+SGbYv9hgw5h6AoO+KAuyUPet6m34THwbSdtV+K
         O0wpzHqTRMU4VG00UkhbDpeMNNZ7jZRogCmayqenFiULLqsuzyv1Sx9xhTWqFKMSwFVJ
         O1+X+77ju4//5sedw7x5aQkQskY3EQ7FeUssnz7/WGyR26YnKTOOJQq30iZ2pMRlVHpO
         mWOaeG0+FCKrhTgUXj6lwc6dq4LN5fKx/Dz0tqV6tPcxT8RkfLPKl/L7eJwCH2Nh/BQG
         dYG96I/o/pDykjUwtMqkp/MXzUkj16sUFT6XWjJ++ySttCU/KfLKRuk13fcVn1MpNjBj
         E2KQ==
X-Gm-Message-State: APjAAAUEsPkMfoqScWAfsivxt9jm5AHBziHei3HDzUp5+zkItMPt8VEP
        u7DIQMMpYv7J0jo+e/kz4+UhqRRXBueYjrSZIGMLrg==
X-Google-Smtp-Source: APXvYqzIB0kwwzIAHfPMgbcj3AR6DIy4CsJKuDki0k6Zndedh71l04nYN3XJmF7cIzuXUnRCff8wFeFS4E+83v+oC4w=
X-Received: by 2002:a05:620a:485:: with SMTP id 5mr1270597qkr.134.1574238065027;
 Wed, 20 Nov 2019 00:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
 <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com> <413c9aad-2123-b22a-56bc-faa5c7d38d06@infradead.org>
In-Reply-To: <413c9aad-2123-b22a-56bc-faa5c7d38d06@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Nov 2019 09:20:53 +0100
Message-ID: <CAMuHMdVLoHejqNMr0CK=K1bcT16fWu-h5n1w3ebsay9VtZccwQ@mail.gmail.com>
Subject: Re: [PATCH] arch/sh/: fix NUMA build errors
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy

On Wed, Nov 20, 2019 at 1:41 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 11/18/19 11:38 PM, Geert Uytterhoeven wrote:
> > BTW, you didn't have the issue with CPU_SHX3 and CPU_SUBTYPE_SH7785?
>
> I don't see a defconfig with that combination.

OK ;-)

> Also, http://kisskb.ellerman.id.au/kisskb/branch/linus/head/af42d3466bdc8f39806b26f593604fdc54140bcb/
> didn't report any such problem.  I only addressed the 3 build errors that were reported there as
>   page_alloc.c:(.text+0x3148): undefined reference to `node_reclaim_distance'
>
> I did just test sdk7786_defconfig successfully, but that's no surprise since it sets CONFIG_SMP.

Yeah, that's one of the few real SMP SH SoCs.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
