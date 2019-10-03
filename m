Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FABC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02D220862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfJCNR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:17:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35835 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfJCNR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:17:59 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iG0zJ-0006F9-Ty; Thu, 03 Oct 2019 15:17:46 +0200
Message-ID: <662abbc0298ebab59919490ccc3d5c093ae35cf7.camel@pengutronix.de>
Subject: Re: [PATCH v2 00/21] Refine memblock API
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 03 Oct 2019 15:17:36 +0200
In-Reply-To: <20191003113010.GC23397@linux.ibm.com>
References: <CAHCN7xJ32BYZu-DVTVLSzv222U50JDb8F0A_tLDERbb8kPdRxg@mail.gmail.com>
         <20190926160433.GD32311@linux.ibm.com>
         <CAHCN7xL1sFXDhKUpj04d3eDZNgLA1yGAOqwEeCxedy1Qm-JOfQ@mail.gmail.com>
         <20190928073331.GA5269@linux.ibm.com>
         <CAHCN7xJEvS2Si=M+BYtz+kY0M4NxmqDjiX9Nwq6_3GGBh3yg=w@mail.gmail.com>
         <CAHCN7xKLhWw4P9-sZKXQcfSfh2r3J_+rLxuxACW0UVgimCzyVw@mail.gmail.com>
         <20191002073605.GA30433@linux.ibm.com>
         <CAHCN7xL1MkJh44N3W_1+08DHmX__SqnfH6dqUzYzr2Wpg0kQyQ@mail.gmail.com>
         <20191003053451.GA23397@linux.ibm.com>
         <20191003084914.GV25745@shell.armlinux.org.uk>
         <20191003113010.GC23397@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 03.10.2019, 14:30 +0300 schrieb Mike Rapoport:
> On Thu, Oct 03, 2019 at 09:49:14AM +0100, Russell King - ARM Linux admin wrote:
> > On Thu, Oct 03, 2019 at 08:34:52AM +0300, Mike Rapoport wrote:
> > > (trimmed the CC)
> > > 
> > > On Wed, Oct 02, 2019 at 06:14:11AM -0500, Adam Ford wrote:
> > > > On Wed, Oct 2, 2019 at 2:36 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > > 
> > > > Before the patch:
> > > > 
> > > > # cat /sys/kernel/debug/memblock/memory
> > > >    0: 0x10000000..0x8fffffff
> > > > # cat /sys/kernel/debug/memblock/reserved
> > > >    0: 0x10004000..0x10007fff
> > > >   34: 0x2fffff88..0x3fffffff
> > > > 
> > > > 
> > > > After the patch:
> > > > # cat /sys/kernel/debug/memblock/memory
> > > >    0: 0x10000000..0x8fffffff
> > > > # cat /sys/kernel/debug/memblock/reserved
> > > >    0: 0x10004000..0x10007fff
> > > >   36: 0x80000000..0x8fffffff
> > > 
> > > I'm still not convinced that the memblock refactoring didn't uncovered an
> > > issue in etnaviv driver.
> > > 
> > > Why moving the CMA area from 0x80000000 to 0x30000000 makes it fail?
> > 
> > I think you have that the wrong way round.
> 
> I'm relying on Adam's reports of working and non-working versions.
> According to that etnaviv works when CMA area is at 0x80000000 and does not
> work when it is at 0x30000000.
> 
> He also sent logs a few days ago [1], they also confirm that.
> 
> [1] https://lore.kernel.org/linux-mm/CAHCN7xJEvS2Si=M+BYtz+kY0M4NxmqDjiX9Nwq6_3GGBh3yg=w@mail.gmail.com/

To clarify: Etnaviv needs to know where the CMA area is in order to
move a aperture window to cover the CMA area so the command buffers
allocated in contig memory can be mapped through this aperture. Now the
issue is that there is currently there is no good API for a driver to
know where the CMA area is located, so we are trying to infer this from
dma_get_required_mask. Unfortunately this can overshoot the real DRAM
area by a bit, so combined with the fixed 2GB size of the GPU aperture
this means we are no longer able to map the command buffers through the
required aperture if the CMA area moves too far down in the physical
memory.

It's really a bad interaction between etnaviv and CMA area placement,
due to insufficient APIs to communicate some crucial information. There
is nothing in the etnaviv driver or the hardware which requires the CMA
area to be at a certain place, we just need to know where it is located
exactly. So my try at fixing this [1] was by adding a API to get the
required information, but the first attempt was shot down and I hadn't
had time to follow up on this yet.

Regards,
Lucas

[1] https://patchwork.kernel.org/patch/10966767/


