Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC178C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4B92070D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfDKRZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:25:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfDKRZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:25:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57E1F30944E2;
        Thu, 11 Apr 2019 17:25:18 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54BF75D9CC;
        Thu, 11 Apr 2019 17:25:17 +0000 (UTC)
Date:   Thu, 11 Apr 2019 13:25:15 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v3 0/1] Use HMM for ODP v3
Message-ID: <20190411172515.GC4266@redhat.com>
References: <20190410154125.21350-1-jglisse@redhat.com>
 <20190411122940.GZ3201@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411122940.GZ3201@mtr-leonro.mtl.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 11 Apr 2019 17:25:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 12:29:43PM +0000, Leon Romanovsky wrote:
> On Wed, Apr 10, 2019 at 11:41:24AM -0400, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> >
> > Changes since v1/v2 are about rebase and better comments in the code.
> > Previous cover letter slightly updated.
> >
> >
> > This patchset convert RDMA ODP to use HMM underneath this is motivated
> > by stronger code sharing for same feature (share virtual memory SVM or
> > Share Virtual Address SVA) and also stronger integration with mm code to
> > achieve that. It depends on HMM patchset posted for inclusion in 5.2 [2]
> > and [3].
> >
> > It has been tested with pingpong test with -o and others flags to test
> > different size/features associated with ODP.
> >
> > Moreover they are some features of HMM in the works like peer to peer
> > support, fast CPU page table snapshot, fast IOMMU mapping update ...
> > It will be easier for RDMA devices with ODP to leverage those if they
> > use HMM underneath.
> >
> > Quick summary of what HMM is:
> >     HMM is a toolbox for device driver to implement software support for
> >     Share Virtual Memory (SVM). Not only it provides helpers to mirror a
> >     process address space on a device (hmm_mirror). It also provides
> >     helper to allow to use device memory to back regular valid virtual
> >     address of a process (any valid mmap that is not an mmap of a device
> >     or a DAX mapping). They are two kinds of device memory. Private memory
> >     that is not accessible to CPU because it does not have all the expected
> >     properties (this is for all PCIE devices) or public memory which can
> >     also be access by CPU without restriction (with OpenCAPI or CCIX or
> >     similar cache-coherent and atomic inter-connect).
> >
> >     Device driver can use each of HMM tools separatly. You do not have to
> >     use all the tools it provides.
> >
> > For RDMA device i do not expect a need to use the device memory support
> > of HMM. This device memory support is geared toward accelerator like GPU.
> >
> >
> > You can find a branch [1] with all the prerequisite in. This patch is on
> > top of rdma-next with the HMM patchset [2] and mmu notifier patchset [3]
> > applied on top of it.
> >
> > [1] https://cgit.freedesktop.org/~glisse/linux/log/?h=rdma-5.2
> 
> Hi Jerome,
> 
> I took this branch and merged with our latest rdma-next, but it doesn't
> compile.
> 
> In file included from drivers/infiniband/hw/mlx5/mem.c:35:
> ./include/rdma/ib_umem_odp.h:110:20: error: field _mirror_ has
> incomplete type
>   struct hmm_mirror mirror;
>                       ^~~~~~
> ./include/rdma/ib_umem_odp.h:132:18: warning: _struct hmm_range_ declared inside parameter list will not be visible outside of this definition or declaration
> struct hmm_range *range);
> 	^~~~~~~~~
> make[4]: *** [scripts/Makefile.build:276: drivers/infiniband/hw/mlx5/mem.o] Error 1
> 
> The reason to it that in my .config, ZONE_DEVICE, MEMORY_HOTPLUG and HMM options were disabled.

Silly my i forgot to update kconfig so i pushed a branch with
proper kconfig changes in the ODP patch but it depends on changes
to the HMM kconfig so that HMM_MIRROR can be enabled on arch that
do not have everything for HMM_DEVICE.

https://cgit.freedesktop.org/~glisse/linux/log/?h=rdma-odp-hmm-v4

I doing build of various kconfig variation before posting to make
sure it is all good.

Cheers,
Jérôme
