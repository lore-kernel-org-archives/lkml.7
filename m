Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6628C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6CE2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfDLLmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:42:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:53728 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfDLLmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:42:01 -0400
Received: by mail-io1-f71.google.com with SMTP id w11so7510009iom.20
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WMoAyI6Kz7akt6IzeJ25Lh5Dd804vIwoNiYa+gRa5os=;
        b=Ro/dkBT8rFrUG+BbYDuZSgGveviz5x/3oWU2B/8LHgP/AIfVF2Mtwz5hgmd9zkndzL
         c5WLjAVlEDuQ8G74tCY0+ooDgfix9khA2a8JKixIvRaRBPNAONs+XWoDWJuYQmN0Lo3w
         GndI/RxxoKXZkRctbakWBFZO/1sC0/gh+pfJ3AY7mNCynGIosCvb0crhaE+t5V9HYDhL
         IhRYZfaoI1qg8BGiy/iguLqij0LgihqLjhOYjQ8mKFjp9uVMtQViDxRKim7ihJLRPczn
         tek4/QrIdkX3GEpr8DqMPZN6hQCnX42pz8kkxVqJ5cV4djjSIWI9izOJ2ClJTdItI3d7
         CgTA==
X-Gm-Message-State: APjAAAXEZnEVHrDWsvfOOxu7t472v084kRdeTNg0kzgSy9HAAf2bx9Ua
        efI8kZoeUvcLcnc/paHGG+BLQUtpsZ73misQmbiudMTSjd5v
X-Google-Smtp-Source: APXvYqymLx6mbqOFGvxKGr4yPEdhIfPdv33q6PFUapyRLFVuTAuuHYwAQXVP6x3zU1CrIW0aYnDsFjR5iSV9zcchsZ9Cv/qov/gV
MIME-Version: 1.0
X-Received: by 2002:a02:4e46:: with SMTP id r67mr10136960jaa.8.1555069321017;
 Fri, 12 Apr 2019 04:42:01 -0700 (PDT)
Date:   Fri, 12 Apr 2019 04:42:01 -0700
In-Reply-To: <000000000000f70a0e0571ad8ffb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b03eb058653caea@google.com>
Subject: Re: WARNING in untrack_pfn
From:   syzbot <syzbot+e1a4f80c370d2381e49f@syzkaller.appspotmail.com>
To:     Julia.Lawall@lip6.fr, bp@alien8.de, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, dave.jiang@intel.com,
        haozhong.zhang@intel.com, hpa@zytor.com,
        jacek.anaszewski@gmail.com, julia.lawall@lip6.fr,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, pavel@ucw.cz,
        pbonzini@redhat.com, peterz@infradead.org, rkrcmar@redhat.com,
        rpurdie@rpsys.net, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit c68729119f4d2993bec3c9cb999ad76de5aeddba
Author: Julia Lawall <Julia.Lawall@lip6.fr>
Date:   Sat Jul 15 09:58:19 2017 +0000

     leds: tlc591xx: add missing of_node_put

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12cda0f3200000
start commit:   23203e3f Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11cda0f3200000
console output: https://syzkaller.appspot.com/x/log.txt?x=16cda0f3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=861a3573f4e78ba1
dashboard link: https://syzkaller.appspot.com/bug?extid=e1a4f80c370d2381e49f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17836d15400000

Reported-by: syzbot+e1a4f80c370d2381e49f@syzkaller.appspotmail.com
Fixes: c68729119f4d ("leds: tlc591xx: add missing of_node_put")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
