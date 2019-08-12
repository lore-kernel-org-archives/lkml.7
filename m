Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCB9C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB79920644
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfHLRSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:18:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45667 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfHLRSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:18:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id q12so14990416wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pBmApiQS/+gQxohoTnkThlw2oRZGT6Jx6zrcPnHDklQ=;
        b=uI289dW/RX4ZrB2VLK7KfjPprvgcH5OZ/eTb+c0PYlerhqDcE08CdhMqX60VHgqbzp
         XMK0pvMQyacwKl58oOC1o04j2wk1I9VC+Mht5bOvidBJmpFveH2vf6PuBDssGwRlLyCc
         cP1dMqL/GnlAZcQliv0PXcUXN/x1avJfvv6cZbuYyz+DmJttzn+xXj3HzsBtsVe5uP8Z
         jRbJKnCfjhZMtDgnJmRa8vgqAT8GmjxAQGp70kPq+qDns6SYpHnll/HAtFFZ5j3nu1es
         lGYuWgCYJrEB2jvuSF5x5HlavC7gnV6ldogXJYoyGDwKVUlJJ1BY6M531tKRf8x2l64b
         yhyA==
X-Gm-Message-State: APjAAAU61nV0moHStxr6yY7SlKPZ9LECXEyQGy2SU5BrLOaIGWCXaCF0
        +Bil1/iQFXHTOJ3WFhiUcPy/4A==
X-Google-Smtp-Source: APXvYqzwJk21tvZbLfhDZjYO1RRyP+UbRZ7w5iO/fbLosDG72tal138bwmCjorD9+/+wHLlasZTdSA==
X-Received: by 2002:adf:e452:: with SMTP id t18mr5297027wrm.0.1565630327577;
        Mon, 12 Aug 2019 10:18:47 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id i93sm11419929wri.57.2019.08.12.10.18.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 10:18:46 -0700 (PDT)
Subject: Re: [PATCH] extcon-intel-cht-wc: Don't reset USB data connection at
 probe
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190808220129.2737-1-jekhor@gmail.com>
 <fbe20a5f-0f64-cadf-2c1e-88a468d54a07@redhat.com>
 <20190809151116.GD30248@jeknote.loshitsa1.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <492098ce-ec4c-a860-4625-27c410d7deb3@redhat.com>
Date:   Mon, 12 Aug 2019 19:18:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809151116.GD30248@jeknote.loshitsa1.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09-08-19 17:11, Yauhen Kharuzhy wrote:
> On Fri, Aug 09, 2019 at 01:06:01PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 8/9/19 12:01 AM, Yauhen Kharuzhy wrote:
>>> Intel Cherry Trail Whiskey Cove extcon driver connect USB data lines to
>>> PMIC at driver probing for further charger detection. This causes reset of
>>> USB data sessions and removing all devices from bus. If system was
>>> booted from Live CD or USB dongle, this makes system unusable.
>>>
>>> Check if USB ID pin is floating and re-route data lines in this case
>>> only, don't touch otherwise.
>>>
>>> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
>>> ---
>>>    drivers/extcon/extcon-intel-cht-wc.c | 16 ++++++++++++++--
>>>    1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
>>> index 9d32150e68db..3ae573e93e6e 100644
>>> --- a/drivers/extcon/extcon-intel-cht-wc.c
>>> +++ b/drivers/extcon/extcon-intel-cht-wc.c
>>> @@ -338,6 +338,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>>>    	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
>>>    	struct cht_wc_extcon_data *ext;
>>>    	unsigned long mask = ~(CHT_WC_PWRSRC_VBUS | CHT_WC_PWRSRC_USBID_MASK);
>>> +	int pwrsrc_sts, id;
>>>    	int irq, ret;
>>>    	irq = platform_get_irq(pdev, 0);
>>> @@ -387,8 +388,19 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>>>    		goto disable_sw_control;
>>>    	}
>>> -	/* Route D+ and D- to PMIC for initial charger detection */
>>> -	cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
>>> +	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
>>> +	if (ret) {
>>> +		dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
>>> +		goto disable_sw_control;
>>> +	}
>>> +
>>> +	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
>>> +
>>> +	/* If no USB host or device connected, route D+ and D- to PMIC for
>>> +	 * initial charger detection
>>> +	 */
>>> +	if (id == INTEL_USB_ID_FLOAT)
>>> +		cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
>>
>> The check here should be != INTEL_USB_ID_GND, when we are connected as
>> device we are charging from the host we are connected to and the port
>> we are connected to may be a CDP (charging downstream port) instead of
>> a SDP (standard downstream port) allowing us to charge at 1.5A instead
>> of 0.5A, also != INTEL_USB_ID_GND matches the condition used in
>> cht_wc_extcon_pwrsrc_event to determine if we should continue with
>> charger detection there.
> 
> Actually it should be checked as ((id != INTEL_USB_ID_GND) && (id !=
> INTEL_USB_RID_A)), to not interrupt connection if ACA used and our host
> is OTG A device (for example, if LiveCD boots from USB flash inserted
> into an ACA USB hub).

Right, except that cht_wc_extcon_get_id never returns INTEL_USB_RID_A,
so checking for that would be superfluous and also would be inconsistent
with what cht_wc_extcon_pwrsrc_event is doing, so for now please just test
for != INTEL_USB_ID_GND, if cht_wc_extcon_get_id ever starts supporting
RID_A then we should fix both cht_wc_extcon_pwrsrc_event and you new check
at that time.

Hmm, I now see that cht_wc_extcon_get_id currently only reports one of:
INTEL_USB_ID_GND or INTEL_USB_ID_FLOAT so == INTEL_USB_ID_FLOAT is
equivalent to != INTEL_USB_ID_GND still please check for 1= INTEL_USB_ID_GND
as that is what cht_wc_extcon_pwrsrc_event is doing.

>> Like your other patch I will try to give this one a  test-run tomorrow.

I've given this patch a test-run today and I can confirm that BC1.2 charger
detection still works fine on my device using this driver.

Regards,

Hans
