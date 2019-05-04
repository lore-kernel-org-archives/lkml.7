Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE33C04AAA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 23:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BB2206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 23:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSINm1To"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfEDXxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 19:53:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42177 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfEDXxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 19:53:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so4562512pgh.9;
        Sat, 04 May 2019 16:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kemZpvUefIOM14uV1JCHbSfQaGg4rWzYM3YSYcLMH3w=;
        b=ZSINm1Toe++eVc7XWNGbtQWckFfDRSE6KUkuhl6PWwy3qxEpd0bgYo0mPjLurl6fBg
         S4hDCL1/3ueisqKjHzTZJNJ0w/cR4rbBAZcbyjpGdYjgijmz1f17BSuk5IcPaXj7RyQG
         RHzeyi9w0gUqIwUKuHSei3ql6c8fmVu3f86/O6E8qTsVndnKfXCoIP4puN43s81RIknf
         +tlX18ZkAfQDCL661BXfGuugbw8OkUXe9MN1337/HsUdZWsrUSFaWME/7m53k/KH3kZW
         bI1mEIqxRJlDmflMDotW0LA6vP69AoIRZ5Sv+qa0eU5zxdDGe/9nsyXcBa4DuleuP4i2
         udHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kemZpvUefIOM14uV1JCHbSfQaGg4rWzYM3YSYcLMH3w=;
        b=pzDhAuWUgYDdB6rblgeMKBi2eVbtiDSfA0Vd8RH1NeFZYMZrYQzxDWItA56ZjDBFI6
         npexnT6STbWrWuGAzem2IU8ZODvmbOsHPgRI2n2veWxwa+1GYv8HAywuLBApW5F1T55b
         s4aw0U4bQwsnjbWBS1di/z2OwI/En4vnUzEwvjOASI4oUUaprM5d7qHVFpLX+u+LsXRa
         j75XKExA/MckRuyk5qAHVNxQRXBLCIKcOWg7aPckPSdFp1KOcJZRbNIlGfW74L+E5SdW
         sloDpfqYERlww1FeECS/KLX4KPfyg4EBxu9AF+dlp6xGym6ALjWsif+BhltOYYsYLX7Q
         3Ngw==
X-Gm-Message-State: APjAAAWCjZqxpIyyXVN2IkO5hz/HnMXAMjMq3vbGLZjRK9JHy67rB+81
        43lfSZXawJjvXgqKagtu1Dbn7s7P
X-Google-Smtp-Source: APXvYqzR79sPkHveX8uQOrbyIJFq45PTQ231RD1YlbwXsO/qG3j/83oQ4In+MBRw0u5vMrxoO0jm9g==
X-Received: by 2002:aa7:93ba:: with SMTP id x26mr4019206pff.238.1557013992736;
        Sat, 04 May 2019 16:53:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a10sm7641816pfc.21.2019.05.04.16.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 16:53:11 -0700 (PDT)
Subject: Re: [PATCH 5.0 00/32] 5.0.13-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190504102452.523724210@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7e81d963-68b5-40ba-6e49-4fdee5e2bb61@roeck-us.net>
Date:   Sat, 4 May 2019 16:53:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504102452.523724210@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/19 3:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.13 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon 06 May 2019 10:24:23 AM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 349 pass: 349 fail: 0

Guenter
