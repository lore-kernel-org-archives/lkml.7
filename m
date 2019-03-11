Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E85C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A5720657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfCKNOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:14:01 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:36261 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfCKNOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:14:01 -0400
Received: by mail-it1-f198.google.com with SMTP id i4so5023374itb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RaNsRi5JHqh666hDwO9MIinlpT7YX8R/dBqSEIdUVQo=;
        b=EmXjO4r3jcDQEbdrrc0kevtM3tgOmNdGoVH+9+1a1DHTLRgnnIj3JRSL4TamCGXhgn
         XGjCCnn4zhXj13kS39TeVijg/xnlo9wNy7U2ukY6793kEz0/JB2bWRAYjwlzxlJs5b+1
         8LXHTQaGiucT2KCjEl5ZMHQmeVoTYrbZEoSnZg6EbJct6/dgOHF3wciu5ERdvYJMP0Fa
         h+ws6WNrePdjhEknnkShJ6KGCHIf8dAsa6vOkmiWGpSIfUcL6pL8YbPI9003eUACe1Xo
         lp7nf0NqDIhvb1f7oVig8z0Bx/ZVw7iYxWW/x/qUyMS2wG9bD9dxaAN+Qco/GesQ7jW0
         x89g==
X-Gm-Message-State: APjAAAUy400eouBFLyGOeTpxpVm2XPHf2LMXR2rr4/VcT6uyCv3efTDX
        qTlGiJ2vk7cfh141FnoDtg5HGIBwnql70owQqAXJlfWpv6ol
X-Google-Smtp-Source: APXvYqyI/6oMjijPfRgKODq444vyjAn1ZAQIoLLW4LLP0dL9Zw5DgAIoakLOOqq/+px31yVhWr+jClJ/cnm86/9BJ8tkWaJUyAoh
MIME-Version: 1.0
X-Received: by 2002:a24:4394:: with SMTP id s142mr21247279itb.40.1552310040735;
 Mon, 11 Mar 2019 06:14:00 -0700 (PDT)
Date:   Mon, 11 Mar 2019 06:14:00 -0700
In-Reply-To: <000000000000d8bec0057eec0a92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f34570583d15823@google.com>
Subject: Re: WARNING in ep_poll_callback
From:   syzbot <syzbot+aea82bf9ee6ffd9a79d9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dbueso@suse.de, dvyukov@google.com,
        jbaron@akamai.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        rpenyaev@suse.de, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f92cacf118171208f62519d92502a8dd0341286d
Author: Roman Penyaev <rpenyaev@suse.de>
Date:   Tue Jan 8 01:15:44 2019 +0000

     epoll: loosen irq safety in ep_poll_callback()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=107ae15f200000
start commit:   f92cacf1 epoll: loosen irq safety in ep_poll_callback()
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=127ae15f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=147ae15f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1521b074ff5a5bdf
dashboard link: https://syzkaller.appspot.com/bug?extid=aea82bf9ee6ffd9a79d9
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1776034b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c2e580c00000

Reported-by: syzbot+aea82bf9ee6ffd9a79d9@syzkaller.appspotmail.com
Fixes: f92cacf1 ("epoll: loosen irq safety in ep_poll_callback()")
