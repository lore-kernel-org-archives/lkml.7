Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7F9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A950B20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLJIQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:16:16 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32794 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfLJIQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:16:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id d17so14815342otc.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l38l0VF8bf24HKe/nGZvjby43vRgIglN8+s8O7VTwDM=;
        b=gmXKhpm9H2JmhcYQ2LoRbaF5N5zHj7O3mQBUFkw6jQv3LUCVx2rcYBFk03fCSYmkKJ
         quvPiWLKWi1BofjzWOXQ5yM+J56pMfcUNS79WSSq7qJT5cIzctQi5e8tHgPL+EanEtBc
         T3ssCqSiqRMD6q9DIytP1NOE6mXVbafHAqsbM46n6A6iPP173aVo4IzMe1jZOejRmb6y
         TZAswGs9b1YOpPon7MWKgtJoIJ0E+TS83Nm+BPoyok4gIuzGuX1bPQEpJ9JG/KpTaQNk
         /k/mLLvwM/ekiWvprf0r8fFJUE9lgEqFmigz/b76Y91dyFOKcnX2lcqA18MbKylGXEiT
         g4GQ==
X-Gm-Message-State: APjAAAVKGTkHdTdsDPLyRR54xajwDzEVcc7xqFe3ldHaqdMQDiLKvkQB
        WmfptTpQzuQEqlxgGrnqwadk6ccth05AgrGi3Pg=
X-Google-Smtp-Source: APXvYqwgxMx0+xiHwT1qjwSWjuqMw2V4ldS6xY+NgkCNvOlFjLtXJmi/Q0s6vnmXqtRCX8j0LceLUfPvxOQDOKzKwR0=
X-Received: by 2002:a05:6830:91:: with SMTP id a17mr23322883oto.107.1575965775467;
 Tue, 10 Dec 2019 00:16:15 -0800 (PST)
MIME-Version: 1.0
References: <1575946121-30548-1-git-send-email-zhang.lin16@zte.com.cn>
In-Reply-To: <1575946121-30548-1-git-send-email-zhang.lin16@zte.com.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Dec 2019 09:15:54 +0100
Message-ID: <CAMuHMdUWeH9u0hP9wCfgb7TJ0nQkbQTPREX+fpTh+ZVrTsCobg@mail.gmail.com>
Subject: Re: [PATCH] initramfs: forcing panic when kstrdup failed
To:     zhanglin <zhang.lin16@zte.com.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Steven Price <steven.price@arm.com>, david.engraf@sysgo.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 3:47 AM zhanglin <zhang.lin16@zte.com.cn> wrote:
> preventing further undefined behaviour when kstrdup failed.
>
> Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>

Thanks for your patch!

> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -125,6 +125,8 @@ static void __init dir_add(const char *name, time64_t mtime)
>                 panic("can't allocate dir_entry buffer");
>         INIT_LIST_HEAD(&de->list);
>         de->name = kstrdup(name, GFP_KERNEL);
> +       if (!de->name)
> +               panic("can't allocate dir_entry.name buffer");
>         de->mtime = mtime;
>         list_add(&de->list, &dir_list);
>  }
> @@ -340,6 +342,8 @@ static int __init do_name(void)
>                                 if (body_len)
>                                         ksys_ftruncate(wfd, body_len);
>                                 vcollected = kstrdup(collected, GFP_KERNEL);
> +                               if (!vcollected)
> +                                       panic("can not allocate vcollected buffer.");
>                                 state = CopyFile;
>                         }
>                 }

Do we really need to add more messages for out-of-memory conditions?
The trend is to remove the printing of those messages, as the memory
allocation subsystem will have printed a backtrace already anyway.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
