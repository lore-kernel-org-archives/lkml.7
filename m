Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AC2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1269B204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQ2jcoc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfCVIGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:06:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40339 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfCVIGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:06:53 -0400
Received: by mail-io1-f67.google.com with SMTP id d201so1005085iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 01:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lnx/OtXGa+Hf1jCaNVrW1mB1C5VxxvGul/Ub814nrtM=;
        b=KQ2jcoc/zMr1CL7SajhRGH54HS42OH9dR8Q6MUtFtOypc7ysfY5lmTOov+io9biTgx
         9CKpoDan6RfcoOSnIBDW60A57PYqQjEVZrK1o7qzSplkZMyiK93BCew5OyBhZQx1Yfmk
         pqx3O7N1Qik11tuJsv0Bs4lWCyEmBeILtfSyCcjYwlV6C11cSDNzYCKAuawF8EngRSrl
         c7Vlh8QYPtGnKa6b6PU99F9DEllp2heMK5uJ3R6fF3Z9QlxDE9eVCVk+rIE7kbZYxxqT
         XwQpWew6hTMcBtz376SV6CofOg0CxKRnOZf4Fa2k1T6vopeS9l1OmSj7A/gcSpFWziP1
         vqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lnx/OtXGa+Hf1jCaNVrW1mB1C5VxxvGul/Ub814nrtM=;
        b=VrCp++wakgkTNGKJ4F2kEfiWEgYtiF6Xn2pdJ1d4gcXRDVMkZlg/2fsNW4CV+G8cCc
         yOvbHT5tJ/aH1s0NT4+KL7NbbiNmycjAYqAii3zMhug87Z4zlyclIerfrj4c2Rc3ARDU
         Bizt8a49dJNco8PCd3QzS+XUNNL5BVXXy0k6aN5VkAmVH3qmyago7K7HKaGm3iXk7z5o
         Ovzy/wuT2uRPLDLNQzHThxjnPFpKWFDLQCbUVQehbUr/KzM7thpBEqpWJ5ZvD4+37zQB
         3TJMUUecCk0xCogZyG5O6li/sOpOvGdWP9W/MWkcc9aLztlGhUC4Hxcn3NuvryRXPKBp
         A00g==
X-Gm-Message-State: APjAAAUgLNp/9G2BGqGrJVuZA5GKfMkXw/AmR7L3s6aJzjQccBoGRLBJ
        z4UVnzDc62iRCYvZdteG4xn1gVN0CC5MPLo6ULsgpg==
X-Google-Smtp-Source: APXvYqwFoHNu20ucFnMXaMALGZ4WzKFg1BgYrqqHPqm7B2NabZMVb1LVdO3X4Mg0ve11btHHLHER4G9b0sEW0YoqxUQ=
X-Received: by 2002:a5d:9457:: with SMTP id x23mr2347723ior.271.1553242012743;
 Fri, 22 Mar 2019 01:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000080601805795ada2e@google.com> <000000000000e626290584a983c0@google.com>
 <CACT4Y+YVNA6aYe-Ai-ZnU+EhNSNAFhjvXPT0oA+i4rCFpQThcg@mail.gmail.com>
In-Reply-To: <CACT4Y+YVNA6aYe-Ai-ZnU+EhNSNAFhjvXPT0oA+i4rCFpQThcg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 22 Mar 2019 09:06:41 +0100
Message-ID: <CACT4Y+aVXJuaBsvwM-7UcpDzvPZG8HaFHPnHQMX1ZzE1Emd-Tg@mail.gmail.com>
Subject: Re: INFO: task hung in vivid_stop_generating_vid_cap
To:     syzbot <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com>,
        linux-can@vger.kernel.org
Cc:     andy@greyhouse.net, David Miller <davem@davemloft.net>,
        Hans Verkuil <hverkuil@xs4all.nl>, j.vosburgh@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        Mahesh Bandewar <maheshb@google.com>, mchehab@kernel.org,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        vfalico@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 9:00 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Mar 22, 2019 at 8:08 AM syzbot
> <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit 4493b81bea24269df898339dee638d7c5cb2b2df
> > Author: Mahesh Bandewar <maheshb@google.com>
> > Date:   Wed Mar 8 18:55:54 2017 +0000
> >
> >      bonding: initialize work-queues during creation of bond
>
> +linux-can
>
> I think I will disable CONFIG_CAN before v4.12. It causes too many
> false results for v4.12..v4.11 range. It always leads to a wrong
> decision for first 3 steps, then no chances of correct bisection
> anymore.

The same seems to show up for v4.12..v4.13:
all runs: crashed: INFO: trying to register non-static key in can_notifier
https://syzkaller.appspot.com/text?tag=Log&x=1555b12b200000

This was fixed by 74b7b490886852582d986a33443c2ffa50970169 right?



> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176d1617200000
> > start commit:   4493b81b bonding: initialize work-queues during creation o..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=14ed1617200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10ed1617200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=62118286bb772a24
> > dashboard link: https://syzkaller.appspot.com/bug?extid=06283a66a648cd073885
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15701a33400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154c8e4d400000
> >
> > Reported-by: syzbot+06283a66a648cd073885@syzkaller.appspotmail.com
> > Fixes: 4493b81bea24 ("bonding: initialize work-queues during creation of
> > bond")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
