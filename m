Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939C9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDD720840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CxySff3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfDBQCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:02:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35769 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbfDBQCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:02:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so4435748wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xuvM19l4tS/whe+xDSqaW8znMri7al0zrYj7EGOa/Qw=;
        b=CxySff3GsW7pfaQJCm7ZWOBCvA1YZpN2GjWYM6M4m/zmSKLBSTXGCeyn3xYOp0lVGo
         MGEOimtAtrroZqT2KZN8mpusZJGT/9V8Umhrrz+++lAj5sPvDfw8TMOgxweVL4bY7AcB
         khOObzLv9o4ovkV9RINfD6+E2HqCbQghgLNAY6dHjZNT6LXMPY5gjk6enYF+mXb2MHuG
         9fVW3Wt6TqRInZdO0B4ye05D5TXSU8+hfiKsWdCAWTZZ9L52u3tD9nhF657gQMHxG4Wf
         s7wfEGbc0bopqArjhKZLrR15nj95TBu2v+Q7yuEWIoETcyWyQv1HzXw+ogrkEc9IdLO3
         HzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xuvM19l4tS/whe+xDSqaW8znMri7al0zrYj7EGOa/Qw=;
        b=ByzS/cDcJzIR6sm9g8P5DKiE6YVS8wdgFI1Z1mtC3Zgrn2N4Ux3xdq36QZESetcrH9
         tBjAjnWWJeHlopZ3wLauxGseus0kvqOXu3864U9XMlmgrn2/ohx22eXa6x8UU/BWQQr/
         +C93kfKJztovRyAhe6O5uTW7hBd+y7ZV5ZtJIkVfE2p3kTrzXqOVeVLn/6hRz+itxygY
         QlSbkKmkyM7c8vJK026S5imgRofn4qKW3q/8rN9mAt36zhXDYXz7KNQr84NEQ5JsOacp
         ApsZkcPRjy0yHbY1+QhBKMSKtnWNf6dbZjWWZbw78t10QpWCFHMEP2UDd4t94Le4VMhc
         UMKA==
X-Gm-Message-State: APjAAAXGI9XRGrnyaKlu7U71hzMsGnXcRoFhNMWa9SiHtJlvKUA0Q21a
        7IuFoY3iExpWbvaNOLlQcARxEuryA3iW0Q==
X-Google-Smtp-Source: APXvYqx3FuzLyAk9yvLLN2chdH9ynjd0mqX9gBCYS9lmM/nGJ9isxWs8IRv9FqXCoR0+IPMSV99PCg==
X-Received: by 2002:a1c:9991:: with SMTP id b139mr3954509wme.53.1554220931372;
        Tue, 02 Apr 2019 09:02:11 -0700 (PDT)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id b9sm20541332wmc.9.2019.04.02.09.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 09:02:10 -0700 (PDT)
Subject: Re: [PATCH 3/3] cpuidle/drivers/mbed: Add new governor for embedded
 systems
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, tglx@linutronix.de, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190308212047.28767-1-daniel.lezcano@linaro.org>
 <20190308212047.28767-4-daniel.lezcano@linaro.org>
 <20190402132236.7h264nffbgnojznw@queper01-lin>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a8db3115-b12b-3a8a-5dfc-a3d068ac3810@linaro.org>
Date:   Tue, 2 Apr 2019 18:02:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402132236.7h264nffbgnojznw@queper01-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2019 15:22, Quentin Perret wrote:
> Hi Daniel,
> 
> On Friday 08 Mar 2019 at 22:20:47 (+0100), Daniel Lezcano wrote:
>> Despite the naive idle state selection for this first iteration, the
>> governor provides a performance improvement of 30% for Jankbench
>> throughout for the same amount of energy than the menu governor
> 
> Wow, that sounds really good. Which kernel and board did you use for
> testing ? What's the perf. metric here ? The 99% percentile of frame
> completion time ?

Hi Quentin,

I tried on a hikey960 with an android kernel 4.19.

The used percentile is the 95%, the tests are jankbench list_view and
edit_text, and exoplayer. Values are normalized against the menu governor:

list_view:
 frame duration -35%
 count: +20%
 energy: +1%

edit text:
 frame duration -45%
 count: +27%
 energy: -0.3%

For audio and video playback, there is no frame drop.

audio
 - energy: -2.8%

video
 - energy: -3.8%

These are preliminary results.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

