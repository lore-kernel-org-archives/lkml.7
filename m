Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06B5C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFC220657
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5EsPVFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfCIWfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 17:35:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41805 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfCIWfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 17:35:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id k11so1012216pgb.8;
        Sat, 09 Mar 2019 14:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zOeAxJlYnKBdI8iT40m5uoUWy8JsL8feF0XC9zF6WCg=;
        b=d5EsPVFCuisXxv2R5FVX2Ei00pNSdcJkEVZqK/5/ZUwHnBMWFt5Zb5OfD1M9IPCG35
         ytCwESmc32ZfW4khHdJLWL+2VU2+GKD7kwH5TMj7iLUe2Gdi3JC3tL/DohjFevZAEhdJ
         ujMqk9WnEytu2JQN1Vj5PfcY6p2QCMxXB4GGxp4/L6SY+mj3bU9rlMwww0N94DC6eC3+
         OAmtsPJlxOiXdBcCUEWvkdfH9mXgrKZDt7BkBaYKPmm7ffXgag1Qk+WlifKefa9j58Qk
         Yk18N13ApKQm1O3ycMvhvhkQzzMPbBuCf1FOqo4x3p+Vs2PYFq3ykLXeRDofMYviY8yt
         C+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zOeAxJlYnKBdI8iT40m5uoUWy8JsL8feF0XC9zF6WCg=;
        b=rsYF5h51W1Klb8GqRQ9+GD9GrAR7KwZCKVECV/EehNDfOOXMYOcm34Ds69N1oEl3Ym
         1nmuft1W9aDXbzoLS2OypnZ12YL5uwJIDxdUDkBbz5CUpjN9X08mqe36gBt+DPUfDDSo
         /TLBmS8pIELzFc+ki9LWpm7Yf6fApIDDCqledZ3jOwdBi6byX+dJGtWSzHGIiHVSjhzz
         iBi8KmivPZ/9iou/rptFDuMpakVVNNs/JJTdT8j6K+VFxGsd0k/PDptz6yxrq1tmzqOG
         mjWhZpgoVELMkjx5LFcc7wvATwA1+2u1DbHpsij56XG1apFtI8EHhSirU6xh2EFroIWC
         l3KA==
X-Gm-Message-State: APjAAAXoBo9oHHP5Sj4yCZV6sJNRTcdLMAg0qriwd6rttkfpTuwhJzQo
        3StwRKqKHHn0GWtYPuZLS7sraXHm
X-Google-Smtp-Source: APXvYqxXeVtVSsnO1GdAAu93HJPQ4w3XCXggNZOp1EISBhZrMsbEdGM/vRdluf6hvXOgJDuKNnBBAg==
X-Received: by 2002:aa7:87c6:: with SMTP id i6mr25372342pfo.208.1552170921923;
        Sat, 09 Mar 2019 14:35:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y6sm2482625pfy.87.2019.03.09.14.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 14:35:20 -0800 (PST)
Subject: Re: [PATCH 4.19 00/68] 4.19.28-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190308124910.696595153@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <59276a52-4dae-1130-3009-8d214d7c03c0@roeck-us.net>
Date:   Sat, 9 Mar 2019 14:35:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/19 4:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.28 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 10 12:48:45 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter


