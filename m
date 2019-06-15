Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10E8C31E52
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 13:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9947C21848
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 13:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hrZAMjX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFONYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 09:24:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45592 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfFONYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 09:24:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so5232198wre.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 06:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vz/q3yDMdsUzgeQCzBXnpHKRw3aqbJ8VhrbofM0uGw8=;
        b=hrZAMjX8YAKjXxrPN9i4Ujy9ygbBRPJb7TBLpsXbIqdZpmx97Burm7sDohZe3gWnGF
         TpUVrUBYaelBUWac1wtnJih7fFCi36VlNHA0e3nFzUJuiQJhTe3pYWGswTK5rzHW85KD
         qcptH5g/EkwFUCv47c9uRFBpc2NGsez4A3/aBJnlybU95E2aY8F8DXzaB2vsTLfFwVA5
         PLa+dFmYzjuHdJSjcWWeO7ysyhLn1TnxbLMmP7Avh6u1ZqdeErA1Fodt6pOIMQ8DJJXB
         8rIChl80ANLmmnIjLwfoHD9EAhoiyDqlcExmWgSZNc2v2Du1hU+2obs+6DOufaJlTpLa
         iZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vz/q3yDMdsUzgeQCzBXnpHKRw3aqbJ8VhrbofM0uGw8=;
        b=QCv4xyBBs2WW8evLwe8ttVGQbveCR7vSvYP3c0XfN87k3sdSxkliXyhVtCt6MB4c5S
         bbsAZJNkz93GmTOxTgW/BLH2bEn+AAoi7Edu2Of5ecEq9dqeRUXXQ6f9n+3s1lzqBhyb
         ayhLHMLQtmMF/E+GQx0y0J/0k1T9y28NuRXtFrOeJ3eGQMin4pSyt6T44UXSM/1jWdi6
         bJ/U4guuMWCulHRQgryUfSUlsOinueKTE5pxGk+3nvP6n5TvLQd3XVZAIxOTg2vTYrJq
         jzP7JPWfHgGd6msdXevIstnqxwVEWSwNrmKq2Zvs0qOr5AduPGFIHTQRRuaHviVMZyI9
         Ma3w==
X-Gm-Message-State: APjAAAVA5uJ6bJ0W3zWclY6lz8HAmltvHVrFpDEpnc4JpdAh3EhEKes7
        cL5kX36XQhKu0GfUGVUAv+Ql4e78tE4TfQ==
X-Google-Smtp-Source: APXvYqzT26v+cM8CuCpyQsf55a1zh1osMb6x36j5wWGQDXrAaSY2Q/a3yv9uJOPSOvdp22hdne9ejA==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr6384669wrq.151.1560605069518;
        Sat, 15 Jun 2019 06:24:29 -0700 (PDT)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id x16sm6168247wmj.4.2019.06.15.06.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 06:24:28 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 6/6] soundwire: qcom: add support for
 SoundWire controller
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-7-srinivas.kandagatla@linaro.org>
 <249f9647-94d0-41d7-3b95-64c36d90f8e8@linux.intel.com>
 <40ea774c-8aa8-295d-e91e-71423b03c88d@linaro.org>
 <7269521a-ac89-3856-c18c-ffaaf64c0806@linux.intel.com>
 <462620fc-ac91-6a36-46c7-7af0080f06cb@linaro.org>
 <0e836692-2297-4cb7-d681-76692db78a56@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d3ccd866-7bc5-9635-4bb4-6b0765f89835@linaro.org>
Date:   Sat, 15 Jun 2019 14:24:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0e836692-2297-4cb7-d681-76692db78a56@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2019 13:21, Pierre-Louis Bossart wrote:
> 
> 
> On 6/11/19 5:29 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 10/06/2019 15:12, Pierre-Louis Bossart wrote:
>>>>>> +
>>>>>> +    if (dev_addr == SDW_BROADCAST_DEV_NUM) {
>>>>>> +        ctrl->fifo_status = 0;
>>>>>> +        ret = wait_for_completion_timeout(&ctrl->sp_cmd_comp,
>>>>>> +                          msecs_to_jiffies(TIMEOUT_MS));
>>>>>
>>>>> This is odd. The SoundWire spec does not handle writes to a single 
>>>>> device or broadcast writes differently. I don't see a clear reason 
>>>>> why you would only timeout for a broadcast write.
>>>>>
>>>>
>>>> There is danger of blocking here without timeout.
>>>
>>> Right, and it's fine to add a timeout. The question is why add a 
>>> timeout *only* for a broadcast operation? It should be added for 
>>> every transaction IMO, unless you have a reason not to do so.
>>>
>>
>> I did try this before, the issue is when we read/write registers from 
>> interrupt handler, these can be deadlocked as we will be interrupt 
>> handler waiting for another completion interrupt, which will never 
>> happen unless we return from the first interrupt.
> 
> I don't quite get the issue. With the Intel hardware we only deal with 
> Master registers (some of which mirror the bus state) in the handler and 
> will only modify Slave registers in the thread. All changes to Slave 
> registers will be subject to a timeout as well as a check for no 
> response or NAK. Not sure what is specific about your solution that 
> requires a different handling of commands depending on which device 
> number is used. It could very well be that you've uncovered a flaw in 
> the bus design but I still don't see how it would be Qualcomm-specific?

Sorry It took bit more time for digging up the issue which I faced 
previously to answer this query. This is now fixed and v2 patchset has 
same handling for all the slave registers read/writes with no special 
casing.

Thanks,
srini
