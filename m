Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F2C73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA80720651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfGJHAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:00:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfGJHAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:00:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D9FC30832E9;
        Wed, 10 Jul 2019 07:00:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C014092D43;
        Wed, 10 Jul 2019 07:00:00 +0000 (UTC)
Date:   Wed, 10 Jul 2019 14:59:53 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [v2 0/5] arm64: allow to reserve memory for normal kexec kernel
Message-ID: <20190710065953.GA4744@localhost.localdomain>
References: <20190709182014.16052-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709182014.16052-1-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 10 Jul 2019 07:00:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/19 at 02:20pm, Pavel Tatashin wrote:
> Changelog
> v1 - v2
> 	- No changes to patches, addressed suggestion from James Morse
> 	  to add "arm64" tag to cover letter.
> 	- Improved cover letter information based on discussion.
> 
> Currently, it is only allowed to reserve memory for crash kernel, because
> it is a requirement in order to be able to boot into crash kernel without
> touching memory of crashed kernel is to have memory reserved.
> 
> The second benefit for having memory reserved for kexec kernel is
> that it does not require a relocation after segments are loaded into
> memory.
> 
> If kexec functionality is used for a fast system update, with a minimal
> downtime, the relocation of kernel + initramfs might take a significant
> portion of reboot.
> 
> In fact, on the machine that we are using, that has ARM64 processor
> it takes 0.35s to relocate during kexec, thus taking 52% of kernel reboot
> time:
> 
> kernel shutdown	0.03s
> relocation	0.35s
> kernel startup	0.29s
> 
> Image: 13M and initramfs is 24M. If initramfs increases, the relocation
> time increases proportionally.
> 
> While, it is possible to add 'kexeckernel=' parameters support to other
> architectures by modifying reserve_crashkernel(), in this series this is
> done for arm64 only.
> 
> The reason it is so slow on arm64 to relocate kernel is because the code
> that does relocation does this with MMU disabled, and thus D-Cache and
> I-Cache must also be disabled.
> 
> Alternative solution is more complicated: Setup a temporary page table
> for relocation_routine and also for code from cpu_soft_restart. Perform
> relocation with MMU enabled, do cpu_soft_restart where MMU and caching
> are disabled, jump to purgatory. A similar approach was suggested for
> purgatory and was rejected due to making purgatory too complicated.

The crashkernel reservation for kdump is a must, there are already a lot
of different problems need to consider, for example the low and high
memory issues, and a lot of other things.  I'm not convinced to enable
this for kexec reboot.

This really looks to workaround the arm64 issue and move the
complication to kernel.

> On, the other hand hibernate does something similar already, but there
> MMU never needs to be disabled, and also by the time machine_kexec()
> is called, allocator is not available, as we can't fail to do reboot,
> so page table must be pre-allocated during kernel load time.
> 
> Note: the above time is relocation time only. Purgatory usually also
> computes checksum, but that is skipped, because --no-check is used when
> kernel image is loaded via kexec.
> 
> Pavel Tatashin (5):
>   kexec: quiet down kexec reboot
>   kexec: add resource for normal kexec region
>   kexec: export common crashkernel/kexeckernel parser
>   kexec: use reserved memory for normal kexec reboot
>   arm64, kexec: reserve kexeckernel region
> 
>  .../admin-guide/kernel-parameters.txt         |  7 ++
>  arch/arm64/kernel/setup.c                     |  5 ++
>  arch/arm64/mm/init.c                          | 83 ++++++++++++-------
>  include/linux/crash_core.h                    |  6 ++
>  include/linux/ioport.h                        |  1 +
>  include/linux/kexec.h                         |  6 +-
>  kernel/crash_core.c                           | 27 +++---
>  kernel/kexec_core.c                           | 50 +++++++----
>  8 files changed, 127 insertions(+), 58 deletions(-)
> 
> -- 
> 2.22.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave
