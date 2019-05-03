Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250E5C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA61E20651
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556900370;
	bh=JoLFU7iDBV8L5oJ3OWC2XGELDtG5GJ9xh1fgSc9znCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I+nxWiHz8wy1YkEiTMhbM6l6oBdxpBuzlDhU1yJ5ZbiF5PJuxEf73kezTUoeO3T2o
	 pkEtdkWVG1BUZyrcM1EGAI1a8XgvJdD0RtjTu7FrhM3+1pA652iHybCol4pLqd7Wxw
	 canWZWksEpTILX/IYL7QmnWcZNsgyZyAPoRol/iQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfECQT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfECQT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:19:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A87020651;
        Fri,  3 May 2019 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556900367;
        bh=JoLFU7iDBV8L5oJ3OWC2XGELDtG5GJ9xh1fgSc9znCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Du0j3HiToZFoUZADuqZVQ1kNtR/OAIm8C20dzs2z78XT8dD2B+U+LNhcaxZc7gu8X
         hFQZ4IR46rWPqYXNuBUxNoZYa5i9SQiMu9ThvlQs0OQEGynKJnvdePQFa+jxwTiuFa
         4lRSSs3AG3UiW0lpOtyodU2h+fFckIvJ9YjpOjGc=
Date:   Fri, 3 May 2019 18:19:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 19/22] intel_th: msu: Introduce buffer driver interface
Message-ID: <20190503161924.GA1046@kroah.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
 <20190503084455.23436-20-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503084455.23436-20-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 11:44:52AM +0300, Alexander Shishkin wrote:
> Introduces a concept of buffer drivers, which is a mechanism for creating
> trace sinks that would receive trace data from MSC buffers and transfer it
> elsewhere.
> 
> A buffer driver can implement its own window allocation/deallocation if
> it has to. It must provide a callback that's used to notify it when a
> window fills up, so that it can then start a DMA transaction from that
> window 'elsewhere'. This window remains in a 'locked' state and won't be
> used for storing new trace data until the buffer driver 'unlocks' it with
> a provided API call, at which point the window can be used again for
> storing trace data.
> 
> This relies on a functional "last block" interrupt, so not all versions of
> Trace Hub can use this feature.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---

Why is no one else reviewing any of these patches at all?  Are you
relying on me to do that?

I'll stop here on this patch series, I've applied all but one before
this, but don't have the time to properly review this one, especially so
late before the merge window closes (really, my tree should be closed
already.)

Please fix up the 2 I responded to, and get other people to review these
patches _before_ you ask me to merge them.  Having code with no other
reviewer at all is not good at all.

thanks,

greg k-h
