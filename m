Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA5CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1800A21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552632811;
	bh=jUZ4DVXp+LJOIFoiwPz2zLtN5iLADF0jOnj93kVZ9GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T1ox0mirPZUN9yImszzdfsInZjhdF/57JVQGvF/Dp3rGyv4YUu3dzRx+4VZK9JDQ9
	 joXZQrjOIGTR6pMok1mpzNdKXT6ZyefVaNJqqK5xVnBusp2ENOX6qlnsnewbN/REC9
	 bTnR+6Is7WUF6Hif5aYBHwPLQFEmnZUoAhRfJzQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfCOGx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:53:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:56514 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfCOGx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:53:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C834ACEC;
        Fri, 15 Mar 2019 06:53:28 +0000 (UTC)
Date:   Fri, 15 Mar 2019 07:53:27 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] elf: print userspace address with %lx
Message-ID: <20190315065327.GA15672@dhcp22.suse.cz>
References: <20190314204548.GB18143@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314204548.GB18143@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-03-19 23:45:48, Alexey Dobriyan wrote:
> Use %lx, save a cast.
> 
> "addr" is userspace address so using (and mangling) pointer was never
> necessary.

There shouldn't be any mangling AFAIU. Documentation for pointer()
says

 * - 'x' For printing the address. Equivalent to "%lx".

> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  fs/binfmt_elf.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -376,8 +376,8 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
>  		map_addr = vm_mmap(filep, addr, size, prot, type, off);
>  
>  	if ((type & MAP_FIXED_NOREPLACE) && map_addr == -EEXIST)
> -		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
> -			task_pid_nr(current), current->comm, (void *)addr);
> +		pr_info("%d (%s): Uhuuh, elf segment at %lx requested but the memory is mapped already\n",
> +			task_pid_nr(current), current->comm, addr);
>  
>  	return(map_addr);
>  }

-- 
Michal Hocko
SUSE Labs
