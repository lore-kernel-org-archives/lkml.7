Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E3EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61EC21900
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552724903;
	bh=VDWxQAU21tdGUPGDnr9/WzeSjqR/YLwmMfKUvAPctVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tHqvHIqI9YQhSbdEzybJtpuTbXuJ3fm2txP7D+w0toGblVssMZzy8LIECywYx+p++
	 uzhvCSpMotC8LWTpglvL168SQfos+/z6S7eh4dDkTkBPOYq6D6wkNt2hbKpm4rW1Av
	 6Uizofa6/+Dqml9Ys1vfxWiU1DRXwi/yvYH3YjKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCPI2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:28:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:34352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726004AbfCPI2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:28:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FEF1AD76;
        Sat, 16 Mar 2019 08:28:21 +0000 (UTC)
Date:   Sat, 16 Mar 2019 09:28:20 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] elf: print userspace address with %lx
Message-ID: <20190316082820.GG15672@dhcp22.suse.cz>
References: <20190314204548.GB18143@avx2>
 <20190315065327.GA15672@dhcp22.suse.cz>
 <20190315160656.GB2135@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315160656.GB2135@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-03-19 19:06:56, Alexey Dobriyan wrote:
> On Fri, Mar 15, 2019 at 07:53:27AM +0100, Michal Hocko wrote:
> > On Thu 14-03-19 23:45:48, Alexey Dobriyan wrote:
> > > Use %lx, save a cast.
> > > 
> > > "addr" is userspace address so using (and mangling) pointer was never
> > > necessary.
> > 
> > There shouldn't be any mangling AFAIU. Documentation for pointer()
> > says
> > 
> >  * - 'x' For printing the address. Equivalent to "%lx".
> 
> The implication of using %p/%px is that the address is kernel pointer
> which should or should not be mangled.

And px is not mangled AFAICS.

> But "map_addr" is not a kernel pointer.

Which should be irrelevant. It is a pointer and my understanding is that
%p$FOO should be used preferably for any pointers.

> And it saves a cast.

Is this really such an improvement? Why?

> > > --- a/fs/binfmt_elf.c
> > > +++ b/fs/binfmt_elf.c
> > > @@ -376,8 +376,8 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
> > >  		map_addr = vm_mmap(filep, addr, size, prot, type, off);
> > >  
> > >  	if ((type & MAP_FIXED_NOREPLACE) && map_addr == -EEXIST)
> > > -		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
> > > -			task_pid_nr(current), current->comm, (void *)addr);
> > > +		pr_info("%d (%s): Uhuuh, elf segment at %lx requested but the memory is mapped already\n",
> > > +			task_pid_nr(current), current->comm, addr);

-- 
Michal Hocko
SUSE Labs
