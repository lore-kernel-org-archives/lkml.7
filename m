Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC720C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A0420675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BO8pd+2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfCFAqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 19:46:42 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45702 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfCFAql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 19:46:41 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 78D55242;
        Wed,  6 Mar 2019 01:46:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1551833199;
        bh=8g0egB80qkVFg3oED+YECqDP+Lv5/wMZ7HlaLdlqJ3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BO8pd+2gy1rPkNuRLgI72rHvuFb+8J/DvRu1RVQ0+uC/q6uSWqoleTm44o4LQogdz
         9AOZLphyZa/yc7dvQtfYvmx4yT3jYFEu1lzPqECH+fMO3omO+Ieq7R7r6m+KUs1bcD
         dqs/phxeofBMRlbeHs3iEG5L230TW9JuLTK7q/hc=
Date:   Wed, 6 Mar 2019 02:46:33 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH -next] usb: gadget: Remove dead branch code
Message-ID: <20190306004633.GU14928@pendragon.ideasonboard.com>
References: <20190123143136.15704-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190123143136.15704-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello YueHaibing,

Thank you for the patch.

On Wed, Jan 23, 2019 at 10:31:36PM +0800, YueHaibing wrote:
> 'num' is a u8 variable, it never greater than 255,
> So the if branch is dead code and can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/usb/gadget/function/uvc_configfs.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
> index bc1e2af..8fe85cb 100644
> --- a/drivers/usb/gadget/function/uvc_configfs.c
> +++ b/drivers/usb/gadget/function/uvc_configfs.c
> @@ -1570,10 +1570,6 @@ uvcg_uncompressed_##cname##_store(struct config_item *item,		\
>  	if (ret)							\
>  		goto end;						\
>  									\
> -	if (num > 255) {						\
> -		ret = -EINVAL;						\
> -		goto end;						\
> -	}								\
>  	u->desc.aname = num;						\
>  	ret = len;							\
>  end:									\
> @@ -1767,10 +1763,6 @@ uvcg_mjpeg_##cname##_store(struct config_item *item,			\
>  	if (ret)							\
>  		goto end;						\
>  									\
> -	if (num > 255) {						\
> -		ret = -EINVAL;						\
> -		goto end;						\
> -	}								\
>  	u->desc.aname = num;						\
>  	ret = len;							\
>  end:									\

-- 
Regards,

Laurent Pinchart
