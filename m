Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B87AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D5A21855
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfGXXOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:14:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:53832 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfGXXOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:14:01 -0400
Received: by mail-io1-f69.google.com with SMTP id h3so52791089iob.20
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kTUfPT7c0ElAMixkntemJj1auET+ylmETk1M6iNdZMM=;
        b=izMT2tVeoJNvBPWZHMHOcV4uE1MJ4/wHfQ+iVkcXAcbQCrgEtTd1liESzYgMv7Pex6
         LEE2ycDzXazeBMFbyPKP4tkeptXZvxrhCgk2MwTQI4NBtLSHs1JLhsG+Dtar5wQFuwyJ
         noupUJ3xgLXlUuzjjWFk0J0gzp9iUBwxSDGpH0HsvGXwNH36uXKfB9tFDpHUCMGO23tC
         zvc7MbwLZM9xbVWNwTSdB5cMjs7TXsscyeUqmDQDBJvE49lUlySLJiHCB/Rgm7DY7j2X
         JPWui77b+2ajbyKCvPi1OMdzC86O6EENF2cbJp9v/viI4xsP9CwZC584/mNVY72XKi0i
         wXqg==
X-Gm-Message-State: APjAAAXECYZgFHMHo9d+/sMJvBBBn5UHxmeuxZHP+l6Xb7bFX7pUEF3w
        +tcfYfDRVu/497rc+YDRusQtxGpDI9UNBjfoGdkRyGNRVOsw
X-Google-Smtp-Source: APXvYqw6yDry1o8jGg/0v1gL2svqsUlEFZJu+ska6MMsY9aYOFn/bqoA0H9Yjt85u9KdNPpHAyn19XfZy9a89LpNooy/F/qjzH6x
MIME-Version: 1.0
X-Received: by 2002:a5e:8e42:: with SMTP id r2mr75257057ioo.305.1564010040835;
 Wed, 24 Jul 2019 16:14:00 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:14:00 -0700
In-Reply-To: <000000000000464b54058e722b54@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8c654058e7576ef@google.com>
Subject: Re: BUG: spinlock recursion in release_sock
From:   syzbot <syzbot+e67cf584b5e6b35a8ffa@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, aviadye@mellanox.com, borisp@mellanox.com,
        daniel@iogearbox.net, davejwatson@fb.com, davem@davemloft.net,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        john.hurley@netronome.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, simon.horman@netronome.com,
        syzkaller-bugs@googlegroups.com, willemb@google.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 8822e270d697010e6a4fd42a319dbefc33db91e1
Author: John Hurley <john.hurley@netronome.com>
Date:   Sun Jul 7 14:01:54 2019 +0000

     net: core: move push MPLS functionality from OvS to core helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ca5a5c600000
start commit:   9e6dfe80 Add linux-next specific files for 20190724
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=102a5a5c600000
console output: https://syzkaller.appspot.com/x/log.txt?x=17ca5a5c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cbb8fc2cf2842d7
dashboard link: https://syzkaller.appspot.com/bug?extid=e67cf584b5e6b35a8ffa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13680594600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b34144600000

Reported-by: syzbot+e67cf584b5e6b35a8ffa@syzkaller.appspotmail.com
Fixes: 8822e270d697 ("net: core: move push MPLS functionality from OvS to  
core helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
