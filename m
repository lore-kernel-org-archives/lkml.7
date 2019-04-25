Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE523C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D752D206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfDYVAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:00:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfDYVAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:00:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27895307D85A;
        Thu, 25 Apr 2019 21:00:48 +0000 (UTC)
Received: from x230.aquini.net (ovpn-126-47.rdu2.redhat.com [10.10.126.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10A1F171C5;
        Thu, 25 Apr 2019 21:00:44 +0000 (UTC)
Date:   Thu, 25 Apr 2019 17:00:43 -0400
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
Subject: Re: [PATCH] fs/proc: add VmTaskSize field to /proc/$$/status
Message-ID: <20190425210043.GB4546@x230.aquini.net>
References: <1556225867-458-1-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556225867-458-1-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 25 Apr 2019 21:00:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 04:57:47PM -0400, Joel Savitz wrote:
> Currently, there is no fast mechanism to get the virtual memory size of
> the current process from userspace. This information is available to the
> user through several means, one being a linear search of the entire address
> space. This is the method used by a component of the libhugetlb kernel
> test, and using the mechanism proposed in this patch, the time complexity
> of that test would be upgraded to constant time from linear time. This is
> especially relevant on 64-bit architechtures where a linear search of
> the address space could take an absurd amount of time. Using this
> mechanism, the modification to the test component would be portable
> across all architechtures.
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  fs/proc/task_mmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 92a91e7816d8..f64b9a949624 100644
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
