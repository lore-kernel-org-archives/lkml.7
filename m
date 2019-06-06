Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6379BC28EB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A231208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZygxiJgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfFFVOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 17:14:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45227 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfFFVOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 17:14:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id w34so2024531pga.12;
        Thu, 06 Jun 2019 14:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f52tpv1WD74Ax5kl9cRY3NuWmR2GDKh3GDLDw7CLojg=;
        b=ZygxiJgzK6wW63rvs+Zm62oqJZT/v8GXAYyjAZ+Ml8LUg3NRmnQZZbMSY/S4onClJ2
         MkPLtsZ+zyPMs/F8BwBl5LqIhCkDpLTx/NwGlNtV9RAjSnhlWzKzreM2fZCwslifQeiq
         Mde06+0zI1bX+605ITvKPHRrmDO+jVXPP0fXa6pMzjN5i4R2AQO1+KCOpJYxNB81nA6s
         KAaEdJlKbd7SMaWB2jsR6lNyvtWYvf1MRaac+HeBgq7+fXtZm1VxM30uTsaenC8fa150
         0UoQDDsyDpL0aUchm8r7tjpDbPj3W9yrBuHuxyjPkni24iFLROtk/VTH2RWcG5oH+RMW
         cplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f52tpv1WD74Ax5kl9cRY3NuWmR2GDKh3GDLDw7CLojg=;
        b=aTLkhM6mNjvj3cC4lawvmHJtP9wtzzizO3EHWELUJsxUlid87q9//75GmYEkB2NYdi
         WXHryAbzI9D1eEcq4Am7ImxxHY1fDJtDDO1//lJlbgCXrfIpJHH5z97nPPlVDvhapFlD
         9APPdDUR+2uw/MpDeW8xpGe9UWb4+V6byvOtgKNaDxf72+YajYfYNCdHv298Df27pX7b
         Ls5Bz23bnsySnkyQpqHixOfINAwQfOl5/Yon6nN9kUZFm0S//0yJ10x8m8AdlViRlSXS
         5i06dk0RLi429AeE7TLYidjVFfGC/CVzVeSF72hVm9+geVbRPI1fCLFZQpIgsFlCW2zW
         Tw1g==
X-Gm-Message-State: APjAAAVEhvJcpkjY5PEraNmw/xOg6QChQ5wSmAkU4l4TLU5lXfisAZ5j
        7RyOCxywWnXG/Pa4zRBrPoY=
X-Google-Smtp-Source: APXvYqxPffMYASARwWQ8nHX5F4OQgoE9h3T/Ycgs5FveqCFJlhIfcnerwixue5QgxJqurc58KUmAGQ==
X-Received: by 2002:a62:3287:: with SMTP id y129mr49409484pfy.101.1559855642500;
        Thu, 06 Jun 2019 14:14:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s9sm17202pjp.7.2019.06.06.14.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 14:14:01 -0700 (PDT)
Date:   Thu, 6 Jun 2019 14:14:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, mironov.ivan@gmail.com,
        rasmus.villemoes@prevas.dk
Subject: Re: [PATCH 1/6] watchdog/hpwdt: Stop hpwdt on unregister.
Message-ID: <20190606211400.GA856@roeck-us.net>
References: <1558126783-4877-1-git-send-email-jerry.hoemann@hpe.com>
 <1558126783-4877-2-git-send-email-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558126783-4877-2-git-send-email-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 02:59:38PM -0600, Jerry Hoemann wrote:
> Have the WD core stop the watchdog on unregister instead of explicitly
> calling hpwdt_stop() in hpwdt_exit().
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/hpwdt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index ef30c7e..8c49f13 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -310,6 +310,7 @@ static int hpwdt_init_one(struct pci_dev *dev,
>  	if (retval != 0)
>  		goto error_init_nmi_decoding;
>  
> +	watchdog_stop_on_unregister(&hpwdt_dev);
>  	watchdog_set_nowayout(&hpwdt_dev, nowayout);
>  	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
>  		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
> @@ -350,9 +351,6 @@ static int hpwdt_init_one(struct pci_dev *dev,
>  
>  static void hpwdt_exit(struct pci_dev *dev)
>  {
> -	if (!nowayout)
> -		hpwdt_stop();
> -
>  	watchdog_unregister_device(&hpwdt_dev);
>  	hpwdt_exit_nmi_decoding();
>  	pci_iounmap(dev, pci_mem_addr);
