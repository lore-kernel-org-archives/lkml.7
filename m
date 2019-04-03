Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D27C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8CB2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CQ68c4Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDCU5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:57:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34375 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfDCU47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:56:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so87368pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Hw1RdLC48PlY+lGZch7dM+23TqqAuAY/QZopAMVcnQ=;
        b=CQ68c4UcKrgU0CvkR84+nhHjX2paop8yXIs6js68qPYFPzp7Tk/Ze80ofspH5OCRas
         kafRwD94zIvISuFd90/xnLJxn4gbBqGili3pEMnDVmaPPyalJDoVI5jJWTPY/pcyYRjL
         wzKLdVd8D50p1tfSc//SGfb6/z4HFoDeNr7rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Hw1RdLC48PlY+lGZch7dM+23TqqAuAY/QZopAMVcnQ=;
        b=jCEJ9HeiJg1JG3oJsxs3pwxkQFervsVQDirkWSWh9jqtI4xgwYK6Ib31ZkH7Ce6wOH
         91PsksMU68OE9YUGkfV+88ely5r0S2ZMNCXimM/kgAmntyd33+W5AE3fP3QoyJpWeJ4I
         heqCfBPBHYghWc0vo3DMaa7NOcHnI6Buw1i28MQTmzGPSjfjgTXwXaX9UPUiYWGcv2F5
         CsJRpiZHYGkgH2x0lfwyUqVlSyfWlJT96OZa0Km4QJ5uHh8kVUH9780ggAvJtQIYBQcI
         Zs/ok01LnyQjfUEJJzQidqs9ye9MPJAETyAL3b5EYyTMlrOj3PCqPGu/YkJ04/1awkL/
         ULhg==
X-Gm-Message-State: APjAAAVnt1KeWhZOO2Sb+jYdoUcwTqYXFErKFcmyJNvxjf64wNbmYyON
        aE94wK8xBd/ls8RdIR1bLrkMnw==
X-Google-Smtp-Source: APXvYqyGwrX1IAAoA+sSw3Ty5He3L7IQvEYql8lyChrR8rp6TrlLTEuc+bT0nbjP6i5udcUyNVJEEw==
X-Received: by 2002:a65:4108:: with SMTP id w8mr1839285pgp.236.1554325018477;
        Wed, 03 Apr 2019 13:56:58 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 10sm24798222pft.83.2019.04.03.13.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 13:56:57 -0700 (PDT)
Subject: Re: [PATCH v6 0/9] iProc I2C slave mode and NIC mode
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
 <20190403204423.btgtke3tmt7pkr3j@ninjato>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <a34e914a-ac8e-421e-f75c-f595bc678219@broadcom.com>
Date:   Wed, 3 Apr 2019 13:56:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403204423.btgtke3tmt7pkr3j@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 4/3/2019 1:44 PM, Wolfram Sang wrote:
> On Tue, Apr 02, 2019 at 06:18:21PM -0700, Ray Jui wrote:
>> This patch series adds the following support to the iProc I2C driver:
>> - Increase maximum read transfer size to 255 bytes
>> - I2C slave mode
>> - Polling mode
>> - NIC I2C mode
>>
>> This patch series is based on kernel v5.1-rc3 and available at:
>> https://github.com/Broadcom/arm64-linux.git
>> branch: i2c-slave-v6
>>
>> Changes from v5:
>>  - Address various comments from Wolfram
> 
> In the future, please write in detail what you changed. I review so many
> patches that I can't recall all my comments on every patch.
> 

Sure will do next time.

> That being said, all patches applied to for-next, thanks!
> 

Thanks!

> Can be fixed incrementally, my code checkers complain about:
> 
>     CPPCHECK
> drivers/i2c/busses/i2c-bcm-iproc.c:720:14: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
>     val |= 1 << M_TX_WR_STATUS_SHIFT;
>              ^
> drivers/i2c/busses/i2c-bcm-iproc.c:847:13: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
>  val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
>             ^
> drivers/i2c/busses/i2c-bcm-iproc.c:998:13: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
>  val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
> 

I'll submit an incremental patch to fix the above warnings. I think we
can convert all '1 << XXX' syntax in this driver to 'BIT(XXX)'. It will
fix all of the above warnings and make the code more readable.

Thanks,

Ray
