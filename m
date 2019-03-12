Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC60AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFB7206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfCLUFH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:05:07 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:47359 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfCLUFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:05:06 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2019 16:05:05 EDT
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2CJpSbo027851
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Mar 2019 04:51:28 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2CJpSeK016858;
        Wed, 13 Mar 2019 04:51:28 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2CJpSQX006898;
        Wed, 13 Mar 2019 04:51:28 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.136] [10.38.151.136]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-3278575; Wed, 13 Mar 2019 04:47:38 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC08GP.gisp.nec.co.jp ([10.38.151.136]) with mapi id 14.03.0319.002; Wed,
 13 Mar 2019 04:47:38 +0900
From:   Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Boris Petkov" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Dave Anderson" <anderson@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: RE: [PATCH v2 2/2] crash_core, vmcoreinfo: Append
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Thread-Topic: [PATCH v2 2/2] crash_core, vmcoreinfo: Append
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Thread-Index: AQHU1yi7KXHpUX+rcU2iQwrK9lGXaKYIEatw
Date:   Tue, 12 Mar 2019 19:47:37 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03569E6D@BPXM09GP.gisp.nec.co.jp>
References: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
 <1552212242-9479-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1552212242-9479-3-git-send-email-bhsharma@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.134.92]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

-----Original Message-----
> Right now user-space tools like 'makedumpfile' and 'crash' need to rely
> on a best-guess method of determining value of 'MAX_PHYSMEM_BITS'
> supported by underlying kernel.
> 
> This value is used in user-space code to calculate the bit-space
> required to store a section for SPARESMEM (similar to the existing
> calculation method used in the kernel implementation):
> 
>   #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
> 
> Now, regressions have been reported in user-space utilities
> like 'makedumpfile' and 'crash' on arm64, with the recently added
> kernel support for 52-bit physical address space, as there is
> no clear method of determining this value in user-space
> (other than reading kernel CONFIG flags).
> 
> As per suggestion from makedumpfile maintainer (Kazu), it makes more
> sense to append 'MAX_PHYSMEM_BITS' to vmcoreinfo in the core code itself
> rather than in arch-specific code, so that the user-space code for other
> archs can also benefit from this addition to the vmcoreinfo and use it
> as a standard way of determining 'SECTIONS_SHIFT' value in user-land.
> 
> A reference 'makedumpfile' implementation which reads the
> 'MAX_PHYSMEM_BITS' value from vmcoreinfo in a arch-independent fashion
> is available here:
> 
> [0]. https://github.com/bhupesh-sharma/makedumpfile/blob/remove-max-phys-mem-bit-v1/arch/ppc64.c#L471
> 
> Cc: Boris Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
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
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  kernel/crash_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 093c9f917ed0..44b90368e183 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -467,6 +467,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  #define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
>  	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
>  #endif
> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);

Some architectures define MAX_PHYSMEM_BITS only with CONFIG_SPARSEMEM,
so we need to move this to the #ifdef section that exports some
mem_section things.

Thanks!
Kazu

> 
>  	arch_crash_save_vmcoreinfo();
>  	update_vmcoreinfo_note();
> --
> 2.7.4
> 


