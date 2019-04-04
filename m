Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA817C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A4B206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554411412;
	bh=7wPxkuXlZSURuJ19R6WoJ7PH1GZpg13Hs0k2qrDaxPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gTx6SYm+HNRkjI25DWjzXQZfD5Kx2G2vnj6D/VdYYs8mDcxjr/UpLusWvbfGgeh1n
	 GEICYUZ3YCUjttrqYGpUcOhKUXfN95FJu7fsI+yvMALpJHrV0OJj/j3p+GhUwJPGOV
	 2HeB4Jv19cnghjRLx2ci20Wx5aaqIt1/orb4E1wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfDDU4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:56:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:55616 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbfDDU4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:56:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 13:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,309,1549958400"; 
   d="scan'208";a="335083553"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 04 Apr 2019 13:56:49 -0700
Date:   Thu, 4 Apr 2019 14:58:18 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, x86@kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org
Subject: Re: [RFC PATCH 3/5] acpi/hmat: Track target address ranges
Message-ID: <20190404205818.GC24499@localhost.localdomain>
References: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155440492414.3190322.12683374224345847860.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155440492414.3190322.12683374224345847860.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 12:08:44PM -0700, Dan Williams wrote:
> As of ACPI 6.3 the HMAT no longer advertises the physical memory address
> range for its entries. Instead, the expectation is the corresponding
> entry in the SRAT is looked up by the target proximity domain.
> 
> Given there may be multiple distinct address ranges that share the same
> performance profile (sparse address space), find_mem_target() is updated
> to also consider the start address of the memory range. Target property
> updates are also adjusted to loop over all possible 'struct target'
> instances that may share the same proximity domain identification.

Since this may allocate multiple targets with the same PXM,
hmat_register_targets() will attempt to register the same node multiple
times.

Would it make sense if the existing struct memory_target adds a resource
list that we can append to as we parse SRAT? That way we have one target
per memory node, and also track the ranges.
