Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D6AC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E501218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itefp3mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfCWEmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:42:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34484 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfCWEmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:42:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so1460607pfd.1;
        Fri, 22 Mar 2019 21:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nG+4wChODW9kuqTztU7mIoSbSX1bfLh8m+Yw3JRdgLs=;
        b=itefp3mjKKN7zzcfLXMVvCyoIk7mbCR7q1cWsKTbgylhJhXRScfaiHEl4AqjZSXxCY
         cxHEzQNka7AO1/aejlJfwUY8yyQm66db+yyQQRI9KRYmM44ccqoerISRZCMRavwdXnNt
         0451MlB4Anzxqqph3g3Qg9DhNP5T3nrdQI/DZ9Nkfq+GY+Rddg15W+LAUD4AXpRUeb3U
         uiWf6a/ubeGEpEpO7kYLebkgW50PBY2T6O9e4a10pgDqIm9saCkmqHPWPz802/aQch1F
         DZA4kB1tSUUwsqn5dVyALkg+Ut2ZJ6mvskpOHAmxFkmV/t5hlDJEXYzY5AaUD8qwTVKT
         PzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nG+4wChODW9kuqTztU7mIoSbSX1bfLh8m+Yw3JRdgLs=;
        b=Y23zVIFrb+XrL/2m67AiZImRfBgQpnTGvnbY88wUKHUEkTYh45JrL0jwIbEuSrcKAB
         HPDZBvxku+/SqBXaBSYJl0zudbXb2xQRb7bZvbKVAkii4Or+RO7Bu1iiMs9tNnQTeviu
         CcL+hpd9TeLE625fPwLcLxnuja2p0rGujRhdNv7SEDZobTTEXhNntWgXiKAfRtSlrob7
         Az9qw0H7Nb4TMIHCO/+1zKZ3IzMlIe2jwZEehsoiW49ULf/w+njxn2CtOaQkt/n3a0nO
         1UpPLPba7Ka/gQXXBcdLbYJye3EjWj9/jw5Fs4dhgiuC6l0422Rzgz9mw6UdoedRSJys
         DF/w==
X-Gm-Message-State: APjAAAXICnEuxcOwnToIHxvgkuX30eoC27HZcd4EUXmNEp7wiR6DB5Nr
        hdzqHEiCvGK/UtDyp000f2Kn7VkJ
X-Google-Smtp-Source: APXvYqztqoQ5FgHBP5jgzAn7g6HZdjmU95R3B2T1FFmchFm9TIw0qI0dmuBAigFz4qy7XC4gdzqZxw==
X-Received: by 2002:a63:360c:: with SMTP id d12mr3758203pga.404.1553316164344;
        Fri, 22 Mar 2019 21:42:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f65sm14213741pff.21.2019.03.22.21.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 21:42:43 -0700 (PDT)
Subject: Re: [PATCH 3.18 000/134] 3.18.137-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190322111210.465931067@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ea447963-e5e7-e152-9bd4-458aa26790ce@roeck-us.net>
Date:   Fri, 22 Mar 2019 21:42:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 4:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.137 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 24 11:10:54 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 226 pass: 226 fail: 0

Guenter
