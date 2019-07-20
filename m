Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C96C76195
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 22:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDFF2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 22:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQkILhKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGTWqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 18:46:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39994 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfGTWqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 18:46:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so15656871pfp.7;
        Sat, 20 Jul 2019 15:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8jcJmcHEGEEYqidoI3J8M7I3oaGy7AiHVl+ctm6XmvE=;
        b=BQkILhKAbudKrFIGtrR8LQOCVFmLrPvFpZ0n8JeCW+eUBMuteZFF8qzv+75IddR6sl
         tKxxS2m0qsHneAeZsgHEjUpDGDeZk1MaSXLHo3LKbuqrfRJ2NZCGMjK/p2Sy9oUG2RBt
         aHAgvtDdwqoS7ehePed2xiSE1cwVsHcKrk4BNlduNKsnQcYkMIJygurnKg/hs148QZQL
         LAdRRVlVSwj433ztmMwSaWh7hjYVxQ2YSUsRGpay7tyf/heGTiWdrtvR9ydA+CicucxN
         /FfJgr861speGSfR0bjqaekrXFpiHeNhGVVWkodZOvDYf+FAHsOUF2kiOWnVmt6wY1Xs
         lFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8jcJmcHEGEEYqidoI3J8M7I3oaGy7AiHVl+ctm6XmvE=;
        b=tqTmyXoqjV8uOuWFi2wf2wbxm8L5XjhugO34oqM0DlTyJuzPoPAp/4eYkUuzM7Ws/4
         mYkignS7RwKKJfGkAigmTfsyvX1Efuo+KW7kOCvVpgiVtVMCMwxSh97Btv6Dhg4nxJdG
         h49sxTBxBUaadl9YTKTxC/Z0d/UzSyixkSbJPJCLa5/2MikTlfFWv/QvJ15afc7SnSuv
         8CsZLqtJ04D4OTcNtKzb214zh5Wtl36veFxxGhkCBbLouNXfTbR7OP+7mmjIHFIh7hSi
         CY1mKAff8pUU1tx0glIopPQYpTQoRYVzKNrU+lfxFApF2GNvZoKpBmGTXkMwUlEsiCag
         m9EA==
X-Gm-Message-State: APjAAAUEdp+Kzed1mlZauGb1eWc26SwoMgkQXu72e48lUOekDUiCOZ2n
        e0pSKyLbir0wSMH2BNOUfBkvs1UD
X-Google-Smtp-Source: APXvYqycVLfr676C6OsN4jsi06svVpHl6nVrJbc+4q8Y8svmMsGHA3fL80AWxKEChmLcLYR60UaFoA==
X-Received: by 2002:a17:90a:8985:: with SMTP id v5mr66103885pjn.136.1563662810452;
        Sat, 20 Jul 2019 15:46:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i3sm37408448pfo.138.2019.07.20.15.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 15:46:49 -0700 (PDT)
Subject: Re: [PATCH 1/2] hwmon: (k8temp) update to use new hwmon registration
 API
To:     Robert Karszniewicz <avoidr@firemail.cc>,
        Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <BVOE7U9MRMZY.38N6DGWH9KX7H@HP>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1d0f98fb-a0a6-38b7-98f6-ec4c365587b0@roeck-us.net>
Date:   Sat, 20 Jul 2019 15:46:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <BVOE7U9MRMZY.38N6DGWH9KX7H@HP>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/19 2:13 PM, Robert Karszniewicz wrote:

[ ... ]

>>> +	if (data->swap_core_select)
>>> +		core = core ? 0 : 1;
>>
>> 		core = 1 - core;
>>
>> would accomplish the same without conditional.
> 
> How do you like
> 	core ^= 1;
> ?
> 

I didn't notice that before.

Your call. Everything is fine as long as it doesn't involve a conditional.
Hmm ... having said that, how about the following ?

	core ^= data->swap_core_select;

Thanks,
Guenter
