Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B4BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7B22133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDIKJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:09:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:11642 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfDIKJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:09:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 03:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="134214186"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 09 Apr 2019 03:09:01 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hDngZ-0001Ys-K4; Tue, 09 Apr 2019 13:08:59 +0300
Date:   Tue, 9 Apr 2019 13:08:59 +0300
From:   Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 09/18] iommu/vt-d: Enlightened PASID allocation
Message-ID: <20190409100859.GF9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-10-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554767973-30125-10-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 04:59:24PM -0700, Jacob Pan wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the
> IOMMU driver should rely on the emulation software to allocate
> and free PASID IDs. The Intel vt-d spec revision 3.0 defines a
> register set to support this. This includes a capability register,
> a virtual command register and a virtual response register. Refer
> to section 10.4.42, 10.4.43, 10.4.44 for more information.
> 
> This patch adds the enlightened PASID allocation/free interfaces
> via the virtual command register.

> +	pr_debug("vcmd alloc pasid\n");

Perhaps tracepoints should be in use?
OTOH we have function tracer, so, this message in any case is a noise.
And this is applicable to other similar cases.

-- 
With Best Regards,
Andy Shevchenko


