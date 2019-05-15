Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BB1C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04A62082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGpmkt1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfEOMwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:52:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39004 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfEOMwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:52:18 -0400
Received: by mail-io1-f66.google.com with SMTP id m7so2103509ioa.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zKZGZwydNwuBKKpP9EtV38vAYoROUWvlb9dLvc951x8=;
        b=MGpmkt1V40aibZwHWv29Oy3/VHITslWhaDqJDskC8zW9SNKRmWHio8vCdh7qXGv/4A
         M88Q99iuoH5LcHKdcnxtlYh/4ZrE2/YbiuTqnkZmHHs56c5+Ggi/GjtwSHBrr3OfYdy4
         natvaRNDyzL81t4nIJG2jkx+qGSlodaTfeaUYOWTnVIvj03i0JzLA3ynwg6isZOQCEYv
         y6Qw6TDoWx1RbG36efiHjc7w0Z4AUcq1y79XRMWp1le6D3PC16lRG3bAoqrWSXeQn/ny
         yXTvSOmINwlOD9tddAlrJ03/bTDtNEIzlU4CVMMfA1P6XLaeQ+spTcnSN6Kczl5sMQYB
         ygrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zKZGZwydNwuBKKpP9EtV38vAYoROUWvlb9dLvc951x8=;
        b=E/rPDphb2wUOC+VnEyLtQ4l/IEUDsdk210obyolqID7ihSdNkMUddXuRRjg4dARtMp
         68KoKGEeuS6kGe5OuWtI+m/B0R6C56UshisipUUb+3qrsB6ttXhPLpjrY1bOGpOqmPKZ
         TmX5d6Fv+ENGL5GpYBsJAFZbMiuzQq4PyUDZUWtxJihfnLEJjrSJGbUqrcNHY1SxZr6+
         30HL9isoo4qZZbB1UuHYgjrSK03n8sIVwXE/PwAwEl7dFSU+FaRUhv+q+lQR3PuXsevT
         SB/Vq2D2/qqmGnVRKajhSp/+SdcgAPj63X3NxX9NCqClHObErYUso0hw3H3E6coUBhvX
         JLeg==
X-Gm-Message-State: APjAAAXSIoEukKy1RUS8cglO5KOkNSeWgis8kjZdFKivRqx1+6KKVSYz
        4FFxOwStw8+pOejM/gPOjgWs/9wqVro=
X-Google-Smtp-Source: APXvYqwgZHqN2xKUVXAC6ZqzZUT7IVXtjP2jdDiz2idttIicf4Yuoxstw+eK8LOHO1APF2ARySlXaw==
X-Received: by 2002:a6b:6f17:: with SMTP id k23mr25118810ioc.305.1557924737166;
        Wed, 15 May 2019 05:52:17 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id i25sm598719ioh.23.2019.05.15.05.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 05:52:16 -0700 (PDT)
Subject: Re: [PATCH 00/18] net: introduce Qualcomm IPA driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <CAK8P3a3ma-kAYSNP=wxXiF0ZWUJmH-UrysdiJ6kM67EVrEiGdg@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <d346cef8-667f-c924-e74b-501d455dc950@linaro.org>
Date:   Wed, 15 May 2019 07:52:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3ma-kAYSNP=wxXiF0ZWUJmH-UrysdiJ6kM67EVrEiGdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 7:37 AM, Arnd Bergmann wrote:
> On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
>>
>> A version of this code was posted in November 2018 as an RFC.
>>   https://lore.kernel.org/lkml/20181107003250.5832-1-elder@linaro.org/
>> Fixes addressing all feedback received have been implemented.  It
>> has undergone considerable further rework since that time, and
>> most of the "future work" described then has now been completed.
> 
> I think this has turned out really well now.  I've gone through the patches
> today and not found any real show-stoppers, but replied with a couple of
> minor things I noticed.
> 
> I think it's probably worth rearranging the rx and tx code to avoid
> the spinlocks, which would be the main optimization I can still
> think of to reduce the coherency traffic.

Arnd I appreciate your review *so* much.  You clearly committed
a significant block of time to this and your comments were very
insightful and focused.  I concur with everything you pointed
out and will address all of your concerns when I send out v2
of the series.

Thank you for your careful review.

					-Alex

> 
>        Arnd
> 

