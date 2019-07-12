Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B083C742D1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460C620651
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfGLRAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:00:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:59375 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfGLRAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:00:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2019 10:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,483,1557212400"; 
   d="scan'208";a="365210846"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2019 10:00:17 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8518C301004; Fri, 12 Jul 2019 10:00:17 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     unlisted-recipients:; (no To-header on input)
        Jason Gunthorpe <jgg@ziepe.ca>, Ming Lei <ming.lei@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Gal Pressman <galpress@amazon.com>,
        Allison Randal <allison@lohutok.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)Jason Gunthorpe <jgg@ziepe.ca>
                                                                     ^-missing end of address
Subject: Re: [PATCH] scatterlist: Allocate a contiguous array instead of chaining
References: <20190712063657.17088-1-sultan@kerneltoast.com>
Date:   Fri, 12 Jul 2019 10:00:17 -0700
In-Reply-To: <20190712063657.17088-1-sultan@kerneltoast.com> (Sultan Alsawaf's
        message of "Thu, 11 Jul 2019 23:36:56 -0700")
Message-ID: <87lfx39oim.fsf@firstfloor.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sultan Alsawaf <sultan@kerneltoast.com> writes:
>
> Abusing repeated kmallocs to produce a large allocation puts strain on
> the slab allocator, when kvmalloc can be used instead. The single
> kvmalloc allocation for all sg lists reduces the burden on the slab and
> page allocators, since for large sg list allocations, this commit
> replaces numerous kmalloc calls with one kvmalloc call.

Note that vmalloc will eventually cause global TLB flushes, which
are very expensive on larger systems. THere are also global locks
in vmalloc, which can also cause scaling problems. slab is a lot
more optimized.

I don't see any performance numbers in your proposal.

Did you test these corner cases?

I suspect you're better of with larger kmallocs up to a reasonable
size. How big would a sg list need to be to need more than a couple
pages?

-Andi
