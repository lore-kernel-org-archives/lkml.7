Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6D3CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F68205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfJ0GdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 02:33:04 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:53908 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJ0GdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 02:33:03 -0400
Received: by mail-il1-f199.google.com with SMTP id a17so6555314ilb.20
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 23:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lGwoFEs6atbJNjfwbsMMgVdENVRKdZeDwx59pl7Gnc0=;
        b=puPLVexcd0QY89M7n1s5s4qPieUeR52gO6nJ9B08ot6SDZQ+98E+9yQjUV7u4cIHu4
         3EoOWH6thDVVEEgHFaE9nXnkA4QVyjnyx2lfkGKMETruQnDM1/z/uMWdiZNGQujOGGep
         5kerf/3S/f7iQcHaQAlE4CGoE2Fdfz1c3FJmfTOfslGT8UAQqgPYwhOVVVlnIJ8OrJeu
         lkImlG473Tp9JEx/umG5dXMXjH5zUxNOn0sMeceZhEW50OLPy17WP9JaVhuQDs2nLm7M
         Yqm5CH/GchDfeklxxMYgqAIhy+6YZc88oSZ6UPBPbQsTBxuFThQ2lSOuiPQf2ptGTY9S
         IHhQ==
X-Gm-Message-State: APjAAAWI840XPabWblqfCQdzfEl1PmlPBC0zGxhHTj9BGcLkfPzvUftp
        QWl5ICdTHAJId/zO//9pFP4yzxXMKw5TjsEByJ2q+TtrHuTQ
X-Google-Smtp-Source: APXvYqybyCpDlrzzUeGRwdrxvaNZyICTlgNIiEO6W6PPjlDKJOGQERHCbQp+yT2DLtml2AKv0s7y2mTm9ga/zJuCHcqdxwm21NZZ
MIME-Version: 1.0
X-Received: by 2002:a6b:5503:: with SMTP id j3mr12197785iob.151.1572157980811;
 Sat, 26 Oct 2019 23:33:00 -0700 (PDT)
Date:   Sat, 26 Oct 2019 23:33:00 -0700
In-Reply-To: <000000000000fbbe1e0595bac322@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa2e630595de8d05@google.com>
Subject: Re: KASAN: null-ptr-deref Write in io_wq_cancel_all
From:   syzbot <syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk,
        dan.j.williams@intel.com, dhowells@redhat.com, dvyukov@google.com,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        joel@joelfernandes.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, mingo@redhat.com,
        patrick.bellasi@arm.com, rgb@redhat.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit d5f773aba1186142d52aef8242a426310a39fa86
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Oct 24 13:25:42 2019 +0000

     io_uring: replace workqueue usage with io-wq

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142c6d18e00000
start commit:   139c2d13 Add linux-next specific files for 20191025
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=162c6d18e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=122c6d18e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28fd7a693df38d29
dashboard link: https://syzkaller.appspot.com/bug?extid=d958a65633ea70280b23
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160573c0e00000

Reported-by: syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com
Fixes: d5f773aba118 ("io_uring: replace workqueue usage with io-wq")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
