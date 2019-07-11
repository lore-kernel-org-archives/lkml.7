Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D7CC74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601C020872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcgcIoO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfGKQfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 12:35:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40031 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKQfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 12:35:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so3197371pgj.7;
        Thu, 11 Jul 2019 09:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MmkG53WQLXsnChwuW4VZaCFghSpsaEReR7YJG6XS3wY=;
        b=BcgcIoO8JWuECr/LI3atzQ4qxt5OBmIaOr0AK+el9EA3EwjCtUKJeEJJMz56x6JCEc
         9RwB/rq61Hn0aUG50lVV0QnO1bj+XHfUbDFoFhwT1uFEjMaZCyq15Z7lRwifB1sJX2QJ
         kTOLQL38vSoh8eB+AE4q+dzITIvB10BnRneK7HpRWENFWI4PGgSoDANFf8Uzbw43MGsC
         SkuNFR1DrFzdJHgQvOL684DxIMJl+EviFz/JnLXYEqDWxQpGzl7pF0OSX5H4GGnDYvqZ
         J9YGhdo8mrVV1uZWvnM/vf4nwBpnIwXx+Ttk4b8eT7nTUcRpVCvgk+HZQXzl536USxba
         ukYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MmkG53WQLXsnChwuW4VZaCFghSpsaEReR7YJG6XS3wY=;
        b=tWhuc9wY7alzfH1iSUZ8BeLHuOthliFXRWhV0MSVwAwSyJn1t/XYfZzxtdZhrnSF41
         7rkfAAIL8VzOd8y/xpknYkdkBU7uAXxjQpiap+9hl8b5/bAWY4V/PwylObeTblYg/pdT
         X9qBBK9M80cwG9rBJLVWJzpM0hAeGPri4baDTd+95pv04Aet2oeNWRx12xeNisOuh5UN
         CbEhLo3PwZFq3xCE6z9gigZ4pA4JgbRHpoYzHl7VOriLOPizO7BNvF7gBrSLntlp9OBD
         Hr1L7c+X89aCM9wDElSHjvSlpNsBvknSeH8xctcZqQzWUj2XtDB4H90RbDJM1859vG3g
         hlNg==
X-Gm-Message-State: APjAAAW5Naf+dZhcc+3HGHAf8h7mOvtmHAy0eSGFB3h0rj/45gZYUdYS
        5NdkDxCxLjT9eIMFUA6sDg0=
X-Google-Smtp-Source: APXvYqyvGaG6S4s96AFzUFqGjV97xe/yb4IsOBocn5ACV+MMJMiG3jRLvG0CUcuacfGGqhXQuabsEg==
X-Received: by 2002:a63:c106:: with SMTP id w6mr5390973pgf.422.1562862949567;
        Thu, 11 Jul 2019 09:35:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w187sm6560127pfb.4.2019.07.11.09.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 09:35:49 -0700 (PDT)
Date:   Thu, 11 Jul 2019 09:35:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lei YU <mine260309@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Eddie James <eajames@linux.ibm.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon (occ): Fix division by zero issue
Message-ID: <20190711163548.GA19747@roeck-us.net>
References: <1562813088-23708-1-git-send-email-mine260309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562813088-23708-1-git-send-email-mine260309@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 10:44:48AM +0800, Lei YU wrote:
> The code in occ_get_powr_avg() invokes div64_u64() without checking the
> divisor. In case the divisor is zero, kernel gets an "Division by zero
> in kernel" error.
> 
> Check the divisor and make it return 0 if the divisor is 0.
> 
> Signed-off-by: Lei YU <mine260309@gmail.com>
> Reviewed-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/common.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 13a6290..f02aa40 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -402,8 +402,10 @@ static ssize_t occ_show_power_1(struct device *dev,
>  
>  static u64 occ_get_powr_avg(u64 *accum, u32 *samples)
>  {
> -	return div64_u64(get_unaligned_be64(accum) * 1000000ULL,
> -			 get_unaligned_be32(samples));
> +	u64 divisor = get_unaligned_be32(samples);
> +
> +	return (divisor == 0) ? 0 :
> +		div64_u64(get_unaligned_be64(accum) * 1000000ULL, divisor);
>  }
>  
>  static ssize_t occ_show_power_2(struct device *dev,
