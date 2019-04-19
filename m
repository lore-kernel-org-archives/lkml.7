Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F22C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C91217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555704511;
	bh=C+p1NL8mFdhSCUqYHh0ol748ybYOAWTd11xT8WF9pRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Dt/4PyZVfhLgb/XVNLjg9iRaxHR2dy92JLjwg9sQ9YCOewC/9sW6mTZGT5EBXPoTx
	 hwskOqdSMlfO+XuHCsNCsiv5EwnOswYDfpX/b79WGggPCWpbE1rSmAUI33HWsYlU3y
	 QqPXC4zs8U9YFcPyNUvfGCcybibno6EVVinfZDR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfDSUIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:08:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfDSUI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:08:29 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A0A0F27C6;
        Fri, 19 Apr 2019 20:08:28 +0000 (UTC)
Date:   Fri, 19 Apr 2019 13:08:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] elf: init pt_regs pointer later
Message-Id: <20190419130826.849441bb8f526c9defcb1c0f@linux-foundation.org>
In-Reply-To: <20190419200343.GA19788@avx2>
References: <20190419200343.GA19788@avx2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 23:03:43 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Get "current_pt_regs" pointer right before usage.
> 
> Space savings on x86_64:
> 
> 	add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-180 (-180)
> 	Function                           old     new   delta
> 	load_elf_binary                   5806    5626    -180 !!!

-256 bytes with my setup.

> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -704,12 +704,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	unsigned long start_code, end_code, start_data, end_data;
>  	unsigned long reloc_func_desc __maybe_unused = 0;
>  	int executable_stack = EXSTACK_DEFAULT;
> -	struct pt_regs *regs = current_pt_regs();
>  	struct {
>  		struct elfhdr elf_ex;
>  		struct elfhdr interp_elf_ex;
>  	} *loc;
>  	struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
> +	struct pt_regs *regs;
>  
>  	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
>  	if (!loc) {
> @@ -1159,6 +1159,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  				MAP_FIXED | MAP_PRIVATE, 0);
>  	}
>  
> +	regs = current_pt_regs();
>  #ifdef ELF_PLAT_INIT
>  	/*
>  	 * The ABI may specify that certain registers be set up in special

Why the heck does this make such a difference?
