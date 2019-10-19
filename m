Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B89CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 04:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D77222C6
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 04:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfJSEAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 00:00:02 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48783 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfJSEAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 00:00:02 -0400
Received: by mail-il1-f198.google.com with SMTP id d15so2797269iln.15
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 21:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=enssZdcGZr8zBgaRgbTlKFGqiCX/YdzbT8JMhjDRm00=;
        b=S3QqdIwIfoQbQk+IBn7p57MUbBBRQNp1U0EkqrKsdnQUhJawvE75C8TejqkXTfEUcX
         nLeoqvegkX7e+pzm7a9vjSevrFoR0G3lnZQ7EIYpjSvvoGK0YJlA/3DTyjshoB5qUIHP
         MZxuq0pmMYmu2IVMcL2SQembkIB+4apBjnkZxPykDyEF8wEaJ8FSokj70lz2RY1B0hjq
         R1HkNbFwXSbsj4VvsN5sNTvEcCb7X7q4LI2hdvMUUFuo+pikX5EBV+0yNrXWOA9xbBTA
         dQCkrdGbfJqDX7W2JrDG5F/m+wM1+aSmswrKtif9V6Zehsn8KxuhbmBZDdcV2R4QPgXe
         TjyQ==
X-Gm-Message-State: APjAAAVPg9X5jAedwJKnEnzIUFi90roQ8O7fjyHiPBmQFDaxbGmWBgzS
        DzCp1wf/FjnBObsPnEcKQIHfJ4pB5v/TTaHZV6TiR+KOHzLv
X-Google-Smtp-Source: APXvYqz8lqgBFyZx30Xm89H2jN8QiEn0zBJRqpi9o4I5jqUpUIaAtrg8GgpM0+0dlymC4KEkM4dpnR6YmFV5vqWhd5Z8b7RZzrfp
MIME-Version: 1.0
X-Received: by 2002:a92:cb84:: with SMTP id z4mr14774857ilo.78.1571457601324;
 Fri, 18 Oct 2019 21:00:01 -0700 (PDT)
Date:   Fri, 18 Oct 2019 21:00:01 -0700
In-Reply-To: <CAKK_rcj55g8WPCLrrLdT+8zWLXXOMVf0jhMyYQj9jndy_+i8qw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b4f0b05953b7c13@google.com>
Subject: Re: memory leak in copy_net_ns
From:   syzbot <syzbot+3b3296d032353c33184b@syzkaller.appspotmail.com>
To:     a.p.zijlstra@chello.nl, acme@redhat.com, andi@firstfloor.org,
        davem@davemloft.net, dhowells@redhat.com, dsahern@gmail.com,
        jakub.kicinski@netronome.com, jeliantsurux@gmail.com,
        johannes.berg@intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
        syzkaller-bugs@googlegroups.com, tyhicks@canonical.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+3b3296d032353c33184b@syzkaller.appspotmail.com

Tested on:

commit:         43b815c6 Merge tag 'armsoc-fixes' of git://git.kernel.org/..
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9ba1b8c7fca2c71
dashboard link: https://syzkaller.appspot.com/bug?extid=3b3296d032353c33184b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118f59e8e00000

Note: testing is done by a robot and is best-effort only.
