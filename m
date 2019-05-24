Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB81C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034AD20675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lk+FkbhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390717AbfEXQLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:11:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34469 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389588AbfEXQLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:11:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so10606130wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=160Paj/lPd85OhWaT9/sgowVap7gjQwewiJrcI6C66g=;
        b=lk+FkbhRsiiJcxv7AuvF/7Y4Tc52DnfanHK1otTXas1dYfl3+p/ptCtdtjBOSlhVZz
         YX69WRAUtegfu8+r0Nhuy3nejp2BHm1Jf4vQb6ojgJlnKC6q4SPhmyufkIZvDzUJvlih
         Ho7LzU72dYGBKdqgw+940s8TtQ+uL0masHxsv4DIg7EHkxAbEupRwDZwBq98pARrDzzT
         Z6OXWh66ZgaqIzn/jdLMCFIy16pHvzHRrqEN8xQRHdJfQF/CQknRMusHZROekge6bn0F
         hA2dFo4ZGrFKESto0+FB/Qz8yCFEL/aRRMRbilU8A1TPwSZBr55SFZUd1d0aKFtXRjoC
         Ea8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=160Paj/lPd85OhWaT9/sgowVap7gjQwewiJrcI6C66g=;
        b=oztsKpDhgUJw6eeSAaI1klyHuI6LL0x7u6qMGsnYpRqKmMSj14heBfb4BViYsqJX87
         /WHRCM1IKe4JLrpSwuO2wy69hLGQlNNmza6UKNFgxi7uj939a7rwvuxcXiynyE+D7I5n
         KNwi8hzHDG76mkkRAaNCkC7a9fVci6c+D6mYHYaJPOyAzsJ1wHTJeoM27REgbCFahPPF
         zfcaOeNIzUFvyAeTAVyKeIcEJ6bN2RXGuX54GMFSnGh4iXFdid+lKtX7hfDDnpDPwXHZ
         sIxYew/UoyFKtlYTb2SXWmc3zgFOztGoAEsNcKNgPdHfD1Ac3QvwMcoPQhF9+pA+0hJz
         VNTQ==
X-Gm-Message-State: APjAAAVaMGdGhvloeskmRBnBW2o9TrXrkNqy+Nj74zUg/MEVCghX2TNQ
        pPsqMOiEC18dZ/XwHa8qgTy+dVwq0GU=
X-Google-Smtp-Source: APXvYqzs2u6rAJfXZbk10Kqnnamqi5R+5n2+xBl9RWq3t38cho2YlS8DqJ7n1xgJ3s7oMk0OoMKbSw==
X-Received: by 2002:a05:6000:41:: with SMTP id k1mr33234918wrx.332.1558714271901;
        Fri, 24 May 2019 09:11:11 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id z202sm5249302wmc.18.2019.05.24.09.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 09:11:11 -0700 (PDT)
Subject: Re: [PATCH V2 4/9] genirq/timings: Use the min kernel macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <20190524111615.4891-1-daniel.lezcano@linaro.org>
 <20190524111615.4891-5-daniel.lezcano@linaro.org>
 <20190524135742.GX9224@smile.fi.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7e0d0246-2559-b749-f741-521d7cab69f5@linaro.org>
Date:   Fri, 24 May 2019 18:11:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524135742.GX9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2019 15:57, Andy Shevchenko wrote:
> On Fri, May 24, 2019 at 01:16:10PM +0200, Daniel Lezcano wrote:
>> The' min' is available as a kernel macro. Use it instead of writing
>> the same code.
> 
> While it's technically correct...
> 
>>  	/*
>>  	 * 'count' will depends if the circular buffer wrapped or not
>>  	 */
>> -	count = irqs->count < IRQ_TIMINGS_SIZE ?
>> -		irqs->count : IRQ_TIMINGS_SIZE;
>> +	count = min_t(int, irqs->count,  IRQ_TIMINGS_SIZE);
>>  
>>  	start = irqs->count < IRQ_TIMINGS_SIZE ?
>>  		0 : (irqs->count & IRQ_TIMINGS_MASK);
> 
> ...looking to the context I would leave as is to have a pattern.

Yes, you are right. I'll drop this patch.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

