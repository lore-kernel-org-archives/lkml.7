Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64769C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AC62087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOwMT0Cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfECIEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:04:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46756 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfECIEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:04:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so6569504wrr.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TpXqJQI7PVBHDytg+IGA8i8m1/XYj0MrND3X98mgWRU=;
        b=KOwMT0Cl9efaAA08+DXGflf+klv1sSVEHKxtGUL+CBB2gxt07xyd+GyRUCCFVKzsBF
         vKFUzaTq0/DOqlmb39mbYs9iH9RkOcgL/KAAeaSaMlUscaGj/bjbj+P1qApNVwESdscJ
         g+1LJrqUlO8vcWihy8sZ39L1L6LS1ajt0o5fzIYYJaQhvca+WfuJGXFbdFR2rcym4b4t
         zBYkf1Llb/Z3r2f2Mqm8DStMLgaZcHBFBYpuH2Uow5/FZOaBijtEgoGFhaFs2w3Lbcsf
         fUx7d6Qd9AwY90DycZfziK6toE6kMAjg8Mx+cK1CNVyDwdMXuzYcxD1e3vRmAV6UcGSV
         1pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TpXqJQI7PVBHDytg+IGA8i8m1/XYj0MrND3X98mgWRU=;
        b=U3vxwseudQwJhE909Lqk4TC3s7u+DfnHiySE2+qHqv3lMYg21xt4VcUAz7psBdG+Pm
         4z+a8a/BFOKgfk8+SX7owao1y4hzmDAkhmewJ8zYHWKaPa2jhQg4re3QpskW4D2rnMqo
         3j5mSz8s75I7BHJai318w4D2Iy4Qed65DWv532mNG6WToqTuAW+6x25YMs0FDKRf8u3e
         PbipmuHY49/QIxrY34gm47yIG6fWG3KQWPxq2+R+X8qTVwvY0J5uNXKiyCDXI3j1o2OO
         jeoEMLP1Ycp964IaK9p70SY+dXAMMjcZDC6lMOhq0aKhRHCciuLARR0Dyb3m8S6QaSdu
         EJVQ==
X-Gm-Message-State: APjAAAWw7M949HUIbFgorfsNBfh63jvAj3Ah6FBRkQaBaSZ0ZTyVB6kw
        jQ7ICgZl+IcDuiD4e8ZCdeR2+g==
X-Google-Smtp-Source: APXvYqzRH5TpkdzGloadzIxAtQZsM2JgxqfDy9oibY2Qrd4ctA1Tpc85qqJ9ZfJamG8tTMt5Vi3YIQ==
X-Received: by 2002:a5d:430f:: with SMTP id h15mr5756534wrq.132.1556870681778;
        Fri, 03 May 2019 01:04:41 -0700 (PDT)
Received: from [192.168.0.41] (223.235.129.77.rev.sfr.net. [77.129.235.223])
        by smtp.googlemail.com with ESMTPSA id k1sm1159060wmi.48.2019.05.03.01.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 01:04:41 -0700 (PDT)
Subject: Re: [PATCH 1/6] thermal: Introduce
 devm_thermal_of_cooling_device_register
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
 <1555617500-10862-2-git-send-email-linux@roeck-us.net>
 <20190501164843.GA16333@roeck-us.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c8a26b7d-2775-e13f-21b7-dbc901ea3b0b@linaro.org>
Date:   Fri, 3 May 2019 10:04:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501164843.GA16333@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2019 18:48, Guenter Roeck wrote:
> On Thu, Apr 18, 2019 at 12:58:15PM -0700, Guenter Roeck wrote:
>> thermal_of_cooling_device_register() and thermal_cooling_device_register()
>> are typically called from driver probe functions, and
>> thermal_cooling_device_unregister() is called from remove functions. This
>> makes both a perfect candidate for device managed functions.
>>
>> Introduce devm_thermal_of_cooling_device_register(). This function can
>> also be used to replace thermal_cooling_device_register() by passing a NULL
>> pointer as device node. The new function requires both struct device *
>> and struct device_node * as parameters since the struct device_node *
>> parameter is not always identical to dev->of_node.
>>
>> Don't introduce a device managed remove function since it is not needed
>> at this point.
>>
> 
> Any feedback / thoughts / comments ?

Hi Guenter,

I have comments about your patch but I need some time to double check in
the current code how the 'of' and 'devm' are implemented.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

