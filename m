Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27711C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25DC2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554242669;
	bh=4PInamFNxl62bNmmGfz4cuypjGy82gHuDchempTYZXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=P6x18fFvpkFLAPGslGSHT/aZ57tauuOFFYpfvZy10AGSxG4LmtdHmgKwoTdWNtV2X
	 wo+6BngZxK0Ga1U9A4G7lniquCMljmA7LR3wKdBadqUC2731Vj745pRCwfCFIyaGgA
	 9ljuag0B163YBaopcPmteKaPZCYf2Y4+2ewZmoN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDBWE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 18:04:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfDBWE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 18:04:27 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB8B0C84;
        Tue,  2 Apr 2019 22:04:25 +0000 (UTC)
Date:   Tue, 2 Apr 2019 15:04:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Lameter <cl@linux.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Moritz Fischer <mdf@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-Id: <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
In-Reply-To: <20190402204158.27582-2-daniel.m.jordan@oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
        <20190402204158.27582-2-daniel.m.jordan@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Apr 2019 16:41:53 -0400 Daniel Jordan <daniel.m.jordan@oracle.com> wrote:

> Taking and dropping mmap_sem to modify a single counter, locked_vm, is
> overkill when the counter could be synchronized separately.
> 
> Make mmap_sem a little less coarse by changing locked_vm to an atomic,
> the 64-bit variety to avoid issues with overflow on 32-bit systems.
> 
> ...
>
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -59,32 +59,34 @@ static unsigned long kvmppc_stt_pages(unsigned long tce_pages)
>  static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
>  {
>  	long ret = 0;
> +	s64 locked_vm;
>  
>  	if (!current || !current->mm)
>  		return ret; /* process exited */
>  
>  	down_write(&current->mm->mmap_sem);
>  
> +	locked_vm = atomic64_read(&current->mm->locked_vm);
>  	if (inc) {
>  		unsigned long locked, lock_limit;
>  
> -		locked = current->mm->locked_vm + stt_pages;
> +		locked = locked_vm + stt_pages;
>  		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
>  			ret = -ENOMEM;
>  		else
> -			current->mm->locked_vm += stt_pages;
> +			atomic64_add(stt_pages, &current->mm->locked_vm);
>  	} else {
> -		if (WARN_ON_ONCE(stt_pages > current->mm->locked_vm))
> -			stt_pages = current->mm->locked_vm;
> +		if (WARN_ON_ONCE(stt_pages > locked_vm))
> +			stt_pages = locked_vm;
>  
> -		current->mm->locked_vm -= stt_pages;
> +		atomic64_sub(stt_pages, &current->mm->locked_vm);
>  	}

With the current code, current->mm->locked_vm cannot go negative. 
After the patch, it can go negative.  If someone else decreased
current->mm->locked_vm between this function's atomic64_read() and
atomic64_sub().

I guess this is a can't-happen in this case because the racing code
which performed the modification would have taken it negative anyway.

But this all makes me rather queazy.


Also, we didn't remove any down_write(mmap_sem)s from core code so I'm
thinking that the benefit of removing a few mmap_sem-takings from a few
obscure drivers (sorry ;)) is pretty small.


Also, the argument for switching 32-bit arches to a 64-bit counter was
suspiciously vague.  What overflow issues?  Or are we just being lazy?

