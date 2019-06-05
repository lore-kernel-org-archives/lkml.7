Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E28C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFB120657
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yyD4roMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfFEOWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:22:39 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:34139 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfFEOWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:22:39 -0400
Received: by mail-pg1-f182.google.com with SMTP id h2so9240963pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o+IcDP8xywihziIgb7p/GLXZhp4cLmigR0A3EK7XJW0=;
        b=yyD4roMK8IUzMUzyYYIle4EboYZB9IzE6GPQGoQtFvfggOvviH/3vpHFMwjPy6yMS3
         WxYPl11RTtZxvEJUCaC/UF43bEUALvX5Jk2kEr+il/5OgV4GM+OFmk9/m42A9JOpmE6t
         X693rS571KV6xsvo170fRaAsVnujNlNuVARoPovwK38pFU0LPWSWkSb0t7tvlC3EJMIN
         eDpNXXsudC8vHx1QCZRIKcbDBuaPLij83tVhhdPWlQlSMuoQH3MGwO0CZCn+9E76qPum
         wesb7zyj/jsBaJCnnLkw77Pw1DmaVxfI/cQMUYdV9YXCeSCdZlgInhZJ+2eM2++wOOzr
         dRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o+IcDP8xywihziIgb7p/GLXZhp4cLmigR0A3EK7XJW0=;
        b=pXlVD3Sr2raQqb8rXvHprh3CjKlRxinOKLSqAQpYZUeC6dN5eCxop1FCtncCOFqV7q
         BL1H+q9vHCc5gEbQSjLTICVd2EYF7Spr2EzxTR9YQovIEc/oGW2YghdxkunatIhsJhbT
         KL16XnwEs0GxlqaEyDUMdc2jGNzleUmRXTRCw5Z3+0ddY97oETuh3CA4NQUg4kuCqtWm
         Gci2li5W/FUS9z7DjHFD8GILllshbPvIlP5a+sZPkAFQ0dincv/QInpw0QwpDhKU27Y6
         UWqyAOXeznacEd+Us1SkN2CukK4qrcTSKbMJzSSKdYeKbE0rQpJceUkQKdQq8sPbWBJa
         uLkg==
X-Gm-Message-State: APjAAAX2tOVfrg5wu65MOwasW0LLokIvN+gMOKKzA5F9wu7F7siNtMrZ
        w4GaI1cswQwOx+r4hIbsIbiPKw==
X-Google-Smtp-Source: APXvYqzeH4OGyObX0kyEFIyVLA5zY2ImKmCvMnoXbBNx09B0/gTQWHMF/IVXvqQWeh4fp7YF5zmshg==
X-Received: by 2002:a62:6d47:: with SMTP id i68mr46913713pfc.189.1559744557582;
        Wed, 05 Jun 2019 07:22:37 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d9sm17865159pgl.20.2019.06.05.07.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 07:22:36 -0700 (PDT)
Subject: Re: [PATCH] block: Drop unlikely before IS_ERR(_OR_NULL)
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
 <20190605142428.84784-4-wangkefeng.wang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5142de36-e834-1514-a63c-4addea773c41@kernel.dk>
Date:   Wed, 5 Jun 2019 08:22:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605142428.84784-4-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/19 8:24 AM, Kefeng Wang wrote:
> IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag,
> so no need to do that again from its callers. Drop it.

Applied, thanks.

-- 
Jens Axboe

