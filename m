Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9133C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E162084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp8Y/el5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDCMiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:38:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35274 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfDCMiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:38:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so8280234pgf.2;
        Wed, 03 Apr 2019 05:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xgQMxXBkLOuUj19gwYj/QYigabn1T7JzlpgpS9wY/K8=;
        b=Lp8Y/el5IaXiJl8EkumleL6QK8dwB1R0RyGAJ1Im1Rig3eJZ70GquxK6BAymf8JWMC
         cchVl5HFFQZnq2rkqw+A3DsDiyM4pdtKm9h+30QNYcxJ2wLiwn+UDFBVIFswtDoSMhOi
         14Jjisrqsp+00CThmPydiDjwj1WciVaA8SoFk+6IhsqfAwd+J7qyfDRZXpoQipaikjo2
         VsGc5oq1pFV977c9YixInVJDqVLl+8FQhxky9g6YlasEpiE7/P4PXO2yuP7hREPA5puC
         ndjnom8poOJmoJwDWhQ9OkOu5Kc5zqDliFoqfb+AxJGqeYhTFKiDlLPU7Y1xph852gvx
         rA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xgQMxXBkLOuUj19gwYj/QYigabn1T7JzlpgpS9wY/K8=;
        b=RP78oo3l0CKDWtEZLf0YxphLbeBd5PUQa3ULw7KUgalZlgGrQ7wWWADEl+b5O4qhuB
         9AyLnCJZP8fgpMA4s7eZf6eSWbNwv3u8SJcilKGqyWY28J37EBf2msBs7s4UZylWXm9r
         pLdVWvBa/Pa6JnpJl8wLpHRtYRECW6dJhnQZPJsY88vEbky7c8U+2baGL+ZtI9UAupUb
         hIKjh/wuaQe/G6IradU7kGkpKZ3Ifd6qXamxG7lGfdBbasZuV4KMroPEYwDdT4fHyMpY
         pYfjpN80bZXzpAPUEBLsDcYAt9GyqeRZ6J+9A7uCgfuS8PJI3kTZ3Q9Tt/i6nHO2YoYS
         etdw==
X-Gm-Message-State: APjAAAWGiyYtKjoXoh+qcnE1JWX8msrYRc/rFAu6VN9XYR8aEAesEud8
        WXgMAkN1ijiU1zCAju9M4CI=
X-Google-Smtp-Source: APXvYqzwjkON90/20WWBR2usL8D11tPtzy01xZg4dgO4fhlVwRmks6JhUvtSmps81ZjLgw1+BhFzfg==
X-Received: by 2002:a63:465b:: with SMTP id v27mr54781170pgk.165.1554295083162;
        Wed, 03 Apr 2019 05:38:03 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.77.43.209])
        by smtp.gmail.com with ESMTPSA id k131sm31570588pfc.183.2019.04.03.05.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 05:38:02 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:07:54 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging:iio:accel:adis16203: add SPDX license
 identifier tag
Message-ID: <20190403123754.GB22738@himanshu-Vostro-3559>
References: <1554284489-5023-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554284489-5023-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:41:28AM +0200, Nicholas Mc Guire wrote:
> Pop in the SPDX tag as the license is clearly indicated
> as GPL V2 or later this should also be indicated with a SPDX license
> identifier tag.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> chackpatch.pl was warning:
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> 
> Patch was compile tested with: X86_64_defconfig + SPI=y, IIO=m
> STAGING=y, ADIS16203=m
> 
> Patch is against 5.1-rc3 (localversion-next is next-20190403)
> 
>  drivers/staging/iio/accel/adis16203.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index 5cc96c80..cf9d41a 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

SPDX-License-Identifier: GPL-2.0+ ?

Documentation/process/license-rules.rst

 For 'GNU General Public License (GPL) version 2 or any later version' use:
   SPDX-License-Identifier: GPL-2.0+

The following should also be removed in this same patch:

	* Licensed under the GPL-2 or later.

And lastly, MODULE_LICENSE() should also be checked, which appear
to be correct in its current form.

>  /*
>   * ADIS16203 Programmable 360 Degrees Inclinometer
>   *
> -- 
> 2.1.4
> 

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
