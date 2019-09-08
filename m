Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84321C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528792081B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfIHMdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:33:03 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33773 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbfIHMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:33:03 -0400
Received: by mail-io1-f71.google.com with SMTP id 5so14418634ion.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 05:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Dlrt7nF+QMrAeB++A6Ck3UTmsUjVxvwblcY1dMvaVGw=;
        b=pVK20o1staP1eJsS690j1tKrw2+SpbQDrMHUga392uwnNOfbKVsXqI4cV5XRgLQeiu
         coGfMXOvind2gnOXsI52k1veSsPI0W4iX7H5lR3RdJVldBBhxLO1IN3kLsXu+EryeZgM
         Oyt+jYos3fptmkyjb8Jt/s/mjXUVDRHmBFdiz6ryz3UwcBay+shOnbmt/VEiaZPHRtjK
         jYfDaDQCvPkoKLj+pu+gsPGJXZaKzFm6wYXqmT73AbyouIB0bmdB4GJzd+sHIakPJ5M4
         Lq07QVohiRj+1yPjSEoQRnxsBOtD/SxsyIGcbgO+/cn3FMHZQnGGc0Jb4ZMcevjFWPl+
         OC/w==
X-Gm-Message-State: APjAAAUDWAsMjlIN7KnPS/knWjhQH6GHa+iyCi8jJ6G+s7OXOwe8rGYn
        JqB0ZOixRL4TZjnRBaC9B8JQ0aXo3+6PU3mx0AMk2C90BAKY
X-Google-Smtp-Source: APXvYqxLRIrArmm5jACs2Lrk6VJ5eg+Ycgp5MA+m/Uphdu7Qq3nvbW1MwZilaMC6yRKZe3KSnSSU1qER9VS/0ttQsNbDjxeHCSFq
MIME-Version: 1.0
X-Received: by 2002:a05:6638:a12:: with SMTP id 18mr16975290jan.123.1567945980605;
 Sun, 08 Sep 2019 05:33:00 -0700 (PDT)
Date:   Sun, 08 Sep 2019 05:33:00 -0700
In-Reply-To: <000000000000d2a5c60592047e58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000337872059209df41@google.com>
Subject: Re: general protection fault in cbs_destroy
From:   syzbot <syzbot+3a8d6a998cbb73bcf337@syzkaller.appspotmail.com>
To:     davem@davemloft.net, hdanton@sina.com, jhs@mojatatu.com,
        jiri@resnulli.us, leandro.maciel.dorileo@intel.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vedang.patel@intel.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e0a7683d30e91e30ee6cf96314ae58a0314a095e
Author: Leandro Dorileo <leandro.maciel.dorileo@intel.com>
Date:   Mon Apr 8 17:12:18 2019 +0000

     net/sched: cbs: fix port_rate miscalculation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=158f3c01600000
start commit:   3b47fd5c Merge tag 'nfs-for-5.3-4' of git://git.linux-nfs...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=178f3c01600000
console output: https://syzkaller.appspot.com/x/log.txt?x=138f3c01600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=144488c6c6c6d2b6
dashboard link: https://syzkaller.appspot.com/bug?extid=3a8d6a998cbb73bcf337
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17998f9e600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10421efa600000

Reported-by: syzbot+3a8d6a998cbb73bcf337@syzkaller.appspotmail.com
Fixes: e0a7683d30e9 ("net/sched: cbs: fix port_rate miscalculation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
