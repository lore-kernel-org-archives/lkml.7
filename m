Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08B0206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfCKNqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:46:34 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:22405 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCKNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:46:34 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2BDjwu0037971;
        Mon, 11 Mar 2019 22:45:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Mon, 11 Mar 2019 22:45:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2BDjwT0037964
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 11 Mar 2019 22:45:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: kernel panic: MAC Initialization failed. (3)
To:     casey@schaufler-ca.com, james.morris@microsoft.com,
        jmorris@namei.org, john.johansen@canonical.com,
        keescook@chromium.org, serge@hallyn.com, takedakn@nttdata.co.jp
References: <0000000000008407390583d18381@google.com>
Cc:     syzbot <syzbot+2ee3f8974c2e7dc69feb@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <254a6393-a1ac-0627-ad02-3ee2819938ff@i-love.sakura.ne.jp>
Date:   Mon, 11 Mar 2019 22:45:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <0000000000008407390583d18381@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F.Y.I. Nothing is wrong with that commit. That commit merely allows enabling TOMOYO and
one of SELinux/Smack/AppArmor at the same time for syzbot's kernel command line options.
This problem will be handled by a patch at
https://lore.kernel.org/linux-security-module/1551362770-8655-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
and then updating syzbot to build kernels with this option enabled.

Well, it is wonderful that syzbot started bisecting. ;-)

On 2019/03/11 22:26, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 89a9684ea158dd7eef1728be9f0aed9a7d41cf19
> Author: Kees Cook <keescook@chromium.org>
> Date:   Tue Feb 12 18:23:18 2019 +0000
> 
>     LSM: Ignore "security=" when "lsm=" is specified
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11572723200000
> start commit:   89a9684e LSM: Ignore "security=" when "lsm=" is specified
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=13572723200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15572723200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0f38652d28b522f
> dashboard link: https://syzkaller.appspot.com/bug?extid=2ee3f8974c2e7dc69feb
> userspace arch: amd64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c68242c00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17190c8ac00000
> 
> Reported-by: syzbot+2ee3f8974c2e7dc69feb@syzkaller.appspotmail.com
> Fixes: 89a9684e ("LSM: Ignore "security=" when "lsm=" is specified")
> 
