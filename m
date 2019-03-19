Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF32C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB4B20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv+/1orn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbfCSQXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:23:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50206 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbfCSQXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:23:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so9054381wmi.0;
        Tue, 19 Mar 2019 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fT5IiTrCD2mkBVO4SYwrgK+IBcwUUHJdMAVNHqgXqiA=;
        b=Nv+/1ornQ92uaVZXSCgLwkVn29SPNjuYlkQE7lFisyac+uKWapyHR25wHjkjd8C1dh
         I8DcaXN5LjDUuCisuep7YH67CwrsZEqVYSlijJJWVeyBOGG/KXfVL3N/YG1WmkmFxRoR
         lGUTT06Jp9Z56xGWh1CX8BbPzijvWKrvKEFQyrGE9gf6KXM4Ts14jp0xHm37+R0Jt3YG
         Mq9rBbwlI3lfieVXdypxQi8p5QQNJNqW6+I/yeW2M4G6dIhe4B1W8ZYTcAdErCBu9tGu
         IO81LyespkSdKSlDIyRpk2/UbJXr8Q31/ohlcfZk6UEcR+SJvLXMC5MaZlLM0eCncdhO
         ZgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fT5IiTrCD2mkBVO4SYwrgK+IBcwUUHJdMAVNHqgXqiA=;
        b=TwSR4HeSzsAZYO/hi5BaBKoeDsrPoU1hIta4NWY9X6ZA8i8xzI96PEWr4R7/dPweGj
         7vgzJFJe+ialZNOE+4HbvsCxKFyJ4crTo7OnBSAs5wUg4YltMDAAUJtle1e8F1y9ID7R
         4X2uY1k9XZPuTj5bKnAJlOO5bWD9tSyqis5cd2VzGPJVHqMmh/UWfvtyIIwcQf/jNLuJ
         HOmosp70m991Hqc3GbkSrg1+EYq3HLO3F7ZJFuUqJz6Pgrc9DHdEV36lg6VXrcEytNa8
         1XW1RoT7mQt+v51oiDkXzcWMu0uG+DgE8SjBkhptCySnvl9OXCIlgqHY/9elTCauQihu
         c58A==
X-Gm-Message-State: APjAAAVWRy7iA/KJBCdkUeU6TXYvlkzYJsMD0zyptlZ621jSpijMFFo+
        wBlwmvsqf8L5VZGhZwNyYhVlDWUZ
X-Google-Smtp-Source: APXvYqw/9SBSQNvAY6ve7IKFyhudKCKJi8jtlMrsA7OXeUwLkJKiV/DMUXXpHzn8TFMlRnDiN5GOiA==
X-Received: by 2002:a7b:cb1a:: with SMTP id u26mr4601767wmj.46.1553012629985;
        Tue, 19 Mar 2019 09:23:49 -0700 (PDT)
Received: from [172.31.96.190] ([195.39.71.253])
        by smtp.gmail.com with ESMTPSA id c126sm4363728wma.0.2019.03.19.09.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 09:23:47 -0700 (PDT)
Subject: Re: WARNING: suspicious RCU usage in xfrm_alloc_userspi
To:     syzbot <syzbot+59752237f7ab21c3f3c3@syzkaller.appspotmail.com>,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        Su Yanjun <suyj.fnst@cn.fujitsu.com>
References: <0000000000007783a2058474a0b9@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <ed7fdea3-7e1a-66e1-0225-cb8ec3c16585@gmail.com>
Date:   Tue, 19 Mar 2019 09:23:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0000000000007783a2058474a0b9@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Su Yanjun 

On 03/19/2019 09:02 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    b9998194 Add linux-next specific files for 20190318
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17a2e24d200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=59cd5d43b5df6955
> dashboard link: https://syzkaller.appspot.com/bug?extid=59752237f7ab21c3f3c3
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e70cb3200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17292127200000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+59752237f7ab21c3f3c3@syzkaller.appspotmail.com
> 
> =============================
> WARNING: suspicious RCU usage
> 5.1.0-rc1-next-20190318 #5 Not tainted
> -----------------------------
> net/xfrm/xfrm_user.c:1080 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by syz-executor085/7946:
>  #0: 00000000a55031b5 (&net->xfrm.xfrm_cfg_mutex){+.+.}, at: xfrm_netlink_rcv+0x61/0x90 net/xfrm/xfrm_user.c:2691
> 
> stack backtrace:
> CPU: 0 PID: 7946 Comm: syz-executor085 Not tainted 5.1.0-rc1-next-20190318 #5
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>  lockdep_rcu_suspicious+0x153/0x15d kernel/locking/lockdep.c:5162
>  xfrm_nlmsg_unicast net/xfrm/xfrm_user.c:1080 [inline]
>  xfrm_alloc_userspi+0x7d5/0xa80 net/xfrm/xfrm_user.c:1356
>  xfrm_user_rcv_msg+0x458/0x770 net/xfrm/xfrm_user.c:2684
>  netlink_rcv_skb+0x17a/0x460 net/netlink/af_netlink.c:2485
>  xfrm_netlink_rcv+0x70/0x90 net/xfrm/xfrm_user.c:2692
>  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
>  netlink_unicast+0x536/0x720 net/netlink/af_netlink.c:1336
>  netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1925
>  sock_sendmsg_nosec net/socket.c:651 [inline]
>  sock_sendmsg+0xdd/0x130 net/socket.c:661
>  ___sys_sendmsg+0x806/0x930 net/socket.c:2260
>  __sys_sendmsg+0x105/0x1d0 net/socket.c:2298
>  __do_sys_sendmsg net/socket.c:2307 [inline]
>  __se_sys_sendmsg net/socket.c:2305 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2305
>  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440499
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffcf12caf08 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440499
> RDX: 0000000000000000 RSI: 00000000200006c0 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000040
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
