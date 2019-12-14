Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF266C2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 08:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EB224125
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 08:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfLNIlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 03:41:10 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59473 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfLNIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 03:41:10 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBE8dBa0011982;
        Sat, 14 Dec 2019 17:39:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Sat, 14 Dec 2019 17:39:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBE8d6Gc011932
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 14 Dec 2019 17:39:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 mem_serial_out
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+f4f1e871965064ae689e@syzkaller.appspotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asierra@xes-inc.com, ext-kimmo.rautkoski@vaisala.com,
        Jiri Slaby <jslaby@suse.com>,
        kai heng feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        mika.westerberg@linux.intel.com, o.barta89@gmail.com,
        paulburton@kernel.org, sr@denx.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yegorslists@googlemail.com
References: <00000000000053539a0599173973@google.com>
 <20191212105701.GB1476206@kroah.com>
 <CACT4Y+ZeR=z-3CSXFazmngUhs9DqfxgZLKBNhzvfg49Nrw=EzA@mail.gmail.com>
 <20191213093357.GB2135612@kroah.com>
 <CACT4Y+beoeY9XwbQX7nDY_5EPMQwK+j3JZ9E-k6vhiZudEA1LA@mail.gmail.com>
 <74859736-478a-6ad7-f0be-cfe87ec40ff5@i-love.sakura.ne.jp>
 <20191213160700.GA2632926@kroah.com>
 <4f514a5a-af11-e688-8f8d-72bbadadc889@i-love.sakura.ne.jp>
 <20191214075517.GA3314866@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8b130791-d48a-6505-f3f1-d08cada23d8d@i-love.sakura.ne.jp>
Date:   Sat, 14 Dec 2019 17:39:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191214075517.GA3314866@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/14 16:55, Greg KH wrote:
>>>> That suggestion got no response for two months.
>>>>
>>>>   https://lkml.kernel.org/r/3e4e2b6b-7828-54ab-cf28-db1a396d7e20@i-love.sakura.ne.jp
>>>>
>>>> Unless we add such kernel config option to upstream kernels, it will become
>>>> a whack-a-mole game.
>>>
>>> It will be a whack-a-mole game no matter what.
>>>
>>> Yes, /dev/mem/ makes no sense to fuzz.  Neither does other things (like
>>> serial port memory addresses.)
>>
>> /dev/mem makes sense to fuzz. Ditto for other things.
> 
> What?  What are you going to find if you randomly start to write to
> /dev/mem?  How are we supposed to "fix" that?
> 

When did I say "writing to random addresses" ? If you saw my suggestion, you
will find that "fuzzer will be able to test reading from random addresses,
writing to safe addresses (in order to find new lock dependency which would
otherwise be unnoticed)".

Disabling everything using kernel config option is overkill. What you are saying
is "never try to fuzz USB drivers" by excluding USB drivers from fuzz targets.
There is no need to disable whole tests. We need to exclude only stupid operations
(e.g. forever repeating SysRq-t) from fuzz targets.

>>> You just will have a list of things that you "do not fuzz as these are
>>> dangerous".  Nothing new here, any os will have that.
>>
>> The list of kernel config options will become too complicated to maintain.
>> If we can have one kernel config option, we can avoid maintaining
>> the list of kernel config options (which keeps changing over time).
> 
> Use the newly added security_locked_down() call, that gives you a great
> indication that root can cause problems for those things.
> 

No. security_locked_down() is not for fuzz kernels but for real kernels.

"enum lockdown_reason" is overkill, it just keeps fuzzers away from finding bugs.
For example, if ftrace code has bugs but ftrace_event_open() prevents from
fuzzing due to security_locked_down(LOCKDOWN_TRACEFS) ? Fuzz kernels should not
count on security_locked_down() returning errors. That is no different from
disabling everything using kernel config options.

> And it's not a config thing, it's a functionality thing within features,
> as is explicitly shown by this very thread for the serial port memory
> location.

My suggestion is not for real kernels but for fuzz kernels.

