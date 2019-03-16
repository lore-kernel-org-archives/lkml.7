Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118D6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8358218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfCPPCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:02:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:18805 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfCPPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:02:47 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2GF2YRV008354;
        Sun, 17 Mar 2019 00:02:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Sun, 17 Mar 2019 00:02:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2GF2XrV008350
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 17 Mar 2019 00:02:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
References: <0a0d282b-6757-5f42-b888-ef52b040aaa1@i-love.sakura.ne.jp>
 <CACT4Y+ZBpfLpk0FRp7O8Ut=mmf-uddK_fLMDHtPkf6FnMGMqPA@mail.gmail.com>
 <f015f007-2402-27a0-1694-93b1bcffe84b@i-love.sakura.ne.jp>
 <20190316141410.GA18654@tigerII.localdomain>
 <CACT4Y+YEx5PF7QqaLdYpkyBCr_eBgp1n2yuY2LyrN9iZANXgzQ@mail.gmail.com>
 <647012f4-c221-addf-51ab-586014e8f435@i-love.sakura.ne.jp>
 <CACT4Y+Zg4RVbV=ePRYff9BbpqAg0bOUS79Os5kzQXF39z_KSLw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2a48dee7-b649-65a4-be5d-8b3374013cee@i-love.sakura.ne.jp>
Date:   Sun, 17 Mar 2019 00:02:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Zg4RVbV=ePRYff9BbpqAg0bOUS79Os5kzQXF39z_KSLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/16 23:57, Dmitry Vyukov wrote:
> On Sat, Mar 16, 2019 at 3:53 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2019/03/16 23:16, Dmitry Vyukov wrote:
>>>>> Maybe try running with "ignore_loglevel" kernel command line option added?
>>>>
>>>> Right, that's something I would expect 0-day and syzkaller to do.
>>>
>>> to double-check: enabling this won't lead to verbose/debug level of logging?
>>>
>>
>> I don't know what "verbose/debug level" means. But enabling this option causes
>> KERN_{EMERG,ALERT,CRIT,ERR,WARNING,NOTICE,INFO,DEBUG} be printed equally.
>>
>>   "ignore loglevel setting (prints all kernel messages to the console)"
>>
>> static bool suppress_message_printing(int level)
>> {
>>         return (level >= console_loglevel && !ignore_loglevel);
>> }
> 
> Then I don't think it's suitable: there will be too much output.
> 

Then, we need to find what test is changing console_loglevel.
Maybe add debug BUG_ON() in linux-next.git using CONFIG_DEBUG_AID_FOR_SYZBOT ?
