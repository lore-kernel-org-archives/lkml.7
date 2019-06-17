Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B697C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B59420848
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfFQJ6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:58:30 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58941 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfFQJ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:58:29 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5H9upm3052739;
        Mon, 17 Jun 2019 18:56:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Mon, 17 Jun 2019 18:56:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5H9uksP052600
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 17 Jun 2019 18:56:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: general protection fault in oom_unkillable_task
To:     Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     syzbot <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuzhoujian@didichuxing.com
References: <0000000000004143a5058b526503@google.com>
 <CALvZod72=KuBZkSd0ey5orJFGFpwx462XY=cZvO3NOXC0MogFw@mail.gmail.com>
 <20190615134955.GA28441@dhcp22.suse.cz>
 <CALvZod4hT39PfGt9Ohj+g77om5=G0coHK=+G1=GKcm-PowkXsw@mail.gmail.com>
 <20190617063319.GB30420@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <268214f9-18ef-b63e-2d4f-c344a7dd5e72@i-love.sakura.ne.jp>
Date:   Mon, 17 Jun 2019 18:56:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617063319.GB30420@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/06/17 15:33, Michal Hocko wrote:
> On Sat 15-06-19 09:11:37, Shakeel Butt wrote:
>> On Sat, Jun 15, 2019 at 6:50 AM Michal Hocko <mhocko@kernel.org> wrote:
> [...]
>>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>>> index 5a58778c91d4..43eb479a5dc7 100644
>>> --- a/mm/oom_kill.c
>>> +++ b/mm/oom_kill.c
>>> @@ -161,8 +161,8 @@ static bool oom_unkillable_task(struct task_struct *p,
>>>                 return true;
>>>
>>>         /* When mem_cgroup_out_of_memory() and p is not member of the group */
>>> -       if (memcg && !task_in_mem_cgroup(p, memcg))
>>> -               return true;
>>> +       if (memcg)
>>> +               return false;
>>
>> This will break the dump_tasks() usage of oom_unkillable_task(). We
>> can change dump_tasks() to traverse processes like
>> mem_cgroup_scan_tasks() for memcg OOMs.
> 
> Right you are. Doing a similar trick to the oom victim selection is
> indeed better. We should really strive to not doing a global process
> iteration when we can do a targeted scan. Care to send a patch?

I posted a patch that (as a side effect) avoids oom_unkillable_task() from dump_tasks() at
https://lore.kernel.org/linux-mm/1558519686-16057-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/ .
What do you think?

