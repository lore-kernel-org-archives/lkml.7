Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BAAC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF48222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387988AbfJDR3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:29:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729542AbfJDR3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:29:15 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x94HDoav192911
        for <linux-kernel@vger.kernel.org>; Fri, 4 Oct 2019 13:29:14 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ve5cg3ytf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 13:29:14 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 4 Oct 2019 18:29:11 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 4 Oct 2019 18:29:08 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x94HT7Vk58065062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Oct 2019 17:29:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DEFBA405B;
        Fri,  4 Oct 2019 17:29:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9015A405C;
        Fri,  4 Oct 2019 17:29:05 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.204.245])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  4 Oct 2019 17:29:05 +0000 (GMT)
Date:   Fri, 4 Oct 2019 20:29:03 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 00/21] Refine memblock API
References: <CAHCN7xL1sFXDhKUpj04d3eDZNgLA1yGAOqwEeCxedy1Qm-JOfQ@mail.gmail.com>
 <20190928073331.GA5269@linux.ibm.com>
 <CAHCN7xJEvS2Si=M+BYtz+kY0M4NxmqDjiX9Nwq6_3GGBh3yg=w@mail.gmail.com>
 <CAHCN7xKLhWw4P9-sZKXQcfSfh2r3J_+rLxuxACW0UVgimCzyVw@mail.gmail.com>
 <20191002073605.GA30433@linux.ibm.com>
 <CAHCN7xL1MkJh44N3W_1+08DHmX__SqnfH6dqUzYzr2Wpg0kQyQ@mail.gmail.com>
 <20191003053451.GA23397@linux.ibm.com>
 <20191003084914.GV25745@shell.armlinux.org.uk>
 <20191003113010.GC23397@linux.ibm.com>
 <20191004092727.GX25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004092727.GX25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19100417-0008-0000-0000-0000031E134C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100417-0009-0000-0000-00004A3D1F6E
Message-Id: <20191004172902.GB17825@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910040147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:27:27AM +0100, Russell King - ARM Linux admin wrote:
> On Thu, Oct 03, 2019 at 02:30:10PM +0300, Mike Rapoport wrote:
> > On Thu, Oct 03, 2019 at 09:49:14AM +0100, Russell King - ARM Linux admin wrote:
> > > On Thu, Oct 03, 2019 at 08:34:52AM +0300, Mike Rapoport wrote:
> > > > (trimmed the CC)
> > > > 
> > > > On Wed, Oct 02, 2019 at 06:14:11AM -0500, Adam Ford wrote:
> > > > > On Wed, Oct 2, 2019 at 2:36 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > > > >
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
> > > > I'm still not convinced that the memblock refactoring didn't uncovered an
> > > > issue in etnaviv driver.
> > > > 
> > > > Why moving the CMA area from 0x80000000 to 0x30000000 makes it fail?
> > > 
> > > I think you have that the wrong way round.
> > 
> > I'm relying on Adam's reports of working and non-working versions.
> > According to that etnaviv works when CMA area is at 0x80000000 and does not
> > work when it is at 0x30000000.
> > 
> > He also sent logs a few days ago [1], they also confirm that.
> > 
> > [1] https://lore.kernel.org/linux-mm/CAHCN7xJEvS2Si=M+BYtz+kY0M4NxmqDjiX9Nwq6_3GGBh3yg=w@mail.gmail.com/
> 
> Sorry, yes, you're right.  Still, I've reported this same regression
> a while back, and it's never gone away.
> 
> > > > BTW, the code that complained about "command buffer outside valid memory
> > > > window" has been removed by the commit 17e4660ae3d7 ("drm/etnaviv:
> > > > implement per-process address spaces on MMUv2"). 
> > > > 
> > > > Could be that recent changes to MMU management of etnaviv resolve the
> > > > issue?
> > > 
> > > The iMX6 does not have MMUv2 hardware, it has MMUv1.  With MMUv1
> > > hardware requires command buffers within the first 2GiB of physical
> > > RAM.
> > 
> > I've mentioned that patch because it removed the check for cmdbuf address
> > for MMUv1:
> > 
> > @@ -785,15 +768,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
> >                                   PAGE_SIZE);
> >         if (ret) {
> >                 dev_err(gpu->dev, "could not create command buffer\n");
> > -               goto unmap_suballoc;
> > -       }
> > -
> > -       if (!(gpu->identity.minor_features1 & chipMinorFeatures1_MMU_VERSION) &&
> > -           etnaviv_cmdbuf_get_va(&gpu->buffer, &gpu->cmdbuf_mapping) > 0x80000000) {
> > -               ret = -EINVAL;
> > -               dev_err(gpu->dev,
> > -                       "command buffer outside valid memory window\n");
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
> to do, and I note that these changes are _not_ described in the commit
> message.  The problem was known about _before_ (June 22) the patch was
> created (July 5).

The memblock refactoring went in in 5.1 which was May 5, and likely it
caused the regression.

Unless I'm missing something, before the memblock refactoring the CMA
reservation could use the entire physical memory because
memblock_phys_alloc() didn't enforce memblock.current_limit.

Since memblock default is to allocate from top, cma_declare_contiguous()
could grab the memory close to the end of DRAM and thus have physical
address close enough to the virtual address to fit in the 2G limit.

When I've made memblock_phys* limit the memblock allocations to
memblock.current_limit the CMA area moved too far away down and the gap
became larger than 2G.

It does not seem like dealing with this in etnaviv driver and DMA and CMA
APIs would happen fast and the "revert" of the memblock changes I've sent
earlier in this thread does fix the problem.

Andrew, would you like me to resend the patch in a separate e-mail?
 
> Lucas, please can you explain why removing the above check, which is
> well known to correctly trigger on various platforms to prevent
> incorrect GPU behaviour, is safe?
> 
> Thanks.
> 

-- 
Sincerely yours,
Mike.

