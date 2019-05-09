Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810F7C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2E420645
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfEIPDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 11:03:50 -0400
Received: from foss.arm.com ([217.140.101.70]:43810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfEIPDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:03:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EEA7374;
        Thu,  9 May 2019 08:03:49 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52BDD3F6C4;
        Thu,  9 May 2019 08:03:45 -0700 (PDT)
Subject: Re: [PATCH v8 05/20] KVM: PPC: Book3S HV: Remove pmd_is_leaf()
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, kvm-ppc@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20190403141627.11664-1-steven.price@arm.com>
 <20190403141627.11664-6-steven.price@arm.com>
 <20190429020555.GB11154@blackberry>
From:   Steven Price <steven.price@arm.com>
Message-ID: <bf689c22-92ab-e0bf-65d8-9cd495d9e6e1@arm.com>
Date:   Thu, 9 May 2019 16:03:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429020555.GB11154@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2019 03:05, Paul Mackerras wrote:
> On Wed, Apr 03, 2019 at 03:16:12PM +0100, Steven Price wrote:
>> Since pmd_large() is now always available, pmd_is_leaf() is redundant.
>> Replace all uses with calls to pmd_large().
> 
> NAK.  I don't want to do this, because pmd_is_leaf() is purely about
> the guest page tables (the "partition-scoped" radix tree which
> specifies the guest physical to host physical translation), not about
> anything to do with the Linux process page tables.  The guest page
> tables have the same format as the Linux process page tables, but they
> are managed separately.

Fair enough, I'll drop this patch in the next posting.

> If it makes things clearer, I could rename it to "guest_pmd_is_leaf()"
> or something similar.

I'll leave that decision up to you - it might prevent similar confusion
in the future.

Steve
