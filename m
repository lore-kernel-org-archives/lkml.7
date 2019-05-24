Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8117EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3E621773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390624AbfEXKgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:36:46 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60716 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389448AbfEXKgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:36:46 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4OAZW6N082260;
        Fri, 24 May 2019 19:35:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Fri, 24 May 2019 19:35:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4OAZQQO082192
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 24 May 2019 19:35:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Monitor change of console loglevel.
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190514091917.GA26804@jagdpanzerIV>
 <3e2cf31d-25af-e7c3-b308-62f64d650974@i-love.sakura.ne.jp>
 <4d1a4b51-999b-63c6-5ce3-a704013cecb6@i-love.sakura.ne.jp>
 <CACT4Y+YNNzsMHpjDUpfHNYJMqYA+foHtSBdrg_NSeKJKadoGwQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <68486fcf-325f-fbd3-adb4-14666d477917@i-love.sakura.ne.jp>
Date:   Fri, 24 May 2019 19:35:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YNNzsMHpjDUpfHNYJMqYA+foHtSBdrg_NSeKJKadoGwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/24 16:55, Dmitry Vyukov wrote:
> On Thu, May 23, 2019 at 11:57 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Well, the culprit of this problem might be syz_execute_func().
>>
>>   https://twitter.com/ed_maste/status/1131165065485398016
>>
>> Then, blacklisting specific syscalls/arguments might not work.
>> We will need to guard specific paths on the kernel side using
>> some kernel config option...
> 
> Yes, that's a nasty issue. We could stop running random code, or
> setuid into nobody, but then we will lose lots of test coverage...
> 

I think that guarding specific paths on the kernel side is better.
TOMOYO already added CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING for
avoid emitting WARNING: string and getting more test coverage. There are
other codes emitting WARNING: string that confuses syzbot. If we guard
critical paths like reboot/poweroff request that will destroy the target
VM instance, we can get more test coverage while reducing pointless reports.

