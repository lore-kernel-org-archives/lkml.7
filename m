Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2CEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9322C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCLObF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:31:05 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54988 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfCLObF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:31:05 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2CETgWv020006;
        Tue, 12 Mar 2019 23:29:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Tue, 12 Mar 2019 23:29:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2CETfAA019967
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 12 Mar 2019 23:29:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: rcu detected stall in sys_sendfile64 (2)
To:     syzbot <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com>,
        dvyukov@google.com, syzkaller-bugs@googlegroups.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <00000000000010b2fc057fcdfaba@google.com>
 <0000000000008c75b50583ddb5f8@google.com>
 <20190312040829.GQ2217@ZenIV.linux.org.uk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <491ff1c3-91d6-eaa7-f551-46a4f8b90f5a@i-love.sakura.ne.jp>
Date:   Tue, 12 Mar 2019 23:29:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190312040829.GQ2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Moving most recipients to bcc: in order to avoid flooding.)

On 2019/03/12 13:08, Al Viro wrote:
> Umm...  Might be a good idea to add some plausibility filters - it is,
> in theory, possible that adding a line in a comment changes behaviour
> (without compiler bugs, even - playing with __LINE__ is all it would
> take), but the odds that it's _not_ a false positive are very low.

Well, 108 out of 168 tests done during this bisection failed to test.
With such high failure ratio, it is possible that by chance no crash
happened during few tests for specific commit; causing a wrong bisection
result. I expect that when trying to conclude "git bisect good" for
specific commit, the tests should be repeated until no crash happened
during 8 successful tests.

Also, this bisection is finding multiple different crash patterns, which
suggests that the crashed tests are not giving correct feedback to syzbot.

$ grep -F 'run #' bisect.txt\?x\=13220283200000 | wc -l
168
$ grep -F 'Connection timed out' bisect.txt\?x\=13220283200000 | wc -l
108
$ grep -F 'crashed' bisect.txt\?x\=13220283200000
run #0: crashed: WARNING: ODEBUG bug in netdev_freemem
run #0: crashed: WARNING: ODEBUG bug in netdev_freemem
run #1: crashed: INFO: rcu detected stall in corrupted
run #0: crashed: INFO: rcu detected stall in sys_sendfile64
run #0: crashed: INFO: rcu detected stall in corrupted
run #4: crashed: INFO: rcu detected stall in sys_sendfile64
run #0: crashed: INFO: rcu detected stall in corrupted
run #1: crashed: INFO: rcu detected stall in corrupted
run #0: crashed: INFO: rcu detected stall in ext4_file_write_iter
run #0: crashed: INFO: rcu detected stall in corrupted
run #0: crashed: INFO: rcu detected stall in sendfile64
run #0: crashed: INFO: rcu detected stall in corrupted
run #1: crashed: INFO: rcu detected stall in sendfile64
run #0: crashed: INFO: rcu detected stall in ext4_file_write_iter
run #1: crashed: INFO: rcu detected stall in corrupted
run #0: crashed: INFO: rcu detected stall in corrupted
run #0: crashed: INFO: rcu detected stall in corrupted
run #0: crashed: INFO: rcu detected stall in corrupted
run #1: crashed: INFO: rcu detected stall in corrupted
run #0: crashed: INFO: rcu detected stall in corrupted
run #3: crashed: INFO: rcu detected stall in corrupted
run #0: crashed: INFO: rcu detected stall in do_iter_write
