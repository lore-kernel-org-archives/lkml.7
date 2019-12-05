Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35BDC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940F42467C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4g/Tq4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfLEW56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:57:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39476 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLEW55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:57:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id o9so1853826plk.6;
        Thu, 05 Dec 2019 14:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f+B8233jwXRgPzxOVaGgtjsx5fu5wDXS6ZFPAnmHgWE=;
        b=P4g/Tq4+WO+cW3WxZTYiqJNZfLoMDcktvqNShuD8H7Cg4HgtVcLRVUWwp4bh/6n9Bg
         OpFijsgKPdyxobje6rR5ih94D+pY5rIw9wSgpzkcLayE/vKEgbO+R75N+Crn+ZkEZPsh
         zDcaO27KsncfAe/xcB5xCcIq2UXCDrbJcoYzWfaP3exD7TSmsy8QKq+1A1OU2lGHcIdW
         B78uq7LaJwbuP1rZa6cckfClTWniAgdNkPX0T/s7VMzUEotgjue70Yij7HzZLpeIe86f
         JCXF484UFbzRHWuVjVEEhtK04jevP531vmNskkGsEDq9WtijiiNWyWNv3bOeZBZiEmYf
         NEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+B8233jwXRgPzxOVaGgtjsx5fu5wDXS6ZFPAnmHgWE=;
        b=QIqfH5v4Eme9We5hJjphgIpj686/IolpK8BjtGXBR6qa2TJ4aIDV5H8pgnqOKGDQfr
         EGWSlmFttvf4QtkR3tfIwXfIxAs1LBy16KVOGY3Dj53egjcz8EcWFDRNHaukW6duFGDm
         kGpnSwXBIvkapl7tUnKfKY5L996UBlSQ4WzNUxPWTh8vvq/+o5Mgt8qo3KWae+NUqogh
         V4kagVlfS51EF8Yl4P3NmGvkjsJaJvwqcHRe+nluz5VhppMgpUqfwCIZI+h6GCR8ka5T
         tvBz78v9OupZv/YoQUPBdXMGSFPde+4Sus0NjRf1iFSDoO9X69jVIlNkZoCTwmfEg6Z3
         1BHA==
X-Gm-Message-State: APjAAAWC27+/oHZ5h7N4Gfqxc8POsymGE6ljc2XOuGg9vPdx0OnjMUNM
        /T9FOP1JFqbPsuIJoRJZ/HM=
X-Google-Smtp-Source: APXvYqwGR26oIBVrXLweNmmCUkZrmm3EPYUousA/ff6g/94vDGlthxzVV4kF7/DF5J9uZfdc+nIMZQ==
X-Received: by 2002:a17:90a:3aaf:: with SMTP id b44mr12477948pjc.9.1575586677206;
        Thu, 05 Dec 2019 14:57:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p24sm13075587pff.69.2019.12.05.14.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Dec 2019 14:57:56 -0800 (PST)
Date:   Thu, 5 Dec 2019 14:57:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (adt7475) Make volt2reg return same reg as
 reg2volt input
Message-ID: <20191205225755.GC2532@roeck-us.net>
References: <20191205225430.14959-1-luuk.paulussen@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205225430.14959-1-luuk.paulussen@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 11:54:30AM +1300, Luuk Paulussen wrote:
> reg2volt returns the voltage that matches a given register value.
> Converting this back the other way with volt2reg didn't return the same
> register value because it used truncation instead of rounding.
> 
> This meant that values read from sysfs could not be written back to sysfs
> to set back the same register value.
> 
> With this change, volt2reg will return the same value for every voltage
> previously returned by reg2volt (for the set of possible input values)
> 
> Signed-off-by: Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>
> ---
>  drivers/hwmon/adt7475.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 6c64d50c9aae..5eed7dd2f16d 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -294,9 +294,10 @@ static inline u16 volt2reg(int channel, long volt, u8 bypass_attn)
>  	long reg;
>  
>  	if (bypass_attn & (1 << channel))
> -		reg = (volt * 1024) / 2250;
> +		reg = DIV_ROUND_CLOSEST((volt * 1024), 2250);

Unnecessary ( )

>  	else
> -		reg = (volt * r[1] * 1024) / ((r[0] + r[1]) * 2250);
> +		reg = DIV_ROUND_CLOSEST((volt * r[1] * 1024),
> +					((r[0] + r[1]) * 2250));

More unnecessary ( )

Otherwise good catch.

Guenter

>  	return clamp_val(reg, 0, 1023) & (0xff << 2);
>  }
>  
> -- 
> 2.24.0
> 
