Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9357CC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 07:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639D32082F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569655152;
	bh=7Shm2B/zlmlKL3pXHRJPueR0lZN16Qkmk5dclKLpT4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cbQYIUXG58z4M/cSXZdQ1TEV7FggfPV1FmtbOpBLHYr6esEegHOMJQZ0HvBXa2YWO
	 UDgy393D4dEVAVffT7v2k2YhIhudpvOsml882m6fE7Glw5t3Tp5VjwOx1ok+GR+Dri
	 In2lWCxE2HZkYiEe0+ULqOmnikBiO34RnR7Rnj5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfI1HTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 03:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfI1HTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 03:19:11 -0400
Received: from rapoport-lnx (unknown [87.70.86.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E3F207FA;
        Sat, 28 Sep 2019 07:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569655149;
        bh=7Shm2B/zlmlKL3pXHRJPueR0lZN16Qkmk5dclKLpT4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBejyXdzz4rgvKVIlusJOqUyYjLlcxGPKWA8NvQRYwv/a6T4RVFhDzz69bRTQQMfm
         8ML/TYEpo0GAa8y9Lc06KceJL27dvkuxdjuG+6wXArOPovYJxSwxMM6bswsAOYscC+
         ZGPaGhcE6hTHkj0IodumScF7u2RD6n5TKFBBmhlo=
Date:   Sat, 28 Sep 2019 10:19:02 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3] arm64: use generic free_initrd_mem()
Message-ID: <20190928071901.GA3510@rapoport-lnx>
References: <1569388180-28274-1-git-send-email-rppt@kernel.org>
 <76b49810-c59f-8cf1-7401-1f7262873601@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76b49810-c59f-8cf1-7401-1f7262873601@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 11:50:42AM +0530, Anshuman Khandual wrote:
> 
> On 09/25/2019 10:39 AM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > arm64 calls memblock_free() for the initrd area in its implementation of
> > free_initrd_mem(), but this call has no actual effect that late in the boot
> > process. By the time initrd is freed, all the reserved memory is managed by
> > the page allocator and the memblock.reserved is unused, so the only purpose
> > of the memblock_free() call is to keep track of initrd memory for debugging
> > and accounting.
> > 
> > Without the memblock_free() call the only difference between arm64 and the
> > generic versions of free_initrd_mem() is the memory poisoning.
> > 
> > Move memblock_free() call to the generic code, enable it there
> > for the architectures that define ARCH_KEEP_MEMBLOCK and use the generic
> > implementaion of free_initrd_mem() on arm64.
> 
> Small nit. s/implementaion/implementation.
> 
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> > 
> > v3:
> > * fix powerpc build
> > 
> > v2: 
> > * add memblock_free() to the generic free_initrd_mem()
> > * rebase on the current upstream
> > 
> > 
> >  arch/arm64/mm/init.c | 12 ------------
> >  init/initramfs.c     |  5 +++++
> >  2 files changed, 5 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 45c00a5..87a0e3b 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -580,18 +580,6 @@ void free_initmem(void)
> >  	unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begin));
> >  }
> >  
> > -#ifdef CONFIG_BLK_DEV_INITRD
> > -void __init free_initrd_mem(unsigned long start, unsigned long end)
> > -{
> > -	unsigned long aligned_start, aligned_end;
> > -
> > -	aligned_start = __virt_to_phys(start) & PAGE_MASK;
> > -	aligned_end = PAGE_ALIGN(__virt_to_phys(end));
> > -	memblock_free(aligned_start, aligned_end - aligned_start);
> > -	free_reserved_area((void *)start, (void *)end, 0, "initrd");
> > -}
> > -#endif
> > -
> >  /*
> >   * Dump out memory limit information on panic.
> >   */
> > diff --git a/init/initramfs.c b/init/initramfs.c
> > index c47dad0..3d61e13 100644
> > --- a/init/initramfs.c
> > +++ b/init/initramfs.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/utime.h>
> >  #include <linux/file.h>
> > +#include <linux/memblock.h>
> >  
> >  static ssize_t __init xwrite(int fd, const char *p, size_t count)
> >  {
> > @@ -531,6 +532,10 @@ void __weak free_initrd_mem(unsigned long start, unsigned long end)
> >  {
> >  	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
> >  			"initrd");
> > +
> > +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
> 
> Should not the addresses here be aligned first before calling memblock_free() ?
> Without alignment, it breaks present behavior on arm64 which was explicitly added
> with 13776f9d40a0 ("arm64: mm: free the initrd reserved memblock in a aligned manner").

Well, the present behaviour as of v5.3[.1] is call memblock_free() for the
unaligned initrd area. The commit 13776f9d40a0 ("arm64: mm: free the initrd
reserved memblock in a aligned manner") indeed would fix the reporting in
/sys/fs/memblock/reserved, but it won't change anything beyond that despite
its commit log implies otherwise.

> Or does initrd always gets allocated with page alignment on other architectures.

powerpc reserves aligned area and s390 does not. Other architectures do not
keep memblock  after init.

I'll re-send with the aligned addresses.


> > +	memblock_free(__pa(start), end - start);
> > +#endif
> >  }
> >  
> >  #ifdef CONFIG_KEXEC_CORE
> > 

-- 
Sincerely yours,
Mike.
