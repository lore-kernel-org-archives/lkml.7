Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B563C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4320D208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559937272;
	bh=8psQmUHD9luxI22nFWbQOgpTZfWDCb9IM6SP1Gb6RuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1tI6KBXPKtk9TA8YHyXerum3mWAeT9BldNlTDSP+S7ijXV93Ua+b+/9tqGJeQeups
	 bdY2WcSHgi5mOBJSACK3T3WAnmTS6BdIr6AzkvYbyEP2WGJZd4nzv+GOu3YEzi9TVj
	 AVgt93W9d8blFAycn0/x1L8oFQmRo5LkBaWt4Eow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbfFGTyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbfFGTyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:54:31 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81E7D208C3;
        Fri,  7 Jun 2019 19:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559937270;
        bh=8psQmUHD9luxI22nFWbQOgpTZfWDCb9IM6SP1Gb6RuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TANt56tMnGHGSeTHxg2W5Nga6u0fq8FsdWYmLcrlsCGA2NGsA2mQH36A8hsYaUQl7
         PvF+FiSUc0fahikKKGkO11OQ4+xLKsQjmAxNlLOFaGKdbVX69LqoznlxnaXcFMOm0G
         NPbdjRpokmMR23+zPVRWYusaOBotEgcPCbhlQMLI=
Date:   Fri, 7 Jun 2019 12:54:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v9 11/12] libnvdimm/pfn: Fix fsdax-mode namespace
 info-block zero-fields
Message-Id: <20190607125430.81e63cd56590ab3fea37a635@linux-foundation.org>
In-Reply-To: <CAPcyv4hHs75hYs+Ye+NHHiU31C6CnBqCFdo=2c5seN7kvxKOrw@mail.gmail.com>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
        <155977193862.2443951.10284714500308539570.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20190606144643.4f3363db9499ebbf8f76e62e@linux-foundation.org>
        <CAPcyv4hHs75hYs+Ye+NHHiU31C6CnBqCFdo=2c5seN7kvxKOrw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2019 15:06:26 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> On Thu, Jun 6, 2019 at 2:46 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 05 Jun 2019 14:58:58 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > > At namespace creation time there is the potential for the "expected to
> > > be zero" fields of a 'pfn' info-block to be filled with indeterminate
> > > data. While the kernel buffer is zeroed on allocation it is immediately
> > > overwritten by nd_pfn_validate() filling it with the current contents of
> > > the on-media info-block location. For fields like, 'flags' and the
> > > 'padding' it potentially means that future implementations can not rely
> > > on those fields being zero.
> > >
> > > In preparation to stop using the 'start_pad' and 'end_trunc' fields for
> > > section alignment, arrange for fields that are not explicitly
> > > initialized to be guaranteed zero. Bump the minor version to indicate it
> > > is safe to assume the 'padding' and 'flags' are zero. Otherwise, this
> > > corruption is expected to benign since all other critical fields are
> > > explicitly initialized.
> > >
> > > Fixes: 32ab0a3f5170 ("libnvdimm, pmem: 'struct page' for pmem")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > The cc:stable in [11/12] seems odd.  Is this independent of the other
> > patches?  If so, shouldn't it be a standalone thing which can be
> > prioritized?
> >
> 
> The cc: stable is about spreading this new policy to as many kernels
> as possible not fixing an issue in those kernels. It's not until patch
> 12 "libnvdimm/pfn: Stop padding pmem namespaces to section alignment"
> as all previous kernel do initialize all fields.
> 
> I'd be ok to drop that cc: stable, my concern is distros that somehow
> pickup and backport patch 12 and miss patch 11.

Could you please propose a changelog paragraph which explains all this
to those who will be considering this patch for backports?

