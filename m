Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880D9C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF8F20818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfEPNN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:13:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53805 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfEPNN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:13:29 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4GDD1qd020322;
        Thu, 16 May 2019 22:13:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Thu, 16 May 2019 22:13:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4GDD076020318
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 16 May 2019 22:13:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: KMSAN: uninit-value in tomoyo_check_inet_address
To:     syzbot <syzbot+1018d578c410f9f37261@syzkaller.appspotmail.com>
References: <00000000000032685a058900d170@google.com>
Cc:     glider@google.com, jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2b0b9d18-6773-f2dc-ecb2-9f8782d0962a@i-love.sakura.ne.jp>
Date:   Thu, 16 May 2019 22:13:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <00000000000032685a058900d170@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/16 21:58, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    3b955a40 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       kmsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=1027e608a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=602468164ccdc30a
> dashboard link: https://syzkaller.appspot.com/bug?extid=1018d578c410f9f37261
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang 06d00afa61eef8f7f501ebdb4e8612ea43ec2d78)
> 
> Unfortunately, I don't have any reproducer for this crash yet.

This should be already fixed in linux.git.

#syz fix: tomoyo: Check address length before reading address family

commit e6193f78bb689f3f424559bb45f4a091c8b314df
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Fri Apr 12 19:59:36 2019 +0900

    tomoyo: Check address length before reading address family

    KMSAN will complain if valid address length passed to bind()/connect()/
    sendmsg() is shorter than sizeof("struct sockaddr"->sa_family) bytes.

    Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    Signed-off-by: James Morris <jamorris@linux.microsoft.com>
