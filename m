Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B664C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD4A218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfCPCKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 22:10:34 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:43452 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCPCKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 22:10:34 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2G29O1l010207;
        Sat, 16 Mar 2019 11:09:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Sat, 16 Mar 2019 11:09:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2G29KB5010190
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 16 Mar 2019 11:09:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [syzbot? printk?] no WARN_ON() messages printed before "Kernel panic
 - not syncing: panic_on_warn set ..."
Message-ID: <0a0d282b-6757-5f42-b888-ef52b040aaa1@i-love.sakura.ne.jp>
Date:   Sat, 16 Mar 2019 11:09:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I found a corrupted report at https://syzkaller.appspot.com/text?tag=CrashLog&x=17c6b82b200000 .

The panic() was caused by by WARN_ON() from generic_make_request_checks(), but there
was no printk() messages from WARN_ON(). Moreover, there was no printk() messages
for (at least) nearly one minute despite syzbot's testing likely generates constant
printk() messages. Unfortunately, since the report was truncated due to size limit,
we can't check when was the last time prink() succeeded writing messages to consoles.

----------
14:27:02 executing program 1:
(...snipped...)
14:28:00 executing program 3:
(...snipped...)
[  974.068065][T22281] Kernel panic - not syncing: panic_on_warn set ...
[  974.085454][T22281] CPU: 1 PID: 22281 Comm: syz-executor.1 Not tainted 5.0.0+ #23
[  974.093121][T22281] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[  974.103193][T22281] Call Trace:
[  974.106513][T22281]  dump_stack+0x172/0x1f0
[  974.110893][T22281]  ? generic_make_request_checks+0x1be0/0x2160
[  974.117235][T22281]  panic+0x2cb/0x65c
[  974.121434][T22281]  ? __warn_printk+0xf3/0xf3
[  974.126064][T22281]  ? generic_make_request_checks+0x1ca3/0x2160
[  974.132257][T22281]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  974.138521][T22281]  ? __warn.cold+0x5/0x45
[  974.142877][T22281]  ? __warn+0xe8/0x1d0
[  974.146978][T22281]  ? generic_make_request_checks+0x1ca3/0x2160
[  974.153171][T22281]  __warn.cold+0x20/0x45
[  974.157483][T22281]  ? vprintk_emit+0x1ce/0x6d0
[  974.162202][T22281]  ? generic_make_request_checks+0x1ca3/0x2160
[  974.168403][T22281]  report_bug+0x263/0x2b0
[  974.172847][T22281]  do_error_trap+0x11b/0x200
[  974.177646][T22281]  do_invalid_op+0x37/0x50
[  974.182329][T22281]  ? generic_make_request_checks+0x1ca3/0x2160
[  974.188951][T22281]  invalid_op+0x14/0x20
[  974.193142][T22281] RIP: 0010:generic_make_request_checks+0x1ca3/0x2160
----------

Is it possible that the reason there was no printk() messages is that
someone kept printing messages to console from userspace such that
console_trylock() from printk() was not able to succeed for (at least)
nearly one minute?
