Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B33C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB4320675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5a26tuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfCGJJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:09:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33032 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGJJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:09:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so16469552wrw.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 01:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CSHAIVlC8MxNW5ZPd9Q866jz25JQhv2lMabCEAfBPuI=;
        b=O5a26tufocBIKL7hqxs5zkVFHYoFNavYeq/V3nR5VEjPJ6T8zUK8aGwDRUTlI+ehm1
         EUZmOspRHOIgqLVgk03QW15xnd5lOSSMRAz6v6EANfjg8oV0CGtPN6iozDDr0AxAF3e9
         BTqQ7hA3rEhyenFi5RW9baoTNvYkRaYWiACkY3W89EVE6LupcxjuR6GPAGyv06jTK55s
         qsQRtb9spkpoGi22qjia/M7EFc2bav2DUnUkgxFNOgZry5I9s0oxmWFUkqSG/K44B3fo
         xBTpYtgdvrn8VPQMzRSUeTco695vQb/68D37RN2twTqpzvZh3aOCdgPHzEDSZGbbeorI
         77rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CSHAIVlC8MxNW5ZPd9Q866jz25JQhv2lMabCEAfBPuI=;
        b=F2j2dxumIp9AU0VJ25mn5qMbo38GK619XHw4aLxTNz4+DeDNrTGdGJJTc9qsCJqVcz
         R0KiZ26jPsp3M+tH3MVP2SWXi8W+rVSrqzCGMsLZcLzwPSQfE+tx0hRWzfWBlhX187B2
         sgT7RIOUc0E/CG4k0/T8j9M3qVTGUaCB5reNReu0iKPz0PUC5IK0j3+tbdrry+qMWZSP
         UAgLHQlym7dAdjA/6hJW3WA1CaY7trEolmKwcJQTsrcu+FgD+gqe5VZ2hXQFmrp2td8r
         d9px7H6QSv40HLfFY/e2p2ZMJ1p32IY+6aEQNT6m9PK8CP9fTLhr9RgbVsUbVIbTA2mV
         qVqA==
X-Gm-Message-State: APjAAAV5+Gp3KULCym1QU4crj9pVDYJW1MmYBoIpR0YGY+gBMeC8VEIs
        amyY4w5wQ9exTyx2/pjHmfjFZzmK6+U=
X-Google-Smtp-Source: APXvYqxq6kl6Er22sE51kDOfrIDeo1TcREtvxv8O8AktuqH/u4GlAqInx9ywz5QpF9PTnfKvsEAaWg==
X-Received: by 2002:a5d:52ca:: with SMTP id r10mr6275678wrv.187.1551949747216;
        Thu, 07 Mar 2019 01:09:07 -0800 (PST)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id y5sm9930432wrd.97.2019.03.07.01.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 01:09:06 -0800 (PST)
Subject: Re: [PATCH] clocksource: arm_arch_timer: remove unneeded pr_fmt macro
To:     Yangtao Li <tiny.windzz@gmail.com>, mark.rutland@arm.com,
        marc.zyngier@arm.com, tglx@linutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190305170851.24643-1-tiny.windzz@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <471bc17f-fb4e-c4af-9814-da0f72484c0e@linaro.org>
Date:   Thu, 7 Mar 2019 10:09:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305170851.24643-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2019 18:08, Yangtao Li wrote:
> After this commit ded24019b6b6f(clocksource: arm_arch_timer: clean up
> printk usage), the previous macro is redundant, so delete it.
> 
> And move the new macro to the previous position.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied, thanks


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

