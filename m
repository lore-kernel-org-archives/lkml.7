Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E270AC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E3220651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAIbKk1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733095AbfDQUSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:18:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33853 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDQUSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:18:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so30652plt.1;
        Wed, 17 Apr 2019 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FKYoOrkPWJ8jYz0Ef0/9SONZYVLSf2vd4XE8IVn6Uwk=;
        b=PAIbKk1eK3lD3LJbW7MpUHTCpgwHZ2UH5CMR6oNWqDdFgNtPdaVfwomU3g4mWJ/mJF
         X5qU/gHgH/cvbdNucP/ivTYIgRGUJPa3KTVZ0Ia+ttnmvjRqvt7qRDwG39bBcyBNm3SO
         FxQ/GDlaf262cgjrnwWtdXFpZgIGfW8qnggzBmzZ/AGPMfxAplDeoyIJEU7vAHdCyia+
         RnyWm0UXgElftqDs8wsDN1tpdX8TOq+bUmRUslEzxP3tEX4Z92vF2FNwoS5juCj0sbZd
         7ZgllYSyfRB6eF2ta4peeKHymy66ciht3IyKHB+vkIfxUhXwwwvywaFeBhDO/WgdsW5l
         ah6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FKYoOrkPWJ8jYz0Ef0/9SONZYVLSf2vd4XE8IVn6Uwk=;
        b=Lb3w+QlAVDphBFn2/ZV2p3WY+9S7/kAxLxdJXrBjdksZW/VWrhB+Y+d4G43NSdTgWX
         5SLpsMOtgz337aTmyO22lE4Lphu8sdvgKpUESbZF88KriLGm+aLmcJS42693dPu0or9J
         ozOuF9SU9x3yw3GJ5eRVklyWBPE8l+KRY4B+tIt9nt2Fx8qEO/FVuo/+1R7s9wuZ9MST
         Bmy0QPUTnQgv07Ft3MBg3YwUtLphntr27q1GioPnJrSpVGwpFmuue3AqpIR4qc+2G7LP
         SmJ3jkKBggKaRlQsdNFqy243YblhJqFf4nACh2JKxlBCGExWp5dc5xxwrDNHrn4UmKd+
         q4hw==
X-Gm-Message-State: APjAAAX3EZesLahkaoZHfEKuIx3aw3KMyuJ2nACmYh/K2xW3Tu2CRTHN
        D8oC0gmdLysVQ5/lGffov+k=
X-Google-Smtp-Source: APXvYqy+2deBavO0Vs2tDyN+AwVD06NlB/evbn0ZQSuiHhZ+DuRqMhtfXUOSGNx0UW3Qsw6zzNzIIg==
X-Received: by 2002:a17:902:2c01:: with SMTP id m1mr23479512plb.22.1555532280476;
        Wed, 17 Apr 2019 13:18:00 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d68sm55869pfg.16.2019.04.17.13.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:17:59 -0700 (PDT)
Date:   Wed, 17 Apr 2019 13:17:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling
 watchdog_init_timeout
Message-ID: <20190417201758.GB6223@roeck-us.net>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
 <20190416203431.GA20072@anatevka>
 <20190416204814.GA26442@roeck-us.net>
 <20190416205533.GB8268@kunai>
 <20190416212046.GC26442@roeck-us.net>
 <20190416221702.GC8268@kunai>
 <20190416223813.GA744@roeck-us.net>
 <20190417194528.xwivkyubhxyfrx4m@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417194528.xwivkyubhxyfrx4m@ninjato>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 09:45:28PM +0200, Wolfram Sang wrote:
> 
> > Yes, that works as well. Note that it will actually print something like
> > "watchdog: <device>: ..." due to the pr_fmt() at the top of watchdog_core.c.
> > I guess that should be ok.
> 
> I have the following diff applied on top of patch 2. Works with and
> without a parent device. I am not super happy casting 'identity' but
> since its u8-type is exported to userspace, I think we can't avoid it.
> Guenter, is this cast safe? Here is the diff:
> 
I would think it is safe, but question is if it is it needed - ie do you see
a warning if it isn't there ? Presumably yes; if so, let's just do it.

Thanks,
Guenter

> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index cd3ca6b366ef..62be9e52a4de 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -115,6 +115,8 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
>  int watchdog_init_timeout(struct watchdog_device *wdd,
>  				unsigned int timeout_parm, struct device *dev)
>  {
> +	const char *dev_str = wdd->parent ? dev_name(wdd->parent) :
> +			      (const char *)wdd->info->identity;
>  	unsigned int t = 0;
>  	int ret = 0;
>  
> @@ -126,8 +128,8 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
>  			wdd->timeout = timeout_parm;
>  			return 0;
>  		}
> -		dev_err(dev, "driver supplied timeout (%u) out of range\n",
> -			timeout_parm);
> +		pr_err("%s: driver supplied timeout (%u) out of range\n",
> +			dev_str, timeout_parm);
>  		ret = -EINVAL;
>  	}
>  
> @@ -138,12 +140,13 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
>  			wdd->timeout = t;
>  			return 0;
>  		}
> -		dev_err(dev, "DT supplied timeout (%u) out of range\n", t);
> +		pr_err("%s: DT supplied timeout (%u) out of range\n", dev_str, t);
>  		ret = -EINVAL;
>  	}
>  
>  	if (ret < 0 && wdd->timeout)
> -		dev_warn(dev, "falling back to default timeout (%u)\n", wdd->timeout);
> +		pr_warn("%s: falling back to default timeout (%u)\n", dev_str,
> +			wdd->timeout);
>  
>  	return ret;
>  }
> 


