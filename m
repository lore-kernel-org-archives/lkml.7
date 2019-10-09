Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6BEC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF0020679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbfJITdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:33:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfJITdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:33:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9017687630;
        Wed,  9 Oct 2019 19:33:05 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A97B1001DD7;
        Wed,  9 Oct 2019 19:33:03 +0000 (UTC)
Date:   Wed, 9 Oct 2019 15:33:02 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v3 0/8] sched/fair: rework the CFS load balance
Message-ID: <20191009193301.GC25192@pauld.bos.csb>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <20191008143258.GC8431@pauld.bos.csb>
 <CAKfTPtBsFoWOMP=+JHgtKV3S8o3Ha7RKgWcE+g1qaeqvP3xHVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBsFoWOMP=+JHgtKV3S8o3Ha7RKgWcE+g1qaeqvP3xHVw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 09 Oct 2019 19:33:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 05:53:11PM +0200 Vincent Guittot wrote:
> Hi Phil,
>  

...

> While preparing v4, I have noticed that I have probably oversimplified
> the end of find_idlest_group() in patch "sched/fair: optimize
> find_idlest_group" when it compares local vs the idlest other group.
> Especially, there were a NUMA specific test that I removed in v3 and
> re added in v4.
> 
> Then, I'm also preparing a full rework that find_idlest_group() which
> will behave more closely to load_balance; I mean : collect statistics,
> classify group then selects the idlest
> 

Okay, I'll watch for V4 and restest. It really seems to be limited to 
the 8-node system. None of the other systems are showing this.


> What is the behavior of lu.C Thread ? are they waking up a lot  ?and
> could trigger the slow wake path ?

Yes, probably a fair bit of waking. It's an interative equation solving
code. It's fairly CPU intensive but requires communication for dependent
calculations.  That's part of why having them mis-balanced causes such a 
large slow down. I think at times everyone else waits for the slow guys.
 

> 
> >
> > The initial fixes I made for this issue did not exhibit this behavior. They
> > would have had other issues dealing with overload cases though. In this case
> > however there are only 154 or 158 threads on 160 CPUs so not overloaded.
> >
> > I'll try to get my hands on this system and poke into it. I just wanted to get
> > your thoughts and let you know where we are.
> 
> Thanks for testing
>

Sure!


Thanks,
Phil



 
> Vincent
> 
> >
> >
> >
> > Thanks,
> > Phil
> >
> >
> > System details:
> >
> > Architecture:        x86_64
> > CPU op-mode(s):      32-bit, 64-bit
> > Byte Order:          Little Endian
> > CPU(s):              160
> > On-line CPU(s) list: 0-159
> > Thread(s) per core:  2
> > Core(s) per socket:  10
> > Socket(s):           8
> > NUMA node(s):        8
> > Vendor ID:           GenuineIntel
> > CPU family:          6
> > Model:               47
> > Model name:          Intel(R) Xeon(R) CPU E7- 4870  @ 2.40GHz
> > Stepping:            2
> > CPU MHz:             1063.934
> > BogoMIPS:            4787.73
> > Virtualization:      VT-x
> > L1d cache:           32K
> > L1i cache:           32K
> > L2 cache:            256K
> > L3 cache:            30720K
> > NUMA node0 CPU(s):   0-9,80-89
> > NUMA node1 CPU(s):   10-19,90-99
> > NUMA node2 CPU(s):   20-29,100-109
> > NUMA node3 CPU(s):   30-39,110-119
> > NUMA node4 CPU(s):   40-49,120-129
> > NUMA node5 CPU(s):   50-59,130-139
> > NUMA node6 CPU(s):   60-69,140-149
> > NUMA node7 CPU(s):   70-79,150-159
> > Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 popcnt aes lahf_lm epb pti tpr_shadow vnmi flexpriority ept vpid dtherm ida arat
> >
> > $ numactl --hardware
> > available: 8 nodes (0-7)
> > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 80 81 82 83 84 85 86 87 88 89
> > node 0 size: 64177 MB
> > node 0 free: 60866 MB
> > node 1 cpus: 10 11 12 13 14 15 16 17 18 19 90 91 92 93 94 95 96 97 98 99
> > node 1 size: 64507 MB
> > node 1 free: 61167 MB
> > node 2 cpus: 20 21 22 23 24 25 26 27 28 29 100 101 102 103 104 105 106 107 108
> > 109
> > node 2 size: 64507 MB
> > node 2 free: 61250 MB
> > node 3 cpus: 30 31 32 33 34 35 36 37 38 39 110 111 112 113 114 115 116 117 118
> > 119
> > node 3 size: 64507 MB
> > node 3 free: 61327 MB
> > node 4 cpus: 40 41 42 43 44 45 46 47 48 49 120 121 122 123 124 125 126 127 128
> > 129
> > node 4 size: 64507 MB
> > node 4 free: 60993 MB
> > node 5 cpus: 50 51 52 53 54 55 56 57 58 59 130 131 132 133 134 135 136 137 138
> > 139
> > node 5 size: 64507 MB
> > node 5 free: 60892 MB
> > node 6 cpus: 60 61 62 63 64 65 66 67 68 69 140 141 142 143 144 145 146 147 148
> > 149
> > node 6 size: 64507 MB
> > node 6 free: 61139 MB
> > node 7 cpus: 70 71 72 73 74 75 76 77 78 79 150 151 152 153 154 155 156 157 158
> > 159
> > node 7 size: 64480 MB
> > node 7 free: 61188 MB
> > node distances:
> > node   0   1   2   3   4   5   6   7
> >  0:  10  12  17  17  19  19  19  19
> >  1:  12  10  17  17  19  19  19  19
> >  2:  17  17  10  12  19  19  19  19
> >  3:  17  17  12  10  19  19  19  19
> >  4:  19  19  19  19  10  12  17  17
> >  5:  19  19  19  19  12  10  17  17
> >  6:  19  19  19  19  17  17  10  12
> >  7:  19  19  19  19  17  17  12  10
> >
> >
> >
> > --

-- 
