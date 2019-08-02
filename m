Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FAAC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A962086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbfHBGXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:23:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42792 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbfHBGXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:23:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so26009612wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 23:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jbmoJyZEn7J7vTJYsup7+FkjGvnLP/DSEj6znq8zKYY=;
        b=nta2OqgwXHT5HFxYkXfnsRetgPFjNrL6I1xhPRRqUENybQSOTvTTFkbagiAbpQGrq3
         P9orNPBrmFfjTYcf/IeQhWRNHjpJK4KQJ7k8yZoKCoB7IZqjmxbpy1S9GAZFgIpRkS0P
         AFLC0wU7xombg/XQmGlmJNw35Y1/sAdM8yhEUjtf0pH2508zxSTIdzK5sBUKhd06IzQl
         t4H9cJ3r/YRw4fZ928nlHscx8hF7BlvB8tRKYurw5FpuC9ZWEypBrLp9WowYrSyccCEo
         2IQrWviwe8Klr4ikxee4rKYDJprFecJbKnfDD3KLNnGFSWPXPWc8I7pNcXDtefdzfi+P
         Un3Q==
X-Gm-Message-State: APjAAAVL6FABj5XkhsWqc3THllMQ3fA7Dhqfc/8Us+Txv4vIUimP4zxe
        FNtkeLiTs1FEhbKu8fn2/IdYMtnHxJU=
X-Google-Smtp-Source: APXvYqxrPAnCLcbJwjsgrNMaujlH65XxMpENssEL5EhLE/lSCugECYiMzyoKJSE/9LrPTVFHBcsitg==
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr149451223wro.33.1564727008485;
        Thu, 01 Aug 2019 23:23:28 -0700 (PDT)
Received: from [192.168.0.120] (radio12.infos.cz. [46.33.112.76])
        by smtp.gmail.com with ESMTPSA id e19sm104756228wra.71.2019.08.01.23.23.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 23:23:27 -0700 (PDT)
Subject: Re: memory leak in pty_common_install
To:     syzbot <syzbot+bdebcbf44250d75bdd82@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <0000000000002cd2b1058ee760fe@google.com>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9ad9f8ee-4674-9665-1de5-001268d922bf@suse.cz>
Date:   Fri, 2 Aug 2019 08:23:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0000000000002cd2b1058ee760fe@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 07. 19, 17:08, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    6789f873 Merge tag 'pm-5.3-rc2' of
> git://git.kernel.org/pu..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1696897c600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=339b6a6b3640d115
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=bdebcbf44250d75bdd82
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153d7544600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+bdebcbf44250d75bdd82@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff88810d84d400 (size 512):
>   comm "syz-executor.5", pid 7522, jiffies 4294954305 (age 14.260s)
>   hex dump (first 32 bytes):
>     50 d4 84 0d 81 88 ff ff e0 ff ff ff 0f 00 00 00  P...............
>     10 d4 84 0d 81 88 ff ff 10 d4 84 0d 81 88 ff ff  ................
>   backtrace:
>     [<000000003d61da44>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:43 [inline]
>     [<000000003d61da44>] slab_post_alloc_hook mm/slab.h:522 [inline]
>     [<000000003d61da44>] slab_alloc mm/slab.c:3319 [inline]
>     [<000000003d61da44>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
>     [<00000000a6239e0a>] kmalloc include/linux/slab.h:552 [inline]
>     [<00000000a6239e0a>] pty_common_install+0x4e/0x2b0
> drivers/tty/pty.c:391

So this is tty_port for o_tty.

...

> BUG: memory leak
> unreferenced object 0xffff88810e639800 (size 1024):
>   comm "syz-executor.5", pid 7522, jiffies 4294954305 (age 14.260s)
>   hex dump (first 32 bytes):
>     01 54 00 00 01 00 00 00 00 00 00 00 00 00 00 00  .T..............
>     00 83 fa 19 82 88 ff ff a0 7f 9b 83 ff ff ff ff  ................
>   backtrace:
>     [<000000003d61da44>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:43 [inline]
>     [<000000003d61da44>] slab_post_alloc_hook mm/slab.h:522 [inline]
>     [<000000003d61da44>] slab_alloc mm/slab.c:3319 [inline]
>     [<000000003d61da44>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
>     [<000000001cfffc30>] kmalloc include/linux/slab.h:552 [inline]
>     [<000000001cfffc30>] kzalloc include/linux/slab.h:748 [inline]
>     [<000000001cfffc30>] alloc_tty_struct+0x3f/0x290
> drivers/tty/tty_io.c:2981
>     [<000000001946a70c>] pty_common_install+0xac/0x2b0
> drivers/tty/pty.c:399

And this is o_tty proper. So we leak whole o_tty under some
circumstances... Trying to reproduce.

BTW the reproducer says:
ioctl$TCSETS(r0, 0x40045431, ...)

But 0x40045431 is TIOCSPTLCK, not TCSETS.

thanks,
-- 
js
suse labs
