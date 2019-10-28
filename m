Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23F1CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 10:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2F520873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 10:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbfJ1KrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 06:47:17 -0400
Received: from foss.arm.com ([217.140.110.172]:38454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbfJ1KrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:47:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C4C11F1;
        Mon, 28 Oct 2019 03:47:16 -0700 (PDT)
Received: from [10.1.194.43] (unknown [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 904C83F71E;
        Mon, 28 Oct 2019 03:47:13 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v13 12/22] mm: pagewalk: Allow walking without vma
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
        Andrew Morton <akpm@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>
References: <20191024093716.49420-13-steven.price@arm.com>
 <201910271514.G7Dilhf7%lkp@intel.com>
Message-ID: <14bd3b3c-268b-4a4f-2ee7-17ba6f10f31d@arm.com>
Date:   Mon, 28 Oct 2019 10:46:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <201910271514.G7Dilhf7%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2019 07:59, kbuild test robot wrote:
> Hi Steven,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.4-rc4 next-20191025]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Steven-Price/Generic-page-walk-and-ptdump/20191027-140322
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5a1e843c66fa6438f389045981c37e4073917641
> config: arc-defconfig (attached as .config)
> compiler: arc-elf-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=arc 

First off, these instructions don't work! make.cross attempts to
download a sparc toolchain.

However, the issue is actually quite easy to see if you look more
closely at patch 2:

> +#define pmd_leaf(x)                    (pmd_val(pmd) & _PAGE_HW_SZ)

That 'pmd' variable should really have been 'x'!

Below diff should fix this up - I'll repost with this squashed in shortly:

----8<----
diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 5ec798e50836..b4a0cf27ac1c 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -274,7 +274,7 @@ static inline void pmd_set(pmd_t *pmdp, pte_t *ptep)
 #define pmd_none(x)                    (!pmd_val(x))
 #define        pmd_bad(x)                      ((pmd_val(x) & ~PAGE_MASK))
 #define pmd_present(x)                 (pmd_val(x))
-#define pmd_leaf(x)                    (pmd_val(pmd) & _PAGE_HW_SZ)
+#define pmd_leaf(x)                    (pmd_val(x) & _PAGE_HW_SZ)
 #define pmd_clear(xp)                  do { pmd_val(*(xp)) = 0; } while (0)

 #define pte_page(pte)          pfn_to_page(pte_pfn(pte))
