Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E087C00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D450A20684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eypr8Yyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfCEDjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:39:12 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:40282 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfCEDjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:39:12 -0500
Received: by mail-pf1-f178.google.com with SMTP id h1so4570919pfo.7;
        Mon, 04 Mar 2019 19:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kiibamiFStXvQbCyjEVshUgPd8wyR4QjR43EloilzBg=;
        b=Eypr8Yyp6LUI/o3fc++wZ7lWE/OxZzvASNY4TeAv8lql+6pVPB2HVDVa/zWB5uvyNG
         LGwG4dBWp6XLBHRVvzxTnlfD5NCLiRwuTAG3E14IsuiqVgjpyygdd5tFBWb2VbhuOTl3
         vzo8Zyc0lOZlkaIxcQKD4lZHxOmkYx5czMihdZd54eTbQBlfOKf0y547Wn3sSNjlxaix
         zwpY1wwH98BBPIlEqP+rE8Z/Lq9XbJtX4nCyZFUZEG5XgwTIKZgdVn/AODySbpZ9pDz/
         umEhkhtdhh5HfPzwg477SX8/jCfad9Uuf3SnEvQ328ARqJFV0mWjhQo4FHNS8qVRsKzY
         H7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kiibamiFStXvQbCyjEVshUgPd8wyR4QjR43EloilzBg=;
        b=Fb1vcD0XgJFsVtI5qHQie3qATg744AAH2wzZ9ALKrcTWJHHkqMGxhQBGI6cPeBYUvK
         4YxCHiK7DK6sglK2K8o1uTUCc35vJjLDXaT4WFl71elKEmTuLEAv6VamnA/RI5eU4lGu
         Py28j9lu3Rkd885C1R6gD2hGxfYVKABrnqzB/v95HjiYSVSZmlrCAVN9438iJcoNmfQF
         pY/Cm8rqylopafvVbjCk1ndxdz+zvZTT2tqh/U6vm5HHQ8/IlyfUwP9n66R65/B7kfxa
         Um4MRvxwudpbx+j5QqqD7pwfZQ0TaNWYXaJ76qX8COWrEUBj8ltuvCu9/0iuYon8poT0
         4FKA==
X-Gm-Message-State: APjAAAXTXUBhdhT3y6r6E+3DenE27A5hQwVxPkcS+0Jo+d7rYmBesXSK
        8RMDdqoJhNYyGHy6dJKz+ZSw3Rq6
X-Google-Smtp-Source: APXvYqxwJSzML+8ApwhoefhdubWxndziFhka3k4QNYvbX/p5muGtnUMQyqqn3Ad6+/paxLcaD6nHDA==
X-Received: by 2002:a63:83:: with SMTP id 125mr21884106pga.403.1551757150952;
        Mon, 04 Mar 2019 19:39:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h65sm10452581pgc.93.2019.03.04.19.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 19:39:10 -0800 (PST)
Subject: Re: [PATCH 4.19 00/78] 4.19.27-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190304081625.508788074@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <961840ab-3de7-ec37-c955-dee80bb6adc2@roeck-us.net>
Date:   Mon, 4 Mar 2019 19:39:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 12:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.27 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  6 08:16:00 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
