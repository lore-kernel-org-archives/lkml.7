Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C1EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE22D2339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfH2OJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:09:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:65367 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfH2OJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:09:13 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7TE9A90061951;
        Thu, 29 Aug 2019 23:09:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Thu, 29 Aug 2019 23:09:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7TE9AZZ061947
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 29 Aug 2019 23:09:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Edward Chron <echron@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
References: <20190826193638.6638-1-echron@arista.com>
 <20190827071523.GR7538@dhcp22.suse.cz>
 <CAM3twVRZfarAP6k=LLWH0jEJXu8C8WZKgMXCFKBZdRsTVVFrUQ@mail.gmail.com>
 <20190828065955.GB7386@dhcp22.suse.cz>
 <CAM3twVR_OLffQ1U-SgQOdHxuByLNL5sicfnObimpGpPQ1tJ0FQ@mail.gmail.com>
 <20190829071105.GQ28313@dhcp22.suse.cz>
 <297cf049-d92e-f13a-1386-403553d86401@i-love.sakura.ne.jp>
 <20190829115608.GD28313@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a8979b50-b8db-55c1-996b-6d86736513f5@i-love.sakura.ne.jp>
Date:   Thu, 29 Aug 2019 23:09:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829115608.GD28313@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/29 20:56, Michal Hocko wrote:
>> But please be aware that, I REPEAT AGAIN, I don't think neither eBPF nor
>> SystemTap will be suitable for dumping OOM information. OOM situation means
>> that even single page fault event cannot complete, and temporary memory
>> allocation for reading from kernel or writing to files cannot complete.
> 
> And I repeat that no such reporting is going to write to files. This is
> an OOM path afterall.

The process who fetches from e.g. eBPF event cannot involve page fault.
The front-end for iovisor/bcc is a python userspace process. But I think
that such process can't run under OOM situation.

> 
>> Therefore, we will need to hold all information in kernel memory (without
>> allocating any memory when OOM event happened). Dynamic hooks could hold
>> a few lines of output, but not all lines we want. The only possible buffer
>> which is preallocated and large enough would be printk()'s buffer. Thus,
>> I believe that we will have to use printk() in order to dump OOM information.
>> At that point,
> 
> Yes, this is what I've had in mind.

Probably I incorrectly shortcut.

Dynamic hooks could hold a few lines of output, but dynamic hooks can not hold
all lines when dump_tasks() reports 32000+ processes. We have to buffer all output
in kernel memory because we can't complete even a page fault event triggered by
the python process monitoring eBPF event (and writing the result to some log file
or something) while out_of_memory() is in flight.

And "set /proc/sys/vm/oom_dump_tasks to 0" is not the right reaction. What I'm
saying is "we won't be able to hold output from dump_tasks() if output from
dump_tasks() goes to buffer preallocated for dynamic hooks". We have to find
a way that can handle the worst case.
