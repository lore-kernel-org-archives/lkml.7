Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311C8C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01272218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay33YbtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbfGZPAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:00:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38805 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfGZPAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:00:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so51772624ljg.5;
        Fri, 26 Jul 2019 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UzwsdEpQP2Y4hgncO9eMUg7V4ByKsDvR7x0L9gt2XHw=;
        b=ay33YbtJZ+OTKtoUZC8QPAj1U+YbwlUXIutsts+q0e3pxzFOzhdh8xZ1RG066hSNPR
         iL2LEndafJqpl0VFzh7wCBadhUi7tGmgZuzawYuxjN6mugE2DQmvf/amL8dBPkkGhSve
         XgsCGXvmA72ISx3do72TtxQZ1BEWZhbOQb9zvWoMouiExBpJaH0XCTgelU13UOJT0X5z
         XLMqqQ8oQLwGi1HoXDy3tkW/FgslFxEJlcZoGgfAIDPYj1OBr+SUyDXxPod70MPjVlSJ
         F6MkEVpg9dmtVSPoVUIqFhMQCxWSHRWqYgwP4nt3TTcTytwBJMwAfsS0afBcaFBMDsPU
         LG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UzwsdEpQP2Y4hgncO9eMUg7V4ByKsDvR7x0L9gt2XHw=;
        b=ppmdYXmgN9J7KepVIcCTl70tIXLjfMRyTp4GIAT4VK2yiH5sTEcN8uwq7uSAclGE1H
         mLnDJXC3woI0i7Rl9rck3QID2aBO+1zB79oV9faDtqv1UCiHG77sqWcH25Ez8YWyKN3U
         5+W7tgv9j66MrmwofhN4zfDpDpVqttdI03zdlswzeLHGn7Tv5aehuy5WzR00WF+L+4PM
         mPu+4QzZueSjqjXwo+B7abOpYedSVcFix2jzAKvfSrI9hwRxl9Roq7rZzNwizptijShq
         8NSMwycA8wkY5Aw+09PuenAhonQw6eyQSOxe7ltGhhyLrrZiozMC+Srsvr0LzQnkB+3I
         yAdA==
X-Gm-Message-State: APjAAAVI+0CKhu+6JaeZD3wofoeiUTRkqmIIKR/jiY08o+H6yTqPRGRS
        5hp1XgeW9996TsPsCzxgSptmawVy
X-Google-Smtp-Source: APXvYqyfDuR/ORC/0Vvf/aBh3VaaWLhNE8k0fG7DJsoreWWXGTys1LvcDswSlr21DcxALfS0U6j/Uw==
X-Received: by 2002:a2e:900c:: with SMTP id h12mr47509855ljg.197.1564153249440;
        Fri, 26 Jul 2019 08:00:49 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id m4sm10128649ljc.56.2019.07.26.08.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 08:00:48 -0700 (PDT)
Subject: Re: [PATCH] drm/tegra: return with probe defer if GPIO subsystem is
 not ready
To:     Stefan Agner <stefan@agner.ch>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, jonathanh@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180726133606.14587-1-stefan@agner.ch>
 <de84d04c902d1f7f22b6f024b853a1c7@agner.ch>
 <cd14bca0a1f1e097265602a1d5f0c0f5@agner.ch>
 <f035a8ba-ffa7-b98b-a444-db8b4bbd34ec@gmail.com>
 <d02d9605797d784dc941c9d98769bf5d@agner.ch>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <72141479-4ee8-d151-90dc-168e5c9a79c2@gmail.com>
Date:   Fri, 26 Jul 2019 18:00:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d02d9605797d784dc941c9d98769bf5d@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.07.2019 17:57, Stefan Agner пишет:
> On 2019-07-26 16:46, Dmitry Osipenko wrote:
>> 26.07.2019 17:23, Stefan Agner пишет:
>>> Hi Thierry, Hi Dave,
>>>
>>> On 2018-09-07 01:31, Stefan Agner wrote:
>>>> On 26.07.2018 06:36, Stefan Agner wrote:
>>>>> If the GPIO subsystem is not ready make sure to return -EPROBE_DEFER
>>>>> instead of silently continuing without HPD.
>>>>>
>>>>> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>>
>>>> I think this did not get merged yet, any chance to get it in?
>>>
>>> Any chance to get this in in the next merge window?
>>
>> The patch isn't relevant anymore (since v5.3) because the code was
>> changed and now propagates the proper error code in a case of error,
>> please see [1].
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.3-rc1&id=bbad640709fd43ff77b8838c409c977c0b28430c
> 
> Oh I see, I accidentally checked in Linux 5.2. Sorry for the noise and
> thanks for the link!

No problems, you're welcome.
