Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB61C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA12213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zNS6ufP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbfDAHS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:18:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39021 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731879AbfDAHS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:18:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so4096072pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 00:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4jGZqdJMpFmaiFHzg/9PJMHH+esyMQhlQ43/fZLDXWE=;
        b=zNS6ufP4NTK/EEos4lVQUUsZ/xpVuuiirIOHoXbO40kkAxiDEodDK93dwxH5W+i4dn
         3Igw/jzYbgKkjJpVAxOhc8LNXAwcckXUF3T+roK6sq0n2D4t2KFMiR7KgfTD15W+jZOg
         K3DtYfxNNDY4OlELiw9Bh7XXn8M03+WEP06oFFVRtrqbd/GBhzyWiXFn12iL9dLQ/JMw
         2oW+vkoV+F7PFpi7lUi71GFeA3uEM4UK8kmFBqL0IC7xi5ZuuP46w6YRHNOtthZw8209
         1U1htW2Fb5Y3hszi+n6O+qpapenfZ5WppS9wV2pTfrPcXugro7OI/azldmubxkeO4WQF
         LDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4jGZqdJMpFmaiFHzg/9PJMHH+esyMQhlQ43/fZLDXWE=;
        b=MGEwZIP2/UAiLHjzoHzK68cZUqrwWXPdcDBfmDO/HbyV7KwcwPcSu7w+ln9BneL3sz
         Ce3oFuSPH0dN+zp8Wx9nPE17xnCTf83jdYhy4TB/FS5nHcZ+cjsV5ysh3CNUu9JeBG5D
         CDMkUtJ+JhbgsKunQKHLZyItzx0leFloA6yeaMGANEkQUPU8ElDlOCSSWU43aSpHaslX
         J5IaISSZ0eQV0bZ04tCB+T9r7PX0aFFtcuk8nRWHkt5V4Ig+nnLGdvVSCVkFfyJy1kqm
         JFdOg0HKb2/xzZrIXQu+LbYAlNfdowBZlPMF18vES2k9+HgUgrOa252ReTmSrDqfS2Rx
         obxg==
X-Gm-Message-State: APjAAAW6VYN1cBUxIIub1WlpCZF464Bjy7FRTazx0td13Rc/I2Z7aari
        iraZZPxvb7EEZ5nRBj7k2P9G7g==
X-Google-Smtp-Source: APXvYqy7pLAOlAdg+Sp5BEQI+wU4W4cDPg3HtnLAJSWDlC+CrxXJNIF1beWBMp6dCqJaLq7eKoZDRA==
X-Received: by 2002:a63:5b64:: with SMTP id l36mr60466182pgm.182.1554103106788;
        Mon, 01 Apr 2019 00:18:26 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id x16sm4472289pge.27.2019.04.01.00.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 00:18:26 -0700 (PDT)
Subject: Re: [PATCH] thermal/drivers/core: Remove the module Kconfig's option
To:     Guenter Roeck <groeck@google.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
References: <20190401032425.18647-1-daniel.lezcano@linaro.org>
 <CABXOdTeB+5vNi+mRBf2ff2YJG5WVRAGFjBz-ehjDTCyQdcpr7A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <86b89b19-73fe-4ec9-d030-a72f191a44d1@linaro.org>
Date:   Mon, 1 Apr 2019 09:18:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CABXOdTeB+5vNi+mRBf2ff2YJG5WVRAGFjBz-ehjDTCyQdcpr7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

thanks for the review.

On 01/04/2019 06:10, Guenter Roeck wrote:
> On Sun, Mar 31, 2019 at 8:24 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The module support for the thermal subsystem does have a little sense:
> 
> Do you mean "makes little sense" ?

yep :)

>>  - some subsystems relying on it are not modules, thus forcing the
>>    framework to be compiled in
>>  - it is compiled in for almost every configs, the remaining ones
>>    are a few platforms where I don't see why we can not switch the thermal
>>    to 'y'. The drivers can stay in tristate.
>>  - platforms need the thermal to be ready as soon as possible at boot time
>>    in order to mitigate
>>
>> Usually the subsystems framework are compiled-in and the plugs are as module.
>>
>> Remove the module option. The removal of the module related dead code will
>> come after this patch gets in or is acked.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Sounds like a good idea.
> 
> Acked-by: Guenter Roeck <groeck@chromium.org>
> 
> Many dependencies such as the following can probably be simplified or
> removed after this patch has been accepted.
> 
> depends on THERMAL=y
> depends on THERMAL || THERMAL=n
> depends on (HWMON && (THERMAL || !THERMAL_OF)) || !HWMON
> depends on !(MLXSW_CORE=y && THERMAL=m)
> depends on THERMAL || !THERMAL
> depends on HWMON=y || HWMON=THERMAL
> depends on THERMAL || !THERMAL_OF

Absolutely.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

