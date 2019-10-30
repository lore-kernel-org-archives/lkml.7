Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9897DCA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 02:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623F02086D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 02:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPlnOSEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfJ3CAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 22:00:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39663 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfJ3CAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 22:00:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id t12so212474plo.6;
        Tue, 29 Oct 2019 19:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4D0rSlERGCFg+HpPsc22n7LM+0fvKRRRI5LIsVOytZs=;
        b=kPlnOSEFYvjvNe+/OznUbYQJqwKtp3lF/al1O8JlJtS+0XL9rPvJ87r97ZvdCTBsi5
         MJ0O8OhYwzUFiHHklCGf5gobsgOyxBKXLxgdHBvIeG7B6CbGIEctpz7jPIZ4gVVN9lo8
         e/SMNfQz8X/gF1dKFtQZ0W2PvtWvtdRQTzlDW7N0B+zlB5rHqE+/OBJq0jzva2GcbTDW
         3meHJc18Ph4ciGRlGaNpX8zLoRI/gPwEXVpQ5qfLwMgK8ACadwmnGSMdAxeYvYHqCDf7
         m9H1uhihuFaKUyWJ/APcNunpWA6e7tM3PK2W5KQX/IoAvnULJsT5aJPcttTFNV0xrljE
         R+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4D0rSlERGCFg+HpPsc22n7LM+0fvKRRRI5LIsVOytZs=;
        b=fCR0ld6jLmcyjA6LOdMuCdiUPm4G2gs7+oeAerHbRiej6ghiiNq/JAxTUJ6s4jhcw8
         EoTAcyrdDLDyMYJWSCaSPXMetlQ5DHTfwdgKljAuMVU9ueb5dCDRCnpZElx8nWG98IAd
         BqVMOpiPPo1sGLSZU+qoniwcxKvWEscNa5yfl5I0bONooE8+JbousgKkKn1jPD67/kmX
         qV2N+Sw2VK9aCeYyt7Pbpnlwhfy76lnKKIikUT/fpE/pbI57awOH1YPpXaFVCN+g61fj
         fwXSu6tPhU5NqT6udlXE1XmsnDZ3V0whKls5qBMGwu9P/fWAUK4tDsnCi94M4xjogHwb
         F+2A==
X-Gm-Message-State: APjAAAV8nCaBpCeQ9UediVePnA4RI5e+UtNreOonkQhuCwC+2FhdbIl0
        q4yilRS4KTSnymhbCAr+khP6KRxx
X-Google-Smtp-Source: APXvYqzGBAiKExeeLxijQTKVrm2LZ9v6yQdLvEB9xYpsjKHx10zoEGZB6ZnEqBgozW66wfdGEtiP/A==
X-Received: by 2002:a17:902:7784:: with SMTP id o4mr1893970pll.111.1572400814949;
        Tue, 29 Oct 2019 19:00:14 -0700 (PDT)
Received: from [192.168.1.60] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id 184sm420534pfu.58.2019.10.29.19.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 19:00:14 -0700 (PDT)
Subject: Re: [PATCH V2 7/7] USB: serial: f81232: Add gpiolib to GPIO device
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-8-hpeter+linux_kernel@gmail.com>
 <20191023122208.GW24768@localhost>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <ef91b42d-e81d-ecdd-c688-0cb3f0b94906@gmail.com>
Date:   Wed, 30 Oct 2019 10:00:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023122208.GW24768@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Johan Hovold 於 2019/10/23 下午 08:22 寫道:
> On Mon, Sep 23, 2019 at 10:24:49AM +0800, Ji-Ze Hong (Peter Hong) wrote:
>> The Fintek F81534A series contains 3 GPIOs per UART and The max GPIOs
>> is 12x3 = 36 GPIOs and this patch will implements GPIO device as a
>> gpiochip to control all GPIO pins even transforms to transceiver pins.
> 
> Depending to your answer to my question whether these pins are truly
> general purpose or not, this may not be the right interface.

Our F81534A series contains F81532A/534A/535/536. For the following link
of F81534A pin-out:
	https://imgur.com/a/AZHqQ1N

We had 2 type about GPIO pins, MODEx_y & GPIOxx. All MODEx_y & GPIOxx
are GPIOs and can be controlled by GPIO device, but they had some
difference about usage.
	MODEx_y:
		1. 3 pins(x: 0/1/2) can be access by UART port y.
		2. Used to control UART's transceiver normally, but it
		   also can be configure as GPIO when UART disabled by
		   H/W (DTR strap to GND).
	GPIOxx:
		1. Access only by GPIO device.

The series patch only support RS233 mode for all serial port, So we'll
direct set all MODEx_y to (0/0/1) for our demo board for default. If
user really want to use the pin, we had provide the gpiolib with GPIO
device, but we'll recommend user to use GPIOxy first.

Is any suggest about this ? Could I maintain this for this series patch?

>> +
>> +	status = devm_gpiochip_add_data(&intf->dev, &priv->chip, priv);
>> +	if (status) {
>> +		dev_err(&intf->dev, "failed to register gpiochip: %d\n",
>> +				status);
>> +		return status;
>> +	}
> 
> Have you tried disconnecting the device with gpios requested? This used
> to break gpiolib, but was fixed. Just want to make sure it hasn't
> regressed.

I had try export GPIOs and detach the F81534A in kernel 5.0.0, it seems
no problem. Is any link about this issue for me to do more test ?

Thanks

-- 
With Best Regards,
Peter Hong
