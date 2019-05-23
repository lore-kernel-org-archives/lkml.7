Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2157C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C148E21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfEWMpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:45:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:37712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730028AbfEWMpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:45:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 645D9AD78;
        Thu, 23 May 2019 12:45:09 +0000 (UTC)
Message-ID: <1558614729.3994.5.camel@suse.com>
Subject: Re: [RFC PATCH] usb: host: xhci: allow __GFP_FS in dma allocation
From:   Oliver Neukum <oneukum@suse.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jaewon Kim <jaewon31.kim@gmail.com>
Cc:     linux-mm@kvack.org, gregkh@linuxfoundation.org,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        m.szyprowski@samsung.com, ytk.lee@samsung.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Thu, 23 May 2019 14:32:09 +0200
In-Reply-To: <20190520055657.GA31866@infradead.org>
References: <CAJrd-UuMRdWHky4gkmiR0QYozfXW0O35Ohv6mJPFx2TLa8hRKg@mail.gmail.com>
         <20190520055657.GA31866@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On So, 2019-05-19 at 22:56 -0700, Christoph Hellwig wrote:
> Folks, you can't just pass arbitary GFP_ flags to dma allocation
> routines, beause very often they are not just wrappers around
> the page allocator.
> 
> So no, you can't just fine grained control the flags, but the
> existing code is just as buggy.
> 
> Please switch to use memalloc_noio_save() instead.

Thinking about this again, we have a problem. We introduced
memalloc_noio_save() in 3.10 . Hence the code should have been
correct in v4.14. Which means that either
6518202970c1 "(mm/cma: remove unsupported gfp_mask
parameter from cma_alloc()"
is buggy, or the original issue with a delay of 2 seconds
still exist.

Do we need to do something?

	Regards
		Oliver

