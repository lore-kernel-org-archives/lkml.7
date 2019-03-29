Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B235BC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA0021773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfC2VsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:48:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:33418 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbfC2VsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:48:02 -0400
Received: by mail-io1-f72.google.com with SMTP id n15so2839494ioc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 14:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=csUtJ03VlaWX7nAq+6/xvvG71CB4mzfL3WY9tqfh3kI=;
        b=eZ1CTXPFZjz33N6HX48j7QWXBrrRayIPG4MfRvnDqfJzus85wTGJ5HvahRpic2Pv1P
         mdiR8riUdZrsMgDj+zpSG7/ly1g8n4rP7oXuOxsMP+tsZ8kPAxjK+fpqyiklLPR5xTVP
         EWUpOWxCWhA8WskI4OYlfqzJFAH+O76q9kmZucf3uD4L+k0rh2TxPpfEK28Orp7Ljeti
         22k1cl7YlToCYJuoy1+X2yqW9MH41wePxsjjMfzfjDPDjNgu6LRBNoiRUJpbH2A2cBHe
         X5yhMwOOZWpM03M8L3hCODSW+3XOanJpodNasSKu5hI8zsUy9hD3rYHxk1KNEkmhyncE
         Q4qQ==
X-Gm-Message-State: APjAAAXkKiieENFaiQLi7Z3fGn7YqTvdiLsx2aflHC3udDdDq4VKVeRx
        Ycy8hItFiKtQymYfiNaCwJquUATJWfyzl8hByiA7SCrKiyFz
X-Google-Smtp-Source: APXvYqxOvpH2bPBXObQjmxUmL9QwkAEk8a59Pddf3j4Jb0wn3bBGv+PLluZnijXzxpiecgQc/LptWairx4rRglJvopTxCiJwgbgb
MIME-Version: 1.0
X-Received: by 2002:a24:2404:: with SMTP id f4mr2261927ita.15.1553896081438;
 Fri, 29 Mar 2019 14:48:01 -0700 (PDT)
Date:   Fri, 29 Mar 2019 14:48:01 -0700
In-Reply-To: <000000000000ddc91405853d6de3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3bf550585429fe9@google.com>
Subject: Re: general protection fault in load_elf_binary
From:   syzbot <syzbot+0d1fcd7268b21baced4a@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 44e63c4a026325d2e085e46502121ea533a6e315
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Thu Mar 28 23:02:05 2019 +0000

     fs/binfmt_elf.c: free PT_INTERP filename ASAP

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d5c23f200000
start commit:   1baf02ec Add linux-next specific files for 20190329
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13d5c23f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15d5c23f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d8e70f94f3533a7
dashboard link: https://syzkaller.appspot.com/bug?extid=0d1fcd7268b21baced4a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125ca12f200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e1123f200000

Reported-by: syzbot+0d1fcd7268b21baced4a@syzkaller.appspotmail.com
Fixes: 44e63c4a0263 ("fs/binfmt_elf.c: free PT_INTERP filename ASAP")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
