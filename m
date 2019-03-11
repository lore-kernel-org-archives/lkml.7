Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02945C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E392063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjqW43oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfCKRW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:22:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40684 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKRW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:22:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id g20so5103004wmh.5;
        Mon, 11 Mar 2019 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S42ZHBVqrORZjPFoVnjImtlMnGCQZSzZX6xRXE+K8qs=;
        b=DjqW43oiUYyyh4Wl8sxtFjJgFdpOoZuyeJhCgYlhhaZaAq4D8Dkoiycs3Ir9VafF7n
         8VnCvEXnGm/7OaRgbbOsSzNZD+aEYvNAhTmI3S88JhZtURhMe5/7C5YdDoPi0yFEvD76
         +HsdE1aCf3elMKiJTyiLFLTx5Ko0WD7hRe8+sNwGSlWy7U5tbyXAAYlVGydpYGDLPNG/
         +PSEBPy5DGStiZ4h+XZdQV/KYIIUcTiUHdhJ4u+lYYSMbz4GXeku3pKVukkxJguMJhv1
         8SljSfKR/aj8PKENsSlp7JWs64y6Ng57Q4+Bz2M8eAu+tP2kdUxb5phCRMsuObSeJzQ8
         AchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S42ZHBVqrORZjPFoVnjImtlMnGCQZSzZX6xRXE+K8qs=;
        b=UIJVrXX9SdzZtIcBG4DIdyqtqFwfbDRKJIsPUvm5HjyUtuecHu0RHYSB6VvcmcqV6/
         q+MX9rXeC0LB7ykIWaVO61qDlWu46jqD91r/asUMUhMaXTzEC9/xFQXCiM9A1fQ1K0M/
         QiAaHgaoLBTu/zRD2+zd5uTO226yTS2ZmayWUevy7AFXPKPKlKJ/151YKUY2vPXcZ5yU
         V5uWpbOJxPuIMF7PKAzhPkAyYa27JtK038tKOMqKvCGQFAmiVcx/yGn6rAc2KeMrFiCL
         TzAOb5MXblHq/HTC8dB6+j3pDZrih+aGtJbACG/oyI3Bl/CJyPYhQkF4Nez/v7EUWlZV
         zeaQ==
X-Gm-Message-State: APjAAAUkGGKzaYd3j4kevEmuj/Hwl1f6RD/k7GGnw+q1FlrRXkNoic5d
        LhyuG7y8FVUYJtipqWt/LavuO3bi
X-Google-Smtp-Source: APXvYqzAyqY3oLprC/BQxTfR5yf9BiI7u8FRVft0dLMxrhVY60iR/Z2CS1/fc9QjfymiNRrm/RWUqg==
X-Received: by 2002:a1c:c644:: with SMTP id w65mr85736wmf.19.1552324976648;
        Mon, 11 Mar 2019 10:22:56 -0700 (PDT)
Received: from [192.168.1.18] (cka136.neoplus.adsl.tpnet.pl. [83.31.76.136])
        by smtp.gmail.com with ESMTPSA id z129sm18215427wmc.33.2019.03.11.10.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 10:22:55 -0700 (PDT)
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        tony@atomide.com, lee.jones@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190307220947.20057-1-dmurphy@ti.com>
 <20190307220947.20057-4-dmurphy@ti.com>
 <8ac4d84f-c792-893d-fbae-fac88fac8631@gmail.com>
 <bb621d08-c192-0018-f67e-3f3262a71b6f@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <cf26b351-f2b5-8345-29b7-401153b5f0d7@gmail.com>
Date:   Mon, 11 Mar 2019 18:22:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <bb621d08-c192-0018-f67e-3f3262a71b6f@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

One more thing I forgot to mention before.

On 3/11/19 12:36 PM, Dan Murphy wrote:
> Jacek
[...]
> 
>>> @@ -0,0 +1,72 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/* TI LM3532 LED driver
>>> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>>> + */

Let's have "//" comments here.

>>> +#ifndef __DT_BINDINGS_LEDS_LM3532_H
>>> +#define __DT_BINDINGS_LEDS_LM3532_H
>>> +
>>> +#define LM3532_BL_MODE_MANUAL    0x00 /* "man" */
>>> +#define LM3532_BL_MODE_ALS    0x01 /* "als" */
>>> +
>>> +/* ALS Resistor Select */
>>> +#define LM3532_IMP_HIGH        0x00
>>> +#define LM3532_IMP_37K        0x01
>>> +#define LM3532_IMP_18_5K    0x02
>>> +#define LM3532_IMP_12_33K    0x03
>>> +#define LM3532_IMP_9_25K    0x04
>>> +#define LM3532_IMP_7_4K        0x05
>>> +#define LM3532_IMP_6_17K    0x06
>>> +#define LM3532_IMP_5_29K    0x07
>>> +#define LM3532_IMP_4_63K    0x08
>>> +#define LM3532_IMP_4_11K    0x09
>>> +#define LM3532_IMP_3_7K        0x0a
>>> +#define LM3532_IMP_3_36K    0x0b
>>> +#define LM3532_IMP_3_08K    0x0c
>>> +#define LM3532_IMP_2_85K    0x0d
>>> +#define LM3532_IMP_2_64K    0x0e
>>> +#define LM3532_IMP_2_44K    0x0f
>>> +#define LM3532_IMP_2_31K    0x10
>>> +#define LM3532_IMP_2_18K    0x11
>>> +#define LM3532_IMP_2_06K    0x12
>>> +#define LM3532_IMP_1_95K    0x13
>>> +#define LM3532_IMP_1_85K    0x14
>>> +#define LM3532_IMP_1_76K    0x15
>>> +#define LM3532_IMP_1_68K    0x16
>>> +#define LM3532_IMP_1_61K    0x17
>>> +#define LM3532_IMP_1_54K    0x18
>>> +#define LM3532_IMP_1_48K    0x19
>>> +#define LM3532_IMP_1_42K    0x1a
>>> +#define LM3532_IMP_1_37K    0x1b
>>> +#define LM3532_IMP_1_32K    0x1c
>>> +#define LM3532_IMP_1_28K    0x1d
>>> +#define LM3532_IMP_1_23K    0x1e
>>> +#define LM3532_IMP_1_19K    0x1f
>>> +
>>> +/* ALS Averaging Time */
>>> +#define LM3532_ALS_AVRG_TIME_17_92ms    0x00
>>> +#define LM3532_ALS_AVRG_TIME_35_84ms    0x01
>>> +#define LM3532_ALS_AVRG_TIME_71_68ms    0x02
>>> +#define LM3532_ALS_AVRG_TIME_143_36ms    0x03
>>> +#define LM3532_ALS_AVRG_TIME_286_72ms    0x04
>>> +#define LM3532_ALS_AVRG_TIME_573_44ms    0x05
>>> +#define LM3532_ALS_AVRG_TIME_1146_88ms    0x06
>>> +#define LM3532_ALS_AVRG_TIME_2293_76ms    0x07
>>> +
>>> +/* ALS input select */
>>> +#define LM3532_ALS_INPUT_AVRG    0x00 /* ALS1 and ALS2 input average */
>>> +#define LM3532_ALS_INPUT_ALS1    0x01 /* ALS1 Input */
>>> +#define LM3532_ALS_INPUT_ALS2    0x02 /* ALS2 Input */
>>> +#define LM3532_ALS_INPUT_CEIL    0x03 /* Max of ALS1 and ALS2 */
>>> +
>>> +/* Ramp Times */
>>> +#define LM3532_RAMP_8us        0x00
>>> +#define LM3532_RAMP_1024us    0x01
>>> +#define LM3532_RAMP_2048us    0x02
>>> +#define LM3532_RAMP_4096us    0x03
>>> +#define LM3532_RAMP_8192us    0x04
>>> +#define LM3532_RAMP_16384us    0x05
>>> +#define LM3532_RAMP_32768us    0x06
>>> +#define LM3532_RAMP_65536us    0x07
>>> +
>>> +#endif /* __DT_BINDINGS_LEDS_LM3532_H */
>>>
>>
> 
> 

-- 
Best regards,
Jacek Anaszewski
