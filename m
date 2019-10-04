Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E8CC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F15207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbfJDNXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:23:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46727 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387952AbfJDNXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:23:25 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iGNWS-0001sz-5V; Fri, 04 Oct 2019 15:21:28 +0200
Message-ID: <bc05540f2aa46cff5d6239faab83446401ba7b5f.camel@pengutronix.de>
Subject: Re: [PATCH v2 00/21] Refine memblock API
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 04 Oct 2019 15:21:03 +0200
In-Reply-To: <20191004092727.GX25745@shell.armlinux.org.uk>
References: <20190926160433.GD32311@linux.ibm.com>
         <CAHCN7xL1sFXDhKUpj04d3eDZNgLA1yGAOqwEeCxedy1Qm-JOfQ@mail.gmail.com>
         <20190928073331.GA5269@linux.ibm.com>
         <CAHCN7xJEvS2Si=M+BYtz+kY0M4NxmqDjiX9Nwq6_3GGBh3yg=w@mail.gmail.com>
         <CAHCN7xKLhWw4P9-sZKXQcfSfh2r3J_+rLxuxACW0UVgimCzyVw@mail.gmail.com>
         <20191002073605.GA30433@linux.ibm.com>
         <CAHCN7xL1MkJh44N3W_1+08DHmX__SqnfH6dqUzYzr2Wpg0kQyQ@mail.gmail.com>
         <20191003053451.GA23397@linux.ibm.com>
         <20191003084914.GV25745@shell.armlinux.org.uk>
         <20191003113010.GC23397@linux.ibm.com>
         <20191004092727.GX25745@shell.armlinux.org.uk>
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

Am Freitag, den 04.10.2019, 10:27 +0100 schrieb Russell King - ARM
Linux admin:
> On Thu, Oct 03, 2019 at 02:30:10PM +0300, Mike Rapoport wrote:
> > On Thu, Oct 03, 2019 at 09:49:14AM +0100, Russell King - ARM Linux
> > admin wrote:
> > > On Thu, Oct 03, 2019 at 08:34:52AM +0300, Mike Rapoport wrote:
> > > > (trimmed the CC)
> > > > 
> > > > On Wed, Oct 02, 2019 at 06:14:11AM -0500, Adam Ford wrote:
> > > > > On Wed, Oct 2, 2019 at 2:36 AM Mike Rapoport <
> > > > > rppt@linux.ibm.com> wrote:
> > > > > 
> > > > > Before the patch:
> > > > > 
> > > > > # cat /sys/kernel/debug/memblock/memory
> > > > >    0: 0x10000000..0x8fffffff
> > > > > # cat /sys/kernel/debug/memblock/reserved
> > > > >    0: 0x10004000..0x10007fff
> > > > >   34: 0x2fffff88..0x3fffffff
> > > > > 
> > > > > 
> > > > > After the patch:
> > > > > # cat /sys/kernel/debug/memblock/memory
> > > > >    0: 0x10000000..0x8fffffff
> > > > > # cat /sys/kernel/debug/memblock/reserved
> > > > >    0: 0x10004000..0x10007fff
> > > > >   36: 0x80000000..0x8fffffff
> > > > 
> > > > I'm still not convinced that the memblock refactoring didn't
> > > > uncovered an
> > > > issue in etnaviv driver.
> > > > 
> > > > Why moving the CMA area from 0x80000000 to 0x30000000 makes it
> > > > fail?
> > > 
> > > I think you have that the wrong way round.
> > 
> > I'm relying on Adam's reports of working and non-working versions.
> > According to that etnaviv works when CMA area is at 0x80000000 and
> > does not
> > work when it is at 0x30000000.
> > 
> > He also sent logs a few days ago [1], they also confirm that.
> > 
> > [1] 
> > https://lore.kernel.org/linux-mm/CAHCN7xJEvS2Si=M+BYtz+kY0M4NxmqDjiX9Nwq6_3GGBh3yg=w@mail.gmail.com/
> 
> Sorry, yes, you're right.  Still, I've reported this same regression
> a while back, and it's never gone away.
> 
> > > > BTW, the code that complained about "command buffer outside
> > > > valid memory
> > > > window" has been removed by the commit 17e4660ae3d7
> > > > ("drm/etnaviv:
> > > > implement per-process address spaces on MMUv2"). 
> > > > 
> > > > Could be that recent changes to MMU management of etnaviv
> > > > resolve the
> > > > issue?
> > > 
> > > The iMX6 does not have MMUv2 hardware, it has MMUv1.  With MMUv1
> > > hardware requires command buffers within the first 2GiB of
> > > physical
> > > RAM.
> > 
> > I've mentioned that patch because it removed the check for cmdbuf
> > address
> > for MMUv1:
> > 
> > @@ -785,15 +768,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
> >                                   PAGE_SIZE);
> >         if (ret) {
> >                 dev_err(gpu->dev, "could not create command
> > buffer\n");
> > -               goto unmap_suballoc;
> > -       }
> > -
> > -       if (!(gpu->identity.minor_features1 &
> > chipMinorFeatures1_MMU_VERSION) &&
> > -           etnaviv_cmdbuf_get_va(&gpu->buffer, &gpu-
> > >cmdbuf_mapping) > 0x80000000) {
> > -               ret = -EINVAL;
> > -               dev_err(gpu->dev,
> > -                       "command buffer outside valid memory
> > window\n");
> > -               goto free_buffer;
> > +               goto fail;
> >         }
> >  
> >         /* Setup event management */
> > 
> > 
> > I really don't know how etnaviv works, so I hoped that people who
> > understand it would help.
> 
> From what I can see, removing that check is a completely insane thing
> to do, and I note that these changes are _not_ described in the
> commit
> message.  The problem was known about _before_ (June 22) the patch
> was
> created (July 5).
> 
> Lucas, please can you explain why removing the above check, which is
> well known to correctly trigger on various platforms to prevent
> incorrect GPU behaviour, is safe?

It isn't. It's a pretty big oversight in this commit to remove this
check. It can't be done at the same spot in the code anymore, as we
don't have a mapping context at this time anymore, but it should have
moved into etnaviv_iommu_context_init(). I'll send a patch to fix this
up.

Regards,
Lucas

