Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8E5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577C1206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfCKJGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfCKJGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:06:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4CD2308A953;
        Mon, 11 Mar 2019 09:06:10 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-113.pek2.redhat.com [10.72.12.113])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F21E95DD8D;
        Mon, 11 Mar 2019 09:05:56 +0000 (UTC)
Date:   Mon, 11 Mar 2019 17:05:53 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com,
        Dave Anderson <anderson@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 0/2] Append new variables to vmcoreinfo (PTRS_PER_PGD
 for arm64 and MAX_PHYSMEM_BITS for all archs)
Message-ID: <20190311090553.GA12130@dhcp-128-65.nay.redhat.com>
References: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 11 Mar 2019 09:06:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,
On 03/10/19 at 03:34pm, Bhupesh Sharma wrote:
> Changes since v1:
> ----------------
> - v1 was sent out as a single patch which can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2019-February/022411.html
> 
> - v2 breaks the single patch into two independent patches:
>   [PATCH 1/2] appends 'PTRS_PER_PGD' to vmcoreinfo for arm64 arch, whereas
>   [PATCH 2/2] appends 'MAX_PHYSMEM_BITS' to vmcoreinfo in core kernel code (all archs)
> 
> This patchset primarily fixes the regression reported in user-space
> utilities like 'makedumpfile' and 'crash-utility' on arm64 architecture
> with the availability of 52-bit address space feature in underlying
> kernel. These regressions have been reported both on CPUs which don't
> support ARMv8.2 extensions (i.e. LVA, LPA) and are running newer kernels
> and also on prototype platforms (like ARMv8 FVP simulator model) which
> support ARMv8.2 extensions and are running newer kernels.
> 
> The reason for these regressions is that right now user-space tools
> have no direct access to these values (since these are not exported
> from the kernel) and hence need to rely on a best-guess method of
> determining value of 'PTRS_PER_PGD' and 'MAX_PHYSMEM_BITS' supported
> by underlying kernel.
> 
> Exporting these values via vmcoreinfo will help user-land in such cases.
> In addition, as per suggestion from makedumpfile maintainer (Kazu)
> during v1 review, it makes more sense to append 'MAX_PHYSMEM_BITS' to
> vmcoreinfo in the core code itself rather than in arm64 arch-specific
> code, so that the user-space code for other archs can also benefit from
> this addition to the vmcoreinfo and use it as a standard way of
> determining 'SECTIONS_SHIFT' value in user-land.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Boris Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> 
> Bhupesh Sharma (2):
>   arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to vmcoreinfo
>   crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
> 
>  arch/arm64/kernel/crash_core.c | 1 +
>  kernel/crash_core.c            | 1 +
>  2 files changed, 2 insertions(+)
> 

Lianbo's document patch has been merged, would you mind to add vmcoreinfo doc
patch as well in your series?

Thanks
Dave
