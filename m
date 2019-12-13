Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CB3C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB7A2067C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GH98LjQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLMWrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:47:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40207 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMWri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:47:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so391524wmi.5;
        Fri, 13 Dec 2019 14:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=57LGv4ydX1Xlfr7VmjiZDzrKRZJGhZuB3TVDKwYIs4M=;
        b=GH98LjQ+3hqQ7Mby5aZq9PV/PoQ99Iq5WakYau2zdpVsSp4zJz2ZPY5HsaKoBB60P9
         kEtpbzGccAocbdoBr+r3WxJqr36bfMJCtDKybpwVDJGeT0b5Dqw0H6rorP/1FVx+ZvvP
         CU8Ff8rlGTz1mddty2997GN3ScrWPCkEqnwC8GDd9xR1ccYcHKJM5h0ajdWR4zEN1hEK
         X1MKyfmb1YLdCfnu23wBHm13KsWBHOOiz0o8BNfmv7K3sGsR2z5xzpPpQhZoKiY6BPnp
         +AoMfdZ26Od2hI1GFIXHzxSa6PxVe7T/LX8CZf8T1IL4O4DBH+icTRcAsStU4UHJF7FZ
         GCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=57LGv4ydX1Xlfr7VmjiZDzrKRZJGhZuB3TVDKwYIs4M=;
        b=mnZDq+1ng4ZpN4nJ3rBm2/wWVZ/yWdqoZBIjiEHzjoh6xWBGM3y9Dz+x+gnvYNteDM
         SX2J820dihct19IXtlIXy1bwBDauWV1sA6D4uzau+6FdhXxnUjVRXOoJfql+INmfWBIz
         Zg04+tLMM7ZJbgUZYQwK/wkMioNTJDXtIt8tbTsKT3Nf9zykyPalcE4bPwd36lE1MN5a
         YU5L8zaU0ZhDdO0cyBVtD55nKX+YwbBBglRk2zk8BDp/sp+tANTuISBlI6DVwtP1t3nh
         DCkpt5NSs6YBXO3IGL7Xc6qyI+aWgJ5LauBMKMglTSM+hdicWMpJ1drNlk4gtaK0Clby
         IuQQ==
X-Gm-Message-State: APjAAAVaDJJnl0fhHsmMLatzBQn8rL/Z6eAgkxSlJPZnk5fp1bbQQNzg
        58bz9c9OJUBx8vhTpK/luqox+adR
X-Google-Smtp-Source: APXvYqybkXQMzrR+C3onHTt17mF3rWHTK/SKJOiRQXRJnsapFYsgpW54dTFgId7dfI6VtTtStIvWXQ==
X-Received: by 2002:a05:600c:d7:: with SMTP id u23mr15050823wmm.145.1576277254963;
        Fri, 13 Dec 2019 14:47:34 -0800 (PST)
Received: from [10.230.28.123] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l17sm11739281wro.77.2019.12.13.14.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 14:47:34 -0800 (PST)
Subject: Re: [PATCH] ARM: dts: NSP: Use hardware I2C for BCM958625HR
To:     Ray Jui <ray.jui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191213195102.23789-1-f.fainelli@gmail.com>
 <667acf12-cff3-8955-8849-b99db50375bb@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Message-ID: <c11853ec-0a0b-4621-c0cb-e366d36c9592@gmail.com>
Date:   Fri, 13 Dec 2019 14:47:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <667acf12-cff3-8955-8849-b99db50375bb@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/2019 2:11 PM, Ray Jui wrote:
> 
> 
> On 2019-12-13 11:51 a.m., Florian Fainelli wrote:
>> Now that the i2c-bcm-iproc driver has been fixed to permit reading more
>> than 63 bytes in a single transaction with commit fd01eecdf959 ("i2c:
>> iproc: Fix i2c master read more than 63 bytes") we no longer need to
>> bitbang i2c over GPIOs which was necessary before to allow the
>> PHYLINK/SFP subsystems to read SFP modules.
>>
> 
> This is good to hear!
> 
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   arch/arm/boot/dts/bcm958625hr.dts | 15 +++++----------
>>   1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm958625hr.dts
>> b/arch/arm/boot/dts/bcm958625hr.dts
>> index a2c9de35ddfb..536fb24f38bb 100644
>> --- a/arch/arm/boot/dts/bcm958625hr.dts
>> +++ b/arch/arm/boot/dts/bcm958625hr.dts
>> @@ -55,18 +55,9 @@
>>           priority = <200>;
>>       };
>>   -    /* Hardware I2C block cannot do more than 63 bytes per transfer,
>> -     * which would prevent reading from a SFP's EEPROM (256 byte).
>> -     */
>> -    i2c1: i2c {
>> -        compatible = "i2c-gpio";
>> -        sda-gpios = <&gpioa 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> -        scl-gpios = <&gpioa 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> -    };
>> -
> 
> So I suppose GPIO 4 and 5 from the 'gpioa' controller are tied to the
> same SCL/SDA pins from i2c0 and they are internally muxed, right?

Correct.

> 
> Is the mux to GPIO done automatically when pins are configured as GPIO,
> and therefore you don't require any additional changes to pinmux to make
> this work, after changing it back to use real I2C0 block below?

Yes indeed.

> 
>>       sfp: sfp {
>>           compatible = "sff,sfp";
>> -        i2c-bus = <&i2c1>;
>> +        i2c-bus = <&i2c0>;
>>           mod-def0-gpios = <&gpioa 28 GPIO_ACTIVE_LOW>;
>>           los-gpios = <&gpioa 24 GPIO_ACTIVE_HIGH>;
>>           tx-fault-gpios = <&gpioa 30 GPIO_ACTIVE_HIGH>;
>> @@ -74,6 +65,10 @@
>>       };
>>   };
>>   +&i2c0 {
>> +    status = "okay";
>> +};
>> +
>>   &amac0 {
>>       status = "okay";
>>   };
>>
> 
> Change looks good to me.
> 
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>

Thanks!
-- 
Florian
