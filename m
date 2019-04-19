Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21722C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69B320663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBOLM+il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfDSTs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:48:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46238 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfDSTs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:48:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so2940363pfj.13;
        Fri, 19 Apr 2019 12:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lpkcT/3cE2I0/ol0HQ9o/OLoFNZFToJRobNwO3yOpLQ=;
        b=KBOLM+il38KdGXODrHXidLcFmi+ph7A9384dUj4GhMmhDRwGiQvCRGJd/Nk05b1z9L
         B6W5NkStdoHw5+UV6nMB7Z0btAPOfP1rET4VVvToK1wEkzhhlgOsZWdi7AMexeopnAtE
         UbkdIG4ZjaGg+AiNRWtBxekU7H/iGGZ86ydoighL+DCxD63t1q53sNZIsQu+kk3T/JhX
         37664+p6F501v8z/PfmWWYUOLyyr7XmA5IwqWzJ1WlCcaS0eMJpZxlAwW54KBF1Xa12e
         74u6qFuiq7kYJQ6RnBmrmmv90ER1piQHhtcZoKP0/+lX+nSE3Y7g2uPqpSxiYw7fu9LG
         JvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lpkcT/3cE2I0/ol0HQ9o/OLoFNZFToJRobNwO3yOpLQ=;
        b=ILMiXjYzg0kMGmUaa6WniB4wLaaLWlSfgjhi64W3w83u0ID8sDjcyBtNXkx/0oNVdg
         YUyU+XRk2W1EDwdIohQKzSL9wYLeyZDY7+gMoPqIhj8U4uDmR63YNVQtLiLgi64tH6tt
         vKiqzqLGGNXUbyp5XseCrSf7QAwcn8zYFa4gMvyKoJe2C/CDC7FXPPGd614juqjaww1I
         o/YhM3D7iVlIcOjuaTG65zryePsMchQ8prfWJsijrpPDXEQVKTtWp0hzjdUe6NeBcTs1
         lLubOPPh3IXKxeGnfLzG6hPnlwQCrM2uI7P0GFcX39g6rEZFlYpdYkDI4qN8bMdyKdH2
         qwSA==
X-Gm-Message-State: APjAAAUqtSbPJguC/ZE1l9pzidQ6tAKHDwDd+myxCDtz/1c+/f2iRjGk
        LfEAghtakZ4jguE6QCPCRMh0u5+A
X-Google-Smtp-Source: APXvYqzmlKk8jKG4CXsKoPVGvHWm4tXy6VvMmJfjZjl3SUHrh7YbDMEuYt90EcVJCO83oC9Vi9SPbA==
X-Received: by 2002:a65:5cc8:: with SMTP id b8mr3184229pgt.36.1555671442964;
        Fri, 19 Apr 2019 03:57:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c3sm5991738pfo.2.2019.04.19.03.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 03:57:22 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/50] 4.9.170-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190418160422.455656724@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <98a55711-2cdb-47ae-7130-ce5b944643a3@roeck-us.net>
Date:   Fri, 19 Apr 2019 03:57:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 10:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.170 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr 20 16:03:22 UTC 2019.
> Anything received after that time might be too late.
> 


Building i386:tools/perf ... failed
--------------
Error log:

bench/numa.c:726:0: error: "BIT" redefined [-Werror]

Guenter
