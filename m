Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E023EC606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B643E20644
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="hTUyICoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbfGHTaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:30:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40721 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGHTaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id b17so8123361lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MPzcEDCZuXPGubjh6Sd8DCFOXlYzZGPKEL93jdAnvFQ=;
        b=hTUyICoZlzohR5KUnkPZd9HNVqrSZLHvHnuHK5hAr4jqjTN/yBLsOlaKsLnXiaDbWm
         nAjK9CaL47BF/QHm2LthJhnhu5hp5fXH+mLLyAopaB7Neol5MKw1HhcYpRSyZYSC+1ok
         k3Pe6vOIfk5iWhCRGPS9x5k34uSCrr1w2woNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MPzcEDCZuXPGubjh6Sd8DCFOXlYzZGPKEL93jdAnvFQ=;
        b=hoD56NOwDfZIwCGIZVCdifLZfnMd180EkIMzHNg2FhPTm2FSnxhYXmGM1XZSXZ0kB2
         3BFTrJ7+9LDnEf4sPFPW/WnBybDgBG9HWp3wxVNAWoVRnYX1TgJFMmXS9lI3tBDNp4C7
         lZmznVgT7oD2E40U0x3gZGoTWs3PGwgTL2pldz2lVpn/4vYCnNvGhirIsOwlaqCRjnk1
         07PTcGVJTMQbTI+nPq+r8XZxTB/wTMpDZ5uCbzx6YUvah/fQUCUquUWNggVuyZSt41Jv
         jI2lw7Fl98natnBgo1XbxmZQ72vi7j7Mgnx6fP6YwJbpBacp6KYH84CwMRBNg+6m54aC
         bzaw==
X-Gm-Message-State: APjAAAXmq4w9xrRrdLyNs35FMkHEU3CppNKNBs/FkPXPZSAurGlLQtlq
        kYvE+E37k7pttbsYaL9Lx9qNdQ==
X-Google-Smtp-Source: APXvYqw3oox6wJoy0L2nP7j3fKkgl7VOj9pwJZlbYw68swnfF/Hrw82WFeIy4bb1OCfK3m2qQuJ5Zw==
X-Received: by 2002:ac2:51ab:: with SMTP id f11mr7543144lfk.55.1562614199914;
        Mon, 08 Jul 2019 12:29:59 -0700 (PDT)
Received: from luke-XPS-13 (77-255-206-190.adsl.inetia.pl. [77.255.206.190])
        by smtp.gmail.com with ESMTPSA id x67sm3821622ljb.13.2019.07.08.12.29.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 12:29:59 -0700 (PDT)
Date:   Mon, 8 Jul 2019 12:29:56 -0700
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.1 00/96] 5.1.17-stable review
Message-ID: <20190708192956.GB4652@luke-XPS-13>
References: <20190708150526.234572443@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 05:12:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.17 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 10 Jul 2019 03:03:52 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
Hi Greg, 

Compiled and Booted on my x86_64 system. 

Thanks, 
- Luke 
