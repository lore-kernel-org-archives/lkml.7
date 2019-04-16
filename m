Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2B7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC95E2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555414004;
	bh=gkDHdtUZw4LIZmkCFR8CKDA+uD3WfNPB8qcrYtx5X3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EXJx95Gt97mpDFcQKqmtt9zIvAwLZ+fTV2tnWrxSEC/PXKdJcLSTM1RLJjx+cNqUc
	 hirqS+kTJYNuXLl0TJLp9KjA5W9GQUilJ5SMcmVapt17RF9w7JFsQJv+9y4rl2XiX2
	 0QCIncOXXq5vwUnebfixMNcIzXJYjiNFIzbSNH9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfDPL0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:26:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35578 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfDPL0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:26:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id j20so2845011lfh.2;
        Tue, 16 Apr 2019 04:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJKHZpxwRQsFB5n0MhL4GKkRlf428UhyO+u00MshSV8=;
        b=FKO9u9scV+8ZfRDLnQYBixpDm1B1e3qWapPfLlJ734ZzsxdbwbgTVkrDV4MiUJsLR4
         OtcgIpcEzOTk6M3XHHOYvoDmpdO1LfaKVLExf1wUaPJ5X001zIlVzHK5YnEwY9nmM2f7
         cniE6k4183DovGp7nHXM3Gn7Ek86yWcnocCGOU2rqzE6JM9aTSkUlQ/quUQW7zGn+N9V
         9axVXK8ct//70EC+wrC62GFA0FjxT4A7CVQNRCy0wB2+34EjilmavNgxMsV4x1uzAEQu
         ZyIYbi66MwqrGCzl79LHRsonHzYrdmkpPh+e/sOYsL1Fin+HIGch5UqCMDUq/v1e6G5/
         b9Lg==
X-Gm-Message-State: APjAAAX8GurwGt+gSPywRl/tpCva3uJ36LUuEW+uB1A5zrprFXULYbuU
        JaHreMHGbv1SnGWaHp52pSY=
X-Google-Smtp-Source: APXvYqxWZCARybrme3NTxtAyTyCXhPJuPWGzMuQBfgX3z7SL0RhOgmInP2brmoCwIk/0nm3rv+5h2Q==
X-Received: by 2002:ac2:482e:: with SMTP id 14mr24096972lft.1.1555414000929;
        Tue, 16 Apr 2019 04:26:40 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id i24sm10305641ljb.31.2019.04.16.04.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 04:26:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hGMEf-0006wi-M2; Tue, 16 Apr 2019 13:26:45 +0200
Date:   Tue, 16 Apr 2019 13:26:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Young Xiao <92siuyang@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, mchehab@kernel.org,
        keescook@chromium.org, hans.verkuil@cisco.com,
        Young Xiao <YangX92@hotmail.com>
Subject: Re: [PATCH] USB: s2255 & stkwebcam: fix oops with malicious USB
 descriptors
Message-ID: <20190416112645.GI775@localhost>
References: <1554958452-29794-1-git-send-email-92siuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554958452-29794-1-git-send-email-92siuyang@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 12:54:12PM +0800, Young Xiao wrote:
> From: Young Xiao <YangX92@hotmail.com>
> 
> The driver expects at least one valid endpoint. If given
> malicious descriptors that specify 0 for the number of endpoints,
> it will crash in the probe function.  Ensure there is at least
> one endpoint on the interface before using it.

Why do claim it will crash?

> This vulnerability is same as CVE-2016-2188.

Note that the "fix" for this CVE that you're now copying was incomplete.
Here's the proper fix:

	b7321e81fc36 ("USB: iowarrior: fix NULL-deref at probe")

> Signed-off-by: Young Xiao <YangX92@hotmail.com>
> ---
>  drivers/media/usb/s2255/s2255drv.c       | 7 +++++++
>  drivers/media/usb/stkwebcam/stk-webcam.c | 6 ++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/media/usb/s2255/s2255drv.c b/drivers/media/usb/s2255/s2255drv.c
> index 5b3e54b..7fdf159 100644
> --- a/drivers/media/usb/s2255/s2255drv.c
> +++ b/drivers/media/usb/s2255/s2255drv.c
> @@ -2263,6 +2263,13 @@ static int s2255_probe(struct usb_interface *interface,
>  	iface_desc = interface->cur_altsetting;
>  	dev_dbg(&interface->dev, "num EP: %d\n",
>  		iface_desc->desc.bNumEndpoints);
> +
> +	if (iface_desc->desc.bNumEndpoints < 1) {
> +		dev_err(&interface->dev, "Invalid number of endpoints\n");
> +		retval = -EINVAL;
> +		goto error;
> +	}
> +
>  	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {

Besides that you didn't even bother compile-testing this, there is no
bug here to fix to begin with.

If bNumEndpoints is zero this loop will execute and the driver bails out
just after since dev->read_endpoint is NULL.

>  		endpoint = &iface_desc->endpoint[i].desc;
>  		if (!dev->read_endpoint && usb_endpoint_is_bulk_in(endpoint)) {
> diff --git a/drivers/media/usb/stkwebcam/stk-webcam.c b/drivers/media/usb/stkwebcam/stk-webcam.c
> index 8f54586..d2a4785 100644
> --- a/drivers/media/usb/stkwebcam/stk-webcam.c
> +++ b/drivers/media/usb/stkwebcam/stk-webcam.c
> @@ -1350,6 +1350,12 @@ static int stk_camera_probe(struct usb_interface *interface,
>  	 * for the current alternate setting */
>  	iface_desc = interface->cur_altsetting;
>  
> +	if (iface_desc->desc.bNumEndpoints < 1) {
> +		dev_err(&interface->dev, "Invalid number of endpoints\n");
> +		retval = -EINVAL;
> +		goto error;
> +	}
> +
>  	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {

Same here.

>  		endpoint = &iface_desc->endpoint[i].desc;

Johan
