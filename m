Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E04C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A9C20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbfHFHEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:04:49 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36746 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731711AbfHFHEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:04:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TYo6kt7_1565075082;
Received: from 10.15.232.115(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TYo6kt7_1565075082)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 06 Aug 2019 15:04:43 +0800
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
References: <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com>
 <20190806032418.GA54717@aaronlu>
 <CAERHkrtJ3f1ggfG7Qo-KnznGo66p0Y3E0sAfb3ki6U=ADT6__g@mail.gmail.com>
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
Message-ID: <54fa27ff-69a7-b2ac-6152-6915f78a57f9@linux.alibaba.com>
Date:   Tue, 6 Aug 2019 15:04:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAERHkrtJ3f1ggfG7Qo-KnznGo66p0Y3E0sAfb3ki6U=ADT6__g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/6 14:56, Aubrey Li wrote:
> On Tue, Aug 6, 2019 at 11:24 AM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>> I've been thinking if we should consider core wide tenent fairness?
>>
>> Let's say there are 3 tasks on 2 threads' rq of the same core, 2 tasks
>> (e.g. A1, A2) belong to tenent A and the 3rd B1 belong to another tenent
>> B. Assume A1 and B1 are queued on the same thread and A2 on the other
>> thread, when we decide priority for A1 and B1, shall we also consider
>> A2's vruntime? i.e. shall we consider A1 and A2 as a whole since they
>> belong to the same tenent? I tend to think we should make fairness per
>> core per tenent, instead of per thread(cpu) per task(sched entity). What
>> do you guys think?
>>
> 
> I also think a way to make fairness per cookie per core, is this what you
> want to propose?

Yes, that's what I meant.
