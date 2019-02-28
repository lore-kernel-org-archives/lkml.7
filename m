Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D10DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D9120C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TLrbb5ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbfB1PbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:31:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56243 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfB1PbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:31:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id q187so9687974wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 07:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YrFq4peLuN62Cw+RvpRMk9ymMFBSZPIVHmIFKLtxidM=;
        b=TLrbb5juIqET+wHGfzSvjv0mxtHHwzdrjbMhpxwbX/ToHIQvi2c2wg3gO/ARqvbFI8
         TkLzxGMy/ANm+xnxf8P5BRttx4YchhoqU08Kqr3e8J9eyPGXP7YLR3BurhiLK7CotpEh
         DdLSbRqXn8IQb+fVm7I+4KQLU6IYlfTKAGbzhyltJ2sy2g17bIeOELO1aU55Adpardw5
         x1+QliiPrxD7jfN7VQBVqEwFA7jKA1TQAHFomfRzo0cH8DWH+MH/BS4LaYCCVipkjnSj
         wpf2tEf6PKLUtFRDBWv2BwcU5VXxVV5ceO2gqZJIges2ozRrv/hBBjre8W6Q2libCNEi
         QTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YrFq4peLuN62Cw+RvpRMk9ymMFBSZPIVHmIFKLtxidM=;
        b=rPVqFxCw4qnV9nrlRpqKoXTpnvO537M0EexlR212c4cHRxPE3eW6iXCuPBcaKSFeoR
         ZqC/ypL03LpBxZZeF+8N5iaF+pP1B+Rok4AJd7xwWLQuO6bGJ0H9ujtKfAffqQHGLei2
         MR7CbrscCnSTMAU+oj+h6hHO9Y1MQ/QgSUv+0HUYJXHPd2SJhNPPfy0afylKi6qvE0IJ
         KLxKSCCiuUCparqbUSBiwP7I8PmoDVF7DNoN6CxeHt+veL4zz/orrvIM7dRBdGxmQvrf
         xv3If06eSEYqHToZCQUGrr8QggmnEtoS/UHUPPePulNLr3BdfHLxIPx9tAJTlwU5IYXm
         SlCw==
X-Gm-Message-State: AHQUAuZJPKQeBVSjnoV5Ll8lWVPZSwNyO7gl6GOixCmddQ50JMa5lUpo
        FDW0sj6uVYoIXmVYroF+sCBmiA==
X-Google-Smtp-Source: APXvYqz1oR+wuqCFdbCcIk+4KU8rhrZgsS4M1sKFH/c+FkH0h+jOFgJSNuD60Y09D7pbu21bjcf0dw==
X-Received: by 2002:a1c:9d94:: with SMTP id g142mr144463wme.125.1551367859183;
        Thu, 28 Feb 2019 07:30:59 -0800 (PST)
Received: from [192.168.0.41] (244.150.136.77.rev.sfr.net. [77.136.150.244])
        by smtp.googlemail.com with ESMTPSA id s127sm3318513wmf.39.2019.02.28.07.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 07:30:58 -0800 (PST)
Subject: Re: [PATCH 4/7] ARM/ARM64: cpuidle: Let back-end init ops take the
 driver as input
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-5-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <37c1fd29-a888-4ae5-ae7b-3d4c00812941@linaro.org>
Date:   Thu, 28 Feb 2019 16:30:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190228135919.3747-5-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 14:59, Ulf Hansson wrote:
> To allow arch back-end init ops to operate on the cpuidle driver for the
> corresponding CPU, let's pass along a pointer to the struct cpuidle_driver*
> and forward it the relevant layers of callbacks for ARM/ARM64.
> 
> Following changes for the PSCI firmware driver starts making use of this.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

