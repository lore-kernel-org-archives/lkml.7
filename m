Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B49C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D6D2070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgAHKKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:10:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:52442 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgAHKKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:10:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 02:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,409,1571727600"; 
   d="scan'208";a="395696582"
Received: from jochenh-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.51.76])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2020 02:10:06 -0800
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id B38A021EDA; Wed,  8 Jan 2020 12:10:04 +0200 (EET)
Date:   Wed, 8 Jan 2020 12:10:04 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+54fd8cca4b7226c94b8e@syzkaller.appspotmail.com,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Vandana BN <bnvandana@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-core: only zero-out ioctl-read buffers
Message-ID: <20200108101004.GC4383@kekkonen.localdomain>
References: <20200108100013.284108-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108100013.284108-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 11:00:00AM +0100, Arnd Bergmann wrote:
> The memset() got moved out of the check for _IOC_NONE, so passing a
> made-up command number with a size but no direction would allow clearing
> data on user-provided pointers.
> 
> Move video_get_user() back into the _IOC_NONE check where it belongs.
> 
> Reported-by: syzbot+54fd8cca4b7226c94b8e@syzkaller.appspotmail.com
> Fixes: 6c625c01c7a6 ("media: v4l2-core: split out data copy from video_usercopy")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fix, Arnd!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index b0d670715c27..0f11fc6b5447 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -3208,12 +3208,12 @@ video_usercopy(struct file *file, unsigned int orig_cmd, unsigned long arg,
>  			parg = mbuf;
>  		}
>  
> +		err = video_get_user((void __user *)arg, parg, orig_cmd,
> +				     &always_copy);
> +		if (err)
> +			goto out;
>  	}
>  
> -	err = video_get_user((void __user *)arg, parg, orig_cmd, &always_copy);
> -	if (err)
> -		goto out;
> -
>  	err = check_array_args(cmd, parg, &array_size, &user_ptr, &kernel_ptr);
>  	if (err < 0)
>  		goto out;

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
