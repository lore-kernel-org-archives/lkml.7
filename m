Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9208FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FA3213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553003774;
	bh=8t8/3Cwy38Eu38/Is7aZyv/pQQNZSsCulps/l3FJCok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=psZUMEWGUC+UG9Vhwo98JVWZIkXciSgfy1lP5zP1oTfQBOHdP3rf/BLuUxWZOXNww
	 swcAof7UY3tljLiDmUXspOQbT7ltkygA4lzp5bKkBHjLmqHYf+kliFf5b9gQV3fU0n
	 QdaEWf0znlNCrnl0U7i8M1uYAmwTExpfUmJmOvLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfCSN4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfCSN4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:56:12 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74BDA2085A;
        Tue, 19 Mar 2019 13:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553003772;
        bh=8t8/3Cwy38Eu38/Is7aZyv/pQQNZSsCulps/l3FJCok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBSi7nmTh2q5l7s/1GdaO7rNHZNBWCNV5wUsVTe2jm59Z2d7iPaJpXWcYfh/cGxOQ
         uLBLYco6dlajZ21bDIrrLBNhLi1ZBBwDFEEjISUZHWRHHJPPIXwKrqDn+cX78IyrpB
         dsFTkck6YR73YMbTEtLMSTNE9FKBXNAr1V+U7jtg=
Date:   Tue, 19 Mar 2019 14:56:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Colin Ian King <colin.king@canonical.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: u132-hcd: fix potential NULL pointer dereference
Message-ID: <20190319135609.GA16254@kroah.com>
References: <20190314072713.20666-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314072713.20666-1-kjlu@umn.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 02:27:11AM -0500, Kangjie Lu wrote:
> In case create_singlethread_workqueue fails, the fix notifies
> callers the error to avoid potential NULL pointer dereferences.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/usb/host/u132-hcd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
> index 934584f0a20a..6d5b532b03f8 100644
> --- a/drivers/usb/host/u132-hcd.c
> +++ b/drivers/usb/host/u132-hcd.c
> @@ -3203,6 +3203,8 @@ static int __init u132_hcd_init(void)
>  		return -ENODEV;
>  	printk(KERN_INFO "driver %s\n", hcd_name);
>  	workqueue = create_singlethread_workqueue("u132");
> +	if (unlikely(!workqueue))

You only ever use unlikely/likely if you can actually measure the
difference with and without it.  For stuff like this, it is not needed
at all, and in fact, the compiler and CPU already know this type of
thing, so it is going to be faster without it.

And are you sure you properly unwound from anything that was
created/initialized above these lines?

thanks,

greg k-h
