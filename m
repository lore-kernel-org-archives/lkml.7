Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170B2C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12012184D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSy8Ap4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfIBDYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 23:24:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38910 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbfIBDYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:24:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id b2so10772661qtq.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 20:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6Z5DSSACKSWSp8b89LCfUEjrE4iWwfhjwqK/9pHbwo=;
        b=vSy8Ap4oedvi1uoi4Gf/VMdfcS5JJtiDTon/mIGfqt/y7WbszkDTZwKXp7TlocbvVl
         +sBAAQeyefSh/sulYF8VL5auwguh+sWOfOGgqa7Nf8pKoGDcy2SNhDUUTjGAooOokL2k
         8FLsc7wbPcIA6SHkw17zjkDr+iGCJvPPs0oLVlBuO/dRmXf5iluhYvzUFMi+rvtrIczp
         zpo6lc/lCfQrlLly93rf39XOAh2ZKOXobW4LlJ4KEUWfhhovFe02wNQ0FCPtbIBkvy2p
         BxhqWg9c1amnFP0yZKaX+SF0sXjN88W1oESgNZFj8f1eSYSv59WrcYLQoF7GfEK3FcVf
         uY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6Z5DSSACKSWSp8b89LCfUEjrE4iWwfhjwqK/9pHbwo=;
        b=FzYStMVMvGfE+pBSw3wc78Xf5AZrOc76UxFqejsc/kvp/qAkKwxFYVZJ0qBwI/x9cL
         59vsan2eUBkppxu+z5cN6iyVkIqpQRCjSeXK/WBMd0nn4wMYsQ7QtbGiASRbuve4InHW
         eTekikDUFD720fODD6k7bpTne9OcVR9GVOTbAHRnhalVWjMRanBC8URLf/NN35Z6ykmE
         WZLTCcsen5ngciWGXt9YsCGLMGJjiL6ytf+6PlsBCIUd+gHRulDJMnjz+siuSu/DSxkk
         Oj+bwo0mdDOp61UK+7ibMTHehqt2bX9KTntndoW1oe+x+N7+SoRZ5LOba6u5bhfH8Df6
         n8ww==
X-Gm-Message-State: APjAAAWAIRM3EDqYlyukjy5Bqn6jvB0PIgjAclJu3TCz6yuDVrx99RSd
        grvbOt6hgj21rfW5LHfxlHX4LDkXwJsM3jDKngmCWw==
X-Google-Smtp-Source: APXvYqxriQFfhlHk4GewXahbFKKYVfC8BMiYNDm2u11fc4CRJuKouSCtWHVVoahxf3YSj40UWiwHjV6BgN6AVqxt5FU=
X-Received: by 2002:a0c:fd91:: with SMTP id p17mr17416922qvr.170.1567394653221;
 Sun, 01 Sep 2019 20:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000088cdb2059186312f@google.com>
In-Reply-To: <00000000000088cdb2059186312f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 1 Sep 2019 20:24:02 -0700
Message-ID: <CACT4Y+Z64=fD3aw88YtEQS9o-uZ8hqe0WRr_X=FrkajJWSs3Nw@mail.gmail.com>
Subject: Re: kernel panic: stack is corrupted in lock_release (2)
To:     syzbot <syzbot+97deee97cf14574b96d0@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 1, 2019 at 4:27 PM syzbot
<syzbot+97deee97cf14574b96d0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    dd7078f0 enetc: Add missing call to 'pci_free_irq_vectors(..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=115fe0fa600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2a6a2b9826fdadf9
> dashboard link: https://syzkaller.appspot.com/bug?extid=97deee97cf14574b96d0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f7c2fe600000

Stack corruption + bpf maps in repro triggers some bells. +bpf mailing list.

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+97deee97cf14574b96d0@syzkaller.appspotmail.com
>
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in:
> lock_release+0x866/0x960 kernel/locking/lockdep.c:4435
> CPU: 0 PID: 9965 Comm: syz-executor.0 Not tainted 5.3.0-rc6+ #182
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000088cdb2059186312f%40google.com.
