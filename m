Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CBCC4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 02:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280F1206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 02:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I00z0Pbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfIPC5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 22:57:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39109 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfIPC5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 22:57:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id i1so13173281pfa.6;
        Sun, 15 Sep 2019 19:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=drCjAV/UOp50Rxy/eoxcvaAEaVun3goZhD4P4/heSYQ=;
        b=I00z0PbjVwKah91GyH4HWyymN3/zOC3Thqji3PpExoFF3C/6Pm9mPxqhlxiRiNs28N
         hnHiLEJIwKVBjJwStKNvTieufqi3RFTPimd7teWe5Ms8bRRHvyN7RQcF+GeCj4zu7lxM
         sX55iOsFZ2JChA5GBInSMCdzp/HNh9RQ2URn2g5Ko7BHQe8rs2+gpEYPA1wXKZjcm10P
         JBYdQjD7DCRWoTBoQy7kiFoRSIiszcicMMmyPMunBOHrCkvqOlvURyWeoBwv/bkOTZoD
         RJF4t8oIAUBO8hxwIyF28rvnREgXOvIMVN1paKGZwL71rLrKBh0EzQ3qat0q7BDS/UDP
         ZZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=drCjAV/UOp50Rxy/eoxcvaAEaVun3goZhD4P4/heSYQ=;
        b=cIeySbL/P7uMHFUu9BeUvx3WVcZz9IQdzYdTw7OCF3ALz+z4R08Be+OjmGjk0gpNeO
         2VbkRMIb9/g7SiIpLodA2QkXTnadRusWukNChVmz3q7biw/g4Q7PppqZEAvY7yyYduRC
         ucJpTymHpc4Pe1K2jRptW2JF7/mZ5t+MpxE28wng3oxoxSwjJz9WKdjTDfwmEy1Hgcyg
         21KoR3w1FJQNvO9/C7zjFa4fTX/jheFBdDnvMDRdBCOo0VkEgmK/lqjtEQFjq30YMVTO
         Eyfpbet9JCG5z7wwa7wpeVSVEZIA6tN58vpnP7pc0CeYjdn5rw4y6c2NqAJLbFRR3tBc
         B3zQ==
X-Gm-Message-State: APjAAAUy+3RXcsL1DKa8QRiW666M3J+H0kZOCmwWe2T9U5khXPJhbxMD
        2pbjtzSKy/GJU6ynQ6GEHan1i9SE
X-Google-Smtp-Source: APXvYqz9I3lFXO/JtKnYk0CEx+Y5oBEyq0Yw/eJP8VyywXVN601xero1IhniJGjm2QoTp+cB+dtfYg==
X-Received: by 2002:aa7:96cd:: with SMTP id h13mr69257461pfq.21.1568602642545;
        Sun, 15 Sep 2019 19:57:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j2sm35706180pfe.130.2019.09.15.19.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2019 19:57:21 -0700 (PDT)
Subject: Re: [v1,1/1] hwmon: (nct7904) Fix the incorrect value of vsen_mask in
 nct7904_data struct.
To:     Amy.Shih@advantech.com.tw, she90122@gmail.com
Cc:     oakley.ding@advantech.com.tw, bichan.lu@advantech.com.tw,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190916021836.1945-1-Amy.Shih@advantech.com.tw>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4bfa5c0e-e6c9-b47c-3b22-5ce9786bc0fd@roeck-us.net>
Date:   Sun, 15 Sep 2019 19:57:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916021836.1945-1-Amy.Shih@advantech.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/19 7:18 PM, Amy.Shih@advantech.com.tw wrote:
> From: "amy.shih" <amy.shih@advantech.com.tw>
> 
> Voltage sensors overlap with external temperature sensors. Detect
> the multi-function of voltage, thermal diode and thermistor from
> register VT_ADC_MD_REG to set value of vsen_mask in nct7904_data
> struct.
> 
> Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
> ---
>   drivers/hwmon/nct7904.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 95b447cfa24c..ad61c3d92411 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -919,8 +919,11 @@ static int nct7904_probe(struct i2c_client *client,
>   		bit = (1 << i);
>   		if (val == 0)
>   			data->tcpu_mask &= ~bit;
> -		else if (val == 0x1 || val == 0x2)
> +		else if (val == 0x1 || val == 0x2) {
>   			data->temp_mode |= bit;
> +			data->vsen_mask &= ~(0x06 << (i * 2));
> +		} else
> +			data->vsen_mask &= ~(0x06 << (i * 2));

The second instruction is the same for both branches of the if()
statement and can thus be moved outside.

Either case, if {} is needed for one branch of an if statement,
it needs to be used for the other branch(es) as well.

Guenter
