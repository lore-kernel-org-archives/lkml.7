Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36D2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F9C20850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU6Mj1Za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfCTTAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:00:33 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:34504 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfCTTAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:00:32 -0400
Received: by mail-lj1-f171.google.com with SMTP id j89so3263140ljb.1;
        Wed, 20 Mar 2019 12:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LoJ6zoLfO6i4+OBot1i6JHQqENGSknGoLLn9d6Nc2tI=;
        b=ZU6Mj1Za5DOHMpgDzufQgJLlbb3cvOjSPyc01Yfj/bqX4xSZgg1EChiyOjjUuZGMHr
         QLzO4F2KMDA6zNhwGge3ZCng31fMYfM9xoeNp2eB7XJpJCiYd04BKv60cHUwZwkQafwf
         QtjZSBWmoFhcMXdKsjaCgEfM1Iau0OAtDg0muVWJoanQDaP2o0eg22daEtcAbJoutnji
         INPX2Vzw46htl6MucLVs9tWhIw9ugDp40I2SDieGGwX52ipCzPVyHeQgS8RSalwa/Dc3
         oa6kc97qWlRKnOEYuBgIQuxMaoWnj4BP99VzmzsOr6dj/lUf4c8TbLvEvnWrfwuPB7nM
         PLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LoJ6zoLfO6i4+OBot1i6JHQqENGSknGoLLn9d6Nc2tI=;
        b=cwffRwAzH58vp+rl8hoo1oIaSzrQmPQZ2xxzUj2yEveMsD9n7mDPt8Jr3s0aamyFul
         Iw+vsL+JiarU3j2BCT2ZKREGx1mz7nrwRK17k3VgO7WzO04b43h5+tLqxu/jYc2IyGKa
         OI8T/ZziUnKoC6sZ0np42CvUYxtok1yxjYJfZQ2b0BeLtxgFVhiYbeUITcrIqrJRN1HG
         6+1J1nUa4Ly+PqVAAMdiRFRNUYTtYdCCTkHB8fFtFqUXgrqq6e0XYVktBtgqw2f/SdB/
         bUC/Z//Q9Y7VxDwMdqnduHRh+cBsDNluDA3nb1/EgmO241lnXI0B7gQi8tZXbDcgCfpc
         EQmg==
X-Gm-Message-State: APjAAAWSaGrSPmVbMtdQkaX5MkS8W2G7FX2r3iHZPH13L6XmeaQLDMLl
        RS265pqVXQxMHyDzior61EPt0O1p
X-Google-Smtp-Source: APXvYqwWMF2lDoalubof3KWVd2Qi4ow/5/bOzeUHJro3zh2hDCBMzw+FraTMxJwB4X6R5vmYLJKvUw==
X-Received: by 2002:a2e:312:: with SMTP id 18mr19143600ljd.114.1553108429891;
        Wed, 20 Mar 2019 12:00:29 -0700 (PDT)
Received: from [192.168.1.18] (chp186.neoplus.adsl.tpnet.pl. [83.31.13.186])
        by smtp.gmail.com with ESMTPSA id p5sm478372ljg.44.2019.03.20.12.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:00:29 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] leds: lm3532: Introduce the lm3532 LED driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        tony@atomide.com, lee.jones@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190313123249.17258-1-dmurphy@ti.com>
 <20190313123249.17258-4-dmurphy@ti.com>
 <8623d5bd-e369-9f90-a749-224119e5861b@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <08406168-b20e-527f-23c7-e6543f5b5c10@gmail.com>
Date:   Wed, 20 Mar 2019 20:00:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <8623d5bd-e369-9f90-a749-224119e5861b@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 3/20/19 1:39 PM, Dan Murphy wrote:
> Hello
> 
> On 3/13/19 7:32 AM, Dan Murphy wrote:
>> Introduce the Texas Instruments LM3532 White LED driver.
>> The driver supports ALS configurability or manual brightness
>> control.
>>
>> The driver also supports associating LED strings with specific
>> control banks in a group or as individually controlled strings.
>>
> 
> I have a v5 series ready for posting and only the DT was reviewed.
> 
> Do we have any comments on the code?

I've just added one comment. After it is addressed please submit v5.

-- 
Best regards,
Jacek Anaszewski
