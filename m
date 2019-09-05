Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFADC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A417320828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k76jOrRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbfIEIPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:15:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34891 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbfIEIPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:15:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id n10so1768768wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 01:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=10aGnknD8IVEjfbOX2J03d8KjnX6yhuxq2udar1p34k=;
        b=k76jOrRn/KqtgyfYiCm9Ukk2P3wGLbhaWHDEQR0fjgSahxgrv783qMr08DQCvvoFHb
         dFWrX/vqeJYe0lMt90mMjPIVomNPc2EEGH7Qyela16mLtoeq5MFuuWSCD23Ka7njLGpD
         vogzkJ1kEvAkU+Do4oDdoxU4CqoNBABMxFgcr1iKAItorlnA6vClv4aaRagvvUM+PvWT
         uPkPn7DgrbzAtzYn3CqhC/gNo2rC7GcL0nBRJIOpyRbeZskpX0VxoXCs1sxNNJt55gxb
         0w3aZ6dYg1SgwHESDCL8DQyDPhMN6vvRMAuoGDg8Mnd1mJwz+mNfCaIwtCl0SbbNi09a
         uKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=10aGnknD8IVEjfbOX2J03d8KjnX6yhuxq2udar1p34k=;
        b=meEpZfvyRAUFE7FtRBo+jcJjVMr9uUBEmmxMnjeHcpT9ObjsbgMvZGtsF5R6aEPkfl
         pvikKzMjTHxuC2IOq5/UFLEyCbM6xwpbR1C6ME7BA/KCwPc+WdYA3xUVImojguj1hwfw
         srOEcyYB5JENH6Sn36hOKoH80AyHy3Z89qmeOa7qmQA32i+JBNYSdOQexeab/qsK6iKL
         ZJ91ML81+6rtt5u0nHNAcquqjH5P8S9EOqqePtAhmUuy8xNtayaCP686MD8PrF7aPZZf
         c/5NmSAjLYL6kKbtZZg60g3Ze+Qe2+WZnhVuXqnjE2NNgeKfSg+Ei+j+Ha8Jv7mUlNSY
         nCxQ==
X-Gm-Message-State: APjAAAWPeKDjyr8YzEXg3qY1YLBsT1dazW1H7Jc7xrDVNE4Thk1Gsu35
        c2Qy6cOiEN9p2mJudPWpjaWaJg==
X-Google-Smtp-Source: APXvYqwrO6C9MyodFbqDZysM24MlqavSlQNIAbuArfba4cg0pHZov957s+oST5S0PxX0HKLaEDgF4w==
X-Received: by 2002:a1c:a383:: with SMTP id m125mr1870964wme.57.1567671342179;
        Thu, 05 Sep 2019 01:15:42 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q124sm2858526wma.5.2019.09.05.01.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 01:15:41 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] misc: fastrpc: free dma buf scatter list
To:     Stephen Boyd <swboyd@chromium.org>, gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mayank Chopra <mak.chopra@codeaurora.org>
References: <20190829092926.12037-1-srinivas.kandagatla@linaro.org>
 <20190829092926.12037-6-srinivas.kandagatla@linaro.org>
 <5d70991c.1c69fb81.c0590.2f13@mx.google.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0b530a6a-a788-4a45-38f1-41b85a814afd@linaro.org>
Date:   Thu, 5 Sep 2019 09:15:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d70991c.1c69fb81.c0590.2f13@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/2019 06:11, Stephen Boyd wrote:
> Quoting Srinivas Kandagatla (2019-08-29 02:29:26)
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index eee2bb398947..47ae84afac2e 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -550,6 +550,7 @@ static void fastrpc_dma_buf_detatch(struct dma_buf *dmabuf,
> 
> Is the function really called buf_detatch? Is it supposed to be
> buf_detach?

Thanks Stephen, for you keen observation on the spelling, I will send a 
patch to fix that!

Looks like I inherited that from drivers/staging/android/ion/ion.c

--srini

> 
>>          mutex_lock(&buffer->lock);
>>          list_del(&a->node);
>>          mutex_unlock(&buffer->lock);
>> +       sg_free_table(&a->sgt);
>>          kfree(a);
