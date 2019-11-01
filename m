Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B8ACA9ECE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 01:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ABA2083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 01:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfKABCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 21:02:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:53044 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfKABCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 21:02:02 -0400
Received: by mail-io1-f69.google.com with SMTP id b2so6109166iod.19
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 18:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=g5b/uq1jPzIHWKTG4KkvcGY51W0aJ/wSvlfQDeK7EKs=;
        b=b/r/wCwL/SbR4qBoxBCg6Wfl0CIPCNy1K6bEHPMgfh/PlKS5yv4ceTaiiwa2n5GTFZ
         zFdtg2zye8NwchPS4z9B/7NPmoSELZf8+NZJsUoRcy/ttwoZDzFMtLdL/iEdIqUARZPj
         VmjrCdGDZzTdUu9W16cZHrs8OKv/Jpn+Vz6OHNYcv3f7XSlSW2TCbBfy0mkRkF4xdMNQ
         4Hi/hDdhPzyR8KD62E6pc6SF+TcIP26QkCiF/AO23xpJLXrwSpb+M47HzFHCVx5XSeB1
         2GBh9ki3Xoe7QudB2IxCVWUJRMk8M2obju9OOyPqyybUh/bh6VH/5yo3lohaQ5aLAgE9
         NnpA==
X-Gm-Message-State: APjAAAVluv/EF25CncMG9VxCtnqiOQl+2crCNmVLWbRITymAAhx74zFT
        CCOohzCp4v0yTggR5vwo5cAyNmFURuEqbZ2X+/qrWGtjbtCi
X-Google-Smtp-Source: APXvYqxZsTelPOF42qriET4H2YWOnXA8pSOyk4C53x/sSGq8f4RGlUtiE6R/yVt6douHfDWehA+zCy3otomUVEeICPtM27LaOmVm
MIME-Version: 1.0
X-Received: by 2002:a5e:c302:: with SMTP id a2mr7896816iok.295.1572570121338;
 Thu, 31 Oct 2019 18:02:01 -0700 (PDT)
Date:   Thu, 31 Oct 2019 18:02:01 -0700
In-Reply-To: <000000000000d73b12059608812b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077853c05963e8313@google.com>
Subject: Re: WARNING in print_bfs_bug
From:   syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@gmail.com,
        f.fainelli@gmail.com, hannes@cmpxchg.org, hawk@kernel.org,
        hughd@google.com, idosch@mellanox.com,
        jakub.kicinski@netronome.com, jglisse@redhat.com,
        jiri@mellanox.com, johannes.berg@intel.com,
        john.fastabend@gmail.com, kafai@fb.com,
        kirill.shutemov@linux.intel.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mkubecek@suse.cz,
        netdev@vger.kernel.org, petrm@mellanox.com,
        roopa@cumulusnetworks.com, sfr@canb.auug.org.au,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        william.kucharski@oracle.com, willy@infradead.org, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 9c61acffe2b8833152041f7b6a02d1d0a17fd378
Author: Song Liu <songliubraving@fb.com>
Date:   Wed Oct 23 00:24:28 2019 +0000

     mm,thp: recheck each page before collapsing file THP

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15be4e14e00000
start commit:   49afce6d Add linux-next specific files for 20191031
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17be4e14e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13be4e14e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f119b33031056
dashboard link: https://syzkaller.appspot.com/bug?extid=62ebe501c1ce9a91f68c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c162f4e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131b5eb8e00000

Reported-by: syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com
Fixes: 9c61acffe2b8 ("mm,thp: recheck each page before collapsing file THP")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
