Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D24C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFED620678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngfgP/ZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfK0OC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:02:29 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44857 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfK0OC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:02:29 -0500
Received: by mail-qk1-f195.google.com with SMTP id m16so19527597qki.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 06:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiANxCdzbSnhcioCshDSncN9KNW/FPFbw4cOUMqmqeE=;
        b=ngfgP/ZTpPWsNp46WapVEeO/23UKqhQpYPxJU8Dc7TSCBLiuziZEFLNieXiEgVi/pK
         tGb3BLwoxViSQEurg9p1YJnhQF1sD9IHgHXkD4dFHyTfkGJsVJS4ua9HVSzdgPulEKos
         siwebeHBuryUKtLcjHPtFLBLXdDdua9RcF4wFtEbsdjZz6EHjLqTFvYW+vxzXB5jN+Bt
         ZlxupDjpq3KAjxtAiANabxP+G3KBnGAYg/VIaxmE3YgeSfvvmCL5Qj7pwJB7jsrY4fHt
         2De1tir7UzrXzumms27m8DxKOWYQoDT6QGUNDnwtE8ZizqoH8WZlW6euNObqwUQuAcY8
         Y8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiANxCdzbSnhcioCshDSncN9KNW/FPFbw4cOUMqmqeE=;
        b=XFKWEcI2/NOE4ANkAn2sw+gulXIK1DzFcVD/XX8dYHd/bJKuSUM0dybnOXFSjfRiiI
         Ibdqu850MX500XM6gxm2k2GbGyG6sdfNR14aC/OYTm9CLce/YXOT2Dt6dqa3s08DQHbz
         W37BQ0dlKqO2JIu4+ZTbqRqCH6B5fLS96yXtWph0Esm7Q9EVmsPjY2uBM8feAOMfY1qq
         P6VkFVuRTpcQceeRCmoozk2WiY9Ntqw+nJm6XhDHJ5xUd1NepGhMShKZBgvdjGqoWtdh
         KknZg2XM6e2x6ZFjokKU95WkCB4m8hhIbrFSLSj7rKHFkU9byZR+ZKyOimYQo4QU1A3Z
         YAig==
X-Gm-Message-State: APjAAAXEW01r8pTpmh0/QdA3i/xThVH3Kz3qA7JjqZtbJdKdBiy4RX14
        bE6euOf9C310dKIGq3WmPzFTTCzUqcriYurOmdGUZA==
X-Google-Smtp-Source: APXvYqzS6mlz4BCAYHUVdzb46ZrHHqG8DBfbMgLijDEeGXHUH+izQyzaEY6Dq5osj9QJojOwj5cAr/rMnM/acdv6l04=
X-Received: by 2002:a37:bdc3:: with SMTP id n186mr40399qkf.407.1574863346374;
 Wed, 27 Nov 2019 06:02:26 -0800 (PST)
MIME-Version: 1.0
References: <001a11441b6c6cb96c0569120042@google.com> <00000000000093ca84059853da04@google.com>
In-Reply-To: <00000000000093ca84059853da04@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Nov 2019 15:02:15 +0100
Message-ID: <CACT4Y+Y1=+uGRNUk5G-m4vF4AhRTWRAngLJLGGiFmN_Y72sGeQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in ntfs_read_locked_inode
To:     syzbot <syzbot+19b469021157c136116a@syzkaller.appspotmail.com>
Cc:     anton@tuxera.com, deller@gmx.de, jejb@parisc-linux.org,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net, linux-parisc@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Drewry <wad@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 2:20 PM syzbot
<syzbot+19b469021157c136116a@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 910cd32e552ea09caa89cdbe328e468979b030dd
> Author: Helge Deller <deller@gmx.de>
> Date:   Wed Mar 30 12:14:31 2016 +0000
>
>      parisc: Fix and enable seccomp filter support

FWIW this commit somehow has an effect on x86 binary. I can reproduce
it. I've collected what I know so far here:
https://github.com/google/syzkaller/issues/1271#issuecomment-559093018
Well, actually it does not look like effect of this commit but rather
non-deterministic/hermetic kernel build.
+Al for affected x86 build bullshit

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=143090dee00000
> start commit:   3e968c9f Merge tag 'ext4_for_linus' of git://git.kernel.or..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=163090dee00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=123090dee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7e8c053ac965e0dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=19b469021157c136116a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142d219b800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143029db800000
>
> Reported-by: syzbot+19b469021157c136116a@syzkaller.appspotmail.com
> Fixes: 910cd32e552e ("parisc: Fix and enable seccomp filter support")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000093ca84059853da04%40google.com.
