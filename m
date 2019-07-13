Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A437C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82D5204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnx2UuWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfGMGrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 02:47:05 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42915 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfGMGrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 02:47:05 -0400
Received: by mail-io1-f65.google.com with SMTP id u19so25154622ior.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 23:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEq7gpO/JFo6YHmOtPBZOjH0nCudV00tb/wtbxhzgn0=;
        b=qnx2UuWp80W50wiCRVVNClHzuvAc6Wr+7kAebuLIWX9CzaHXrhQ/tsLyIIoniYvPQ6
         GFAIjdJhZmAXe3pPHHbgohXsnhPKZ++iyKJCNce7o/XJk3RkTIdeuqmWCaox6f1Dtazr
         auQqbGTLEteCee7BKdRuMShFRcCLwS7U4w0Z+cyWnSuRuwXIAU2lDL157s/GX1xbTHGK
         NbWsTrsMZrcdofftEXUN7wc2jtSB9S3locFJ8ad0N3kUC7ro/D6MrxlxyA0dB93Qmmu/
         nXkdjAlJKP5gMdtuViWWUn+s4jRjbQK7+c97846KeLgIeotwIQ1w0U5XDCRTFeNLRgam
         q0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEq7gpO/JFo6YHmOtPBZOjH0nCudV00tb/wtbxhzgn0=;
        b=REguDGJ3fSEhgPGrTvrIg9prnvQEZfVIYa7Hc7v7MCsL0fGxVvGwWwjxJJVmqIXjww
         8oPvGg9scxY0zRnEaFZa2L33d4F+v+ulkcWIyVJjleZI4NyA6jUa7qp2mMsXxL3EUamR
         HRbwaGPTDtOHHP9MNhHEHKeHw1yzocV4aLz4vnHIANUlaN91J+U7MoXaA1a5WTiuq3gY
         x4UpiyiswrMpUZy1Im41Se3UhjlcovCvvfMY1IRJWfQkxWgGRIGxCzpegL89K9xcF6rD
         o7MPIOfNACpcR8tA0Oj6HY6A0gC3GfU78kRKdH0GKs5wZEFtDNYGYhgecUhW9qpPSVS1
         rmlA==
X-Gm-Message-State: APjAAAUXa6JZXLtbhCC4BYfEB9hAmeqyCxpI1Dq8+shFhAccNhFavhG2
        +fw3HzZ0E5rK+uDvjlATfMEfMNxOlxfCrR6mRlg=
X-Google-Smtp-Source: APXvYqxdt+xi91UqhCcS84kgJWEwR1dnD4oEUkCE1FlhlVqU8eZZhAlzhHnZETRQVgR9r0eQAfR1Tmq84SQ7JM2G3o8=
X-Received: by 2002:a02:13c3:: with SMTP id 186mr15479612jaz.30.1563000424018;
 Fri, 12 Jul 2019 23:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <156294329676.1745.2620297516210526183.stgit@buzz> <20190713060929.GB1038@tigerII.localdomain>
In-Reply-To: <20190713060929.GB1038@tigerII.localdomain>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Sat, 13 Jul 2019 09:46:56 +0300
Message-ID: <CALYGNiPedT3wyZ3CrvJra=382g6ETUvrhirHJMb29XkBA3uMyg@mail.gmail.com>
Subject: Re: [PATCH] kernel/printk: prevent deadlock at calling kmsg_dump from
 NMI context
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 9:10 AM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (07/12/19 17:54), Konstantin Khlebnikov wrote:
> > Function kmsg_dump could be invoked from NMI context intentionally or
> > accidentally because it is called at various oops/panic paths.
> > Kernel message dumpers are not ready to work in NMI context right now.
> > They could deadlock on lockbuf_lock or break internal structures.
>
> Hmm.
> printk()-s from NMI go through per-CPU printk_safe/nmi - a bunch of
> lockless buffers which is supposed to deal with printk() deadlocks,
> including NMI printk()-s.
>
> include/linux/hardirq.h
>
> #define nmi_enter()
>         ...
>         printk_nmi_enter();
>         ...
>
> #define nmi_exit()
>         ...
>         printk_nmi_exit();
>         ...
>
> So we are not really supposed to deadlock.

Yep printk() can deal with NMI, but kmsg_dump() is a different beast.
It reads printk buffer and saves content into persistent storage like ACPI ERST.

>
>         -ss
