Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021A2C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 03:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45AF2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 03:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfG1DqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 23:46:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45746 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfG1DqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 23:46:01 -0400
Received: by mail-io1-f69.google.com with SMTP id e20so63151502ioe.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 20:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=o2kzyTbMhQL/kAorHcC+7ID+BqHWTQyphajjOBsUUz8=;
        b=cA7CccRz5izEY3dJP5dV0F4e9IXcGNQLAUOhtXd5bPojHbcKl6qC4VyTHUcuV1eFxI
         vpoZCgZzmzBphNqy59sFcmt/traSzuVuz9U3kcjDcscX3cGBpA5s22mdyarMHQbpmhng
         ADS6XVoMAht6iAg9oRUydX6f7g7Kv8WVI7wtJBrd4/Iiev/sWx5X/eBR47tajPZgJHqO
         tE6xbMZswngaxVmTxrRQZFRNUBmheZxbJtMkHAnGEwxR5y7qYFbTMQizH9Fy9G9dpXOp
         9cHaoblQw7ER0gUyHGNTLnwLJaoDLugBst1eJnomkgJ5cbybc3mu3HtCtq6dM0hYxQCy
         IKxw==
X-Gm-Message-State: APjAAAUFHGJ1t7B41uNk0glaNSfcnVasJ4Y86KL3Mo4mCfc9XbE2TRXw
        pb77CeMesYsV7ojjsNfxuoCBp77a6A4jIxXt1rUuZx8HnCZO
X-Google-Smtp-Source: APXvYqxXM+e7HkG1ndOj4S4xy8tLRGbSOz7rHomFcVxe9opbIqsbCOX/jEqUOK4tXAcI7y8l03aMdveo9Zu26OKpCrjDuyQnBW0q
MIME-Version: 1.0
X-Received: by 2002:a02:878a:: with SMTP id t10mr33742269jai.112.1564285560945;
 Sat, 27 Jul 2019 20:46:00 -0700 (PDT)
Date:   Sat, 27 Jul 2019 20:46:00 -0700
In-Reply-To: <0000000000002b4896058e7abf78@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000300996058eb59dd7@google.com>
Subject: Re: general protection fault in tls_trim_both_msgs
From:   syzbot <syzbot+0e0fedcad708d12d3032@syzkaller.appspotmail.com>
To:     ast@kernel.org, aviadye@mellanox.com, borisp@mellanox.com,
        bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        kafai@fb.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 32857cf57f920cdc03b5095f08febec94cf9c36b
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Fri Jul 19 17:29:18 2019 +0000

     net/tls: fix transition through disconnect with close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155064d8600000
start commit:   fde50b96 Add linux-next specific files for 20190726
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=175064d8600000
console output: https://syzkaller.appspot.com/x/log.txt?x=135064d8600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b58274564b354c1
dashboard link: https://syzkaller.appspot.com/bug?extid=0e0fedcad708d12d3032
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14779d64600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1587c842600000

Reported-by: syzbot+0e0fedcad708d12d3032@syzkaller.appspotmail.com
Fixes: 32857cf57f92 ("net/tls: fix transition through disconnect with  
close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
