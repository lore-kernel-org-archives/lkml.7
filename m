Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792AFECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CC3214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570806411;
	bh=6u22eQMxqkrsYk72ZwygUnfNpqOnzMaqtO/hpkzgc8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EtgnkrNgIStNmNQEZM2gFdMU6tPjqhRncTsNtx8EZkPjKV+za7f+5VxdYRgaRDKRq
	 R29aswNTH8ZNPuL7i4Fm26CRbMBteXxcdeF1mIqBjyNJTLCV2ydlYsh2/lryExyLBC
	 OsLt7fQmlx/FW2cSVplb/D/FZ1WFxA/Hw07KPJXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfJKPGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfJKPGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:06:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73948206CD;
        Fri, 11 Oct 2019 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570806409;
        bh=6u22eQMxqkrsYk72ZwygUnfNpqOnzMaqtO/hpkzgc8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfj56F35BeBeTrdkFO1TJu+G+xclftJXP4w4kK9upDLZRbPSLicd41mwki/Hg83QN
         O4i4TaJuwCW3ss0Y8vLI+1XUroo2bhG3bJrFsc0msSE2EgzGAFz5h84D4vlqpRwFDi
         TaC4qIJ6XesoFJkISOqyIomFVrooVe45EL00i82I=
Date:   Fri, 11 Oct 2019 17:06:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>,
        syzbot <syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        usb-storage@lists.one-eyed-alien.net
Subject: Re: KMSAN: uninit-value in alauda_check_media
Message-ID: <20191011150646.GA1240544@kroah.com>
References: <CAAeHK+zR=S1cyaYfehyUDrpMGMXvxgLEeS8V2ze2HkwYUp6bjg@mail.gmail.com>
 <Pine.LNX.4.44L0.1910111039380.1529-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1910111039380.1529-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:53:47AM -0400, Alan Stern wrote:
> On Fri, 11 Oct 2019, Andrey Konovalov wrote:
> 
> > On Fri, Oct 11, 2019 at 4:08 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > > Now yes, it's true that defining status as an array on the stack is
> > > also a bug, since USB transfer buffers are not allowed to be stack
> > > variables.
> > 
> > Hi Alan,
> > 
> > I'm curious, what is the reason for disallowing that? Should we try to
> > somehow detect such cases automatically?
> 
> Transfer buffers are read and written by DMA.  On systems that don't
> have cache-coherent DMA controllers, it is essential that the CPU does
> not access any cache line involved in a DMA transfer while the transfer
> is in progress.  Otherwise the data in the cache would be different
> from the data in the buffer, leading to corruption.
> 
> (In theory it would be okay for the CPU to read (not write!) a cache
> line assigned to a buffer for a DMA write (not read!) transfer.  But
> even doing that isn't really a good idea.)
> 
> (Also, this isn't an issue for x86 architectures, because x86 has 
> cache-coherent DMA.  But it is an issue on other architectures.)
> 
> In practice, this means transfer buffers have to be allocated by
> something like kmalloc, so that they occupies their own separate set of
> cache lines.  Buffers on the stack obviously don't satisfy this
> requirement.
> 
> At some point there was a discussion about automatically detecting when
> on-stack (or otherwise invalid) buffers are used for DMA transfers.  I
> don't recall what the outcome was.

A patchset from Kees was sent, but it needs a bit more work...

thanks,

greg k-h
