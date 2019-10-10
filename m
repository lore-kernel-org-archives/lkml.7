Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1D9C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E542190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbfJJI2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:28:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:45151 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfJJI2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:28:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 01:28:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208";a="198274137"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 Oct 2019 01:28:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4B00822C; Thu, 10 Oct 2019 11:28:03 +0300 (EEST)
Date:   Thu, 10 Oct 2019 11:28:03 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] ARC: mm: remove __ARCH_USE_5LEVEL_HACK
Message-ID: <20191010082803.biaon6gq7yxvrvrq@black.fi.intel.com>
References: <20191009184350.18323-1-vgupta@synopsys.com>
 <20191009185731.25814-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009185731.25814-1-vgupta@synopsys.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 06:57:31PM +0000, Vineet Gupta wrote:
> Add the intermediate p4d accessors to make it 5 level compliant.
> 
> This is a non-functional change anyways since ARC has software page walker
> with 2 lookup levels (pgd -> pte)
> 
> There is slight code bloat due to pulling in needless p*d_free_tlb()
> macros which needs to be addressed seperately.
> 
> | bloat-o-meter2 vmlinux-with-5LEVEL_HACK vmlinux-patched
> | add/remove: 0/0 grow/shrink: 2/0 up/down: 128/0 (128)
> | function                                     old     new   delta
> | free_pgd_range                               546     656    +110
> | p4d_clear_bad                                  2      20     +18
> | Total: Before=4137148, After=4137276, chg 0.000000%
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
