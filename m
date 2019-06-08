Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B37C468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 18:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9F621537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 18:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2dK8K8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfFHSp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 14:45:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34502 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfFHSp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 14:45:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so2998081pfc.1;
        Sat, 08 Jun 2019 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7PjkCPjoL2hWYTELSvYcvdztcod3RrOPu7wFgE1q5Q0=;
        b=P2dK8K8JdJM0J5qgdHa1InsMpwb0V+VnJinOE/1fo/Tpwybvt1lDT0QPd9uUfr0eYp
         a4589QVLm1iHxMzzL+O2CCSAyewZ98gl6DnkhtVzym8k8j0UraQRNcFZzZJI05T/b6bV
         SZGjRwO4I5taLS8TuhEmLHGDs8pXi79ZtSkpvy+o7YExWL4ekC4lMXZ38dXbHObPkK5A
         gPaslKHe4tYbcQ0QXffxlxUWqWfDFcW2QX+XC8vaQSdmH5ue225ffSk6ICHYKlkMCSxT
         tNqzfCUoTn8p6M/SwODyJW1YqAJirRsMz+a3pfQzYwN5cELVAxO5t59tcGO6qUPqVEDR
         PMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7PjkCPjoL2hWYTELSvYcvdztcod3RrOPu7wFgE1q5Q0=;
        b=CW0ajyVlKCjomA0z++dR4BwXNwdF/00R0vuUNTxn0119KjvPAoyzMkZ2Dj1nbcaqg4
         lj0GFnO6kLKEvMOEZtB+z/fIwe/H8LKWM8iwBqGIvCd8AF9oZIPi2KPH8DWH3QJD83C4
         eblsb3yO/cwAYbMo22KjTBJ1SCDJS+iLQzCdb8mndwob5PfuDL3+YXaKydNKYOKNXTyK
         2SdMKHpX6SHBKMxdwETSdhBReCvpnIeqq5X6XEp0A5M0v6K1l/tTMgL79JHb1avZa6II
         nH1lBZVd+zwqm+9Re3YT4fCECJakdQDi6MxbcSlprqrFfgGJEchqKvxi2selQMxcQiZB
         d53w==
X-Gm-Message-State: APjAAAX4naAMsHgMLfnB0vCWi3sT7pxTmCs2XZtGY/vkUO0f0cAXb4T2
        yjEK3oe1kaTVhhf00vTkp4+HTAAM
X-Google-Smtp-Source: APXvYqxfJtcwZ8Z/JQK44Pusl+4rZFe9UyZjrB/VTTzj0MBfqZaQidkw5+ePEvJ4uPGLF7PXzYzBZw==
X-Received: by 2002:a63:445b:: with SMTP id t27mr8460790pgk.56.1560019525408;
        Sat, 08 Jun 2019 11:45:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m8sm12228653pff.137.2019.06.08.11.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 11:45:24 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/69] 4.14.124-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190607153848.271562617@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <55ac92e4-7395-9437-76f8-00f03837aabd@roeck-us.net>
Date:   Sat, 8 Jun 2019 11:45:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607153848.271562617@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/19 8:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.124 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun 09 Jun 2019 03:37:08 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 333 pass: 333 fail: 0

Guenter
