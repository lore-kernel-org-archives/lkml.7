Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41EBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C5020637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfLJWIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:08:10 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:50009 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbfLJWIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:08:02 -0500
Received: by mail-io1-f69.google.com with SMTP id t3so14309731ioj.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 14:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GwENJOhReXSoSX4FCZp3Vso0XyIxIAaoh96r/uvXuy4=;
        b=NBloXL4emu6tqm6wl54gfPkzFst5Y6Ifswd5trCWWcG7DjJWpu3BeM6pYHM0GwOXBb
         qh0GK3ypi9ZN5YJvY7Nb2eh3W5/Tm/6vXLPUC+DjPZ3V0eCo04KdugZuOqj+mIir+jMJ
         0UJNoTqzFEj01PeRBVU7o+5LGh6zDnH5gEE3BGjgA0JwN++vYMgIgVJj4kQzo0Z1p2Gg
         Niz9mnapKS0oEc+keWzSKMrL3gGdaBCHy5lrRu1D8kVWDMR/WJ1IX28tI61c9l7xNt8b
         jZ9tO4yP65xf01+TlwrS90mAjiFnF1J/8ExnaPHWLmFAn2hq3UG3x6uaTcKjXMCJNWip
         OTeA==
X-Gm-Message-State: APjAAAUwh+Eg9+fa1SdpwldFUp8gaB2u9QyIcTvNerUv+ZfliBK0jySO
        J0Wnt3uNpk69V53lUrNEgr8UaaPDQ6mOA9niAit+TkEUPY6f
X-Google-Smtp-Source: APXvYqw1nemikCJS5D7M4N4f0bYbahpKkcyiyjQt4kL1XP7Z9X8CJ3ZOIh4k/9LB4ygXcYMr/mw1sHHvGwAuiBpmhzif60YWo58S
MIME-Version: 1.0
X-Received: by 2002:a5d:9f05:: with SMTP id q5mr234717iot.295.1576015681954;
 Tue, 10 Dec 2019 14:08:01 -0800 (PST)
Date:   Tue, 10 Dec 2019 14:08:01 -0800
In-Reply-To: <0000000000005175bf057617c71d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e22b3c059960bebd@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in ip6_tnl_parse_tlv_enc_lim
From:   syzbot <syzbot+68dce7caebd8543121de@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ast@kernel.org, boqun.feng@gmail.com,
        byungchul.park@lge.com, daniel@iogearbox.net, davem@davemloft.net,
        dledford@redhat.com, jgg@mellanox.com, jgg@ziepe.ca,
        kernel-team@lge.com, kirill@shutemov.name, kuznet@ms2.inr.ac.ru,
        leon@kernel.org, leonro@mellanox.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-rdma@vger.kernel.org, mingo@kernel.org,
        netdev@vger.kernel.org, npiggin@gmail.com, parav@mellanox.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        walken@google.com, willy@infradead.org, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 30471d4b20335d9bd9ae9b2382a1e1e97d18d86d
Author: Leon Romanovsky <leonro@mellanox.com>
Date:   Sun Feb 3 12:55:50 2019 +0000

     RDMA/core: Share driver structure size with core

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b7bb7ae00000
start commit:   3a5af36b Merge tag '4.19-rc3-smb3-cifs' of git://git.samba..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c4a80625153107e
dashboard link: https://syzkaller.appspot.com/bug?extid=68dce7caebd8543121de
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1068a44e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146386c6400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: RDMA/core: Share driver structure size with core

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
