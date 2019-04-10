Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0D8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379DB2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB1V+Vju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfDJRru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:47:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44883 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbfDJRru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:47:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so1905213pfm.11;
        Wed, 10 Apr 2019 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q91V6OmvTc/Auau73Rj+pKcqo7v9MnUkZAtPss1ug4I=;
        b=YB1V+VjuphtRDq7v9hUSJyTgkK+JHhanAS2uy+zLHxwxYuGMOFqyBeMEt7ey8aC93G
         ok9zrdBo128qpJ0wxvPvclCyUBy/SRPQeknSUpJ6CQzNHqCAPV4LBrTzQH5g6c/Tbpkq
         jTlXBtJ8Vnw5CLFGNY3uEifZFDI9MQ/3Z+/M24u/ACfXtc/TtDpKkvwx3chMzOgmgcBk
         uYDxmBAw6AylDG2NWSFqLqaDqTSZK4jO+zZFtf/JnsnGs4410qmGGpyHgh1ltNKUKYYD
         DQKMo1eH21IaV+/rJrpk6kGcGQg79aIPM8xD0jAgMMnABrQt60JAwduwzUVLBa9BJeRb
         LgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q91V6OmvTc/Auau73Rj+pKcqo7v9MnUkZAtPss1ug4I=;
        b=OVmlJSFSURk9Xdo/mtE14rOvars6KIJgNADK3qMp/thL+RGJLF+X462SHRT3GyJNqY
         E7ruZwrtFqmzJw19ziiRMpFIQhKRzYQkBbE26CelURtDZlgAGvpIhcvQ01uCf5HDkkqn
         fj0maJGof1lMFeutgR7ifOFubeyGjPpYyL/e+uEX84O9h79IiRZVdSZ1iXz+nupIo/gy
         nA4WOBRablsiT9qixpCQz22hQbHSjEr7PU76+lzjZRzzk9tM8cF6tk3iLgxHlLQvmpj/
         BEgQQ5kjub8crLxoQdO2Oh5VeRpeZHEhiFZgC2yOVXydcJ8MlHZpgXffYQ3tig3Ngn9S
         GrvQ==
X-Gm-Message-State: APjAAAUQfoRM1/Gbqzz7CCiRO4XUswUUCW4Ff1etmgiO3vY/mK9tMVDv
        2IM7iGI2gY7WK6BuybFGrms=
X-Google-Smtp-Source: APXvYqwP0ga9tcAJKgyhKFxnqq+tKec3ETA8eqkGMNgIoIX4xeB8Ns+7bKQx1uyFLfnPGd2WOtpdqA==
X-Received: by 2002:a62:304:: with SMTP id 4mr44113960pfd.99.1554918469647;
        Wed, 10 Apr 2019 10:47:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v19sm65644840pfa.138.2019.04.10.10.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:47:48 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:47:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Perches <joe@perches.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/22] watchdog: jz4740_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Message-ID: <20190410174746.GA2132@roeck-us.net>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
 <1554913683-25454-21-git-send-email-linux@roeck-us.net>
 <8d44aaf119c286ac18ead30a2174aecef2dbc7e2.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d44aaf119c286ac18ead30a2174aecef2dbc7e2.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Wed, Apr 10, 2019 at 09:52:09AM -0700, Joe Perches wrote:
> On Wed, 2019-04-10 at 09:28 -0700, Guenter Roeck wrote:
> > Introduce local variable 'struct device *dev' and use it instead of
> > dereferencing it repeatedly. Also, there is no call to dev_get_drvdata()
> > or platform_get_drvdata() in the driver, so drop the unnecessary
> > call to platform_set_drvdata().
> 
> Dropping platform_set_drvdata seems to me like it should
> be a separate patch.
> 

Bundling all changes into one patch per driver already resulted in more than
60 patches total in this series. Splitting that into three sets of patches
over three days already earned me automated replies telling me that I am now
considered to be a spammer. One logical change per patch would have resulted
in hundreds of patches. I don't think that would have scaled well.

I considered other splits, such as one coccinelle rule per patch, affecting
multiple drivers, but that would have had the same result since it would have
needed dozens of Cc: lines per patch. Ultimately, I decided to go with one patch
per file.

> And are you sure no other function uses a get_drvdata call?
> Maybe something in watchdog_dev.c?  Possibly:
> 
>    #ifdef CONFIG_WATCHDOG_SYSFS
>    static ssize_t nowayout_show(struct device *dev, struct device_attribute *attr,
>    				char *buf)
>    {
>    	struct watchdog_device *wdd = dev_get_drvdata(dev);
> 

'dev' in nowayout_show() points to the watchdog device, not to the platform
device. Its drvdata is set in drivers/base/core.c:device_create_groups_vargs().
Not all watchdog drivers are platform drivers, and the watchdog core can not
depend on a watchdog device even having a parent device, much less make
assumptions about its drvdata.

Guenter
