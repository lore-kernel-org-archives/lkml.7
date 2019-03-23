Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30A4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DAB20880
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 16:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKAfwb74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfCWQr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 12:47:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41430 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfCWQr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 12:47:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so4462162lja.8;
        Sat, 23 Mar 2019 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gZorbnuxvEX7uakfU7yC8xRnhyuSPN66D+HUVQZ5xHo=;
        b=AKAfwb74UvBiOOiP6qsW0Egguc18yROj0E/Onr5bl+/CTRoi4S3IKQEu2NffkJAIqX
         LP0XUYCtRkvukgzfWF4OQ043DvlBrqw4UMXE1R7iTuJmAOWFJuy+WpzoFgOLk9DufTj4
         BclJZZbPst+pChfYJgUl1Qfr9Q0manCH9luK8OCmj1GytVf5atpOOt3ih93g//4wVyRN
         HLzQZvJair/y8PasNm/c+5e2wjxsQin9hrBoAHNLIkJpeTPzlKofNB0MEpHWX2RWuuOR
         FAXYu1cFP271NfiTLOeD8wYiVN2uYDX8EhlZAo3Eis/6W076UxvjcKc5EW88tLQhGiHE
         7vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gZorbnuxvEX7uakfU7yC8xRnhyuSPN66D+HUVQZ5xHo=;
        b=e0g61syTrUzcXn7GqoWtX1ZjGvVu5s678ebpzlSjPDn6xyzmqC/nKHdoZ2Ot6xIv8b
         nDkp+y0DxYA5UANMlL6LSLUFvsHT1Vpdl+jhtYpnnlmBEw5VEjfQtu5DNV7pRrZ4v+jw
         sRFb6A/kj7eLV8cWmJ2PtnXRSBtM/xeFkQd7TLEQQoI1Yau4Hp95dJ6gyuGHmNkPXz/V
         tQS9HeQqOVIJRWDXO/w9jkkV1QboL1XTi/2GMrSSnFkF4s4gJI5gtPf928ry+9HcIbTW
         d5gPA2qi8yDngSNqEhcCJ2U/BYCgdFNPdv/bTHyOajqHZN47LLAiDkCUn+WHsUocUr3a
         USKw==
X-Gm-Message-State: APjAAAWxXnrx7coTwmYCJ0w9DAlytJgy1n/ajeSXdqURANI+00yggzWZ
        2HLaOWB36r+5AhTAxKx7H5IE4pRL
X-Google-Smtp-Source: APXvYqzElRB9Hm6tbBmMS36XM9RfZ3NrrU5ylarBWQBgCY346CdfJ/esr6zgXPDo7+4/9rMp0j5ydw==
X-Received: by 2002:a2e:7215:: with SMTP id n21mr9046506ljc.105.1553359644500;
        Sat, 23 Mar 2019 09:47:24 -0700 (PDT)
Received: from [192.168.1.18] (chi4.neoplus.adsl.tpnet.pl. [83.31.6.4])
        by smtp.gmail.com with ESMTPSA id y17sm483866ljd.54.2019.03.23.09.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 09:47:23 -0700 (PDT)
Subject: Re: [PATCH 3/4] mfd: ti-lmu: Remove LM3532 backlight driver
 references
To:     lee.jones@linaro.org
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-3-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <8769a95d-179f-6219-0a63-9dd623cdd297@gmail.com>
Date:   Sat, 23 Mar 2019 17:47:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321142838.22985-3-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Can we have your ack for this going via LED tree, please?

Best regards,
Jacek Anaszewski

On 3/21/19 3:28 PM, Dan Murphy wrote:
> Remove the LM3532 backlight driver references from the ti-lmu
> code as dedicated driver support is available.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v5 - No changes - https://lore.kernel.org/patchwork/patch/1050411/
> 
> v4 - No changes - https://lore.kernel.org/patchwork/patch/1050123/
> v3 - No changes - https://lore.kernel.org/patchwork/patch/1049025/
> v2 - Removed LM3532 register definitions from ti-lmu-register - https://lore.kernel.org/patchwork/patch/1048808/
> 
>   drivers/mfd/ti-lmu.c                | 11 --------
>   include/linux/mfd/ti-lmu-register.h | 44 -----------------------------
>   include/linux/mfd/ti-lmu.h          |  1 -
>   3 files changed, 56 deletions(-)
[...]
