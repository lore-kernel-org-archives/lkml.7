Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBEFC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B022084B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYFrrnNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbfFRQuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:50:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42787 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbfFRQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:50:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so249448wrl.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KSk4moREDVQrfaFvvaG4JNEpQO7UXRGLSRSH/qJ+Hf8=;
        b=OYFrrnNYl9Boz+yv/ZqqkPtI+ZZCBmg3QVTr6t3T7Tujvs9N+iWArZa1sXtsu63+mK
         yF1DPTBjzZTRCzoD6Ng5l8CBQ/jVwvhnuKdcCOfiAlVISTjPT2aid54erklkFX368Obz
         E/86CpYRNLVyC7leuks6PBrNF/rrcZgs36GhhxRhcJHEmsnJKmBmjwbZnlP20WMd7dmn
         vduei46eD42DJo5XxEPTdNvHtFvcYuLtRx54fnXx9a856TaMQhBtweQT7f9JW4mjvcip
         mW9QIxEKmzROPOIzXTzmbVy2yQ2kVHktkRihmDSf8GUtbJ8gn9bA8zF/+aUnA15U2Uhs
         OLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KSk4moREDVQrfaFvvaG4JNEpQO7UXRGLSRSH/qJ+Hf8=;
        b=Cn6NlT9hgjNcwvFR69v2piMTBSk9Pxw0QVUPVucZfaW1wWNY/P1JPDaXo3nyjXKhvj
         riBER/r6FIuQkdprpEF7IlDznzYpN5d/DciJuzRnPrX9KYE4jiQU39RWWJQMbB8F6zi6
         0rIe1D7QFftGyrVtw+/SQ08c1U0GdoihsyxyOzxuLYVL+/ffIwpbf5tqJ9S7EZ//4qaA
         ExPSS5roUlskPrMi1Pi7SYxG3VAiB9Z29iKdyVThlkpYn9X7agydciFkDuVLJirsh24h
         6+am2cUv8IF8GQ7o82gGwhNcEf6hfhtr/xK8xEUQ4p2YN0MThhPIOgZqICukLF3MQGwP
         AbRQ==
X-Gm-Message-State: APjAAAUWF+tcYntLwpUUY7J0/QMQaQqcKvd3uYPpR2lt4orK025u4+d6
        qYlMvW4LUQ3N74JsDgvot7cQFhOudQ6tXw==
X-Google-Smtp-Source: APXvYqz02pp7jrNPiLtRBNsaULwRQxJ/0Ckr/N049AUpbNenDnGGjDoaGajTn9C+jKdSxnVaUXHD7Q==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr20234263wrm.191.1560876607432;
        Tue, 18 Jun 2019 09:50:07 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id l8sm41152736wrg.40.2019.06.18.09.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 09:50:06 -0700 (PDT)
Subject: Re: [PATCH] dmaengine: qcom-bam: fix circular buffer handling
To:     Sricharan R <sricharan@codeaurora.org>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190614142012.31384-1-srinivas.kandagatla@linaro.org>
 <f4522b78-b406-954c-57b7-923e6ab31f96@codeaurora.org>
 <d84af3ad-5ba4-0f24-fd30-2fa20cf85658@linaro.org>
 <2d370a33-fa16-45ca-cf82-9d775349f806@codeaurora.org>
 <544851f6-58b8-2506-01ce-5c4d1f93fb3c@linaro.org>
 <a50066ac-be85-6706-e7f3-f1069fd0dd0b@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <31574ef2-d675-bb36-08d1-18b756ebd29e@linaro.org>
Date:   Tue, 18 Jun 2019 17:50:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a50066ac-be85-6706-e7f3-f1069fd0dd0b@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/06/2019 17:27, Sricharan R wrote:
>   The Macro's expect that buffer size is power of 2. So we are infact passing the actual correct
>   size ( MAX_DESCRIPTORS + 1 = 4096)
This will make the circular buffer macros happy but question is that do 
we actually have that many descriptor buffers?

This is what is in the driver:

#define BAM_DESC_FIFO_SIZE	SZ_32K
#define MAX_DESCRIPTORS (BAM_DESC_FIFO_SIZE / sizeof(struct bam_desc_hw) 
- 1)
#define BAM_FIFO_SIZE	(SZ_32K - 8)

Wouldn't having MAX_DESCRIPTORS + 1 = 4096  lead to overflow the actual 
descriptor memory size of (SZ_32K - 8) ?

--srini

