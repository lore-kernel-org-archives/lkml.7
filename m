Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E9FC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDD7206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfD0BQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:16:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfD0BQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:16:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D105230BC10D;
        Sat, 27 Apr 2019 01:16:27 +0000 (UTC)
Received: from x230.aquini.net (ovpn-120-14.rdu2.redhat.com [10.10.120.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1CF35E7B8;
        Sat, 27 Apr 2019 01:16:25 +0000 (UTC)
Date:   Fri, 26 Apr 2019 21:16:24 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/proc: add VmTaskSize field to /proc/$$/status
Message-ID: <20190427011623.GB10398@x230.aquini.net>
References: <1556305328-2001-1-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556305328-2001-1-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 27 Apr 2019 01:16:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 03:02:08PM -0400, Joel Savitz wrote:
> In the mainline kernel, there is no quick mechanism to get the virtual
> memory size of the current process from userspace.
> 
> Despite the current state of affairs, this information is available to the
> user through several means, one being a linear search of the entire address
> space. This is an inefficient use of cpu cycles.
> 
> A component of the libhugetlb kernel test does exactly this, and as
> systems' address spaces increase beyond 32-bits, this method becomes
> exceedingly tedious.
> 
> For example, on a ppc64le system with a 47-bit address space, the linear
> search causes the test to hang for some unknown amount of time. I
> couldn't give you an exact number because I just ran it for about 10-20
> minutes and went to go do something else, probably to get coffee or
> something, and when I came back, I just killed the test and patched it
> to use this new mechanism. I re-ran my new version of the test using a
> kernel with this patch, and of course it passed through the previously
> bottlenecking codepath nearly instantaneously.
> 
> This patched enabled me to upgrade an O(n) codepath to O(1) in an
> architecture-independent manner.
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  Documentation/filesystems/proc.txt | 2 ++
>  fs/proc/task_mmu.c                 | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> index 66cad5c86171..1c6a912e3975 100644
> --- a/Documentation/filesystems/proc.txt
> +++ b/Documentation/filesystems/proc.txt
> @@ -187,6 +187,7 @@ read the file /proc/PID/status:
>    VmLib:      1412 kB
>    VmPTE:        20 kb
>    VmSwap:        0 kB
> +  VmTaskSize:	137438953468 kB
>    HugetlbPages:          0 kB
>    CoreDumping:    0
>    THP_enabled:	  1
> @@ -263,6 +264,7 @@ Table 1-2: Contents of the status files (as of 4.19)
>   VmPTE                       size of page table entries
>   VmSwap                      amount of swap used by anonymous private data
>                               (shmem swap usage is not included)
> + VmTaskSize                  size of entire virtual address space of a process
>   HugetlbPages                size of hugetlb memory portions
>   CoreDumping                 process's memory is currently being dumped
>                               (killing the process may lead to a corrupted core)
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 95ca1fe7283c..0ddd51479f90 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -74,7 +74,10 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>  	seq_put_decimal_ull_width(m,
>  		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
>  	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
> -	seq_puts(m, " kB\n");
> +	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
> +	seq_put_decimal_ull_width(m,
> +		    " kB\nVmTaskSize:\t", TASK_SIZE >> 10, 8);
> +	seq_puts(m, " kB\n");
>  	hugetlb_report_usage(m, mm);
>  }
>  #undef SEQ_PUT_DEC
> -- 
> 2.18.1
> 
Acked-by: Rafael Aquini <aquini@redhat.com>
