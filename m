Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951A3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C28D20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553575302;
	bh=2UbsMec4t6f/gWj570PXzvxsXJv60gSbpI+Vkbmho5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ktmNpgqqw7+U58mPUQn/H/K71CiMflDDoyUjQ2krU/O2t+VdzdPSa5DFwXMYEbp6X
	 m3fO96JEyIqojBDt0Oem1nhcPVtfRNi4mUJF+vudx/avIKM7B/tu/XUv8iUpg7GDMI
	 /kCTl/uU2fslFL9ir8OeapvN3G9FLmye8CZT3isU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfCZEll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 00:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfCZElk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 00:41:40 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDB4A20857;
        Tue, 26 Mar 2019 04:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553575300;
        bh=2UbsMec4t6f/gWj570PXzvxsXJv60gSbpI+Vkbmho5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzLPQL4qJ3F2ZROD/MnRU2GCRhy9yiGR9R/0EGXB6wob2L+dbri84t5UMrnGeVJ4x
         MqWkxXPHV6OOVEh6aw7Fc82xg6me4M1AXwJ1ZLR+AQPe70lJLBhKbol0VagED+Qgsj
         Q8AVvnxcJK592kazRxRDQK8JfweDj5jnOGgKSUp8=
Date:   Tue, 26 Mar 2019 13:41:32 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Colin Ian King <colin.king@canonical.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: u132-hcd: fix potential NULL pointer dereference
Message-ID: <20190326044132.GA19677@kroah.com>
References: <20190319135609.GA16254@kroah.com>
 <20190319173407.7279-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319173407.7279-1-kjlu@umn.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:34:06PM -0500, Kangjie Lu wrote:
> In case create_singlethread_workqueue fails, the fix notifies
> callers the error to avoid potential NULL pointer dereferences.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> removed "unlikely"
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
> +	if (!workqueue)
> +		return -ENOMEM;
>  	retval = platform_driver_register(&u132_platform_driver);
>  	return retval;

if platform_driver_register() fails, shouldn't you clean up the
workqueue?  That can be a separate patch, that's not your fault here :)

thanks,

greg k-h
