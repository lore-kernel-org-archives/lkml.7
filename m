Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C268C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2926720880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GejyAKRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDGTLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 15:11:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41219 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfDGTLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 15:11:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so9273114lja.8;
        Sun, 07 Apr 2019 12:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v01SA7LaG7DAiIG6c6NxfVRHkmuMCRnHlt29iOLmPjY=;
        b=GejyAKRIZNwuMpjzW9gRWY/+FqNNweksfdYu/4f4STl0Lx/66rFGBFlvcjqPBdYHyi
         zOyD3ajXKc8ji+JmX6PuwUklKgUYyiOcxRFkX+WynIp40K/HjjuJSmM6GPJFa2HXefLS
         btQri6nczTbyJVallRXTh3rVOzHjV++YMy++LEXr0VPh/py33CGA8zUhP08GJXY7cuc2
         0Dmjvnp3aRSerR3YqSXro93wmdZlO0AJpjisZaEitPZ++IC4YCbUCPSoPrHl/eqx8Rsx
         OynEUGey6hdxyYtoiZ6CJqU7auQJiMStGMXKvf2srkc4IaQNYWkR5/oHdHudWSuBSq0P
         QlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v01SA7LaG7DAiIG6c6NxfVRHkmuMCRnHlt29iOLmPjY=;
        b=rCdoM8sOUIoqorJx11JS2JQYGFPHOzKs6OBsaFGtPFMEzS6uepaAwTmoZaAi+zxdgb
         E6BLml6JbM0oH+sZPzQfqR2bPX7aMJ6+bm38qIXj4TBlslhfLGK1QLdRhOM7l0DXqD7g
         q2/CF1wPRnFM54Gmxy04EiDWCbyrnW/aoOTRlMC26TV0llzj+su1iVR33zbglHOIkI/e
         TsasZkHfuGw8azS85uQXzS4MzPg+LRbblKNPT3IAOJ2nkhFQZ7GNvYBOt94X5o/W+U5c
         TUf6HOvWUo8I5zuLDG8Un7t3HRpnccaGx3fubzSUdG1Ibip0B62OefpovP+aOhoyUHID
         F9qA==
X-Gm-Message-State: APjAAAXLPE+fJpr8LBsNjfvjee70T9Di+akWEhzAhtZLdoZposIj9gQE
        fNTMFbR6VEAyZkDvSn3quJLRL1hYnGk=
X-Google-Smtp-Source: APXvYqyKRMoPJmPPsSTidvyT3iRLkMbDJ7xxP2pWJBbtOWb/4XF671zk7pCvX5wTkqwvG1uZbvhdTA==
X-Received: by 2002:a2e:8347:: with SMTP id l7mr13338316ljh.17.1554664268844;
        Sun, 07 Apr 2019 12:11:08 -0700 (PDT)
Received: from [192.168.1.19] (bkw193.neoplus.adsl.tpnet.pl. [83.28.190.193])
        by smtp.gmail.com with ESMTPSA id k15sm5955142lji.2.2019.04.07.12.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 12:11:07 -0700 (PDT)
Subject: Re: [PATCH 1/4] dt: lm3532: Add lm3532 dt doc and update ti_lmu doc
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        tony@atomide.com, lee.jones@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190321142838.22985-1-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <4d00cf1b-8863-1650-52e3-d1566f715a44@gmail.com>
Date:   Sun, 7 Apr 2019 21:11:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190321142838.22985-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 3/21/19 3:28 PM, Dan Murphy wrote:
> Add the lm3532 device tree documentation.
> Remove lm3532 device tree reference from the ti_lmu devicetree
> documentation.
> 
> With the addition of the dedicated lm3532 documentation the device
> can be removed from the ti_lmu.txt.
> 
> The reason for this is that the lm3532 dt documentation now defines
> the ability to control LED output strings against different control
> banks or groups multiple strings to be controlled by a single control
> bank.
> 
> Another addition was for ALS lighting control and configuration.  The
> LM3532 has a feature that can take in the ALS reading from 2 separate
> ALS devices and adjust the brightness on the strings that are configured
> to support this feature.
> 
> Finally the device specific properties were moved to the parent node as these
> properties are not control bank configurable.  These include the runtime ramp
> and the ALS configuration.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

Thank you for your work on this set. Applied.

-- 
Best regards,
Jacek Anaszewski
