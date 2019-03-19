Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0958C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837C020828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd3Kw46B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfCSC0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:26:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41054 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCSC0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:26:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so12590555pfn.8;
        Mon, 18 Mar 2019 19:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nUvGuBUrIYNCUG7fIUGHGEFTD2N4vazFKLjvRT7zGD4=;
        b=Bd3Kw46BfC6Es3bnow79gumiq/4IOidvxjL5dqesYWuGW8wh3eu2a3g6PDN/2lADjZ
         n8CkovXyD9TXzfmpyAbYbvI7Idcc+4yr//y32oE9Eu+kNIjE1+CCQbBX7SIScCoEGBuI
         Txxc2LdpgozaL3QjVuwaNYp9Ihszr/ScQvQ4tvtDLV4LhHDM3Xif6oFgpTLd/WMTf3UJ
         Iea/hULEZuNs/IfdCx3LzZrCLs4QrDqV0kWbPg/EnkFmUZworbkdJ9GEGxx+EqdXCkKi
         /+WhRu1ak1Sn6tEhQWC49546bts5KZzWE0DH0oqUTkrhHLaK2hXLTZ+dWoDVL4atayKx
         RjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nUvGuBUrIYNCUG7fIUGHGEFTD2N4vazFKLjvRT7zGD4=;
        b=o8xmPcVFiJYWY+fxF2HnLap168ZtSE3CEgnUxTGXv/cpw6K2/QK5tZyGxR3LfCtowK
         JN/Ehfkyov4HxlQbSjyPpiauSXrl3orB1IMSwoJJgOsUDwhSZHuHcr/Z2IQFCiq3loIW
         cvQ0Y5FVtvW2K1JeX8DvcTjyw57qoNwQeIoX+QMO6OHM1YDV0X3uxb+X58KdqTHkDF1h
         pT8s7vsY+V/N5PMpFUR6tkeFptIbr6yFNGQqDmcCDrlhQ45qkJLK3XVV69MzD2iJgBuR
         iyU+KmV4MjSNHQLAbMeLvgez212ABoyCtPRdon0wiHrOn7rWhrcwHd/Vs5N6og5h7S9o
         4pPQ==
X-Gm-Message-State: APjAAAXH7dCHVp+hDJLLwyJSgXC6SF9bHwRsmx0c6kdvLNNwXQrZ7nnM
        66KHmluhQWJFTdo3O/anF93i/WVe
X-Google-Smtp-Source: APXvYqzIEav1YLJ3b0z6Q4OX7IhkzsbBXu8lN+BkHTPZen+DgWcA7eC2TppvABaCn2vGHv3hkWWEQQ==
X-Received: by 2002:a62:1212:: with SMTP id a18mr22091801pfj.177.1552962414240;
        Mon, 18 Mar 2019 19:26:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o76sm30043033pfa.156.2019.03.18.19.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:26:53 -0700 (PDT)
Subject: Re: [PATCH 5.0 00/43] 5.0.3-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190318083715.877441740@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e658f53a-a751-473f-e8c3-b60531f02470@roeck-us.net>
Date:   Mon, 18 Mar 2019 19:26:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 2:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.3 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 20 08:36:53 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter
