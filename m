Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33530C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40E920673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFi4VKjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfFXQCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:02:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41739 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730806AbfFXQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:02:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id 136so10453185lfa.8;
        Mon, 24 Jun 2019 09:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AMA2HAM5GHzbGba8x47+feRyrGzC/8GufLwaBmuBGpI=;
        b=cFi4VKjZjCmxjO8v4tBxWI7Ea1nJvu9U3IDUVkQnvLY8+cpRzX+obGqM/tRosDuQMV
         kNAVYQcesAqVtliX5j3bqrmHEoEcXpG++ecm99MOEAW1iSON5my8NvupWBRjr/TjOOvB
         xP+g/HfL+kbiL4bzfR+xz8dnj8VzNYjpTTAVXoLC49gwygejRxXVyZyFNPGRznx6y0aM
         HodbAi3fl3M689LBAB1X2SG/ROPB8cHJAfwoSByXoS4XxHozMOcdYAaNOwLFSDIE1hLb
         55Kh+ZBhy7qh/JLQNynGXsoIpFWhegQyOyecGSXZmyb4m1fK17XLNmG8R26WF09dCrJv
         9MCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AMA2HAM5GHzbGba8x47+feRyrGzC/8GufLwaBmuBGpI=;
        b=lVsEnYbIbKosTF/3ecuAqyOGL5uHSEUHy2VdfSp+m4jR7LB2GlGhF+q2eGDBO/+qHo
         lZu/IfO1mT4wLpN50lB28gm/RrDzQ229Ak6qE5/RBfzTuUbxtS+C5oAk8g8zqQrIDJuw
         Rfy695kDPahwDjp4GlciTju/wRwcK6x3i4bl+oXUNJYKLxBcv+SVbznzb2UmDo3m7hBJ
         JCFccOo7KjVsucxEot6y801UHx9KBnbUsvIKB8lbQN2YFdxs/bp3Aq1O0HB01+UGSx10
         m7Xw8LVVxBAtbpm94a7aE0U4Uik1cd8nTD2v+FVGBMzUsdnl5rhaO0chxsZXr88Ouar+
         qPRg==
X-Gm-Message-State: APjAAAWL5P6Er4ECbVdWs2yBn4+WqWXjo3JYVqI6DoFue/RW9rB/eTx0
        JH2BJjFdjR6PQN9WIfg/9X6w/p9XtSJhH6RKawp8SA==
X-Google-Smtp-Source: APXvYqxCN8kQWiKJaD//zsae7V99HE3CrWQOEkiJLG6rUAhV1euZ3kkcLIT7ZhMJHflLxaZ1bAUr7N5KUH2jhqEWsBM=
X-Received: by 2002:ac2:5467:: with SMTP id e7mr52671259lfn.23.1561392117802;
 Mon, 24 Jun 2019 09:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190617185815.3949-1-carmeli.tamir@gmail.com>
In-Reply-To: <20190617185815.3949-1-carmeli.tamir@gmail.com>
From:   Tamir Carmeli <carmeli.tamir@gmail.com>
Date:   Mon, 24 Jun 2019 19:01:21 +0300
Message-ID: <CAKxm1-EFzwbFS73VsriiwZKHJjZZAyvD-WHpFRsWttzhqqMy2Q@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt: Changed order of elf and misc to prevent
 privilege escalation
To:     viro@zeniv.linux.org.uk, Tamir Carmeli <carmeli.tamir@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'd appreciate feedback on the patch. Seems like we can solve a stupid
"hiding" technique, more "advanced" than just marking an executable
with suid, that leads to privilege escalation. Please tell me if I
miss something.


On Mon, Jun 17, 2019 at 9:58 PM Carmeli Tamir <carmeli.tamir@gmail.com> wrote:
>
> The misc format handler is configured to work in many boards
> and distributions, exposing a  volnurability that enables an
> attacker with a temporary root access to configure the system
> to gain a hidden persistent root acces. This can be easily
> demonstrated using https://github.com/toffan/binfmt_misc .
>
> According to binfmt_misc documentation
> (https://lwn.net/Articles/679310/), the handler is used
> to execute more binary formats, e.g. execs compiled
> for different architectures. After this patch, every
> mentioned example in the documentation shall work.
>
> I tested this patch using a "positive example" - running
> and ARM executable on an x86 machine using a qemu-arm misc
> handler, and a "negative example" of running the demostration
> by toffan I mention above. Before the patch both examples
> work, and after the patch only the positive example work
> where the volnurability is prevented.
>
> Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
> ---
>  fs/binfmt_elf.c  | 2 +-
>  fs/binfmt_misc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index d4e11b2e04f6..3a2afe84943c 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -2411,7 +2411,7 @@ static int elf_core_dump(struct coredump_params *cprm)
>
>  static int __init init_elf_binfmt(void)
>  {
> -       register_binfmt(&elf_format);
> +       insert_binfmt(&elf_format);
>         return 0;
>  }
>
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index b8e145552ec7..f4a9e1154cae 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -859,7 +859,7 @@ static int __init init_misc_binfmt(void)
>  {
>         int err = register_filesystem(&bm_fs_type);
>         if (!err)
> -               insert_binfmt(&misc_format);
> +               register_binfmt(&misc_format);
>         return err;
>  }
>
> --
> 2.21.0
>
