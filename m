Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2921DC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033B120B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU/g9Xjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfE1UfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:35:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45197 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfE1UfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:35:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id a5so137pls.12;
        Tue, 28 May 2019 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aaxYwob8ojeK4vx5PzzDahXRFmqjdVXWsrOuEKNA0DQ=;
        b=kU/g9XjvqkKf73URzdLKKwOdGl+647hKFs2XQqYIAzhwUcIj6TdexIvjLYJGOcPzIm
         3fvFvcREeLeaGxX/FSST4+dEdPWYX2UvfC8zm8Ucc6lqmfQVH4P3pCpOoa/cocMd6/hs
         7QJJykiV5Cp8W5hnXNnXhgXhX4dEiJZ3Wp70E3JcLZUzl87q8BEQJs/rMLDj1eXTUxXV
         yoDbNl8ldiF6kb6wUtK+2OEteKpI3XFWEB+2MrvvbiuGdD+01R7rmZ989p0ACYgFZG0c
         5c9YTobz4kWOgaba+Q7sHeW1BPSHAgmW2O2mrrJ57eIgamxmjI8hQEy+mAJXptlYT6o3
         icAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aaxYwob8ojeK4vx5PzzDahXRFmqjdVXWsrOuEKNA0DQ=;
        b=d7MzjVoZyqauBrA+eNUp3BWL11a6ptq3tvh+GxIATwmWxpZTmOVTprmNiNqFmh338p
         HXIIxCN2LwroVstIltLKRF5t8gzBpL1zmD6b4jfdASGRO0LRAIN2ruKMUxGuJP3/eLTl
         VYLzCqfVjE/M8yNxHMLOPLo71dSp+tcMGVwdjttpUhTwMiHHrKx/Ph8i17fKsBgM6ssy
         oXI2LdmF8jc6mLa7N9UwWL7vqIfz50UmEVcgEAgLPIsCgrfx5Pcpepu/DvSeXVLeIpS6
         g4dhaOybX6hCssjEEgQ6dFsgOTv9CtZLwqMr2d7Y8sA/j1KCuTOBVe/LytqkweBu7+K9
         cCWA==
X-Gm-Message-State: APjAAAXDfFddb0+XPUyWXgqWDCMzxRDMTptBdpDx4gC8mUxR5nT/Z4wV
        Pg/X5T0tcybaIy4hXk3mK9UuHOrj
X-Google-Smtp-Source: APXvYqwx3DhB771I8an+dHWcIOZ1aLaPjoLMcizU8AriPnovDNWtPBOxsd1ApMTyKTQ7HXpYNhYOVA==
X-Received: by 2002:a17:902:e60a:: with SMTP id cm10mr126506971plb.316.1559075714609;
        Tue, 28 May 2019 13:35:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g19sm12582193pgj.75.2019.05.28.13.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 13:35:13 -0700 (PDT)
Date:   Tue, 28 May 2019 13:35:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (tc654) Update to use SPDX-License-Identifier
Message-ID: <20190528203512.GA29505@roeck-us.net>
References: <20190515031508.30206-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515031508.30206-1-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 03:15:08PM +1200, Chris Packham wrote:
> Add the SPDX-License-Identifier to the top of the file and remove the
> old license boilerplate.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Notes:
>     I've gone with GPL-2.0+ because that matches the old text. As the author I
>     don't mind switching to GPL-2.0 if people want that.
> 
>  drivers/hwmon/tc654.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/tc654.c b/drivers/hwmon/tc654.c
> index 81dd229d7db4..8d0acbf8fbfc 100644
> --- a/drivers/hwmon/tc654.c
> +++ b/drivers/hwmon/tc654.c
> @@ -1,17 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * tc654.c - Linux kernel modules for fan speed controller
>   *
>   * Copyright (C) 2016 Allied Telesis Labs NZ
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/bitops.h>
