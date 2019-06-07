Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF443C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA1A2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbfFGVlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:41:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731340AbfFGVla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:41:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56294ABE9;
        Fri,  7 Jun 2019 21:41:29 +0000 (UTC)
Message-ID: <1559943687.3141.8.camel@suse.de>
Subject: Re: [PATCH v9 08/12] mm/sparsemem: Support sub-section hotplug
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Jun 2019 23:41:27 +0200
In-Reply-To: <CAPcyv4hgmjUvA0+uMWYJibmgSWtoLw7zM-jFuP7eRdU2xyVxOw@mail.gmail.com>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
         <155977192280.2443951.13941265207662462739.stgit@dwillia2-desk3.amr.corp.intel.com>
         <20190607083351.GA5342@linux>
         <CAPcyv4hgmjUvA0+uMWYJibmgSWtoLw7zM-jFuP7eRdU2xyVxOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-07 at 08:38 -0700, Dan Williams wrote:
> I don't know, but I can't imagine it would because it's much easier
> to
> do mem_map relative translations by simple PAGE_OFFSET arithmetic.

Yeah, I guess so.

> No worries, its a valid question. The bitmap dance is still valid it
> will just happen on section boundaries instead of subsection. If
> anything breaks that's beneficial additional testing that we got from
> the SPARSEMEM sub-case for the SPARSEMEM_VMEMMAP superset-case.
> That's
> the gain for keeping them unified, what's the practical gain from
> hiding this bit manipulation from the SPARSEMEM case?

It is just that I thought that we might benefit from not doing extra
work if not needed (bitmap dance) in SPARSEMEM case.
But given that 1) hot-add/hot-remove paths are not hot paths, it does
not really matter 2) and that having all cases unified in one function
make sense too, spreading the work in more functions might be sub-
optimal.
I guess I could justfiy it in case both activate/deactive functions
would look convulated, but it is not the case here.

I just took another look to check that I did not miss anything.
It looks quite nice and compact IMO:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
