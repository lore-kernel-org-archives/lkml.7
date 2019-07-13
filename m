Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99438C73C66
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 22:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E88C205ED
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 22:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEwi2gve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfGMWF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 18:05:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46963 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfGMWF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 18:05:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id c73so5767275pfb.13;
        Sat, 13 Jul 2019 15:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2XHXJs3Yhdj2wU76oTVjXWWz7A60qFZCANW4DQ2QTLA=;
        b=MEwi2gve6wJfiOPe8zP9KXwUYlo2OpXD1qqrJ2zEMtdsuL1x9dPGEy3zYwUGv+2jGI
         Lkusr2EFwxnZ8C/o5mMK4PXgM1kW04OOcQgzW0WNX+VHCiyy32nr53IspEYOv+JaVkGK
         iNvBJpBgm5LhnSum7sg6LYeKXvVYduoL8L0RXYzWTfN22qIw+cFOmanvtmtazVkoqvPH
         CyO+iPBu8DMuCjIHAnNYc1RD5zndfBRSJfc3ljSA+bfplVg1DUJfK8Nt7PK3X48Rpqb1
         ZWRHr8po7IsWO4yyfuX5KJQPXcXJsznFz6a0Yst8Ea3lbgegxCbDXtTfz++6SCIQqlKc
         gAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2XHXJs3Yhdj2wU76oTVjXWWz7A60qFZCANW4DQ2QTLA=;
        b=gN5rerWMchIELnqjq0cAVKsI4Anzmd7NTn22kqHdJZvTvPeFMzSEIW7ZhtjoMBL2HX
         UF92Y9jo3vNqp7SrtHfa2AI5DhQdeiapDNHihGO6Soe3nz5C3viOQJpgBnaEIfwdqE1K
         lNj2WQ9rgb5j48wNHzwqhnMAX1iWfE4ohoRCDL+HxhjoA+8Ln5Bn7Tz5orUYGXfGeQOO
         WUts0ITzj1fbIA/KmfqeYDuSMRbzfHiThGztU1pD7srmNJQ8gg5d2XAViLhNkbIpJsCZ
         9UeDhYoo454F08xiLNwbKzu/64fClzvyhTf1vNZzRCAdzIql3IJXMUt4oLoYCnpHOI3Z
         tlnA==
X-Gm-Message-State: APjAAAWZgRUJAWsg5G1xHiesJbVJq6K2WurbwBT3cCJ7PD0VNLcjGrYo
        g8Ab6X+J8o7np+rOYWqNSg5Zio7S
X-Google-Smtp-Source: APXvYqzgOwB3IVktNUX68S26iYKnyMVooiX3ll3BE/HbbMERyFXC28rzAqeyGGzQK9aMsTJI5/hcVw==
X-Received: by 2002:a17:90a:5884:: with SMTP id j4mr21197797pji.142.1563055526531;
        Sat, 13 Jul 2019 15:05:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2sm14754824pfn.29.2019.07.13.15.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 15:05:26 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/91] 4.19.59-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190712121621.422224300@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3435ef0f-18ab-baf7-0ae3-9c11c25176ef@roeck-us.net>
Date:   Sat, 13 Jul 2019 15:05:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/19 5:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.59 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 14 Jul 2019 12:14:36 PM UTC.
> Anything received after that time might be too late.
> 

For v4.19.58-91-g778a2640e781:

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 364 pass: 364 fail: 0

Guenter
