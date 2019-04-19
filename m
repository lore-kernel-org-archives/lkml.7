Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ED5C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F205F2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UueVHyVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfDSVA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:00:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43017 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfDSVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:00:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so3065275plp.10;
        Fri, 19 Apr 2019 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ObhkPP5ZenpoLyqUAzWd44yrT4qPqlwLemCvG2ZzlSU=;
        b=UueVHyVPziB8VYDAJVFUSQY8VGfi+DPwwZC2qyol73ReX1VYKlxv8RE7ieY3fKebc1
         LB5gcGgmr5s+zBf7AfJa92rhPWFtWW2byzv91iwO7rQm1OeEdVOl0oEpwHk31v+jT7OM
         T/FARuKygJJjjLhWPbD53v5oPm95tuoa81OLArVLowb4kF0NlEHNpd6qWa6n1n6o2xy5
         GMRXpR+7unrtYjoAfY2VeEqLUYUNFCs/IbUV5ri847VpC4bJ2egpCvlYjQPt7q7t6bds
         fNKkkNbrBuJUJBOJMixWENuSVISjLYKRDVTTSrolb82kxfRIr5TK/7aBu7dR/Vgpwny8
         VyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ObhkPP5ZenpoLyqUAzWd44yrT4qPqlwLemCvG2ZzlSU=;
        b=jGN+XVcmEYLIstvGrZCwI1fvViw//YOBc0fEwf92okQoahucZ+6nFD6GhdaSIpM/6T
         /8LyqrHccMqzFyw331IiFbxgw4IKP5jgrZRA6XBw8xd2LnZUvvvtj+Zqjo6sPDEb57S8
         Oybca2DHedew7qOlXC+WdcPUz1zfvQZkbnEIaBW2pqZ5VK/fEaDooacTvhyh8zQiKqId
         Kx035TU1qS1+vaJFwEZvcho+xkQ0oV+xVzyKBYghD24CsDSEzWVlHAmzTdTF/48noo0P
         itzzmex3cr12prBw3CFrxEeqBOjarkgR7RBY+Bf2cHvjDsxFGN/TJ7cjAu487zCy+bsK
         GIFA==
X-Gm-Message-State: APjAAAX5jSHGFXJUitKXzoJwalvhvtt6sYm/lbkY1E6w4It3XDQ+Iw+h
        MH/s49gxSQjSuDFX/T0r4/A=
X-Google-Smtp-Source: APXvYqzocwr4eIG2Z/fbWuNq9ReIfYN00ZdBExS7fri70Wy5kW9M4vwzVcy1gQefMDX63y3B/AYpzw==
X-Received: by 2002:a17:902:9a89:: with SMTP id w9mr5943253plp.126.1555707625775;
        Fri, 19 Apr 2019 14:00:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i1sm14727263pgc.63.2019.04.19.14.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 14:00:24 -0700 (PDT)
Date:   Fri, 19 Apr 2019 14:00:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/93] 5.0.9-stable review
Message-ID: <20190419210023.GB24525@roeck-us.net>
References: <20190418160436.781762249@linuxfoundation.org>
 <20190419194102.GD10320@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419194102.GD10320@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 12:41:02PM -0700, Guenter Roeck wrote:
> On Thu, Apr 18, 2019 at 07:56:38PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.9 release.
> > There are 93 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Apr 20 16:03:33 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 157 fail: 2
> Failed builds: 
> 	i386:tools/perf 
> 	x86_64:tools/perf 
> Qemu test results:
> 	total: 349 pass: 349 fail: 0
> 

Update: The build failure has been fixed with v5.0.8-94-ga6b9c7d1cb06.

Guenter
