Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93505C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2102082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfEPOVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:21:24 -0400
Received: from foss.arm.com ([217.140.101.70]:47414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfEPOVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:21:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8268E1715;
        Thu, 16 May 2019 07:21:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C1413F71E;
        Thu, 16 May 2019 07:21:22 -0700 (PDT)
Date:   Thu, 16 May 2019 15:21:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Bad virt_to_phys since commit 54c7a8916a887f35
Message-ID: <20190516142119.GD43059@lakrids.cambridge.arm.com>
References: <20190516133820.GA43059@lakrids.cambridge.arm.com>
 <20190516134105.GB43059@lakrids.cambridge.arm.com>
 <20190516141314.GF19122@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516141314.GF19122@rapoport-lnx>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 05:13:14PM +0300, Mike Rapoport wrote:
> On Thu, May 16, 2019 at 02:41:06PM +0100, Mark Rutland wrote:
> > On Thu, May 16, 2019 at 02:38:20PM +0100, Mark Rutland wrote:
> > > Hi,
> > > 
> > > Since commit:
> > > 
> > >   54c7a8916a887f35 ("initramfs: free initrd memory if opening /initrd.image fails")
> > 
> > Ugh, I dropped a paragarph here.
> > 
> > Since that commit, I'm seeing a boot-time splat on arm64 when using
> > CONFIG_DEBUG_VIRTUAL. I'm running an arm64 syzkaller instance, and this
> > kills the VM, preventing further testing, which is unfortunate.
> > 
> > Mark.
> > 
> > > IIUC prior to that commit, we'd only attempt to free an intird if we had
> > > one, whereas now we do so unconditionally. AFAICT, in this case
> > > initrd_start has not been initialized (I'm not using an initrd or
> > > initramfs on my system), so we end up trying virt_to_phys() on a bogus
> > > VA in free_initrd_mem().
> > > 
> > > Any ideas on the right way to fix this?
> 
> If I remember correctly, initrd_start would be 0 unless explicitly set by
> the arch setup code, so something like this could work:
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 435a428c2af1..05fe60437796 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -529,6 +529,9 @@ extern unsigned long __initramfs_size;
>  
>  void __weak free_initrd_mem(unsigned long start, unsigned long end)
>  {
> +       if (!start)
> +               return;
> +
>         free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
>                         "initrd");
>  }

I think this should work, given Steven's patch checks the same thing.

I don't have a preference as to which patch should be taken, so I'll
leave that to Christoph.

Thanks,
Mark.
