Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEA5C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0562186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbfGSUEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 16:04:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41404 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfGSUEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 16:04:00 -0400
Received: by mail-io1-f72.google.com with SMTP id x17so35516783iog.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 13:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aPsM7izy0lsHgieRMKZNuSLjrGTa3/1dak1h6g1FuBU=;
        b=ONw4Sp0YT8K3LKZkqg7XhjgemBfmvPVQUKdp2wfSxT6HxjJ2Sy3YC/2+JkQPr8AmHd
         mkuMQhjDLZWRLrEgIl813p6SgvyzNsRPnT3y69/H/OmHduxvQJdTo9ngkDjahE6QXPOs
         ULmcaf5ytTtP6PxyXL8+W70HiwlzRGpu/r74ZwbfmmKu22CGHudKdFcHaj9baw+QY/z+
         S5G3/qqdkrMpbPn0XTQn6ECiZBIdhuKa14R1k8WPhv5cDgXLEOcQVEihepKjznNtkUIL
         4IvhBswpb2aHBo0reglD72jxG3GLBM/5yKXADO4GZr4oHc/svVlpfRnclJHLYslqUjRO
         2uJg==
X-Gm-Message-State: APjAAAVDC6lJ2CIrsN3p6ccUxfhGNqxdSR4EeziQDQNYNpst0zMmqyR9
        1Nmw0fqMMRU6sm6BNjHOcXMQm9ZIXWXa/N00luOLnruNnhUJ
X-Google-Smtp-Source: APXvYqxidYggLhCDlKDPPoGD3FSWeBWxwtOzAyrvnQyzo3ixpa+XRzwDjKZfxioOdAVAMIp4fTiorW0EVPKAU++mh06/cyXjSy0g
MIME-Version: 1.0
X-Received: by 2002:a5d:87c6:: with SMTP id q6mr29436327ios.115.1563566640206;
 Fri, 19 Jul 2019 13:04:00 -0700 (PDT)
Date:   Fri, 19 Jul 2019 13:04:00 -0700
In-Reply-To: <00000000000045e7a1058e02458a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c183d058e0e3abd@google.com>
Subject: Re: KASAN: use-after-free Write in tlb_finish_mmu
From:   syzbot <syzbot+8267e9af795434ffadad@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, davem@davemloft.net, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jasowang@redhat.com,
        jglisse@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, mst@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
Author: Jason Wang <jasowang@redhat.com>
Date:   Fri May 24 08:12:18 2019 +0000

     vhost: access vq metadata through kernel virtual address

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11642a58600000
start commit:   22051d9c Merge tag 'platform-drivers-x86-v5.3-2' of git://..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13642a58600000
console output: https://syzkaller.appspot.com/x/log.txt?x=15642a58600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d831b9cbe82e79e4
dashboard link: https://syzkaller.appspot.com/bug?extid=8267e9af795434ffadad
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d58784600000

Reported-by: syzbot+8267e9af795434ffadad@syzkaller.appspotmail.com
Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual  
address")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
