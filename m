Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF66FCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9F42064B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408147AbfJRK1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:27:02 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:38243 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733031AbfJRK1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:27:02 -0400
Received: by mail-il1-f200.google.com with SMTP id a7so1653632iln.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 03:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4JoPCUxM0SmhsnlFHKFjSP4adziJaRApk9VYV5+Ut5c=;
        b=EMj/r54AV+OdJuuxHb2Q3XdecBY/KG28EOeM2+pSmW+5/Tf+pAnDJMeXaGuRH5hOPg
         Gg+IzDkMdxthidSOnBrpt4tjNUDucaXAUaVHk+motcxjyqa4PjE/RHX4YjL9PDGnSr7o
         y6Q9Kb89rRpWapc96mFT5DHNr4nuYPlR2Vs6U53Wfh6HAv8gRHRkZhj2q2ojY0t2F2xa
         5uBTS8zHTh12fNZqEXagWZ8+l3ZnzZ67kUMAG9s/mc+RkyOafqp19Ahov7Q9dMtw3tdw
         /BPxLfvLLGRNessPQ6GuQ0crw6k1EReL2W2OAsKSE+4BE7H/st6aAteANmLciwbMYs4J
         1qfA==
X-Gm-Message-State: APjAAAXYc3BlOccl5P1sbEgh0fZWCM1Lj+e28tf12HbciWlO1cvOkIm6
        Vraz4Zc4RYhvSu7pNHO4XIn1yCOdYilKvWJE+GTiYLr0NcPn
X-Google-Smtp-Source: APXvYqwLOMpW6VAezBgHBiWGwlAKQuAIHa3svUkCYFs+Ik2sdZOXklZJzjUj6Elt89PUXjwILVjKRboMtHG/HjPXYU5BCTXlvWNy
MIME-Version: 1.0
X-Received: by 2002:a92:d784:: with SMTP id d4mr9462227iln.110.1571394421258;
 Fri, 18 Oct 2019 03:27:01 -0700 (PDT)
Date:   Fri, 18 Oct 2019 03:27:01 -0700
In-Reply-To: <000000000000410cbb059528d6f7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048021005952cc62b@google.com>
Subject: Re: BUG: unable to handle kernel paging request in is_bpf_text_address
From:   syzbot <syzbot+710043c5d1d5b5013bc7@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, hawk@kernel.org, jakub.kicinski@netronome.com,
        joe@wand.net.nz, joeypabalinas@gmail.com, john.fastabend@gmail.com,
        kafai@fb.com, linux-kernel@vger.kernel.org,
        mauricio.vasquez@polito.it, netdev@vger.kernel.org,
        quentin.monnet@netronome.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 6c4fc209fcf9d27efbaa48368773e4d2bfbd59aa
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Sat Dec 15 23:49:47 2018 +0000

     bpf: remove useless version check for prog load

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14306908e00000
start commit:   283ea345 coccinelle: api/devm_platform_ioremap_resource: r..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16306908e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12306908e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0a8b0a0736a2ac1
dashboard link: https://syzkaller.appspot.com/bug?extid=710043c5d1d5b5013bc7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142676bb600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a2cebb600000

Reported-by: syzbot+710043c5d1d5b5013bc7@syzkaller.appspotmail.com
Fixes: 6c4fc209fcf9 ("bpf: remove useless version check for prog load")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
