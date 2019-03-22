Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A650FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2D721900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy1h16B/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfCVQkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:40:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38756 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfCVQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:40:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id v1so1888685pgi.5;
        Fri, 22 Mar 2019 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2cYtadt0nqp0mNbCfBBg6WJsW9hVJ4H21hlitbkFfxw=;
        b=Yy1h16B/zDe1a+OAuZbtTwKSvcAehI3nBh6SPBRtWkzXGqnc6TQMbeK2cXzrH+sY/q
         e5BxuqTVXQlBknGAEzq/jBoxxnoxU+wpoZ1MNEfbhgeqSasAbqBr7ygFYk1NmQ9+/6iv
         rxFxHSqzgQgD8THVZrucId77BiiibziF0KNFOd7SXNNTGYyUD/a0NifIykLMjYszWVMg
         1fkChTKgottouidwWj3A03OaE2wlCbTXuP06kDRzZGjcvwygyeJZ+WhrP4Ruw8eJlW6f
         nQmyeCWr35dTpC1UX7UOESmJWq0HgECnQ30rYOOTKqGShvn+xwVI6d+OTI8N9SKy1bPb
         3b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2cYtadt0nqp0mNbCfBBg6WJsW9hVJ4H21hlitbkFfxw=;
        b=nW1KO9HDri3luMnMdY7usJAb2TCD84YdHKhgeJRBrtYRgJrhUZUpxrsr6JxG++FzQx
         jrDjJ/FiMfOaAUIiJYxqVLjcduEkqSIZqJhvPwUVl6u9/A921UpZIK3Tfcn/hJ6ry+rU
         Ryqa3pFwipoSTHNEl8A4PGfxxGU0Fj6VBda3tf/ZQ6X5d4gLM2nY10s9U+mkOTZd4ot7
         QbV8FekPA63i69i9BrgNz6uMghu0CQeQHMYfP6cnmPC5+c9+TZ6+asvf5rufW35CjAnw
         uzkuxszVDpIjUSDhECPWWDZzVoI5+ZJia2XNTVclG1woZHNwfi7D6fwb+H/hVs0J182O
         2NrA==
X-Gm-Message-State: APjAAAW568pBWhHSTmFLrm6ewM5BUKMgd9ohJH6tyrNz2SILL0lyLB+O
        B+JsXlpbKLeFO2XgKmACwb4=
X-Google-Smtp-Source: APXvYqxFS1/+3cxTtZMoVNmKOh3r5aQxO4NV3N7eODQyNZ1wmpirBQA+F8afK4tTY/H01ew+92o8Ow==
X-Received: by 2002:a62:560f:: with SMTP id k15mr10059032pfb.231.1553272843896;
        Fri, 22 Mar 2019 09:40:43 -0700 (PDT)
Received: from [10.67.48.231] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id j1sm9428725pgp.84.2019.03.22.09.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 09:40:43 -0700 (PDT)
Subject: Re: [PATCH v5 0/8] iProc I2C slave mode and NIC mode
To:     Ray Jui <ray.jui@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <5c5ed177-0e9e-6271-518c-6956a7a6c554@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <c06896b8-d3dc-2d3e-1d12-b2f2c2a09410@gmail.com>
Date:   Fri, 22 Mar 2019 09:40:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5c5ed177-0e9e-6271-518c-6956a7a6c554@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 12:04 PM, Ray Jui wrote:
> Hi Wolfram,
> 
> Rob has reviewed all DT binding related changes from this patch series.
> Could you please help to review the I2C driver related changes when you
> have time?

Wolfram, did you queue those patches yet? The dt-binding patch has been
reviewed by Rob, therefore I am going to queue up patch 8 for the ARM
SoC pull request for 5.2. Let me know if that does not align with when
you plan on sending the i2c changes, thanks!

> 
> Thanks,
> 
> Ray
> 
> On 2/14/2019 9:57 AM, Ray Jui wrote:
>> This patch series adds the following support to the iProc I2C driver:
>> - Increase maximum read transfer size to 255 bytes
>> - I2C slave mode
>> - Polling mode
>> - NIC I2C mode
>>
>> This patch series is based on kernel v5.0-rc3 and available at:
>> https://github.com/Broadcom/arm64-linux.git
>> branch: i2c-slave-v5
>>
>> Changes from v4:
>>  - Add more detailed explanations in the device tree binding document
>>    changes, to address Rob's review comments
>>
>> Changes from v3:
>>  - Various minor fixes on commit messages and commits
>>  - Rebased to v5.0-rc3
>>
>> Changes from v2:
>>  - Address Ray's review comments.
>>
>> Changes from v1:
>>  - Rebased to Linux v5.0.0-rc2
>>
>> Ray Jui (1):
>>   dt-bindings: i2c: iproc: make 'interrupts' optional
>>
>> Rayagonda Kokatanur (5):
>>   i2c: iproc: add polling support
>>   i2c: iproc: use wrapper for read/write access
>>   dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
>>   i2c: iproc: add NIC I2C support
>>   arm64: dts: Stingray: Add NIC i2c device node
>>
>> Shreesha Rajashekar (2):
>>   i2c: iproc: Extend I2C read up to 255 bytes
>>   i2c: iproc: Add slave mode support
>>
>>  .../bindings/i2c/brcm,iproc-i2c.txt           |  17 +-
>>  .../boot/dts/broadcom/stingray/stingray.dtsi  |  18 +
>>  drivers/i2c/busses/Kconfig                    |   1 +
>>  drivers/i2c/busses/i2c-bcm-iproc.c            | 758 +++++++++++++++---
>>  4 files changed, 663 insertions(+), 131 deletions(-)
>>


-- 
Florian
