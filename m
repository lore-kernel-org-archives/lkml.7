Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A0CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6378B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkiYGAvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfDPNMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:12:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37996 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfDPNMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:12:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so10327188pgl.5;
        Tue, 16 Apr 2019 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IRRRdCJvUfQO42fbWalJ527OXsT9rWyVvHgcaJXy4Uw=;
        b=HkiYGAvX/TMTWxrYjkngKojO4SEKOHRAjpA5zkTIQCEWb2XFzYtxgdaKh2HneY0qQx
         UW9IX0byeLiV4aWIXmC7RVuRB0OUWsaOOLVF5Chz2vxeTajVWgyhh4Kp1D9FuyzH2VNk
         6RAEa/SDUY02nSM9KRLL4V5VjYAI5posC+7ClEFFJCkICza6y9JkOMUPxrkyXtPUUZ4e
         k3XlysnPqmemXqueJdKLP8aVt+Wg9UtHTnCOc4mh18De28mAcjQVq0IGBLimDC7ZBG7J
         6d5MahuuzI5EcMI3vSP9Ho0a7gVWm74SbTgFsVJr4IvF7aJ+fOcfGAuq4wiwzT/IUDi1
         CSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IRRRdCJvUfQO42fbWalJ527OXsT9rWyVvHgcaJXy4Uw=;
        b=RDD/96gH/R9I/fNlGP+4mk6NGWPMUP+pIOwKoQ5Kr3CwyUFxaaTJALR6gF4ZCgqiUR
         aUJNieWlsjmEfef5DqxURvFnRc8sdGURljQfO2jqXFx6aMX7sDzqKirurUkq/mVoVr2q
         BdsqP1E/2Mj0gYUHmLZbvDR3oKQ92/bpOJs0TRxdKaJPJKytgwJoCORolECu/VZtZCuq
         sbNye+ASl2zk2/EtEGbXK3DMPL/xHALfqIAKcnajGPicDUH0JcXiNQQVR5I0dd67TmGC
         YlAn80OivIhHwr9zk85i07Ks37fM6NFTFp3+Dr0mCG6vbuGZl/RR0UK4ds8Hzte9dfSI
         t7uA==
X-Gm-Message-State: APjAAAWcihAy9vSJrz5YTn5VQEH+r4rU9bK552OOE6CM9HlecSkpSOQM
        QJwWdLLJz7+21qpJsSF7H6lanSkS
X-Google-Smtp-Source: APXvYqwI+bHbN/n/+j/sw03Cxn5CLCg+ueiIkvSR1BqPsmP+8EB7LExpJb4VehHEhT2Z1kD30UhgQQ==
X-Received: by 2002:a63:78b:: with SMTP id 133mr43804637pgh.307.1555420360223;
        Tue, 16 Apr 2019 06:12:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w1sm49525890pfw.101.2019.04.16.06.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 06:12:39 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/76] 4.9.169-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190415183707.712011689@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a8d1657b-065b-c81a-743b-d73c683a46cd@roeck-us.net>
Date:   Tue, 16 Apr 2019 06:12:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 11:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.169 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr 17 18:36:37 UTC 2019.
> Anything received after that time might be too late.
> 

Building parisc:defconfig ... failed
--------------
Error log:
arch/parisc/kernel/setup.c: In function 'start_parisc':
arch/parisc/kernel/setup.c:407:2: error: 'running_on_qemu' undeclared

This affects all parisc builds.

Final results follow later.

Guenter

