Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB4DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 02:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4854E20409
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 02:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfL0CrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 21:47:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:46326 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfL0CrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 21:47:01 -0500
Received: by mail-il1-f199.google.com with SMTP id a2so8359926ill.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 18:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9wUyWhkVCaEXCNwORLXmBdo7IR6pgdqnHT8ZPHyEEOI=;
        b=YNzrbLXNGZdbvktIzV0J2syfubLE+RFVaj5Fd8J/PfXY2nVGYkIemjm2dFSiytmDt0
         38dqz++ubbykOqwxLCrGWp7chABG3Y9HxOhWICj6aipaGc4rM0MvXPhA49vPG4C4YAr7
         l0IWR/u5le70CDAu6Vvr0di6lamoLjVVC4j1+0MlfeRbvJ1IQmK9cLivjmJHAjfB1AEp
         rUsJ2ChOFoNJnSs+6gymFjupmTH9EDvNPaN9vmmPBU9AHpzfMGaJlnu9uDDeBVJV4lIA
         fTvZZZ+jqDeUsK7JrwplxUoVMId7EMlGfv4UqETVQN+sA5ngobxu6ypHDLg3JsCgGZN/
         vZ6g==
X-Gm-Message-State: APjAAAVaK8zgd42fJHmMuiwJ+bj3M5qaqaJ+XAhCYMfjDDY++AGceHoW
        /TwODlDvDSte9PJ5vALeh9glKPIc+TY1FDrb9lQRYU0OGv89
X-Google-Smtp-Source: APXvYqy/glUbW4fyY45ilDNcSBPrbmY8p44WAOpcXDXHF91TBRPIzoRZYjV4mJKH8foQH5c56NeEd3d20Al3XaiB4s0DhImJVTjq
MIME-Version: 1.0
X-Received: by 2002:a92:d809:: with SMTP id y9mr44099353ilm.261.1577414821279;
 Thu, 26 Dec 2019 18:47:01 -0800 (PST)
Date:   Thu, 26 Dec 2019 18:47:01 -0800
In-Reply-To: <00000000000057fd27059aa1dfca@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015fd8f059aa682d3@google.com>
Subject: Re: general protection fault in xt_rateest_tg_checkentry
From:   syzbot <syzbot+d7358a458d8a81aee898@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com,
        fw@strlen.de, kadlec@blackhole.kfki.hu, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 3427b2ab63faccafe774ea997fc2da7faf690c5a
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri Mar 2 02:58:38 2018 +0000

     netfilter: make xt_rateest hash table per net

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151a26c1e00000
start commit:   46cf053e Linux 5.5-rc3
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=171a26c1e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=131a26c1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=d7358a458d8a81aee898
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13713ec1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1272ba49e00000

Reported-by: syzbot+d7358a458d8a81aee898@syzkaller.appspotmail.com
Fixes: 3427b2ab63fa ("netfilter: make xt_rateest hash table per net")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
