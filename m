Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA8CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3384D206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfKRC2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 21:28:00 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57260 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbfKRC2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 21:28:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TiMbjiK_1574044075;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TiMbjiK_1574044075)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Nov 2019 10:27:55 +0800
Subject: Re: [RFC PATCH v4 0/7] Speed booting by sorting ORC unwind tables at
 build time
To:     hpa@zytor.com, Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20191115164539.57930-1-shile.zhang@linux.alibaba.com>
 <6DC4AA3A-15CA-43B5-B560-5DBB168D3899@zytor.com>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <d0e14f75-c668-8011-bc5b-7db070bbf5bc@linux.alibaba.com>
Date:   Mon, 18 Nov 2019 10:27:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6DC4AA3A-15CA-43B5-B560-5DBB168D3899@zytor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/18 10:18, hpa@zytor.com wrote:
> On November 15, 2019 8:45:32 AM PST, Shile Zhang <shile.zhang@linux.alibaba.com> wrote:
>> Hi,
>>
>> I refactored the code, followed by Peter's suggestions in v3, thank
>> you!
>> Any suggestions and comments are welcome!
>>
>> Thanks!
>>
>> Changelog:
>> ==========
>> v3->v4:
>> - Code refactored for Peter's review findings and suggestions.
>>
>> v2->v3:
>> - Discard new added sortorctable tool and related Kconfig changes.
>> - Refactored sortextable, makes it more readable and extendable.
>> - Rename 'sortextable' to 'sorttable', for more kernel tables extend.
>> - Add ORC unwind tables sort into sorttable.
>> - Remove the runtime ORC tables sort.
>> https://lore.kernel.org/lkml/20191115064750.47888-1-shile.zhang@linux.alibaba.com/
>>
>> v1->v2:
>> - Removed new added Kconfig and runtime sort code, advised by Josh
>> Poimboeuf.
>> - Some minor refactoring.
>> https://lore.kernel.org/lkml/20191108071108.72132-1-shile.zhang@linux.alibaba.com/
>>
>> v1:
>> - Added a new sortorctable tool to sort ORC unwind tables at build
>> time,
>>   same as sortextable.
>> - Add a new Kconfigure to control if ORC unwind tables sort at build
>>   time.
>> https://lore.kernel.org/lkml/20191107143205.206606-1-shile.zhang@linux.alibaba.com/
>>
>> Shile Zhang (7):
>>   scripts/sortextable: Rewrite error/success handling
>>   scripts/sortextable: kernel coding style formating
>>   scripts/sortextable: Remove dead code
>>   scripts/sortextable: refactor do_func() function
>>   scripts/sorttable: rename sortextable to sorttable
>>   scripts/sorttable: Add ORC unwind tables sort concurrently
>>   x86/unwind/orc: remove run-time ORC unwind tables sort
>>
>> arch/arc/Kconfig                       |   2 +-
>> arch/arm/Kconfig                       |   2 +-
>> arch/arm64/Kconfig                     |   2 +-
>> arch/microblaze/Kconfig                |   2 +-
>> arch/mips/Kconfig                      |   2 +-
>> arch/parisc/Kconfig                    |   2 +-
>> arch/parisc/kernel/vmlinux.lds.S       |   2 +-
>> arch/powerpc/Kconfig                   |   2 +-
>> arch/s390/Kconfig                      |   2 +-
>> arch/x86/Kconfig                       |   2 +-
>> arch/x86/kernel/unwind_orc.c           |   8 +-
>> arch/xtensa/Kconfig                    |   2 +-
>> init/Kconfig                           |   2 +-
>> scripts/.gitignore                     |   2 +-
>> scripts/Makefile                       |  10 +-
>> scripts/link-vmlinux.sh                |  10 +-
>> scripts/sortextable.h                  | 209 -------------
>> scripts/{sortextable.c => sorttable.c} | 299 +++++++++---------
>> scripts/sorttable.h                    | 401 +++++++++++++++++++++++++
>> 19 files changed, 568 insertions(+), 395 deletions(-)
>> delete mode 100644 scripts/sortextable.h
>> rename scripts/{sortextable.c => sorttable.c} (67%)
>> create mode 100644 scripts/sorttable.h
> Any actual time measurements?

Sorry for missed in cover letter!

The ORC unwind tables sorting cost about 100ms in boot time on my 
2vcpu16GB VM (with 2.5GHz Xeon CPU).
After sort at build time, the sorttable needs about 70ms in host.

Thanks!

