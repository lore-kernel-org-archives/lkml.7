Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63F7C2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4DE20706
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFDgxgxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLFOhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:37:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36885 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfLFOhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:37:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id bb5so2805261plb.4;
        Fri, 06 Dec 2019 06:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MmAJYe9y7hqJDFUyCzbIg+/OBoZV4/dfN8ALgALbljo=;
        b=PFDgxgxfa1SQfvN602ZGkhQGP+RUlpRbKFPdeHwt1yx2/1QK8DF9XuSXfmlbmGFH3O
         qdnjDNdPuTVtV3jDzel/MzOUc0ADPf/EZrQDJVSCc+FlKKP/WO1hJawk+sYjb+tp5mq3
         fkpyaBZY6P5YQ4/RXNM0BN9xMn63GrqAgPsU5CBo1mUlwVt+pUF1uyQyMQDPe+/seJPo
         QqE3SwtEf+cZtfGvCVduV/gvw6mE20+J5bTBs1M2BoDfN/RO4vv+OupEtubpY3j7LoYx
         xziCwRNHPRfT1QxlUOcEOftAzCunpp47VZilf2huVZBnJNvoJBPpRLq808H7MXSuQq1M
         3iQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MmAJYe9y7hqJDFUyCzbIg+/OBoZV4/dfN8ALgALbljo=;
        b=fVAeNcPmYHjQGV4JpR4jJW8RVWXZzY/SAkW6CgGU/hRnHbR/rtYM89L/TG5bv/jKjS
         7qgR8DUPo5ZdWdxSt3KUDyq7/HRrfeFZBspAYVQgtoeE3UlHdNy//Wj8cBNFqXMmyUn7
         lgBHw30++IU6QaPE3K6m/kWabAFz6rfdjRXljKcBenchw1i2QlTrGHreQGOFzCajCzH2
         pbEvlL0MsE9SAJTC34i2fzPwXnWzyR6+h96qoz6ebWTtYf+jscDBpCK5Q3EvCDysc1p0
         HPwWYUwA+jrTxkHNxjaSXR/XQLhVNsbPnRK/LxIvviCD27Lz+h5UdNCxQQrSKa/xH2Lu
         PB9w==
X-Gm-Message-State: APjAAAUobGja8EqZTflDleX4zUBW6IKOoi7pfOx+57gYp2PUxv8McRR4
        GCKzbCwZD54r8XrkvZMCg80=
X-Google-Smtp-Source: APXvYqxJGdkN7RNKsZLyt14TxInds+wbC8VNpPQfJGJOSwV7v/peQJDCs7D08nXCIJ/B4vPMqxaFrA==
X-Received: by 2002:a17:90a:a44:: with SMTP id o62mr15799733pjo.80.1575643025840;
        Fri, 06 Dec 2019 06:37:05 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 186sm16865700pfe.141.2019.12.06.06.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Dec 2019 06:37:05 -0800 (PST)
Date:   Fri, 6 Dec 2019 06:37:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (adt7475) Make volt2reg return same reg as
 reg2volt input
Message-ID: <20191206143703.GA2291@roeck-us.net>
References: <20191205225755.GC2532@roeck-us.net>
 <20191205231659.1301-1-luuk.paulussen@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205231659.1301-1-luuk.paulussen@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 12:16:59PM +1300, Luuk Paulussen wrote:
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

Applied.

Thanks,
Guenter

> ---
>  changes in v2:
>  - remove unnecessary braces.
>  drivers/hwmon/adt7475.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 6c64d50c9aae..01c2eeb02aa9 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -294,9 +294,10 @@ static inline u16 volt2reg(int channel, long volt, u8 bypass_attn)
>  	long reg;
>  
>  	if (bypass_attn & (1 << channel))
> -		reg = (volt * 1024) / 2250;
> +		reg = DIV_ROUND_CLOSEST(volt * 1024, 2250);
>  	else
> -		reg = (volt * r[1] * 1024) / ((r[0] + r[1]) * 2250);
> +		reg = DIV_ROUND_CLOSEST(volt * r[1] * 1024,
> +					(r[0] + r[1]) * 2250);
>  	return clamp_val(reg, 0, 1023) & (0xff << 2);
>  }
>  
