Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82548C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2BD222D1
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbfKGNmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:42:31 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:42994 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389193AbfKGNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:10 -0500
Received: by mail-il1-f197.google.com with SMTP id n16so2655968ilm.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ts1/QN7SlZAv8FzCyonCkAig7h5V9G7HkY3ov7xjs3M=;
        b=cHRM5kNmj6aQY2LJVS3MRyQMmBVELsi1Z15h2z9iuDzku5qTJrQgEnuG+vvJcB3SJi
         qOxDioJG6lChlgR3PTZv3XC51I0gZGKti+jViWO/iCIjOibfAhc05bEwygtlmCkSosEB
         tmvObJsQ6851Ss1LHt/dmns2/tc5Xwx0yJFKTMLKbkto2sS4NjuR/iXi+ajCZip4gb/5
         FCiGnKNqDRVxbudPH5WiqqjxJ025yABKFywFG9r53/QUVnE29aMfnjJ5DgWg7hBWZSra
         E4CL1YVBGHEklpqdP+l04gIEKziOhfNOskf4fZYz/GACzni+t6U/ww/FPFpnzmscb/cW
         /f9A==
X-Gm-Message-State: APjAAAWr+BYMvj3bev0YMyrxzUSNziTfdf7tQhAfuPKxVmvc+JceDjgE
        zzFb8twPGprwDrFpvvpcWLmDJuQHPhtCn7pyZwOCnUBUKlDn
X-Google-Smtp-Source: APXvYqz/g3akW+HYZOqq00GOcwk4TIgPuwUmUsNZ8JleeVUWjArlNV1JzK0GZVOa198jjNQXsMlAh0R+qyRRrxrnABjAL9dYZK4H
MIME-Version: 1.0
X-Received: by 2002:a5d:9f02:: with SMTP id q2mr3553203iot.3.1573134129497;
 Thu, 07 Nov 2019 05:42:09 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:09 -0800
In-Reply-To: <00000000000006602605752ffa1a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f90bb30596c1d438@google.com>
Subject: Re: general protection fault in tcp_cleanup_ulp
From:   syzbot <syzbot+0b3ccd4f62dac2cf3a7d@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, john.fastabend@gmail.com,
        kafai@fb.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 5607fff303636d48b88414c6be353d9fed700af2
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Tue Sep 18 16:01:44 2018 +0000

     bpf: sockmap only allow ESTABLISHED sock state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fdc73c600000
start commit:   28619527 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=0b3ccd4f62dac2cf3a7d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13537269400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: bpf: sockmap only allow ESTABLISHED sock state

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
