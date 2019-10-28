Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85826CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EFE21744
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572277028;
	bh=g38VoI5LJrASchwjNi5RYmGYL3WYNwPkOBYh7bPUb0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DMQ/6bCAWtm5ebz/5K9YEDpLsGjD3uGvt1Ym1zxb606rZeSd2Q/R7EoPWJM7BZDhB
	 b/0B+kiRXnMbu2Y6GYbkAmftFh/kbuw9cDwbyYVr58nXAXiLPYD8DDW58zJdU9MTSH
	 7NC+0+vsabURWfQhWDQWXkOKu2THUAoFd3iv/FVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbfJ1PhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfJ1PhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:37:06 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1B3520578;
        Mon, 28 Oct 2019 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572277026;
        bh=g38VoI5LJrASchwjNi5RYmGYL3WYNwPkOBYh7bPUb0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5r3BrfQocbPBwDmaCn9MKFT3W2EIB4MOStdx0SbBZnhjQxU2GHUBKULWWAFmWjsh
         NsF0fy2NObcHK1HCgor/E5h9mWr0eI4WSNx9MgbyTbULxXNR1uC6AWntxV4/xcPwpE
         GeK6HaAVVJyabCZHsCWszG3TW3RY04zrY8bpkhJQ=
Date:   Mon, 28 Oct 2019 16:37:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Stefan Wahren <wahrenst@gmx.net>, eric@anholt.net,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: vc04_services: replace g_free_fragments_mutex
 with spinlock
Message-ID: <20191028153704.GA134005@kroah.com>
References: <20191027221530.12080-1-dave@stgolabs.net>
 <576df522-f012-9dd1-9dcc-b7e444e82ac6@gmx.net>
 <20191028152108.bjliafudxn3llysv@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028152108.bjliafudxn3llysv@linux-p48b>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 08:21:08AM -0700, Davidlohr Bueso wrote:
> On Mon, 28 Oct 2019, Stefan Wahren wrote:
> 
> > Hi Davidlohr,
> > 
> > Am 27.10.19 um 23:15 schrieb Davidlohr Bueso:
> > > There seems no need to be using a semaphore, or a sleeping lock
> > > in the first place: critical region is extremely short, does not
> > > call into any blocking calls and furthermore lock and unlocking
> > > operations occur in the same context.
> > > 
> > > Get rid of another semaphore user by replacing it with a spinlock.
> > > 
> > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > > ---
> > > This is in an effort to further reduce semaphore users in the kernel.
> > > 
> > thanks for this. Could please also send this to devel@driverdev.osuosl.org?
> 
> Ccing.

I don't see a patch here :(

