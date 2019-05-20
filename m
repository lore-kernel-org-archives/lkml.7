Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983C6C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D61C216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfuQsulH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392104AbfETOzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:55:46 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40333 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbfETOzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:55:44 -0400
Received: by mail-it1-f194.google.com with SMTP id h11so1953286itf.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RO2OZsOswAnqzoxA5Kah+EcYVhjoBdIBVPEusFbAhx8=;
        b=SfuQsulHoheqPTiq+0yTaNEt6guPJO5vtoQAXZ8LFw7P5630C1hIePmqANhr78VgMz
         RXSgnIKX2w8wiNOA/r9VFOqCc2Bu1XJgujekBCCPYO8DEGs9IgKhUShhiGa35tM5iRbv
         Erm4439OmvyMIxlRQC9PYG5xziVp7JdQLUV4lGvTvJQ0mxig80VdDtTk9S4xZwvzUNCf
         5WjA/xsgN/AOhR9o9mJ40COdjTaQ+BEUTmiX+7fgYwPlV2JAH4b9Gqmato1oXiIvxhXZ
         jbJvRkQznSjlmwf4Uet0FUmNaYSWMfiGDgxxC/4R4H5E+jLoU+c7/yBb/CvEyvbvMrqH
         uffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RO2OZsOswAnqzoxA5Kah+EcYVhjoBdIBVPEusFbAhx8=;
        b=W+5Jk0Y/uRNiylX5qV5Zbv3tj1M/GU38rlNOXCXKCoI4nc2Tukxhl0SLwDH7nBn92H
         8ZEQHszZdooJlfFKXFxVtFh0hO60qh+T21+lcRUkR+s1rfEpSMX09X5O/4yCHgXwQsBr
         N11roEIRxIWxI355qPEviO8fT2hKw1Ux8/IDAsEihYSKNgvjUQTFCStalA9VwO6tv6DX
         /0M3A4caYGNwKHJEQzv1O1/h3LH2JklDkLXBuKhrr35dJ9lzt7JEuvxDLR3AB+2WuTQ4
         2dTr5Mf6nsHfQGVctrn2hP+kZasa/aUQ+p0gDnDWxgCa2Hj0swPeZldoIQYPwk5iR2Ux
         fEdQ==
X-Gm-Message-State: APjAAAV4CJOWbA8APX7ORD6qRauOd1XUs4/R9IZtq1eFJmKetg5I+ClT
        8wawnStTe2kmlq2tJUmk/jgzYQ==
X-Google-Smtp-Source: APXvYqypeJLt6TpwEDU4qmkzd+WMK3Vx9kRrxD1fX0sLQmNDlYJDgW7Ki0ExxXNjnH0JE6d2Z1Sq0A==
X-Received: by 2002:a24:4c4e:: with SMTP id a75mr29422291itb.42.1558364143993;
        Mon, 20 May 2019 07:55:43 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id 69sm4206643itl.7.2019.05.20.07.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 07:55:43 -0700 (PDT)
Subject: Re: [PATCH 12/18] soc: qcom: ipa: immediate commands
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-13-elder@linaro.org>
 <CAK8P3a3v2fzSBmYk1vG7sKJ9jnAWGt_u91EuLC7f5jq_PqrKXQ@mail.gmail.com>
 <f92bfb59-07bb-e8c0-c307-cd69da7ccd8a@linaro.org>
 <5d948d74-f739-0cfa-8fae-b15c20fbe7ec@linaro.org>
 <CAK8P3a3161Oc3ALB74LTuDny-aO9E4VGYpmqQSNoDNbj6PhRsQ@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <d29335f3-75f3-00f6-8ae9-690ef3bffa96@linaro.org>
Date:   Mon, 20 May 2019 09:55:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3161Oc3ALB74LTuDny-aO9E4VGYpmqQSNoDNbj6PhRsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/19 9:50 AM, Arnd Bergmann wrote:
> Ok, that sounds reasonable, yes. I'm not sure if
> dma_alloc_coherent() guarantees zero-initialization
> though, so if that is required, you may have to
> add a memset().
I had dma_zalloc_coherent() originally but I think
Christoph Hellwig posted something recently that
removed that function, because dma_alloc_coherent()
always zeroes the underlying memory.

+Christoph, who might be able to explain or confirm

					-Alex
