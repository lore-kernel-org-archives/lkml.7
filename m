Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687E8C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566B8206E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="pGbXq5tO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKMWds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:33:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45824 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfKMWdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:33:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id w7so1663056plz.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 14:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aZxJ73oZSgqijSV53S37oyWVbREhPPJnkeSvFjOaHRY=;
        b=pGbXq5tOdXqAg/QNG2WO1pDSzCg18VJpo5e8JVAeyA08wpHt93eBSIOiwYU4O6VYV6
         3fqDM1SjMi0iPBhJh0mWlWiKtvQHk+6MlFP2TImCwDiLDtaazNSwSQMoq0Pnni0HQRbF
         +2gOc/mWOIf6psbQYqOEbsez2yrScfAorVEHBl9g6hwnDxoKxBvkUtkxvimPNxyL3aH7
         Z+L6jkCBKAhCVFKjDzTz4jO4SchCsFMT1lf0TzNibMizGXqwQex/klicjC3++P6wk/HG
         sfjBTygoDRtlJKn+RscDbwJXF/PdIawPRQGlZYdRIr9nxTM13ZOskYw6hL+NFi58HdBA
         QjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aZxJ73oZSgqijSV53S37oyWVbREhPPJnkeSvFjOaHRY=;
        b=cFCt7NWDVMb99JUsZvNClB8aftgHqrHPTt+HaCoZsyiLwpvZ1RXLCx5OX/UDZqrEmi
         N6JNXliJqCELo6Bji40cZWSxrTNpU2wI5Cf34zHoHAlw/PHzC+TIITrPc47gxEcGBdf7
         LCR/ftrWMrnygo541+g7hgWvjUWVqaqVlOyBohawwV9LCkjTe+aF/m63WTIr7tHe58+o
         ZVuqpzdUJvjfO9HBMDhqcIW7XRyoXQ7b8U0NR2knDiFO+bvEzireQ3pkpY93DEKULddA
         mDCZR59NnFiVdtRoEhyQ1Kw2ST5QJsrec2EXVT/xfqfiwY0chYOM4yYvBNGosZNFUf5X
         zSZQ==
X-Gm-Message-State: APjAAAU4O8GOMXLU4abqvsoGZYqwUw1AJ4uqew5CwgjAO7eW4WDtvOcC
        OxEvUVBGzZYxLco6caq7SO08r8vQE9HdSg==
X-Google-Smtp-Source: APXvYqzcDGAIW2ZofzKXCTr4yn1MGMnvB9gWJNRgTrrj+U0dokiuDSqtPy9oSRS3opyPgMcZQKwlig==
X-Received: by 2002:a17:902:7c04:: with SMTP id x4mr6423766pll.0.1573684425432;
        Wed, 13 Nov 2019 14:33:45 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id u24sm3805963pfh.48.2019.11.13.14.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 14:33:44 -0800 (PST)
Subject: Re: [PATCH] firmware_class: make firmware caching configurable
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Tim Murray <timmurray@google.com>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20191113210124.59909-1-salyzyn@android.com>
 <20191113215031.GA3944533@kroah.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <4bca568b-4ffd-f880-7273-37db4d9f8f54@android.com>
Date:   Wed, 13 Nov 2019 14:33:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113215031.GA3944533@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/19 1:50 PM, Greg Kroah-Hartman wrote:
> On Wed, Nov 13, 2019 at 01:01:13PM -0800, Mark Salyzyn wrote:
>> Because firmware caching generates uevent messages that are sent over
>> a netlink socket, it can prevent suspend on many platforms.  It's
>> also not always useful, so make it a configurable option.
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>> Cc: Tim Murray <timmurray@google.com>
>> Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
>> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>   drivers/base/Kconfig                | 13 +++++++++++++
>>   drivers/base/firmware_loader/main.c |  6 +++---
>>   2 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
>> index 28b92e3cc570..36351c3a62b0 100644
>> --- a/drivers/base/Kconfig
>> +++ b/drivers/base/Kconfig
>> @@ -89,6 +89,19 @@ config PREVENT_FIRMWARE_BUILD
>>   
>>   source "drivers/base/firmware_loader/Kconfig"
>>   
>> +config FW_CACHE
>> +	bool "Enable firmware caching during suspend"
>> +	depends on PM_SLEEP
>> +	default y
>> +	help
>> +	  Because firmware caching generates uevent messages that are sent
>> +	  over a netlink socket, it can prevent suspend on many platforms.
>> +	  It is also not always useful, so on such platforms we have the
>> +	  option.
>> +
>> +	  If unsure, say Y.
>> +
>> +
> Shouldn't this entry go into drivers/base/firmware_loader/Kconfig
> instead and depend on FW_LOADER by putting it in the correct location in
> that file?

Good point, respin on its way.

>
> Also, no need for two blank lines.
<not sure how the double lines showed up, checkpatch,pl should look for 
this>
>
> And finally, 'default y' is only a good idea if your machine can not
> boot without the option.  I don't think that's the case here, correct?
>
> thanks,
>
> greg k-h

I am concerned about the change in user space behavior and to prevent 
defconfig churn.

