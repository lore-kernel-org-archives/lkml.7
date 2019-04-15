Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC20EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DE2218FE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQUY7qlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfDOLFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:05:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34654 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfDOLFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:05:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so21381784wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 04:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MiWOHJ7bFbur4nnNPzNq7Rq3VDxdNvAdvuMbaHmvknQ=;
        b=RQUY7qlKSqVhMvNgX+jx5EwRSL7eakI2j43Yu4NsPh+hb1f65TGHQgjBwbqtx2TdJ0
         5bZWHGzH/TCBl94MbCsiNojFQdmijmji8cP5OeToefhXx+SpqgE+AoZNsJR0+SeN12JU
         M1ow6SNzTPXBo+YaeAbj/z4yhSWK8QnQWbugsV/aPZgS391glcIjFctfe51LtHFOP27M
         YBF4goBsQv+60JOHq8vWInTgkv6KPezkONjmZ654OEt+Qn9GNiFRaN5GCsXY7gxxfnDF
         i3+wZlwnJG5vof9PGlghDwNj3bqhMFHui6ahabn6qZ8R0bjr0lcJXuwMbmVF513P4jx7
         C3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MiWOHJ7bFbur4nnNPzNq7Rq3VDxdNvAdvuMbaHmvknQ=;
        b=mgH6Aw7WrE+KOKFz218wQI2PwNcXp3FbFT0Lu+XyvsUcyooRGGbKl6kLb5AXU3D55E
         yftR5dGNlGtl0GszRsJqASf+KA75VQHsBxCPAL+iVG6lK35xSdEDeNqlz6pi+eehXStC
         46yuy9NdW/BVNfWoAD8oQfcoITo8STX9Sd9j/MAhZDA42mDrgEEP4dT9ORXZY67nIZDJ
         RTxJw26EB2vMmavB1OdZuRsO1UFg/ilpsW1msLFe7TOE73iwyWrJVUsvbooP0ygnJUKw
         VywgsAi7GY0vD04acIiPEN4HwPIAjlpLQPJrjFSdTy++r9h0U/0OoR7apdw4gN94UnRR
         q+MQ==
X-Gm-Message-State: APjAAAXrScbKXrzTKMZXCC+3CREjrZXnbI1uoNmGP86ChsIfaoxznycp
        FJXftbE4fhEBcJIJCOMUyUZCDg==
X-Google-Smtp-Source: APXvYqyh4MH0NI7Ux8XjQDX46I0YXJhAezKg+EnjZz/Vje4+xI/PRKmkcVAX5xPWpJSMFmUpSKJ5DQ==
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr18682266wrw.71.1555326299612;
        Mon, 15 Apr 2019 04:04:59 -0700 (PDT)
Received: from [192.168.0.41] (4.112.130.77.rev.sfr.net. [77.130.112.4])
        by smtp.googlemail.com with ESMTPSA id z140sm43200519wmc.27.2019.04.15.04.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 04:04:59 -0700 (PDT)
Subject: Re: [PATCH 5/7] clocksource/arm_arch_timer: Drop use of static key in
 arch_timer_reg_read_stable
To:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
 <20190408154907.223536-6-marc.zyngier@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7a6460c4-aca6-404e-c104-e94eeaaba908@linaro.org>
Date:   Mon, 15 Apr 2019 13:04:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408154907.223536-6-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 17:49, Marc Zyngier wrote:
> Let's start with the removal of the arch_timer_read_ool_enabled
> static key in arch_timer_reg_read_stable. IT is not a fast path,
> and we can simplify things a bit.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

