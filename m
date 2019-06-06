Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93432C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5B120872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BzxKUUDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfFFOmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:42:04 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54645 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbfFFOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:42:04 -0400
Received: by mail-it1-f193.google.com with SMTP id h20so309089itk.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yI4UXAmfk5AOoLIasiEgCZLXHqdA6sJuFFsoq27RzWo=;
        b=BzxKUUDwXS3pKhUbyzh0IBg3j0CX/86s/DnYE4HvoU55W1tydocpIKG1IlQOsydUQl
         huukxirzjW7kJ+AZ+Yxqd5DF19hVyAFq9uzWoSI8V5C+pjT4SW2QTLrvxGBwqP2wEB7n
         cbu8JiiySU7SgTKKDRD+5f/zYcvoBfqSXiToVcT25u3eP8nCJO72AkALhzAALlQHhXrK
         sycPgq6obiKeGQz/suhzIERteHkTaB3Rn1bK8aCr+WQ5ykQvHoq0kT4FdEryf4zaXVoR
         YMo6HytXQhUZ65ymN1q8bNjjEfA6Cug7VlsxiTSf5PwSTjES0DxHY9CxQX5ejXLVmOqu
         dPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yI4UXAmfk5AOoLIasiEgCZLXHqdA6sJuFFsoq27RzWo=;
        b=Lf7Z4++oKn7ryyj7MEZe0TtFFFYli6YlPuevvOksPDqi+/5DlGscaZR1lj6Rhn0JJG
         6hlPugjq8AtZalHZk6J4dQGnVBZVnduYTMZmOxwN6K2+wGK0G/yl+S/iG0QQlFOTmKIY
         N/cPnm/qjmknd0Oi+ecRBeC/fvTU9qXxZZmKAP1bLeI5vhvT3D+Yw3kL8FLc549u2vvq
         RbiEt+hStzBf/Xl89Sd3qsZMEXCqAA3zCzLnTqky7BacIa/JDtvxAmUek9G37lur5qzi
         8ePHmyWr+vPf4TfqnNlPRvvWz0L+tPl4cPxZjTE/rsoNzvIoJ4ldvsFc2nyPChfRx2LX
         G3Vw==
X-Gm-Message-State: APjAAAX+k5C+vyR/VsYOmQAVnCgS663pk5nLeNaiMTB5iyqbaiCfL+uJ
        ozngYAGhq7OBKkTcSaFPThjwV8BFJssf6zyH5EymoA==
X-Google-Smtp-Source: APXvYqxmQaijA2Oe/JJbDNLGyx4jQv3Fek40A4Cze3ibfgIGnUz18m8n3YV+uZHidCOUbrTpckx056z4S7SSrxEKBFI=
X-Received: by 2002:a02:c7c9:: with SMTP id s9mr30323015jao.82.1559832123120;
 Thu, 06 Jun 2019 07:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004945f1058aa80556@google.com>
In-Reply-To: <0000000000004945f1058aa80556@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 6 Jun 2019 16:41:51 +0200
Message-ID: <CACT4Y+aK8U2UG1KjuPx-tiPuRQf-T4YyQe04v5aCdP87ejodWQ@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in corrupted (2)
To:     syzbot <syzbot+9a901acbc447313bfe3e@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 3:52 PM syzbot
<syzbot+9a901acbc447313bfe3e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    156c0591 Merge tag 'linux-kselftest-5.2-rc4' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13512d51a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=60564cb52ab29d5b
> dashboard link: https://syzkaller.appspot.com/bug?extid=9a901acbc447313bfe3e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a4b01ea00000

Looks +bpf related from the repro.

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9a901acbc447313bfe3e@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in vsnprintf+0x1727/0x19a0
> lib/vsprintf.c:2503
> Read of size 8 at addr ffff8880a91c7d00 by task syz-executor.0/9821
>
> CPU: 0 PID: 9821 Comm: syz-executor.0 Not tainted 5.2.0-rc3+ #13
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>
> Allocated by task 1024:
> (stack is not available)
>
> Freed by task 2310999008:
> ------------[ cut here ]------------
> Bad or missing usercopy whitelist? Kernel memory overwrite attempt detected
> to SLAB object 'skbuff_head_cache' (offset 24, size 1)!
> WARNING: CPU: 0 PID: 9821 at mm/usercopy.c:78 usercopy_warn+0xeb/0x110
> mm/usercopy.c:78
> Kernel panic - not syncing: panic_on_warn set ...
> Shutting down cpus with NMI
> Kernel Offset: disabled
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000004945f1058aa80556%40google.com.
> For more options, visit https://groups.google.com/d/optout.
