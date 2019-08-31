Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A67C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45C022DA9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfHaP74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 11:59:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39667 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfHaP74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 11:59:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id u6so5583451edq.6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 08:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wqHLN1Ubhfd+hVXSg+9EoM4u/DnI6dgG4zDin2xzzdE=;
        b=l+/ej7XGl/fLdZgl2VlfgqGw9Ijvg2j4Op02EbALJBcDyp9Fn1KA25KdaPSh8LY86K
         9T/DU9gFDgZlUgScL6BOgP26K1po6XohrGxTiN7jN1F/VGrTRsV2nLBGXzmbHKs1qdqR
         q9fWWshEMUGr0npOR9gYHr5CYVcuXQoyVJVkeZtk8X6k7qBPXcJaU/j1wYI33i9zurnD
         Jf/LHoaLSnzmB918QXnjYNKSDfvMNBpd3cPe2Lq/689LPC8Wo1m3ESiXrIs/YB8IZ481
         M237uYUxQV/MPcaL2A2g7RrlJq3eXDFohaWHxR7TEUFOIgWKx0cFMqDXAE4VVap1NPc0
         G/9Q==
X-Gm-Message-State: APjAAAWkn5xVsGYgl8cATGd8jVxiB6Kwk39x8lfX1U0x72RKHspernpd
        0UvMZBGLNOY4rimp9FqX/Ad6J85r8Mk=
X-Google-Smtp-Source: APXvYqzHLoe8Itko54EKb5QriZRMLbcSRGHQmU9ZT1Sj29SDP46U7AIMRCXbyJgWLlui1m3TX9eVLQ==
X-Received: by 2002:aa7:ccc4:: with SMTP id y4mr21735740edt.1.1567267194704;
        Sat, 31 Aug 2019 08:59:54 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id w14sm1727714eda.69.2019.08.31.08.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2019 08:59:54 -0700 (PDT)
Subject: Re: [PATCH v3 06/11] wimax/i2400m: remove unlikely() from WARN*()
 condition
To:     Markus Elfring <Markus.Elfring@web.de>, linux-wimax@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
References: <20190829165025.15750-6-efremov@linux.com>
 <c9d3f0e1-d2c9-aedb-385c-82a8cb077253@web.de>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <4a064df8-9b44-8380-d7c5-8a94086c3a52@linux.com>
Date:   Sat, 31 Aug 2019 18:59:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c9d3f0e1-d2c9-aedb-385c-82a8cb077253@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.08.2019 14:25, Markus Elfring wrote:
>>          pad_buf = i2400m_tx_fifo_push(i2400m, padding, 0, 0);
>> -        if (unlikely(WARN_ON(pad_buf == NULL
>> -                     || pad_buf == TAIL_FULL))) {
>> +        if (WARN_ON(pad_buf == NULL || pad_buf == TAIL_FULL)) {
> 
> How do you think about to use the following code variant?
> 
> +        if (WARN_ON(!pad_buf || pad_buf == TAIL_FULL)) {
> 

Well, I thought about it, because coccinelle warns about style here.
But this condition looks more symmetric with direct comparison.
I've decided that it will be better to save the original style.

Thanks,
Denis
