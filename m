Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA62DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEE320857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwEU1KR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfCZIoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:44:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38699 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfCZIoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:44:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id q14so9980641edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fx4bc/xeU2icy5q3tRcX7R5j5vyIwYOf71aPeuGzsbk=;
        b=gwEU1KR3zxtiCylhKYed0y7glzpT6oBSf5JMV7gKpvSIwOeGslL+XooNG6ZnEyZDYm
         HLUOslro9GUEiPPmD8g1WEp2ryXy9AEUpYaohqTDy34tZXpSqZTxWSkqaHVMnMmrJYIa
         5EYbOP5oLyqyRfki6+LZHCPK2rDoGyCVuZUZVnG6P6RKPKA2GTUpYx4cdi3Q3DTk1icZ
         SHDtEv8sHOsPpCxmwcxsw2kvba+z3KINxWrkWqZMHXlifSz8xD5dIGRqvm4k4CXRJdV0
         XK1cL+UjGVmBn5j5P/OMYbziTj5TateRBW3XPYqzpN6demf3g5IWYUDd8IK5jCY37qnt
         jB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fx4bc/xeU2icy5q3tRcX7R5j5vyIwYOf71aPeuGzsbk=;
        b=blYlThZoS1zKBKc0kdzT12MT9UFSvPETzqOJTytkzooapqB/sqAUf+Diw+PC5pxbl2
         g6LPy17yEVAknEzL7w06XMCOpQcWHrQ9VVKviIYj7Xlac9ioYp3qg/tP66Y7jbkZVEsg
         3GXg6hqsiaaFBLK/9CVPFKrwZMqm7j0R3wbi+076UqF/G/XIL6vMrhWzPLT4eRwopIvI
         sI/Rdvdv3P9LQ5nGZNzfx7btTUaZAUIZku1zgtCkOW+nuR6P2XYMQmROqOk4cdOYRTiv
         4+cxPeS9vxKVRgpz26qrUZ4ie2sDdPBqR4hLT8VCpnmxNaLcMxlT983bV20KMGAuyDYc
         XBDQ==
X-Gm-Message-State: APjAAAVVhEK7N4GCmggn1A5BuQYdTFXZsq9qnnATL9GjBLvbpApb7DCR
        0Xq291wpr4DTgjhehLgZ4CQcQYc6jI/QcjYVjS4Fwl+YIITZoQ==
X-Google-Smtp-Source: APXvYqyGVfLO8IDDKcuLbTRKF4EtuCmDmbW+nv0Lr7fhNsh5xW2c4ofCD5NvzPVms8Z8NNhvxTSRgMO4g/zqfJ0oumY=
X-Received: by 2002:a17:906:1942:: with SMTP id b2mr16877237eje.5.1553589852412;
 Tue, 26 Mar 2019 01:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000e2b4e057c80822f@google.com> <000000000000bc42080584db9121@google.com>
In-Reply-To: <000000000000bc42080584db9121@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Mar 2019 09:43:59 +0100
Message-ID: <CACT4Y+ZMfkB5kHnF5erCHtuEENLVdWGJtEME2-nx0_1+2ywe0A@mail.gmail.com>
Subject: Re: general protection fault in freeary
To:     syzbot <syzbot+9d8b6fa6ee7636f350c1@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux@dominikbrodowski.net,
        manfred <manfred@colorfullife.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 7:51 PM syzbot
<syzbot+9d8b6fa6ee7636f350c1@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 86f690e8bfd124c38940e7ad58875ef383003348
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Thu Mar 29 12:15:13 2018 +0000
>
>      Merge tag 'stm-intel_th-for-greg-20180329' of
> git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm into char-misc-next
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d653a3200000
> start commit:   74c4a24d Add linux-next specific files for 20181207
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=143653a3200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=103653a3200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6e9413388bf37bed
> dashboard link: https://syzkaller.appspot.com/bug?extid=9d8b6fa6ee7636f350c1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e19da3400000
>
> Reported-by: syzbot+9d8b6fa6ee7636f350c1@syzkaller.appspotmail.com
> Fixes: 86f690e8bfd1 ("Merge tag 'stm-intel_th-for-greg-20180329' of
> git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm into char-misc-next")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looking at the crash patterns in the bisection log it seems that this
is a stack overflow/corruption in wb_workfn. There are other reports
that suggest that simply causing OOM randomly corrupts kernel memory.
The semget is only an easy way to cause OOMs.
But since we now sandbox tests processes with sem sysctl and friends,
I think we can close this report.

#syz invalid

Though the kernel memory corruption on OOMs is still there.
