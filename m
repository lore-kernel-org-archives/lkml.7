Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDDCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED926214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCLVLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:11:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:17119 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfCLVL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:11:29 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2CLBJlM094254;
        Wed, 13 Mar 2019 06:11:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Wed, 13 Mar 2019 06:11:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2CLBIAe094251
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 13 Mar 2019 06:11:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: rcu detected stall in sys_sendfile64 (2)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
References: <00000000000010b2fc057fcdfaba@google.com>
 <0000000000008c75b50583ddb5f8@google.com>
 <20190312040829.GQ2217@ZenIV.linux.org.uk>
 <491ff1c3-91d6-eaa7-f551-46a4f8b90f5a@i-love.sakura.ne.jp>
 <CACT4Y+ahcZpJ1Q-TKkCJkyhzGc07XFusuwBcKjg_rfAeos8RWA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <92a4e5e5-33ca-7b39-16c0-82c7fb742d18@i-love.sakura.ne.jp>
Date:   Wed, 13 Mar 2019 06:11:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ahcZpJ1Q-TKkCJkyhzGc07XFusuwBcKjg_rfAeos8RWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/13 2:15, Dmitry Vyukov wrote:
>> Also, this bisection is finding multiple different crash patterns, which
>> suggests that the crashed tests are not giving correct feedback to syzbot.
> 
> Treating different crashes as just "crash" is intended. Kernel bugs
> can manifest in very different ways.
> Want fun, search for "bpf: sockhash, disallow bpf_tcp_close and update
> in parallel" in  https://syzkaller.appspot.com/?fixed=upstream
> It lead to 50+ different failure modes.
> 

But syzbot already found a rather simple C reproducer
( https://syzkaller.appspot.com/text?tag=ReproC&x=116fc7a8c00000 ) for this bug.
Was this reproducer used for bisection? I guess that if this reproducer was used,
syzbot did not hit "WARNING: ODEBUG bug in netdev_freemem" cases.

Also, humans can sometimes find more simpler C reproducers from syzbot provided
reproducers. It would be nice if syzbot can accept and use a user defined C
reproducer for testing.

