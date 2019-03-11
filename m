Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF914C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AC92075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyp4JTN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfCKOPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:15:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43947 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfCKOPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:15:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so3785371pfh.10;
        Mon, 11 Mar 2019 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4z2AZ4lMR5IXpII1O3tybb21guBBB/FszpKjJYtolYs=;
        b=nyp4JTN2Ka/WLgf4FBNUts+lcVWFZZ5jgrWoMM2BBiS413QElpu+EC0Sw0GHmsjMLn
         LzZ7roasTdWedNyDaV59wOEcP/VzW6TLrRO8N1jir8VW0qFF2EfLQ1BkjTzAKTND8bnA
         vpmSyXRCwRkTyqB7muk0h0j6cvkfdmJ8sgIjBpDGDRuQ+wmWuIjbjbR5EXrhVbtVJgTm
         70Hoh0vFepL6ctdS30NaNYjfLZIdc9+1Tk1HXtOIH/YqKCgj7OU/wPsoADORZdSpB5S8
         9WUxRiNgzQDnYQMtqK/IeBAUALe724zw2nS1WMbsMHpp0H8QXxgzW90VfXz5YvACBit2
         lc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4z2AZ4lMR5IXpII1O3tybb21guBBB/FszpKjJYtolYs=;
        b=hIvZy7SbWU3CWCrQeRAJZlWLhUkl5jy3xRAf2gqJcluYazGvCeDJwsy6IZ9mXIzBe4
         VpmOStj8TuHQFHbysBdioerZaraTU0L3Il4FLgsfcl+ht9wFuHTTOvWalYdm46dXagdT
         5diRhGCQYSU/rQVGSc08Ab8HjJdoFQK6xcsRbg40qZtGCYepCErd+l0lUWv27HUxExWC
         OG1fdbEyIEdG7/CwU5hWjOJKD7LNRpKrVXRTK2rRt+liJEYAS1oks87I+O0x1B4yG9Zm
         T+b3wejy0S8fRWcE+G0FY4EB1LYAezp674NNGLfweAMWKNI1fdRekM+oR+Fyd08lwM4L
         uNVQ==
X-Gm-Message-State: APjAAAWqZ/V4u4SVu7bxo+cRrRF5ifbYWP8IjOtxQOX7guXZWGNvpjT+
        cuBGMjp1fPmGNvjmuttw/IZxlyVR
X-Google-Smtp-Source: APXvYqzTKOEmUpb/7GcoOrWxAieARr8U6QzhkXHAFdVlwlJeJy4lO7YNX3Bu8jZU556rpbiE6/LoWA==
X-Received: by 2002:a63:5317:: with SMTP id h23mr5771737pgb.437.1552313700736;
        Mon, 11 Mar 2019 07:15:00 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id y37sm12918793pgk.78.2019.03.11.07.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 07:14:59 -0700 (PDT)
Subject: Re: [PATCH] net: ocelot_board: fix a NULL pointer dereference
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190311063632.21111-1-kjlu@umn.edu>
 <20190311102600.GB1637@piout.net>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <d61f3d5e-6f8c-5a44-447a-7fc96cb65037@gmail.com>
Date:   Mon, 11 Mar 2019 07:14:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190311102600.GB1637@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/2019 03:26 AM, Alexandre Belloni wrote:
> On 11/03/2019 01:36:32-0500, Kangjie Lu wrote:
>> In case devm_kcalloc fails, the fix returns -ENOMEM to avoid
>> NULL pointer dereference.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 

A proper error path is needed to avoid memory leaks.

>> ---
>>  drivers/net/ethernet/mscc/ocelot_board.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
>> index e7f90101d2e0..af68abf1632a 100644
>> --- a/drivers/net/ethernet/mscc/ocelot_board.c
>> +++ b/drivers/net/ethernet/mscc/ocelot_board.c
>> @@ -256,6 +256,8 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
>>  
>>  	ocelot->ports = devm_kcalloc(&pdev->dev, ocelot->num_phys_ports,
>>  				     sizeof(struct ocelot_port *), GFP_KERNEL);
>> +	if (!ocelot->ports)
>> +		return -ENOMEM;
>>  
>>  	INIT_LIST_HEAD(&ocelot->multicast);
>>  	ocelot_init(ocelot);
>> -- 
>> 2.17.1
>>
> 
