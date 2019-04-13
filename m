Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32684C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB85218C3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yIP0mRK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfDMI2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:28:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43008 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfDMI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so10229137wrx.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ndpNAE5f0uMmj8vDzzBRZhz5QD/E0R1HXOBgmQQ4hwI=;
        b=yIP0mRK/CS7K8lrxdxhNT+tZcTAahH7yp4szrQDiOsqZqoVlLdyHR5LNZr3BhpZ0HZ
         QkqkTyb+BQfAg3W4NQhWAu+vFuE03f/zQW1lXLr4JEAqi3T3xvMqCuj2VS5kbzgWzjE/
         Zof9zTws2MIlE86H4ZL0M0A3Wg9flatZ+2amjaONNXdQcoBmEFaQjYczllkrfu+y5zW/
         egZJH8qKeuu9IjMso8gEOHBThv05QkY2QKXaR17XTE6GV+r5OQdDhP9t0iix1p4uiNAa
         n8ETYgmhQUsk87/IzdoXuqHGY+UtwVk80OoVj1f11r7Bm7DWxySbWBp2CZ3W/RRqgtIn
         +1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ndpNAE5f0uMmj8vDzzBRZhz5QD/E0R1HXOBgmQQ4hwI=;
        b=ZoN6PtUPqcvQI1dxhZ8E+CciOsy7ZGQOpIxFBbwvpczpHyP1Umle8/oEch/9B5ixpx
         Ezn5ETJVTZrEk8TKHvkW+x0RN1kCFpTxy1G/5/iSlmBf9C1d0lCN65iQ8Z+zsIQnnuIe
         d9EaEthyCiGbEzGZ5Trj5TEZT0NX+tZqvA3ItqoLNHnZxopmYgGerthE91xfFcJjvGRL
         kP0+c21HCEXuf+E3IFN2oEeIQ/ztsgCSQWQ3iZUxSAIyIwZ/5znJiyz7yn7h7FkTS27m
         6DIQx0DNOJ0rsQyjzt+4xGJuAnDpD6oYe+8u782JtzF6S0B90iIRSdl99A/KKD1xeMSp
         rl3A==
X-Gm-Message-State: APjAAAUPa2vx6yP9Tl4WgHTkdaxe7qy+c23oUuyiTcv8z4wlOF3OT9IK
        oj3I5jxUIGg7x0yH+HCoBpfPEaczjp0=
X-Google-Smtp-Source: APXvYqzJxC5vY4VZVAMf9vGhOoLMDOeJoQGSreoe4AxeDmTPTW9UkT1J2b0BQBtLWuWqTMYUP//4XQ==
X-Received: by 2002:adf:f60e:: with SMTP id t14mr37920872wrp.39.1555144096087;
        Sat, 13 Apr 2019 01:28:16 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id s18sm12331610wmc.41.2019.04.13.01.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 01:28:15 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] thermal/drivers/of: Add a get_temp_id callback
 function
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
 <20190404080647.8173-1-daniel.lezcano@linaro.org>
 <CAHQ1cqHXK8HHXCj0FtZUtCzafYCYdOkdHm_wA6_NqN8q=iB-yQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e6f3007f-bcee-278a-24f0-df1e70cb376e@linaro.org>
Date:   Sat, 13 Apr 2019 10:28:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqHXK8HHXCj0FtZUtCzafYCYdOkdHm_wA6_NqN8q=iB-yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2019 10:18, Andrey Smirnov wrote:
> On Thu, Apr 4, 2019 at 1:07 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> Currently when we register a sensor, we specify the sensor id and a data
>> pointer to be passed when the get_temp function is called. However the
>> sensor_id is not passed to the get_temp callback forcing the driver to
>> do extra allocation and adding back pointer to find out from the sensor
>> information the driver data and then back to the sensor id.
>>
>> Add a new callback get_temp_id() which will be called if set. It will
>> call the get_temp_id() with the sensor id.
>>
>> That will be more consistent with the registering function.
>>
> 
> Tested both patches on i.MX8MQ, seem to work as expected.
> 
> Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Great, thank you very much for testing!


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

