Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE168C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8F420821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP2SD5zz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfDPQaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:30:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46669 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPQaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:30:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so10636271pfj.13;
        Tue, 16 Apr 2019 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CfC+4JMDOyIByCS6MmhOHKCnP5MNaOKUcpzqUeZreOM=;
        b=TP2SD5zzlOPw4esGXRPO0MXh2dhSsdExWL8a+llhBH2ewvqGBno+/53TGdxaXyTHBh
         H1/SP/UoBYEC+c4wtHSus7npuf2Kb1MgyfyGc83KK/p6vvXo1hWYtb/FZBwUMqwpTjSB
         xlAyemQbcN3R57z4h8kJhqkCQck2RbbmMs6xge3G8VAmpYkXHKsRlyZDOSZvrA+f3JrR
         cqTxpNWEL7BNeTmKgsLWmpRljp2UQ1852F5ZjZambRVUUGBxRzchPb7QbzLJFYqRe6nm
         YYe9Z0gUeRaAqIvlhMGF5OS+itocJZG0dKV7zfuVgogvqyIJUNCzbEkxtQbZBYLp2BOJ
         7dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CfC+4JMDOyIByCS6MmhOHKCnP5MNaOKUcpzqUeZreOM=;
        b=s6wiAse2s95Fd5+sBCqEypGKU+RPp79QEKfr7WlvmVrtu4SJ/NivaY8PNRMA0yloNV
         kLkMaS3AaEzpU0vjofIpcn+pVJsNNEonnZvVLIdfW6yLEAR/VyfAaeSm5PNwVCKbt+ht
         J9E/yHMOzHgSW+QpaKIRE6AfcH/zlSgzSvU7+KyrntXmqjFqwSMG1nMAajAZffURVBjE
         a156CNxjRfcZpsyjd92YSTM3IY3TZnaShbEZhyqMgmRndVJpyCt4acH1XeIewYwic+ZY
         /JGqOoNUdtpPPsS1RLZZdRNkkPdGGj+I9WYdqT4Y9Uz4P9RXrIh9awQ/SX17SwkCUt97
         A83g==
X-Gm-Message-State: APjAAAXUyfJdTeL3j5/dGkxOw07/x7GpjhW6RU3Hsk/tCt7SfWstAfhY
        2YT1uUU/ueJxuEWQZTD2drXEh2gI
X-Google-Smtp-Source: APXvYqywyBsLs3DHUc+vB8zKKuUuIkbeb2bqHTnBX5dXQXjjRZ6DUzarVhlyMFPF6n1O32KFqtiUkQ==
X-Received: by 2002:a63:3c19:: with SMTP id j25mr78405128pga.365.1555432216322;
        Tue, 16 Apr 2019 09:30:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j20sm42191467pfn.84.2019.04.16.09.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:30:15 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:30:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/69] 4.14.112-stable review
Message-ID: <20190416163014.GB22656@roeck-us.net>
References: <20190415183726.036654568@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:58:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.112 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr 17 18:36:38 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 333 pass: 333 fail: 0

Guenter
