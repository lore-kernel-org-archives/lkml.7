Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF85C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF33E2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDCUAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:00:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCUAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:00:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BCE1308220B;
        Wed,  3 Apr 2019 20:00:43 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B86119C69;
        Wed,  3 Apr 2019 20:00:38 +0000 (UTC)
Date:   Wed, 3 Apr 2019 14:00:37 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com, cohuck@redhat.com, peterx@redhat.com
Subject: Re: [PATCH v2] vfio/type1: Limit DMA mappings per container
Message-ID: <20190403140037.15fcd764@x1.home>
In-Reply-To: <20190403192426.GA16117@redhat.com>
References: <155422160029.16896.1992475589398080933.stgit@gimli.home>
        <20190403192426.GA16117@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 03 Apr 2019 20:00:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 15:24:26 -0400
Jerome Glisse <jglisse@redhat.com> wrote:

> On Tue, Apr 02, 2019 at 10:15:38AM -0600, Alex Williamson wrote:
> > Memory backed DMA mappings are accounted against a user's locked
> > memory limit, including multiple mappings of the same memory.  This
> > accounting bounds the number of such mappings that a user can create.
> > However, DMA mappings that are not backed by memory, such as DMA
> > mappings of device MMIO via mmaps, do not make use of page pinning
> > and therefore do not count against the user's locked memory limit.
> > These mappings still consume memory, but the memory is not well
> > associated to the process for the purpose of oom killing a task.
> > 
> > To add bounding on this use case, we introduce a limit to the total
> > number of concurrent DMA mappings that a user is allowed to create.
> > This limit is exposed as a tunable module option where the default
> > value of 64K is expected to be well in excess of any reasonable use
> > case (a large virtual machine configuration would typically only make
> > use of tens of concurrent mappings).
> > 
> > This fixes CVE-2019-3882.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> 
> Have you tested with GPU passthrough ? GPU have huge BAR from
> hundred of mega bytes to giga bytes (some driver resize them
> to cover the whole GPU memory). Driver need to map those to
> properly work. I am not sure what path is taken by mmap of
> mmio BAR by a guest on the host but i just thought i would
> point that out.

The limit introduced is the number of mappings that a user can have
outstanding, not the size of the mappings.  We don't try to estimate
the overhead of a mapping based on the mapping size since IOMMU
super-page support can make a 1GB mapping comparable in overhead to a
4KB mapping.  QEMU will generally try to map a bar with a single
mapping, unless it's split by something like an MSI-X vector table or
quirks, which still results in a low single digit number of mappings per
BAR.  This does not affect how the guest drivers use the device, BARs
cannot be partially enabled from a DMA address space perspective.

If a userspace driver were trying to map a large GPU BAR with separate
4K mappings, they could indeed hit the limit, but it's far from the
common or expected use case and the module tunable could be used to
provide this functionality if it were really necessary.

There's really no support for resizable BARs through vfio-pci right now,
we get the device in its base configuration, QEMU maps that and exposes
a rather fixed device to the VM.  If this is something we need to
address for GPU assignment, let's talk.  Thanks,

Alex
