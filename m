Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD68FC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A139207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389578AbfKGNnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:43:46 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:39665 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388985AbfKGNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:06 -0500
Received: by mail-io1-f69.google.com with SMTP id e17so617856ioc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uJH7mAU4uCSDV4aa0L0fNAi/CNHQFgrnxb0qCcwKuQg=;
        b=EYBgBRL8h1MVtWRuTXtMQZgQhR8SG8jm1Zvu4IIAKWkP7T4m6KMcsVysD9ojFJln4M
         FR29oNt4JWL5nk8eC0WakUPwL+QUzqQ8T6eqaiUbPwLAKVlMTgq9+TrQSR6I4AkWz2X0
         BChcgvm2Lz2J/VAL9NSXqhQptIKSac91D7vEEEm+s2hdJxB2VLIWgGyPfzSOd9EBXVmZ
         e7R0k8o+QcKqffg8HmexUujp7cym7ee/KUrWqVvtI6+yJvTv5eKWIRnXDK9tSyXXUuON
         9smxdYhhGx9t4Di83mXApIbqpgJbmFwNzB+fCtRq1mp4tiQD0zVYnI8hbNti/2qFGTzg
         wlbw==
X-Gm-Message-State: APjAAAVL38aypkn5vdF34hDRiuPt0JEWAEoPdsSgY+54r3kcbyvx4Qhn
        oulhV2IRjrI8aF09IuEXzruMlkYvcn361f1Dxp7e36N6VYUX
X-Google-Smtp-Source: APXvYqyHrfdUeqRJ/p/UmqwSEH2PGF9vcIIDWWp+x12afNV5pmko9MIPBQwQ6EP0UabIBzdD2tA0EO3kdrl2IMEkfnCzwaSnZ0AC
MIME-Version: 1.0
X-Received: by 2002:a6b:ed05:: with SMTP id n5mr3546499iog.273.1573134126204;
 Thu, 07 Nov 2019 05:42:06 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:06 -0800
In-Reply-To: <0000000000006971fa05769d22f6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6cd1b0596c1d4a2@google.com>
Subject: Re: WARNING in request_end
From:   syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com>
To:     dvyukov@google.com, ebiederm@xmission.com, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 4c316f2f3ff315cb48efb7435621e5bfb81df96d
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri Sep 28 14:43:22 2018 +0000

     fuse: set FR_SENT while locked

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113124ba600000
start commit:   0238df64 Linux 4.19-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=ef054c4d3f64cd7f7cec
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119bf2e6400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1760f806400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: fuse: set FR_SENT while locked

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
