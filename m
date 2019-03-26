Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECE0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7ED2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdOJIOe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfCZPXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:23:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37197 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbfCZPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:23:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so13394803wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WddYwkXAY/Tsi87NmwWzGmL0EwMpqgKBoopyDwPbmEg=;
        b=NdOJIOe1oguHGIOps371L/qncSYJQtNTU1TH/4OfGukXF8W85e1DVPJUSohRLPyTxR
         2gets3BsZGe8b++3oZxC//Q9F9g6lDh1o6kSO5J266OBVZKGxW+dorBf6FI/g7PKGVNx
         nYD/VB2+NtAIAYjPdEAJ5ItHKQ2MuUx7s+DxarHgGhoZSBZLOS7apK6H+W7m2Gwo++qU
         3zA0SIMOSzsP/i06shLjMwLNsartGcfOdznBR3VD/EyyHJuJfh/Az4CJTk2xEJRAPnxn
         ENCVgnr4hfznb98DvT1r2wK7+6gBQV/lICZZ4G4kU1X9Z46f8jF1DuFw8ak0rzWgJBh9
         fdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WddYwkXAY/Tsi87NmwWzGmL0EwMpqgKBoopyDwPbmEg=;
        b=tjqEFSQ+vFsfEMNYP6nzOB8i1dOWFDkKyUHT+Br3Ki16uiSiTB4/Hdawk7KfuRM81T
         SPM1uegMnClLd2K+DR9m1VwHLnB5t9zQsHKloH7Tyyqep/ThbQWLDRgyzisA09n1gkOu
         pCGlifDZkbyWeBh6m+IjyqxICATIZokOZiB+Mgr8iOqQHo8yeL/wv7Rksw5wDpl5ud6N
         d4m45TRP865ZMmfccdpS2sZi/1MZ5ttgqoeHCe9moxNJpMmSxzf8p0Ud5KkFoxDZz+yM
         cGqH2XbW8nvWjrkMazsfJkjpvHPc8fcrCV53lTeeAiuqwQxFjdNx28gnUQxXtorXqnHw
         gG2Q==
X-Gm-Message-State: APjAAAWU9kNZO0AvOmsvojicOJPhAA1BnEblYotUI0dLDQFDpOu/7ocG
        thZnZfCLb0bv8Rr5lTJEGv6fX4TVeM0=
X-Google-Smtp-Source: APXvYqw5DcqNDRiiYtNoR/Kog2RwhylMWMNfIGF/DiT2y4+ObhqtZBGKfZCAp0KFlQY+lNpPfoiWKA==
X-Received: by 2002:a1c:4e04:: with SMTP id g4mr9119604wmh.127.1553613780500;
        Tue, 26 Mar 2019 08:23:00 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id z129sm19667902wmc.33.2019.03.26.08.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 08:22:59 -0700 (PDT)
Subject: Re: [PATCH 2/3] genirq/timings: Add array suffix computation code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     rjw@rjwysocki.net, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190308212047.28767-1-daniel.lezcano@linaro.org>
 <20190308212047.28767-3-daniel.lezcano@linaro.org>
 <alpine.DEB.2.21.1903241825210.1798@nanos.tec.linutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
X-Enigmail-Draft-Status: N11100
Message-ID: <5ad6f7d7-3081-8eef-1adf-3ce705a1ba94@linaro.org>
Date:   Tue, 26 Mar 2019 16:22:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903241825210.1798@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

thanks for reviewing this patch.

[ ... ]

>> +
>> +/*
>> + * Exponential moving average computation
>> + */
>> +static int irq_timings_ema_new(s64 value, s64 ema_old)
> 
> There is a mixed bag of s64/u64 all over this code. Please stay
> consistent. We had enough sign confusion bugs in the past.

Right.

I have a question, ema_old and value will be always u64 type and the
function irq_timings_ema_new() will return an u64 ...

> 	value = (value - ema_old) * EMA_ALPHA_VAL;
> 	return ema_old + value >> EMA_ALPHA_SHIFT;

... how can I deal with the operations above when value < ema_old ?

Shall I use an intermediate s64 ?

eg:

	s64 aux = (value - ema_old) * EMA_ALPHA_VAL;
	return ema_old + aux >> EMA_ALPHA_SHIFT;
?

[ ... ]

 > Other than that this looks good to me. Nice work!

Thanks, I appreciate.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

