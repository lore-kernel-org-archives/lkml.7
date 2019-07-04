Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A865C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9DA218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562266407;
	bh=qkDBOADvWshMyVN7H3BLz2q7D8CF8WI3UnSO0p9XJrk=;
	h=Date:From:To:Subject:In-Reply-To:References:List-ID:From;
	b=f4D9reeW58ud2XFZ0ZW8ia5fTifEkrs3Oa6RpqGhdMO6wGIw7FYmkontg7KN3msda
	 +4+iu/3ejl4pD1YOMIaJzFQSFW1H8P6RGcn9lwuBpTRrlORL9CCFc7jxhPvcRYfY5z
	 NwFILOn0Joex/KvT1va2XdL6pViAX1fE+1t5E4/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfGDSx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 14:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfGDSx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 14:53:26 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFC8621738;
        Thu,  4 Jul 2019 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562266405;
        bh=qkDBOADvWshMyVN7H3BLz2q7D8CF8WI3UnSO0p9XJrk=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=YP1CWkmH0JmPvIb/iq31MuI00kd3EDa/9+C6FkMW9xNGhHlkejojh07VR/3oy9+KK
         IaMaAVuXl15/ma/jlj84cLS06pu+hF+aZFECnsfjJYLa1fqDGmLqdbwVk7A2KeDeKQ
         /qpQ+nlJ635aiqGfp36Mf66+8oo8W3i8EH5ciKR8=
Date:   Thu, 4 Jul 2019 11:53:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/4] Devmap cleanups + arm64 support
Message-Id: <20190704115324.c9780d01ef6938ab41403bf9@linux-foundation.org>
In-Reply-To: <20190626203551.4612e12be27be3458801703b@linux-foundation.org>
References: <cover.1558547956.git.robin.murphy@arm.com>
        <20190626073533.GA24199@infradead.org>
        <20190626123139.GB20635@lakrids.cambridge.arm.com>
        <20190626153829.GA22138@infradead.org>
        <20190626154532.GA3088@mellanox.com>
        <20190626203551.4612e12be27be3458801703b@linux-foundation.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 20:35:51 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> > Let me know and I can help orchestate this.
> 
> Well.  Whatever works.  In this situation I'd stage the patches after
> linux-next and would merge them up after the prereq patches have been
> merged into mainline.  Easy.

All right, what the hell just happened?  A bunch of new material has
just been introduced into linux-next.  I've partially unpicked the
resulting mess, haven't dared trying to compile it yet.  To get this
far I'll need to drop two patch series and one individual patch:


mm-clean-up-is_device__page-definitions.patch
mm-introduce-arch_has_pte_devmap.patch
arm64-mm-implement-pte_devmap-support.patch
arm64-mm-implement-pte_devmap-support-fix.patch

mm-sparsemem-introduce-struct-mem_section_usage.patch
mm-sparsemem-introduce-a-section_is_early-flag.patch
mm-sparsemem-add-helpers-track-active-portions-of-a-section-at-boot.patch
mm-hotplug-prepare-shrink_zone-pgdat_span-for-sub-section-removal.patch
mm-sparsemem-convert-kmalloc_section_memmap-to-populate_section_memmap.patch
mm-hotplug-kill-is_dev_zone-usage-in-__remove_pages.patch
mm-kill-is_dev_zone-helper.patch
mm-sparsemem-prepare-for-sub-section-ranges.patch
mm-sparsemem-support-sub-section-hotplug.patch
mm-document-zone_device-memory-model-implications.patch
mm-document-zone_device-memory-model-implications-fix.patch
mm-devm_memremap_pages-enable-sub-section-remap.patch
libnvdimm-pfn-fix-fsdax-mode-namespace-info-block-zero-fields.patch
libnvdimm-pfn-stop-padding-pmem-namespaces-to-section-alignment.patch

mm-sparsemem-cleanup-section-number-data-types.patch
mm-sparsemem-cleanup-section-number-data-types-fix.patch


I thought you were just going to move material out of -mm and into
hmm.git.  Didn't begin to suspect that new and quite disruptive
material would be introduced late in -rc7!!
