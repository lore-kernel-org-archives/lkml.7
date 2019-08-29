Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977A6C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FFE23428
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfH2KO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:14:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53035 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfH2KO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:14:56 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7TAEseo053121;
        Thu, 29 Aug 2019 19:14:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Thu, 29 Aug 2019 19:14:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7TAEmjO052966
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 29 Aug 2019 19:14:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
To:     Michal Hocko <mhocko@kernel.org>, Edward Chron <echron@arista.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <297cf049-d92e-f13a-1386-403553d86401@i-love.sakura.ne.jp>
Date:   Thu, 29 Aug 2019 19:14:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829071105.GQ28313@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/29 16:11, Michal Hocko wrote:
> On Wed 28-08-19 12:46:20, Edward Chron wrote:
>> Our belief is if you really think eBPF is the preferred mechanism
>> then move OOM reporting to an eBPF.
> 
> I've said that all this additional information has to be dynamically
> extensible rather than a part of the core kernel. Whether eBPF is the
> suitable tool, I do not know. I haven't explored that. There are other
> ways to inject code to the kernel. systemtap/kprobes, kernel modules and
> probably others.

As for SystemTap, guru mode (an expert mode which disables protection provided
by SystemTap; allowing kernel to crash when something went wrong) could be used
for holding spinlock. However, as far as I know, holding mutex (or doing any
operation that might sleep) from such dynamic hooks is not allowed. Also we will
need to export various symbols in order to allow access from such dynamic hooks.

I'm not familiar with eBPF, but I guess that eBPF is similar.

But please be aware that, I REPEAT AGAIN, I don't think neither eBPF nor
SystemTap will be suitable for dumping OOM information. OOM situation means
that even single page fault event cannot complete, and temporary memory
allocation for reading from kernel or writing to files cannot complete.

Therefore, we will need to hold all information in kernel memory (without
allocating any memory when OOM event happened). Dynamic hooks could hold
a few lines of output, but not all lines we want. The only possible buffer
which is preallocated and large enough would be printk()'s buffer. Thus,
I believe that we will have to use printk() in order to dump OOM information.
At that point,

  static bool (*oom_handler)(struct oom_control *oc) = default_oom_killer;

  bool out_of_memory(struct oom_control *oc)
  {
          return oom_handler(oc);
  }

and let in-tree kernel modules override current OOM killer would be
the only practical choice (if we refuse adding many knobs).

