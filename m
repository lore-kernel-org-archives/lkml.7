Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61FCC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821F4222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O0iZExLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfJCIta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:49:30 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39982 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfJCIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q5TExg+4TQhLrghJSY1icmd2xGrFxJ2aG5hPkzrxoDo=; b=O0iZExLAO4uc+e/CglOD7o1sG
        XdeWeGADcm11wnkviHeLVMjXiFkSMEWsnB1aRuOrg9pdfhW8cxOvVxNDAdjCd5pzB1Y/YnaV0t8gt
        c3d7A++vtECK+gMCtq/WDZ4Jf4kZ5R1nHi+5NSiRPmW6qfzg/qgM1TyywcHJn69oFbwOowhMGxOw6
        ZDq+Bifokb3wN/D2qf+bWxeB7djWt+ji4fUoBA6EIZGgvundyQudFgIZOZ4wm14wWBDRbZMBie4L2
        GrZZhAnjCg/zZPwp6zKGNlvY6rlgE8P7qYeZITFAKoitL+TigifTruIavCHkhzJPLypp60ntvNzBc
        6PbFqSvIw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:47020)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iFwnY-0005L4-41; Thu, 03 Oct 2019 09:49:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iFwnS-0001bt-8g; Thu, 03 Oct 2019 09:49:14 +0100
Date:   Thu, 3 Oct 2019 09:49:14 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Mike Rapoport <rppt@linux.ibm.com>
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
Message-ID: <20191003084914.GV25745@shell.armlinux.org.uk>
References: <CAOMZO5D2uzR6Sz1QnX3G-Ce_juxU-0PO_vBZX+nR1mpQB8s8-w@mail.gmail.com>
 <CAHCN7xJ32BYZu-DVTVLSzv222U50JDb8F0A_tLDERbb8kPdRxg@mail.gmail.com>
 <20190926160433.GD32311@linux.ibm.com>
 <CAHCN7xL1sFXDhKUpj04d3eDZNgLA1yGAOqwEeCxedy1Qm-JOfQ@mail.gmail.com>
 <20190928073331.GA5269@linux.ibm.com>
 <CAHCN7xJEvS2Si=M+BYtz+kY0M4NxmqDjiX9Nwq6_3GGBh3yg=w@mail.gmail.com>
 <CAHCN7xKLhWw4P9-sZKXQcfSfh2r3J_+rLxuxACW0UVgimCzyVw@mail.gmail.com>
 <20191002073605.GA30433@linux.ibm.com>
 <CAHCN7xL1MkJh44N3W_1+08DHmX__SqnfH6dqUzYzr2Wpg0kQyQ@mail.gmail.com>
 <20191003053451.GA23397@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003053451.GA23397@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 08:34:52AM +0300, Mike Rapoport wrote:
> (trimmed the CC)
> 
> On Wed, Oct 02, 2019 at 06:14:11AM -0500, Adam Ford wrote:
> > On Wed, Oct 2, 2019 at 2:36 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > 
> > Before the patch:
> > 
> > # cat /sys/kernel/debug/memblock/memory
> >    0: 0x10000000..0x8fffffff
> > # cat /sys/kernel/debug/memblock/reserved
> >    0: 0x10004000..0x10007fff
> >   34: 0x2fffff88..0x3fffffff
> > 
> > 
> > After the patch:
> > # cat /sys/kernel/debug/memblock/memory
> >    0: 0x10000000..0x8fffffff
> > # cat /sys/kernel/debug/memblock/reserved
> >    0: 0x10004000..0x10007fff
> >   36: 0x80000000..0x8fffffff
> 
> I'm still not convinced that the memblock refactoring didn't uncovered an
> issue in etnaviv driver.
> 
> Why moving the CMA area from 0x80000000 to 0x30000000 makes it fail?

I think you have that the wrong way round.

> BTW, the code that complained about "command buffer outside valid memory
> window" has been removed by the commit 17e4660ae3d7 ("drm/etnaviv:
> implement per-process address spaces on MMUv2"). 
> 
> Could be that recent changes to MMU management of etnaviv resolve the
> issue?

The iMX6 does not have MMUv2 hardware, it has MMUv1.  With MMUv1
hardware requires command buffers within the first 2GiB of physical
RAM.

I've reported the problem previously but there was no resolution,
other than pointing the blame at CMA.

https://lists.freedesktop.org/archives/dri-devel/2019-June/thread.html#223516

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
