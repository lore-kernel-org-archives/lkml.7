Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C711FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95030214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554361033;
	bh=Doda+4ZTfhITd2FHC7BYwt1vCf3SANuM4VwEQhS6uVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kt+bxxlpYVlUCqF3p8NtgbyeFujejHy2BDsif4iB/fQRt+gcFF2cqhvX6/AixYIHM
	 vCZtnBFg6Jl878LWEnoD85+2cu6jT0Mp37x4gGLgWcBE7ziyqte4kXXjbtRu03zz59
	 oOtbwCmlTkJh3DmtoOupdqJRZcFCjDIA5qnx6HYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfDDG5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:57:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37942 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfDDG5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:57:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so1067259ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 23:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gSvsvNM/pXoL+R9brqlb9tlw9roffYyAxoP3BKZe/nU=;
        b=Fy1nnQh6KUY1lNycFM3tlJT+X1NDWme47JnsKqzfEFYRockRwqPtHpbG8rUy9XdISV
         dG2BhClwgMJmEDyEbfHYvRu0xm8HlnYH5jJJHX/rleA/7VkbuA7TT0DKSKW6ezypMPVr
         URcvlBmFgigEB1mKke+fxLxSoAo9JIM+EGtjEQf1c8lIR5O/ISCj9fVIPMoqxx55ntlf
         zx1G0YRVLXre+Ir28rlAbvUK7KU7ayJLXkrfBvg3qr461RB1KEiXJ/sj9Hcnqdfr6/Ae
         sbCIv3nWvMc3k4BkkPCtf/S/Zf0fyfiVB2Cob2V0Ds5yBN7/B20cr6xHJkm9xvc2tV7q
         fAXA==
X-Gm-Message-State: APjAAAVPIjvmY/KtafdUOzXZqmOzg/v7ozKwjntTLVIFOxdCL5BZCX5C
        67rgUhmY2zXK+E7+xslGkG8=
X-Google-Smtp-Source: APXvYqxFU3j0U8r4+6STRo4/6fZLVJG/2chLi6Fo46wN6c+1fLdJaX4toodok+/jjsslw6I369Um/w==
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr2290690lje.138.1554361029828;
        Wed, 03 Apr 2019 23:57:09 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 15sm3445276lft.88.2019.04.03.23.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 23:57:08 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hBwJZ-0003GL-JB; Thu, 04 Apr 2019 08:57:33 +0200
Date:   Thu, 4 Apr 2019 08:57:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: power_supply: Use struct_size() helper
Message-ID: <20190404065733.GA12635@localhost>
References: <20190403205801.GA19762@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403205801.GA19762@embeddedor>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 03:58:01PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace code of the following form:
> 
> sizeof(*resp) + props_count * sizeof(struct gb_power_supply_props_desc)
> 
> with:
> 
> struct_size(resp, props, props_count)
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/staging/greybus/power_supply.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/power_supply.c b/drivers/staging/greybus/power_supply.c
> index 0529e5628c24..40cc2d462ba0 100644
> --- a/drivers/staging/greybus/power_supply.c
> +++ b/drivers/staging/greybus/power_supply.c
> @@ -520,8 +520,8 @@ static int gb_power_supply_prop_descriptors_get(struct gb_power_supply *gbpsy)
>  
>  	op = gb_operation_create(connection,
>  				 GB_POWER_SUPPLY_TYPE_GET_PROP_DESCRIPTORS,
> -				 sizeof(req), sizeof(*resp) + props_count *

This patch looks good, but I noticed a bug here in the current code,
which should be fixed before applying this clean up.

sizeof(req) should have been sizeof(*req) above.

> -				 sizeof(struct gb_power_supply_props_desc),
> +				 sizeof(req),
> +				 struct_size(resp, props, props_count),
>  				 GFP_KERNEL);
>  	if (!op)
>  		return -ENOMEM;

I've just submitted a fix (and CCed you as well). 

Would you mind respinning on top of that one?

Thanks,
Johan
