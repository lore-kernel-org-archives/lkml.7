Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F423C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1ED2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404493AbfHHV7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:59:35 -0400
Received: from 68.66.241.172.static.a2webhosting.com ([68.66.241.172]:37936
        "EHLO vps.redhazel.co.uk" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbfHHV7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 17:59:34 -0400
Received: from [192.168.1.66] (unknown [212.159.68.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vps.redhazel.co.uk (Postfix) with ESMTPSA id A2A331C0219A;
        Thu,  8 Aug 2019 22:59:32 +0100 (BST)
From:   ndrw <ndrw.xf@redhazel.co.uk>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20190806142728.GA12107@cmpxchg.org>
 <20190806143608.GE11812@dhcp22.suse.cz>
 <CAJuCfpFmOzj-gU1NwoQFmS_pbDKKd2XN=CS1vUV4gKhYCJOUtw@mail.gmail.com>
 <20190806220150.GA22516@cmpxchg.org> <20190807075927.GO11812@dhcp22.suse.cz>
 <20190807205138.GA24222@cmpxchg.org> <20190808114826.GC18351@dhcp22.suse.cz>
 <806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk>
 <20190808163228.GE18351@dhcp22.suse.cz>
 <5FBB0A26-0CFE-4B88-A4F2-6A42E3377EDB@redhazel.co.uk>
 <20190808185925.GH18351@dhcp22.suse.cz>
Message-ID: <08e5d007-a41a-e322-5631-b89978b9cc20@redhazel.co.uk>
Date:   Thu, 8 Aug 2019 22:59:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808185925.GH18351@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2019 19:59, Michal Hocko wrote:
> Well, I am afraid that implementing anything like that in the kernel
> will lead to many regressions and bug reports. People tend to have very
> different opinions on when it is suitable to kill a potentially
> important part of a workload just because memory gets low.

Are you proposing having a zero memory reserve or not having such option 
at all? I'm fine with the current default (zero reserve/margin).

I strongly prefer forcing OOM killer when the system is still running 
normally. Not just for preventing stalls: in my limited testing I found 
the OOM killer on a stalled system rather inaccurate, occasionally 
killing system services etc. I had much better experience with earlyoom.

> LRU aspect doesn't help much, really. If we are reclaiming the same set
> of pages becuase they are needed for the workload to operate then we are
> effectivelly treshing no matter what kind of replacement policy you are
> going to use.

In my case it would work fine (my system already works well with 
earlyoom, and without it it remains responsive until last couple hundred 
MB of RAM).


>>> PSI is giving you a matric that tells you how much time you
>>> spend on the memory reclaim. So you can start watching the system from
>>> lower utilization already.

I've tested it on a system with 45GB of RAM, SSD, swap disabled (my 
intention was to approximate a worst-case scenario) and it didn't really 
detect stall before it happened. I can see some activity after reaching 
~42GB, the system remains fully responsive until it suddenly freezes and 
requires sysrq-f. PSI appears to increase a bit when the system is about 
to run out of memory but the change is so small it would be difficult to 
set a reliable threshold. I expect the PSI numbers to increase 
significantly after the stall (I wasn't able to capture them) but, as 
mentioned above, I was hoping for a solution that would work before the 
stall.

$ while true; do sleep 1; cat /proc/pressure/memory ; done
[starting a test script and waiting for several minutes to fill up memory]
some avg10=0.00 avg60=0.00 avg300=0.00 total=0
full avg10=0.00 avg60=0.00 avg300=0.00 total=0
some avg10=0.00 avg60=0.00 avg300=0.00 total=10389
full avg10=0.00 avg60=0.00 avg300=0.00 total=6442
some avg10=0.00 avg60=0.00 avg300=0.00 total=18950
full avg10=0.00 avg60=0.00 avg300=0.00 total=11576
some avg10=0.00 avg60=0.00 avg300=0.00 total=25655
full avg10=0.00 avg60=0.00 avg300=0.00 total=16159
some avg10=0.00 avg60=0.00 avg300=0.00 total=31438
full avg10=0.00 avg60=0.00 avg300=0.00 total=19552
some avg10=0.00 avg60=0.00 avg300=0.00 total=44549
full avg10=0.00 avg60=0.00 avg300=0.00 total=27772
some avg10=0.00 avg60=0.00 avg300=0.00 total=52520
full avg10=0.00 avg60=0.00 avg300=0.00 total=32580
some avg10=0.00 avg60=0.00 avg300=0.00 total=60451
full avg10=0.00 avg60=0.00 avg300=0.00 total=37704
some avg10=0.00 avg60=0.00 avg300=0.00 total=68986
full avg10=0.00 avg60=0.00 avg300=0.00 total=42859
some avg10=0.00 avg60=0.00 avg300=0.00 total=76598
full avg10=0.00 avg60=0.00 avg300=0.00 total=48370
some avg10=0.00 avg60=0.00 avg300=0.00 total=83080
full avg10=0.00 avg60=0.00 avg300=0.00 total=52930
some avg10=0.00 avg60=0.00 avg300=0.00 total=89384
full avg10=0.00 avg60=0.00 avg300=0.00 total=56350
some avg10=0.00 avg60=0.00 avg300=0.00 total=95293
full avg10=0.00 avg60=0.00 avg300=0.00 total=60260
some avg10=0.00 avg60=0.00 avg300=0.00 total=101566
full avg10=0.00 avg60=0.00 avg300=0.00 total=64408
some avg10=0.00 avg60=0.00 avg300=0.00 total=108131
full avg10=0.00 avg60=0.00 avg300=0.00 total=68412
some avg10=0.00 avg60=0.00 avg300=0.00 total=121932
full avg10=0.00 avg60=0.00 avg300=0.00 total=77413
some avg10=0.00 avg60=0.00 avg300=0.00 total=140807
full avg10=0.00 avg60=0.00 avg300=0.00 total=91269
some avg10=0.00 avg60=0.00 avg300=0.00 total=170494
full avg10=0.00 avg60=0.00 avg300=0.00 total=110611
[stall, sysrq-f]

Best regards,

ndrw


