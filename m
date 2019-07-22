Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B04C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D744C214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfGVKnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:43:22 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48149 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728031AbfGVKnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:43:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0TXXAZC9_1563792195;
Received: from 30.17.233.143(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TXXAZC9_1563792195)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Jul 2019 18:43:16 +0800
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <20190531210816.GA24027@sinkpad> <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
Message-ID: <18fdcd2b-9064-6895-5948-feed65f96e35@linux.alibaba.com>
Date:   Mon, 22 Jul 2019 18:43:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/22 18:26, Aubrey Li wrote:
> The granularity period of util_avg seems too large to decide task priority
> during pick_task(), at least it is in my case, cfs_prio_less() always picked
> core max task, so pick_task() eventually picked idle, which causes this change
> not very helpful for my case.
> 
>  <idle>-0     [057] dN..    83.716973: __schedule: max: sysbench/2578
> ffff889050f68600
>  <idle>-0     [057] dN..    83.716974: __schedule:
> (swapper/5/0;140,0,0) ?< (mysqld/2511;119,1042118143,0)
>  <idle>-0     [057] dN..    83.716975: __schedule:
> (sysbench/2578;119,96449836,0) ?< (mysqld/2511;119,1042118143,0)
>  <idle>-0     [057] dN..    83.716975: cfs_prio_less: picked
> sysbench/2578 util_avg: 20 527 -507 <======= here===
>  <idle>-0     [057] dN..    83.716976: __schedule: pick_task cookie
> pick swapper/5/0 ffff889050f68600

Can you share your setup of the test? I would like to try it locally.
Thanks.
