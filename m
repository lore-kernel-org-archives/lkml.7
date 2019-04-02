Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44462C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B4E2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlmnKgSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfDBTDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:03:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42951 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfDBTDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:03:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so6819988pfn.9;
        Tue, 02 Apr 2019 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZIN2Y8rLqflzwQDFYfLgLohx8RHN4GTkqaFf1mMK9Pc=;
        b=rlmnKgSSTXrAAoLhEZUy59l9lVD/GamnjaIMMsCvJaEyx5Lzk93M4VRrY4zWe78Zhu
         PAN9nUts5y7ajlpylv5nvGFQToWlwvQ9Whru3gPDoBaMr4wd6HJ8e0XsWWd57Oy75VGd
         umx4s0fTHsx6UWmjSpwOM7iUhpLi86VeG6cnV8uVySNx37AG+N+m0uGmLYC11G3dU1tJ
         sLoYRiuphybnNwcVTYrH4mkaSR5zXL77UW5Ef3ujaLQk389Yqs5fXcRSCuqLcJhlLFrZ
         2yIaAiCoOCP3Sgmgp+FAvVHP/8DoyukNarTboFMk1GPJ8exT0l8261IPwS/ysdwSq7Wv
         rudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZIN2Y8rLqflzwQDFYfLgLohx8RHN4GTkqaFf1mMK9Pc=;
        b=aNvs2dmMYp2dobTBLdri6Pp3S26NiEsXr3qL9m/s2luGJGIGwKtVvifMgocKeAstFf
         PYIldKdmacPFQi2tyDVqhmLeA6SIjNMXsmnzyT8ov2LPMmjlRtA2QV2+e1AIPcU/Sv7o
         AdsIlfV6BgWXOy3mYD5FtpITqjyxpYqEWUXodGQ6ehKM6KWdNetBDWmXAr2Z8bbLtrEj
         Uqj3ypNl169PaytrWgdpD16rSrei9ZOfybU+TIDR4CUC2HzYbQVaNQ4akRBrtWnVUrp2
         utC3eIYrFgF+sei80xue2z2NGGB4oSCjIwgnwKDBFN31v/TlnEVA096V6q7ND958U73o
         sxWw==
X-Gm-Message-State: APjAAAWA5i57lE95Z9eUSmllimMAlHEeqB00VYAcY7LjxTioYmPxlsFi
        XO3u6sj8mxI3u0grp8v200Y=
X-Google-Smtp-Source: APXvYqwpiXJtnucBqq4o5C728lR8kBDuGAc2s9SQ8xSEI5/UVGN6HdMOzwW2YjoXZEeAGAvk1fskoA==
X-Received: by 2002:a62:1249:: with SMTP id a70mr70619381pfj.160.1554231834427;
        Tue, 02 Apr 2019 12:03:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o67sm17662383pga.55.2019.04.02.12.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:03:53 -0700 (PDT)
Date:   Tue, 2 Apr 2019 12:03:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/50] 3.18.138-stable review
Message-ID: <20190402190352.GA14232@roeck-us.net>
References: <20190401170041.257273804@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 07:02:43PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.138 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr  3 16:59:36 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 226 pass: 226 fail: 0

Guenter
