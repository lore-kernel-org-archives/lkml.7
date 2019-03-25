Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB387C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A5D206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/xPROsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfCYWmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:42:52 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39182 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCYWmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:42:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id n187so5570762oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5OFLov40SjcOFf8ikH4ygZSvxIh5UYiZDeBcFjKYxfM=;
        b=q/xPROsWzL2GjriYp/aFN5140twjUOq3B6jWkS4Pekj4X2BlCheNhMVtohclfUi74y
         SijuPOZYqi1hTio3tIX0GQRLB4ahich28M5Hoi7jcsq9SBZomLFuhVnUpmpI4GdNz62b
         BS2y2fC+c6iuHai9cVXJcz24w+5wszWhz1MruW1EyrTqFMgO81+VDeW50GDx1jI3XBW7
         9QPvwiMzEd4g11M5w3Jk/kDX0schhNAI/osPT8+XYFV2HNxG678Auk99JQ9+nAv8hC+q
         Xve5T4YxrZcxUKPkVttMBY+HSbstsgJNjsnw/ma54QHrjNe11Q6Y55EYHsDKfLPBSVXU
         KiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5OFLov40SjcOFf8ikH4ygZSvxIh5UYiZDeBcFjKYxfM=;
        b=bgPPR8Yhp0ENASHk8yhv0Bpx+gMYbi9gmGSRknuxN5uRtm1LkkCbLjR5fgZ6zsz08Y
         iA6Zr0eudXzk1PqJ97ZhvlpOF8t5jFh4V7GQxi3jSyLkjHjCdEPTPGnyEvN888YFz/Ys
         Ae1tPLEGtVjDhoGvFMn4ZCZX1DrSSWkYa4Vb5uyTUcquCkmhm/y3UbdW6Pk8RdCQ5hpi
         qMx1gxJ/sQMFHioPERyA6eBOte+i/OyhjYwRaSfAi3+GNAf2Ad8xmPpgAN6Y0eSQ3Jz9
         L2/T/VCk8KUY3Z9Xo037C4tkS/oB+a/LRCR/vwY9lBf/lNMtyuAwwmXD2o7/AjEscNG7
         NyQQ==
X-Gm-Message-State: APjAAAVDqtxCiN3QXtWlb/QxiApSZFNxV2IuVxLUqsCKNxStsySmltsA
        l/MsgldTg8hUUXu1akvpk1k=
X-Google-Smtp-Source: APXvYqzJWbCO+mOrtR3yi/QpqiM6osKg0lUeyr7fImXXaB6P9to2JfRhhYuoviiRSXJQ3lVFIXlW/A==
X-Received: by 2002:aca:390a:: with SMTP id g10mr13578879oia.4.1553553771321;
        Mon, 25 Mar 2019 15:42:51 -0700 (PDT)
Received: from griffin ([177.234.13.170])
        by smtp.gmail.com with ESMTPSA id o18sm2415258otp.65.2019.03.25.15.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 15:42:50 -0700 (PDT)
Date:   Mon, 25 Mar 2019 16:42:48 -0600
From:   =?utf-8?B?SmVzw7pz?= Castro <x51v4n@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     miguel.bernal@zapopan.tecmm.edu.mx, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] hv: utils: enhance code for human read
Message-ID: <20190325224246.GA1697@griffin>
References: <20190305234542.5243-1-x51v4n@gmail.com>
 <20190312002949.4937-1-x51v4n@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190312002949.4937-1-x51v4n@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 06:29:49PM -0600, Jesús Castro wrote:
> The if/else block from hvt_op_open function can be written
> as a switch/case block,  and the bool issue_reset variable
> is avoided.
> 
> No functional change made.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Jesús Castro <x51v4n@gmail.com>
> ---
> 
> v2: Refactoring hvt_op_open function with a switch/case block.
>     Change subject from: fix coding style
> 
	ping?

>  drivers/hv/hv_utils_transport.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hv/hv_utils_transport.c b/drivers/hv/hv_utils_transport.c
> index 832777527936..6b27dd7be9bb 100644
> --- a/drivers/hv/hv_utils_transport.c
> +++ b/drivers/hv/hv_utils_transport.c
> @@ -125,35 +125,35 @@ static int hvt_op_open(struct inode *inode, struct file *file)
>  {
>  	struct hvutil_transport *hvt;
>  	int ret = 0;
> -	bool issue_reset = false;
>  
>  	hvt = container_of(file->f_op, struct hvutil_transport, fops);
>  
>  	mutex_lock(&hvt->lock);
>  
> -	if (hvt->mode == HVUTIL_TRANSPORT_DESTROY) {
> -		ret = -EBADF;
> -	} else if (hvt->mode == HVUTIL_TRANSPORT_INIT) {
> +	switch (hvt->mode) {
> +	case HVUTIL_TRANSPORT_INIT:
>  		/*
>  		 * Switching to CHARDEV mode. We switch bach to INIT when
>  		 * device gets released.
>  		 */
>  		hvt->mode = HVUTIL_TRANSPORT_CHARDEV;
> -	}
> -	else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
> +		break;
> +	case HVUTIL_TRANSPORT_NETLINK:
>  		/*
>  		 * We're switching from netlink communication to using char
>  		 * device. Issue the reset first.
>  		 */
> -		issue_reset = true;
>  		hvt->mode = HVUTIL_TRANSPORT_CHARDEV;
> -	} else {
> +		hvt_reset(hvt);
> +		break;
> +	case HVUTIL_TRANSPORT_DESTROY:
> +		ret = -EBADF;
> +		break;
> +	default:
>  		ret = -EBUSY;
> +		break;
>  	}
>  
> -	if (issue_reset)
> -		hvt_reset(hvt);
> -
>  	mutex_unlock(&hvt->lock);
>  
>  	return ret;
> -- 
> 2.21.0
> 
