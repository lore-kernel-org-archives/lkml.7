Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87804C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6557C20848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfEPNho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:37:44 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59934 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfEPNho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:37:44 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4GDbRZ2038911;
        Thu, 16 May 2019 22:37:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Thu, 16 May 2019 22:37:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4GDbR4R038908
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 16 May 2019 22:37:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: KMSAN: uninit-value in tomoyo_check_inet_address
To:     Alexander Potapenko <glider@google.com>
Cc:     syzbot <syzbot+1018d578c410f9f37261@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        takedakn@nttdata.co.jp
References: <00000000000032685a058900d170@google.com>
 <2b0b9d18-6773-f2dc-ecb2-9f8782d0962a@i-love.sakura.ne.jp>
 <CAG_fn=UHjDv=Jc_nEKKknVGrr9CC4rZ+a+hw_yAL-j4y4=89cg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d13cd8cd-03d1-ddde-47e1-d61147520e19@i-love.sakura.ne.jp>
Date:   Thu, 16 May 2019 22:37:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAG_fn=UHjDv=Jc_nEKKknVGrr9CC4rZ+a+hw_yAL-j4y4=89cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/16 22:19, Alexander Potapenko wrote:
>> commit e6193f78bb689f3f424559bb45f4a091c8b314df
>> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Date:   Fri Apr 12 19:59:36 2019 +0900
>>
>>     tomoyo: Check address length before reading address family
>>
>>     KMSAN will complain if valid address length passed to bind()/connect()/
>>     sendmsg() is shorter than sizeof("struct sockaddr"->sa_family) bytes.
>>
>>     Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>     Signed-off-by: James Morris <jamorris@linux.microsoft.com>
> Apparently the fix didn't make it to 5.1, I'll cherry-pick it to KMSAN tree.

Together with three more patches listed bottom, please.

> OOC, how did you know about this bug?

I did a tree-wide check when writing a patch for

  KMSAN: uninit-value in rds_bind
  KMSAN: uninit-value in rds_connect

reports. Patches for LSM part just did not make it to 5.1.



commit b9ef5513c99bf9c8bfd9c9e8051b67f52b2dee1e
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Fri Apr 12 19:59:35 2019 +0900

    smack: Check address length before reading address family

commit 619ae03e922b65a1a5d4269ceae1e9e13a058d6b
Author: Casey Schaufler <casey@schaufler-ca.com>
Date:   Tue Apr 30 14:13:32 2019 -0700

    Smack: Fix kbuild reported build error

commit c750e6929d3c76d13d1d0ba475989d6dd74785d5
Author: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date:   Fri Apr 12 19:59:34 2019 +0900

    selinux: Check address length before reading address family
