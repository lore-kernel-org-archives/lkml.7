Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A525AC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FE521D7E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbfKGNnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:43:03 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:52893 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389084AbfKGNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:08 -0500
Received: by mail-io1-f71.google.com with SMTP id o5so1841909iob.19
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jkaowxwkOkoiRTHl/PiXUNv+cs8YRuoJfUzBEAMk5lc=;
        b=VPq08ytviEo0pPIlY8Kd6fQuIU6uj41bZm8HPI8fP2k/RVyOYEfoKcX/qZpYPE0OMf
         S06Cki/STHob/DfFSQ62/OwKLzN1J7M3xQO1hcGVmKDmzVY/kKqsyqEnyTWl+P14IIDD
         TPi1NtpeA14LXYCTZjb787i2ls7ZMmen4sDuIM2IvSm3LED8PDCNkqc+jxkr16HxVabA
         +cGV9RRAIfttNQbxVv+XffOb/qZlp8r8NMmloFEUEy9bn+n2cU1YBmdxarJ0BBvGsARD
         /mipGbbODz0V0dNJyc2SEJwjD9cf1flkzHWApNCLZOEgU0plxwC7VqEJf8eGwK2N11Mc
         TrsQ==
X-Gm-Message-State: APjAAAUN3inWqPtDea5BGNQAzYRljOrUAaVNYsIB8QnYGzZs5150L03p
        1SR2kkShpM8Gm6thxQRzEp/haqs6zBphoT4AAjfhfzz4vS7F
X-Google-Smtp-Source: APXvYqz9hJt5ZMGmb626jkP8Il0OisxxpfMRJk1y6Nf0DXo/5VYPvSczXypuhhynVt4UcMLYKdDWNzeKnfIo2dtS1aP9V/BZ0ldP
MIME-Version: 1.0
X-Received: by 2002:a92:84d4:: with SMTP id y81mr4570955ilk.136.1573134127699;
 Thu, 07 Nov 2019 05:42:07 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:07 -0800
In-Reply-To: <00000000000060e0ae057a092be8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd9f160596c1d465@google.com>
Subject: Re: KASAN: use-after-free Read in crypto_gcm_init_common
From:   syzbot <syzbot+e736399a2c4054612307@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, ard.biesheuvel@linaro.org, aviadye@mellanox.com,
        borisp@mellanox.com, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, dhowells@redhat.com,
        dirk.vandermerwe@netronome.com, ebiggers3@gmail.com,
        herbert@gondor.apana.org.au, jakub.kicinski@netronome.com,
        jason@zx2c4.com, john.fastabend@gmail.com, k.marinushkin@gmail.com,
        keescook@chromium.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        security@kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 9354544cbccf68da1b047f8fb7b47630e3c8a59d
Author: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Date:   Mon Jun 24 04:26:58 2019 +0000

     net/tls: fix page double free on TX cleanup

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=168ad3c2600000
start commit:   4710e789 Merge tag 'nfs-for-4.20-2' of git://git.linux-nfs..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9384ecb1c973baed
dashboard link: https://syzkaller.appspot.com/bug?extid=e736399a2c4054612307
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17902f5b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111377e5400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net/tls: fix page double free on TX cleanup

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
