Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87ADC46470
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831EC21872
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfEVGbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 02:31:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:43612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbfEVGbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 02:31:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B08E1B01F;
        Wed, 22 May 2019 06:31:44 +0000 (UTC)
Message-ID: <1558506702.12672.28.camel@suse.com>
Subject: Re: [RFC PATCH] usb: host: xhci: allow __GFP_FS in dma allocation
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jaewon Kim <jaewon31.kim@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        gregkh@linuxfoundation.org, Jaewon Kim <jaewon31.kim@samsung.com>,
        m.szyprowski@samsung.com, ytk.lee@samsung.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Wed, 22 May 2019 08:31:42 +0200
In-Reply-To: <Pine.LNX.4.44L0.1905210950170.1634-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1905210950170.1634-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2019-05-21 at 10:00 -0400, Alan Stern wrote:
> 
> Changing configurations amounts to much the same as disconnecting,
> because both operations destroy all the existing interfaces.
> 
> Disconnect can arise in two different ways.
> 
>         Physical hot-unplug: All I/O operations will fail.
> 
>         Rmmod or unbind: I/O operations will succeed.
> 
> The second case is probably okay.  The first we can do nothing about.  
> However, in either case we do need to make sure that memory allocations
> do not require any writebacks.  This suggests that we need to call
> memalloc_noio_save() from within usb_unbind_interface().

I agree with the problem, but I fail to see why this issue would be
specific to USB. Shouldn't this be done in the device core layer?

	Regards
		Oliver

