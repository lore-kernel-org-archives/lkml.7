Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9936C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804DA2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfFYXHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:07:03 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:50593 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFYXHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:07:01 -0400
Received: by mail-io1-f72.google.com with SMTP id m26so224884ioh.17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 16:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5XO6NDSi7o9UCx31IdKa++vNGr4w4sFZNOdIzxhXeB0=;
        b=kQMmhccr5/eFgVKxIrmuE0QvrLgWmOZcscqKzX86UMUDbmTWJ+Raril6kfG2O4CZYE
         UL/QwabK59NCXVe6lUoKF/So5wbWRuEbQYN3h9KcGAkcZQXHQ9QmGdR8Z5kNcTLY36Ul
         jUtCOohGa0K10b+myHlA3204722RnZGXEnBZDbZNFn2T2H8BPQZZWdZ9Y85E9oKkf2Og
         kV9CoC7uecPSku8hzwa6qINf/10z4Xzn2Z1nOAIkd46a0ALwgV5a7R3Xs3/Qe5K957JE
         EMa3gKW4V8VIR3I8peUE2NCE9/wR4neJXLpQ0IaFJxrkOjabO/epkM+HkDoZm/LIBndV
         VCxg==
X-Gm-Message-State: APjAAAVvd6djezo0CCK8Pn3kzQDzRnZBcxUsTxb+FyXiuTxB098R6LLa
        VRMDARzbMCiXPHN/r0Fpi9WneTRIAAsWGnYHa+HB4IYwWS8V
X-Google-Smtp-Source: APXvYqxg7Q43zU7eDdjWCJJjMc20VKLoF6D1yLiqI3SKjTQAMQ214QUyVPvfOOK+luu/cmFimcz2QkEtvpAEzFW2H5AaIqwEW1Z8
MIME-Version: 1.0
X-Received: by 2002:a5e:c00a:: with SMTP id u10mr1423993iol.24.1561504020634;
 Tue, 25 Jun 2019 16:07:00 -0700 (PDT)
Date:   Tue, 25 Jun 2019 16:07:00 -0700
In-Reply-To: <000000000000e672c6058bd7ee45@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007724d6058c2dfc24@google.com>
Subject: Re: KASAN: slab-out-of-bounds Write in validate_chain
From:   syzbot <syzbot+8893700724999566d6a9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ast@kernel.org, cai@lca.pw,
        crecklin@redhat.com, daniel@iogearbox.net,
        john.fastabend@gmail.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Sat Jun 30 13:17:47 2018 +0000

     bpf: sockhash fix omitted bucket lock in sock_close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a4e9b5a00000
start commit:   abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16a4e9b5a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a4e9b5a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=8893700724999566d6a9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167098b2a00000

Reported-by: syzbot+8893700724999566d6a9@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
