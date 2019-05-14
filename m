Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A00C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6434C20578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557872493;
	bh=urgi78rPUjXn9pegDohx5SQ8ZIKrCsM2b9ZQKT/c5Hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s7Jfzppm2l6QjQZxlIH0O8K1o6eLlP9O1dAD1L8NJava07lFwZpEysS4vy4Lc8gGQ
	 bBXAWkpEvE2lbuM81zReY+ux6+ion916cduTUAKpjwPYmcKvtmSHSWEWLx83p5e5xf
	 qKG6sGrjQM0pL8KnfwgAVg+Cwt3+6PZBwzFdbVv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfENWVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:21:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:1878 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfENWVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:21:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 15:21:29 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 14 May 2019 15:21:28 -0700
Date:   Tue, 14 May 2019 16:16:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190514221609.GC19977@localhost.localdomain>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143741.GA25500@lst.de>
 <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
 <20190513145522.GA15421@localhost.localdomain>
 <d69ff7154191492eaa8f55535a7effa5@AUSX13MPC105.AMER.DELL.COM>
 <20190513150458.GA15437@localhost.localdomain>
 <CAJZ5v0g3cCYK3rAQn09pCr7LMrRr=zQy_ceaEB5AKhVx604YgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g3cCYK3rAQn09pCr7LMrRr=zQy_ceaEB5AKhVx604YgA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 10:04:22AM +0200, Rafael J. Wysocki wrote:
> On Mon, May 13, 2019 at 5:10 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Mon, May 13, 2019 at 03:05:42PM +0000, Mario.Limonciello@dell.com wrote:
> > > This system power state - suspend to idle is going to freeze threads.
> > > But we're talking a multi threaded kernel.  Can't there be a timing problem going
> > > on then too?  With a disk flush being active in one task and the other task trying
> > > to put the disk into the deepest power state.  If you don't freeze the queues how
> > > can you guarantee that didn't happen?
> >
> > But if an active data flush task is running, then we're not idle and
> > shouldn't go to low power.
> 
> To be entirely precise, system suspend prevents user space from
> running while it is in progress.  It doesn't do that to kernel
> threads, at least not by default, though, so if there is a kernel
> thread flushing the data, it needs to be stopped or suspended somehow
> directly in the system suspend path.  [And yes, system suspend (or
> hibernation) may take place at any time so long as all user space can
> be prevented from running then (by means of the tasks freezer).]
> 
> However, freezing the queues from a driver ->suspend callback doesn't
> help in general and the reason why is hibernation.  Roughly speaking,
> hibernation works in two steps, the first of which creates a snapshot
> image of system memory and the second one writes that image to
> persistent storage.  Devices are resumed between the two steps in
> order to make it possible to do the write, but that would unfreeze the
> queues and let the data flusher run.  If it runs, it may cause the
> memory snapshot image that has just been created to become outdated
> and restoring the system memory contents from that image going forward
> may cause corruption to occur.
> 
> Thus freezing the queues from a driver ->suspend callback should not
> be relied on for correctness if the same callback is used for system
> suspend and hibernation, which is the case here.  If doing that
> prevents the system from crashing, it is critical to find out why IMO,
> as that may very well indicate a broader issue, not necessarily in the
> driver itself.
> 
> But note that even if the device turns out to behave oddly, it still
> needs to be handled, unless it may be prevented from shipping to users
> in that shape.  If it ships, users will face the odd behavior anyway.

Thanks for all the information. I'll take another shot at this, should
have it posted tomorrow.

It's mostly not a problem to ensure enqueued and dispatched requests are
completed before returning from our suspend callback. I originally had
that behavior and backed it out when I thought it wasn't necessary. So
I'll reintroduce that. I'm not sure yet how we may handle kernel tasks
that are about to read/write pages, but haven't yet enqueued their
requests.

IO timeouts, shold they occur, have some problems here, so I'll need to
send prep patches to address a few issues with that.
