Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EE4C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F0B2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfGJOT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:19:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46568 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfGJOT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:19:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so1294500plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 07:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ggCy5DaAoOLhu/lmTeaYRX9QH2HBX0XI6WkttIONUks=;
        b=RJ3288irNliVTsV/uvSS+F542RR4i5nQFEifCBXHv6vijqqG8AtNCZ1g2M2aqY5+2I
         K3o+MY4ZI/wgBpAF/U3PwsG4pEK+JpWhpyOP27CF3Vx2GamoocadHi0ZB7UA7uBu8k7J
         zuweP+WigqTbD5IPyfpfMxeTabYYAkrAZPwa/eM1/i2/DYiQBgljLdRBGWfEg9Gq3pit
         yZcjzPMBVdTs15e387AWwGo3MYKJiuLTmcWlfnrzbFF3giRiGC639O2xGJB+X7A5AQpp
         HPIGbyXO47aCh7gPG0qAamLV5OHsZ8Q0YQpPyG8WEtD0/s7DY+avGgpP27ChDMf0wlDD
         lewA==
X-Gm-Message-State: APjAAAUrttqfg6uGUxo9vLZd4qznQf2yZ7GAyO9XSqrc390K3ri93ljH
        Ha+swdkyzS/hYOat71GXV4M=
X-Google-Smtp-Source: APXvYqxkLxFzT59ZGUCfkBBn58eoKFPBOrUWcdmRGpB3x5w002gS8dsXdtGEutt6QguFnJ3jXDnDxA==
X-Received: by 2002:a17:902:549:: with SMTP id 67mr39154016plf.86.1562768398246;
        Wed, 10 Jul 2019 07:19:58 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:f8eb:b8a1:fefa:e83f])
        by smtp.gmail.com with ESMTPSA id y10sm2555415pfm.66.2019.07.10.07.19.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 07:19:57 -0700 (PDT)
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <00000000000089a718058556e1d8@google.com>
 <f71aaffa-ecf4-1def-fe50-91f37c677537@acm.org>
 <20190710053030.GB2152@sol.localdomain>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b378a903-d0fc-a137-e6b9-dec55277cf16@acm.org>
Date:   Wed, 10 Jul 2019 07:19:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710053030.GB2152@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/19 10:30 PM, Eric Biggers wrote:
> [Moved most people to Bcc; syzbot added way too many random people to this.]
> 
> Hi Bart,
> 
> On Sat, Mar 30, 2019 at 07:17:09PM -0700, Bart Van Assche wrote:
>> On 3/30/19 2:58 PM, syzbot wrote:
>>> syzbot has bisected this bug to:
>>>
>>> commit 669de8bda87b92ab9a2fc663b3f5743c2ad1ae9f
>>> Author: Bart Van Assche <bvanassche@acm.org>
>>> Date:   Thu Feb 14 23:00:54 2019 +0000
>>>
>>>       kernel/workqueue: Use dynamic lockdep keys for workqueues
>>>
>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f1bacd200000
>>> start commit:   0e40da3e Merge tag 'kbuild-fixes-v5.1' of
>>> git://git.kernel..
>>> git tree:       upstream
>>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1409bacd200000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1009bacd200000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
>>> dashboard link:
>>> https://syzkaller.appspot.com/bug?extid=6f39a9deb697359fe520
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e1bacd200000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1120fe0f200000
>>>
>>> Reported-by: syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com
>>> Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for
>>> workqueues")
>>>
>>> For information about bisection process see:
>>> https://goo.gl/tpsmEJ#bisection
>>
>> Hi Dmitry,
>>
>> This bisection result doesn't make sense to me. As one can see, the message
>> "BUG: MAX_STACK_TRACE_ENTRIES too low!" does not occur in the console output
>> the above console output URL points at.
>>
>> Bart.
> 
> This is still happening on mainline, and I think this bisection result is
> probably correct.  syzbot did start hitting something different at the very end
> of the bisection ("WARNING: CPU: 0 PID: 9153 at kernel/locking/lockdep.c:747")
> but that seems to be just because your commit had a lot of bugs in it, which had
> to be fixed by later commits.  In particular, the WARNING seems to have been
> fixed by commit 28d49e282665e ("locking/lockdep: Shrink struct lock_class_key").
> 
> What seems to still be happening is that the dynamic lockdep keys which you
> added make it possible for an unbounded number of entries to be added to the
> fixed length stack_trace[] array in kernel/locking/lockdep.c.  Hence the "BUG:
> MAX_STACK_TRACE_ENTRIES too low!".
> 
> Am I understanding it correctly?  How did you intend this to work?

The last two paragraphs do not make sense to me. My changes do not 
increase the number of stack traces that get recorded by the lockdep code.

Bart.
