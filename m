Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8937C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC552085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561012453;
	bh=Ho986ZwEwN6lSqW02CRO5TRKTGH2igmUfY7a/ULtRRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d1a+fmXnulumlmmo8YXLMyo7y33Q4Y2AglRwct1G7uy0c6+Z2+aiBFrHRCR5IVqym
	 Tl8uQSzT4ZxvFCSKhdxQEwZxssq3YH+ezezwYbKPxqKtdLf2Ld2oizFDpfx0+5OarO
	 Wgfh3g+7AXKRonPQrCwpRs/GQbvKJrHCNibD4vGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfFTGeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfFTGeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:34:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515C62070B;
        Thu, 20 Jun 2019 06:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561012450;
        bh=Ho986ZwEwN6lSqW02CRO5TRKTGH2igmUfY7a/ULtRRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFM3+3jhB60zvG/6yB5IE5B3Rx+VKwvPqzhLzTvAMHSgLqGN5c7UT/x7JJ1TuJGVF
         lVevF4s7TKlP8/Hj+yX54QMnBdPlf/MMKzNcCIdDbj9TeGMDC6DOu+5ILxmtYZrzRg
         godWZUUe0caVwlu6le/5vxZ5bW96eLKozu4FLnhk=
Date:   Thu, 20 Jun 2019 08:34:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] driver-core, libnvdimm: Let device subsystems add
 local lockdep coverage
Message-ID: <20190620063408.GA4768@kroah.com>
References: <156029554317.419799.1324389595953183385.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156029557585.419799.11741877483838451695.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4h8QZBAC4kY3=mJVq0J8-W3aTLoT6h2b0WXFtymzToH-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h8QZBAC4kY3=mJVq0J8-W3aTLoT6h2b0WXFtymzToH-Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 03:21:58PM -0700, Dan Williams wrote:
> On Tue, Jun 11, 2019 at 4:40 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > For good reason, the standard device_lock() is marked
> > lockdep_set_novalidate_class() because there is simply no sane way to
> > describe the myriad ways the device_lock() ordered with other locks.
> > However, that leaves subsystems that know their own local device_lock()
> > ordering rules to find lock ordering mistakes manually. Instead,
> > introduce an optional / additional lockdep-enabled lock that a subsystem
> > can acquire in all the same paths that the device_lock() is acquired.
> >
> > A conversion of the NFIT driver and NVDIMM subsystem to a
> > lockdep-validate device_lock() scheme is included. The
> > debug_nvdimm_lock() implementation implements the correct lock-class and
> > stacking order for the libnvdimm device topology hierarchy.
> 
> Greg, Peter,
> 
> Any thoughts on carrying this debug hack upstream? The idea being that
> it's impossible to enable lockdep for the device_lock() globally, but
> a constrained usage of the proposed lockdep_mutex has proven enough to
> flush out device_lock deadlocks from libnvdimm.
> 
> It appears one aspect that is missing from this patch proposal is a
> mechanism / convention to make sure that lockdep_mutex has constrained
> usage for a given kernel build, otherwise it's obviously just as
> problematic as device_lock(). Other concerns?

Yeah, it feels a bit hacky but it's really up to a subsystem to mess up
using it as much as anything else, so user beware :)

I don't object to it if it makes things easier for you to debug.

thanks,

greg k-h
