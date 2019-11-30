Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01B3C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 21:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1832082E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 21:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfK3VEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 16:04:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:36930 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3VEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 16:04:02 -0500
Received: by mail-il1-f199.google.com with SMTP id t19so3307857ila.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 13:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ajRnvypnjscQlLjcnb2EcjX6WsZvwjmcn8iDAJm1MBA=;
        b=SzCrl6YcECBnC1nV1ATVO11c9pZgMjU/3q9wGGrvUPelzJnKLXRWUMgZ40Y86Fs43A
         KjD2b2K8bmyb3nKdGi7rCmTNuzQ1zyrq+YmwZdhfweHUr/3ab9afIo7ZOOy/YUl5DkoI
         av1U0z+Wl5eStXISZZ6ePRL7cYKY0rcxwoL+oH6C4Y9EqOLpgBDMR+j9oslt9L/QlIZY
         2gWDATfMW3xS5oAind1Ey4EKWxovDL9rFxqEsuVL+DmHfkAMb2nvLTlrQN0seyQkTdk6
         ABHMnk4suUh/WUGMs2AJYySRhOteBNtUhXCTG8SUd/85DBFp+K2WxKlTRQHanWccQZPy
         Jl3w==
X-Gm-Message-State: APjAAAUvsdcMo5eYjlwbygnlKbBhruAa176OqKSbvsz7RYOUMwWNSELo
        7DpyDofFSZs6uOr4g8SrvGt3Kh5Q2DyU/ehmB3+KJLQWa4aU
X-Google-Smtp-Source: APXvYqyk0rTcqugfdtur6uiuIuBVEo0q39xqazGWbjHn8D5vwxIrxEHCKojMOgpwHWUMv5+j3+qw1ag0Lxh+CojKUAkDMAHfCxI3
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3b6:: with SMTP id z22mr8076076jap.35.1575147841422;
 Sat, 30 Nov 2019 13:04:01 -0800 (PST)
Date:   Sat, 30 Nov 2019 13:04:01 -0800
In-Reply-To: <089e0825d4a4d2cb2a0562e878f1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e8a99059896af4c@google.com>
Subject: Re: possible deadlock in sch_direct_xmit
From:   syzbot <syzbot+29cc278357da941e304e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        lucien.xin@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit c84bed440e4e11a973e8c0254d0dfaccfca41fb0
Author: Xin Long <lucien.xin@gmail.com>
Date:   Sun Oct 1 14:00:56 2017 +0000

     ip_gre: erspan device should keep dst

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=153a767ee00000
start commit:   c92a9a46
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=173a767ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=133a767ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46986c099cb53bc6
dashboard link: https://syzkaller.appspot.com/bug?extid=29cc278357da941e304e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143636c9800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16856849800000

Reported-by: syzbot+29cc278357da941e304e@syzkaller.appspotmail.com
Fixes: c84bed440e4e ("ip_gre: erspan device should keep dst")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
