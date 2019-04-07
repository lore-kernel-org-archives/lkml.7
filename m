Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41146C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 18:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015A62083E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 18:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju0ycsMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDGSbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 14:31:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32811 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfDGSbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 14:31:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so13727984wrp.0;
        Sun, 07 Apr 2019 11:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+CtxHaZEkWfYxSkNn1dVnGIsGIka2xuVMKBnTnxAjM0=;
        b=ju0ycsMkUW9hYg2VxaRmM4EjgJ9Q6i3pK1KWf1+8yDx8CsUyjcGcBi5Z6Q47n8ekde
         nud/9ergfqJmGIEpU9S+TG/SHEA+VrJbM1/4f4qzTFcbBK0rxEJ55avRHcnTrNt8MrWY
         f+EISSr05IoNdkIA2ekByrU47eKsHyZo0E3jN1Crx9qsEcA1hLcRsekxHAeFGni9YXIf
         viyBbO0g6aGanZvd2FVeT/0webkZuvUMk2SOBe6EW8hNyqwF09YzykSrPyfqbD0wpEzP
         NOGj58HE/a0NPXVL/7ldrywICPd2v4YH5ux0rTbk/amRshuNqFcJd4PhwInYs/emcIhV
         h9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+CtxHaZEkWfYxSkNn1dVnGIsGIka2xuVMKBnTnxAjM0=;
        b=unqOT7FU8oZYTaROzOoI3Ly0lgColW9U29C0FK0+puFnmWDm4r6ZBjgcdBEr6x+r/2
         IFkXgPwdJJMc82i5X5+XQqrzIYogdbpsdwyP16p62Baf3J9K8rZ5qf3CtsWMofirkCOW
         6NrjjzErTy9s7CpY+8EW++sSD2aKOeBMUot5SRcFdl2PpAGeVz13PGgSmm/WU3Ja37/U
         MJkfkcLPoQRhMrtwDcWRAQBdYllyZyDeHrYwnslNrBXuUYzchCNa99SonZx3LSP8SZdu
         /rMuQjCC8aXZX+811u8y8oSJ+j2Bq/n3jK9MwX8D4DlXHAQGxxEQkJ2Bk8tHaAEqtdXs
         cj4w==
X-Gm-Message-State: APjAAAULFSrX/SUgFDvm5NnjdEks15LweLPehCK4nH1F7ZBi86nEawA+
        z7rJ7EDcvxZU3LH1KfmIK0sfN/XEItA=
X-Google-Smtp-Source: APXvYqyQBWq55kOF7gZRdue/7s+Uzd3UZv7cnTIFbNqbgkRWDLXWCfLEMyGVzzXZPi22xYBgTrtq6g==
X-Received: by 2002:a05:6000:1286:: with SMTP id f6mr10604528wrx.93.1554661865551;
        Sun, 07 Apr 2019 11:31:05 -0700 (PDT)
Received: from [192.168.1.19] (bkw193.neoplus.adsl.tpnet.pl. [83.28.190.193])
        by smtp.gmail.com with ESMTPSA id b204sm14841845wmh.29.2019.04.07.11.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 11:31:04 -0700 (PDT)
Subject: Re: [PATCH 2/4] ARM: dts: omap4-droid4: Update backlight dt
 properties
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-2-dmurphy@ti.com>
 <f9d80ad1-d80c-bf77-5e0b-1e02a1b74200@gmail.com>
 <20190404220013.GG49658@atomide.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <eeb1ba10-302b-d81e-e5ae-129c79ef7b66@gmail.com>
Date:   Sun, 7 Apr 2019 20:31:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404220013.GG49658@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/19 12:00 AM, Tony Lindgren wrote:
> * Jacek Anaszewski <jacek.anaszewski@gmail.com> [190404 20:12]:
>> Tony,
>>
>> On 3/21/19 3:28 PM, Dan Murphy wrote:
>>> Update the properties for the lm3532 device node for droid4.
>>> With this change the backlight LED string and the keypad
>>> LED strings will be controlled separately.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>
>>> v5 - No change - https://lore.kernel.org/patchwork/patch/1050409/
>>>
>>> v4 - No change - https://lore.kernel.org/patchwork/patch/1050125/
>>> v3 - updated keypad label on v1 comment - https://lore.kernel.org/patchwork/patch/1049023/
>>> v2 - Fixed ramp-up and ramp-down properties, removed hard coded property values,
>>> I did not change the label as it is undecided what it could be - https://lore.kernel.org/patchwork/patch/1048806/
>>>
>>>    arch/arm/boot/dts/omap4-droid4-xt894.dts | 26 ++++++++++++++++--------
>>>    1 file changed, 18 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
>>> index e21ec929f096..aea206f04f76 100644
>>> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
>>> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
>>> @@ -383,20 +383,30 @@
>>>    };
>>>    &i2c1 {
>>> -	lm3532@38 {
>>> +	led-controller@38 {
>>>    		compatible = "ti,lm3532";
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>>    		reg = <0x38>;
>>>    		enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
>>> -		lcd_backlight: backlight {
>>> -			compatible = "ti,lm3532-backlight";
>>> +		ramp-up-us = <1024>;
>>> +		ramp-down-us = <8193>;
>>> -			lcd {
>>> -				led-sources = <0 1 2>;
>>> -				ramp-up-msec = <1>;
>>> -				ramp-down-msec = <0>;
>>> -			};
>>
>> Since I'll be creating integration branch for this series,
>> and it would be good to have this patch in it too, then
>> I can do the amendments by myself:
>>
>>> +		lcd_backlight: led@0 {
>>> +			reg = <0>;
>>> +			led-sources = <2>;
>>> +			ti,led-mode = <0>;
>>> +			label = "backlight";
>>
>> s/backlight/:backlight/
>>
>>> +			linux,default-trigger = "backlight";
>>> +		};
>>> +
>>> +		led@1 {
>>> +			reg = <1>;
>>> +			led-sources = <1>;
>>> +			ti,led-mode = <0>;
>>> +			label = "platform::kbd_backlight";
>>
>> s/platform::kbd_backlight/:kbd_backlight/
> 
> Yes makes sense to me.
> 
>> and then send you a pull request.
>>
>> Would you be OK with that?
> 
> Sure go for it. Here's my ack for the changes:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> And then for the one liner to fold in below:
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> 8< -------------
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -214,7 +214,6 @@
>   
>   		width-mm = <50>;
>   		height-mm = <89>;
> -		backlight = <&lcd_backlight>;
>   
>   		panel-timing {
>   			clock-frequency = <0>;		/* Calculated by dsi */
> 

Folded in, thanks. Beside that, I also removed lcd_backlight DT
labels from both DT bindings and dts, since it is now unused
and misleading.

-- 
Best regards,
Jacek Anaszewski
