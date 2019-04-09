Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883F6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E0620693
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyPpcKro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDIBDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:03:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37165 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfDIBDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:03:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so8346494ply.4;
        Mon, 08 Apr 2019 18:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1QtGKgPxY7UlciRmg18I6RYAzi9EdWlyj5RZ6H9w9L0=;
        b=KyPpcKroUSFqK/Z5mufSUj8fafKLgf1qocBpS6zU3p58WrVGozYbaHKChb1c+7hmqZ
         4vEaWK5/EhccIuWp/uWEbCrWmiNz9Ct58aQ0KTwfTdXlZ3VW3kmMZnnEzEFCSBRyugBf
         KmqYx9netbqC+j4pka3Qhg/V20vhxjve0awvTelTLyTesHRDDvYjMSCI/EAkfXAHe2KJ
         dpuWQVvppZHGMaId+PSCESxcIVFK4ga2DOyvSCHcnNkLTVMljtSUjUAFj+vApNEdVmgK
         hQDXuV8EBt/EIDYgzylH+9dFHf6aVAvn3YkzH4ZfcfRvpN/Lm4kQCBfSKnXZLDVw6xFj
         VNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1QtGKgPxY7UlciRmg18I6RYAzi9EdWlyj5RZ6H9w9L0=;
        b=jLEyfJR6pzH1OVJMUg8PoLwrLRuEdheNI4Nh2Af73KbNXbLlftpDfnder0H2CA20Cc
         tHv30GVONwQ5M3b82EgXDBPVlZLwvYrOxQgGjaE1qlXPM69Bby5Rb58t3/lbta1C5Ah4
         kPETuTF+ldvpaLP/XiVT7fUAiVYgwV1SPo4k7yG2c6xurkCVNlMce0eKXVbWdXLesGh4
         6C5bx565X1TWWuxx8msjLdtugGNJTx2WeMGuUkU9RXmFs09R38AfyPrzb/fy7EJUawPq
         AchbtsYridbH4xZFjOQrzvzuvXpZumZLE+FpPuLbfjXRs1jaGI7C8ow872m/8Jp7bG2e
         dsOw==
X-Gm-Message-State: APjAAAWfBsxPWuzLWNwRPsENbyYGWe6yo6UUZoO6hKamcYiBZr35fJ9B
        FfY3akideC9y8OFnazcu/HrPh731
X-Google-Smtp-Source: APXvYqzWwes/Iu3rts9KMHpfiQ2TLwnywuKOpbpEsrVogwj6h8CkA65DdnPGlTZkfh+iu1UZMV3axA==
X-Received: by 2002:a17:902:e183:: with SMTP id cd3mr18716832plb.233.1554771795712;
        Mon, 08 Apr 2019 18:03:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w21sm41844741pfn.48.2019.04.08.18.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 18:03:14 -0700 (PDT)
Subject: Re: [PATCH 03/22] watchdog: aspeed_wdt: Use 'dev' instead of
 dereferencing it repeatedly
To:     Andrew Jeffery <andrew@aj.id.au>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
 <1554752326-13319-4-git-send-email-linux@roeck-us.net>
 <2b039e4a-1f21-4297-a499-d8f764844693@www.fastmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8eab4602-eb0e-a49d-3dab-c6454f4fdb47@roeck-us.net>
Date:   Mon, 8 Apr 2019 18:03:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2b039e4a-1f21-4297-a499-d8f764844693@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 4/8/19 5:37 PM, Andrew Jeffery wrote:
> 
> 
> On Tue, 9 Apr 2019, at 05:09, Guenter Roeck wrote:
>> Introduce local variable 'struct device *dev' and use it instead of
>> dereferencing it repeatedly.
>>
>> The conversion was done automatically with coccinelle using the
>> following semantic patches. The semantic patches and the scripts
>> used to generate this commit log are available at
>> https://github.com/groeck/coccinelle-patches
>>
>> Cc: Joel Stanley <joel@jms.id.au>
>> Cc: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/watchdog/aspeed_wdt.c | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
>> index f09333fd54b4..34117745c65f 100644
>> --- a/drivers/watchdog/aspeed_wdt.c
>> +++ b/drivers/watchdog/aspeed_wdt.c
>> @@ -187,6 +187,7 @@ static const struct watchdog_info aspeed_wdt_info = {
>>   
>>   static int aspeed_wdt_probe(struct platform_device *pdev)
>>   {
>> +	struct device *dev = &pdev->dev;
>>   	const struct aspeed_wdt_config *config;
>>   	const struct of_device_id *ofdid;
>>   	struct aspeed_wdt *wdt;
>> @@ -196,7 +197,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>   	u32 status;
>>   	int ret;
>>   
>> -	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>>   	if (!wdt)
>>   		return -ENOMEM;
> 
> Looks like it's missed this one somehow?
> 
> wdt->base = devm_ioremap_resource(&pdev->dev, res);
> 
> Otherwise,
> 
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> 

Assuming you mean the conversion to use devm_platform_ioremap_resource(),
I had this already addressed with a single patch for all watchdog drivers.

https://patchwork.kernel.org/patch/10882207/

Sorry, I didn't Cc: you on that one - I limited the number of Cc:s to avoid being
tagged as spammer.

Guenter
