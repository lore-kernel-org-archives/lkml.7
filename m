Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E980BC4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33A52083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbfFXR57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:57:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:43056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbfFXR56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:57:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83F67ABE1;
        Mon, 24 Jun 2019 17:57:57 +0000 (UTC)
Message-ID: <1561399075.3073.6.camel@suse.de>
Subject: Re: [PATCH v10 03/13] mm/sparsemem: Add helpers track active
 portions of a section at boot
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Jane Chu <jane.chu@oracle.com>,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 19:57:55 +0200
In-Reply-To: <156092350874.979959.18185938451405518285.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
         <156092350874.979959.18185938451405518285.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-18 at 22:51 -0700, Dan Williams wrote:
> Prepare for hot{plug,remove} of sub-ranges of a section by tracking a
> sub-section active bitmask, each bit representing a PMD_SIZE span of
> the
> architecture's memory hotplug section size.
> 
> The implications of a partially populated section is that pfn_valid()
> needs to go beyond a valid_section() check and either determine that
> the
> section is an "early section", or read the sub-section active ranges
> from the bitmask. The expectation is that the bitmask
> (subsection_map)
> fits in the same cacheline as the valid_section() / early_section()
> data, so the incremental performance overhead to pfn_valid() should
> be
> negligible.
> 
> The rationale for using early_section() to short-ciruit the
> subsection_map check is that there are legacy code paths that use
> pfn_valid() at section granularity before validating the pfn against
> pgdat data. So, the early_section() check allows those traditional
> assumptions to persist while also permitting subsection_map to tell
> the
> truth for purposes of populating the unused portions of early
> sections
> with PMEM and other ZONE_DEVICE mappings.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reported-by: Qian Cai <cai@lca.pw>
> Tested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
