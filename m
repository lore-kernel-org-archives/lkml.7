Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8116AC7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6565D2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a71Vrcg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbfG0QHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 12:07:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37484 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387419AbfG0QHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 12:07:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so25889351plr.4;
        Sat, 27 Jul 2019 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gXNnk/xw2Aad/62mfKk4ZqheZHbWzvRThNuzFviWxvA=;
        b=a71Vrcg0QJ5wEZNVc8PhgJfATGXUXcuXlG7CVRSbDf8f3anG/15ddoqgwWNdboHTiU
         KvXPljW65ULc0T+xsvdilR2FxwjgcncZvdSt/7oDjr7+p1fzi1l3ZXeok2wC87Mymmoh
         ECbH1CV0zyJpSRVOxSdtaDqIKsqPcK2hdBqPfjEm8RzFnBXxr5wGFQgqLFocXSi/NcRp
         8P34h8t+I5jhjqWstVGDTKNXWbfVFcFLmbI7wfEhDFDQZeOr6DhiYRxA0QuhHQ7g72tR
         c8daQbpkAStR6i5GCUWMlrZJciNfwPhxbjHYGUuvyYUgiUShluOX88+9DmwnfsevS2FX
         QMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gXNnk/xw2Aad/62mfKk4ZqheZHbWzvRThNuzFviWxvA=;
        b=OK8Qpllpx6F22rfIGaaVPb2NIpIl3MPAXdGsAKhc8Xx9XK+50Ilq6vH0ZaZQJEKVP5
         ABYky4ZI2ljfkUeQ7kaw/BJSzZBaVMIegWPTtT1lJ7JQbI+a3CSpLQqOEYr4nRaQ953H
         1pcwfVpj6UWXyhJRNLl4BGz6ukVKIm3RnWeN9q/xS/tEtnvdsf1IC09P1+xMd8n+ApN8
         fQ0DNQGr7SiW54zHUVes0Cm7owHJnbZW0INQ3n9fjSsS6eMIBAAgp+rvOhOxelXqhKIs
         6KG7XsX5AJyCdhqwuNubgbSkIpmTeAW733aZolcTeYLqTk+KjN3GOZysk6i3on0PgSLf
         p3yg==
X-Gm-Message-State: APjAAAXKd41L/Ky/hdyMu/3u0jcx3C1lI8vdgBbPgaDlHYHwY2fIzGEV
        r4OIxABHLT2mFIDG7Aj4Uds3Gmds
X-Google-Smtp-Source: APXvYqw+ccOaaEzCScVeLszbUaf+PZm3VOU4vwAj12EE4EMQIT0bJ7WV02IloyEBfsI3g8Juae1P/A==
X-Received: by 2002:a17:902:20ec:: with SMTP id v41mr96277738plg.142.1564243649361;
        Sat, 27 Jul 2019 09:07:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m20sm58657342pff.79.2019.07.27.09.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 09:07:28 -0700 (PDT)
Subject: Re: [PATCH 5.1 00/62] 5.1.21-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190726152301.720139286@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ad4512b8-889e-e4ba-a1bd-df6f8ad2be24@roeck-us.net>
Date:   Sat, 27 Jul 2019 09:07:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 8:24 AM, Greg Kroah-Hartman wrote:
> Note, this will be the LAST 5.1.y kernel release.  Everyone should move
> to the 5.2.y series at this point in time.
> 
> This is the start of the stable review cycle for the 5.1.21 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 28 Jul 2019 03:21:13 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 364 pass: 364 fail: 0

Guenter
