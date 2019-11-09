Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD27C17443
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 15:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EC0207FA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 15:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRB0cn75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfKIPi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 10:38:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45506 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfKIPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 10:38:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id z4so7142207pfn.12;
        Sat, 09 Nov 2019 07:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FQ5eeGvwI3sIqEB8UmrJ6un2HC5Aw8iwaA7cX7uk578=;
        b=TRB0cn75PSv1FwpIbMxI8ZRU4dNw+zKaWipeX9fVNnI1fAZXU9LJVXhWMEIZWvG96p
         BjX5nOgfyPVwvZCLKGbSqjVp5wG7+dQpgcsMVlbpjX8DPi8aE+bRn73rWOnOXB+q32PN
         puDSdVJHpa0axLdJSL13xTl2z+FBuGyyt2Sx2iXIH2S/5I4q3ha3hwyXmS0zN0ty2gjX
         q5XvnkTbTtykPf1kwPg67BUYQB8J4sqIwb8RzGi0ioYO7iA9RwijO1JgYRjahxegX+53
         2jS+Hmi3C/sA3z8J/pvY5B5z5P4Sh00eeUjG7VhoPXQYz6hBZXyPlsgnQrFCSxXGlR4+
         NyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FQ5eeGvwI3sIqEB8UmrJ6un2HC5Aw8iwaA7cX7uk578=;
        b=EUct+t0l7wiD4IUrzOBzqcpYV66GcPwiBpb93j7f7y5akTW6B1bMAi9ntz/+JyeV14
         tVlC1+V7KJ/IO5rz7W4NU8ricS2509ruwgnUUHwcOOSKic0TuJISkLAlqN8Wq+UKueFU
         KEhok1FQSsZsXsnBZ38vKZWLQ3w2Q4KW/4LOG8ynO4X1qwVc1QZDsjiwkQoq154UL28w
         /mqBQeslxv15R3BRQ3bxPtC3xcgPQBT2lkTC+VVX3tqcbjx3gXpdQISX0Cp4C/EbraLN
         PGL5ApN6XU2Rfi7zwbNS7QT1j1roWv9Z5FxNlsmD0ow2M4Yxdwc24cv56VJqBGEj1oJh
         oU7w==
X-Gm-Message-State: APjAAAWUgPjZjewmyYh0ioCHSn58vQ8SD3soMniH4rrSpL8F7PpNC2pt
        2aM1hJ9nFKC6vg2CA3+SXE2poM+p
X-Google-Smtp-Source: APXvYqwUQvwUhtbqqh/7EekJ96l7J663jESRNYC7KyNbYJ9kfQhNmQd4Tp9RbjqGfh8aEAt2zHuXSQ==
X-Received: by 2002:a17:90a:2947:: with SMTP id x7mr21804664pjf.136.1573313934938;
        Sat, 09 Nov 2019 07:38:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 27sm9676556pgx.23.2019.11.09.07.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 07:38:54 -0800 (PST)
Subject: Re: [PATCH 4.4 00/75] 4.4.200-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20191108174708.135680837@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <468e12a8-eabd-9d0d-ee2a-842743f22e95@roeck-us.net>
Date:   Sat, 9 Nov 2019 07:38:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/19 10:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.200 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 10 Nov 2019 05:42:11 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 170 pass: 170 fail: 0
Qemu test results:
	total: 324 pass: 324 fail: 0

Guenter
