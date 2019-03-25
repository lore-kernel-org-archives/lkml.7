Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CFCC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5C220693
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaHKlsuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfCYGKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:10:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37585 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfCYGKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:10:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so5614083pfr.4;
        Sun, 24 Mar 2019 23:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oSCUOZlSY6vaMGpU4UD/nvMNxeOvjUMJdTN55leir58=;
        b=kaHKlsuQFP8J1RCshf3bMHdH4ffM7i6LAklxr9+3SNp+OYySeJclujBa/7+ygMDpPy
         7SLPkQx6PyPx2qJXuLFmyu+ggfBjZ7ksMSOgqPgJw9sNbXJ67MWUlo7gs84C+BhTAA8M
         aniqDtugiYID2SdKZ/9FaiRjq61EhGZjqnab1VWdaWtN88trtMXt1oDylTU2mps42ri4
         Xz86zmL3Li9nTjMemO1TvMyUh+xl2Y0iFuWOCjVTPIwg+Hakdh1KUtEq20xZaqjhmuN5
         8BRg8lmS8k+4HcZxGfRAN7xHZ8TFQC4BuwyJDi8rXvE2PkNy6E+NhK8z1BIO2ZVAAYaJ
         gojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oSCUOZlSY6vaMGpU4UD/nvMNxeOvjUMJdTN55leir58=;
        b=qB8quPMhFWSuIPTeieUPA/uqmrw2vT3wZ4HeuCARDfhBW5NEVUSLODeOHaVNMKZ6Uv
         8hL6jdV3r+RigztArJRxi9itR9Nswt2j/4w6MbnPZ1sBOS6P/LP+nvQd3qL10jB8uRfx
         Ieok0eaJlfKtdgNqDZd7kiqLoUweX+9X1StNrrYRUpAb6mGwpUs/MDounj5EtfbUPiNv
         6kSQ9HLIPnQlP9UpqgVC3b5N0rbBm6veA3UeRdG/loe4PF9XgykM5d4za5QPycLnPEN4
         R1BATJj23L/G+On8/9PmYNgQ2e0br3Qt3u9cQtPkj7QcfRkpGXPFPpTcgvhlLRxN86p9
         4UDA==
X-Gm-Message-State: APjAAAU5BaRRjGCFalM6EXIb5103o7+ahrCFZ1iLR+0onn5QG32NZSMN
        1Q7zy/ao6vnGVqI9rNqc8Xb1LvCB
X-Google-Smtp-Source: APXvYqxVxGdale1mOBvgnO33LFdO9uv5fQl5SP6wIIm17iX+ppiNST1EVqe4o7R0hn0DHRXgeBb/eg==
X-Received: by 2002:a62:484:: with SMTP id 126mr22596687pfe.91.1553494219196;
        Sun, 24 Mar 2019 23:10:19 -0700 (PDT)
Received: from [192.168.1.58] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id q62sm18127269pga.32.2019.03.24.23.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:10:18 -0700 (PDT)
Subject: Re: [PATCH V1 1/1] watchdog: f71808e_wdt: fix F81866 bit operation
To:     Guenter Roeck <linux@roeck-us.net>, wim@linux-watchdog.orgw
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <1553225816-24375-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <af4fba18-da99-2b48-7bbe-d59222081ab4@roeck-us.net>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <cf37ee27-593c-b809-62d4-8d38265cb710@gmail.com>
Date:   Mon, 25 Mar 2019 14:10:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <af4fba18-da99-2b48-7bbe-d59222081ab4@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck 於 2019/3/22 下午 09:06 寫道:
> On 3/21/19 8:36 PM, Ji-Ze Hong (Peter Hong) wrote:
>> Fix error bit operation in watchdog_start()
>>
> 
> Hmm ... does that mean it never worked ? Did you test it this time ?

Sorry for lacking test procedure. I had only test the functional (reset)
, not to test the register value.

The F81866 PIN70 (WDTRST#/GPIO15) is default set to WDTRST# function and
the old code only change register 27h bit(4) - PORT_4E_EN.

If the mainboard entry port is 4Eh, the old code is equal to nothing
done, but when the mainboard entry port is 2Eh, this code will make the
change from entry port 2Eh to 4Eh.

https://html.alldatasheet.com/html-pdf/459086/FINTEK/F81866AD/26531/119/F81866AD.html

> A secondary concern is that the watchdog doesn't _have_ to trigger WDTRST,
> but may also trigger PWOK. But that may be a separate issue.

Out watchdog is only support WDTRST#.

> Please add:
> 
> Fixes: 14b24a88a3660 ("watchdog: f71808e_wdt: Add F81866 support")

OK, I'll add to v2

>> diff --git a/drivers/watchdog/f71808e_wdt.c 
>> b/drivers/watchdog/f71808e_wdt.c
>> index 9a1c761258ce..9129485732c7 100644
>> --- a/drivers/watchdog/f71808e_wdt.c
>> +++ b/drivers/watchdog/f71808e_wdt.c
>> @@ -387,18 +387,17 @@ static int watchdog_start(void)
>>       case f81866:
>>           /* Set pin 70 to WDTRST# */
>> -        superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
>> -                  BIT(3) | BIT(0));
>> -        superio_set_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
>> -                BIT(2));
>> +        superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, 3);
>> +        superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, 0);
>> +        superio_set_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, 2);
> 
> Better use superio_inb()/superio_outb(). The above is (much) more 
> expensive,
> and  we have no real idea what the impact of changing one bit at a time 
> may be.

Could I add a superio_mask_write(reg, mask, data) with v2 patch like
following fintek driver ?
https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/8250/8250_fintek.c#L113

Thanks
-- 
With Best Regards,
Peter Hong
