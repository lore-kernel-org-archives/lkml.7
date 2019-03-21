Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE20C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAB6218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfCULn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:43:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:41042 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfCULn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:43:56 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2LBfAnm057030;
        Thu, 21 Mar 2019 20:41:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Thu, 21 Mar 2019 20:41:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126094122116.bbtec.net [126.94.122.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2LBf57M056987
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 21 Mar 2019 20:41:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: kernel panic: corrupted stack end in wb_workfn
To:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     syzbot <syzbot+ec1b7575afef85a0e5ca@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, David Miller <davem@davemloft.net>,
        guro@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <jbacik@fb.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-sctp@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        netdev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vladislav Yasevich <vyasevich@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xin Long <lucien.xin@gmail.com>
References: <000000000000db3d130584506672@google.com>
 <d9e4e36d-1e7a-caaf-f96e-b05592405b5f@virtuozzo.com>
 <CACT4Y+Zj=35t2djhKoq+e1SH3Zu3389Pns7xX6MiMWZ=PFpShA@mail.gmail.com>
 <426293c3-bf63-88ad-06fb-83927ab0d7c0@I-love.SAKURA.ne.jp>
 <CACT4Y+Zh8eA50egLquE4LPffTCmF+30QR0pKTpuz_FpzsXVmZg@mail.gmail.com>
 <315c8ff3-fd03-f2ca-c546-ca7dc5c14669@virtuozzo.com>
 <CACT4Y+axojyHxk5K34YuLUyj+NJ05+FC3n8ozseHC91B1qn5ZQ@mail.gmail.com>
 <CACT4Y+aGyPpkrwvzZQUHXgipWo26T2U4OW0CxoJpp6yK+MgX=Q@mail.gmail.com>
 <CACT4Y+Z4yLPRRfRa4GhTDOQkuOsQccAOcBMoD4sgMmYj69ggrg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <cfec86c1-e1df-7eaa-a2b7-098f86bb5212@i-love.sakura.ne.jp>
Date:   Thu, 21 Mar 2019 20:41:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z4yLPRRfRa4GhTDOQkuOsQccAOcBMoD4sgMmYj69ggrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/21 18:51, Dmitry Vyukov wrote:
>>> Lots of bugs (half?) manifest differently. On top of this, titles
>>> change as we go back in history. On top of this, if we see a different
>>> bug, it does not mean that the original bug is also not there.
>>> This will sure solve some subset of cases better then the current
>>> logic. But I feel that that subset is smaller then what the current
>>> logic solves.
>>
>> Counter-examples come up in basically every other bisection.
>> For example:
>>
>> bisecting cause commit starting from ccda4af0f4b92f7b4c308d3acc262f4a7e3affad
>> building syzkaller on 5f5f6d14e80b8bd6b42db961118e902387716bcb
>> testing commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad with gcc (GCC) 8.1.0
>> all runs: crashed: KASAN: null-ptr-deref Read in refcount_sub_and_test_checked
>> testing release v4.19
>> testing commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d with gcc (GCC) 8.1.0
>> all runs: crashed: KASAN: null-ptr-deref Read in refcount_sub_and_test_checked
>> testing release v4.18
>> testing commit 94710cac0ef4ee177a63b5227664b38c95bbf703 with gcc (GCC) 8.1.0
>> all runs: crashed: KASAN: null-ptr-deref Read in refcount_sub_and_test
>> testing release v4.17
>> testing commit 29dcea88779c856c7dc92040a0c01233263101d4 with gcc (GCC) 8.1.0
>> all runs: crashed: KASAN: null-ptr-deref Read in refcount_sub_and_test
> 
> 
> And to make things even more interesting, this later changes to "BUG:
> unable to handle kernel NULL pointer dereference in vb2_vmalloc_put":
> 
> testing release v4.12
> testing commit 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c with gcc (GCC) 8.1.0
> all runs: crashed: general protection fault in refcount_sub_and_test
> testing release v4.11
> testing commit a351e9b9fc24e982ec2f0e76379a49826036da12 with gcc (GCC) 7.3.0
> all runs: crashed: BUG: unable to handle kernel NULL pointer
> dereference in vb2_vmalloc_put
> 
> And since the original bug is in vb2 subsystem
> (https://syzkaller.appspot.com/bug?id=17535f4bf5b322437f7c639b59161ce343fc55a9),
> it's actually not clear even for me, if we should treat it as the same
> bug or not. May be different manifestation of the same root cause, or
> a different bug around.
> 

Well, maybe we should use reproducers for checking whether each not-yet-fixed
problem is reproducible with old kernels rather than finding specific commit
that is causing specific problem?

I think there are two patterns syzbot starts reporting.

  (a) a commit which causes one or more problems is merged into a codebase where
      syzbot was already testing because syzbot already knew what/how should
      that codebase be tested.

  (b) a commit which causes one or more problems was already there in a codebase
      where syzbot did not know until now what/how should that codebase be tested.

(a) tends to require testing new kernels (i.e. bisection range is narrow) whereas
(b) tends to require testing old kernels (i.e. bisection range is wide).

Regarding case (b), it is difficult for developers to guess when the problem
started, and I think that (b) tends to confuse automatic bisection attempts.

Therefore, instead of trying to find specific commit for specific problem using
"git bisect" approach, try running all reproducers (gathered from all problems)
on each release (e.g. each git tag) and append reproduced crashes to the

  Manager Time Kernel Commit Syzkaller Config Log Report Syz repro C repro Maintainers

table for each not-yet-fixed problem of dashboard interface. That is, if running a
repro1 from problem1 on some old kernel reproduced a crash for problem2, append the
crash to the problem2's table. Maybe we want to use a new table with only

  Kernel Commit Syzkaller Config Log Report Syz repro C repro

entries because what we want to know is the oldest kernel release which helps
guessing when the problem started.
