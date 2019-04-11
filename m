Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831DDC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDF42184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8Cv4QVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDKUOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:14:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36700 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKUOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:14:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so8209231wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mfgYVEL0NtELnzvBqf/CA5vN8U+yudOWgv+okoGfuDE=;
        b=A8Cv4QVldwj/mU215BXnCL1BEw/YfZEiEw4zOHbLYijk4QQ4mqiZNZ7aNj6v6YAeX+
         DsPerV6eZlexu46ETmaJBODBiXoJU4isYwhPeu9naNgTB+Iv34Vu5r1tEt3JAZE0qS5z
         ku4+bcu2iLSLZrg7RAG8cP5/bXNIVpDVBTTuExV+GzlZE91+a3IJuUtbmQDBG6Qwj/Mx
         LP/p+METLB9sWWlpOez5TRXcpLT0rkjcIdwul10zjbHajZD3/h5FolUgUXf1STM8eqDb
         I+BjTvRZg1ZBq1sgTMZUtvM7JC+MQW2Rh11Ws9fmN364K0Bxm/bxSU2rjTpo0wNwQ3DP
         9ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mfgYVEL0NtELnzvBqf/CA5vN8U+yudOWgv+okoGfuDE=;
        b=nNaoHSDu33UUALOmcoewe76kD4l7kJDLNMJ70sFdBR7a/O7UlOzEjnpJpIU4Uysids
         mJ1av1Bw24QtVRGWPENOG3Cfe08JWVKSXfMexr9xlwa8iQLoEsCd74Mx7rotcvvSASUz
         i98uQyGWYOM0cHkDggPdS4MJ5oj5m8ssmDpQeyAi0coq5H//QNeMPNhKxLY5j+R9MWs8
         B18fno5AuGnTozCqUdM9uRZDGxbQxLCqWkaj32MalZFM1SDnZAZlRJsoJNdAUHmcLGFj
         3kAs21ozFocTCI/gm/UAqKhEBuBKXPaVPLXrOCpyi07YhtF8N3m7eFoawua3/s6+uzcP
         8kvQ==
X-Gm-Message-State: APjAAAXhlzjNuzodCgDuT0wh5ZhhGYXQhQMTm0IGFCuXTa17jgqYveBE
        JH7Vk82UXD8My2YcbGi/ELjCMg==
X-Google-Smtp-Source: APXvYqwpWGbLQZqjS4mBUKVJK7P7MJghvEXlnvSMNNt4lyD4Ql2GNeMD4XLOjY8a4lA+BTs2Ny3ZeQ==
X-Received: by 2002:a7b:cb16:: with SMTP id u22mr7977250wmj.60.1555013684798;
        Thu, 11 Apr 2019 13:14:44 -0700 (PDT)
Received: from [192.168.8.100] (195.118.130.77.rev.sfr.net. [77.130.118.195])
        by smtp.googlemail.com with ESMTPSA id i28sm110206567wrc.32.2019.04.11.13.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:14:44 -0700 (PDT)
Subject: Re: [PATCH 0/3] Bugfix and cleanup the timer driver for Milbeaut M10V
To:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1553483149-8922-1-git-send-email-sugaya.taichi@socionext.com>
 <30226b29-bee5-6410-6ddc-5943c834dc15@socionext.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8b1c127e-6a19-fb1c-4643-981c50656dc6@linaro.org>
Date:   Thu, 11 Apr 2019 22:14:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <30226b29-bee5-6410-6ddc-5943c834dc15@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2019 09:11, Sugaya, Taichi wrote:
> This is ping..
> Does anyone have any comments?

Other than the missing Fixes tag, the patches look good to me.



> On 2019/03/25 12:05, Sugaya Taichi wrote:
>> This series fixes a bug and cleanup code about timer driver for
>> Milbeaut M10V.
>> Since it is difficult to separate, it is integrated into a series.
>>
>> Sugaya Taichi (3):
>>    clocksource/drivers/timer-milbeaut: Fix to enable one-shot timer
>>    clocksource/drivers/timer-milbeaut: Add shutdown function
>>    clocksource/drivers/timer-milbeaut: Cleanup common register accesses
>>
>>   drivers/clocksource/timer-milbeaut.c | 66
>> +++++++++++++++++++++++++-----------
>>   1 file changed, 47 insertions(+), 19 deletions(-)
>>
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

