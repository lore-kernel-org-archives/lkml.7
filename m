Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE42CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7CF21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnxpQGzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbfDESa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:30:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40810 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfDESax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:30:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so3452574plr.7;
        Fri, 05 Apr 2019 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=to5y1BPAS4nvyCyZdiEO7z70bhibcR2WL5gAQpKd9Yg=;
        b=DnxpQGzAocJ8n5JjxPRdgdjBLyNqUnJNVONMuElrJfoZZRQAy7I6NNV/aiQtlPhnb9
         ZNlACvMTz5OI6KmVKUTns0S/XyC/KEdDXj2X5hcUbUNktgIaed9arPRNvtR+B+GwcF1s
         s3YP7djUmYI0/junWRxq+JEAG28NI0ltJAwIcRTbR0pgrfXxjEiSz5+Y8ohDDR31b8iW
         E0kYpyzKPwvlhiW5xpxz6mNKIfQmbHZRX+iSqOpYjii75CpVc5t4tyTH75shCv+BxyaC
         81XTmvT+jxq/gXmow+4/3xbGjGd3Q6FvBVn8DUF753s1WIu9WZUn5jHNKXu/61XZDCqR
         KyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=to5y1BPAS4nvyCyZdiEO7z70bhibcR2WL5gAQpKd9Yg=;
        b=T92x8QqxXyvHCReu7OnBmNCNHHyFFFZLRGA3OhxuwJ5UeA6XpcIEVNkDcksdBvO4kd
         3uMGNs3tH4MpKEoStESjYUVGUiv8jcFwnvm/2mz0T8I/EtyWDWkdCorWRJVee+rkq/P0
         ko0bpSxGEBXGmNnQEltGdY5GcyU3F6FaZRgb/DgY7/QI+jPToVQpB/qTCFfMkMfWidm4
         iOU2ZCn1w3RbthaHbb+KdqDpDEmz4Wnib0wXvCXDmqOg9V/01mjKU4IScrPHLUtpuPuL
         8bKwdxfovojq94UGM9IVfAESsot8pczYFNwwJi62xlmQuedCGXpIaPHldblBASJO+L73
         4KFA==
X-Gm-Message-State: APjAAAXxbdM4yN7WGJD9m6t/bu5EIPtQfGC22QHWcrKJ+hD8YpjoFSNt
        OXMOj7MHRsjvv08bLutFu9E=
X-Google-Smtp-Source: APXvYqy1WpOWTglg3+veM370yWE9boZVBLnI9WqGQM38+QSMyvw175kECb9x1M7mFXLWPlJDiZ9Zvg==
X-Received: by 2002:a17:902:e684:: with SMTP id cn4mr14112026plb.71.1554489053322;
        Fri, 05 Apr 2019 11:30:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n5sm27512082pgp.80.2019.04.05.11.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 11:30:52 -0700 (PDT)
Date:   Fri, 5 Apr 2019 11:30:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/121] 4.14.111-stable review
Message-ID: <20190405183051.GC11563@roeck-us.net>
References: <20190404084545.245659903@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:46:28AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.111 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr  6 08:44:23 UTC 2019.
> Anything received after that time might be too late.
> 

For v4.14.110-121-g4c8aee9:

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 329 pass: 329 fail: 0

Guenter
