Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E048CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345A720880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYAW/Y0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfJ1X7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 19:59:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40566 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfJ1X7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 19:59:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id p5so1389144plr.7;
        Mon, 28 Oct 2019 16:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6PbNC9ZYBewrGx4YYy/4pVIAWb+IMk+47XVy1Sx5zzI=;
        b=HYAW/Y0L2chXTWqpU2iL0mEYEyFN8O5JV3K7uT5zi5MVAHM10rAzOumCdJH84zYxS+
         6KQq51xBpAp+0GQjRvOibReUcU59U3AUuy1kQUQ5CcdwbzgoBwp0KdeN6itX3xSo5UQt
         /mMMuxzxj/B7EGZayugehJU3wbrFEknjC+t+/sf5/LUs5Mr0rkWMLHvjdv6ao6IUbVCf
         mS/H6anHtrzQWKZmdnph7Hx4LDFc1h3T5W1gxadaykgczBZakktCleeu5MV+gy2d37/d
         ebNnz9/PmR6LKowLihYoAiAvHmgj3N+3IbUVfnIaVRrnL8N4c6OjMLxR/1QN5mTnFtKz
         15Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6PbNC9ZYBewrGx4YYy/4pVIAWb+IMk+47XVy1Sx5zzI=;
        b=nzVcVyl5WJ9KjEHBs6JYoHAlCHcWk51sKAlew5lxYTUou5tIE9aVnEPO+r/fjyjuYM
         X2RUBriw6muwmQvaviBod0WQAhfUwRr2rOrqE95sI+oq2v4BueuhoZopBaPIYmA/YDcZ
         yYK6RlxOQkJU+jX8NGE+tiIf+sHN3S878XixHj760CqgbqFGHolioazrSYx2zC0xOFUS
         f/KfT79YR/HhbxxFZt/duAcs7EOKpA8aTuUZnnesB2rq70RpqVrjHers2T9VtrMSTunM
         L8s64pnmTwFSn8CekXc+yiWVn4XC9Q2s0CqUgVNUWDPLuHaBN4buyvcZJ0/Z+jHxJcYc
         /Lpw==
X-Gm-Message-State: APjAAAU3Dr/zQ4g8kFLPAuTgfEmm/eVsRuzLycqp+2OeGKohHvHh0QOL
        ZkN4Bo1dc4W7OvSElFluZH8=
X-Google-Smtp-Source: APXvYqxHQOFG5/pQ1j8cv44WDxjt9j7KSDG8Izwx7Veg0LydX0N9MI97H/fzaTvx1p1mbLvx6KdoyA==
X-Received: by 2002:a17:902:7089:: with SMTP id z9mr751398plk.51.1572307184139;
        Mon, 28 Oct 2019 16:59:44 -0700 (PDT)
Received: from [172.30.89.111] (sjewanfw1-nat.mentorg.com. [139.181.7.34])
        by smtp.gmail.com with ESMTPSA id r33sm579115pjb.5.2019.10.28.16.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 16:59:43 -0700 (PDT)
Subject: Re: [PATCH 2/2] dt-bindings: timer: imx: gpt: Add pin group bindings
 for input capture
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" 
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191016010544.14561-1-slongerbeam@gmail.com>
 <20191016010544.14561-3-slongerbeam@gmail.com> <20191027212121.GA3049@bogus>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <2daa37a6-83a7-ec08-b89c-a07268b3ea4a@gmail.com>
Date:   Mon, 28 Oct 2019 16:59:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191027212121.GA3049@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for reviewing.

On 10/27/19 2:21 PM, Rob Herring wrote:
> On Tue, Oct 15, 2019 at 06:05:44PM -0700, Steve Longerbeam wrote:
>> Add pin group bindings to support input capture function of the i.MX
>> GPT.
>>
>> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
>> ---
>>   .../devicetree/bindings/timer/fsl,imxgpt.txt  | 28 +++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
>> index 5d8fd5b52598..32797b7b0d02 100644
>> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
>> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
>> @@ -33,6 +33,13 @@ Required properties:
>>              an entry for each entry in clock-names.
>>   - clock-names : must include "ipg" entry first, then "per" entry.
>>   
>> +Optional properties:
>> +
>> +- pinctrl-0: For the i.MX GPT to support the Input Capture function,
>> +  	     the input capture channel pin groups must be listed here.
>> +- pinctrl-names: must be "default".
>> +
>> +
>>   Example:
>>   
>>   gpt1: timer@10003000 {
>> @@ -43,3 +50,24 @@ gpt1: timer@10003000 {
>>   		 <&clks IMX27_CLK_PER1_GATE>;
>>   	clock-names = "ipg", "per";
>>   };
>> +
>> +
>> +Example with input capture channel 0 support:
>> +
>> +pinctrl_gpt_input_capture0: gptinputcapture0grp {
>> +	fsl,pins = <
>> +		MX6QDL_PAD_SD1_DAT0__GPT_CAPTURE1 0x1b0b0
>> +	>;
>> +};
>> +
>> +gpt: gpt@2098000 {
> timer@...

Ok.

>
> I don't really think this merits another example though.

Ok.

But for version 2 of this patch-set I'd like to run some ideas by you.

Because in this version I did not make any attempt to create a generic 
timer capture framework. I just exported a couple imx-specific functions 
to request and free a timer input capture channel in the imx-gpt driver.

So for version 2 I am thinking about a simple framework that other SoC 
timers with timer input capture support can make use of.

To begin with I don't see that timer input capture warrants the 
definition of a new device. At least for imx, timer input capture is 
just one function of the imx GPT, where the other is Output Compare 
which is used for the system timer. I think that is likely the case for 
most all SoC timers, that is, input capture and output compare are 
tightly interwoven functions of general purpose timers.

So I'm thinking there needs to be an additional #input-capture-cells 
property that defines how many input capture channels the timer 
contains, where a channel refers to a single input signal edge that can 
capture the timer counter. The imx GPT has two input capture channels (2 
separate input signals).

For example, on imx:

gpt: timer@2098000 {
	compatible = "fsl,imx6q-gpt", "fsl,imx31-gpt";
	/* ... */
	#input-capture-cells = <1>;
	pinctrl-names = "default", "icap1";
	pinctrl-0 = <&pinctrl_gpt_input_capture0>;
	pinctrl-1 = <&pinctrl_gpt_input_capture1>;
};


A device that is a listener/consumer of an timer capture event would then refer to a timer capture channel:

some-device {
	/* ... */
	timer-input-capture = <&gpt 0>;
};


Is this a sound approach? Let me know what you think.

Thanks,
Steve

