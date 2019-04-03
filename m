Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E37C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F14B206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfDCPtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:49:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43510 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfDCPtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:49:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFD1380D;
        Wed,  3 Apr 2019 08:49:10 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1BC33F68F;
        Wed,  3 Apr 2019 08:49:04 -0700 (PDT)
Date:   Wed, 3 Apr 2019 16:49:02 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
Message-ID: <20190403154902.GB16866@fuggles.cambridge.arm.com>
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
 <87tvff24a1.fsf@concordia.ellerman.id.au>
 <20190403111134.GA7159@fuggles.cambridge.arm.com>
 <9d673dfd-0051-3676-653e-6376430d73dd@kernel.dk>
 <20190403151932.GA16866@fuggles.cambridge.arm.com>
 <032faa2f-6317-75b6-8514-076ef1a244e8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032faa2f-6317-75b6-8514-076ef1a244e8@kernel.dk>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 09:39:52AM -0600, Jens Axboe wrote:
> On 4/3/19 9:19 AM, Will Deacon wrote:
> > On Wed, Apr 03, 2019 at 07:49:26AM -0600, Jens Axboe wrote:
> >> On 4/3/19 5:11 AM, Will Deacon wrote:
> >>> will@autoplooker:~/liburing/test$ ./io_uring_register 
> >>> RELIMIT_MEMLOCK: 67108864 (67108864)
> >>> [   35.477875] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
> >>> [   35.478969] Mem abort info:
> >>> [   35.479296]   ESR = 0x96000004
> >>> [   35.479785]   Exception class = DABT (current EL), IL = 32 bits
> >>> [   35.480528]   SET = 0, FnV = 0
> >>> [   35.480980]   EA = 0, S1PTW = 0
> >>> [   35.481345] Data abort info:
> >>> [   35.481680]   ISV = 0, ISS = 0x00000004
> >>> [   35.482267]   CM = 0, WnR = 0
> >>> [   35.482618] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
> >>> [   35.483486] [0000000000000070] pgd=0000000000000000
> >>> [   35.484041] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> >>> [   35.484788] Modules linked in:
> >>> [   35.485311] CPU: 113 PID: 3973 Comm: io_uring_regist Not tainted 5.1.0-rc3-00012-g40b114779944 #1
> >>> [   35.486712] Hardware name: linux,dummy-virt (DT)
> >>> [   35.487450] pstate: 20400005 (nzCv daif +PAN -UAO)
> >>> [   35.488228] pc : link_pwq+0x10/0x60
> >>> [   35.488794] lr : apply_wqattrs_commit+0xe0/0x118
> >>> [   35.489550] sp : ffff000017e2bbc0
> >>
> >> Huh, this looks odd, it's crashing inside the wq setup.
> > 
> > Enabling KASAN seems to indicate a double-free, which may well be related.
> 
> Does this help?

Yes, thanks for the quick patch. Feel free to add:

Reported-by: Will Deacon <will.deacon@arm.com>
Tested-by: Will Deacon <will.deacon@arm.com>

if you spin a proper patch.

Will

> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index bbdbd56cf2ac..07d6ef195d05 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2215,6 +2215,7 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
>  			fput(ctx->user_files[i]);
>  
>  		kfree(ctx->user_files);
> +		ctx->user_files = NULL;
>  		ctx->nr_user_files = 0;
>  		return ret;
>  	}
> 
> -- 
> Jens Axboe
> 
