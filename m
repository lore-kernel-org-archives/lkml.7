Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69FDC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E70206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5iDPAGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKUVHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:07:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33955 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfKUVHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:07:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id b188so4424596qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NENUynk4I14cLJ1gzY7kbHVItSkGHRUyltKk2t7G71k=;
        b=g5iDPAGusrJ5T04T0la9VutqkiP2FlaTpfWeszcdEhnqyy+Wf4O7trjWSqztvlc2Y/
         eOq0JX+qxqp862BdbChJYLpfkyRSkxU1OgZBos12SGOrDTklEIy9Oho3glmf4U8ZDkh3
         Y8wIV8XPhXqjnI28AakLPiO29iU6jwSTorgYdDO+I7QVznE7zId5aO9qy/AHiwMtAOMR
         4FCd24PhP/eEvqyVfd6pECXj+cBkfho5b3MlVxhnlBrWP3avZ1yQjn8pgZJxbtbga3Pz
         dGIP4nXO7tvKkElauREkFPC6GmkN6DVS1bbFzlyD4wBiQy7vTIEVMP31Zt+6MrQ0Tbep
         iCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NENUynk4I14cLJ1gzY7kbHVItSkGHRUyltKk2t7G71k=;
        b=fm0e/X3fwZw69XYXA+PfiiUcPzhhydmYPjFzyQB9/55idSrm+Xt7j/W1sSu9D3tF8M
         10i6h/GI9N4xwI29Wro6zAGpYkbJVsrrUFbEg3EGhQOQug9G/G/Spln93fGKydR0TRGY
         fh0weAbFt+eKKqbAPnd/T41znF+t98973AnnL0oxXl9+hVSwSBwlXpwCryBGNyut8P8m
         RChtxx43tlcBI4MBXr1NmcbIpRhv67OfSd3IUgv8S3n3JvwTszu1sr9yyXuxzYG6VoDx
         g5h/OY8gD0IvhBaC/fpwdW+k7nRUD41LfGDxOuuwtwruKUDDaRKfHGEalOAG5VGm5L5e
         DlVQ==
X-Gm-Message-State: APjAAAWv5UwTleJZ6JBvgtJD88OY3DFqghL+YgqWYtEYrL5QnS5uVPjJ
        Y1f8KMKftt+WBCGgtvuQKjW28w==
X-Google-Smtp-Source: APXvYqwlynOQgNTLE0weHTUVWiNQd0hgkoM+NrDMGZXLhgwxuK7tEo4Ra/hAtmxs4ObbQbOXtAGAWA==
X-Received: by 2002:a37:9b4a:: with SMTP id d71mr9974147qke.0.1574370441784;
        Thu, 21 Nov 2019 13:07:21 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id d139sm1983435qkb.36.2019.11.21.13.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 13:07:20 -0800 (PST)
Subject: Re: [PATCH] drivers: thermal: step_wise: add support for hysteresis
To:     Amit Kucheria <amit.kucheria@linaro.org>
References: <8e812065f4a76325097c5f9c17f3386736d8c1d4.1574315190.git.amit.kucheria@linaro.org>
 <5DD69AB7.3060307@linaro.org>
 <CAP245DVwEij-fs-LK=i3+Ps6BrsHt4DfxKG=C-tFM3CVKadtXA@mail.gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "J, KEERTHY" <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM list <linux-pm@vger.kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DD6FC87.6040403@linaro.org>
Date:   Thu, 21 Nov 2019 16:07:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAP245DVwEij-fs-LK=i3+Ps6BrsHt4DfxKG=C-tFM3CVKadtXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/2019 09:38 AM, Amit Kucheria wrote:
> On Thu, Nov 21, 2019 at 7:40 PM Thara Gopinath
> <thara.gopinath@linaro.org> wrote:
>>
>> On 11/21/2019 12:50 AM, Amit Kucheria wrote:
>>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>>
>>> Currently, step wise governor increases the mitigation when the
>>> temperature goes above a threshold and decreases the mitigation when the
>>> temperature goes below the threshold. If there is a case where the
>>> temperature is wavering around the threshold, the mitigation will be
>>> applied and removed every iteration, which is not very efficient.
>>>
>>> The use of hysteresis temperature could avoid this ping-pong of
>>> mitigation by relaxing the mitigation to happen only when the
>>> temperature goes below this lower hysteresis value.
>> Hi Amit,
>>
>> Can this not lead to ping-pong around the hysteresis temperature?
> 
> That isn't how hysteresis is supposed to work if there is a sufficient
> delta between your trip point and your hysteresis value.
> 
> e.g. if you have a trip at 80C and a hysteresis of 10C, it means that
> you will start throttling at 80C, but you won't STOP throttling until
> you cool down to 70C. At that point, you will wait again to get to 80C
> before throttling again.
> IOW, on the downward slope (80 -> 70) you still have throttling active
> and on the upward slope (70 -> 80), you have no[1] throttling, so
> different behaviour is the same temperature range depending on
> direction.
> 
> If your hysteresis value was very low .e.g. 1C, it would certainly be useless.

Thanks for the explanation. I think averaging can still give a smoother
experience/transition. But then it has to be implemented and tested
against this solution. Other reason for this solution is hysteresis can
be a higher value if needed where as averaging might not give that
flexibility. I have some other comments on the patch which I have posted
separately.
> 
>> If the idea is to minimize ping-pong isn't average a better method?
> 
> We shouldn't ping-pong with the asymmetric behaviour described above.
> 
> Regards,
> Amit
> [1] This is a simple example with a single trip point.
> 


-- 
Warm Regards
Thara
