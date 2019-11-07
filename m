Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA80AC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B662207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389530AbfKGNn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:43:27 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:55663 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389040AbfKGNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:07 -0500
Received: by mail-il1-f199.google.com with SMTP id n81so2604417ili.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vnRsz0/rOqX31qWVqa+jCcqeQTYMdPmUZHcF8We9FRA=;
        b=iDEbNdKVkd7JlzEUm3DQ2diHY52Bk7mZLw0wD5xW6XJnyDu3f39PdP8WA7w+HT3ZeS
         6Wxij07thbj8ydQGH+4F0MSE/ojrDSvH1F/ZornzqR6xnkn1TPrN915SyZht2TRGb3PL
         yG7pq5JB3JAAIbnKcwJ7pYrJtyxixrDM/1pqfz+j7Bm3VO3K3F28ym6eFTUcDQ/YL9Zx
         QP3Idecy8Ikla697V4Fk/BLiHTzgm30yW+B1R+9cINBceMlbp8UkbSyFQSNHZq2yGeNX
         UECYQcdn3GKDyCiPpQplg1hl4YnPYDRNkkp6g2nMYD1SMyE4DIlMjUA9+714x/HTYh8S
         f5UA==
X-Gm-Message-State: APjAAAXzehflLOfchbzAmvtHWQ0xp9vn7RU808njeNxvg/yjsdqNGIQl
        ThuS8omDLgxZHCxPmP+VxzcxcCUtLtgl54fvSS0LvKkrCKDn
X-Google-Smtp-Source: APXvYqxag6ODkk8Wbv8Wdp6mU+iNDO/+EsH5xk9k1x/wiqR1dAXliax/9/yHrkDCGJ9jCF/t7qMAyUhTeT+GGlYdhmUlfnYJ7pvc
MIME-Version: 1.0
X-Received: by 2002:a6b:8b02:: with SMTP id n2mr3600626iod.66.1573134126640;
 Thu, 07 Nov 2019 05:42:06 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:06 -0800
In-Reply-To: <0000000000008d5a360575368e31@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd76fb0596c1d41c@google.com>
Subject: Re: KASAN: use-after-free Read in _decode_session6
From:   syzbot <syzbot+e8c1d30881266e47eb33@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com,
        herbert@gondor.apana.org.au, johannes.berg@intel.com, kafai@fb.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, posk@google.com, songliubraving@fb.com,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, willemb@google.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit e7c87bd6cc4ec7b0ac1ed0a88a58f8206c577488
Author: Willem de Bruijn <willemb@google.com>
Date:   Wed Jan 16 01:19:22 2019 +0000

     bpf: in __bpf_redirect_no_mac pull mac only if present

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1736f974600000
start commit:   b36fdc68 Merge tag 'gpio-v4.19-2' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
dashboard link: https://syzkaller.appspot.com/bug?extid=e8c1d30881266e47eb33
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d42021400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d09f1e400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: bpf: in __bpf_redirect_no_mac pull mac only if present

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
