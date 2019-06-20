Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C87C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D772082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puv4rVj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfFTV71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:59:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42137 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFTV71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:59:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id y13so3498109lfh.9;
        Thu, 20 Jun 2019 14:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tRIIVl0VbTlFEXZMu1wj2SNsiio04pIGeTYWpzGSVWY=;
        b=puv4rVj0Zh+Q33NTFRu0ROY4pCOMTiiUIseCTwA+HbUraPRlfUEGhFw9OriAtoF01y
         aNlpSiT09LRljdH5qM/hEElfU3Hi+Uakc32gWbeeTjiA99cAUG1nAfQFYIliT4Kn8vsI
         sA3OR+BP+kFC27Nw8oqM7sGt4bJBqaF2V25utuiuzGjxj9GqY5ptGZb5s5Cli5duDwF8
         Qy+LytxEIlYkquLvGwihU3YYCAdLVRRrwwbeWkhKX00x2tarA8n2brcVy4fggLdFG0uz
         zB5ZqfVNN3W9TloFzeAX9OtEpvXnRiyDfMAAaeaPmEmH8XUwRDd/iscOGXxDsJz0g+UG
         3K9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tRIIVl0VbTlFEXZMu1wj2SNsiio04pIGeTYWpzGSVWY=;
        b=ZV+v/kkVQq109mvGXm1JEErOtlIdOJo5d7753T2MknVtrNL/llZ1KFxpEKGMSVCXCP
         sls90czlgYIU6I7uKLrr/Y3gX0c/ZQT+sF++OEL8kgb/snBDjtLNZAqxxacKP/wxVKvz
         Hcm4saKAQ7/WWSqKBM4rLyUf+8jDTKHZOweIRFxPkBn8AyvC6T5csewjjBjTbOp8Bo5W
         5xmGOSaKCwvzFj0vr/UfM5GOd6s5ginrNonOd1ej8EZ+ZxcnCC/hwV4DJxrbXCpJCXSG
         YpwmpyEddRgWPOawf5vJXchKpRMMUBREdygmNtApAUXXBkxyeXJwod8mQxiFlAupv3kb
         DK2Q==
X-Gm-Message-State: APjAAAWwdSPEX8Cep2d3gI5nxoU/EpwIqXUhjXQ6Ojf/EBGusck1ZhKq
        tOl/lXTSEtC/8nqJ9FgFTD28a4VZ
X-Google-Smtp-Source: APXvYqxFQf1wBLgddRpmo2fEQ7r8JksSx64AG+9lbnupJIdgCgw0Hyn/r60S7/h/aXtRMvePlikgDQ==
X-Received: by 2002:ac2:43bb:: with SMTP id t27mr45838660lfl.187.1561067964771;
        Thu, 20 Jun 2019 14:59:24 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id a5sm116147lff.75.2019.06.20.14.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:59:24 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] clocksource/drivers/tegra: Cycles can't be 0
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-8-digetx@gmail.com> <20190619081907.GH3187@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <97c75bd3-3448-de52-46c2-3e302a6907d5@gmail.com>
Date:   Fri, 21 Jun 2019 00:59:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619081907.GH3187@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.06.2019 11:19, Thierry Reding пишет:
> On Tue, Jun 18, 2019 at 05:03:57PM +0300, Dmitry Osipenko wrote:
>> Tegra's timer uses n+1 scheme for the counter, i.e. timer will fire after
>> one tick if 0 is loaded. The minimum and maximum numbers of oneshot ticks
>> are defined by clockevents_config_and_register(min, max) invocation and
>> the min value is set to 1 tick. Hence "cycles" value can't ever be 0,
>> unless it's a bug in clocksource core.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/clocksource/timer-tegra.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 

Thanks!
