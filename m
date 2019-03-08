Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435B8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1329120811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfCHKut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:50:49 -0500
Received: from foss.arm.com ([217.140.101.70]:56566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfCHKus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:50:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3132A78;
        Fri,  8 Mar 2019 02:50:47 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB00E3F706;
        Fri,  8 Mar 2019 02:50:43 -0800 (PST)
Subject: Re: [PATCH v4 04/19] powerpc: mm: Add p?d_large() definitions
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
        Paul Mackerras <paulus@samba.org>,
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
        linuxppc-dev@lists.ozlabs.org
References: <20190306155031.4291-1-steven.price@arm.com>
 <20190306155031.4291-5-steven.price@arm.com>
 <20190308083744.GA6592@rapoport-lnx>
From:   Steven Price <steven.price@arm.com>
Message-ID: <a2103947-4551-6f6d-4082-0dca4efd1d06@arm.com>
Date:   Fri, 8 Mar 2019 10:50:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308083744.GA6592@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2019 08:37, Mike Rapoport wrote:
> On Wed, Mar 06, 2019 at 03:50:16PM +0000, Steven Price wrote:
>> walk_page_range() is going to be allowed to walk page tables other than
>> those of user space. For this it needs to know when it has reached a
>> 'leaf' entry in the page tables. This information is provided by the
>> p?d_large() functions/macros.
>>
>> For powerpc pmd_large() was already implemented, so hoist it out of the
>> CONFIG_TRANSPARENT_HUGEPAGE condition and implement the other levels.
>>
>> Also since we now have a pmd_large always implemented we can drop the
>> pmd_is_leaf() function.
>>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Paul Mackerras <paulus@samba.org>
>> CC: Michael Ellerman <mpe@ellerman.id.au>
>> CC: linuxppc-dev@lists.ozlabs.org
>> CC: kvm-ppc@vger.kernel.org
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/pgtable.h | 30 ++++++++++++++------
> 
> There is one more definition of pmd_large() in
> arch/powerpc/include/asm/pgtable.h

True. That is a #define so will work correctly (it will override the
generic version). Since it is only a dummy definition (always returns 0)
it could be removed, but that would need to be in a separate patch after
the asm-generic versions have been added to avoid breaking bisection.

Steve
