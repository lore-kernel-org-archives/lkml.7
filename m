Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAA0C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF3D22DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfIDI0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:26:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfIDI0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:26:34 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D053E121D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2019 08:26:33 +0000 (UTC)
Received: by mail-ed1-f71.google.com with SMTP id x40so12190213edm.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 01:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mdq+QracXr/iUxjMIxa/s/5noOnKKkBNDchKNpboJh8=;
        b=k371zjgitfId6W0Vzq21hraMuGWwJc85VpQzLcb94bL0UHwttww1jaoW+tehS7W0U8
         exV67DHv4fHaDNm0hrR31zzHeuEi32MC0p47FvZsu4x0EP5UMSpSmFXINSMohaJPQwNW
         3Rb2JqJ3T33oZ/McVB0Ow3uxf5I1mL2Gl7/7H7Qax6ZksFK60geQxpxlr6sVPekoRjD0
         3TJFHKNQYqhCxJRAqUDlc53e/v7lWt8pQcdCqAoPHOvX49Og4GR7ees0Pb6sn1UwZveQ
         Pwibepq/6gP9Ezre205BLej9+jB2+lbjIyQWyMBSQ0e7CwBXw5Wdc8Svvh95hTZvuuaK
         WlZw==
X-Gm-Message-State: APjAAAVDbEE0OROXC4ZTYRvfPgeVGqREm5HWxlP8iDENvjiTNUIiLLSL
        9ee42zz4/IRDCFN3Immu0IgnHnKp2wo3GekQD9pmTKFqtkr7LJP3ppm3778ZZXJoh8txjICs+JU
        sm9H+Cz8vKWJJXyRUd7JavlcZ
X-Received: by 2002:a50:935d:: with SMTP id n29mr17641206eda.294.1567585592218;
        Wed, 04 Sep 2019 01:26:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyrZIi/f7VkraEJ2lB8pAtxxch5NNjc6CDt2RyPZ8JPCmVki5CWKUep7EVPz+F/rfwvljQ3FQ==
X-Received: by 2002:a50:935d:: with SMTP id n29mr17641199eda.294.1567585592109;
        Wed, 04 Sep 2019 01:26:32 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id d10sm2621252ejd.86.2019.09.04.01.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 01:26:31 -0700 (PDT)
Subject: Re: [PATCH] i2c: cht-wc: drop check because i2c_unregister_device()
 is NULL safe
To:     Wolfram Sang <wsa@the-dreams.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190820153441.7693-1-wsa+renesas@sang-engineering.com>
 <20190903175218.GE2171@ninjato>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2e55f3cb-ba88-5404-3b38-585710976ed0@redhat.com>
Date:   Wed, 4 Sep 2019 10:26:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903175218.GE2171@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-09-19 19:52, Wolfram Sang wrote:
> On Tue, Aug 20, 2019 at 05:34:40PM +0200, Wolfram Sang wrote:
>> No need to check the argument of i2c_unregister_device() because the
>> function itself does it.
>>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> ---
> 
> Hans, are you OK with this change?

Yes this is fine by me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
>> Build tested only, buildbot is happy, too.
>>
>> Please apply to your tree.
>>
>>   drivers/i2c/busses/i2c-cht-wc.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
>> index 66af44bfa67d..3e2608a65c06 100644
>> --- a/drivers/i2c/busses/i2c-cht-wc.c
>> +++ b/drivers/i2c/busses/i2c-cht-wc.c
>> @@ -363,8 +363,7 @@ static int cht_wc_i2c_adap_i2c_remove(struct platform_device *pdev)
>>   {
>>   	struct cht_wc_i2c_adap *adap = platform_get_drvdata(pdev);
>>   
>> -	if (adap->client)
>> -		i2c_unregister_device(adap->client);
>> +	i2c_unregister_device(adap->client);
>>   	i2c_del_adapter(&adap->adapter);
>>   	irq_domain_remove(adap->irq_domain);
>>   
>> -- 
>> 2.20.1
>>
