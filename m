Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C70C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFE42229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuXk+iT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbfHGQuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:50:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40052 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387967AbfHGQuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:50:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so41599556pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PTJzzkmcaFUIGPxJmALw8QsVth95UCeQqYyb4Gc4MR8=;
        b=BuXk+iT0vwKIA0hX7V6EV5NP7jgQv2pWbqpiOPvZ8tYVZdY1rPXgJRtjJq5pUbk5XK
         7U3DXrq/EEmpCYh8tFZONFErpTLxL11P6UPu9Xz4JN6LwwdvPFFCIZ1Ie535I3KKG4YI
         oXTa+SFWTb5oV3Cg5xBVTAeBl1N6HO6jO+QKP1g+aT3PeViiZmmxS+S9PNPw7r3ODXjg
         O2e9O037NvwQl/2n+2RdiS7DiRhbY+REzno7Q+UxlUYVuU5Y+7QCs/SByX/R8glOTHcB
         YgXYIuwRNRMIy/WRhN+bk3Spz5SRvg91oDkMbovrVaf1+bh1zKmuPI7s8cf8hiaVqFXh
         suYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PTJzzkmcaFUIGPxJmALw8QsVth95UCeQqYyb4Gc4MR8=;
        b=MHTdkBluYN7GOj71gMnQZPWKBAN1zKO4tmMpkq496T8X3NVJvCz3mqBfnH5VJ2Bf/0
         6dVki7eHjU/wXH3CMVsokXxO/Tk0UZryTg2LzIN+lMkxmOXhCCeecMG3hRrIcDjqXZD3
         KwiaqFh/VWAS5rZ/tz07OMNIb5Hh4VWK8+2Lw5gXvLCKF7rWGi2XxQYY2NBEOTZM9Cnk
         rRMYbWh39NTUWByLGSnVPWFS6+wVOEyJrmd3D5cdMLX8XTTBjynaflS17t5Pe2W+8K47
         cYf4I8CgUL8W6fF8BOGxU8+UbrC6ziYkv42MdhsW/3Z7Y6OkZfVo2hwP+sOwtgFGFFE1
         mBgQ==
X-Gm-Message-State: APjAAAXKPjWpZt1ElSggFQTNXB17fd6DAk0Jafb4yNz9RJFfWPUlBOWK
        unK3f3QasXXCWw11gzlOlM7EPIjR
X-Google-Smtp-Source: APXvYqxJq1PCxDZqWR+8/uL+AcoMjoR6UOChvu+pgMRi0ClmXRnnBHis3U2N9Jlnqgp4Tq7hPlMNUw==
X-Received: by 2002:a63:2252:: with SMTP id t18mr8521998pgm.5.1565196612166;
        Wed, 07 Aug 2019 09:50:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o24sm170364577pfp.135.2019.08.07.09.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 09:50:11 -0700 (PDT)
Subject: Re: [PATCH] firmware: google: update vpd_decode from upstream
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Hung-Te Lin <hungte@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anton Vasilyev <vasilyev@ispras.ru>,
        Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
References: <20190802082035.79316-1-hungte@chromium.org>
 <5d44b8eb.1c69fb81.6d1c1.7d80@mx.google.com>
 <20190807135834.GA12853@roeck-us.net>
 <5d4ae764.1c69fb81.f81f8.054c@mx.google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <525c3cdd-ba15-5898-b9de-daaa42b4b87e@roeck-us.net>
Date:   Wed, 7 Aug 2019 09:50:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d4ae764.1c69fb81.f81f8.054c@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 7:59 AM, Stephen Boyd wrote:
> Quoting Guenter Roeck (2019-08-07 06:58:34)
>> On Fri, Aug 02, 2019 at 03:27:54PM -0700, Stephen Boyd wrote:
>>> Quoting Hung-Te Lin (2019-08-02 01:20:31)
>>>>   
>>>> -static int vpd_section_attrib_add(const u8 *key, s32 key_len,
>>>> -                                 const u8 *value, s32 value_len,
>>>> +static int vpd_section_attrib_add(const u8 *key, u32 key_len,
>>>> +                                 const u8 *value, u32 value_len,
>>>>                                    void *arg)
>>>>   {
>>>>          int ret;
>>>> @@ -246,7 +246,7 @@ static int vpd_section_destroy(struct vpd_section *sec)
>>>>   
>>>>   static int vpd_sections_init(phys_addr_t physaddr)
>>>>   {
>>>> -       struct vpd_cbmem *temp;
>>>> +       struct vpd_cbmem __iomem *temp;
>>
>> The change to __iomem should also be a separate patch.
>>
> 
> Please don't change it back to __iomem. See commit ae21f41e1f56
> ("firmware: vpd: Drop __iomem usage for memremap() memory") for why.
> 
> 
Sorry, I didn't notice that part.

Guenter

