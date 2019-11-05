Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CB5C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4600214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRPcQQwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389539AbfKEOYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:24:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40778 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfKEOYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:24:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id r4so15535931pfl.7;
        Tue, 05 Nov 2019 06:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dl0qLGW/VIR1GtY/tOk1rveOHOlvI/+YmxpD9AGHMU0=;
        b=sRPcQQwRZT5Od6MI4ugEdIv4wPqYyVlbZEe0YGKs5KGj+A30jeKz419NprZ6d3RhUk
         q+bITv1zXCtTnkMHOVTbvHuE5rJpDXFgNlAycB4xmUpT179uo1+Zm5TaDJE6eVVfi/If
         tCa2Vfh4YyQJO1jZ/hFWUwyMzNHQGo/9wMerEbB59maBVQ8wLn1KaVrI3l/9VMUqLIkk
         9FMDcAfTopoAHrCLt1pkayjbMFIRYPnli1w8ujrzIh+urlh5ljA6+U9c7S+4x2mCmR78
         h4/VMcFy+Qwq6KnWf5H+2P233vLX26FFP8GFiuQqF2FySvfmDK/NIMJB1wwsDKLJol5t
         4a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dl0qLGW/VIR1GtY/tOk1rveOHOlvI/+YmxpD9AGHMU0=;
        b=hY7hxhInqgqeMt3QnIa0nINIcX1q5+fuktscyfy99OmYThk5oCs6u05qtAOhsnlimM
         H3nhywa9J61belqczxvezaVvc80ybQdj3HHZl81isZurz0VHqCCMU6TZygRgNf5VP7YB
         wz3Anv5nhHrvrDt4pkbxAHSqKFnggH/5fwbI374y650b+Muwt+QMx7qDrwBhpi4dT8tg
         lwIjr/AWDM33DbH93lFYWLWe3FwWaxBaA00IvxPUQOkVmEkAcb+CwjeXvvlh/tdQRzBt
         cTi3E8j7/F51ePy6+N1DsgFKWKozFliY4ktVKamtmp0V2doedDtlsR9NU6mtNcdMjOys
         25tA==
X-Gm-Message-State: APjAAAUcgmcM5Z2qc2a2ZID+HOKhmOK/ATBUXvajETDw5qzUtTnm/hzQ
        gbySG9MOozU/Gis2rla9aU7f6BJH
X-Google-Smtp-Source: APXvYqwvvWgK1D+7pSS2Wg6HdO3HcT4T1IEcu5zWB37K+qFKfZR/Hf4fQ7vpC2MvBf2ANzObCPrOlw==
X-Received: by 2002:a62:1693:: with SMTP id 141mr7078605pfw.146.1572963870211;
        Tue, 05 Nov 2019 06:24:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d4sm21002397pjs.9.2019.11.05.06.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 06:24:29 -0800 (PST)
Subject: Re: [PATCH 4.9 00/62] 4.9.199-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20191104211901.387893698@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0618c4dd-cd16-a45b-0985-3c5f747b63ab@roeck-us.net>
Date:   Tue, 5 Nov 2019 06:24:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104211901.387893698@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/19 1:44 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.199 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 06 Nov 2019 09:14:04 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 356 pass: 356 fail: 0

Guenter
