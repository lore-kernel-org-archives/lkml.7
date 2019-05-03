Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CDAC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276902075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556885897;
	bh=6C13agQQJZ6WPf1glwUhHqV74hbe32pXiP2g3Pw2vLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uiCBy6moJYgC3nV9zQ0/2Ys1BYmdtk7esq35YBjPTF8AIaSNSF414XeflzwMFp3Kv
	 mJVFH64OEGlICRTvHpBHR167oSGHSK/z+AuyRQn7QnN7K4l+FsCaSJ+d6sIMDWltTO
	 16YcIyfNSPw7IjOWlZqmt77twG8OryVKkE6RMF60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfECMSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 08:18:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:42015 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfECMSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:18:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 05:18:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="167227563"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 03 May 2019 05:18:14 -0700
Date:   Fri, 3 May 2019 06:12:32 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 0/4] nvme-pci: support device coredump
Message-ID: <20190503121232.GB30013@localhost.localdomain>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <20190502125722.GA28470@localhost.localdomain>
 <CAC5umygdADGrYeJy=F53Mm4bNPHmo+WY4SD3HFSRqi_cLrz9jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umygdADGrYeJy=F53Mm4bNPHmo+WY4SD3HFSRqi_cLrz9jw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 12:38:08PM +0900, Akinobu Mita wrote:
> 2019年5月2日(木) 22:03 Keith Busch <keith.busch@intel.com>:
> > On Thu, May 02, 2019 at 05:59:17PM +0900, Akinobu Mita wrote:
> > > This enables to capture snapshot of controller information via device
> > > coredump machanism, and it helps diagnose and debug issues.
> > >
> > > The nvme device coredump is triggered before resetting the controller
> > > caused by I/O timeout, and creates the following coredump files.
> > >
> > > - regs: NVMe controller registers, including each I/O queue doorbell
> > >         registers, in nvme-show-regs style text format.
> >
> > You're supposed to treat queue doorbells as write-only. Spec says:
> >
> >   The host should not read the doorbell registers. If a doorbell register
> >   is read, the value returned is vendor specific.
> 
> OK.  I'll exclude the doorbell registers from register dump.  It will work
> out without the information if we have snapshot of the queues.

Could you actually explain how the rest is useful? I personally have
never encountered an issue where knowing these values would have helped:
every device timeout always needed device specific internal firmware
logs in my experience.
