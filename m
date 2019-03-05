Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5E2C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AAA2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SINnBMeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfCEDjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:39:53 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:42855 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfCEDjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:39:51 -0500
Received: by mail-pf1-f178.google.com with SMTP id n74so4571213pfi.9;
        Mon, 04 Mar 2019 19:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x1CuHGM9EqUE8GrRq0PHi/1a2+zlB4DyXqAOJpNXQT8=;
        b=SINnBMeqpgcggDZKnQJN7408OY+5m5SZjmK42ruOnJWj0C/rdUZiQ0xPfNxz0WrnKy
         u0bXgSb+Wcw085GjbPJ03n21hBiErjq7tqTTx6Qe/NG2XwHmp90p6n1ae+W4/5hUT/wY
         jUmuDoB8Xa4GBuELgq0e2426DrpRXIjRxo5lXYVD0/p1nL7N2hPdlfgOK4wnweAwq8bd
         Fw8F1ebsT2iAHYFh6nO7/R2t7pTsfRKgAl6zZm86YS2/LRIMoSjXZnzN5tYb6y5ue0Qk
         8dBfn2383TLD7pd5rMgRSPRIoR+61jDxJasW+Z8/eipHK/jfNui7dPXTXiozmv7t1PDy
         OiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x1CuHGM9EqUE8GrRq0PHi/1a2+zlB4DyXqAOJpNXQT8=;
        b=aIkxMZI/ZRy153jpC+f2s+19/c5FPTbQbbrdWVguWymW8Kk2peht/chGYv3zzw+Y9l
         0R64TkHnQUn4/E/fhGN1BroliEC58eW6yxJzlxRubc7qloZ5cWfAoiEOrKPSYDDdAkSg
         lLAlOjpXdEB/uBoBlT4rk8tTm6C92ykIvqTf+eqEATW+E0CTR8HmlGIJ3WkhVyaM8Xqf
         F+nBETZSywdnC98mnjGLelkalT1ll+4+YjzGxFPaKhjLRg4oKCFAKcgD7e29hS76WMdX
         x4Ebm76NJW5q3+cDGeonr5O7fEH7y0T9I4kh5psj1wiMqNPtv7it2vSWYmI2fPdJR58n
         x5NA==
X-Gm-Message-State: AHQUAuYaPWGstd1hzwQnsF3JzevxZmaBmVHQYvn7d3YQU+d40yY/7q3d
        yJCL2ru8BRKLku5el2FZ/Ckb7zMM
X-Google-Smtp-Source: AHgI3Ib3KWAnrNyUZZ3IZaOljs3Rlp2UIXOUC3SMG05BoXzAiBmxmKoUz2CnhvJpdaln/fXy2RI/Pg==
X-Received: by 2002:a62:fc10:: with SMTP id e16mr23748449pfh.83.1551757190520;
        Mon, 04 Mar 2019 19:39:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y7sm10349053pgf.42.2019.03.04.19.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 19:39:50 -0800 (PST)
Subject: Re: [PATCH 4.20 00/88] 4.20.14-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190304081630.610632175@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <85d11f50-7dde-54f4-9f4a-db37c56d063c@roeck-us.net>
Date:   Mon, 4 Mar 2019 19:39:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 12:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.14 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  6 08:16:03 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
