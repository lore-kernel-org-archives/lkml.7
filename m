Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75A2C04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994A8205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd/bYwse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfEGVG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:06:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33156 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfEGVG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:06:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so9298642pfk.0;
        Tue, 07 May 2019 14:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VL8uiSCPpzZNMmP+oEVAuQOFn8NTTTisNh1ggwInehw=;
        b=hd/bYwseMXfh2hIOB9c0up4PVwZLYR4n6c+ckG//+BXsEDwauzmZywkj452nBvEUDt
         sAiDFdvaMIJ1RFSq6Ts6UGBoViNk/9II0Yq0+34q03rC6fWIJ2LcUt4FNYDtMLd4p6Xi
         gD3JeSihu3tqX3M4nl+YuCPfpbSEDGaEDr2VfjzyKCSZFUVAN1IOj3Q5JHx4ucy/V6MF
         nDJ4pXd7Pr1CvPECi+wBzmq0f6e2kR0w8cY0Ztn+n4WwBsSpM4QEMxpV0dDs2g/QlysO
         1r1V265aKrVbP6t/tlMivLjqUmI8SGQ3fMGawtfQMSNccF+8pthXpJZzv3ElDkKqXo86
         91aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VL8uiSCPpzZNMmP+oEVAuQOFn8NTTTisNh1ggwInehw=;
        b=njOAxN3jaEB78TLtXJKaK9RmrVK8q2f/LPwUL2Bz9XKdSigg/ZePefEe6JI4G74jA0
         SGzApNGHssH6uH9P+qDJ/k5immq2nWte477zSxy+6zKuwHdm+QkVhAs6ODw0C9wUompQ
         msGv3w1l0WBJHl+r2dk7ro8qgxw2YU24ahQw3IvF+pomPZ+yZb7kAzp7PZRgaOe9YZMj
         h7poDGwh+o2lSnoVHC7h1oqMBslKKxQScou72Yl0xw7ewHvHaBZKIhiskzCSri6El8TJ
         bX79ztvkw5JU28kWizIugG/bRZkMb6YXNVgcMkLrCPIICSOO5DT1hK4NVQs2KKwUvtTI
         ifjg==
X-Gm-Message-State: APjAAAXdgRqF7KhTmldw4pKu+iNUSK1Up40uwdhYXBPU5Em0Nz8rZFYn
        0m2gaTxvaIFSb4r1TBhLH/0=
X-Google-Smtp-Source: APXvYqx1ktV35C20uU5UuqbaQvu3JK7lhcdWdBSMcoeOiHXkOeEm0E+QpkPPBfwH3ZwQSt0JbhhpAw==
X-Received: by 2002:a62:160b:: with SMTP id 11mr43708208pfw.88.1557263216768;
        Tue, 07 May 2019 14:06:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k191sm27841147pfc.151.2019.05.07.14.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 14:06:55 -0700 (PDT)
Date:   Tue, 7 May 2019 14:06:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 1/3] kernel: Provide a __pow10() function
Message-ID: <20190507210654.GA4951@roeck-us.net>
References: <20190507193504.28248-1-f.fainelli@gmail.com>
 <20190507193504.28248-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507193504.28248-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 12:35:02PM -0700, Florian Fainelli wrote:
> Provide a simple macro that can return the value of 10 raised to a
> positive integer. We are going to use this in order to scale units from
> firmware to HWMON.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  include/linux/kernel.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 2d14e21c16c0..62fc8bd84bc9 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -294,6 +294,17 @@ static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
>  	return (u32)(((u64) val * ep_ro) >> 32);
>  }
>  
> +/* Return in f the value of 10 raise to the power x */
> +#define __pow10(x, f)(					\
> +{							\
> +	typeof(x) __x = abs(x);				\
> +	f = 1;						\
> +	while (__x--)					\
> +		f *= 10;				\
> +	f;						\
> +}							\
> +)

Kind of unusual. I would have expected to use this like
	f = __pow10(x);
ie without having to provide f as parameter. That would be much less
confusing. I assume this is to make the result type independent, but
I am not sure if that is worth the trouble.

Are there users outside the hwmon code ? If not, it might be simpler
to keep it there for now.

Thanks,
Guenter

> +
>  #if defined(CONFIG_MMU) && \
>  	(defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP))
>  #define might_fault() __might_fault(__FILE__, __LINE__)
> -- 
> 2.17.1
> 
