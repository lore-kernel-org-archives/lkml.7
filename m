Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7B0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC60421900
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qN7z7n3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfCWEpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:45:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45201 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfCWEpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:45:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so1982756pfi.12;
        Fri, 22 Mar 2019 21:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HORkIJTsZrrnhQwa8A9amghPSQfX5EIafqJvOVg7cts=;
        b=qN7z7n3Oo4GQnSRGzxog7BiS6YATQypSmToxk0ZUjb2PV6XGjREqXiBXCIiJGhDHfy
         7NiLYgTP68SFH1StI92dEsuYra2FoRflfRDoP9MQg9ZBsKhzoqXSvMLAZScpXMUAVNlE
         lZ7fJEqCgi8OJBnE8wo82QsSpsIsJf1G7bf3Jbap2a031OaaboTZINibDbQcmUfEaYGP
         9aiDysXXOkBaew+DTwy5l9Z+5zkQcxrb3J0GFEsHKmBfnxGoXrPNCKp6eIvBtRxp5JVY
         XzS8BCTvca0scHOc1nIlx3XbuVzzjBdrv7WoffpMooXZ9Kq0n98acLuN5Zb5BFr57iEm
         m/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HORkIJTsZrrnhQwa8A9amghPSQfX5EIafqJvOVg7cts=;
        b=HncrFfjnkIeB4/twDYGWFGfrh4FdHKPJAPKX4x8+LbArmbd6IMuaNzaR+60zslXuH6
         1t6dtzS+1/iXv672oj+g9EvKfaegu8aZPyvWHQ0LyWcOsDC6JvETwtXUfC9vFeQEaizU
         dXnAZ9v+hRr1/sRz3kXD6XuhmyZRgrG7qxjHOtR1+zgIyByPlwa0cTwOsGBPxzKMs/7P
         koZJaoDorS6eh/DMfqbh7DmF4xTCw/L4z3uAnKY/dWh+ai/x1TNw9+SBuRqjw+wPPI9W
         VefDvCUjG+1d1JxLjwQmQLPsC+1opswHkjxeUBJjjxip97dy3V0G3EgOhZxpZ5WyKcJL
         CcCQ==
X-Gm-Message-State: APjAAAVX6Zn/MkipoBq/UHMq8LM1wq5TvMyg4qw2x3mG5Chjo4EMbQbr
        m5SlgwaMToVO+ngya89LF44Xnqk5
X-Google-Smtp-Source: APXvYqzcCANdGmV7ubBjjStOwWiwDvSb21vJIAjvMrzmhl89/8mrzY+2YwV1Kylfw3jdcDMsUiqBGQ==
X-Received: by 2002:a63:104e:: with SMTP id 14mr12338085pgq.185.1553316331087;
        Fri, 22 Mar 2019 21:45:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h64sm10325499pge.7.2019.03.22.21.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 21:45:30 -0700 (PDT)
Subject: Re: [PATCH 4.14 000/183] 4.14.108-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190322111241.819468003@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3ba95b01-8124-c8d7-4f09-ba492d6db9d2@roeck-us.net>
Date:   Fri, 22 Mar 2019 21:45:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 4:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.108 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 24 11:11:06 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 329 pass: 329 fail: 0

Guenter
