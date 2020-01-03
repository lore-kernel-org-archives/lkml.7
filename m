Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82A2C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 14:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB95321734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 14:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tccf+PP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgACOxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 09:53:02 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55717 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgACOxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 09:53:02 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so4683483pjz.5;
        Fri, 03 Jan 2020 06:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gugeNdxqIhZ7M5KUmIYAv4IFMw43bubwD52ekT8U3z8=;
        b=Tccf+PP7KjBDo71yFX+SPTJWrhk2tPUKgx+jb7KD1/paVSykSElNxZLc/7EyCbX9cf
         TDed58OmQQnxrJVDtd7MCDtskIL18ZzZcSEhszoDYzEeD34N4BT3n2fy/6L1Cz9NS2RE
         3SHH/HZ/6oKH42ZmTm/PVFmFKT/RavQDKJlqM3WCgckbUpo8ie9Y1kXVwTbQyGzBvW29
         TIvwXVFdbNnqqBEZwltKT7FErSfXzfUqAdGxq7yvLW4oqTVT2qHAXmuNqwhF+h0LazNj
         DGQeoub7AAdlM6rO3C6DgdyaXfVbglt8rfgqQDNUVCyUJS2x+mGrUz5y+XaTjpFvtWEd
         ZaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gugeNdxqIhZ7M5KUmIYAv4IFMw43bubwD52ekT8U3z8=;
        b=Xuz8pPq7xAqYBHM9WfH9zdM4nRQ9QAurOeJW52aZlnsC03B235qtfj82LelxD1cREO
         FGehqwqIkmKblBkvELo448yKwREWdspiX8MwyXdVpYbW7xCdn9W92VjsGo9TEZXFUHMI
         qOZJUMI1QcqX+aU1+A/VsjuorNDEq52GN/AHTW8SyMgaFxjkCox/X80bNoOhOapD5SOy
         rq7oH4m2R3Jgc41V2xLgUFvPQsJExKa7g1v/4mqFJhkidLrk7RR2CccxlTMFkB25i4yN
         YkziisXHa3H5AW5GokSNd6btla32srzHa5WcM9yFE7tgqkrtaFEXqDFGECfqOARpDo9C
         lotQ==
X-Gm-Message-State: APjAAAU4L4I/99UybbTvQaF4VBBMFzzCka4NAEPBStCHYtfBd1G7hx7b
        JP31vHx2ko9C8hGc0Dg3T5dl660T
X-Google-Smtp-Source: APXvYqxmNCy6HVbbe7l35UM8rfpQhvY4j/tNcKBdh/xdU0F+auxNuaZLgjVEOAmRdDT7zV6P/51utg==
X-Received: by 2002:a17:902:a403:: with SMTP id p3mr75982098plq.126.1578063181376;
        Fri, 03 Jan 2020 06:53:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e19sm15255531pjr.10.2020.01.03.06.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 06:53:00 -0800 (PST)
Subject: Re: [PATCH 4.9 000/171] 4.9.208-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20200102220546.960200039@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5f892e75-81a9-be3d-93bc-9d67c6452c50@roeck-us.net>
Date:   Fri, 3 Jan 2020 06:52:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/20 2:05 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.208 release.
> There are 171 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jan 2020 22:02:15 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 357 pass: 357 fail: 0

Guenter
