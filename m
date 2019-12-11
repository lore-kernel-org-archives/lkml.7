Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1E8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6DA208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbfLKPyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:54:15 -0500
Received: from foss.arm.com ([217.140.110.172]:36624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731887AbfLKPyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:54:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2A2B31B;
        Wed, 11 Dec 2019 07:54:11 -0800 (PST)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88EAD3F52E;
        Wed, 11 Dec 2019 07:54:08 -0800 (PST)
Subject: Re: [PATCH v16 13/25] mm: pagewalk: Don't lock PTEs for
 walk_page_range_novma()
To:     kbuild test robot <lkp@intel.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, kbuild-all@lists.01.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191206135316.47703-14-steven.price@arm.com>
 <201912101842.KIXI4yCg%lkp@intel.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <e0fd5594-fb4e-9ead-e582-544f47cb1f8b@arm.com>
Date:   Wed, 11 Dec 2019 15:54:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <201912101842.KIXI4yCg%lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 11:23, kbuild test robot wrote:
> Hi Steven,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.5-rc1 next-20191209]
> [cannot apply to arm64/for-next/core tip/x86/mm]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Steven-Price/Generic-page-walk-and-ptdump/20191208-035831
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ad910e36da4ca3a1bd436989f632d062dda0c921
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-101-g82dee2e-dirty
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>>> include/linux/spinlock.h:378:9: sparse: sparse: context imbalance in 'walk_pte_range' - unexpected unlock

I believe this is a false positive (although the trace here is useless).
This patch adds a conditional lock/unlock:

pte = walk->no_vma ? pte_offset_map(pmd, addr) :
		     pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
...
if (!walk->no_vma)
	spin_unlock(ptl);
pte_unmap(pte);

I'm not sure how to match sparse happy about that. Is the only option to
have two versions of the walk_pte_range() function? One which takes the
lock and one which doesn't.

Steve

> vim +/walk_pte_range +378 include/linux/spinlock.h
> 
> c2f21ce2e31286 Thomas Gleixner 2009-12-02  375  
> 3490565b633c70 Denys Vlasenko  2015-07-13  376  static __always_inline void spin_unlock(spinlock_t *lock)
> c2f21ce2e31286 Thomas Gleixner 2009-12-02  377  {
> c2f21ce2e31286 Thomas Gleixner 2009-12-02 @378  	raw_spin_unlock(&lock->rlock);
> c2f21ce2e31286 Thomas Gleixner 2009-12-02  379  }
> c2f21ce2e31286 Thomas Gleixner 2009-12-02  380  
> 
> :::::: The code at line 378 was first introduced by commit
> :::::: c2f21ce2e31286a0a32f8da0a7856e9ca1122ef3 locking: Implement new raw_spinlock
> 
> :::::: TO: Thomas Gleixner <tglx@linutronix.de>
> :::::: CC: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

