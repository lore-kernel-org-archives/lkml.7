Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415DFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B6220652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfDRVra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:47:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfDRVr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:47:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 051B03082B44;
        Thu, 18 Apr 2019 21:47:28 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20A455D70A;
        Thu, 18 Apr 2019 21:47:23 +0000 (UTC)
Date:   Thu, 18 Apr 2019 17:47:21 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v12 01/31] mm: introduce CONFIG_SPECULATIVE_PAGE_FAULT
Message-ID: <20190418214721.GA11645@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-2-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-2-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 18 Apr 2019 21:47:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:44:52PM +0200, Laurent Dufour wrote:
> This configuration variable will be used to build the code needed to
> handle speculative page fault.
> 
> By default it is turned off, and activated depending on architecture
> support, ARCH_HAS_PTE_SPECIAL, SMP and MMU.
> 
> The architecture support is needed since the speculative page fault handler
> is called from the architecture's page faulting code, and some code has to
> be added there to handle the speculative handler.
> 
> The dependency on ARCH_HAS_PTE_SPECIAL is required because vm_normal_page()
> does processing that is not compatible with the speculative handling in the
> case ARCH_HAS_PTE_SPECIAL is not set.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

Small question below

> ---
>  mm/Kconfig | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0eada3f818fa..ff278ac9978a 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -761,4 +761,26 @@ config GUP_BENCHMARK
>  config ARCH_HAS_PTE_SPECIAL
>  	bool
>  
> +config ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
> +       def_bool n
> +
> +config SPECULATIVE_PAGE_FAULT
> +	bool "Speculative page faults"
> +	default y
> +	depends on ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
> +	depends on ARCH_HAS_PTE_SPECIAL && MMU && SMP
> +	help
> +	  Try to handle user space page faults without holding the mmap_sem.
> +
> +	  This should allow better concurrency for massively threaded processes

Is there any case where it does not provide better concurrency ? The
should make me wonder :)

> +	  since the page fault handler will not wait for other thread's memory
> +	  layout change to be done, assuming that this change is done in
> +	  another part of the process's memory space. This type of page fault
> +	  is named speculative page fault.
> +
> +	  If the speculative page fault fails because a concurrent modification
> +	  is detected or because underlying PMD or PTE tables are not yet
> +	  allocated, the speculative page fault fails and a classic page fault
> +	  is then tried.
> +
>  endmenu
> -- 
> 2.21.0
> 
