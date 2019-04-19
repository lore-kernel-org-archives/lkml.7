Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC120C282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D2E2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5bnsfY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfDSUrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:47:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46245 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfDSUrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:47:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id v2so692308pge.13;
        Fri, 19 Apr 2019 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pZdACxNZaYwFl4DEZDaG4W0tF6PGBtSmsOdKmjH8ohk=;
        b=T5bnsfY0ZkFlNtEisV3pOyXy5aQo38DVPF2i1/ACPG8CI2Dcmlp/z8vCY/NwmnX1v8
         95d7BGdLfEEAymY2pAH89dZSgTYDs8GkAxW/+Aa7RfODNnU6iju3HSs7RBRPnUzKXeWF
         i/jPGJ3/BilsvzSlomOWoXMCo7udY4y0Z6peobzLNtIYg/uASm9f00d6ELQW1osEqUQy
         BoanC4ejw4tW4HVSYWeQR/QYnqJmnpH/eDkZKj9dw54L9rxQrfxjD0n5RhbOKd+VsED4
         4NIHPbtxWofIwUeX4HrfkSSABfWYa7A8Q0H9OVa+iMfHNHCpsG27JsXFCwzcS2TdTyDh
         2RcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pZdACxNZaYwFl4DEZDaG4W0tF6PGBtSmsOdKmjH8ohk=;
        b=jRcgp25vXh8Gw6BBm1/z6WgNDyAA7crqNMNQ042XUu9F2WXdxMEMljwzBkZLR5vstS
         RUYJGnXst8lPzsGRJxsfi1Yy9qtEnTYSkFR9htMT0JKRhkOOTrkm54EBm3DhYfvQigOF
         wQjJIXADTN1XTF1M6DTs+vu9mKhoIEpdMnFdKtejn0hYgC4H5ZyVRgNrrIImP0Iizzky
         DMZtq7wMHghLhDryITkf6iJw27iaxJRT4afBbZrIc0U+h1WI9/WoxBuU4MpP8FrQHqrc
         2iTYc8g9VhNp/AVZaHOHFvQ3tcGIkZrox5i0jjBAUyw5qNv+MMVGdGn2cV5F2d4n6XsB
         8X/A==
X-Gm-Message-State: APjAAAWqyEpZFRhAHzUoxK667uvHa1XFE5eaYUd6isuKw0t8juMVUyIW
        5PwC7JjHiVBwJtAgyjpBL/M9Cytr
X-Google-Smtp-Source: APXvYqyw62IBad1l7Y852RfjXZBJ6/8VA7eqDpD2P1G7Nk6Ee2V2yg4q/SrdVwIE8e+FXkUG/HXCow==
X-Received: by 2002:a62:cfc4:: with SMTP id b187mr6058609pfg.130.1555706844369;
        Fri, 19 Apr 2019 13:47:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e126sm14024982pfh.35.2019.04.19.13.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 13:47:23 -0700 (PDT)
Date:   Fri, 19 Apr 2019 13:47:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/110] 4.19.36-stable review
Message-ID: <20190419204722.GA24525@roeck-us.net>
References: <20190418160437.484158340@linuxfoundation.org>
 <20190419194041.GC10320@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419194041.GC10320@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 12:40:41PM -0700, Guenter Roeck wrote:
> On Thu, Apr 18, 2019 at 07:55:49PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.36 release.
> > There are 110 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Apr 20 16:03:29 UTC 2019.
> > Anything received after that time might be too late.
> > 
> Build results:
> 	total: 156 pass: 154 fail: 2
> Failed builds: 
> 	i386:tools/perf 
> 	x86_64:tools/perf 
> Qemu test results:
> 	total: 349 pass: 349 fail: 0
> 

Update: The build failure has been fixed with v4.19.35-111-ge409a9a79179.

Guenter
