Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7E4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5846A217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbfDRL20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:28:26 -0400
Received: from foss.arm.com ([217.140.101.70]:59892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388535AbfDRL20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:28:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7550480D;
        Thu, 18 Apr 2019 04:28:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 772D63F59C;
        Thu, 18 Apr 2019 04:28:23 -0700 (PDT)
Date:   Thu, 18 Apr 2019 12:28:18 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Boyang Zhou <zhouby_cn@126.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, haozhu@nudt.edu.cn,
        linux@dominikbrodowski.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: Re: [PATCH] The patch solves =?utf-8?Q?the?=
 =?utf-8?Q?_type_error__of_the_parameter_=E2=80=9Coff?= =?utf-8?B?4oCd?= in
 syscall mmap on the ARM64 platform.
Message-ID: <20190418112818.GA31923@lakrids.cambridge.arm.com>
References: <1555504525-17962-1-git-send-email-zhouby_cn@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1555504525-17962-1-git-send-email-zhouby_cn@126.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-arch and relevant folk]

On Wed, Apr 17, 2019 at 08:35:25PM +0800, Boyang Zhou wrote:
> The error information is that “offset value too large for defined data type”.
> Reason:
> On the X86 platform, the data type of “off" is unsigned long; but on the ARM64 platform, the data type is defined as off_t, and off_t is by type long instead of unsigned long.
> When the off right shifts in the function “sys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT)"on ARM64, high address of off is filled with sign bit 1instead of 0.
> In our case, we mmap GPU doorbell on both platform. On the x86 platform, the value of off is f009c00000000000, after shift the value becomes f009c00000000; while on the ARM64, the value of off changes from ed35c00000000000 to fffed35c00000000. This value is treated as unsigned long in later functions. So it is too big for off and the error happened.
> We have tested the patchs in Huawei ARM64 server with a couples of AMD GPUs.

It looks like the generic mmap uses unsigned long, as do sparc and x86.

However, arm64, microblase, powerpc and riscv all use off_t.

Should those all be using unsigned long? If so, that seems like it
should be a treewide cleanup.

Similar applies to pgoff for mmap2.

Thanks,
Mark.

> 
> Signed-off-by: Boyang Zhou <zhouby_cn@126.com>
> ---
>  arch/arm64/kernel/sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
> index b44065f..6f91e81 100644
> --- a/arch/arm64/kernel/sys.c
> +++ b/arch/arm64/kernel/sys.c
> @@ -31,7 +31,7 @@
>  
>  SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
>  		unsigned long, prot, unsigned long, flags,
> -		unsigned long, fd, off_t, off)
> +		unsigned long, fd, unsigned long, off)
>  {
>  	if (offset_in_page(off) != 0)
>  		return -EINVAL;
> -- 
> 2.7.4
> 
