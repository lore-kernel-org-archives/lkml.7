Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD00EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA3C216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfEUJHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:07:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:46038 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726391AbfEUJHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:07:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42ADAAD43;
        Tue, 21 May 2019 09:07:35 +0000 (UTC)
Message-ID: <1558428877.12672.8.camel@suse.com>
Subject: Re: [RFC PATCH] usb: host: xhci: allow __GFP_FS in dma allocation
From:   Oliver Neukum <oneukum@suse.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Jaewon Kim <jaewon31.kim@gmail.com>, linux-mm@kvack.org,
        gregkh@linuxfoundation.org, Jaewon Kim <jaewon31.kim@samsung.com>,
        m.szyprowski@samsung.com, ytk.lee@samsung.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Tue, 21 May 2019 10:54:37 +0200
In-Reply-To: <20190520142331.GA12108@infradead.org>
References: <20190520101206.GA9291@infradead.org>
         <Pine.LNX.4.44L0.1905201011490.1498-100000@iolanthe.rowland.org>
         <20190520142331.GA12108@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2019-05-20 at 07:23 -0700, Christoph Hellwig wrote:
> On Mon, May 20, 2019 at 10:16:57AM -0400, Alan Stern wrote:
> > What if the allocation requires the kernel to swap some old pages out 
> > to the backing store, but the backing store is on the device that the 
> > driver is managing?  The swap can't take place until the current I/O 
> > operation is complete (assuming the driver can handle only one I/O 
> > operation at a time), and the current operation can't complete until 
> > the old pages are swapped out.  Result: deadlock.
> > 
> > Isn't that the whole reason for using GFP_NOIO in the first place?
> 
> It is, or rather was.  As it has been incredibly painful to wire
> up the gfp_t argument through some callstacks, most notably the
> vmalloc allocator which is used by a lot of the DMA allocators on
> non-coherent platforms, we now have the memalloc_noio_save and
> memalloc_nofs_save functions that mark a thread as not beeing to
> go into I/O / FS reclaim.  So even if you use GFP_KERNEL you will
> not dip into reclaim with those flags set on the thread.

OK, but this leaves a question open. Will the GFP_NOIO actually
hurt, if it is used after memalloc_noio_save()?

	Regards
		Oliver

