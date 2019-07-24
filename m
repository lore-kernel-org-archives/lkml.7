Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E010C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6592070B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfGXOet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:34:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:18868 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfGXOet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:34:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 07:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="171518552"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jul 2019 07:34:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 39248130; Wed, 24 Jul 2019 17:34:46 +0300 (EEST)
Date:   Wed, 24 Jul 2019 17:34:46 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        yang.shi@linux.alibaba.com, jannh@google.com, walken@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/mmap.c: silence variable 'new_start' set but not used
Message-ID: <20190724143445.ezii7bwbbxxxtu2k@black.fi.intel.com>
References: <20190724140739.59532-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724140739.59532-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 02:07:39PM +0000, YueHaibing wrote:
> 'new_start' is used in is_hugepage_only_range(),
> which do nothing in some arch. gcc will warning:

Make is_hugepage_only_range() reference the variable on such archs:

#define is_hugepage_only_range(mm, addr, len)   ((void) addr, 0)

-- 
 Kirill A. Shutemov
