Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D85C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CF72184E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbfEWPEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730783AbfEWPEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:04:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F9233082E24;
        Thu, 23 May 2019 15:04:37 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EB501001E81;
        Thu, 23 May 2019 15:04:33 +0000 (UTC)
Date:   Thu, 23 May 2019 11:04:32 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190523150432.GA5104@redhat.com>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
 <20190522235737.GD15389@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190522235737.GD15389@ziepe.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 23 May 2019 15:04:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 08:57:37PM -0300, Jason Gunthorpe wrote:
> On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:
> 
> > > > So attached is a rebase on top of 5.2-rc1, i have tested with pingpong
> > > > (prefetch and not and different sizes). Seems to work ok.
> > > 
> > > Urk, it already doesn't apply to the rdma tree :(
> > > 
> > > The conflicts are a little more extensive than I'd prefer to handle..
> > > Can I ask you to rebase it on top of this branch please:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/jgg-for-next
> > > 
> > > Specifically it conflicts with this patch:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-next&id=d2183c6f1958e6b6dfdde279f4cee04280710e34
> 
> There is at least one more serious blocker here:
> 
> config ARCH_HAS_HMM_MIRROR
>         bool
>         default y
>         depends on (X86_64 || PPC64)
>         depends on MMU && 64BIT
> 
> I can't loose ARM64 support for ODP by merging this, that is too
> serious of a regression.
> 
> Can you fix it?

5.2 already has patch to fix the Kconfig (ARCH_HAS_HMM_MIRROR and
ARCH_HAS_HMM_DEVICE replacing ARCH_HAS_HMM) I need to update nouveau
in 5.3 so that i can drop the old ARCH_HAS_HMM and then convert
core mm in 5.4 to use ARCH_HAS_HMM_MIRROR and ARCH_HAS_HMM_DEVICE
instead of ARCH_HAS_HMM

Adding ARM64 to ARCH_HAS_HMM_MIRROR should not be an issue i would
need access to an ARM64 to test as i did not wanted to enable it
without testing.

So it seems it will have to wait 5.4 for ODP. I will re-spin the
patch for ODP once i am done reviewing Ralph changes and yours
for 5.3.

Cheers,
Jérôme
