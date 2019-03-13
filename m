Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6546BC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FC02146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552494791;
	bh=hYFUE8iHDOyLWviUyLA2jHLIqA4whqUBgLBlXPCuO/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=otxy2kwhWBZUtafSCz2sdW9BoB1Iei6FHf/Q8kAtUahAMMizLMjjzV0LO4WqHr0OK
	 LvBMqLHM7ssn9C5YEts+dNDYMawJvALQyuDqnpAYR5GGhLligsX1pJzm3uxojFvslI
	 v51n9358y3BGeynLIs8VTUTmX6FXpW4SObqwc51c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCMQdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:33:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfCMQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:33:09 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7739ECB7;
        Wed, 13 Mar 2019 16:33:07 +0000 (UTC)
Date:   Wed, 13 Mar 2019 09:33:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v6 6/7] mm: Add reserved flag setting to
 set_page_links
Message-Id: <20190313093306.c4b49c6d062f506a967f843d@linux-foundation.org>
In-Reply-To: <4c72a04bb87e341ea7c747d509f42136a99a0716.camel@linux.intel.com>
References: <154361452447.7497.1348692079883153517.stgit@ahduyck-desk1.amr.corp.intel.com>
        <154361479877.7497.2824031260670152276.stgit@ahduyck-desk1.amr.corp.intel.com>
        <20181205172225.GT1286@dhcp22.suse.cz>
        <19c9f0fe83a857d5858c386a08ca2ddeba7cf27b.camel@linux.intel.com>
        <20181205204247.GY1286@dhcp22.suse.cz>
        <20190312150727.cb15cbc323a742e520b9a881@linux-foundation.org>
        <4c72a04bb87e341ea7c747d509f42136a99a0716.camel@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 15:50:36 -0700 Alexander Duyck <alexander.h.duyck@linux.intel.com> wrote:

> On Tue, 2019-03-12 at 15:07 -0700, Andrew Morton wrote:
> > On Wed, 5 Dec 2018 21:42:47 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > > > I got your explanation. However Andrew had already applied the patches
> > > > and I had some outstanding issues in them that needed to be addressed.
> > > > So I thought it best to send out this set of patches with those fixes
> > > > before the code in mm became too stale. I am still working on what to
> > > > do about the Reserved bit, and plan to submit it as a follow-up set.
> > > > From my experience Andrew can drop patches between different versions of
> > > the patchset. Things can change a lot while they are in mmotm and under
> > > the discussion.
> > 
> > It's been a while and everyone has forgotten everything, so I'll drop
> > this version of the patchset.
> > 
> 
> As far as getting to the reserved bit I probably won't have the time in
> the near future. If I were to resubmit the first 4 patches as a
> standalone patch set would that be acceptable, or would they be held up
> as well until the reserved bit issues is addressed?
> 

Yes, I think that merging the first four will be OK.  As long as they
don't add some bug which [5/5] corrects, which happens sometimes!

Please redo, retest and resend sometime?
