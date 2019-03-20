Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E75C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC23321850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfCTK0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:26:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:18912 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfCTK0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:26:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 03:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,248,1549958400"; 
   d="scan'208";a="154023085"
Received: from tfkristx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.211])
  by fmsmga004.fm.intel.com with ESMTP; 20 Mar 2019 03:26:05 -0700
Date:   Wed, 20 Mar 2019 12:26:07 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sudeep Dutt <sudeep.dutt@intel.com>
Cc:     ashutosh.dixit@intel.com, linux-kernel@vger.kernel.org
Subject: Re: scif_insert_vma()
Message-ID: <20190320102607.GA9457@linux.intel.com>
References: <20190311064514.GA10833@linux.intel.com>
 <1552888060.22480.197.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552888060.22480.197.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 10:47:40PM -0700, Sudeep Dutt wrote:
> On Mon, 2019-03-11 at 08:45 +0200, Jarkko Sakkinen wrote:
> > Hi
> > 
> > Just wondering what will happen if kzalloc() fails in scif_mmap.c. How
> > it is recovered? I don't see anything in the VMA callbacks taking care
> > of this.
> 
> Hi Jarkko,
> 
> scif_insert_vma(..) is called from scif_mmap(..) and scif_vma_open(..).
> scif_mmap(..) checks for allocation failures but scif_vma_open(..) does
> not on purpose.
> 
> The vm_operations_struct open(..)/close(..) callbacks do not allow
> returning errors. The driver will take a reference to the VMA private
> data structure irrespective of whether the allocation during the
> open(..) callback succeeds or fails. The close(..) callback cleans up
> the data structures from the mmap(..) or open(..) callbacks if any.

I'm doing allocations also in SGX vma_open callback and was grepping
through kernel tree for how allocations were handled.  Thanks for
clarifying this. In SGX's case I ended up with allowing to fail in
vma open and doing SIGBUS in the #PF handler if so...

/Jarkko
