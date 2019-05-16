Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB9DC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCF320848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfEPO2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:28:02 -0400
Received: from foss.arm.com ([217.140.101.70]:47602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfEPO2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:28:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08ED91715;
        Thu, 16 May 2019 07:28:01 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5EAA3F71E;
        Thu, 16 May 2019 07:27:59 -0700 (PDT)
Date:   Thu, 16 May 2019 15:27:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Bad virt_to_phys since commit 54c7a8916a887f35
Message-ID: <20190516142756.GE43059@lakrids.cambridge.arm.com>
References: <20190516133820.GA43059@lakrids.cambridge.arm.com>
 <20190516134105.GB43059@lakrids.cambridge.arm.com>
 <e70ead93-2fe9-faf9-9e77-9df15809bad6@arm.com>
 <20190516141640.GC43059@lakrids.cambridge.arm.com>
 <d265e5fe-c061-17a0-427d-0e6f31be17f3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d265e5fe-c061-17a0-427d-0e6f31be17f3@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 03:20:59PM +0100, Steven Price wrote:
> On 16/05/2019 15:16, Mark Rutland wrote:
> > On Thu, May 16, 2019 at 03:05:31PM +0100, Steven Price wrote:
> >> I suspect the following is sufficient to fix the problem:
> >>
> >> ----8<-----
> >> diff --git a/init/initramfs.c b/init/initramfs.c
> >> index 435a428c2af1..178130fd61c2 100644
> >> --- a/init/initramfs.c
> >> +++ b/init/initramfs.c
> >> @@ -669,7 +669,7 @@ static int __init populate_rootfs(void)
> >>  	 * If the initrd region is overlapped with crashkernel reserved region,
> >>  	 * free only memory that is not part of crashkernel region.
> >>  	 */
> >> -	if (!do_retain_initrd && !kexec_free_initrd())
> >> +	if (!do_retain_initrd && initrd_start && !kexec_free_initrd())
> >>  		free_initrd_mem(initrd_start, initrd_end);
> >>  	initrd_start = 0;
> >>  	initrd_end = 0;
> > 
> > That works for me. If you spin this as a real patch:
> > 
> > Tested-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > As I mentioned, initrd_start has not been initialized at all, so I
> > suspect we should also update its declaration in init/do_mounts_initrd.c
> > such that it is guaranteed to be initialized to zero. We get away with
> > that today, but that won't necessarily hold with LTO and so on...
> 
> Well it's a global variable, so the C standard says it should be
> initialised to 0...

For some reason I was under the impression that wasn't guaranteed, but I
see that it is. Sorry for the noise.

> I'll spin a real patch and add your Tested-by

Great; thanks!

Mark.
