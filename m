Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A852AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E9220818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbfDJQwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:52:14 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:43372 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727020AbfDJQwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:52:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3B6D6180A8140;
        Wed, 10 Apr 2019 16:52:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: form68_1316c4b4e991e
X-Filterd-Recvd-Size: 2021
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Apr 2019 16:52:11 +0000 (UTC)
Message-ID: <8d44aaf119c286ac18ead30a2174aecef2dbc7e2.camel@perches.com>
Subject: Re: [PATCH 20/22] watchdog: jz4740_wdt: Use 'dev' instead of
 dereferencing it repeatedly
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Apr 2019 09:52:09 -0700
In-Reply-To: <1554913683-25454-21-git-send-email-linux@roeck-us.net>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
         <1554913683-25454-21-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-10 at 09:28 -0700, Guenter Roeck wrote:
> Introduce local variable 'struct device *dev' and use it instead of
> dereferencing it repeatedly. Also, there is no call to dev_get_drvdata()
> or platform_get_drvdata() in the driver, so drop the unnecessary
> call to platform_set_drvdata().

Dropping platform_set_drvdata seems to me like it should
be a separate patch.

And are you sure no other function uses a get_drvdata call?
Maybe something in watchdog_dev.c?  Possibly:

   #ifdef CONFIG_WATCHDOG_SYSFS
   static ssize_t nowayout_show(struct device *dev, struct device_attribute *attr,
   				char *buf)
   {
   	struct watchdog_device *wdd = dev_get_drvdata(dev);

   	return sprintf(buf, "%d\n", !!test_bit(WDOG_NO_WAY_OUT, &wdd->status));
   }
   static DEVICE_ATTR_RO(nowayout);

> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
[]
> @@ -189,18 +190,16 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
[]
> -	platform_set_drvdata(pdev, drvdata);
> -
>  	return 0;
>  }
>  

