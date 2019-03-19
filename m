Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535AEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CEF20700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2ySonx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfCSCYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:24:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46592 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCSCYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:24:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id s23so12581151pfe.13;
        Mon, 18 Mar 2019 19:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IasbJbDldjnyQsNLMx1pXj5kuEe1IYJC9iNv/m837Yo=;
        b=U2ySonx48xyPKxjVW1Q22Ed1SquMbqAg1TzImgnNGuWCAgehI8OVyrA7O1XLBedEAW
         TjVtJ9SMlsgy5Th4dLKbaqMBWEa9ysAKoHT4dh/8o3jPK/GqKqSbDtC6jHcob7tGjaZh
         dsitvu9X0YrwKBbjsG2TCLzv2a69R0HdPp5UluJrbk26reLRKO6tedMZdIiXdLrRMjK0
         BlUmByWLxzOBCJBoyiNRw1bclVLb7u8rFtXyhKp29/P2bm6OjndvGneluvX913uMDv0A
         dNrYBgu97Yg/A889+39foWyBKehTJIY3dPZmjU31S6K8xHZUqZYy3Co8E+oAvzJ9DP9g
         6ioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IasbJbDldjnyQsNLMx1pXj5kuEe1IYJC9iNv/m837Yo=;
        b=rzHAZrR8dUq1vBlXMEf1bO9ZWpFB7jUf+c4xigCMMC8iTi8B3G4tNDNvp6Kj83V3Mh
         887kTAiF8/IdQ7jtFWYaTIfHlZsnIeZvjXhHdygm4v1u44gV8Tcqu3zvqyWCa3/gMRe6
         1plETCOoG+wnWHVV22Xxst0fkaByC9FVdpqDBli/5UVoFnh+cB8b3Au2wC0UdW3OpWZZ
         v1gE1cLK9dk9ROrGiXPG7IP1iU+tPVTdfMsZyIXXd4o0fl/BU92Ij0YOhWkY2wZP5AXA
         6iW6vd/t7v5RHiPlbrn+jM9wIWwIFbpeIlK9P7mUMbniR7nd+I28p84Hw1lWEbhnwoyP
         GYkw==
X-Gm-Message-State: APjAAAU7LAJVKOXst1KBGQ4VqrU9tJyFAeJjPN74ovKvUMlw5eSG+xWD
        RW8aUGzfesD61uZXwxVUpdD0WvlI
X-Google-Smtp-Source: APXvYqz8y5PgwHeaK8P5LQQ47hfR9VjpuN1O9uSHXbvYfxnrMasNOBtXqvDA8ZeYIyjh/j5XhSAhXg==
X-Received: by 2002:aa7:8186:: with SMTP id g6mr11540pfi.138.1552962273984;
        Mon, 18 Mar 2019 19:24:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i13sm13962338pgq.17.2019.03.18.19.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:24:32 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/31] 4.9.164-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190318084210.397476003@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a1b42807-3b70-6141-890b-2056786b3b06@roeck-us.net>
Date:   Mon, 18 Mar 2019 19:24:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318084210.397476003@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 2:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.164 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 20 08:42:01 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 316 pass: 316 fail: 0

Guenter
