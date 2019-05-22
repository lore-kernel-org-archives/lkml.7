Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCE1C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E830F2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfEVDLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 23:11:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13641 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbfEVDLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 23:11:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50E4333025F;
        Wed, 22 May 2019 03:11:41 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B5311001DED;
        Wed, 22 May 2019 03:11:36 +0000 (UTC)
Date:   Wed, 22 May 2019 11:11:33 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        bp@alien8.de, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org
Subject: Re: [PATCH v4 3/3] x86/kdump/64: Change the upper limit of
 crashkernel reservation
Message-ID: <20190522031133.GA31269@dhcp-128-65.nay.redhat.com>
References: <20190509013644.1246-1-bhe@redhat.com>
 <20190509013644.1246-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509013644.1246-4-bhe@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 22 May 2019 03:11:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

A few nitpicks, otherwise
Acked-by: Dave Young <dyoung@redhat.com>

On 05/09/19 at 09:36am, Baoquan He wrote:
> Restrict kdump to only reserve crashkernel below 64TB.
> 
> The reaons is that the kdump may jump from 5-level to 4-level, and if
> the kdump kernel is put above 64TB, then the jumping will fail. While the
> 1st kernel reserves crashkernel region during bootup, we don't know yet
> which kind of kernel will be loaded after system bootup, 5-level kernel
> or 5-level kernel.

5-level kernel or 4-level kernel ?
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/setup.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 905dae880563..efb0934a46f6 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -452,15 +452,26 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>  #define CRASH_ALIGN		SZ_16M
>  
>  /*
> - * Keep the crash kernel below this limit.  On 32 bits earlier kernels
> - * would limit the kernel to the low 512 MiB due to mapping restrictions.
> + * Keep the crash kernel below this limit.
> + *
> + * On 32 bits earlier kernels would limit the kernel to the low
> + * 512 MiB due to mapping restrictions.
> + *
> + * On 64bit, old kexec-tools need to be under 896MiB. The later
> + * supports to put kernel above 4G, up to system RAM top. Here

Above two lines are not reflected in code because we have removed
the 896M limitation, it would be better to drop the two lines to
avoid confusion. 

> + * kdump kernel need be restricted to be under 64TB, which is
> + * the upper limit of system RAM in 4-level paing mode. Since
> + * the kdump jumping could be from 5-level to 4-level, the jumping
> + * will fail if kernel is put above 64TB, and there's no way to
> + * detect the paging mode of the kernel which will be loaded for
> + * dumping during the 1st kernel bootup.
>   */
>  #ifdef CONFIG_X86_32
>  # define CRASH_ADDR_LOW_MAX	SZ_512M
>  # define CRASH_ADDR_HIGH_MAX	SZ_512M
>  #else
>  # define CRASH_ADDR_LOW_MAX	SZ_4G
> -# define CRASH_ADDR_HIGH_MAX	MAXMEM
> +# define CRASH_ADDR_HIGH_MAX	(64UL << 40)

Maybe add a new macro in sizes.h like SZ_64T

>  #endif
>  
>  static int __init reserve_crashkernel_low(void)
> -- 
> 2.17.2
> 

Thanks
Dave
