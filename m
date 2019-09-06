Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AACC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C8D206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbfIFLLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:11:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64720 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfIFLLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:11:33 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x86BBLX5076555;
        Fri, 6 Sep 2019 20:11:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Fri, 06 Sep 2019 20:11:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x86BBKQs076551
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 6 Sep 2019 20:11:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] mm, oom: disable dump_tasks by default
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190903144512.9374-1-mhocko@kernel.org>
 <af0703d2-17e4-1b8e-eb54-58d7743cad60@i-love.sakura.ne.jp>
 <20190904054004.GA3838@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909041302290.95127@chino.kir.corp.google.com>
 <12bcade2-4190-5e5e-35c6-7a04485d74b9@i-love.sakura.ne.jp>
 <20190905140833.GB3838@dhcp22.suse.cz>
 <20ec856d-0f1e-8903-dbe0-bbc8b7a1847a@i-love.sakura.ne.jp>
 <20190906110233.GE14491@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0825c4b6-377d-f9ef-034d-648cfd675e2c@i-love.sakura.ne.jp>
Date:   Fri, 6 Sep 2019 20:11:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906110233.GE14491@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/09/06 20:02, Michal Hocko wrote:
> On Fri 06-09-19 19:46:10, Tetsuo Handa wrote:
>> On 2019/09/05 23:08, Michal Hocko wrote:
>>> On Thu 05-09-19 22:39:47, Tetsuo Handa wrote:
>>> [...]
>>>> There is nothing that prevents users from enabling oom_dump_tasks by sysctl.
>>>> But that requires a solution for OOM stalling problem.
>>>
>>> You can hardly remove stalling if you are not reducing the amount of
>>> output or get it into a different context. Whether the later is
>>> reasonable is another question but you are essentially losing "at the
>>> OOM event state".
>>>
>>
>> I am not losing "at the OOM event state". Please find "struct oom_task_info"
>> (for now) embedded into "struct task_struct" which holds "at the OOM event state".
>>
>> And my patch moves "printk() from dump_tasks()" from OOM context to WQ context.
> 
> Workers might be blocked for unbound amount of time and so this
> information might be printed late.
> 

Yes, but the OOM reaper will quickly reclaim memory. And if WQ is blocked, new WQ
for processing this work will be created (because OOM situation is quickly solved).

Nonetheless if your worry turns out to be a real problem, we can use a dedicated WQ
or offload to e.g. the OOM reaper kernel thread. Anyway, such tuning is beyond the
scope of my patch.
