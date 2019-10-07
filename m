Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DE0C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC55020684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pF/ZsIKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfJGOd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:33:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32828 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfJGOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:33:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id i76so1178999pgc.0;
        Mon, 07 Oct 2019 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vgkfuDOHZBQgZuKFercCCu0wiKIxFanlyd00oLyvMvM=;
        b=pF/ZsIKCD8HlMzrr23xeqTLPzdvtKCYji/HAPtta0Yi6KW2ChioIEADwFGgpk3cL2/
         bwOsASpK5R+dtoUZoE6IRLXmIGvZJI00e07xbyAa8bB090MOkcOHjjbHzj/5670kvv4L
         A7z2YVxnllI6Apr61r28cygDdm61c1HxE/E9fxT3K8xz9z3Rt2TnEe1YXF0Y4/VRK+c9
         7a4WETwD0GA20Yztdy6sJF1S1KPBEwmJSrfYdVYlEUmqa6Z+owx2iud1O5X8qJ79G2GW
         WxgzmyCyKPP3D6Nd9V4Ok7ILtP8sV4d/Bi2HVYcY0lT6Bmn5RMSFdfUM/Tx9Fb4Y2Bw8
         WRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vgkfuDOHZBQgZuKFercCCu0wiKIxFanlyd00oLyvMvM=;
        b=VCsuRwfe6DSB/eFWZj0BM9APyZ65J76LXBLBpS5pcB0zkDX3Etj7OswFjZU47v5z2x
         ELvzKyXHFDtppvRM6Hg2hqLDzgs5s0eNOjUOEebY5tOx49IAINPfcxTb94rcmd6yFO6A
         8tYE8En8kT4BOdexNULm1WZe8iwEIWbaJ/hLZC1MILxpAathTE9MAMBLhDISEA0+P/fL
         w5hIlSfVKA4quQeOr5R0qN/on8A/Fs8+QO7o11r6ezvCkUuTDwmQ4fRQYs+IzKXa3GjN
         jKRJ+Pz6nNUq9SBVUwfCxO/JdJlp2oSPAojNysDpTwxsPagC4lrwroPLK5KgRxQm+F0+
         FKPg==
X-Gm-Message-State: APjAAAVTEMEMGDgFUKPLxhgZSIUCCwKyF1oClW3irkGBqpCJag+0mPNB
        3Nu5oq6cUyaoH0WOgXKzy/4Bo1EV
X-Google-Smtp-Source: APXvYqwEJYxwloVh+NwNmuMKM7pGr4DLSQcQ5LDAFiFp6/5etwTOqAi3+Ay0jH+PqeYn+PVb4OEoCg==
X-Received: by 2002:a17:90a:8991:: with SMTP id v17mr32598122pjn.127.1570458807387;
        Mon, 07 Oct 2019 07:33:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l192sm22148953pga.92.2019.10.07.07.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:33:26 -0700 (PDT)
Subject: Re: [PATCH 5.2 000/137] 5.2.20-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20191006171209.403038733@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <82db8361-c3ab-b48f-ecfb-eda9b6b0d726@roeck-us.net>
Date:   Mon, 7 Oct 2019 07:33:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/19 10:19 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.2.20 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue 08 Oct 2019 05:07:10 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 390 pass: 390 fail: 0

Guenter
