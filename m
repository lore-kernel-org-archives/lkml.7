Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E8BC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1612082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIouuo7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbfFTNX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:23:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34516 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfFTNXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:23:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so6925486wmd.1;
        Thu, 20 Jun 2019 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QRsZz0dCYRgcO6EsWLLIo6fDZbX1ygY3MDXGBeGeUmE=;
        b=mIouuo7EJ9YmdxMEu/ab4r6Ca7GwOS+EwFcLdpP6SOt69TOftaNC93wtxO891EVv3j
         u31nQxxf3Jq7acJZPbPKIGayfUyo84LiQRqAMoEg4WIlCWPxrfBVd1yWwu6NmbrIH7Vf
         d6jN+ct1lxiusJVq1mClHzq3YlS2zqp6U40vr94BTeGrdCSu1DIKIpD0M+UDXCtc//xZ
         ZhqHFyBkzJ9BzjST+idczoBaxpSe2Uqgj4YWuiuVh2Vp296BsAkP+eyGo924uPm7Ridk
         dpFrDxUksP+eS9oosS9312VFnDlwpq6D7r1/fc5yOuc6H2rfalUkjfk8p4NCab9WW+ij
         PoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QRsZz0dCYRgcO6EsWLLIo6fDZbX1ygY3MDXGBeGeUmE=;
        b=sTV0gqDv6S2xAGjoUuuadbdFcxc+jCW+M1TvGbSPBDwhWV9cRJK6Ehd9ErBysi4SWV
         fg0t+QK4Dqx0SIIKSmL84MQJ0m5FlBrbuhmt5RIZGPg1Elume5XnUotBkUFFuVTv8naG
         Du/gB68Y0WEdbFqZO4o50p23yC8NW90B00FL7+/fLHPt3ItEiSfoFJ3Hb/zmWgcveI4G
         NVe9NiaIxNQhida9p9Ngm9c5zfqNFszWfgB7QiLqMsQBPTVzCInYJXEs2mlq3F+aqwob
         88fGxqfc0cbRXhCCt1Ug9nKccJBuP/iQcPO028u3yu02xePzCIr+dha8W+NvPGZ1tBVJ
         Rs0A==
X-Gm-Message-State: APjAAAUfuLVkWfbz9AnUKKqwsA9J6mEfj7pWlAcwWNKRRJtdhe9vSnhx
        O0DMQW8xloO6tokYX1H51hXm2DcJ
X-Google-Smtp-Source: APXvYqxTPoTjp2QP76mmvA9aNcT5VZHPhVHWdEC6J1XHVBRV/1+xEP+aAglVltVdKU0mqjMMAzFhdg==
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr2645766wmj.87.1561037004074;
        Thu, 20 Jun 2019 06:23:24 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id v204sm5668948wma.20.2019.06.20.06.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 06:23:23 -0700 (PDT)
Date:   Thu, 20 Jun 2019 15:23:21 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Convert remaining drivers to use SPDX identifier
Message-ID: <20190620132321.GA19183@Red>
References: <1561036786-23190-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561036786-23190-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 06:19:46AM -0700, Guenter Roeck wrote:
> This gets rid of the unnecessary license boilerplate, and avoids
> having to deal with individual patches one by one.
> 
> No functional changes intended.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/adm1029.c    | 10 ----------
>  drivers/hwmon/adt7411.c    |  5 +----
>  drivers/hwmon/adt7475.c    |  5 +----
>  drivers/hwmon/iio_hwmon.c  |  5 +----
>  drivers/hwmon/max197.c     |  5 +----
>  drivers/hwmon/scpi-hwmon.c | 10 +---------
>  6 files changed, 5 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
> index 388060ff85e7..f7752a5bef31 100644
> --- a/drivers/hwmon/adm1029.c
> +++ b/drivers/hwmon/adm1029.c
> @@ -10,16 +10,6 @@
>   * Very rare chip please let me know if you use it
>   *
>   * http://www.analog.com/UploadedFiles/Data_Sheets/ADM1029.pdf
> - *
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation version 2 of the License
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/module.h>

For adm1029
Reviewed-by: Corentin Labbe <clabbe.montjoie@gmail.com>
