Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93B1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E092133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/7JAAJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbfDJNLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:11:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33343 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbfDJNLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:11:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so1560383pgh.0;
        Wed, 10 Apr 2019 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tuZG/ko+3OAPdVsoKoUI2egERJqSrCrLr6SbDb/mHbc=;
        b=s/7JAAJH6Zz+NStz7GIEj9jpor9Ka9rV2jMFQKijWnpyKOd2JwPTlbP9F/76Hf0Ums
         uW7J87u3zx8X3yTgA9EtwvH2+eZgCarJ6nOH1kw5E+jDlaDpk2tKpofwNXpABTs1bVdC
         r4kMwda05AdKMxwKouKoz9ntD+E2fwptAHnbtLNmrP2yzm79VYoishY7odtVdEJBhPVQ
         CERulgBZ4MhRn25avDUdWPF+i76lhab17pwxBEkofKJifjanFyzeUyHUcSqhYRB/T+bw
         AQB6q4TjDBR8VziAsn9xrM2YrtIYTjskdNaocv3KBzcwe5yhoTotXEExQtMWZtjSIU+r
         2lZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tuZG/ko+3OAPdVsoKoUI2egERJqSrCrLr6SbDb/mHbc=;
        b=UhbYW3Ch1NAGIST2L1QA3dLHTJ3drh2GLENoMME8VxyBkPCxnK1QGZTDhJfjI77XcS
         /THlKCctqLWAyqcDzLCQk7HRxIfhBGNj+N8fuCs6Mt/kJPNct3nZhqKDkJvEx2LXCWkm
         MuxWX0ZVtDBTB6BbfyI+r96TOr6PqVSpdMcSehI2Hhx2hyXGXaMb/oROO+n3eCJgixOD
         txCdHE1sYlHK5gBvTOEDBeVpGov+ospscs4lSg2Fbekw+P/j7veMEkjXpoPrK+6blGAj
         KDmQue/Ewn/iQv/ocuTb0kM54FrFTI4sgTKxYhlt3lvYukzd6RfnW3FnWToWmig1fMC6
         i50A==
X-Gm-Message-State: APjAAAWMiFyyw1SGpQczaVRwSRd90qZBB19w49FNQ4V9tdtGQxTA1eYv
        nL+B42CwAbGv8ncvU7sjArI=
X-Google-Smtp-Source: APXvYqwNbjxdQuzPMoRFLXIxmh1mNBKggW7ULGB9htiL5qAMqZLMczmI5MSHlTt1gXZwD9z02xtTvA==
X-Received: by 2002:a62:6e05:: with SMTP id j5mr41988862pfc.5.1554901880334;
        Wed, 10 Apr 2019 06:11:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v189sm86677932pgd.77.2019.04.10.06.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 06:11:19 -0700 (PDT)
Subject: Re: [PATCH 12/22] watchdog: da9063_wdt: Use 'dev' instead of
 dereferencing it repeatedly
To:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
 <1554752326-13319-13-git-send-email-linux@roeck-us.net>
 <VI1PR10MB235286F9A7E4E1C32DD41139FE2E0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3fd0e7c8-acc5-8c94-3617-1cea8f8d9f20@roeck-us.net>
Date:   Wed, 10 Apr 2019 06:11:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR10MB235286F9A7E4E1C32DD41139FE2E0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 4/10/19 5:50 AM, Steve Twiss wrote:
> Hi Guenter,
> 
> On 08 April 2019 20:39, Guenter Roeck:
> 
>> Subject: [PATCH 12/22] watchdog: da9063_wdt: Use 'dev' instead of
>> dereferencing it repeatedly
>>
>> Introduce local variable 'struct device *dev' and use it instead of
>> dereferencing it repeatedly.
>>
>> The conversion was done automatically with coccinelle using the
>> following semantic patches. The semantic patches and the scripts
>> used to generate this commit log are available at
>> https://github.com/groeck/coccinelle-patches
>>
>> Cc: Support Opensource <support.opensource@diasemi.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/watchdog/da9063_wdt.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
>> index 384dca16af8b..06eb9070203c 100644
>> --- a/drivers/watchdog/da9063_wdt.c
>> +++ b/drivers/watchdog/da9063_wdt.c
>> @@ -188,17 +188,18 @@ static const struct watchdog_ops
>> da9063_watchdog_ops = {
>>
>>   static int da9063_wdt_probe(struct platform_device *pdev)
>>   {
>> +	struct device *dev = &pdev->dev;
>>   	struct da9063 *da9063;
>>   	struct watchdog_device *wdd;
>>
>> -	if (!pdev->dev.parent)
>> +	if (!dev->parent)
>>   		return -EINVAL;
> 
> None of my previous Acked e-mails in this patch set considered whether the
> dev->parent was NULL. But this DA9063 driver does.
> 
> Logically, this is correct to check, but ... any thoughts?

The check is not really necessary. All da90xx drivers are instantiated from
mfd drivers and do provide a parent. Anyone changing that code or trying
to instantiate the drivers from some other place without providing a parent
really deserves the resulting crash (it would be a bug).

Either case, I don't think this warrants changing this driver to drop
the check, or changing the other drivers to add unnecessary checks
just to make the code consistent.

> Otherwise,
> 
> Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 

Thanks,
Guenter
