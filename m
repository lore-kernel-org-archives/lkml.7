Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24CDC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0CF21783
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfI0FP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 01:15:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfI0FP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 01:15:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D9CF300894D;
        Fri, 27 Sep 2019 05:15:28 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF89C60C44;
        Fri, 27 Sep 2019 05:15:22 +0000 (UTC)
Date:   Fri, 27 Sep 2019 13:15:18 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, bhe@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] x86/kdump: Fix 'kmem -s' reported an invalid freepointer
 when SME was active
Message-ID: <20190927051518.GA13023@dhcp-128-65.nay.redhat.com>
References: <20190920035326.27212-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920035326.27212-1-lijiang@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 27 Sep 2019 05:15:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lianbo,

For kexec/kdump patches, please remember to cc kexec list next time.
Also it is definitely kdump specific issue, I added Vivek and Eric in
cc. 

On 09/20/19 at 11:53am, Lianbo Jiang wrote:
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204793
> 
> Kdump kernel will reuse the first 640k region because of some reasons,
> for example: the trampline and conventional PC system BIOS region may
> require to allocate memory in this area. Obviously, kdump kernel will
> also overwrite the first 640k region, therefore, kernel has to copy
> the contents of the first 640k area to a backup area, which is done in
> purgatory(), because vmcore may need the old memory. When vmcore is
> dumped, kdump kernel will read the old memory from the backup area of
> the first 640k area.
> 
> Basically, the main reason should be clear, kernel does not correctly
> handle the first 640k region when SME is active, which causes that
> kernel does not properly copy these old memory to the backup area in
> purgatory(). Therefore, kdump kernel reads out the incorrect contents
> from the backup area when dumping vmcore. Finally, the phenomenon is
> as follow:
> 
> [root linux]$ crash vmlinux /var/crash/127.0.0.1-2019-09-19-08\:31\:27/vmcore
> WARNING: kernel relocated [240MB]: patching 97110 gdb minimal_symbol values
> 
>       KERNEL: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmlinux
>     DUMPFILE: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmcore  [PARTIAL DUMP]
>         CPUS: 128
>         DATE: Thu Sep 19 08:31:18 2019
>       UPTIME: 00:01:21
> LOAD AVERAGE: 0.16, 0.07, 0.02
>        TASKS: 1343
>     NODENAME: amd-ethanol
>      RELEASE: 5.3.0-rc7+
>      VERSION: #4 SMP Thu Sep 19 08:14:00 EDT 2019
>      MACHINE: x86_64  (2195 Mhz)
>       MEMORY: 127.9 GB
>        PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>          PID: 9789
>      COMMAND: "bash"
>         TASK: "ffff89711894ae80  [THREAD_INFO: ffff89711894ae80]"
>          CPU: 83
>        STATE: TASK_RUNNING (PANIC)
> 
> crash> kmem -s|grep -i invalid
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> crash>
> 
> In order to avoid such problem, lets occupy the first 640k region when
> SME is active, which will ensure that the allocated memory does not fall
> into the first 640k area. So, no need to worry about whether kernel can
> correctly copy the contents of the first 640K area to a backup region in
> purgatory().

The log is too simple,  I know you did some other tries to fix this, but
the patch log does not show why you can not correctly copy the 640k in
current kdump code, in purgatory here.

Also this patch seems works in your test, but still to see if other
people can comment and see if it is safe or not, if any other risks
other than waste the small chunk of memory.  If it is safe then kdump
can just drop the backup logic and use this in common code instead of
only do it for SME.

> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/setup.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 77ea96b794bd..5bfb2c83bb6c 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1148,6 +1148,9 @@ void __init setup_arch(char **cmdline_p)
>  
>  	reserve_real_mode();
>  
> +	if (sme_active())
> +		memblock_reserve(0, 640*1024);
> +
>  	trim_platform_memory_ranges();
>  	trim_low_memory_range();
>  
> -- 
> 2.17.1
> 

Thanks
Dave
