Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C94AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAF120811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfCZQhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:37:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40408 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbfCZQhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:37:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8451D1596;
        Tue, 26 Mar 2019 09:37:03 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F6A23F614;
        Tue, 26 Mar 2019 09:37:01 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to
 vmcoreinfo
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Steve Capper <Steve.Capper@arm.com>
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
 <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
Date:   Tue, 26 Mar 2019 16:36:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 20/03/2019 05:09, Bhupesh Sharma wrote:
> With ARMv8.2-LVA architecture extension availability, arm64 hardware
> which supports this extension can support a virtual address-space upto
> 52-bits.
> 
> Since at the moment we enable the support of this extension in kernel
> via CONFIG flags, e.g.
>  - User-space 52-bit LVA via CONFIG_ARM64_USER_VA_BITS_52
> 
> so, there is no clear mechanism in the user-space right now to
> determine these CONFIG flag values and hence determine the maximum
> virtual address space supported by the underlying kernel.
> 
> User-space tools like 'makedumpfile' therefore are broken currently
> as they have no proper method to calculate the 'PTRS_PER_PGD' value
> which is required to perform a page table walk to determine the
> physical address of a corresponding virtual address found in
> kcore/vmcoreinfo.
> 
> If one appends 'PTRS_PER_PGD' number to vmcoreinfo for arm64,
> it can be used in user-space to determine the maximum virtual address
> supported by underlying kernel.

I don't think this really solves the problem, it feels fragile.

I can see how vmcoreinfo tells you VA_BITS==48, PAGE_SIZE==64K and PTRS_PER_PGD=1024.
You can use this to work out that the top level page table size isn't consistent with a
48bit VA, so 52bit VA must be in use...

But wasn't your problem walking the kernel page tables? In particular the offset that we
apply because the tables were based on a 48bit VA shifted up in swapper_pg_dir.

Where does the TTBR1_EL1 offset come from with this property? I assume makedumpfile
hard-codes it when it sees 52bit is in use ... somewhere.
We haven't solved the problem!

Today __cpu_setup() sets T0SZ and T1SZ differently for 52bit VA, but in the future it
could set them the same, or different the other-way-round.

Will makedumpfile using this value keep working once T1SZ is 52bit VA too? In this case
there would be no ttbr offset.

If you need another vmcoreinfo flag once that happens, we've done something wrong here.

(Not to mention what happens if the TTBR1_EL1 uses 52bit va, but TTBR0_EL1 doesn't)


> Suggested-by: Steve Capper <Steve.Capper@arm.com>

(CC: +Steve)


Thanks,

James
