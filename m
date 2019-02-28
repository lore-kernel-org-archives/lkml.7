Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F0AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87B620857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388351AbfB1R65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:58:57 -0500
Received: from www62.your-server.de ([213.133.104.62]:57300 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfB1R64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:58:56 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzPx8-0004Dz-CM; Thu, 28 Feb 2019 18:58:38 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzPx8-000Doz-41; Thu, 28 Feb 2019 18:58:38 +0100
Subject: Re: [tip:x86/build] x86, retpolines: Raise limit for generating
 indirect calls from switch-case
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, bjorn.topel@intel.com,
        David Miller <davem@davemloft.net>, brouer@redhat.com,
        magnus.karlsson@intel.com, Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, ast@kernel.org,
        linux-tip-commits@vger.kernel.org
References: <20190221221941.29358-1-daniel@iogearbox.net>
 <tip-ce02ef06fcf7a399a6276adb83f37373d10cbbe1@git.kernel.org>
 <33bf951448e7d916fd4a6ad41cd3d040e9d1f118.camel@infradead.org>
 <CAMe9rOrcOVRWuNWy3xp7NMD=2UbGH+C5zifDhd=-AxrrzEVrmw@mail.gmail.com>
 <79add9a9-543b-a791-ecbe-79edd49f1bb3@iogearbox.net>
 <CAMe9rOryEsLHossVa=QmaKW1wbW67AOnewkB_RN_WkveBEwnZg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4604e680-7962-f1ee-5b79-711247f4e7d5@iogearbox.net>
Date:   Thu, 28 Feb 2019 18:58:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAMe9rOryEsLHossVa=QmaKW1wbW67AOnewkB_RN_WkveBEwnZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2019 05:25 PM, H.J. Lu wrote:
> On Thu, Feb 28, 2019 at 8:18 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 02/28/2019 01:53 PM, H.J. Lu wrote:
>>> On Thu, Feb 28, 2019 at 3:27 AM David Woodhouse <dwmw2@infradead.org> wrote:
>>>> On Thu, 2019-02-28 at 03:12 -0800, tip-bot for Daniel Borkmann wrote:
>>>>> Commit-ID:  ce02ef06fcf7a399a6276adb83f37373d10cbbe1
>>>>> Gitweb:     https://git.kernel.org/tip/ce02ef06fcf7a399a6276adb83f37373d10cbbe1
>>>>> Author:     Daniel Borkmann <daniel@iogearbox.net>
>>>>> AuthorDate: Thu, 21 Feb 2019 23:19:41 +0100
>>>>> Committer:  Thomas Gleixner <tglx@linutronix.de>
>>>>> CommitDate: Thu, 28 Feb 2019 12:10:31 +0100
>>>>>
>>>>> x86, retpolines: Raise limit for generating indirect calls from switch-case
>>>>>
>>>>> From networking side, there are numerous attempts to get rid of indirect
>>>>> calls in fast-path wherever feasible in order to avoid the cost of
>>>>> retpolines, for example, just to name a few:
>>>>>
>>>>>   * 283c16a2dfd3 ("indirect call wrappers: helpers to speed-up indirect calls of builtin")
>>>>>   * aaa5d90b395a ("net: use indirect call wrappers at GRO network layer")
>>>>>   * 028e0a476684 ("net: use indirect call wrappers at GRO transport layer")
>>>>>   * 356da6d0cde3 ("dma-mapping: bypass indirect calls for dma-direct")
>>>>>   * 09772d92cd5a ("bpf: avoid retpoline for lookup/update/delete calls on maps")
>>>>>   * 10870dd89e95 ("netfilter: nf_tables: add direct calls for all builtin expressions")
>>>>>   [...]
>>>>>
>>>>> Recent work on XDP from Björn and Magnus additionally found that manually
>>>>> transforming the XDP return code switch statement with more than 5 cases
>>>>> into if-else combination would result in a considerable speedup in XDP
>>>>> layer due to avoidance of indirect calls in CONFIG_RETPOLINE enabled
>>>>> builds.
>>>>
>>>> +HJL
>>>>
>>>> This is a GCC bug, surely? It should know how expensive each
>>>> instruction is, and choose which to use accordingly. That should be
>>>> true even when the indirect branch "instruction" is a retpoline, and
>>>> thus enormously expensive.
>>>>
>>>> I believe this is https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86952 so
>>>> please at least reference that bug, and be prepared to turn this hack
>>>> off when GCC is fixed.
>>>
>>> We couldn't find a testcase to show jump table with indirect branch
>>> is slower than direct branches.
>>
>> Ok, I've just checked https://github.com/marxin/microbenchmark/tree/retpoline-table
>> with the below on top.
>>
>>  Makefile | 6 +++---
>>  switch.c | 2 +-
>>  test.c   | 6 ++++--
>>  3 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index bd83233..ea81520 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1,16 +1,16 @@
>>  CC=gcc
>>  CFLAGS=-g -I.
>> -CFLAGS+=-O2 -mindirect-branch=thunk
>> +CFLAGS+=-O2 -mindirect-branch=thunk-inline -mindirect-branch-register
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Does slowdown show up only with -mindirect-branch=thunk-inline?

Not really, numbers are in similar range / outcome. Additionally, I also tried
on a bit bigger machine (Xeon Gold 5120 this time). First is thunk-inline, second
is thunk, and third is w/o raising limit for comparison; first test (from last
mail) on that machine:

root@test:~/microbenchmark# make
gcc -g -I. -O2 -mindirect-branch=thunk-inline -mindirect-branch-register   -c -o test.o test.c
gcc -g -I. -O2 -mindirect-branch=thunk-inline -mindirect-branch-register --param=case-values-threshold=20   -c -o switch-no-table.o switch-no-table.c
gcc -g -I. -O2 -mindirect-branch=thunk-inline -mindirect-branch-register   -c -o switch.o switch.c
gcc -o test test.o switch-no-table.o switch.o
./test
no jump table: 5624962964
jump table   : 13016449922 (231.41%)
root@test:~/microbenchmark# make
./test
no jump table: 5619612366
jump table   : 13014680544 (231.59%)
root@test:~/microbenchmark# make
./test
no jump table: 5619725000
jump table   : 13003825442 (231.40%)
root@test:~/microbenchmark# make
./test
no jump table: 5619668520
jump table   : 13011259440 (231.53%)
root@test:~/microbenchmark# make
./test
no jump table: 5623093740
jump table   : 13044403684 (231.98%)

root@test:~/microbenchmark# make
gcc -g -I. -O2 -mindirect-branch=thunk   -c -o test.o test.c
gcc -g -I. -O2 -mindirect-branch=thunk --param=case-values-threshold=20   -c -o switch-no-table.o switch-no-table.c
gcc -g -I. -O2 -mindirect-branch=thunk   -c -o switch.o switch.c
gcc -o test test.o switch-no-table.o switch.o
./test
no jump table: 5620474618
jump table   : 13373059114 (237.93%)
root@test:~/microbenchmark# make
./test
no jump table: 5619791082
jump table   : 13325518382 (237.12%)
root@test:~/microbenchmark# make
./test
no jump table: 5621678214
jump table   : 13335416770 (237.21%)
root@test:~/microbenchmark# make
./test
no jump table: 5621402772
jump table   : 13345090466 (237.40%)

root@test:~/microbenchmark# make
gcc -g -I. -O2 -mindirect-branch=thunk   -c -o test.o test.c
gcc -g -I. -O2 -mindirect-branch=thunk   -c -o switch-no-table.o switch-no-table.c
gcc -g -I. -O2 -mindirect-branch=thunk   -c -o switch.o switch.c
gcc -o test test.o switch-no-table.o switch.o
./test
no jump table: 13658170002
jump table   : 13404815232 (98.15%)
root@test:~/microbenchmark# make
./test
no jump table: 13664287098
jump table   : 13407352204 (98.12%)
root@test:~/microbenchmark# make
./test
no jump table: 13667680182
jump table   : 13422187370 (98.20%)
root@test:~/microbenchmark# make
./test
no jump table: 13665625094
jump table   : 13420373364 (98.21%)
root@test:~/microbenchmark#

Thanks,
Daniel
