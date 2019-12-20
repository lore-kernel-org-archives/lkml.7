Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8367C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFC424679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLmOQumr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLTK1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:27:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51854 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfLTK1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:27:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so8392471wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 02:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n0d7A9vcdYOjJrptRZ7l/Py3puK9fLPBMNKquvCDBS8=;
        b=vLmOQumrckuy/uRuCU6yj4xJmKBQPT49yE9Lmv9XbT/e4gBL/sCo8bZKZcNnCad6h0
         EzThNeJ09aW/PlljQ59lBAJU4BTFH/sJ04aytmPiYK8I+kWIlRR7MA+jfxfIdYPt0QA+
         nWQBF3Yni8tdLR3XUHykRBHWmfvqVXQaGhEGSRHgOQSSpQYvqCdZLAV47obw4KLsYyi9
         53sRvzHkBz6I54lzaP/B2akmRLThzlzDdlRePi86UJs02KQobisvc7mvwOLdjBx6VCTX
         127qaleSFwWS0mM1so33m0aD7tPk56PVtyMWniexnnQ7x7CARkRBFdSJ9Z+wu8UimdzM
         7p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n0d7A9vcdYOjJrptRZ7l/Py3puK9fLPBMNKquvCDBS8=;
        b=oHj7JtglBEr0gXbCUz80v9iNkx9fnU1gQyCAF+4flVoNramYcnrNi+E8GCMNF7Dedm
         0xATSL34uDymXfCPivTw85g62IXerqnudS1MgCpfv7JB+JW58dXMiYHGpklh2+kNT10L
         6xsFf3CKSsQqfcN/1vt+hM1duI3agqw6bsLvun1h0dtar290tSHyau8S5F4EXCERzWKQ
         K5pXKSFNmtQGuq9IOGNheo64/HlGhsdvmq5jwqkHBffwJd7mshVFzC0w9GERUppDsPxt
         CRlx66E7LJK/fwtSa2sAeNKuX3ZYXJNjWN5rHa0sO1yryQp5Co2Xp/MGHHk0sRXmzd9f
         Y1QA==
X-Gm-Message-State: APjAAAX50p0cCACVn3xJ4Fmo75NsjAwz5jw1oA1HC44BZjsWhMMgTS9X
        dMjysJSwRHa+KbXM6c/agbXU/Q==
X-Google-Smtp-Source: APXvYqyVpEoQ0ffKKhojLArPhnqkXcZq4Qsi1o1iUUiVSKzewceGkEew3wQ3Hvpb8P8F0HzsUlM/ag==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr15254728wmj.75.1576837643320;
        Fri, 20 Dec 2019 02:27:23 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id r68sm9232066wmr.43.2019.12.20.02.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 02:27:22 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH v6 02/11] mfd: wcd934x: add support to
 wcd9340/wcd9341 codec
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, lee.jones@linaro.org, linus.walleij@linaro.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org,
        devicetree@vger.kernel.org, spapothi@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20191219103153.14875-1-srinivas.kandagatla@linaro.org>
 <20191219103153.14875-3-srinivas.kandagatla@linaro.org>
 <af48cd71-fa1a-dbc5-0e88-e315ea13c28c@linux.intel.com>
 <db36d6d7-40a2-bbd2-f299-838abf4d92cc@linaro.org>
 <4492b71e-9923-365c-f22c-3766e2d5bae2@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3fa4997f-4409-97f6-ba10-a87013383eb7@linaro.org>
Date:   Fri, 20 Dec 2019 10:27:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4492b71e-9923-365c-f22c-3766e2d5bae2@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/2019 20:05, Pierre-Louis Bossart wrote:
>>>
>> Note these are the child devices of the MFD SLIMBus device.
> 
> Ah ok. I guess the creation of those child devices when the parent 
> SLIMbus device reports PRESENT initially if fine, it's the part where 
> you remove them if the device loses sync or gets powered off which is 
> odd. And I guess technically you could still have race conditions where 
> a child device starts a transaction just as the parent is no longer 
> attached to the bus.

Losing power to SLIMBus device is very odd usecase and if it happens 
suggests that threre are bigger issues on the board design itself. This 
case should never happen. Even if it happens we would get timeout errors 
on every SLIMbus transactions.

> 
>>> I would however not remove the devices when the status is down but 
>>> only on an explicit .remove.
>>
>> Am open for suggestions but I would not like the child devices to talk 
>> on the bus once the SLIMbus device is down! Only way to ensure or make 
>> it silent is to remove.
> 
> it's as if you are missing a mechanism to forward the parent status to 
> the children so use remove() for lack of a better solution?
That is true. This gives bit more control on the slave device lifecycle.
Current solution works fine for now with less complexities across 
multiple drivers. I also agree that there is scope of improvement in 
future for this.

Thanks,
srini
