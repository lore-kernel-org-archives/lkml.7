Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67794C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF3822DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9qsgChs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfHTPFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:05:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40377 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfHTPFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:05:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id w16so3555217pfn.7;
        Tue, 20 Aug 2019 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g2uXNLCxA+dXRwhpGdL3x6UO13at0QdpKzA7SxMXRAU=;
        b=V9qsgChsHcfRalvftwAD++xaW2CQo0MTo9l3AnGv8SOHGJTlLvWynRgXe6yNnJe90R
         u+z3JXRdxx6ZhRO+3+920gOUuiTL7yz67eaxmBx9YcTssDHPTfC7dsTtsLpG8FNs+OT5
         yHPfK1Bs9hcJAvjpuv3f1n/XIOB+caZpJOBUwtvAh3wdB8XzU0X/3xF+nUEKZOdfkgn7
         /j62Dqv4zlI7e7moaCo+HX7v6EGP/CJbfPWqd/2R9xjQIp1jjpwh4wIPbwkGh1zqz2Vw
         z/P6kG2wJjPlafs2sXceJeQNpKBtzzp1kdryqHzRHzYxB2+i/WXmlMK0JOTQOgLMHGSJ
         DM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=g2uXNLCxA+dXRwhpGdL3x6UO13at0QdpKzA7SxMXRAU=;
        b=e+7gl3oUh1Y86kvnlrdeHn4npGBQPH72w5O1yumHnhs6czkORDGPWzfgbVUM5VRhLG
         0/6swr1uPt+7+bU72H1UN2yNYVo+X4ogxmWVArDU/7NHZXaftAny5BlejJ4S6Z+u2fk1
         flJ2kh6sb7Hksc1pmPagaIfPK4aNJ89Yh0XjtVh7tpsBQWjtJUPdE9Zjx6+2q3jv24h7
         9V8wiC3Oc9E/1B2PSa2F8Ag1VmhliNE/lHsf9zHpmR+2pJF1HwMaDeotVUWXw8FiTrKV
         izZvfea+MUl9W9jw6Omhs5LqTXhNHUooGSaXIyBd6QtkCDyNaNSWVMjo2ofL77IFPR67
         MNqQ==
X-Gm-Message-State: APjAAAUkMAb9FyCWVUMj7Co+kk5CjdqY5V/eryXH+YY2sBFWMogzSgzj
        ey52+mXenzbDdiPE6m4zpmg=
X-Google-Smtp-Source: APXvYqxADL9JKZUyaWsi4ECBYxpmpVty/F2zQ+4L4AoFilq+5Lc7ndsImxTBb3E5MpTyJ4w579QOrA==
X-Received: by 2002:a63:9249:: with SMTP id s9mr24396327pgn.356.1566313515641;
        Tue, 20 Aug 2019 08:05:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l123sm29448261pfl.9.2019.08.20.08.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:05:15 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:05:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        "open list:CORETEMP HARDWARE MONITORING DRIVER" 
        <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon/coretemp: Fix a memory leak bug
Message-ID: <20190820150513.GA12013@roeck-us.net>
References: <1566248402-6538-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566248402-6538-1-git-send-email-wenwen@cs.uga.edu>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:00:02PM -0500, Wenwen Wang wrote:
> In coretemp_init(), 'zone_devices' is allocated through kcalloc(). However,
> it is not deallocated in the following execution if
> platform_driver_register() fails, leading to a memory leak. To fix this
> issue, introduce the 'outzone' label to free 'zone_devices' before
> returning the error.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/coretemp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index fe6618e..d855c78 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -736,7 +736,7 @@ static int __init coretemp_init(void)
>  
>  	err = platform_driver_register(&coretemp_driver);
>  	if (err)
> -		return err;
> +		goto outzone;
>  
>  	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hwmon/coretemp:online",
>  				coretemp_cpu_online, coretemp_cpu_offline);
> @@ -747,6 +747,7 @@ static int __init coretemp_init(void)
>  
>  outdrv:
>  	platform_driver_unregister(&coretemp_driver);
> +outzone:
>  	kfree(zone_devices);
>  	return err;
>  }
