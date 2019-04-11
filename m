Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AB1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5282146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDKVjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:39:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:33034 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfDKVjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:39:01 -0400
Received: by mail-io1-f72.google.com with SMTP id n15so6119409ioc.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 14:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BuGuw+B3+zSCJRG2xo6aXZeyAoyiaNxoNELkYlLxkds=;
        b=dLHAseLn7+cZL4of4muT0YRxeKO+1cnQ17d3LKxPUr6l6dXlYU+HyYQaTc1KxAtRn3
         7cFWWA5K1yKpyYGg7Q5427CuL68Tu55/Oge9Doi2lvTJDMWeoGOnzAe+O8bwsRXMurKz
         zPTPqOABzzICCd+vqoomQO1emFFi5t4fKlR5YjUIknruz5UQBNKhwvcY7NtEfuDzjqrn
         S1A4K3oVbCmGkGx1BlGhbfq6CR0lsz8Wn9wwxxxduBbnsGo2ctQXlr3qcW9/fZvtpd2D
         CT1/Jm3AXu5eNrZFgbVap/ItHfY382+yuc8FlWloOQ2o5EqA/K5XZsOR9WjCbWw/08qu
         ojmg==
X-Gm-Message-State: APjAAAWSC3vuCl2wHTCFKGbAcxme6URTrkhTfFQBHjFd49wfb1sdVP6C
        8q6Bi4ie3DJEPh6mrG0hT8vps1QyCukLzPJBjgvP9RsTKnXp
X-Google-Smtp-Source: APXvYqzzOvrjkU3rc6F0ZjvCgbKzqgos6hIYsoL30G5AS8XDW7AN0ft+e91rUo8o2EytYbK9mgr5dzXYq8Dmg9EuxLfRsGy+czZM
MIME-Version: 1.0
X-Received: by 2002:a24:440a:: with SMTP id o10mr2886517ita.31.1555018741065;
 Thu, 11 Apr 2019 14:39:01 -0700 (PDT)
Date:   Thu, 11 Apr 2019 14:39:01 -0700
In-Reply-To: <000000000000a819440574900515@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae2c7605864803ff@google.com>
Subject: Re: general protection fault in kvm_pv_send_ipi
From:   syzbot <syzbot+86c0a866f80d88349f1f@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hpa@zytor.com, jhs@mojatatu.com, jiri@resnulli.us,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vladbu@mellanox.com, x86@kernel.org,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 653cd284a8a857ddfcf24f5bc3bd204a229f6c9f
Author: Vlad Buslov <vladbu@mellanox.com>
Date:   Tue Aug 14 18:46:16 2018 +0000

     net: sched: always disable bh when taking tcf_lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e25dbb200000
start commit:   05193597 Merge branch 'for-4.19' of git://git.kernel.org/p..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15e25dbb200000
console output: https://syzkaller.appspot.com/x/log.txt?x=11e25dbb200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b576e333ca31bb2
dashboard link: https://syzkaller.appspot.com/bug?extid=86c0a866f80d88349f1f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137d861e400000

Reported-by: syzbot+86c0a866f80d88349f1f@syzkaller.appspotmail.com
Fixes: 653cd284a8a8 ("net: sched: always disable bh when taking tcf_lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
