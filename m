Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79FAC433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 15:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB83720679
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 15:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPO5sZEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbfHCP5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 11:57:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40999 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387466AbfHCP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 11:57:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so34665357pls.8;
        Sat, 03 Aug 2019 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d3CIwQoEGF2oy028jCq+T7aVF4EpZFXK+yKOGjklAts=;
        b=oPO5sZElAKvY3IW807H3ReUFHazzLaV7AzEn/SZonflvFuU7yZuaLk584NCNGoP+xj
         T5IaYLfIJHaUjtjfvyjixBRMCzFYsOj3BwBiP4q500NDkjyVvLhoC2knjR60mX2K5cEI
         umEuqJTFwURM6gwKqx/GeuiIUCQhHWbR1jVie6FEsvBFDigmJ1AtqavkOxqxhy6SAgra
         FkrxIzAlxTq1cZxZjJHNy8KepoMcAdGBF7tmxb4Gmcv6PhnROAoadPO56KGzNdPqPUiM
         EVeGmBR+HZeSGttmUwkAhtuoKBwTpQKSKbZKfBmCPm6u5oRp5sCuRQzFhjRPJU9BZzFH
         Tueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d3CIwQoEGF2oy028jCq+T7aVF4EpZFXK+yKOGjklAts=;
        b=Pp6iOXIQ7rbFjvrm1LWsaP6z41TfaXSL2EixvbSXsujLgYAtVSZPuZ/x8ewMg5MDJ8
         IgjFQrJDU4+pL132UaCv9DIbNBJk8Bf31se60JOgi6U95Uwabwq+VXhN20H7B0zOkVv0
         E4LyHCr5AFQXC2UJzKsWDMC6xJ/AznRkyExZtPKy7t8KkKpBbB/GPdxxKB4PKZTw0N7c
         8WcSEYb3ld/+fXZFyDHwxegviXbS8P3I7Ljp8VBQ56M/5MdPhjT3jIULO4hC6J2P33tR
         UrKWmLoPSfbgnOj73IZ+WDB3bnxibBmRpRt6ivPqJk4uuLBGNiuDjM5SzKxZyrBLYMhi
         H8Ww==
X-Gm-Message-State: APjAAAWvURk6bCjdXL+R3uzljU8ACsh9GolOvpKGoYmUEs+lT0kU9ocN
        9iUUlYzYXfLQUlepJgkph9SHyQqA
X-Google-Smtp-Source: APXvYqxY3fTDa4KjedTpyPAHllG6/Tk3LTfemR3dPrsTNplxnsjledCJeAN0xxclmQrsdbBk+yrnQg==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr62828564pld.41.1564847854394;
        Sat, 03 Aug 2019 08:57:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b37sm23918951pjc.15.2019.08.03.08.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 08:57:32 -0700 (PDT)
Subject: Re: [PATCH 4.4 000/158] 4.4.187-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190802092203.671944552@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9df0fc26-594c-ae36-edf5-4fb41bc57fd1@roeck-us.net>
Date:   Sat, 3 Aug 2019 08:57:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/19 2:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.187 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 04 Aug 2019 09:19:34 AM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 170 pass: 170 fail: 0
Qemu test results:
	total: 301 pass: 301 fail: 0

Guenter
