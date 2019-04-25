Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1DCC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E1A205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXLRL6ho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfDYTjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:39:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35550 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfDYTji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:39:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so426575pfh.2;
        Thu, 25 Apr 2019 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n4fJOq3bB7pJcJd1Me7UtQB4vJ6X6DI9R42oTpfmKzs=;
        b=cXLRL6hoS/4730dJHtZa3vBt/DMh0lbS/5C2xB3QmtaP9jFz2B8kvEgu5vUGfK0o5i
         rMrtbLlJIv7lS+/x2vfpdh1ywlU3vQ0+dhqIAi3/CJe0jMIrTdhXOnCLcGbZh158qoVS
         ZdDW9Or7/JXfZaMw4efpuOMI8Drivl4ObQxjk31bi/a+GD6SeNdf11U0R4BzDXGiGuwK
         cTJUs5INXzP5HWK1c0BB9tm0Az/xr3fc6aDMxeeQJ76A7Yseq7tdkq7GoojeVxNS/1wW
         xb9B22hZSi9S3Kl9Igz0RqSdbqtGRE1mnnYhVqP8NtrYI8Eywtm1grItAFBt8pQEVFB+
         5rSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=n4fJOq3bB7pJcJd1Me7UtQB4vJ6X6DI9R42oTpfmKzs=;
        b=i/vy5mwMClOYQzajuz1Y6X2Q5mXnSgFO8lus4X4EJcTRatfNeRWWNO14s37slaIj2r
         0P/383EpZLgZXDWH6Z0qps1llLfqSE1lvXWZefwuyM2wQRAMq14NlgcZ8GyFGzDG4Th4
         YSP4+OHf9bILSHZy1oR9q5YlMv3fiUmukOrA91zN4IOyaAtaRPqsjFG1jdMiyWWm7xqH
         rHyhkmVEz3NvyVZZC88M+DEfdvmcDItB9dNKhnOcYC5VGbhd9eh7GeH9x+Q8ven1Nufj
         BgQ5BGZFcsuyOQDVzFEW3SGFitQcNCAyO09laqGoNZp1lQk+VCO2IFDOvuEu0LE4CDv3
         40Fw==
X-Gm-Message-State: APjAAAUegKIg+72k7/sfgkK/1oqcYjyk+AX7Ihcbhw8NNjJlg1g4vuuX
        YYknopVf8oaNwiak/hT9EFzQyJsw
X-Google-Smtp-Source: APXvYqwuoH5MMjRi+4LU9x3Tm+k6yDrfJCFp6fdRa4gQcpBUQ078ihMQWJqfjkJloNXtgq4rN24tyA==
X-Received: by 2002:a62:204b:: with SMTP id g72mr40912982pfg.51.1556221178095;
        Thu, 25 Apr 2019 12:39:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b1sm26161617pgq.15.2019.04.25.12.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:39:37 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:39:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/115] 5.0.10-stable review
Message-ID: <20190425193936.GF13462@roeck-us.net>
References: <20190424170924.797924502@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 07:08:56PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.10 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 26 Apr 2019 05:07:37 PM UTC.
> Anything received after that time might be too late.
> 

For v5.0.9-117-ge428bc9cd366:

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 349 pass: 349 fail: 0

Guenter
