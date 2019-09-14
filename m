Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7401C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 13:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D9F206A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 13:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDjqgYAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388939AbfINNzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 09:55:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35161 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388709AbfINNzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 09:55:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so19820843pfw.2;
        Sat, 14 Sep 2019 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=40wc6FA0lMj+YfYkps9Vn71QTo0POuXDZoYm8VJiTpU=;
        b=cDjqgYABnbivJRMn0kZm2EHQ++G5yrio8xWIJoo+vuiMucBafli08Ow58yBaxZOlqT
         V6z6ibcfoGpnnE6yz1Al6GuLlMHZkG1cU7PhNIULCyZgKoiTpT2XJQurMOeJgWtFNj+2
         D+d4gW+4mbEk/rYu3bQ2ZefTfH8ARyIEVwulDBJf5clN98qddoL1s16IfhYJ05ez2ic8
         jnscbcUY/2xso/tO8kpmBvjvQa78XI+kVe0TS38SQXF4tRY57F8+GjCKgLsHvBylgsXV
         5i5GiT7WVnZbK5naJpYOwBf+R1alWlHx+F2q4C6Q1xBXz4rmWXzvV6Oxq16Xz72Rqvll
         WydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=40wc6FA0lMj+YfYkps9Vn71QTo0POuXDZoYm8VJiTpU=;
        b=Hn4yhsE6Rl/aB8eM6vqaD7TnjC3X7LblwRKP2RlbcEtwI0MGC+6Nu9b1oNPQuVgdAW
         h3EeC0TbM9sKWm0jLF+5TcqS9aWOq5DVSM+Uk2IQHTxMgzp+k8bHat5KcRS0u8McwCND
         CA6vBSJPbF9nYkjRSacgZSoxyjXLPEMbc+7DrmBj4lv0IQF5RDToFbWTzp5wnP2v/j/I
         P7qY8nlqNwh72MHp07nmCV80L4MTA0JWB5GIIfuBb5uPviFb0dMd8A/MPQoLfwF0vizy
         lBib3POxJoucHSp7ekdYfFCP40GePmvxzxOPXtsjw39S36YjL0hYBy0FXp+ijZHB1aWh
         XMAw==
X-Gm-Message-State: APjAAAW83pWytPlfKqO44Uyn8wkJmjZWvvjkkPDF5eJ4V6dDhE7jRp5k
        QhNvRwIWdQKaOaGbC3ojRwss5Rm5
X-Google-Smtp-Source: APXvYqxS+Ubct8ROhOLdx8mBtIYFTCkMb7WgfIQEUK7HvpetRkuGvbcayziYK45mIvmbWnvQsSV7JQ==
X-Received: by 2002:a63:7d49:: with SMTP id m9mr49808816pgn.161.1568469337472;
        Sat, 14 Sep 2019 06:55:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j128sm41529625pfg.51.2019.09.14.06.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2019 06:55:36 -0700 (PDT)
Subject: Re: [PATCH 4.4 0/9] 4.4.193-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190913130424.160808669@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <32171a50-9fa8-5233-3a34-4f1e751b54a9@roeck-us.net>
Date:   Sat, 14 Sep 2019 06:55:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913130424.160808669@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/19 6:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.193 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 15 Sep 2019 01:03:32 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 170 pass: 170 fail: 0
Qemu test results:
	total: 324 pass: 324 fail: 0

Guenter
