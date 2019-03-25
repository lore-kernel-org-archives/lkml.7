Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC453C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B81A20850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtd8H/wD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfCYK3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:29:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37480 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbfCYK3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:29:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so6242333pgq.4;
        Mon, 25 Mar 2019 03:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ey9xQ+MI67kM6+LSZpUvDw46PAf2djwmiWErMwnyCJg=;
        b=jtd8H/wDMBZOnQh3mccznAxMR5nsbhqx5XoDXzAbIGPfN0gaX3v9lGhuz240WDd5hH
         xstAq+wZoG7zZBhO8H2cWUF0XYuMitbZs8GL7HQBg3FWL0rZeb5/9STJWp08gnv9eyJs
         oFbMdtFpMza7KpCHS0zZTlQ4B+Oxxu4zAumHNeQo4XK7r9HYniklvbDx1dzb68RyygXv
         Pov4qDBRXgL+k0W+j4GQFnly5AXhEOmNjzyxh888wuJEFuiZEWibgGz8bfwk/DEEA0Qe
         GkPKpaLSZ79rvnEZhFE7Rqy9cSbpwJGKc2EGzeCvFcPSLw+hsfgdz+xv1Syor5pSnp2q
         v2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ey9xQ+MI67kM6+LSZpUvDw46PAf2djwmiWErMwnyCJg=;
        b=Ez5L+bQF2ZpoPuDF8s9mDXYMUOllhehSrsAl1M4xQUj44gmJMGj4N7kad1ReilE49T
         M5e0Un5/9mU3NyKRbj7q4Q2GCW6mILoxd+TKYQ0T9lGc4ah2O9MMCkvw3uE8Sh77vOM6
         P60sW2n+0FQybOOxH+qKPvIRNbiNLZpiHbt3Xd2wci6Vx/KKrNGVzOBRmIgWHegOrtkC
         DuVB61DUbTA4ygmXJqSnunhEeWU+dq0TjNyotR+QCCakVZrGw/lr6456RgpFeokerQCN
         t0PAYNUj3+zsF0cbO34A31oYvutzvLU87twu1yLErCr+cPh2MIvywUuM4O+XQ7L2toQq
         3lMw==
X-Gm-Message-State: APjAAAW3J0kse1Q9TX569omDikhFnGDlMaTzuoFvxNlWyDbs+kRGlaze
        MVZECQEHrpFQ+mUQA5mUBq4=
X-Google-Smtp-Source: APXvYqyzS6/yV0VoCEuMYNhkVH9OTjKQ0/BbwR0yKEd8cRhuzHSIQVHycth0ZnVT/R5UGAGj4uIhwQ==
X-Received: by 2002:a63:36cb:: with SMTP id d194mr23032609pga.426.1553509785440;
        Mon, 25 Mar 2019 03:29:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i135sm15089982pgd.41.2019.03.25.03.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 03:29:44 -0700 (PDT)
Subject: Re: [PATCH V1 1/1] watchdog: f71808e_wdt: fix F81866 bit operation
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>,
        wim@linux-watchdog.orgw
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <1553225816-24375-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <af4fba18-da99-2b48-7bbe-d59222081ab4@roeck-us.net>
 <cf37ee27-593c-b809-62d4-8d38265cb710@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3f6c755d-c2ff-01cb-ac67-3a899737cbde@roeck-us.net>
Date:   Mon, 25 Mar 2019 03:29:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <cf37ee27-593c-b809-62d4-8d38265cb710@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/19 11:10 PM, Ji-Ze Hong (Peter Hong) wrote:
> Guenter Roeck 於 2019/3/22 下午 09:06 寫道:
>> On 3/21/19 8:36 PM, Ji-Ze Hong (Peter Hong) wrote:
>>> Fix error bit operation in watchdog_start()
>>>
>>
>> Hmm ... does that mean it never worked ? Did you test it this time ?
> 
> Sorry for lacking test procedure. I had only test the functional (reset)
> , not to test the register value.
> 
> The F81866 PIN70 (WDTRST#/GPIO15) is default set to WDTRST# function and
> the old code only change register 27h bit(4) - PORT_4E_EN.
> 
> If the mainboard entry port is 4Eh, the old code is equal to nothing
> done, but when the mainboard entry port is 2Eh, this code will make the
> change from entry port 2Eh to 4Eh.
> 
> https://html.alldatasheet.com/html-pdf/459086/FINTEK/F81866AD/26531/119/F81866AD.html
> 
>> A secondary concern is that the watchdog doesn't _have_ to trigger WDTRST,
>> but may also trigger PWOK. But that may be a separate issue.
> 
> Out watchdog is only support WDTRST#.
> 
>> Please add:
>>
>> Fixes: 14b24a88a3660 ("watchdog: f71808e_wdt: Add F81866 support")
> 
> OK, I'll add to v2
> 
>>> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
>>> index 9a1c761258ce..9129485732c7 100644
>>> --- a/drivers/watchdog/f71808e_wdt.c
>>> +++ b/drivers/watchdog/f71808e_wdt.c
>>> @@ -387,18 +387,17 @@ static int watchdog_start(void)
>>>       case f81866:
>>>           /* Set pin 70 to WDTRST# */
>>> -        superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
>>> -                  BIT(3) | BIT(0));
>>> -        superio_set_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
>>> -                BIT(2));
>>> +        superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, 3);
>>> +        superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, 0);
>>> +        superio_set_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, 2);
>>
>> Better use superio_inb()/superio_outb(). The above is (much) more expensive,
>> and  we have no real idea what the impact of changing one bit at a time may be.
> 
> Could I add a superio_mask_write(reg, mask, data) with v2 patch like
> following fintek driver ?
> https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/8250/8250_fintek.c#L113
> 

If you wish. but not necessary. For the fix it would be better to have only the fix.
You could introduce the function in a second patch and use it wherever read/modify/write
of a mask is used in the driver (I think it was used at least in one other place).

Guenter
