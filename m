Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A532CC04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818AD20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XexsToTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfEGSjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:39:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39463 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfEGSjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:39:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so7426757pgi.6;
        Tue, 07 May 2019 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BP35SswCbqECcvWrM/PHEqjhBRhUqq1LQom7X/iBeAA=;
        b=XexsToTG899SSRfBRwHpqivMpwnSefjVP9WJCuYHxNq6QgYihHmpVX+yu/jfTot0+w
         3GpesXb6kk8QG05Esoe2AQpga4KI7H2xSxUawWv4+l5MZk7SLI+cUKjMWy83o2M4P1GJ
         Ku2pRm0KQFDHmyQ6DoPHkKTSd+NbpBSkITZISVeBwP/vqnFMp0KC8D6FkIpCqWvcsa6q
         OgmG8e8i/SHeTLpjqEhlVr2rdgHcH0gcEN1Avx5xwuytvs+a3xHJONCwBaXGqsdM592s
         SZNYk4Y0ActbZebWhxKODZT6Eyiej0U5+vIYlJJIRdJp729EF1hvdATP6PA5Z3TwEIK6
         STQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BP35SswCbqECcvWrM/PHEqjhBRhUqq1LQom7X/iBeAA=;
        b=OCvY5YTxGcjysqidXySbev/cxKOMaapLCBCSYxV3no2u4qj86lP+RMVL1DwW00Pczc
         vRoq3ijACQmU+ZhuU8yTV4/24Opg3n19RHxjoOE0tqXBkRTiWD+5/U76nhDqOGyM8+c/
         8FGbQlzizvvIXO4UdrY+ieDbJF6iFsBzWd/PTjV9azRss7OC9hAlNyd+nnGB2sHhToRz
         QOfkVYwAk5oIaKtqf86jbKUN3EiODP34qEAbLKihui74SN3w/koV/qKL6+osOHvJJD3r
         AI+9kSiehFvojhBb30gofuI0Ux4r/uYVgxPBG54Cte0ProsOHqsiVyFtcNmBMy2xWaiR
         2kEA==
X-Gm-Message-State: APjAAAVzgP/YS5Kd0TENs8CrckVAZob5ChdaGJviXqJ8SGLyylH5pubM
        AFqKjE92bIwb12DnA+qUH3s=
X-Google-Smtp-Source: APXvYqysSafBEHQKYHSkWLryo6blT2+d1/1AMIG5Z3dZhRwvuHzlRgQYj6wb4DhVbrfExxcegefnqQ==
X-Received: by 2002:a62:e101:: with SMTP id q1mr43047008pfh.160.1557254361505;
        Tue, 07 May 2019 11:39:21 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y68sm19728288pfy.28.2019.05.07.11.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 11:39:20 -0700 (PDT)
Date:   Tue, 7 May 2019 11:39:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/99] 4.19.41-stable review
Message-ID: <20190507183920.GC30225@roeck-us.net>
References: <20190506143053.899356316@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:31:33PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.41 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 08 May 2019 02:29:12 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 349 pass: 349 fail: 0

Guenter
