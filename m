Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1E3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4413C2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfC1XqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:46:02 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:41436 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfC1XqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:46:02 -0400
Received: by mail-it1-f197.google.com with SMTP id q184so493967itd.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 16:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8blUUY3Z+Vwvz4W83sqp0uB4hzITpzSvBDE5pi9mytY=;
        b=sRAw6COZxBMF20YQUsrzt/iYKudJwWvirInvKbap1Lt6Y33bWtMZCgNENdvxlH36N0
         BENzyIwYyL3NGJDNvhjcX4mJhx3otpQMnJZ5nBkIHiWbvhXnRTuc+9KMK86BLMJg3IBF
         NPdqvUFynBsoWJk7Ids4uNfMZEpdIB/xxch7pPGLh4xcAO/MHs1AuCEg/Ru+5C1SbO/t
         dWoSZWP3NskY/pNDPS0KvlYt7HjEeOJyDMKDhMYX5pAl2JzKM6jPMNYzshk2hCeTrX7K
         cRzYr80Ff/XTwjjisARX5TISDCFhnP/Nv3pFf/cySk+bBRhDC5ut2paKlmD5y/S1/XYW
         uSiA==
X-Gm-Message-State: APjAAAXkrN+wfBwm67IrVSYbu4F6tPzX9FLz+n6VvvUOS5k+nc8bEWm4
        mr77WOlDwURBHg63vG2klkHQif73TlA9/ztdX9JGaps4hPob
X-Google-Smtp-Source: APXvYqy2gtPfFP7KvJ7luiQX1pGGkNy+qtndYsuoUj/PQFdhbhJgJ7+kkCijz1sn1urKwdqvhw8v0RdbO3jEhE/edzfsuianrKNr
MIME-Version: 1.0
X-Received: by 2002:a02:2501:: with SMTP id g1mr4132133jag.25.1553816761273;
 Thu, 28 Mar 2019 16:46:01 -0700 (PDT)
Date:   Thu, 28 Mar 2019 16:46:01 -0700
In-Reply-To: <000000000000ea60e6058529d77b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a141505853028fd@google.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (3)
From:   syzbot <syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com>
To:     a@unstable.cc, arve@android.com, b.a.t.m.a.n@lists.open-mesh.org,
        christian@brauner.io, davem@davemloft.net,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        maco@android.com, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, tkjos@android.com,
        tkjos@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 1a7c3d9bb7a926e88d5f57643e75ad1abfc55013
Author: Todd Kjos <tkjos@android.com>
Date:   Fri Feb 8 18:35:14 2019 +0000

     binder: create userspace-to-binder-buffer copy function

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b9383f200000
start commit:   1a9df9e2 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17b9383f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=13b9383f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
dashboard link: https://syzkaller.appspot.com/bug?extid=f9f3f388440283da2965
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d05637200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1677e62f200000

Reported-by: syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com
Fixes: 1a7c3d9bb7a9 ("binder: create userspace-to-binder-buffer copy  
function")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
