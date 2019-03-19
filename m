Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BF2C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1742D206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZ9LzxuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfCSSDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:03:17 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35854 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfCSSDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:03:17 -0400
Received: by mail-wr1-f47.google.com with SMTP id y13so17744220wrd.3;
        Tue, 19 Mar 2019 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjQYlcDfI2yco5kK76SVjFJd0JAsA9gIL0FN2AFEY0c=;
        b=qZ9LzxuXQvPGopSwPJwE8FrP4+RUr7dwnIw4CMOoP3vrdES4eCRZN0qsKsmEohIFql
         1M5iMT99wvZg+pGeJCDc1tJ+vefdqsuXZ5ZFRAz2JzF1Ix5o2CKHWEmX4WSVmldE6lot
         Zbh+Hdlgft4t+Pk7NORG2PV2ktc/swjMTc34GCOVG9DSGuemlxRZtuLGuw09+VpGYvw+
         KXOyH/SDwD3pFeE5at5whcZCPpCspZKxPUvaNrxWeb1RhPxqIeipxd7hStH/ZJolOFdO
         SOfPW3UW+QeCh0gBPszxXcyuF7AZkmBMsTB34x1n/4neVfj7FxhdiLke9LJTk9Xth+rS
         2n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjQYlcDfI2yco5kK76SVjFJd0JAsA9gIL0FN2AFEY0c=;
        b=buS4Gpw6pziuiyz3dfn/9yI2bCw0YzmfMMcdRzyhwiukpN2tvrxkpoKRj1Uxq5aAWy
         gJXAkgfy5q5kR4dc9Uc4u88eHWcuLopUYSmXND6++XeQ3LKayt3alKLbI1mXhQr8TfnZ
         12u+KLEpR5/Kew2eMPC8tB1RF79DhgBocUaajcgzPOIbc45UpS7tVwYh2XGcfzlb2jny
         gv6kaqgXZfuOUyf/3+Zkv0Xc3ZJ9N6XzdDLVhg87qkFOkQ55r2M4AMcxFSSgQPMi5Tfl
         2tzjJsDr3PSC7LVAoORZr+rLj0ihybovs6X/+B3Io521OR2f76nB4uQ1DJ3mpwm0YO3Q
         5TOw==
X-Gm-Message-State: APjAAAXH5Bx9we3Ax+r5PD22+gs5gB+ZbRnBXWHEqvefqOqGIJL0ElnH
        BlJnYs6RE0/zGGkqHvHYqK9vyy0UH46YlZfPUsA=
X-Google-Smtp-Source: APXvYqwxA+cja8P0Uolv1lvIcuMWr+xMbFnYg7BW0m+L5QJB8Jf0Q/+sVz5h/+znN3FpJIUNhQ72kkWZ2miVK/JxlGM=
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr16412401wrn.242.1553018595039;
 Tue, 19 Mar 2019 11:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b05d0c057e492e33@google.com> <000000000000db3d130584506672@google.com>
In-Reply-To: <000000000000db3d130584506672@google.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 20 Mar 2019 02:03:03 +0800
Message-ID: <CADvbK_f6cDsJzXa3fzj3EFq+-hRD9EYXqbhkXq8gHqMEpqp8bA@mail.gmail.com>
Subject: Re: kernel panic: corrupted stack end in wb_workfn
To:     syzbot <syzbot+ec1b7575afef85a0e5ca@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, aryabinin@virtuozzo.com, cai@lca.pw,
        davem <davem@davemloft.net>, Dmitry Vyukov <dvyukov@google.com>,
        guro@fb.com, hannes@cmpxchg.org, jbacik@fb.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-sctp@vger.kernel.org, mgorman@techsingularity.net,
        mhocko@suse.com, network dev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>, shakeelb@google.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        viro@zeniv.linux.org.uk, Vlad Yasevich <vyasevich@gmail.com>,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 4:49 AM syzbot
<syzbot+ec1b7575afef85a0e5ca@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit c981f254cc82f50f8cb864ce6432097b23195b9c
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Sun Jan 7 18:19:09 2018 +0000
>
>      sctp: use vmemdup_user() rather than badly open-coding memdup_user()
'addrs_size' is passed from users, we actually used GFP_USER to
put some more restrictions on it in this commit:

commit cacc06215271104b40773c99547c506095db6ad4
Author: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Date:   Mon Nov 30 14:32:54 2015 -0200

    sctp: use GFP_USER for user-controlled kmalloc

However, vmemdup_user() will 'ignore' this flag when going to vmalloc_*(),
So we probably should fix it by using memdup_user() to avoid that
open-coding part instead:

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index ea95cd4..e5bcade 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -999,7 +999,7 @@ static int sctp_setsockopt_bindx(struct sock *sk,
        if (unlikely(addrs_size <= 0))
                return -EINVAL;

-       kaddrs = vmemdup_user(addrs, addrs_size);
+       kaddrs = memdup_user(addrs, addrs_size);

>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=137bcecf200000
> start commit:   c981f254 sctp: use vmemdup_user() rather than badly open-c..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=10fbcecf200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=177bcecf200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=ec1b7575afef85a0e5ca
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a9a84b400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17199bb3400000
>
> Reported-by: syzbot+ec1b7575afef85a0e5ca@syzkaller.appspotmail.com
> Fixes: c981f254 ("sctp: use vmemdup_user() rather than badly open-coding
> memdup_user()")
