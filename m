Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6786C31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2EA2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NervFuQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfFMVeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:34:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37477 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMVeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:34:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so385213qkl.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=EVRWfobaNaVm+W0JKtsU9wphVcOIrKD7yE8vaQCIDqo=;
        b=NervFuQxG/81VFmsUiiCY8H4nhIU56bmosXRVYRjaky0QWBQGxLd9XbWPdWjljYqzR
         JS9GMv+ZL1VohRmjOZSuNsDtlm8GgYwxooElIywAHSeU9sGJhs1KDucUjndsq3tg00mT
         CbjN8rBPsfDeAyjfb8DorW7PHR9Sgm2UPOeRdyMyaKuwwygoXFY0t15R5KT4K9vkFxng
         6ZmRZIc+RXoxSvcgafwhBcoMd1taf8d7M9nY5tcSMMmbSEvko0ChLQ2gUX/KkLNJXNyg
         fSWHv4AQ3LUEN1VAuDe3jqFq+vOZIFNHxSGr2/Su6JVFO9USrPt1w+tiAQALOT4zx670
         xEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=EVRWfobaNaVm+W0JKtsU9wphVcOIrKD7yE8vaQCIDqo=;
        b=WI51x0/W+h6D/u1eZNlMHraXvgaruwo1RJXr6TsP/UrCDYSsOR33nb6k8unbg6RRhz
         EDM9KseE9wBHAsldEQJO3k7URp8lADFH+wF1hk8PpWPypITqFmAEDJjiS4zDqhzCRL1h
         lM1cabxWcVWmAbbDzVSZdH7iF4/fTPwlnKDCK8p+WMVpHULOfkk1dtXHhIZmghdz/Gln
         OvASEvDml6z+8lAWytC1TkjF+DBhCAaH759U2JI0Ml+uXqXgXw1YXGBbE4QdN26fO5R2
         AXUaK1R0dzvPuwhRVN97oEslIAECoWBPwpbvaJ+y+Mt2x0M1BAxUa9o2s4D5kIJdM3Ex
         KmwA==
X-Gm-Message-State: APjAAAX07c78b9YEnE8n3x77Zm3FQdiddZlKk0413J/oRbc8QMgwQnQP
        2X2eocnlX4p2VOhyIX41p/cOeA==
X-Google-Smtp-Source: APXvYqyDUpKRqoy2HstGgqJFci4mizZ3VAHPyqqsi0JxdZABzQE75j2jARmRfw1bRGsAs0PxOaQY4w==
X-Received: by 2002:ae9:f016:: with SMTP id l22mr34543234qkg.51.1560461642889;
        Thu, 13 Jun 2019 14:34:02 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y29sm498369qkj.8.2019.06.13.14.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 14:34:02 -0700 (PDT)
Message-ID: <1560461641.5154.19.camel@lca.pw>
Subject: LTP hugemmap05 test case failure on arm64 with linux-next
 (next-20190613)
From:   Qian Cai <cai@lca.pw>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 13 Jun 2019 17:34:01 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP hugemmap05 test case [1] could not exit itself properly and then degrade the
system performance on arm64 with linux-next (next-20190613). The bisection so
far indicates,

BAD:  30bafbc357f1 Merge remote-tracking branch 'arm64/for-next/core'
GOOD: 0c3d124a3043 Merge remote-tracking branch 'arm64-fixes/for-next/fixes'

I don't see anything obvious between those two pull requests, so I guess
something in 'arm64/for-next/core' is wrong.

$ git log --oneline 361413ee1992..9b6047220590
9b6047220590 arm64: mm: avoid redundant READ_ONCE(*ptep)
4745224b4509 arm64/mm: Refactor __do_page_fault()
c49bd02f4c74 arm64/mm: Document write abort detection from ESR
8e01076afd97 arm64: Fix comment after #endif
f086f67485c5 arm64: ptrace: add support for syscall emulation
fd3866381be2 arm64: add PTRACE_SYSEMU{,SINGLESTEP} definations to uapi headers
15532fd6f57c ptrace: move clearing of TIF_SYSCALL_EMU flag to core
616810360043 arm64/mm: Drop task_struct argument from __do_page_fault()
a0509313d5de arm64/mm: Drop mmap_sem before calling __do_kernel_fault()
01de1776f62e arm64/mm: Identify user instruction aborts
87dedf7c61ab arm64/mm: Change BUG_ON() to VM_BUG_ON() in [pmd|pud]_set_huge()
2e6aee5af330 arm64: kernel: use aff3 instead of aff2 in comment
27e6e7d63fc2 arm64/cpufeature: Convert hook_lock to raw_spin_lock_t in
cpu_enable_ssbs()
0c1f14ed1226 arm64: mm: make CONFIG_ZONE_DMA32 configurable
f7f0097af67c arm64/mm: Simplify protection flag creation for kernel huge
mappings
7b8c87b297a7 arm64: cacheinfo: Update cache_line_size detected from DT or PPTT
9a83c84c3a49 drivers: base: cacheinfo: Add variable to record max cache line
size
6dcdefcde413 arm64/fpsimd: Don't disable softirq when touching FPSIMD/SVE state
54b8c7cbc57c arm64/fpsimd: Introduce fpsimd_save_and_flush_cpu_state() and use
it
6fa9b41f6f15 arm64/fpsimd: Remove the prototype for sve_flush_cpu_state()
201d355c15c1 arm64/mm: Move PTE_VALID from SW defined to HW page table entry
definitions
441a62780687 arm64/hugetlb: Use macros for contiguous huge page sizes

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/h
ugetlb/hugemmap/hugemmap05.c

# /opt/ltp/testcases/bin/hugemmap05 -s -m
tst_test.c:1111: INFO: Timeout per run is 0h 05m 00s
hugemmap05.c:235: INFO: original nr_hugepages is 0
hugemmap05.c:248: INFO: original nr_overcommit_hugepages is 0
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Cannot kill test processes!
Congratulation, likely test hit a kernel bug.
Exitting uncleanly...

[ 7792.681691][ T5025] LTP: starting hugemmap05_3 (hugemmap05 -s -m)
[ 7911.149058][ T1309] INFO: task hugemmap05:51035 can't die for more than 122
seconds.
[ 7911.156833][ T1309] hugemmap05      R  running task    27648 51035      1
0x0000000d
[ 7911.164654][ T1309] Call trace:
[ 7911.167823][ T1309]  __switch_to+0x2e0/0x37c
[ 7911.172128][ T1309]  0x3e4ca
[ 7911.175033][ T1309] 
[ 7911.175033][ T1309] Showing all locks held in the system:
[ 7911.182888][ T1309] 1 lock held by khungtaskd/1309:
[ 7911.187778][ T1309]  #0: 0000000037a3e572 (rcu_read_lock){....}, at:
rcu_lock_acquire+0x8/0x38
[ 7911.196655][ T1309] 4 locks held by hugemmap05/51035:
[ 7911.201731][ T1309] 4 locks held by hugemmap05/51038:
[ 7911.206814][ T1309] 
[ 7911.209025][ T1309] =============================================
[ 7911.209025][ T1309] 
